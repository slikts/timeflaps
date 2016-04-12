local _ = require './_util'

return function(config, _log, global)
  local tf = {}

  _log('load config', serpent.block(config, {comment = false}))

  function tf.cap_start()
    if global.cap_started then
      return
    end
    global.cap_count = 0
    global.cap_start_tick = nil
    global.cap_started = true
    _log('cap started')
  end

  function tf.cap_stop()
    global.cap_started = false
    _log('cap stopped')
  end

  local cam_pos
  local last_cap_interval
  local cam_debug_ent

  function tf.tick(event)
    local cap_interval = config.target_speedup / config.target_video_fps * game.speed * 60
    if last_cap_interval ~= cap_interval then
      last_cap_interval = cap_interval
      _log('cap interval', cap_interval .. ' ticks')
    end

    if global.time_restore ~= nil then
      game.daytime = global.time_restore
      global.time_restore = nil
    end

    if global.cap_start_tick == nil then
      _log('cap start tick', event.tick)
      global.cap_start_tick = event.tick
    end

    if config.cam_debug_pos and cam_pos then
      if cam_debug_ent then
        cam_debug_ent.destroy()
      end
      cam_debug_ent = game.get_surface(1).create_entity{ name="red-asterisk", position = cam_pos }
    end

    if event.tick % cap_interval > 0 then
      return
    end

    if not config.cam_fixed_pos then
      local player_pos = { game.player.character.position.x, game.player.character.position.y }
      if not cam_pos then
        cam_pos = player_pos
      else
        local cam_diff = _.pos_diff(player_pos, cam_pos)
        local cam_dist = _.dist(cam_diff)
        if cam_dist > config.cam_follow_dead_radius then
          cam_pos = _.map(cam_pos, function(x, i)
            return x + cam_diff[i] / ((cam_dist / (cam_dist - config.cam_follow_dead_radius)) * config.cam_follow_smooth_factor)
          end)
        end
      end
    else
      cam_pos = config.cam_fixed_pos
    end
    if not global.cap_started then
      return
    end

    local cap_count = global.cap_count
    if config.cap_save then
      global.cap_count = cap_count + 1
      if cap_count > 0 and cap_count % 100 == 0 then
        log('caps ' .. cap_count)
      end

      if config.cap_force_daytime then
        global.time_restore = game.daytime
        game.daytime = 0
      end

      local cap_path = string.format(config.cap_path_format, global.cap_start_tick, global.cap_count)
      if global.cap_count == 1 then
        _log('cap path start', cap_path)
      end

      game.take_screenshot{
        position = cam_pos,
        resolution = config.cap_resolution,
        zoom = config.cap_zoom * (config.cap_resolution[2] / config.cap_zoom_base_res_y),
        path = cap_path,
        show_entity_info = config.cap_show_entity_info,
        show_gui = config.cap_show_gui,
      }
    end

    if config.cap_limit > 0 and global.cap_count > config.cap_limit then
      _log('cap limit reached', config.cap_limit)
      tf.cap_stop()
      if (config.cap_limit_break) then
        assert(false)
      end
    end
  end

  return tf
end
