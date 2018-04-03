	--------------------------------------------------------------------
--	Color de alterar para modificar la interfaz por defecto - de Aprikot
	--------------------------------------------------------------------
	
--	Configuracion
	-------------
	local topcolor = {  	-- Parte superior de la gradiente de color (RGB)
    	r = 0.3,
		g = 0.3,
		b = 0.3,
	}

	local topalpha = 1.0	-- Top transparencia
	
	-- Cargar Gestion del Tiempo (boton del reloj de color)
	if not IsAddOnLoaded("Blizzard_TimeManager") then
		LoadAddOn("Blizzard_TimeManager")
	end
	
--	Objetos alterados
	-----------------
	local objects = {
	
		-- Carcasa de la unidad
		PlayerFrameTexture,
		PetFrameTexture,
		--TargetFrameTextureFrameTexture,
		--FocusFrameTextureFrameTexture,
		--TargetFrameToTTextureFrameTexture,
		--FocusFrameToTTextureFrameTexture,
	
		-- Minimap
        MiniMapBattlefieldBorder,
        MiniMapLFGFrameBorder,
		MinimapBackdrop,
		MinimapBorder,
		MiniMapMailBorder,
		MiniMapTrackingButtonBorder,
		MinimapBorderTop,
		MinimapZoneTextButton,
		MiniMapWorldMapButton,
		MiniMapWorldMapButton,
		MiniMapWorldIcon,
		MinimapZoomIn:GetRegions(),
		select(3, MinimapZoomIn:GetRegions()),
		MinimapZoomOut:GetRegions(),
		select(3, MinimapZoomOut:GetRegions()),
		TimeManagerClockButton:GetRegions(),
		MiniMapWorldMapButton:GetRegions(),
		select(6, GameTimeFrame:GetRegions()),
		
		-- Barra de accion
		MainMenuBarTexture0,
		MainMenuBarTexture1,
		MainMenuBarTexture2,
		MainMenuBarTexture3,
		MainMenuXPBarTextureRightCap,
		MainMenuXPBarTextureMid,
		MainMenuXPBarTextureLeftCap,
		ActionBarUpButton:GetRegions(),
		ActionBarDownButton:GetRegions(),

		-- Boton de Chat
		select(2, FriendsMicroButton:GetRegions()),
		ChatFrameMenuButton:GetRegions(),
		ChatFrame1ButtonFrameUpButton:GetRegions(),
		ChatFrame1ButtonFrameDownButton:GetRegions(),
		select(2, ChatFrame1ButtonFrameBottomButton:GetRegions()),
		ChatFrame2ButtonFrameUpButton:GetRegions(),
		ChatFrame2ButtonFrameDownButton:GetRegions(),
		select(2, ChatFrame2ButtonFrameBottomButton:GetRegions()),
  		
		-- Barra de cast
		select(2,CastingBarFrame:GetRegions()),
		select(2,MirrorTimer1:GetRegions()),
		CastingBarFrameBorder,
		FocusFrameSpellBarBorder,
		TargetFrameSpellBarBorder,
        
	}
	


--  Colorea Todo
	----------------------------
   
	local exec = function()
		for i,v in pairs(objects) do
			if v:GetObjectType() == "Texture" then
				v:SetDesaturated(1)
				v:SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)
			end
		end
	end
	exec()

--  Colorea Griffos
	----------------------------
	MainMenuBarLeftEndCap:SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)
	MainMenuBarRightEndCap:SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)

	