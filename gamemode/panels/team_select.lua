DEFINE_BASECLASS "EditablePanel"

local mat = surface.GetTextureID("vgui/white")

function PANEL:Init()
    self:InvalidateLayout(true)
end

surface.CreateFont("team_select_text", {
    font = "Trebuchet18",
    size = 26,
    antialias = false,
    outline = true
})

function PANEL:PerformLayout(w, h)

    local point = Vector(self:GetParent():GetWide() / 2, 0, 0)

    local x, y = self:GetPos()

    local target_left_top, target_left_bottom,
          target_right_top, target_right_bottom

          --get normal multiply by height

    target_left_bottom  = Vector(x,     y + h, 0)
    target_left_top     = Vector(x,     y,     0)
    target_right_top    = Vector(x + w, y,     0)
    target_right_bottom = Vector(x + w, y + h, 0)
    if (x + w < point.x) then -- target top right and bottom left
        local norm_right = (target_right_top  - point) / (target_right_top.y - point.y)
        local norm_left  = (target_left_bottom - point) / (target_left_bottom.y - point.y)

        target_left_top = point + norm_left * (target_left_top.y - point.y)
        target_right_bottom = point + norm_right * (target_right_bottom.y - point.y)
    else
        local norm_right = (target_right_bottom  - point) / (target_right_bottom.y - point.y)
        local norm_left  = (target_left_top - point) / (target_left_top.y - point.y)

        target_left_bottom = point + norm_left * (target_left_bottom.y - point.y)
        target_right_top = point + norm_right * (target_right_top.y - point.y)
    end
    local panel_pos = Vector(self:GetPos())

    target_left_bottom = target_left_bottom - panel_pos
    target_left_top = target_left_top - panel_pos
    target_right_bottom = target_right_bottom - panel_pos
    target_right_top = target_right_top - panel_pos

    self.VectorPoly = {
        target_left_top,
        target_right_top,
        target_right_bottom,
        target_left_bottom
    }
    self.Poly = {
        {
            x = target_left_top.x,
            y = target_left_top.y
        },
        {
            x = target_right_top.x,
            y = target_right_top.y
        },
        {
            x = target_right_bottom.x,
            y = target_right_bottom.y
        },
        {
            x = target_left_bottom.x,
            y = target_left_bottom.y
        }
    }

end

function PANEL:GetLeftRightAt(y)
    local poly = self.Poly
    local rightx = self.VectorPoly[2] + (self.VectorPoly[3] - self.VectorPoly[2]) /
                       (poly[3].y - poly[2].y) * y


    local leftx   = self.VectorPoly[1] + (self.VectorPoly[4] - self.VectorPoly[1]) /
                      (poly[4].y - poly[1].y) * y

    return leftx.x, rightx.x
end

function PANEL:TestMouseInside()

    if (vgui.GetHoveredPanel() ~= self) then
        return false
    end

    local leftx, rightx = self:GetLeftRightAt(gui.MouseY() - select(2, self:GetPos()))

    local x = gui.MouseX() - self:GetPos()
    return (leftx > x and 1 or 0) + (rightx > x and 1 or 0) == 1

end

function PANEL:Think()

    self.IsHovered = self:TestMouseInside()
    self.WasReleased = self.IsClicked
    self.IsClicked = self.IsHovered and input.IsMouseDown(MOUSE_LEFT)
    self.WasReleased = self.WasReleased and not self.IsClicked

    if (self.WasReleased) then
        self:OnClick()
    end

end

function PANEL:Paint(w, h)
    local drawc = Color(255,255,255,255)
    if (self.IsHovered) then
        drawc = Color(180,180,180,255)
        surface.SetTextColor(255,128,128,255)
    else
        surface.SetTextColor(255,128,128,255)
    end

    surface.SetDrawColor(drawc)
    surface.SetTexture(mat)

    surface.DrawPoly(self.Poly)

    surface.SetFont "team_select_text"

    local text = "Meme"

    local left, right = self:GetLeftRightAt(h / 2)

    local textw, texth = surface.GetTextSize(text)


    surface.SetTextPos((right + left) / 2 - textw / 2, h / 2 - texth / 2)

    surface.DrawText(text)
end

function PANEL:OnClick()
    self:DoClick()
end

function PANEL:DoClick()
end
