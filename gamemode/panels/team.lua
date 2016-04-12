DEFINE_BASECLASS "EditablePanel"

PANEL.Background = Material "team_select.jpg"

function PANEL:Init()

    self:SetMouseInputEnabled(true)
    self:MakePopup()
    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
    self:Dock(FILL)
    self:InvalidateParent(true)

end

function PANEL:Remove()
    self:SetMouseInputEnabled(false)
    timer.Simple(0, function()
        BaseClass.Remove(self)
    end)
end

function PANEL:Paint(scrw, scrh)

    local img = self.Background

    local w, h = img:GetInt "$realwidth", img:GetInt "$realheight"

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(self.Background)

    if (scrw / w < scrh / h) then
        w = w * (scrh / h)
        h = scrh
        surface.DrawTexturedRect(-(w - scrw) / 2, 0, w, h)
    else
        h = h * (scrw / w)
        w = scrw
        surface.DrawTexturedRect(0, -(h - scrh) / 2, w, h)
    end

end
