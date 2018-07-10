--**************************************************
--*** Improved UI and Reduced Action Bar (by JB) ***
--**************************************************

------------------------------------------------------------------------------------------
--VARIABLES
------------------------------------------------------------------------------------------

-- Collecting Addon Info
SUI_INFO = {};
SUI_INFO.title = GetAddOnMetadata("SimpleUI", "Title")
SUI_INFO.version = GetAddOnMetadata("SimpleUI", "Version")
SUI_INFO.author = GetAddOnMetadata("SimpleUI", "Author")
SUI_INFO.notes = GetAddOnMetadata("SimpleUI", "Notes")

-- Saved Defaults Variables
SUI_CONFIG_DEFAULT = {
	HideBagButtons = false,		-- true or false to hide Bagbuttons
	HideMicroButtons = false,	-- true or false to hide/show MicroButtons and BagButtons
	mb_scale = 0.8,				-- MicroButtonandBagsbar Fade and Scale variables
	mb_alpha = 0.4,
	mb_position = 0,			-- MicroButtonandBagsbar position
	QTmovable = false,			-- true or false to move/fix the Quest Tracker Panel
	QTfadeandresize = false,	-- Fade and Resize the Quest Tracker Panel
	CustomChat = false,			-- Customized Chat: Relocate the ChatFrameEditBox to the top of the chat.
	HideOrderHallCommandBar = false	-- true or false to hide/show OrderHallCommandBar 
}


------------------------------------------------------------------------------------------
--SLASH COMMANDS
------------------------------------------------------------------------------------------

function SUI_SlashCommands(msg)
	msg = strlower(msg);
	local cmd, arg1, arg2 = msg:match("(%w+)[ ]?(%w*)[ ]?(%w*)") -- <at least 1 text> <zero or more text> <zero or more text>
	
	if (cmd == "default") or (cmd == "defaults") or (cmd == "def")  then
		SUI_CONFIG=SUI_CONFIG_DEFAULT;
		print(SUI_INFO.title," |cffB18904/reload|r to DEFAULTS");
		
	elseif (cmd == "bags") then
		SUI_CONFIG.HideBagButtons = not SUI_CONFIG.HideBagButtons;
		HideBagButtons(SUI_CONFIG.HideBagButtons );	
		print("HideBagButton set to",SUI_CONFIG.HideBagButtons);
		
	elseif (cmd == "microbuttons") or (cmd == "mb")  then
		SUI_CONFIG.HideMicroButtons = not SUI_CONFIG.HideMicroButtons;
		MoveMicroButtons(SUI_CONFIG.HideMicroButtons);
		print("HideMicroButtons set to",SUI_CONFIG.HideMicroButtons);
		
	elseif (cmd == "qtmov") then
		SUI_CONFIG.QTmovable = not SUI_CONFIG.QTmovable
		print("Quest Tracker move set to ",SUI_CONFIG.QTmovable);	
		print(SUI_INFO.title," |cffB18904/reload|r to Quest Tracker takes effect");
		
	elseif (cmd == "customchat") or (cmd == "cchat")  then
		SUI_CONFIG.CustomChat = not SUI_CONFIG.CustomChat
		print("Custom Chat set to ",SUI_CONFIG.CustomChat);	
		print(SUI_INFO.title," |cffB18904/reload|r to CustomChat takes effect");
		
	elseif (cmd == "ohcb") or (cmd == "cb")  then
		SUI_CONFIG.HideOrderHallCommandBar = not SUI_CONFIG.HideOrderHallCommandBar;
		HideOrderHallCommandBar(SUI_CONFIG.HideOrderHallCommandBar);
		print("HideOrderHallCommandBar set to ",SUI_CONFIG.HideOrderHallCommandBar);
		print(SUI_INFO.title," |cffB18904/reload|r to OrderHallCommandBar takes effect");
		
	else
		print(SUI_INFO.title,"|cffB18904 Usage:|r /sui <command>");
		print(SUI_INFO.title,"|cffB18904 List of commands:|r default or def, qtmov, bags, microbuttons or mb, customchat or cchat, ohcb or cb");
	end
	SUI_CheckPanel();
end

SLASH_SIMPLEUI1 = "/sui";
SLASH_SIMPLEUI2 = "/simpleui";
SlashCmdList["SIMPLEUI"] = SUI_SlashCommands

------------------------------------------------------------------------------------------
--FUNCTIONS
------------------------------------------------------------------------------------------

-- ***********************************
-- *** BagButtons and MicroButtons ***
-- ***********************************
function setupMicroButtonandBagsbar()
	
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
	
	--BagButtons scale/alpha
	MicroButtonAndBagsBar:SetAlpha(SUI_CONFIG.mb_alpha);
	MicroButtonAndBagsBar:SetScale(SUI_CONFIG.mb_scale);
	--Microbuttons scale/alpha
	for i,v in pairs(MenuButtonFrames) do
			v:SetScale(SUI_CONFIG.mb_scale);
			v:SetAlpha(SUI_CONFIG.mb_alpha);
	end
	
	function show_all()
		MicroButtonAndBagsBar:Show();
		for i,v in pairs(MenuButtonFrames) do
			v:Show();
		end
		MicroButtonAndBagsBar:ClearAllPoints();
		MicroButtonAndBagsBar:SetPoint("RIGHT",UIParent,"BOTTOMRIGHT",SUI_CONFIG.mb_position,CharacterMicroButton:GetHeight()+8);
	end
	
	-- Show ALL
	if not SUI_CONFIG.HideBagButtons and not SUI_CONFIG.HideMicroButtons then
		show_all();
	end

	-- Show only Bags
	if not SUI_CONFIG.HideBagButtons and SUI_CONFIG.HideMicroButtons then
		show_all();
		MicroButtonAndBagsBar:SetPoint("RIGHT",UIParent,"BOTTOMRIGHT",SUI_CONFIG.mb_position,0);
	end

	-- Show only MicroButtons
	if SUI_CONFIG.HideBagButtons and not SUI_CONFIG.HideMicroButtons then
		show_all();
		MicroButtonAndBagsBar:Hide();
	end

	-- Hide all (Bags and MicroButtons)
	if SUI_CONFIG.HideBagButtons and SUI_CONFIG.HideMicroButtons then
		MicroButtonAndBagsBar:Hide();
		for i,v in pairs(MenuButtonFrames) do
				--v:ClearAllPoints();
				v:SetAlpha(0);
				v:Hide();
		end
	end
	
	--print("|cffB18904setupMicroButtonandBagsbar LOADED");
end


-- *******************
-- *** Chat Frames ***
-- *******************
function setupChatFrame()

	
	if SUI_CONFIG.CustomChat then 
		-- NUM_CHAT_WINDOWS
		for i = 1, 10 do

			cf = _G["ChatFrame"..i]
			cfeb = _G["ChatFrame"..i.."EditBox"]
			cft = _G["ChatFrame"..i.."Tab"]

			--SETUP the ChatFrame
			cf:SetClampedToScreen(false)
			cf:SetClampRectInsets(0, 0, 0, -5)		--sujeta los frames dentro de unos margenes
			cf:SetMaxResize(0,0) 					--fully scalable
			cf:SetMinResize(200, 100)				--min. size

			-- Fija el Chat con el tamaño y posicion indicados por defecto
			cf:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 37, 6) -- 30, 5
			cf:SetSize(440,168)
			cf:SetHeight(168)

			--MOVE EditBox to the Top chatFrame
			cfeb:ClearAllPoints()
			cfeb:SetPoint("BOTTOMLEFT", cft, "TOPLEFT", 0, -10)
			cfeb:SetWidth(420)
			--HIDE EditBox Textures
			_G["ChatFrame"..i.."EditBoxLeft"]:Hide()
			_G["ChatFrame"..i.."EditBoxMid"]:Hide()
			_G["ChatFrame"..i.."EditBoxRight"]:Hide()
			
		end
	end 


	--print("|cffB18904setupChatFrame LOADED");


end


-- ******************************************
-- ***Quest Tracking: Fit,Move,Fade,Scale ***
-- ******************************************
function setupObjectiveFrames()

	wf = ObjectiveTrackerFrame
	wf:SetMovable(true)
	wf:SetUserPlaced(true)
	wf:SetFrameStrata("HIGH")

	if SUI_CONFIG.QTmovable then
		--Move Quest Tracker Frame function
		function Moveit(f)
			f:EnableMouse(true)
			f:RegisterForDrag("LeftButton")
			f:SetScript("OnDragStart", function(s)
				wf:StartMoving()
			end)
			f:SetScript("OnDragStop", function(s)
				wf:StopMovingOrSizing()
			end)
		end
	else	
		--Fix Quest Tracker Frame function
		function Moveit(f)
			f:EnableMouse(false)
		end		
	end
	
	Moveit(ObjectiveTrackerBlocksFrame.QuestHeader)
	Moveit(ObjectiveTrackerBlocksFrame.ScenarioHeader)
	Moveit(ObjectiveTrackerBlocksFrame.AchievementHeader)

	--Fade and Scale QuestTracker
	if SUI_CONFIG.QTfadeandresize then
		wf:SetAlpha(0.8);
		wf:SetScale(0.9);
	else 
		wf:SetAlpha(1);
		wf:SetScale(1);
	end
	
	--print("|cffB18904setupObjectiveFrames LOADED");

end


-- *****************************
-- *** Order Hall CommandBar ***
-- *****************************
function HideOrderHallCommandBar()

	if SUI_CONFIG.HideOrderHallCommandBar then 
		hooksecurefunc("OrderHall_CheckCommandBar",
		function()
			if OrderHallCommandBar then
				OrderHallCommandBar:Hide()
			end
		end)
	end
	
	--print("|cffB18904HideOrderHallCommandBar LOADED");
	
end




------------------------------------------------------------------------------------------
--REGISTERED EVENTS & EVENT HANDLER
------------------------------------------------------------------------------------------
function SUI_RegisteredEvents(self)
	-- Unregister events
	--self:UnregisterAllEvents();
	
	-- Register for events
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("ADDON_LOADED");

	
end


function SUI_EventHandler(self, event, ...)
	-- Esta funcion salta cada vez que se registra un evento de los declarados en SUI_RegisteredEvents
	-- Para definir una accion concreta en funcion del evento, usar el IF
	
	-- AddOns that want to do one-time initialization procedures once the player has "entered the world" should use this event
	if ( event == "PLAYER_LOGIN" ) then
	end
	
	-- Saved variables for one addon a time are loaded and executed, then ADDON_LOADED event is fired for that addon.
	-- VARIABLES_LOADED event is fired to let addons know that all saved variables were loaded.
	if ( event == "ADDON_LOADED" ) then				

		-- If SavedVariables file doesn't exist, create it.
		if SUI_CONFIG == nil then 
			SUI_CONFIG=SUI_CONFIG_DEFAULT;
			print(SUI_INFO.title,": LOADED DEFAULTS");
		end
				
		-- Load SimpleUI Modules
		setupMicroButtonandBagsbar();
		setupObjectiveFrames();
		setupChatFrame();
		HideOrderHallCommandBar();

		-- Setup SimpleUI Option Panel
		SUI_CheckPanel();
		
		collectgarbage();
		print(SUI_INFO.title," |cff00ff00v."..SUI_INFO.version," |rloaded.|r For more info type |cffB18904/sui");

		self:UnregisterEvent("ADDON_LOADED");
	end

end


-- UPDATE CODE
--local up=0;
--local SimpleUIUpdateInterval = 2; -- How often the OnUpdate code will run (in seconds)
function SUI_OnUpdate()	
--function SUI_OnUpdate(self, elapsed)	
	--up = up + elapsed; 		
	--if (up > SimpleUIUpdateInterval) then
	--OnUpdate code here
	--print(up);
	AchievementMicroButton:SetAlpha(SUI_CONFIG.mb_alpha);
	GuildMicroButton:SetAlpha(SUI_CONFIG.mb_alpha);
	--up = 0;
	--end

end


------------------------------------------------------------------------------------------
--MAIN LOADER
------------------------------------------------------------------------------------------

--local SUI_panel = CreateFrame("Frame", nil, UIParent);

--SUI_panel:SetScript('OnLoad', SUI_RegisteredEvents)
--SUI_panel:SetScript('OnEvent', SUI_EventHandler)
--SUI_panel:SetScript('OnUpdate', SUI_OnUpdate)
--SUI_panel:RegisterEvent('PLAYER_LOGIN')





