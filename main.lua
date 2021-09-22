
local oolua = require("oolua")

local class_test_constructor = function(...)
	local this = {}
	this.value = ({...})[1]
	return this
end
local class_test = oolua.newClass(0, oolua.asValue, class_test_constructor, nil)

local test = class_test.new(6)

print(test.value)
obj = test + 2
print(test.value)
