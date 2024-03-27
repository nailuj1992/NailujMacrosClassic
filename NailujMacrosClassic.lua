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
	{31935, "Avenger\'s Shield", "Escudo de vengador"},
	{31884, "Avenging wrath", "Cólera vengativa"},
	{6940, "Hand of sacrifice", "Mano de sacrificio"},
	{1038, "Hand of salvation", "Mano de Salvación"},
	{54428, "Divine Plea", "Súplica divina"},
	{64205, "Divine Sacrifice", "Sacrificio divino"},
	{53595, "Hammer of the Righteous", "Martillo del honrado"},
	{24275, "Hammer of Wrath", "Martillo de cólera"},
	{53407, "Judgement of justice", "Sentencia de justicia"},
	{53408, "Judgement of wisdom", "Sentencia de sabiduría"},
	{7328, "Redemption", "Redención"},
	{53601, "Sacred shield", "Escudo sacro"},
	{20375, "Seal of Command", "Sello de orden"},
	{348704, "Seal of Corruption", "Sello de corrupción"},
	{53600, "Shield of Righteousness", "Escudo de rectitud"},
	{62124, "Hand of Reckoning", "Mano de expiación"},
	{31789, "Righteous Defense", "Defensa recta"},
	{1022, "Blessing of protection", "Bendición de protección"},
	{55428, "Lifeblood", "Sangre de vida"},
	{59542, "Gift of the naaru", "Ofrenda de los naaru"}
}

local priestSpells = {
	{32546, "Binding Heal", "Sanación conjunta"},
	{552, "Abolish Disease", "Suprimir enfermedad"},
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
	createCustomMacroNailuj("paladinAvengersShieldButton", paladinSpells, 1, "Avenger shield", "/startattack" .. "\n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 1))
	createCustomMacroNailuj("paladinHammerRighteousButton", paladinSpells, 7, "Hammer righteous", "/startattack" .. "\n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 7))
	createCustomMacroNailuj("paladinHammerWrathButton", paladinSpells, 8, "Hammer wrath", "/startattack" .. "\n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 8))
	createCustomMacroNailuj("paladinShieldRighteousnessButton", paladinSpells, 15, "Shield righteous", "/startattack" .. "\n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 15))
	createCustomMacroNailuj("paladinJudgeJusticeButton", paladinSpells, 9, "Judge Justice", "/startattack" .. "\n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 9))
	createCustomMacroNailuj("paladinJudgeRotationButton", paladinSpells, 10, "Judge rotation", "/startattack" .. "\n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 10))
	createCustomMacroNailuj("paladinAvengingWrathButton", paladinSpells, 2, "Avenging wrath", "/use " .. chooseSpellByLanguage(paladinSpells, 2) .. "\n/use 14\n/y LET FLY!")
	createCustomMacroNailuj("paladinBlessOfSacrificeButton", paladinSpells, 3, "B of sacrifice", "/use [@mouseover] " .. chooseSpellByLanguage(paladinSpells, 3))
	createCustomMacroNailuj("paladinBlessOfSalvationButton", paladinSpells, 4, "B of salvation", "/use [@mouseover] " .. chooseSpellByLanguage(paladinSpells, 4))
	createCustomMacroNailuj("paladinBlessOfProtectionButton", paladinSpells, 18, "B of protection", "/use [@mouseover] " .. chooseSpellByLanguage(paladinSpells, 18))
	createCustomMacroNailuj("paladinDivinePleaButton", paladinSpells, 5, "Divine plea", "/use " .. chooseSpellByLanguage(paladinSpells, 5) .. "\n/y FOCUS FIRE!!!")
	createCustomMacroNailuj("paladinDivineSacrificeButton", paladinSpells, 6, "Divine sacrifice", "/use 13 \n/use 14 \n" .. "/use [@player] " .. chooseSpellByLanguage(paladinSpells, 6))
	createCustomMacroNailuj("paladinDivineSacriPvpButton", paladinSpells, 6, "Divine sacri PvP", "/use 14 \n" .. "/use [@player] " .. chooseSpellByLanguage(paladinSpells, 6))
	createCustomMacroNailuj("paladinSealsChangeButton", paladinSpells, 14, "Seals change alt", "/use [nomod:alt] " ..chooseSpellByLanguage(paladinSpells, 13) .. " ; [mod:alt] " .. chooseSpellByLanguage(paladinSpells, 14))
	createCustomMacroNailuj("paladinTauntButton", paladinSpells, 16, "Taunt", "/use [nomod:alt] " ..chooseSpellByLanguage(paladinSpells, 16) .. " ; [mod:alt] " .. chooseSpellByLanguage(paladinSpells, 17))
	createCustomMacroNailuj("paladinRedemptionButton", paladinSpells, 11, "Revive single", "/use " .. chooseSpellByLanguage(paladinSpells, 11) .. "\n/s Reviviendo al manco de %t xD")
	createCustomMacroNailuj("paladinOffHealButton", paladinSpells, 19, "Off heal", "/use [@player] " .. chooseSpellByLanguage(paladinSpells, 18) .. "\n" .. "/use " .. chooseSpellByLanguage(paladinSpells, 19))
	createCustomMacroNailuj("paladinSacredShieldButton", paladinSpells, 12, "Sacred shield", "/use [@player] " .. chooseSpellByLanguage(paladinSpells, 12))
end

--------------------------------------------------------------------
-- Creating priest macros
--------------------------------------------------------------------
if englishClass == "PRIEST" then
	createCustomMacroNailuj("priestBindingHealButton", priestSpells, 1, "Binding Heal", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 1))
	createCustomMacroNailuj("priestDispelDiseaseButton", priestSpells, 2, "Dispel disease", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 2))
	createCustomMacroNailuj("priestDispelMagicButton", priestSpells, 3, "Dispel magic", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 3))
	createCustomMacroNailuj("priestFlashHealButton", priestSpells, 4, "Flash Heal", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 4))
	createCustomMacroNailuj("priestGreaterHealButton", priestSpells, 5, "Greater Heal", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 5))
	createCustomMacroNailuj("priestMassDispelButton", priestSpells, 6, "Mass dispel", "/use [@cursor] " .. chooseSpellByLanguage(priestSpells, 6))
	createCustomMacroNailuj("priestPrayerMendingButton", priestSpells, 7, "Prayer mending", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 7))
	createCustomMacroNailuj("priestPwShieldButton", priestSpells, 8, "PW Shield", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 8))
	createCustomMacroNailuj("priestRenewButton", priestSpells, 9, "Renew", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 9))
end
