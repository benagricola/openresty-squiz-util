module('util.actions', package.seeall)
_VERSION = '0.01'

require "util.url"

-- Flips the scheme of an nginx request 
function redirect_flip_scheme()
    ngx.redirect(util.url.full((ngx.var.scheme == 'http') 
    	and 'https' or 'http'),ngx.HTTP_MOVED_TEMPORARILY)
    return ngx.exit(ngx.HTTP_SPECIAL_RESPONSE) 
end

-- Redirects to a different path. If append is true,
-- then appends the given path to the current ngx.var.uri
-- otherwise simply redirects to the given path.
function redirect_path(path,append)
	if append then
		path = util.url.relative(ngx.var.uri .. path)
	end

	ngx.redirect(path,ngx.HTTP_MOVED_TEMPORARILY)
    return ngx.exit(ngx.HTTP_SPECIAL_RESPONSE)
end
