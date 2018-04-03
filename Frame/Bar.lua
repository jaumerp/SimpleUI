--**************************************************
--*** Improved UI and Reduced Action Bar (by JB) ***
--**************************************************

------------------------------------------------------------------------------------------
--VARIABLES
------------------------------------------------------------------------------------------

-- Collecting Addon Info
SUI_INFO = {};
SUI_INFO.nombre = GetAddOnMetadata("SimpleUI", "Title")
SUI_INFO.version = GetAddOnMetadata("SimpleUI", "Version")
SUI_INFO.autor = GetAddOnMetadata("SimpleUI", "Author")
SUI_INFO.notas = GetAddOnMetadata("SimpleUI", "Notes")

-- Saved Defaults Variables
SUI_CONFIG_DEFAULT = {
	HideMicroButtons = false,	-- true or false to hide/show MicroButtons
	HideBagButton = false,		-- true or false to hide Bagbuttons
	PosPetFrame = 1,			-- 1,2 for different PetBar positions
	QTmovable = true,			-- Set the Quest Tracker movable by the user
	QTpos ={x=0,y=25},
	JBtweaks = false,			-- Some tweaks for personal config.
	CustomChat = false,			-- Customized Chat: Relocate the ChatFrameEditBox to the top of the chat.
	HideOrderHallCommandBar = true	-- true or false to hide/show OrderHallCommandBar 
}


------------------------------------------------------------------------------------------
--SLASH COMMANDS
------------------------------------------------------------------------------------------

function SUI_SlashCommands(msg)
	msg = strlower(msg);
	local cmd, arg1, arg2 = msg:match("(%w+)[ ]?(%w*)[ ]?(%w*)") -- <at least 1 text> <zero or more text> <zero or more text>
	
	if (cmd == "default") or (cmd == "defaults") or (cmd == "def")  then
		SUI_CONFIG=SUI_CONFIG_DEFAULT;
		print(SUI_INFO.nombre," |cffB18904/reload|r to DEFAULTS");
		
	elseif (cmd == "bags") then
		SUI_CONFIG.HideBagButton = not SUI_CONFIG.HideBagButton;
		HideBagButtons(SUI_CONFIG.HideBagButton );	
		print("HideBagButton set to",SUI_CONFIG.HideBagButton);
		
	elseif (cmd == "microbuttons") or (cmd == "mb")  then
		SUI_CONFIG.HideMicroButtons = not SUI_CONFIG.HideMicroButtons;
		MoveMicroButtons(SUI_CONFIG.HideMicroButtons);
		print("HideMicroButtons set to",SUI_CONFIG.HideMicroButtons);
		
	elseif (cmd == "petframe") then
		if (SUI_CONFIG.PosPetFrame == 1) then SUI_CONFIG.PosPetFrame=2; --else SUI_CONFIG.PosPetFrame=1 end
		elseif (SUI_CONFIG.PosPetFrame == 2) then SUI_CONFIG.PosPetFrame=1;
		end
		RelocatePetBar(SUI_CONFIG.PosPetFrame);
		print("PosPetFrame set to Position",SUI_CONFIG.PosPetFrame);
		
	elseif (cmd == "qtmov") then
		SUI_CONFIG.QTmovable = not SUI_CONFIG.QTmovable
		MoveObjectiveFrames(SUI_CONFIG.QTmovable);
		print("QTmovable set to ",SUI_CONFIG.QTmovable);
		
	elseif (cmd == "customchat") or (cmd == "cchat")  then
		SUI_CONFIG.CustomChat = not SUI_CONFIG.CustomChat
		print("Custom Chat set to ",SUI_CONFIG.CustomChat);	
		print(SUI_INFO.nombre," |cffB18904/reload|r to CustomChat takes effect");
		
	elseif (cmd == "jb") then
		SUI_CONFIG.JBtweaks = not SUI_CONFIG.JBtweaks
		print("JBtweaks set to ",SUI_CONFIG.JBtweaks);
		print(SUI_INFO.nombre," |cffB18904/reload|r to JBtweaks takes effect");
	
	elseif (cmd == "ohcb") or (cmd == "cb")  then
		SUI_CONFIG.HideOrderHallCommandBar = not SUI_CONFIG.HideOrderHallCommandBar;
		HideOrderHallCommandBar(SUI_CONFIG.HideOrderHallCommandBar);
		print("HideOrderHallCommandBar set to ",SUI_CONFIG.HideOrderHallCommandBar);
		print(SUI_INFO.nombre," |cffB18904/reload|r to OrderHallCommandBar takes effect");
		
	else
		print(SUI_INFO.nombre,"|cffB18904 Usage:|r /sui <command>");
		print(SUI_INFO.nombre,"|cffB18904 List of commands:|r default or def, qtmov, petframe, bags, microbuttons or mb, customchat or cchat, jb, ohcb or cb");
	end
	SUI_LoadMenu();
end

SLASH_SIMPLEUI1 = "/sui";
SLASH_SIMPLEUI2 = "/simpleui";
SlashCmdList["SIMPLEUI"] = SUI_SlashCommands

------------------------------------------------------------------------------------------
--FUNCTIONS
------------------------------------------------------------------------------------------

function ColoringItems()

	local topcolor = {
		r = 0.3,
		g = 0.3,
		b = 0.3,
	}
	local topalpha = 1.0

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

		--Boton de Chat
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
	
	for i,v in pairs(objects) do
		if v:GetObjectType() == "Texture" then
			v:SetDesaturated(1)
			v:SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)
		end
	end
	
	
	MainMenuBarLeftEndCap:SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)
	MainMenuBarRightEndCap:SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)


end


-- ***Hide some ActionBar Items
function HideActionBarItems()
		
	local itemAccionBar = {
		ActionBarUpButton,		-- BotonUp pagina barra
		ActionBarDownButton,	-- BotonDown pagina barra
		SlidingActionBarTexture0, 
		SlidingActionBarTexture1, 
		--[[
		MainMenuBarPageNumber,
		MainMenuBarLeftEndCap, 		-- Grypho left
		MainMenuBarRightEndCap, 	-- Grypho right
		MainMenuXPBarTextureLeftCap, 
		MainMenuXPBarTextureMid, 
		MainMenuXPBarTextureRightCap, 
		StanceBarLeft, 
		StanceBarMiddle, 
		StanceBarRight, 
		PossessBackground1, 
		PossessBackground2,
		]]
		ReputationWatchBar.StatusBar.WatchBarTexture0, 	--Reputacion separaciones
		ReputationWatchBar.StatusBar.WatchBarTexture1, 
		ReputationWatchBar.StatusBar.WatchBarTexture2, 
		ReputationWatchBar.StatusBar.WatchBarTexture3, 
		ReputationWatchBar.StatusBar.XPBarTexture0, 
		ReputationWatchBar.StatusBar.XPBarTexture1, 
		ReputationWatchBar.StatusBar.XPBarTexture2, 
		ReputationWatchBar.StatusBar.XPBarTexture3, 
		--MainMenuBarTexture0, -- Textura de barra pegada al Grypho
		--MainMenuBarTexture1, -- Textura de barra pegada al Grypho
		MainMenuBarTexture2, -- Algunas texturas decorativas del ActionBar
		MainMenuBarTexture3, -- Algunas texturas decorativas del ActionBar
		MainMenuMaxLevelBar0, 
		MainMenuMaxLevelBar1, 
		MainMenuMaxLevelBar2, 
		MainMenuMaxLevelBar3, 
		--[[
		MainMenuXPBarDiv1, -- Ocultar separadores sobrantes de la Barra XP 
		MainMenuXPBarDiv2, 
		MainMenuXPBarDiv3, 
		MainMenuXPBarDiv4, 
		MainMenuXPBarDiv5, 
		MainMenuXPBarDiv6, 
		MainMenuXPBarDiv7, 
		MainMenuXPBarDiv8, 
		MainMenuXPBarDiv9, 
		MainMenuXPBarDiv10,
		]]
		MainMenuXPBarDiv11, 
		MainMenuXPBarDiv12, 
		MainMenuXPBarDiv13, 
		MainMenuXPBarDiv14, 
		MainMenuXPBarDiv15, 
		MainMenuXPBarDiv16, 
		MainMenuXPBarDiv17, 
		MainMenuXPBarDiv18, 
		MainMenuXPBarDiv19,
		HonorWatchBar.StatusBar.WatchBarTexture0, 
		HonorWatchBar.StatusBar.WatchBarTexture1, 
		HonorWatchBar.StatusBar.WatchBarTexture2, 
		HonorWatchBar.StatusBar.WatchBarTexture3, 
		HonorWatchBar.StatusBar.XPBarTexture0, 
		HonorWatchBar.StatusBar.XPBarTexture1, 
		HonorWatchBar.StatusBar.XPBarTexture2, 
		HonorWatchBar.StatusBar.XPBarTexture3, 
		ArtifactWatchBar.StatusBar.WatchBarTexture0, 	--Artifact separaciones
		ArtifactWatchBar.StatusBar.WatchBarTexture1, 
		ArtifactWatchBar.StatusBar.WatchBarTexture2, 
		ArtifactWatchBar.StatusBar.WatchBarTexture3, 
		ArtifactWatchBar.StatusBar.XPBarTexture0, 
		ArtifactWatchBar.StatusBar.XPBarTexture1, 
		ArtifactWatchBar.StatusBar.XPBarTexture2, 
		ArtifactWatchBar.StatusBar.XPBarTexture3
	}

	for _, name in pairs(itemAccionBar) do
		name:SetAlpha(0);
	end

end

-- ***Ajusta y recoloca los items de la ActionBar y la PetBar
function RelocateActionBars()
		
	-- Ajusta Grifos y barras a la ActionBar principal
	MainMenuBarTexture0:SetPoint("LEFT", MainMenuBar, "LEFT", 0, 0);
    MainMenuBarTexture1:SetPoint("RIGHT", MainMenuBar, "RIGHT", 0, 0);
 	MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBar, "LEFT", 32, 0);
    MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBar, "RIGHT", -32, 0);
	MultiBarBottomRight:ClearAllPoints();
	MultiBarBottomRight:SetPoint("BOTTOMLEFT", MultiBarBottomLeft, "TOPLEFT", 0, 4);
	
	-- ***Barras de XP, Repu, Artefacto
	MainMenuBar:SetWidth(512);
	MainMenuExpBar:SetWidth(512);
	ReputationWatchBar.StatusBar:SetWidth(512);
	HonorWatchBar:SetWidth(512);
	HonorWatchBar.StatusBar:SetWidth(512);
	ArtifactWatchBar:SetWidth(512);
	ArtifactWatchBar.StatusBar:SetWidth(512);
	ArtifactWatchBar.StatusBar:SetHeight(9);
	ArtifactWatchBar.StatusBar.SetHeight = function() end
	
	-- Numero de Página
	MainMenuBarPageNumber:ClearAllPoints();
	MainMenuBarPageNumber:SetPoint("BOTTOM",MainMenuBarRightEndCap,"BOTTOM",-18,10);
	MainMenuBarPageNumber:SetAlpha(0.75);
	
	-- CastingBarFrame to the Top
	CastingBarFrame:SetFrameStrata("TOOLTIP")
		
end


-- **Ajusta la barra de las Pets en la posicion indicada por la variable PosPetFrame
function RelocatePetBar(position)
	position = SUI_CONFIG.PosPetFrame;
	PetActionBarFrame:SetAlpha(0.6);
	StanceBarFrame:SetAlpha(0.6);
	
	if MultiBarBottomRight:IsShown() and MultiBarBottomLeft:IsShown()then
		if (position == 1) then
			--PetActionBarFrame:ClearAllPoints();
			--PetActionBarFrame:SetPoint("BOTTOM", MultiBarBottomRight, "TOP",36,2)
			PetActionButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRight, "TOPLEFT", 64, 4)
			if not SUI_CONFIG.JBtweaks then
				StanceButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRight, "TOPLEFT", 0, 4)
			end
		end
		if (position == 2) then
			--PetActionBarFrame:ClearAllPoints();
			--PetActionBarFrame:SetPoint("BOTTOMLEFT", MultiBarBottomLeft, "TOPLEFT", -36, 4)
			PetActionButton1:SetPoint("BOTTOMLEFT", MultiBarBottomLeft, "TOPLEFT", 0, 4)
			if not SUI_CONFIG.JBtweaks then
				StanceButton1:SetPoint("BOTTOMLEFT", MultiBarBottomLeft, "TOPLEFT", 0, 4)
			end
		end
	end

end

-- ***MicroButtons
local MenuButtonFrames = {
	CharacterMicroButton,
	SpellbookMicroButton,
	TalentMicroButton,
	AchievementMicroButton,
	QuestLogMicroButton,
	GuildMicroButton,
	LFDMicroButton,
	CollectionsMicroButton,		-- Added for 6.x
	EJMicroButton,
	StoreMicroButton,          	-- Added for 5.x 
	MainMenuMicroButton
}
function MoveMicroButtons(hide)
	hide = SUI_CONFIG.HideMicroButtons;
	local offset=25;
	CharacterMicroButton:SetFrameStrata("LOW")
	
	for i,v in pairs(MenuButtonFrames) do
			v:ClearAllPoints();
			-- (anchor, anchorTo, relAnchor, x, y)
			v:SetPoint("BOTTOMLEFT",MainMenuBarRightEndCap,"BOTTOMRIGHT",-25+(offset*i),-1);
			v:SetScale(0.9);
			v:SetAlpha(0.4);
	end
	
	if hide then
		for i,v in pairs(MenuButtonFrames) do v:Hide(); StoreMicroButton:SetScale(0.01); end
		-- Move Bags to the bottom
		MainMenuBarBackpackButton:ClearAllPoints();
		MainMenuBarBackpackButton:SetPoint("BOTTOM",GuildMicroButton,"TOP",6,-55);
	else
		for i,v in pairs(MenuButtonFrames) do v:Show(); end
		MainMenuBarBackpackButton:ClearAllPoints();
		MainMenuBarBackpackButton:SetPoint("BOTTOM",GuildMicroButton,"TOP",6,-20);
	end
	
end


-- ***Iconos Bolsas
function HideBagButtons(hide)
	
	MainMenuBarBackpackButton:ClearAllPoints();
	if not SUI_CONFIG.HideMicroButtons then
		MainMenuBarBackpackButton:SetPoint("BOTTOM",GuildMicroButton,"TOP",6,-20);
	else 
		MainMenuBarBackpackButton:SetPoint("BOTTOM",GuildMicroButton,"TOP",6,-55);
	end
	MainMenuBarBackpackButton:SetScale(0.9);
	MainMenuBarBackpackButton:SetAlpha(0.4);
	for i = 0, 3 do
		_G["CharacterBag"..i.."Slot"]:SetScale(0.9);
		_G["CharacterBag"..i.."Slot"]:SetAlpha(0.4);
	end

	if hide then
		MainMenuBarBackpackButton:Hide();
		CharacterBag0Slot:Hide();
		CharacterBag1Slot:Hide();
		CharacterBag2Slot:Hide();
		CharacterBag3Slot:Hide();
	else
		MainMenuBarBackpackButton:Show();
		CharacterBag0Slot:Show();
		CharacterBag1Slot:Show();
		CharacterBag2Slot:Show();
		CharacterBag3Slot:Show();
	end

end

-- ***Battle.net Popup Message and Button
function MoveBnetFrame()
	
	local x = -40
	local y = 100

	--don't cut the toastframe
	BNToastFrame:SetClampedToScreen(true)
	BNToastFrame:SetClampRectInsets(-15,15,15,-15)
	
	-- POPUP MESSAGE Battle.net
	BNToastFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints();
		self:SetPoint("BOTTOM", ChatFrameMenuButton, "TOP", x, y);
	end);
	BNToastFrameClickFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints();
		self:SetPoint("BOTTOM", ChatFrameMenuButton, "TOP", x, y);
	end);
	BNToastFrameGlowFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints();
		self:SetPoint("BOTTOM", ChatFrameMenuButton, "TOP", x, y);
	end);
	QuickJoinToastButton.Toast:HookScript("OnShow", function(self)
		self:ClearAllPoints();
		self:SetPoint("BOTTOM", ChatFrameMenuButton, "TOP", x, y);
	end);
	QuickJoinToastButton.Toast2:HookScript("OnShow", function(self)
		self:ClearAllPoints();
		self:SetPoint("BOTTOM", ChatFrameMenuButton, "TOP", x, y);
	end);
	

	-- BUTTON FRAME Battle.net
	QuickJoinToastButton:ClearAllPoints();
	QuickJoinToastButton:SetPoint("BOTTOMRIGHT",MainMenuBarLeftEndCap,"BOTTOMLEFT",5,-1);
	--SetFrameStrata: BACKGROUND,LOW,MEDIUM,HIGH,DIALOG,FULLSCREEN,FULLSCREEN_DIALOG,TOOLTIP
	--QuickJoinToastButton:SetFrameStrata("HIGH")
	--QuickJoinToastButton:SetScale(0.9)
	QuickJoinToastButton:SetAlpha(0.5)
	-- Fuerza a mostrar el boton (por si algun chat-addon lo quita)
	QuickJoinToastButton:UnregisterAllEvents()
	QuickJoinToastButton:SetScript("OnHide", QuickJoinToastButton.Show)
	QuickJoinToastButton:Show()
	--UIParent:UnregisterEvent("UNIT_AURA")
	
end


function EditChatFrame(customChat)
	-- NUM_CHAT_WINDOWS
	if customChat then
		for i = 1, 19 do

			cf = _G["ChatFrame"..i]
			cfeb = _G["ChatFrame"..i.."EditBox"]
			cft = _G["ChatFrame"..i.."Tab"]
				
			--SETUP the ChatFrame
			cf:SetClampedToScreen(false);
			cf:SetClampRectInsets(0, 0, 0, -5)	--sujeta los frames dentro de unos margenes
			cf:SetMaxResize(0,0) 				--fully scalable
			cf:SetMinResize(200, 100)			--min. size
		
			if SUI_CONFIG.JBtweaks then
			-- Fija el Chat con el tamaño y posicion indicados por defecto
			--cf:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 37, 6) -- 30, 5
			--cf:SetSize(440,168)
			cf:SetHeight(168)
			end
			
			--MOVE EditBox to the Top chatFrame
			cfeb:ClearAllPoints();
			cfeb:SetPoint("BOTTOMLEFT", cft, "TOPLEFT", 0, -10)
			cfeb:SetWidth(420)
			--HIDE EditBox Textures
		  _G["ChatFrame"..i.."EditBoxLeft"]:Hide()
		  _G["ChatFrame"..i.."EditBoxMid"]:Hide()
		  _G["ChatFrame"..i.."EditBoxRight"]:Hide()
		end
	end

end


-- ***Quest Tracking: Fit,Move,Fade,Scale.
function MoveObjectiveFrames(move)

	wf = ObjectiveTrackerFrame
	wf:SetClampedToScreen(false) -- hace que el frame pueda salirse del padre (si es true, no puede salir)
	wf:SetHeight(800)
	wf:ClearAllPoints()
	wf.ClearAllPoints = function() end
	
	if SUI_CONFIG.QTpos.x == 0 then
	wf:SetPoint("TOPRIGHT", MinimapBackdrop, "BOTTOMRIGHT", SUI_CONFIG.QTpos.x, SUI_CONFIG.QTpos.y)
	else
	wf:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", SUI_CONFIG.QTpos.x, SUI_CONFIG.QTpos.y)
	end
	
	wf.SetPoint = function() end
	--Fade and Scale QuestTracker
	if SUI_CONFIG.JBtweaks then
		wf:SetAlpha(0.8);
		wf:SetScale(0.9);
	end
	
	-- Move Quest Tracker Frame function
	local function Moveit(f)
		f:EnableMouse(true)
		f:RegisterForDrag("LeftButton")
		--f:SetHitRectInsets(-15, -15, -5, -5)
		f:SetScript("OnDragStart", function(s)
			wf:StartMoving()
		end)
		f:SetScript("OnDragStop", function(s)
			wf:StopMovingOrSizing()
			SUI_CONFIG.QTpos.x = wf:GetRight()
			SUI_CONFIG.QTpos.y = wf:GetTop()
		end)
	end
	
	wf:SetMovable(true)
	wf:SetUserPlaced(true)
	Moveit(ObjectiveTrackerBlocksFrame.QuestHeader)
	Moveit(ObjectiveTrackerBlocksFrame.ScenarioHeader)
	Moveit(ObjectiveTrackerBlocksFrame.AchievementHeader)
	
	if not move then
		wf:SetMovable(false)
	end
	
end


-- ***Show quest color and level
local function Showlevel()
	if ENABLE_COLORBLIND_MODE == "1" then return end
	local numEntries = GetNumQuestLogEntries()
	local titleIndex = 1
	for i = 1, numEntries do
		local title, level, _, isHeader, _, isComplete, frequency, questID = GetQuestLogTitle(i)
		local titleButton = QuestLogQuests_GetTitleButton(titleIndex)
		if title and (not isHeader) and titleButton.questID == questID then
			titleButton.Check:SetPoint("LEFT", titleButton.Text, titleButton.Text:GetWrappedWidth() + 2, 0)
			titleIndex = titleIndex + 1
			local text = "["..level.."] "..title
			if isComplete then
				text = "|cffff78ff"..text
			elseif frequency == 2 then
				text = "|cff3399ff"..text
			end
			titleButton.Text:SetText(text)
		end
	end
end
hooksecurefunc("QuestLogQuests_Update", Showlevel)


-- ***Personal Tweaks
function PersonalTweaks()

	--Trasparenta el boton5 para poner la montura secundaria
	MultiBarBottomRightButton5:SetAlpha(0.2);
	PetName:Hide();
	
end

--***Order Hall CommandBar
function HideOrderHallCommandBar()
	--print("HideOrderHallCommandBar:",SUI_CONFIG.HideOrderHallCommandBar)
	if SUI_CONFIG.HideOrderHallCommandBar then 
		hooksecurefunc("OrderHall_CheckCommandBar",
		function()
			if OrderHallCommandBar then
				OrderHallCommandBar:Hide()
			end
		end)
	end
	
end




------------------------------------------------------------------------------------------
--REGISTERED EVENTS & EVENT HANDLER
------------------------------------------------------------------------------------------
function SUI_RegisteredEvents(self)
	-- Unregister events
	--self:UnregisterEvent("PLAYER_REGEN_ENABLED");
	--self:UnregisterAllEvents();
	
	-- Register for events
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("ADDON_LOADED");
	
	self:RegisterEvent("CHAT_MSG_WHISPER");
	self:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
	self:RegisterEvent("CHAT_MSG_BN_WHISPER");
	self:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM");
	
end


function SUI_EventHandler(self, event, ...)
	-- Esta funcion salta cada vez que se registra un evento de los declarados en SUI_RegisteredEvents
	-- Para definir una accion concreta en funcion del evento, usar el IF
	
	if ( event == "CHAT_MSG_WHISPER" ) or ( event == "CHAT_MSG_WHISPER_INFORM" ) or ( event == "CHAT_MSG_BN_WHISPER" ) or ( event == "CHAT_MSG_BN_WHISPER_INFORM" ) then
		EditChatFrame(SUI_CONFIG.CustomChat);
	end
	
	if ( event == "PLAYER_ENTERING_WORLD" ) then
	
		-- Load SimpleUI Modules
		SUI_LoadAddon();
		--SUI_LoadMenu();
	
	end

	if ( event == "ADDON_LOADED" ) then				

		-- If SavedVariables file doesn't exist, create it.
		if SUI_CONFIG == nil then 
			SUI_CONFIG=SUI_CONFIG_DEFAULT;
			print(SUI_INFO.nombre..": LOADED DEFAULTS");
		end
		
		-- Hides OrderHallCommandBar if Checked
		HideOrderHallCommandBar();
		-- Load Options Panel
		SUI_LoadMenu();
		
		self:UnregisterEvent("ADDON_LOADED");
	end

end

------------------------------------------------------------------------------------------
--LAUNCHER & FUNCTION LOADER
------------------------------------------------------------------------------------------

function SUI_LoadAddon()

	if SUI_CONFIG.JBtweaks then
		--MoveBnetFrame();
		PersonalTweaks();
		--vars
		SUI_CONFIG.HideBagButton = true;
		SUI_CONFIG.HideMicroButtons = false;
		--SUI_CONFIG.PosPetFrame = 2;
		SUI_CONFIG.QTmovable = false;
		SUI_CONFIG.CustomChat = true;
		SUI_CONFIG.HideOrderHallCommandBar = true;
		SUI_LoadMenu()
	end
	
	--AÑADIR FUNCIONES AQUI
	HideActionBarItems();
	RelocateActionBars();
	RelocatePetBar(SUI_CONFIG.PosPetFrame);
	MoveMicroButtons(SUI_CONFIG.HideMicroButtons);
	HideBagButtons(SUI_CONFIG.HideBagButton);
	MoveObjectiveFrames(SUI_CONFIG.QTmovable);
	EditChatFrame(SUI_CONFIG.CustomChat);
	--ColoringItems();
	--FIN AÑADIR FUNCIONES
	collectgarbage();

	
end

print(SUI_INFO.nombre," |cff00ff00v."..SUI_INFO.version," |cffB18904Loaded.|r For more info write |cffB18904/sui");

