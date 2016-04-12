AddCSLuaFile()
local PLAYER = {}
DEFINE_BASECLASS "class_base"

PLAYER.DisplayName = "Bullet"
PLAYER.WalkSpeed   = 1000
PLAYER.RunSpeed    = 1000



player_manager.RegisterClass("class_bullet", PLAYER, "class_base")
