
 function BrockProgressOptionsFrame_OnLoad(panel)
        
        -- Set the name for the Category for the Panel
        --
        panel.name = "BP Options ";
        -- When the player clicks okay, run this function.
        --
--        panel.okay = function (self) SC_ChaChingPanel_Close(); end;

        -- When the player clicks cancel, run this function.
        --
  --      panel.cancel = function (self)  SC_ChaChingPanel_CancelOrLoad();  end;

        -- Add the panel to the Interface Options
        --
		panel.okay = function (self) print("MyAddOnSettings: Okay clicked") end

	-- When the player clicks cancel, run this function.
	    panel.cancel = function (self) print("MyAddOnSettings: Cancel clicked.") end   
		
		 local frame = CreateFrame("CheckButton", "UICheckButtonTemplateTest", panel, "UICheckButtonTemplate")
		 frame:ClearAllPoints()
		 frame:SetPoint("CENTER", 0, 0)
		 frame:SetText("Example checkbutton")
		
        InterfaceOptions_AddCategory(panel);
		ChatFrame1:AddMessage("BrockProgress:options frame loaded added")
    end