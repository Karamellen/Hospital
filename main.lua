local ped = PlayerPedId()

exports["qtarget"]:AddBoxZone("Signin", vector3(Config.HospitalNpc.x, Config.HospitalNpc.y, Config.HospitalNpc.z-0.95), 1.2, 1, {name = "Signin", heading = 40.9, debugPoly = false, minZ = Config.HospitalNpc.z-0.05, maxZ = Config.HospitalNpc.z+0.75}, {
    options = {
        {
            event = "karamel-hospital:SignIn",
            type = "client",
            icon = "fas fa-bars", 
            label = "Tjek Ind",
        },
    },
    job = {"all"},
    distance = 1.5
})

RegisterNetEvent('karamel-hospital:SignIn', function()
    local ped = PlayerPedId()

    FreezeEntityPosition(ped, true)
    exports['progressBars']:startUI(9000, "")
    Wait(9000)
    FreezeEntityPosition(ped, false)
    SetEntityCoords(ped, 314.5475, -584.1505, 43.2040)
    SetEntityHeading(ped, 336.63)

    RequestAnimDict('anim@gangops@morgue@table@')
    while not HasAnimDictLoaded('anim@gangops@morgue@table@') do
        Wait(10)
    end

    TaskPlayAnim(ped, 'anim@gangops@morgue@table@', 'ko_front', 8.0, -8.0, -1, 1, 0, false, false, false)
    InBed = true

    CreateThread(function()
        while InBed == true do
            SetEntityHealth(PlayerPedId(), 200)
            local text = "~r~E~w~ - Forlad sengen"

			if IsControlPressed(0, 38) then
				ClearPedTasks(ped)
                SetEntityCoords(ped, 313.42, -583.71, 43.28)
                InBed = false
                exports['mythic_notify']:DoHudText('success', 'Du forlod sengen.')
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)

            Wait(0)
        end
    end)
end)

CreateThread(function()
    local model = GetHashKey('s_m_m_doctor_01')

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
    QuestGiver = CreatePed(4, model, Config.HospitalNpc.x, Config.HospitalNpc.y, Config.HospitalNpc.z-0.95, false, true)
    
    FreezeEntityPosition(QuestGiver, true)
    SetEntityInvincible(QuestGiver, true)
    SetEntityHeading(QuestGiver, 340.28)
    SetBlockingOfNonTemporaryEvents(QuestGiver, true)
end)

function DrawGenericTextThisFrame()
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.0, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)
end