require('util')
require('defines')

local _ = require './lib/_util'

local MOD_NAME = 'timeflaps'

local config = _.assign(_.prequire('config'), require('defaults'))
local _log = config.debug and function(...) print(string.format("[%s]", MOD_NAME), ...) end or function() end

local tf = require('./lib/timeflaps')(config, _log, global)

remote.add_interface('timeflaps', {
  set_config = function(k, v)
    local _v = loadstring('return ' .. v)()
    config[k] = _v
    _log('set config', k, serpent.line(_v))
  end,

  pos = function()
    game.player.print(string.format('Player position: { %d, %d }', game.player.position.x, game.player.position.y))
  end,

  cap_start = tf.cap_start,
  
  cap_stop = tf.cap_stop,
})

if config.cap_autostart then
  tf.cap_start()
end

script.on_event(defines.events.on_tick, tf.tick)
