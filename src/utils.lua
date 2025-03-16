CONFIG_API.UTILS = {}

function CONFIG_API.UTILS.dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. CONFIG_API.UTILS.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

---@param str string
function CONFIG_API.UTILS.capitalize(str)
	return str:gsub("%w+", function(word)
		return word:sub(1, 1):upper() .. word:sub(2):lower()
	end)
end

---@param str string
function CONFIG_API.UTILS.format_key(str)
	return CONFIG_API.UTILS.capitalize(str:gsub("_", " "))
end

function CONFIG_API.UTILS.keys(t)
	local keyset = {}
	for k, v in pairs(t) do
		table.insert(keyset, k)
	end
	return keyset
end

function CONFIG_API.UTILS.to_array(t)
	local arr = {}
	for k, v in pairs(t) do
		table.insert(arr, v)
	end
	return arr
end


function CONFIG_API.UTILS.get_parent_path(path)
	-- Find the position of the last forward slash
	local parent_path = path:match("(.*/)")

	-- If there is no path separator, return an empty string
	if not parent_path then
		return ""
	end

	-- Return the substring up to the last path separator
	if parent_path:sub(-1) == "/" then
		return parent_path:sub(1, -2)
	else
		return parent_path
	end
end

---@param array any[]
function CONFIG_API.UTILS.sort_by_order(array)
	table.sort(array, function(a, b)
		return (a.config_api_order or a.order or 0) < (b.config_api_order or b.order or 0)
	end)
end
