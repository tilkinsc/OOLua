
local main = {}

main.METATYPE_VALUE = 0
main.METATYPE_FIELD = 1


main.asValue = function(obj)
	local metatable = {
		metatype = main.METATYPE_VALUE;
		__add = function(t, v)
			t.value = t.value + v
			return t
		end;
		__sub = function(t, v)
			t.value = t.value - v
			return t
		end;
		__mul = function(t, v)
			t.value = t.value * v
			return t
		end;
		__div = function(t, v)
			t.value = t.value / v
			return t
		end;
		__mod = function(t, v)
			t.value = t.value % v
			return t
		end;
		__unm = function(t)
			t.value = -t.value;
			return t
		end;
		__concat = function(t, v)
			t.value = t.value .. v
			return t
		end;
		__pow = function(t, v)
			t.value = t.value ^ v
			return t
		end;
		__call = function(...)
			t.value(...)
		end;
		__eq = function(t, v)
			return t.value == v
		end;
		__lt = function(t, v)
			return t.value < v
		end;
		__le = function(t, v)
			return t.value <= v
		end;
		__gc = function(t)
			obj.destructor()
		end;
		__tostring = function(t)
			return t.hash
		end;
	}
	return metatable
end

main.asFields = function(obj)
	local metatable = {
		metatype = main.METATYPE_FIELD;
		__gc = function(t)
			obj.destructor()
		end;
		__eq = function(t)
			return t.hash == obj.hash
		end;
		__tostring = function(t)
			return t.hash
		end;
	}
	return metatable
end



main.newClass = function(uuid, metatype, constructor, destructor)
	-- TODO: allocate memory
	local this = {}
	this.uuid = uuid
	this.new = function(...)
		local loc = constructor(...)
		loc.uuid = uuid
		if(metatype)then
			setmetatable(loc, metatype(loc))
		end
		return loc
	end
	this.free = destructor
	
	
	return this
end



return main

