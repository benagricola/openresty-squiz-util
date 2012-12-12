module('squtil.misc', package.seeall)
_VERSION = '0.01'

function get_cookie(cookie)
	return ngx.var['cookie_' .. cookie]
end

function append_via_header(identifier)
    local via = string.format('1.1 %s (%s)',ngx.var.server_name,identifier)
    ngx.header['Via'] = (ngx.header['Via'] ~= nil) and (via .. ', ' .. 
    	res.header['Via']) or via
end