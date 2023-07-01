---
--- @author Dylan MALANDAIN
--- @version 2.0.0
--- @since 2020
---
--- RageUI Is Advanced UI Libs in LUA for make beautiful interface like RockStar GAME.
---
---
--- Commercial Info.
--- Any use for commercial purposes is strictly prohibited and will be punished.
---
--- @see RageUI
---

local GridType = RageUI.Enum {
    Default = 1,
    Horizontal = 2,
    Vertical = 3
}

local GridSprite = {
    [GridType.Default] = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", },
    [GridType.Horizontal] = { Dictionary = "RageUI_", Texture = "horizontal_grid", },
    [GridType.Vertical] = { Dictionary = "RageUI_", Texture = "vertical_grid", },
}

local Grid = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
    Grid = { X = 115.5, Y = 47.5, Width = 200, Height = 200 },
    Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
    Text = {
        Top = { X = 215.5, Y = 15, Scale = 0.35 },
        Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
        Left = { X = 57.75, Y = 130, Scale = 0.35 },
        Right = { X = 373.25, Y = 130, Scale = 0.35 },
    },
}

local function UIGridPanel(Type, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and ((CurrentMenu.Index == Index)) then
            local X = Type == GridType.Default and StartedX or Type == GridType.Horizontal and StartedX or Type == GridType.Vertical and 0.5
            local Y = Type == GridType.Default and StartedY or Type == GridType.Horizontal and 0.5 or Type == GridType.Vertical and StartedY
            local Hovered = RageUI.IsMouseInBounds(CurrentMenu.X + Grid.Grid.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Grid.Grid.Width + CurrentMenu.WidthOffset, Grid.Grid.Height)
            local Selected = false
            local CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) 
            local CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset 
            if X <= 0.0 then
                X = 0.0
            elseif X >= 1.0 then
                X = 1.0
            end
            if Y <= 0.0 then
                Y = 0.0
            elseif Y >= 1.0 then
                Y = 1.0
            end
            CircleX = CircleX + ((Grid.Grid.Width ) * X) - (Grid.Circle.Width / 2)
            CircleY = CircleY + ((Grid.Grid.Height ) * Y) - (Grid.Circle.Height / 2)
            RenderSprite(Grid.Background.Dictionary, Grid.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Grid.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Grid.Background.Width + CurrentMenu.WidthOffset, Grid.Background.Height)
            RenderSprite(GridSprite[Type].Dictionary, GridSprite[Type].Texture, CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Grid.Grid.Width, Grid.Grid.Height)
            RenderSprite(Grid.Circle.Dictionary, Grid.Circle.Texture, CircleX, CircleY, Grid.Circle.Width, Grid.Circle.Height)
            if (Type == GridType.Default) then
                RenderText(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
                RenderText(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
                RenderText(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
                RenderText(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
            end
            if (Type == GridType.Vertical) then
                RenderText(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
                RenderText(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
            end
            if (Type == GridType.Horizontal) then
                RenderText(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
                RenderText(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
            end
            if Hovered then
                if IsDisabledControlPressed(0, 24) then
                    Selected = true
                    CircleX = math.round(GetControlNormal(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (Grid.Circle.Width / 2)
                    CircleY = math.round(GetControlNormal(2, 240) * 1080) - CurrentMenu.SafeZoneSize.Y - (Grid.Circle.Height / 2)
                    if CircleX > (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + Grid.Grid.Width ) then
                        CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2)  + Grid.Grid.Width 
                    elseif CircleX < (CurrentMenu.X + Grid.Grid.X  - (Grid.Circle.Width / 2)) then
                        CircleX = CurrentMenu.X + Grid.Grid.X  - (Grid.Circle.Width / 2)
                    end
                    if CircleY > (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset  + Grid.Grid.Height ) then
                        CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset  + Grid.Grid.Height 
                    elseif CircleY < (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset  - (Grid.Circle.Height / 2)) then
                        CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset  - (Grid.Circle.Height / 2)
                    end
                    X = math.round((CircleX - (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2)) + (Grid.Circle.Width / 2)) / (Grid.Grid.Width ), 2)
                    Y = math.round((CircleY - (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset ) + (Grid.Circle.Height / 2)) / (Grid.Grid.Height ), 2)
                    if (X ~= StartedX) and (Y ~= StartedY) then
                        Action.onPositionChange(X, Y, (X * 2 - 1), (Y * 2 - 1))
                    end
                    StartedX = X;
                    StartedY = Y;
                    if X >= 1.0 then
                        X = 1.0
                    end
                    if Y >= 1.0 then
                        Y = 1.0
                    end
                end
            end
            RageUI.ItemOffset = RageUI.ItemOffset + Grid.Background.Height + Grid.Background.Y
            if Hovered and Selected then
                local Audio = RageUI.Settings.Audio
                RageUI.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
                if (Action.onSelected ~= nil) then
                    Action.onSelected(X, Y, (X * 2 - 1), (Y * 2 - 1));
                end
            end

        end
    end
end

function RageUI.Grid(StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Default, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
end

function RageUI.GridHorizontal(StartedX, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Horizontal, StartedX, nil, nil, nil, LeftText, RightText, Action, Index)
end

function RageUI.GridVertical(StartedY, TopText, BottomText, Action, Index)
    UIGridPanel(GridType.Vertical, nil, StartedY, TopText, BottomText, nil, nil, Action, Index)
end
