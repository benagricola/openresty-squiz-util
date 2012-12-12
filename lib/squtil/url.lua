module('squtil.url', package.seeall)
_VERSION = '0.01'

-- Return the current relative URL, optionally overriding each part of it 
-- (uri,query_string). Items which do not need to be overridden can be called
-- with nil.
function relative(uri,query_string)
    return (uri or ngx.var.uri) .. (query_string and '?' or ngx.var.is_args)
    	.. (query_string or ngx.var.query_string or "")
end

-- Return the current full URL, optionally overriding each part of it 
-- (scheme,host,uri,query_string). Items which do not need to be 
-- overridden can be called with nil.
function full(scheme,host,...)
    return (scheme or ngx.var.scheme) .. '://' .. (host or ngx.var.host)
    	.. relative(...)
end