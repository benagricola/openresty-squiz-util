module('util.memcache', package.seeall)
local memcached = require "resty.memcached"

_VERSION = '0.02'

function connect(host,port,timeout)
    if not host or not port then
        ngx.log(ngx.ERR,"Must supply a hostname and a port for memcache")
        return nil
    end

    memcache, err = memcached:new()
    if err then 
        ngx.log(ngx.ERR,"Unable to instantiate resty.memcached") 
        return nil
    end

    memcache:set_timeout(timeout or 1000)

    local ok, err = memcache:connect(host,port)
    if not ok then
        ngx.log(ngx.WARN,"Unable to connect to memcache: " .. err)
        return nil
    end
    return memcache
end

function close(memcache)
    local ok,err = memcache:set_keepalive()
    if not ok then
        ngx.log(ngx.WARN, "Unable to set keepalive: " .. err)
    end
end

-- Connects, retrieves a key and then disconnects (setkeepalives) from memcache
function get(host,port,key)
    memcache = connect(host,port)
    -- If we couldn't get a memcache connection, then just return nothing
    -- - connect produces its own error messages.
    if not memcache then
        return nil
    end

    if not key then
        ngx.log(ngx.INFO,'No memcache key given')
        return nil
    end

    -- Attempt to retrieve the session from memcache then setkeepalive
    local res,flags,err = memcache:get(key)
    close(memcache)

    if err then
        ngx.log(ngx.ERR,string.format(
            "Unable to get key '%s' from memcache: %s",key,err))
        return nil
    end

    if not res then
        ngx.log(ngx.INFO,string.format("Key '%s' not found",key))
        return nil
    end

    return res
end