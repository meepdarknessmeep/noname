AddCSLuaFile()
local PLAYER = {}

PLAYER.DisplayName = "class_base"

function PLAYER:StartCommand(cmd)
    local me = self.Player
    me:SetRunSpeed(hook.Call("CalculatePlayerRunSpeed", gmod.GetGamemode(), self, self.RunSpeed))
    me:SetWalkSpeed(hook.Call("CalculatePlayerWalkSpeed", gmod.GetGamemode(), self, self.WalkSpeed))
end

function PLAYER:SetupMove(mv, cmd)
    local me = self.Player
    mv:SetMaxClientSpeed(mv:KeyDown(IN_SPEED) and self.RunSpeed or self.WalkSpeed)
    mv:SetMaxSpeed(mv:GetMaxClientSpeed())
end

player_manager.RegisterClass("class_base", PLAYER, "player_default")
