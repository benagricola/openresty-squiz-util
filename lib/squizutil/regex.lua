module('squiz.regex', package.seeall)
_VERSION = '0.011'

function match_all(expressions,string)
    return match_multi(expressions,string)
end

function match_any(expressions,string)
    return match_multi(expressions,string,true)
end

function match_none(expressions,string)
    return not match_multi(expressions,string,true)
end

-- This matches all or any depending on truth / falsity of `flip`
function match_multi(expressions,string,flip)
    if #expressions < 1 or not string then return false end
    for _, expr in pairs(expressions) do
        local match = ngx.re.match(string,expr,'jo')
        ngx.log(ngx.INFO,string.format("Match '%s': %s",expr,
            (match and 'Yes' or 'No')))
        if (flip and match) or (not flip and not match) then
            return flip
        end
    end
    return not flip
end