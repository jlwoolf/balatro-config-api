CONFIG_API.VALIDATE = {}

---checks if a variable is a array of a specific type
---@param var any
---@param var_type type
---@return boolean
function CONFIG_API.VALIDATE.is_type_arr(var, var_type)
	if type(var) ~= "table" then
		return false
	end

	local prev_key = -1
	for key, value in pairs(var) do
		if type(key) ~= "number" then
			return false
		end

		if key ~= prev_key + 1 then
			return false
		end
		prev_key = key

		if type(value) ~= var_type then
			return false
		end
	end

	return true
end

function CONFIG_API.VALIDATE.is_options(var)
	if type(var) ~= "table" then
		return false
	end

	local options = var["options"]

	-- must have the option key
	if options == nil then
		return false
	end

	-- options must be a string array
	if not CONFIG_API.VALIDATE.is_type_arr(options, "string") then
		return false
	end

	local value = var["value"]

	-- must have the value key
	if value == nil then
		return false
	end

	-- value must be a string
	if type(value) ~= "string" then
		return false
	end

	-- value must be an option
	local contains = false
	for _, v in ipairs(options) do
		if v == value then
			contains = true
		end
	end

	if not contains then
		return false
	end

	return true
end

function CONFIG_API.VALIDATE.is_range(var)
	if type(var) ~= "table" then
		return false
	end

	local range = var["range"]

	-- must have the range key
	if range == nil then
		return false
	end

	-- range must contain two values
	if #range ~= 2 then
		return false
	end

	-- range must be a number array
	if not CONFIG_API.VALIDATE.is_type_arr(range, "number") then
		return false
	end

	-- the first value of range must be less then the second
	if range[0] >= range[1] then
		return false
	end

	local value = var["value"]

	-- must have the value key
	if value == nil then
		return false
	end

	-- value must be a number
	if type(value) ~= "number" then
		return false
	end

	-- value must be within range
	if range[0] > value or range[1] < value then
		return false
	end

	return true
end