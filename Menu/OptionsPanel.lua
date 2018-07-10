--******************************
--*** SIMPLEUI PANEL OPTIONS ***
--******************************

------------------------------------------------------------------------------------------
-- INIT PANEL
------------------------------------------------------------------------------------------

SET_TITLE = GetAddOnMetadata("SimpleUI", "Title")
SET_VERSION = GetAddOnMetadata("SimpleUI", "Version")
SET_AUTHOR = GetAddOnMetadata("SimpleUI", "Author")
SET_NOTES = GetAddOnMetadata("SimpleUI", "Notes")

WidgetArray ={};

-- ***********************************
-- *** Widget Panel Initialitation ***
-- ***********************************
function SUI_PanelOnLoad(frame)
		
	frame.name = GetAddOnMetadata("SimpleUI", "Title");
	InterfaceOptions_AddCategory(frame);
	
	WidgetArray[1]=_G["OptionsPanelCheckButton"..1]		-- HideBagButtons
	WidgetArray[2]=_G["OptionsPanelCheckButton"..2]		-- HideMicroButtons
	WidgetArray[31]=_G["OptionsPanelSlider"..31]		-- Slider: Fade bags and microbuttons 
	WidgetArray[32]=_G["OptionsPanelSlider"..32]		-- Slider: Position bags and microbuttons
	WidgetArray[4]=_G["OptionsPanelCheckButton"..4]		-- QTmovable
	WidgetArray[41]=_G["OptionsPanelCheckButton"..41]	-- QTfadeandresize
	WidgetArray[5]=_G["OptionsPanelCheckButton"..5]		-- CustomChat
	WidgetArray[6]=_G["OptionsPanelCheckButton"..6]		-- HideOrderHallCommandBar

end

------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------

-- **************************
-- *** Widget Panel Check ***
-- **************************
function SUI_CheckPanel()

	--getglobal("OptionsPanelCheckButton1"):SetChecked(true);
	--getglobal(WidgetArray[1]:GetName()):SetChecked(true);
	--print(WidgetArray[1]:GetName());
	
	-- *** HIDEBABUTTONS
	getglobal(WidgetArray[1]:GetName()):SetChecked(SUI_CONFIG.HideBagButtons);
	
	-- *** HIDEMICROBUTTONS
	getglobal(WidgetArray[2]:GetName()):SetChecked(SUI_CONFIG.HideMicroButtons);
	
	-- *** SLIDER FADE
	--getglobal(WidgetArray[31]:GetName()).scrollStep = 0.1
	getglobal(WidgetArray[31]:GetName()):SetMinMaxValues(0,1);
	getglobal(WidgetArray[31]:GetName()):SetValue(SUI_CONFIG.mb_alpha);	
	getglobal(WidgetArray[31]:GetName()):SetValueStep(0.1);
	getglobal(WidgetArray[31]:GetName().."Low"):SetText("0");
	getglobal(WidgetArray[31]:GetName().."High"):SetText("1");
	--getglobal(WidgetArray[31]:GetName().."Text"):SetFormattedText(mb_alpha,value);

	-- *** SLIDER POSITION
	--slider_max = GetScreenWidth();
	getglobal(WidgetArray[32]:GetName()):SetMinMaxValues(0,math.floor(GetScreenWidth()));
	getglobal(WidgetArray[32]:GetName()):SetValue(SUI_CONFIG.mb_position);
	getglobal(WidgetArray[32]:GetName()):SetValueStep(1);
	getglobal(WidgetArray[32]:GetName().."Low"):SetText("0");
	getglobal(WidgetArray[32]:GetName().."High"):SetText(math.floor(GetScreenWidth()));
	--getglobal(WidgetArray[32]:GetName().."Text"):SetFormattedText(math.floor(slider_max),value);
	
	-- *** QT MOV
	getglobal(WidgetArray[4]:GetName()):SetChecked(SUI_CONFIG.QTmovable);
	-- *** QT RESIZE
	getglobal(WidgetArray[41]:GetName()):SetChecked(SUI_CONFIG.QTfadeandresize);
	
	-- *** CUSTOMCHAT
	getglobal(WidgetArray[5]:GetName()):SetChecked(SUI_CONFIG.CustomChat);
	
	-- *** HIDEORDERHALLCOMMANDBAR
	getglobal(WidgetArray[6]:GetName()):SetChecked(SUI_CONFIG.HideOrderHallCommandBar);	
	
	
	--print("VALORES EN LOADMENU: ", SUI_CONFIG)

end

function printData()
	print("HideBagButtons ",SUI_CONFIG.HideBagButtons)
	print("HideMicroButtons ",SUI_CONFIG.HideMicroButtons)
	print("QTmovable ",SUI_CONFIG.QTmovable)
	print("QTfadeandresize ",SUI_CONFIG.QTfadeandresize)
	print("CustomChat ",SUI_CONFIG.CustomChat)
	print("OrderHallCommandBar ",SUI_CONFIG.HideOrderHallCommandBar)
	print("end print data")
end

