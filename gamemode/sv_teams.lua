
DEFINE_BASECLASS "gamemode_base"

function GM:ShowTeam(p)

    if (p.TeamSet) then
        return
    end

    net.Start "show_team"
        net.WriteBool(true)
    net.Send(p)

    p.TeamSet = false

end

function GM:PlayerClassChosen(p, class)
    print"a"
    player_manager.SetPlayerClass(p, class)
    net.Start "show_team"
        net.WriteBool(false)
        net.WriteString(class)
    net.Send(p)
end

function GM:PlayerJoinTeam(p, team)
    p:SetTeam(team)
    p.TeamSet = true
    hook.Call("PlayerClassChosen", gmod.GetGamemode(), p, "class_bullet")

    p:Spawn()
end

function GM:PlayerCanJoinTeam(p, team)
    return (team == TEAM_A or team == TEAM_B) and not p.TeamSet
end

net.Receive("show_team", function(l, p)

    if (p.TeamSet) then
        return
    end

    local team = net.ReadUInt(16)

    local canjoin = hook.Call("PlayerCanJoinTeam", gmod.GetGamemode(), p, team)

    if (canjoin) then
        hook.Call("PlayerJoinTeam", gmod.GetGamemode(), p, team)
    end

end)
