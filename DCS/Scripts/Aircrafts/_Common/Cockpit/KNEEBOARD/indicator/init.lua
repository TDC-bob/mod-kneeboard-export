dofile(LockOn_Options.common_script_path.."devices_defs.lua")
---dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
indicator_type       = indicator_types.COMMON

--------------------------------------------------------
-------------- Custom KNEEBOARD - START - PeterP -----------------
--------------------------------------------------------

function set_full_viewport_coverage(viewport)
   dedicated_viewport 		 = {viewport.x,
								viewport.y,
								viewport.width,
								viewport.height}
   dedicated_viewport_arcade = dedicated_viewport
   purposes 				 = {render_purpose.GENERAL,
								render_purpose.HUD_ONLY_VIEW,
								render_purpose.SCREENSPACE_OUTSIDE_COCKPIT,
								render_purpose.SCREENSPACE_INSIDE_COCKPIT} -- set purposes to draw it always 
   render_target_always = true
end


-- try to find assigned viewport
function try_find_assigned_viewport(exactly_name,abstract_name)
	local multimonitor_setup_name =  "Config/MonitorSetup/"..get_multimonitor_preset_name()..".lua"
	local f = loadfile(multimonitor_setup_name)
	if	  f 	then
		  local env = {screen = LockOn_Options.screen}
		  setfenv(f,env)
		  pcall(f)
		  local target_env = env[exactly_name]
		  if not target_env and abstract_name then
			 target_env = env[abstract_name]
		  end
		  if target_env then
			 set_full_viewport_coverage(target_env)
		  end	  
	end
end

indicator_type       = indicator_types.COMMON
try_find_assigned_viewport("KNEEBOARD") 

--------------------------------------------------------
-------------- Custom KNEEBOARD - END - PeterP -------------------
--------------------------------------------------------
----------------------
init_pageID     = 1
purposes 	 	 		   = {100,render_purpose.HUD_ONLY_VIEW} --100 as guard to switch off general in cockpit rendering , cause purposes cannot be empty
--subset ids
BASE    = 1
OVERLAY = 2
MAP     = 3
OBJECTS = 4
OVERLAY2 = 5

page_subsets  =
{
	[BASE]    = LockOn_Options.common_script_path.."KNEEBOARD/indicator/base_page.lua",
	[OVERLAY] = LockOn_Options.common_script_path.."KNEEBOARD/indicator/overlay_page.lua",
	[OBJECTS] = LockOn_Options.common_script_path.."KNEEBOARD/indicator/objects_page.lua",
	[OVERLAY2] = LockOn_Options.common_script_path.."KNEEBOARD/indicator/overlay2_page.lua",
}
pages = 
{
	{BASE,MAP,OVERLAY,OVERLAY2},
}

GetSelf():Add_Map_Page(MAP,LockOn_Options.common_script_path.."KNEEBOARD/indicator/map_page.lua")

custom_images = {}

lfs = require("lfs")
number_of_additional_pages = 0
function scan_path(path)
	if not path then 
		return
	end
	for file in lfs.dir(path) do
		if file ~= "." and
		   file ~= ".." and 
		   file ~= ".svn" and 
		   file ~= "_svn"  then        
		   local fn = path.."/"..file
		   local attr = lfs.attributes (fn)
		   
		   local ext = string.sub(file, -4)
		   
		   if attr.mode	 ~= "directory" then
			  if '.lua' == ext then
				  page_subsets[#page_subsets  + 1] = fn;
				  pages[#pages + 1]				   = {BASE,#page_subsets,OVERLAY2}
				  number_of_additional_pages  = number_of_additional_pages + 1 
			  elseif '.dds' == ext or
			         '.bmp' == ext or
					 '.jpg' == ext or
					 '.png' == ext or
					 '.tga' == ext then
					custom_images[#custom_images  + 1] = fn --they will generates from C++
					number_of_additional_pages  	   = number_of_additional_pages + 1
			  end
		   end
		end
	end
end

scan_path(get_terrain_related_data("KNEEBOARD"))
scan_path(LockOn_Options.common_script_path.."KNEEBOARD/indicator/CUSTOM")
scan_path(lfs.writedir().."KNEEBOARD")

specific_element_id =
{
	STEERPOINT = 0,  
	RED_ZONE   = 1,
	SELF_MARK  = 2,
}

specific_element_names = {}
specific_element_names[specific_element_id.STEERPOINT] = "el_steerpoint"
specific_element_names[specific_element_id.RED_ZONE]   = "el_red_zone"
specific_element_names[specific_element_id.SELF_MARK]  = "el_self_mark_point"

function get_template(name)
	return OBJECTS
end

function get_specific_element_name_by_id(id)
	return specific_element_names[id] or "el_steerpoint"
end

if is_left == nil then
   is_left =  false
end

update_screenspace_diplacement(SelfWidth/SelfHeight,is_left)
dedicated_viewport_arcade = dedicated_viewport

