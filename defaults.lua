return {
  --[[ The first number placeholder (%d) is for the starting tick of the capture,
  the second is the order of the captures. %05d formats the number with leading
  zeroes. The file extension can be .png, .jpg and .gif, but it's recommended to
  use .png because the .jpg quality is very low (high compression). ]]
  cap_path_format = 'timeflaps/tick%d/cap%05d.png',

  --[[ Size of the captured images. Affects capture and video preview speed,
  so use lower sizes for testing,  higher for final versions. Downsampling from
  higher resolutions will generally result in better quality than 1:1 images
  from the game. ]]
  cap_resolution = { 1920, 1080 },

  --[[ How zoomed in or out the captured images will be. 1 is the game default. ]]
  cap_zoom = 0.45,

  --[[ Adjust the zoom based on the height of a different resolution from the
  capture resolution (assuming 16:9). Useful for framing the captures in game
  but capturing at a higher resolution. ]]
  cap_zoom_base_res_y = 720,

  --[[ Show the game GUI in the captures. ]]
  cap_show_gui = false,

  --[[ Show icon overlay for, e.g., building production targets. ]]
  cap_show_entity_info = true,

  --[[ Start capturing automatically upon loading or starting the game. ]]
  cap_autostart = true,

  --[[ Automatically stop capturing after this number of images. ]]
  cap_limit = 0,

  --[[ Force all images to be bright. Recommended for very high speedups because
  the day/night cycle will cause a strobing effect then. ]]
  cap_force_daytime = false,

  --[[ Indended speedup of the timelapse video. ]]
  target_speedup = 60,

  --[[ Indended framerate of the timelapse video. ]]
  target_video_fps = 60,

  --[[ Show a position marker for the camera position (useful for testing
  camera follow setings). Don't use in actual games because it will cause desyncs. ]]
  cam_debug_pos = false,

  --[[ Don't move the camera if it's within this radius from the player. ]]
  cam_follow_dead_radius = 2.5,

  --[[ Higher number means the camera will catch up with the player slower. ]]
  cam_follow_smooth_factor = 5,

  --[[ Use a fixed camera position instead of the camera following the player.
  For example:
  cam_fixed_pos = { 13, -15 },
  ]]
  cam_fixed_pos = nil,

  --[[ Print debug information to stdout (start game in a console to see). ]]
  debug = true,
  --[[ Set to false to disable saving the screenshots (testing). ]]
  cap_save = true,
}
