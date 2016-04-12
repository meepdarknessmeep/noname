
vgui.Register("panel_team", vgui.RegisterFile "panels/team.lua", "EditablePanel")
vgui.Register("panel_team_select", vgui.RegisterFile "panels/team_select.lua", "EditablePanel")

net.Receive("show_team", function()
    if (net.ReadBool()) then
        hook.Call("ShowTeam", gmod.GetGamemode())
    else
        hook.Call("PlayerClassChosen", gmod.GetGamemode(), LocalPlayer(), net.ReadString())
    end
end)

function GM:PlayerClassChosen(p, str)
    player_manager.SetPlayerClass(p, str)
end

function GM:SelectTeam(team)
    net.Start "show_team"
        net.WriteUInt(team, 16)
    net.SendToServer()
end

function GM:ShowTeam()

    local panel = vgui.Create("panel_team")

    local select_a = vgui.Create("panel_team_select", panel)
    local select_b = vgui.Create("panel_team_select", panel)
    select_a:SetPos(ScrW() * .05, ScrH() * 0.75)
    select_a:SetSize(ScrW() * .4, ScrH() * 0.2)
    select_b:SetPos(ScrW() * .55, ScrH() * 0.75)
    select_b:SetSize(ScrW() * .4, ScrH() * 0.2)

    function select_a.DoClick()
        panel:Remove()
        self:SelectTeam(TEAM_A)
    end

    function select_b.DoClick()
        panel:Remove()
        self:SelectTeam(TEAM_B)
    end

end
