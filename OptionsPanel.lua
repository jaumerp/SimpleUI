--******************************
--*** SIMPLEUI PANEL OPTIONS ***
--******************************

------------------------------------------------------------------------------------------
--INIT PANEL
------------------------------------------------------------------------------------------

SET_NOM = GetAddOnMetadata("SimpleUI", "Title")
SET_VERSIO = GetAddOnMetadata("SimpleUI", "Version")
SET_AUTOR = GetAddOnMetadata("SimpleUI", "Author")
SET_NOTES = GetAddOnMetadata("SimpleUI", "Notes")

WidgetArray ={}

function SUI_PanelOnLoad(frame)
		
	frame.name = GetAddOnMetadata("SimpleUI", "Title")
	InterfaceOptions_AddCategory(frame)
	
	WidgetArray[1]=_G["OptionsPanelCheckButton"..1]
	WidgetArray[2]=_G["OptionsPanelCheckButton"..2]
	WidgetArray[4]=_G["OptionsPanelCheckButton"..4]
	WidgetArray[5]=_G["OptionsPanelCheckButton"..5]
	WidgetArray[6]=_G["OptionsPanelCheckButton"..6]
	WidgetArray[7]=_G["OptionsPanelCheckButton"..7]
	WidgetArray[3]=_G["OptionsPanelDropDown_PetFrame"]
end

function SUI_LoadMenu()

	-- 1.BAGS, 2.MICROBUTTONS, 3.PETFRAME, 4.QTMOV, 5.CUSTOM CHAT, 6.JB TWEAKS, 7.ORDERHALLCOMMANDBAR
	WidgetArray[1]:SetChecked(SUI_CONFIG.HideBagButton);
	WidgetArray[2]:SetChecked(SUI_CONFIG.HideMicroButtons);
	WidgetArray[4]:SetChecked(SUI_CONFIG.QTmovable);
	WidgetArray[5]:SetChecked(SUI_CONFIG.CustomChat);
	WidgetArray[6]:SetChecked(SUI_CONFIG.JBtweaks);
	WidgetArray[7]:SetChecked(SUI_CONFIG.HideOrderHallCommandBar);
	--WidgetArray[7]:Disable();

	WidgetArray[3].selectedName = PetFrameOptions[SUI_CONFIG.PosPetFrame];
	WidgetArray[3].selectedID = SUI_CONFIG.PosPetFrame;
	UIDropDownMenu_SetText(WidgetArray[3], PetFrameOptions[SUI_CONFIG.PosPetFrame])
	--print("VALORES EN LOADMENU: ", SUI_CONFIG)
	
end

------------------------------------------------------------------------------------------
--DROPDOWN MENU
------------------------------------------------------------------------------------------

PetFrameOptions={"Position 1","Position 2"}

local function DropDown_OnClick(self,DropDownFrame)
	UIDropDownMenu_SetSelectedID(DropDownFrame, self:GetID())
	SUI_CONFIG.PosPetFrame=self:GetID()
	--print(SUI_INFO.nombre," PetFrame set to",PetFrameOptions[SUI_CONFIG.PosPetFrame])
	RelocatePetBar(SUI_CONFIG.PosPetFrame);
end

function DropDown_Initialize(self)   
     local info = UIDropDownMenu_CreateInfo()   
     for k,v in pairs(PetFrameOptions) do   
         info = UIDropDownMenu_CreateInfo()   
         info.text = v   
         info.value = k
         info.arg1 = self
         info.func = DropDown_OnClick   
         UIDropDownMenu_AddButton(info)  
     end
end

function printData()
	print("HideBagButton ",SUI_CONFIG.HideBagButton)
	print("HideMicroButtons ",SUI_CONFIG.HideMicroButtons)
	print("PosPetFrame ",SUI_CONFIG.PosPetFrame)
	print("QTmovable ",SUI_CONFIG.QTmovable)
	print("CustomChat ",SUI_CONFIG.CustomChat)
	print("JBtweaks ",SUI_CONFIG.JBtweaks)
	print("OrderHallCommandBar ",SUI_CONFIG.HideOrderHallCommandBar)
end

