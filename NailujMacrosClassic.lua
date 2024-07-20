local addon = ...
local _, englishClass, _ = UnitClass("player")

--------------------------------------------------------------------
-- Nailuj Macros
-- ----------------
-- Creates/uses specific macros for my characters 
-- (identifying the spells according the language of the game).
--------------------------------------------------------------------

--------------------------------------------------------------------
-- List for all spells utilized for my macros
--------------------------------------------------------------------
local paladinSpells = {
	{31884, "Avenging wrath", "Cólera vengativa"},
	{6940, "Hand of sacrifice", "Mano de sacrificio"},
	{1038, "Hand of salvation", "Mano de Salvación"},
	{1022, "Hand of protection", "Mano de protección"},
	{54428, "Divine Plea", "Súplica divina"},
	{64205, "Divine Guardian", "Guardián Divino"},
	{7328, "Redemption", "Redención"},
	{62124, "Hand of Reckoning", "Mano de expiación"},
	{31789, "Righteous Defense", "Defensa recta"},
	{86150, "Guardian of Ancient Kings", "Guardián de los antiguos reyes"},
	{31850, "Ardent defender", "Defensor candente"},
	{498, "Divine Protection", "Protección divina"},
	{55428, "Lifeblood", "Sangre de vida"},
	{59542, "Gift of the naaru", "Ofrenda de los naaru"}
}

local priestSpells = {
	{2050, "Heal", "Sanar"},
	{528, "Cure Disease", "Curar enfermedad"},
	{527, "Dispel Magic", "Disipar magia"},
	{2061, "Flash heal", "Sanación relámpago"},
	{2060, "Greater Heal", "Sanación superior"},
	{32375, "Mass Dispel", "Disipación en masa"},
	{33076, "Prayer of Mending", "Rezo de alivio"},
	{17, " Power Word: Shield", "Palabra de poder: escudo"},
	{139, "Renew", "Renovar"}
}


--------------------------------------------------------------------
-- Create or update global macro
--------------------------------------------------------------------
function updateMacroNailuj(name,icon,src)
	if not InCombatLockdown() then
		local macroIndex = GetMacroIndexByName(name)
		local content = "#showtooltip " .. "\n" .. src;
		if macroIndex > 0 then
			EditMacro(macroIndex, name, icon, content)
		else
			CreateMacro(name, icon, content, 1)
		end
	end
end

--------------------------------------------------------------------
-- Core methods
--------------------------------------------------------------------

function chooseSpellByLanguage(spells, index)
	if GetLocale() == "esES" then
		return spells[index][3]
	end
	return spells[index][2]
end

function createCustomMacroNailuj(button, spells, pos, name, body)
	local button = CreateFrame("Button", button, nil,  "SecureActionButtonTemplate")
	button:RegisterEvent("PLAYER_ENTERING_WORLD")
	button:RegisterEvent("UNIT_SPELLCAST_STOP")
	button:RegisterForClicks("LeftButtonDown", "LeftButtonUp" )
	button:SetAttribute("type","macro")
	button:SetScript("OnEvent", function(self,event, arg1)
			if not InCombatLockdown() then
				if event == "PLAYER_ENTERING_WORLD" then
					local _, _, icon, _, _, _, _, _ = GetSpellInfo(spells[pos][1])
					updateMacroNailuj(name, icon, body)
				end
				if event == "UNIT_SPELLCAST_STOP" and arg1 == "player" then
					local _, _, icon, _, _, _, _, _ = GetSpellInfo(spells[pos][1])
					updateMacroNailuj(name, icon, body)
				end
			end
		end)
end

--------------------------------------------------------------------
-- Creating paladin macros
--------------------------------------------------------------------
if englishClass == "PALADIN" then
	createCustomMacroNailuj("paladinArdentDefenderButton", paladinSpells, 11, "Ardent defender", "/use 13 \n/use 14 \n" .. "/use [@player] " .. chooseSpellByLanguage(paladinSpells, 11))
	createCustomMacroNailuj("paladinAvengingWrathButton", paladinSpells, 1, "Avenging wrath", "/use " .. chooseSpellByLanguage(paladinSpells, 1) .. "\n/use " .. chooseSpellByLanguage(paladinSpells, 13) .. "\n/use 14\n/y LET FLY!")
	createCustomMacroNailuj("paladinBlessOfSacrificeButton", paladinSpells, 2, "B of sacrifice", "/use [@mouseover] " .. chooseSpellByLanguage(paladinSpells, 2))
	createCustomMacroNailuj("paladinBlessOfSalvationButton", paladinSpells, 3, "B of salvation", "/use [@mouseover] " .. chooseSpellByLanguage(paladinSpells, 3))
	createCustomMacroNailuj("paladinBlessOfProtectionButton", paladinSpells, 4, "B of protection", "/use [@mouseover] " .. chooseSpellByLanguage(paladinSpells, 4))
	createCustomMacroNailuj("paladinDivinePleaButton", paladinSpells, 5, "Divine plea", "/use " .. chooseSpellByLanguage(paladinSpells, 5) .. "\n/y FOCUS FIRE!!!")
	createCustomMacroNailuj("paladinDivineProtectionButton", paladinSpells, 12, "Divine protection", "/use 14 \n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 12))
	createCustomMacroNailuj("paladinAreaDefensiveButton", paladinSpells, 10, "Divine guardian", "/use ".. chooseSpellByLanguage(paladinSpells, 6) .." \n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 10))
	createCustomMacroNailuj("paladinTauntButton", paladinSpells, 8, "Taunt", "/use [nomod:alt] " ..chooseSpellByLanguage(paladinSpells, 8) .. " ; [mod:alt] " .. chooseSpellByLanguage(paladinSpells, 9))
	createCustomMacroNailuj("paladinRedemptionButton", paladinSpells, 7, "Revive single", "/use " .. chooseSpellByLanguage(paladinSpells, 7) .. "\n/s Reviviendo al manco de %t xD")
	createCustomMacroNailuj("paladinOffHealButton", paladinSpells, 13, "Off heal", "/use [@player] " .. chooseSpellByLanguage(paladinSpells, 14) .. "\n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 13))
end

--------------------------------------------------------------------
-- Creating priest macros
--------------------------------------------------------------------
if englishClass == "PRIEST" then
	createCustomMacroNailuj("priestHealButton", priestSpells, 1, "Heal", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 1))
	createCustomMacroNailuj("priestDispelDiseaseButton", priestSpells, 2, "Dispel disease", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 2))
	createCustomMacroNailuj("priestDispelMagicButton", priestSpells, 3, "Dispel magic", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 3))
	createCustomMacroNailuj("priestFlashHealButton", priestSpells, 4, "Flash Heal", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 4))
	createCustomMacroNailuj("priestGreaterHealButton", priestSpells, 5, "Greater Heal", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 5))
	createCustomMacroNailuj("priestMassDispelButton", priestSpells, 6, "Mass dispel", "/use [@cursor] " .. chooseSpellByLanguage(priestSpells, 6))
	createCustomMacroNailuj("priestPrayerMendingButton", priestSpells, 7, "Prayer mending", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 7))
	createCustomMacroNailuj("priestPwShieldButton", priestSpells, 8, "PW Shield", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 8))
	createCustomMacroNailuj("priestRenewButton", priestSpells, 9, "Renew", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 9))
end
