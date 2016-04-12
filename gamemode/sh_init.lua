AddCSLuaFile()

include "sh_classes.lua"
include "sh_c_weapons.lua"

GM.Name = "Memed"
GM.Author = "meepdarknessmeep"
GM.Email = ""
GM.TeamBased = true
DeriveGamemode "base"


TEAM_A   = 1
TEAM_B   = 2

function GM:CreateTeams()

    team.SetUp(TEAM_A, "Team A", Color(255,0,0), true)
    team.SetUp(TEAM_B, "Team B", Color(0,0,255), true)

    team.SetSpawnPoint(TEAM_A, "info_player_start")
    team.SetSpawnPoint(TEAM_B, "info_player_start")

end

function GM:SetupMove(p, mv, cmd)
    player_manager.RunClass(p, "SetupMove", mv, cmd)
end

function GM:StartCommand(p, cmd)
    player_manager.RunClass(p, "StartCommand", cmd)
end


function GM:CalculatePlayerRunSpeed(p, base)
    return base
end

function GM:CalculatePlayerWalkSpeed(p, base)
    return base
end
