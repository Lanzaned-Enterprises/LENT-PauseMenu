local QBCore = exports['qb-core']:GetCoreObject()

function AddTextEntry(key, value)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

CreateThread(function()
    if LENT.Settings['AddSelectionBar'] then
        ReplaceHudColourWithRgba(116, LENT.HUDColors['SelectionBar'].Red, LENT.HUDColors['SelectionBar'].Blue, LENT.HUDColors['SelectionBar'].Green, LENT.HUDColors['SelectionBar'].Alpha)
    end

    ReplaceHudColourWithRgba(117, LENT.HUDColors['MenuBackground'].Red, LENT.HUDColors['MenuBackground'].Blue, LENT.HUDColors['MenuBackground'].Green, LENT.HUDColors['MenuBackground'].Alpha)

    if LENT.Settings['UseCustomTabNames'] then
        AddTextEntry('PM_SCR_MAP',      LENT.PauseMenu['Map']) -- Map
        AddTextEntry('PM_SCR_GAM',      LENT.PauseMenu['Leave_Disconnect']) -- Leave/Disconnect
        AddTextEntry('PM_PANE_LEAVE',   LENT.PauseMenu['DisconnectButton']) -- Disconnect
        AddTextEntry('PM_PANE_QUIT',    LENT.PauseMenu['LeaveButton']) -- Leave
        AddTextEntry('PM_SCR_INF',      LENT.PauseMenu['Information']) -- Info
        AddTextEntry('PM_SCR_STA',      LENT.PauseMenu['Statistics']) -- Statistics
        AddTextEntry('PM_SCR_SET',      LENT.PauseMenu['Settings']) -- Settings
        AddTextEntry('PM_SCR_GAL',      LENT.PauseMenu['Gallary']) -- Gallary
        AddTextEntry('PM_SCR_RPL',      LENT.PauseMenu['Editor']) -- Editor
        AddTextEntry('PM_PANE_CFX',     LENT.PauseMenu['CFX_CONTROLS']) -- FiveM Added Config
    end

    while true do
        Wait(0)
        if IsPauseMenuActive() and LENT.Settings['UseCustomImage'] then SendNUIMessage({ display = true }) else SendNUIMessage({ display = false }) end
        if LocalPlayer.state.isLoggedIn then
            if LENT.Settings['UseMoneyNatives'] then
                StatSetInt(`MP0_WALLET_BALANCE`, QBCore.Functions.GetPlayerData().money.cash, true)
                StatSetInt(`BANK_BALANCE`, QBCore.Functions.GetPlayerData().money.bank, true)
                if IsControlJustPressed(0 --[[control type]], 20 --[[control index]]) then
                    N_0x170f541e1cadd1de(true)
                    if LENT.HUDComponents['ShowMoney'] then
                        SetMultiplayerWalletCash()
                    end
                    if LENT.HUDComponents['ShowBank'] then
                        SetMultiplayerBankCash()
                    end
                    N_0x170f541e1cadd1de(false)
    
                    Wait(5000)
    
                    RemoveMultiplayerWalletCash()
                    RemoveMultiplayerBankCash()
                end
            end
            -- Left Menu
            N_0xb9449845f73f5e9c("SHIFT_CORONA_DESC")
            PushScaleformMovieFunctionParameterBool(true)
            if LENT.Settings['AddSelectionBar'] then
                PushScaleformMovieFunctionParameterBool(true)
            end
            PopScaleformMovieFunction()
            N_0xb9449845f73f5e9c("SET_HEADER_TITLE")
            PushScaleformMovieFunctionParameterString(LENT.PauseMenu['ServerName'])
            PushScaleformMovieFunctionParameterBool(true)
            PushScaleformMovieFunctionParameterString(LENT.PauseMenu['ServerDescription'])
            PushScaleformMovieFunctionParameterBool(true)
            PopScaleformMovieFunctionVoid()
            -- Right Menu
            BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
            if LENT.Settings['ShowCustomInformationLines'] then
                if LENT.Settings['ShowDepartmentCallsign'] then
                    if QBCore.Functions.GetPlayerData().metadata.callsign then
                        local FirstName = QBCore.Functions.GetPlayerData().charinfo.firstname
                        local LastName = QBCore.Functions.GetPlayerData().charinfo.lastname
                        local Callsign = "[" .. QBCore.Functions.GetPlayerData().metadata.callsign .. "]"
                        local Rank = QBCore.Functions.GetPlayerData().job.grade.name
                        local Text = Callsign .. " - " .. Rank .. " " .. FirstName .. " " .. LastName
                        PushScaleformMovieFunctionParameterString(Text)
                    else
                        PushScaleformMovieFunctionParameterString(QBCore.Functions.GetPlayerData().charinfo.firstname .. ' ' .. QBCore.Functions.GetPlayerData().charinfo.lastname)
                    end
                end
                PushScaleformMovieFunctionParameterString("Cash: " .. QBCore.Functions.GetPlayerData().money.cash)
                PushScaleformMovieFunctionParameterString("Bank: " .. QBCore.Functions.GetPlayerData().money.bank)
            end
            ScaleformMovieMethodAddParamBool(false)
            ScaleformMovieMethodAddParamBool(isScripted)
            EndScaleformMovieMethod()
        end
    end
end)