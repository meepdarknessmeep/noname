AddCSLuaFile "panels/team.lua"
AddCSLuaFile "panels/team_select.lua"
AddCSLuaFile "cl_teams.lua"

include      "sh_init.lua"
include      "sv_teams.lua"
include      "sv_resources.lua"

util.AddNetworkString "show_team"

DEFINE_BASECLASS "gamemode_base"

function GM:PlayerInitialSpawn(p)

    p:SetTeam(TEAM_UNASSIGNED)

    hook.Call("ShowTeam", gmod.GetGamemode(), p)

end
