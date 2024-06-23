---@diagnostic disable: param-type-mismatch
-- Variabili globali
CICUS       = {}
CICUS.Utils = {}
CICUS.lib   = {}
CICUS.lib.Marker = {}



-- UTILS --


-- STREAMING --

CICUS.Utils.RequestTexture = function (dict, timeout)
  if HasStreamedTextureDictLoaded(dict) then return dict end
    RequestStreamedTextureDict(dict, false)
    if coroutine.running() then
        timeout = tonumber(timeout) or 500

        for _ = 1, timeout do
            if HasStreamedTextureDictLoaded(dict) then
                return dict
            end

            Wait(0)
        end

        return print(("ERRORE: TEXTURE NON CARICATA '%s' DOPO %s TEMPO"):format(dict, timeout))
    end
    return dict
end

CICUS.Utils.RequestAnim = function (anim)
  while not HasAnimDictLoaded(anim) do
    RequestAnimDict(anim)
    Wait(0)
  end
end

CICUS.Utils.RequestModel = function (model)
  while not HasModelLoaded(model) do
    RequestModel(model)
    Wait(0)
  end
end


-- UTILS -- 
CICUS.Utils.CompareVector3 = function (coords1, coords2, tolerance)
  local dx = coords1.x - coords2.x
  local dy = coords1.y - coords2.y
  local dz = coords1.z - coords2.z
  return (dx * dx + dy * dy + dz * dz) <= (tolerance * tolerance)
end

-- LIB --

CICUS.lib.KeyPress = function(command, callback)
  if KeyStates[command] then
      KeyStates[command] = false
      if callback then
          callback()
      end
      return true
  end
  return false
end

CICUS.lib.DrawText = function (text, color, scale, font, x, y)
  SetTextFont(font)
	SetTextProportional(1)
	SetTextScale(scale[1], scale[2])
	SetTextColour(color[1], color[2], color[3], color[4])
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end


CICUS.lib.DrawAdvancedMarker = function (options)
    if not options.pos then print('MARKER SYSTEM :ERRORE: VALORE MANCANTE') return false, nil end
    local type, rot, scale, key = options.type or 9, options.rot or vector3(90.0, 90.0, 90.0), options.scale or vector3(1.0, 1.0, 1.0), options.key or 38
    if options.job and (ESX.PlayerData.job.name ~= options.job or (options.job_grade and ESX.PlayerData.job.grade < options.job_grade)) then Wait(1000) end

    DrawMarker(
      type,
      options.pos.x, options.pos.y, options.pos.z,
      0, 0, 0,
      rot.x, rot.y, rot.z,
      scale.x, scale.y, scale.z,
      255, 255, 255, 255,
      false,
      false,
      9,
      true,
      nil,
      nil,
      false
    )

    if #(Playercoords - options.pos) < 2 then
      if IsControlJustPressed(0, key) then
        options.OnPress()
      end
    end

    if #(Playercoords - options.pos) > 30 then
      Wait(1000)
    end
end


exports('CICUS', function ()
  return CICUS
end)
