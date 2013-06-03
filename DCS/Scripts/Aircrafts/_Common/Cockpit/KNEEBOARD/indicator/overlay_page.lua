dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")

SetScale(FOV)
local TST  = MakeMaterial(nil,{28,187,0,150})
local width  = 1;
local height = width * GetAspect()
local line_w = 0.005

function ring(radius)
    local segments = 36 
    local verts = {}
	local inds  = {}
    for i = 1,segments + 1 do
        local alfa = math.rad((i-1) * 360/segments)
 		verts[i] = {radius * math.sin(alfa),radius * math.cos(alfa)}
		inds[2*i - 1] = i - 1
		inds[2*i]     = i
		if i == segments + 1 then
		inds[2*i] = 0
		end
	end
	local ring	       		 = CreateElement "ceMeshPoly"
		ring.name     	   	 =  create_guid_string()
		ring.material 	     =  TST
		ring.primitivetype   = "lines"
		ring.vertices 	     = verts 
		ring.indices	  	 = inds
		ring.level		     = DEFAULT_LEVEL
		ring.h_clip_relation = h_clip_relations.REWRITE_LEVEL
		Add(ring)
    return ring
end

--ring(1.0)




local objects	       = CreateElement "ceSimple"
objects.name     	   = "objects"
objects.controllers    = {{"draw_objects"}}
Add(objects)


flight_plan_line				= CreateElement "ceSimpleLineObject"
flight_plan_line.name			= "flight_lan_line"
flight_plan_line.material		= TST
flight_plan_line.width			= 0.005
flight_plan_line.controllers    = {{"flight_plan_line",GetScale()}}
flight_plan_line.h_clip_relation= h_clip_relations.COMPARE
flight_plan_line.level			= DEFAULT_LEVEL
Add(flight_plan_line)
