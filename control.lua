require('util')
require('defines')

local _ = require './lib/_util'

local MOD_NAME = 'timeflaps'

local config = _.assign(_.prequire('config'), require('defaults'))
local _log = config.debug and function(...) print(string.format("[%s]", MOD_NAME), ...) end or function() end

local tf = require('./lib/timeflaps')(config, _log, global)

remote.add_interface('timeflaps', {
  set_config = function(k, v)
    config[k] = v
    _log('set config', k, v)
  end,
})

if config.cap_autostart then
  tf.cap_start()
end

script.on_event(defines.events.on_tick, tf.tick)
