KeyStates = {}

for _, mapping in pairs(KEY) do
    RegisterKeyMapping(mapping.name, mapping.description, 'keyboard', mapping.defaultkey)
    KeyStates[mapping.name] = false
end

for _, mapping in pairs(KEY) do
    RegisterCommand(mapping.name, function()
        KeyStates[mapping.name] = true
        Wait(500)
        KeyStates[mapping.name] = false
    end, false)
end


