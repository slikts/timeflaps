local _ = {}

function _.map(t, callback)
  local result = {}
  for i, v in pairs(t) do
    result[i] = callback(v, i)
  end
  return result
end

function _.reduce(t, callback)
  local result
  for i, v in pairs(t) do
    if i == 1 then
      result = v
    else
      result = callback(result, v)
    end
  end
  return result
end

function _.sum(t)
  return _.reduce(t, function(a, b)
    return a + b
  end)
end

function _.reverse(t)
  local result = {}
  for i = #array, 1, -1 do
    -- result[#result + 1] = t[i]
    table.insert(result, t[i])
  end
  return result
end

function _.prequire(m)
  local ok, err = pcall(require, m)
  if not ok then return nil, err end
  return err
end

function _.assign(a, b)
  for i, v in pairs(a) do
    b[i] = v
  end
  return b
end

function _.pos_diff(a, b)
  return _.map(a, function(x, i)
    return x - b[i]
  end)
end

function _.sum(t)
  return _.reduce(t, function(a, b)
    return a + b
  end)
end

function _.dist(pos_diff)
  return math.sqrt(_.sum(_.map(pos_diff, function(x)
    return x^2
  end)))
end

return _
