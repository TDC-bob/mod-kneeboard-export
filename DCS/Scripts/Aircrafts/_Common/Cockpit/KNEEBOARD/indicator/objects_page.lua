dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)

local OBJECTS	  = MakeMaterial("Bazar/Textures/AvionicsCommon/kneeboard_indication.tga",{255,0,0,130})
local OBJECTS_RED = MakeMaterial("Bazar/Textures/AvionicsCommon/kneeboard_indication.tga",{255,0,0,255})
local TST     = MakeMaterial(nil,{255,0,255,255})
local FONT_   = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_dejavu_lgc_sans_22"},{0,120,20,255},10,"dejavu_lgc_sans_22")
local FONT_2   = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_dejavu_lgc_sans_outline_22"},{255,255,255,200},10,"dejavu_lgc_sans_outline_22")

local base_half_element_size = 16/256
local texture_size = {256,64}

function box(half_sz)
return {{-half_sz,  half_sz},
	    { half_sz,  half_sz},
	    { half_sz, -half_sz},
		{-half_sz, -half_sz}}
end

function texture_box(UL_X,UL_Y,W,H)
	return  {{UL_X/texture_size[1]	   , UL_Y/texture_size[2]},
			{(UL_X + W)/texture_size[1], UL_Y/texture_size[2]},
			{(UL_X + W)/texture_size[1],(UL_Y + H)/texture_size[2]},
			{ UL_X/texture_size[1]     ,(UL_Y + H)/texture_size[2]}}
end

function element_40x40(name,UL_X,UL_Y,mat,sz_correction)
local   sz_correction  = sz_correction or 0
local 	element					= CreateElement("ceTexPoly")
		element.name 			= name
		element.material		= mat or OBJECTS
		element.vertices		= box(base_half_element_size + sz_correction)
		element.indices			= {0,1,2,2,3,0}
		element.use_mipfilter 	= true
		element.tex_coords		= texture_box(UL_X,UL_Y,40,40)
		return element
end

el_steerpoint 					= element_40x40("el_steerpoint",4,4)
el_steerpoint.h_clip_relation   = h_clip_relations.COMPARE
el_steerpoint.level 		    = DEFAULT_LEVEL		
				   
el_steerpoint.controllers		= {{"waypoint_position",GetScale()},
								   {"remove_orientation"}}
Add(el_steerpoint)

el_waypoint_name						= CreateElement "ceStringPoly"
el_waypoint_name.name					= "el_waypoint_name"
el_waypoint_name.alignment				= "LeftCenter"
el_waypoint_name.formats				= {"%s"}
el_waypoint_name.material				= FONT_2
el_waypoint_name.stringdefs				= {0.008,0.3 * 0.008,0,0}
el_waypoint_name.parent_element			= el_steerpoint.name
el_waypoint_name.use_mipfilter 			= true
el_waypoint_name.init_pos				= {-0.5*base_half_element_size,0}
el_waypoint_name.controllers			= {{"waypoint_name",0,0}}
el_waypoint_name.h_clip_relation   		= h_clip_relations.COMPARE
el_waypoint_name.level 		    		= DEFAULT_LEVEL	
Add(el_waypoint_name)

el_waypoint_name1						= CreateElement "ceStringPoly"
el_waypoint_name1.name					= "el_waypoint_name"
el_waypoint_name1.alignment				= "LeftCenter"
el_waypoint_name1.formats				= {"%s"}
el_waypoint_name1.material				= FONT_
el_waypoint_name1.stringdefs				= {0.008,0.3 * 0.008,0,0}
el_waypoint_name1.parent_element			= el_steerpoint.name
el_waypoint_name1.use_mipfilter 			= true
el_waypoint_name1.init_pos				= {-0.5*base_half_element_size,0}
el_waypoint_name1.controllers			= {{"waypoint_name",0,0}}
el_waypoint_name1.h_clip_relation   		= h_clip_relations.COMPARE
el_waypoint_name1.level 		    		= DEFAULT_LEVEL	
Add(el_waypoint_name1)
el_waypoint_name2						= CreateElement "ceStringPoly"
el_waypoint_name2.name					= "el_waypoint_name2"
el_waypoint_name2.alignment				= "LeftCenter"
el_waypoint_name2.formats				= {"%s"}
el_waypoint_name2.material				= FONT_2
el_waypoint_name2.stringdefs			= {0.008,0.3 * 0.008,0,0}
el_waypoint_name2.parent_element		= el_steerpoint.name
el_waypoint_name2.use_mipfilter 		= true
el_waypoint_name2.init_pos				= {base_half_element_size,0}
el_waypoint_name2.controllers			= {{"waypoint_name",0,1}}
el_waypoint_name2.h_clip_relation   	= h_clip_relations.COMPARE
el_waypoint_name2.level 		    	= DEFAULT_LEVEL	
Add(el_waypoint_name2)

el_waypoint_name3						= CreateElement "ceStringPoly"
el_waypoint_name3.name					= "el_waypoint_name2"
el_waypoint_name3.alignment				= "LeftCenter"
el_waypoint_name3.formats				= {"%s"}
el_waypoint_name3.material				= FONT_
el_waypoint_name3.stringdefs			= {0.008,0.3 * 0.008,0,0}
el_waypoint_name3.parent_element		= el_steerpoint.name
el_waypoint_name3.use_mipfilter 		= true
el_waypoint_name3.init_pos				= {base_half_element_size,0}
el_waypoint_name3.controllers			= {{"waypoint_name",0,1}}
el_waypoint_name3.h_clip_relation   	= h_clip_relations.COMPARE
el_waypoint_name3.level 		    	= DEFAULT_LEVEL	
Add(el_waypoint_name3)
			
el_self_mark_point 					 = element_40x40("el_self_mark_point",204,4)
el_self_mark_point.h_clip_relation   = h_clip_relations.COMPARE
el_self_mark_point.level 		     = DEFAULT_LEVEL		
el_self_mark_point.controllers		= {{"waypoint_position",GetScale()}}
Add(el_self_mark_point)

el_self_mark_point_name 					= Copy(el_waypoint_name)
el_self_mark_point_name.parent_element		= el_self_mark_point.name
el_self_mark_point_name.init_pos			= {0,0}
el_self_mark_point_name.controllers			= {{"waypoint_name",0},{"remove_orientation"},{"move",base_half_element_size * GetScale()}}
Add(el_self_mark_point_name)		

el_steerpoint_2					=  element_40x40("el_steerpoint_2",124,4,OBJECTS_RED,-0.2*base_half_element_size)
el_steerpoint_2.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
el_steerpoint_2.level 		    = DEFAULT_LEVEL	
el_steerpoint_2.parent_element  = el_steerpoint.name			   
el_steerpoint_2.isvisible		= false	
Add(el_steerpoint_2)



el_red_zone					= CreateElement "ceSimpleLineObject"
el_red_zone.name			= "el_red_zone"
el_red_zone.material		= OBJECTS_RED
el_red_zone.width			= 0.025
el_red_zone.offset          = 0.025
el_red_zone.tex_params      = {{0, 55/64}, {1,55/64},{1,(9/64)/0.025}}	
el_red_zone.controllers		= {{"zone_position",GetScale()}}
el_red_zone.level 		    = DEFAULT_LEVEL	
el_red_zone.h_clip_relation = h_clip_relations.COMPARE
el_red_zone.use_mipfilter 	= true
Add(el_red_zone)


el_red_zone_2				= Copy(el_red_zone)
el_red_zone_2.material		= TST
el_red_zone_2.width			= 0.0025
el_red_zone_2.offset       = 0
Add(el_red_zone_2)
