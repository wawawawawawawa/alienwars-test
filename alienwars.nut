/// Creation Vars
{
	local hDrone = Entities.CreateByClassname("asw_drone");
	hDrone.PrecacheModel("models/aliens/droaw/dronB.mdl");
	hDrone.PrecacheModel("models/aliens/droaw/dron3.mdl");
	hDrone.PrecacheModel("models/aliens/droaw/dron4.mdl");
	hDrone.PrecacheModel("models/aliens/droaw/dron8.mdl");
	hDrone.PrecacheModel("models/aliens/droaw/dron9.mdl");
	hDrone.PrecacheModel("models/aliens/droaw/dron0.mdl");
	hDrone.PrecacheModel("models/aliens/droaw/dro10.mdl");
	hDrone.PrecacheModel("models/aliens/droaw/dro11.mdl");
	
	hDrone.PrecacheModel("models/swarm/mariaw/marine.mdl");
	hDrone.PrecacheModel("models/swarm/mariaw/femalemarine.mdl");
	hDrone.Destroy();
	::OriginArray <- {};
	::Start <- false;
	// ::ChangeModel <- true;
	::ChangeModel <- false;
	::RemoveWeapon <- true;
	::OrdersDebug <- false;
	// ::UpdateRate <- 0.5;
	::UpdateRate <- 0.1;
	::CurrentRound <- 1;
	::MaxTry <- 50;
	::MaxRange <- 50;
	::DebugGreen <- {};
	::DebugRed <- {};
	::NotEnd <- true;
	::TipSetting <- true;
	::TipTimeSecond <- 40;
	::TipTime <- 10;
	::StartTime <- 0;
	::LastTip <- "";
	::ThisIsCenterLeft <- null;
	::ThisIsCenterRight <- null;
	::ThisIsCenterAir <- null;
	::ThisIsCenter <- null;
	::HPBarType <- "Default";
	::EverythingFree <- "OFF";
	::lobbyError <- null;

	::MarineModel <- "models/swarm/mariaw/marine.mdl";
	::MarineFModel <- "models/swarm/mariaw/femalemarine.mdl";
	::DefaulttimePrep <- 60;
	// ::DefaulttimeBattle <- 60;
	::DefaulttimeRefresh <- 30;
	::DefaulttimeTeleport <- 90;
	::DefaulttimeEnd <- 3;	
	::DefaulttimeEndMap <- 12;
	::DefaulttimeDebug <- 20;
	::DefaulttimeRestart <- 5;
	::timePrep <- DefaulttimePrep;
	// ::timeBattle <- DefaulttimeBattle;
	::timeRefresh <- DefaulttimeRefresh;
	::timeTeleport <- DefaulttimeTeleport;
	::timeEnd <- DefaulttimeEnd;
	::timeEndMap <- DefaulttimeEndMap;
	::timeDebug <- DefaulttimeDebug;
	::timeRestart <- DefaulttimeRestart;
	::BattleStart <- false;
	::Winner <- 0; // + => green / - => red
	::BuffMultSize <- 2;
	::BuffMultSpeed <- 2;
	::BuffMultHP <- 0.3;
	// ::BuffAddHP <- 100
	// ::BuffHP <- 100;
	::BuffTime <- 15;
	::StealTime <- 15;
	::StasisTime <- 15;

	::AWQueueTimer <- Entities.CreateByClassname("logic_timer");
	AWQueueTimer.__KeyValueFromFloat("RefireTime", 1);
	AWQueueTimer.ConnectOutput("OnTimer", "AWQueueTimerFunc");
	DoEntFire("!self", "Enable", "", 0, null, AWQueueTimer);
	
	::AWTimers <- {};
	AWTimers["Preparation"] <- false;
	AWTimers["Battle"] <- false;
	AWTimers["EndMap"] <- false;
	AWTimers["Debug"] <- false;
	AWTimers["Buff"] <- false;
	AWTimers["Steal"] <- false;
	AWTimers["Stasis"] <- false;
	AWTimers["Fear"] <- false;
	AWTimers["Special"] <- false;
	AWTimers["Restart"] <- false;
	
	::EndPosition <- {};
	
	::StealTimers <- {};
	::StealFaction <- {};
	::BuffTimers <- {};
	::StasisTimers <- {};
	::StasisFaction <- {};
	::FearTimers <- {};
	::SpecialTimers <- {};
	::SpecialType <- {};
	::OldHP <- {};
	::StompEffectOn <- {};
	::StompEffectSeq <- {};
	::StompEffectPos <- {};
	::StompEffectDist <- {};
	::StompEffectMaxDist <- 2000;
	::SlowArray <- {};
	::SlowCreatorArray <- {};
	::SlowArrayCheck <- {};

	::MarineTeamList <- {}; // 0 = neutral / 1 = green (marine) / 2 = red (alien)
	MarineTeamList["Sarge"] <- 1;
	MarineTeamList["Wildcat"] <- 1;
	MarineTeamList["Faith"] <- 1;
	MarineTeamList["Crash"] <- 1;
	MarineTeamList["Jaeger"] <- 2;
	MarineTeamList["Wolfe"] <- 2;
	MarineTeamList["Bastille"] <- 2;
	MarineTeamList["Vegas"] <- 2;

	::BuffWeaponList <- {};
	BuffWeaponList["asw_weapon_medrifle"] <- "medic";
	BuffWeaponList["asw_weapon_grenade_launcher"] <- "officer";
	BuffWeaponList["asw_weapon_pistol"] <- "specialist";
	BuffWeaponList["asw_weapon_deagle"] <- "technician";
	
	::SpawnerWeaponList <- {};
	// SpawnerWeaponList["asw_weapon_rifle"] <- "asw_drone";
	// SpawnerWeaponList["asw_weapon_pdw"] <- "asw_buzzer";
	// SpawnerWeaponList["asw_weapon_vindicator"] <- "asw_shieldbug";
	// SpawnerWeaponList["asw_weapon_deagle"] <- "asw_boomer";
	// SpawnerWeaponList["asw_weapon_prifle"] <- "npc_antlion";
	// SpawnerWeaponList["asw_weapon_heavy_rifle"] <- "npc_antlion_worker";
	// SpawnerWeaponList["asw_weapon_railgun"] <- "npc_zombie";	
	// SpawnerWeaponList["asw_weapon_combat_rifle"] <- "npc_fastzombie";
	SpawnerWeaponList["asw_weapon_rifle"] <- "Special1";
	SpawnerWeaponList["asw_weapon_pdw"] <- "Special2";
	SpawnerWeaponList["asw_weapon_vindicator"] <- "Special3";
	SpawnerWeaponList["asw_weapon_deagle"] <- "Special4";
	SpawnerWeaponList["asw_weapon_prifle"] <- "Special5";
	SpawnerWeaponList["asw_weapon_heavy_rifle"] <- "Special6";
	SpawnerWeaponList["asw_weapon_railgun"] <- "Special7";
	SpawnerWeaponList["asw_weapon_combat_rifle"] <- "Special8";
	
	::SpawnerWeaponPos <- {};
	SpawnerWeaponPos[1] <- Vector(-440, 193, 96);
	SpawnerWeaponPos[2] <- Vector(-128, 193, 96);
	SpawnerWeaponPos[3] <- Vector(24, -47, 96);
	SpawnerWeaponPos[4] <- Vector(24, -283, 96);
	SpawnerWeaponPos[5] <- Vector(-128, -511, 96);
	SpawnerWeaponPos[6] <- Vector(-440, -511, 96);
	SpawnerWeaponPos[7] <- Vector(-656, -283, 96);
	SpawnerWeaponPos[8] <- Vector(-656, -47, 96);
	
	::SpawnerWeaponNum <- {};
	// SpawnerWeaponNum[1] <- "asw_drone";
	// SpawnerWeaponNum[2] <- "asw_buzzer";
	// SpawnerWeaponNum[3] <- "asw_shieldbug";
	// SpawnerWeaponNum[4] <- "asw_boomer";
	// SpawnerWeaponNum[5] <- "npc_antlion";
	// SpawnerWeaponNum[6] <- "npc_antlion_worker";
	// SpawnerWeaponNum[7] <- "npc_zombie";
	// SpawnerWeaponNum[8] <- "npc_fastzombie";
	SpawnerWeaponNum[1] <- "Special1";
	SpawnerWeaponNum[2] <- "Special2";
	SpawnerWeaponNum[3] <- "Special3";
	SpawnerWeaponNum[4] <- "Special4";
	SpawnerWeaponNum[5] <- "Special5";
	SpawnerWeaponNum[6] <- "Special6";
	SpawnerWeaponNum[7] <- "Special7";
	SpawnerWeaponNum[8] <- "Special8";
	
	::SpawnerWeaponName <- {};
	SpawnerWeaponName[1] <- "Varoling";
	SpawnerWeaponName[2] <- "Poofiki";
	SpawnerWeaponName[3] <- "Daroon";
	SpawnerWeaponName[4] <- "Arthyoas";
	SpawnerWeaponName[5] <- "Rotamor";
	SpawnerWeaponName[6] <- "Simeras";
	SpawnerWeaponName[7] <- "Gigarax";
	SpawnerWeaponName[8] <- "Skivus";
	
	::SpawnerWeaponClass <- {};
	SpawnerWeaponClass[1] <- "Splitter";
	SpawnerWeaponClass[2] <- "Kamikaze";
	SpawnerWeaponClass[3] <- "All-Rounder";
	SpawnerWeaponClass[4] <- "Poisonous";
	SpawnerWeaponClass[5] <- "Tank";
	SpawnerWeaponClass[6] <- "Assassin";
	SpawnerWeaponClass[7] <- "Titan";
	SpawnerWeaponClass[8] <- "Titan";
	
	::SpawnerWeaponDesc <- {};
	SpawnerWeaponDesc[1] <- "Varoling's attribute is unique. It can split to avoid death.";
	SpawnerWeaponDesc[2] <- "Poofiki are very proud. They will explode on their ennemies.";
	SpawnerWeaponDesc[3] <- "Daroon are strong, fast and agressive. Avoid at all cost.";
	SpawnerWeaponDesc[4] <- "Arthyoas may have a weak body, but their poison is deadly.";
	SpawnerWeaponDesc[5] <- "Rotamor are hunted for their highly resistant shell.";
	SpawnerWeaponDesc[6] <- "Simeras are so fast you die upon hearing their hiss.";
	SpawnerWeaponDesc[7] <- "Gigarax is the largest species known to mankind.";
	SpawnerWeaponDesc[8] <- "Skivus feed and farm on humans. Very hostile.";
	
	::SpawnerWeaponExtra <- {};
	SpawnerWeaponExtra[1] <- "Split upon death";
	SpawnerWeaponExtra[2] <- "Explode for 100dmg";
	SpawnerWeaponExtra[3] <- "";
	SpawnerWeaponExtra[4] <- "";
	SpawnerWeaponExtra[5] <- "";
	SpawnerWeaponExtra[6] <- "";
	SpawnerWeaponExtra[7] <- "";
	SpawnerWeaponExtra[8] <- "";
	
	::SpawnerWeaponGold <- {};
	SpawnerWeaponGold["Special1"] <- 1; // fodder
	SpawnerWeaponGold["Special2"] <- 2; // regular
	SpawnerWeaponGold["Special3"] <- 5; // medium tank
	SpawnerWeaponGold["Special4"] <- 7; // medium attacker
	SpawnerWeaponGold["Special5"] <- 15; // fat tank
	SpawnerWeaponGold["Special6"] <- 20; // assassin
	SpawnerWeaponGold["Special7"] <- 50; // queen
	SpawnerWeaponGold["Special8"] <- 50; // king
	
	::SpecialSize <- {};
	SpecialSize["Special1"] <- 1; // fodder
	SpecialSize["Special2"] <- 1; // regular
	SpecialSize["Special3"] <- 1.5; // medium tank
	SpecialSize["Special4"] <- 1.5; // medium attacker
	SpecialSize["Special5"] <- 3; // fat tank
	SpecialSize["Special6"] <- 1.5; // assassin
	SpecialSize["Special7"] <- 3; // queen
	SpecialSize["Special8"] <- 3; // king
	
	::SpecialHP <- {};
	SpecialHP["Special1"] <- 150; // Splitter
	SpecialHP["Special2"] <- 50; // Kamikaze
	SpecialHP["Special3"] <- 500; // All-Rounder
	SpecialHP["Special4"] <- 300; // Poisonous
	SpecialHP["Special5"] <- 800; // Tank
	SpecialHP["Special6"] <- 200; // Assassin
	SpecialHP["Special7"] <- 1000; // Titan
	SpecialHP["Special8"] <- 1500; // Titan
	
	::SpecialDMG <- {};
	SpecialDMG["Special1"] <- 15; // fodder
	SpecialDMG["Special2"] <- 10; // regular
	SpecialDMG["Special3"] <- 20; // medium tank
	SpecialDMG["Special4"] <- 50; // medium attacker
	SpecialDMG["Special5"] <- 30; // fat tank
	SpecialDMG["Special6"] <- 80; // assassin
	SpecialDMG["Special7"] <- 100; // queen
	SpecialDMG["Special8"] <- 80; // king
	
	::SpecialSPD <- {};
	SpecialSPD["Special1"] <- 1.2; // fodder
	SpecialSPD["Special2"] <- 1.0; // regular
	SpecialSPD["Special3"] <- 0.9; // medium tank
	SpecialSPD["Special4"] <- 1.5; // medium attacker
	SpecialSPD["Special5"] <- 0.8; // fat tank
	SpecialSPD["Special6"] <- 1.3; // assassin
	SpecialSPD["Special7"] <- 0.9; // queen
	SpecialSPD["Special8"] <- 1.1; // king	
	
	::SpecialBlock <- {};
	SpecialBlock["Special1"] <- 0; // fodder
	SpecialBlock["Special2"] <- 1; // regular
	SpecialBlock["Special3"] <- 10; // medium tank
	SpecialBlock["Special4"] <- 5; // medium attacker
	SpecialBlock["Special5"] <- 20; // fat tank
	SpecialBlock["Special6"] <- 7; // assassin
	SpecialBlock["Special7"] <- 30; // queen
	SpecialBlock["Special8"] <- 101; // king
	
	::SpecialCritDamage <- {};
	SpecialCritDamage["Special1"] <- 1.0; // fodder
	SpecialCritDamage["Special2"] <- 1.2; // regular
	SpecialCritDamage["Special3"] <- 1.2; // medium tank
	SpecialCritDamage["Special4"] <- 1.5; // medium attacker
	SpecialCritDamage["Special5"] <- 1.2; // fat tank
	SpecialCritDamage["Special6"] <- 1.5; // assassin
	SpecialCritDamage["Special7"] <- 1.8; // queen
	SpecialCritDamage["Special8"] <- 1.3; // king
	
	::SpecialCrit <- {};
	SpecialCrit["Special1"] <- 0; // fodder
	SpecialCrit["Special2"] <- 1; // regular
	SpecialCrit["Special3"] <- 5; // medium tank
	SpecialCrit["Special4"] <- 10; // medium attacker
	SpecialCrit["Special5"] <- 7; // fat tank
	SpecialCrit["Special6"] <- 20; // assassin
	SpecialCrit["Special7"] <- 30; // queen
	SpecialCrit["Special8"] <- 10; // king
	
	::SpecialHPBAR <- {};
	SpecialHPBAR["Special1"] <- 0; // fodder
	SpecialHPBAR["Special2"] <- 0; // regular
	SpecialHPBAR["Special3"] <- 0; // medium tank
	SpecialHPBAR["Special4"] <- 0; // medium attacker
	SpecialHPBAR["Special5"] <- 1; // fat tank
	SpecialHPBAR["Special6"] <- 0; // assassin
	SpecialHPBAR["Special7"] <- 1.2; // queen
	SpecialHPBAR["Special8"] <- 1.4; // king
	
	// SpecialHPBAR["Special1"] <- 1; // fodder
	// SpecialHPBAR["Special2"] <- 1; // regular
	// SpecialHPBAR["Special3"] <- 1; // medium tank
	// SpecialHPBAR["Special4"] <- 1; // medium attacker
	// SpecialHPBAR["Special5"] <- 1; // fat tank
	// SpecialHPBAR["Special6"] <- 1; // assassin
	// SpecialHPBAR["Special7"] <- 1.2; // queen
	// SpecialHPBAR["Special8"] <- 1.4; // king	
	
	::SpecialIce <- {};
	SpecialIce["Special1"] <- 0; // fodder
	SpecialIce["Special2"] <- 0; // regular
	SpecialIce["Special3"] <- 0; // medium tank
	SpecialIce["Special4"] <- 1; // medium attacker
	SpecialIce["Special5"] <- 0; // fat tank
	SpecialIce["Special6"] <- 0; // assassin
	SpecialIce["Special7"] <- 1; // queen
	SpecialIce["Special8"] <- 1; // king
	
	::SpecialFire <- {};
	SpecialFire["Special1"] <- 0; // fodder
	SpecialFire["Special2"] <- 0; // regular
	SpecialFire["Special3"] <- 0; // medium tank
	SpecialFire["Special4"] <- 0; // medium attacker
	SpecialFire["Special5"] <- 0; // fat tank
	SpecialFire["Special6"] <- 0; // assassin
	SpecialFire["Special7"] <- 1; // queen
	SpecialFire["Special8"] <- 1; // king
	
	::SpecialTesla <- {};
	SpecialTesla["Special1"] <- 0; // fodder
	SpecialTesla["Special2"] <- 0; // regular
	SpecialTesla["Special3"] <- 0; // medium tank
	SpecialTesla["Special4"] <- 1; // medium attacker
	SpecialTesla["Special5"] <- 0; // fat tank
	SpecialTesla["Special6"] <- 0; // assassin
	SpecialTesla["Special7"] <- 1; // queen
	SpecialTesla["Special8"] <- 1; // king
	
	::SpecialFlinch <- {};
	SpecialFlinch["Special1"] <- 0; // fodder
	SpecialFlinch["Special2"] <- 0; // regular
	SpecialFlinch["Special3"] <- 0; // medium tank
	SpecialFlinch["Special4"] <- 0; // medium attacker
	SpecialFlinch["Special5"] <- 0; // fat tank
	SpecialFlinch["Special6"] <- 0; // assassin
	SpecialFlinch["Special7"] <- 1; // queen
	SpecialFlinch["Special8"] <- 1; // king
	
	::SpecialMDL <- {};	
	SpecialMDL["Special1"] <- "models/aliens/droaw/dronB.mdl"; // fodder
	SpecialMDL["Special2"] <- "models/aliens/droaw/dro11.mdl"; // regular
	SpecialMDL["Special3"] <- "models/aliens/droaw/dron9.mdl"; // medium tank
	SpecialMDL["Special4"] <- "models/aliens/droaw/dron4.mdl"; // medium attacker
	SpecialMDL["Special5"] <- "models/aliens/droaw/dro10.mdl"; // fat tank
	SpecialMDL["Special6"] <- "models/aliens/droaw/dron8.mdl"; // assassin
	SpecialMDL["Special7"] <- "models/aliens/droaw/dron3.mdl"; // queen
	SpecialMDL["Special8"] <- "models/aliens/droaw/dron0.mdl"; // king
	
	::AlienMaxCountList <- {};
	AlienMaxCountList["asw_drone"] <- 500;
	AlienMaxCountList["asw_boomer"] <- 100;
	AlienMaxCountList["asw_buzzer"] <- 100;
	AlienMaxCountList["asw_shieldbug"] <- 100;
	AlienMaxCountList["npc_antlion"] <- 100;
	AlienMaxCountList["npc_antlion_worker"] <- 100;
	AlienMaxCountList["npc_zombie"] <- 100;
	AlienMaxCountList["npc_fastzombie"] <- 100;

	AlienMaxCountList["asw_mortarbug"] <- 500;
	AlienMaxCountList["asw_shaman"] <- 500;
	AlienMaxCountList["asw_harvester"] <- 500;
	AlienMaxCountList["npc_antlionguard_cavern"] <- 500;
	AlienMaxCountList["asw_parasite"] <- 500;
	AlienMaxCountList["asw_parasite_defanged"] <- 500;
	AlienMaxCountList["asw_ranger"] <- 500;
	AlienMaxCountList["asw_queen"] <- 500;
	AlienMaxCountList["npc_zombie_torso"] <- 500;

	::GreenTeamAlienList <- {};
	::RedTeamAlienList <- {};
	// ::AlienMaxCountList <- {};
	foreach(idx, val in AlienMaxCountList)
	{
		RedTeamAlienList[idx] <- 0;
		GreenTeamAlienList[idx] <- 0;
		// AlienMaxCountList[idx] <- 100;
	}
	::GreenAlienEnt <- {};
	::RedAlienEnt <- {};
	::GreyAlienEnt <- {};

	::AWAlienDescTextEnt <- {};
	::AWAlienDescTextNum <- {};
	::AWAlienDescTextTime <- {};
	::HoldTime <- 3;
	::AWAlienCountTextEnt <- {};
	::AWGoldCountTextEnt <- {};
	::AWGoldCountValue <- {};
	::AWGoldCountValueRound <- {};
	
	// ::DefaultGold <- 480;
	// ::DefaultGoldWin <- 492;
	// ::DefaultGoldLoss <- 468;
	// ::DefaultGoldDraw <- 480;
	::DefaultGold <- 240;
	::DefaultGoldWin <- 252;
	::DefaultGoldLoss <- 238;
	::DefaultGoldDraw <- 240;
	::DefaultBuffWeapon <- 30;
	
	::UpdateArray <- {};
}

::AWGoldCount <- function(txt = "", myuser = null, color = "255 255 0")
{
	if (myuser != null)
	{
		if (!AWGoldCountTextEnt.rawin(GetClientXUID(myuser)) || AWGoldCountTextEnt[GetClientXUID(myuser)] == null)
		{
			AWGoldCountTextEnt[GetClientXUID(myuser)] <- Entities.CreateByClassname("game_text");
			AWGoldCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("channel", "2");
			AWGoldCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("x", "-1");
			AWGoldCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("y", "0.8");
			AWGoldCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("color", color);
			AWGoldCountTextEnt[GetClientXUID(myuser)].SetOwner(myuser);
		}
		
		local hMarine = NetProps.GetPropEntity(myuser, "m_hMarine");
		if (hMarine == null || !hMarine.IsValid())
		{
			hMarine = NetProps.GetPropEntity(myuser, "m_hSpectatingMarine");
		}
		if (hMarine != null && hMarine.IsValid())
		{
			AWGoldCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("message", "Gold = " + AWGoldCountValue[hMarine].tostring());
			AWGoldCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("holdtime", "10");
			EntFireByHandle(AWGoldCountTextEnt[GetClientXUID(myuser)], "Display", "", 0.01, AWGoldCountTextEnt[GetClientXUID(myuser)].GetOwner(), AWGoldCountTextEnt[GetClientXUID(myuser)].GetOwner());
		}
	}
	else
	{
		local hMarine = null;
		local GreenMarineNum = 0;
		local RedMarineNum = 0;
		while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
		{
			local faction = MarineTeamList[hMarine.GetMarineName()];
			if (faction == 1)
			{
				GreenMarineNum += 1;
			}
			else
			{
				RedMarineNum += 1;
			}
		}
		while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
		{
			local faction = MarineTeamList[hMarine.GetMarineName()];
			if (faction == 1)
			{
				AWGoldCountValue[hMarine] <- (DefaultGold/GreenMarineNum);
			}
			else
			{
				AWGoldCountValue[hMarine] <- (DefaultGold/RedMarineNum);
			}
			AWGoldCountValueRound[hMarine] <- AWGoldCountValue[hMarine];
		}
	}
}

::ShowAlienDesc <- function(txt = "", mymarine = null, myuser = null, color = "255 255 255")
{
	if (myuser != null)
	{
		// if (AWAlienDescTextEnt.rawin(GetClientXUID(myuser)) && AWAlienDescTextEnt[GetClientXUID(myuser)] != null)
		// {
			// AWAlienDescTextEnt[GetClientXUID(myuser)].Destroy();
			// AWAlienDescTextEnt.rawdelete(GetClientXUID(myuser));
			// AWAlienDescTextEnt[GetClientXUID(myuser)].Destroy();
		// }
		// if (AWAlienDescTextEnt.rawin(GetClientXUID(myuser)) && AWAlienDescTextEnt[GetClientXUID(myuser)] != null && AWAlienDescTextEnt[GetClientXUID(myuser)].IsValid())
		// {
			// AWAlienDescTextEnt[GetClientXUID(myuser)].Destroy();
		// }
		local NewHold = HoldTime + 1;
		if (!AWAlienDescTextEnt.rawin(GetClientXUID(myuser)) || AWAlienDescTextEnt[GetClientXUID(myuser)] == null)
		{
			AWAlienDescTextEnt[GetClientXUID(myuser)] <- Entities.CreateByClassname("game_text");
			AWAlienDescTextEnt[GetClientXUID(myuser)].__KeyValueFromString("channel", "3");
			AWAlienDescTextEnt[GetClientXUID(myuser)].__KeyValueFromString("x", "0.01");
			AWAlienDescTextEnt[GetClientXUID(myuser)].__KeyValueFromString("y", "0.2");
			AWAlienDescTextEnt[GetClientXUID(myuser)].SetOwner(myuser);
		}
		
		AWAlienDescTextEnt[GetClientXUID(myuser)].__KeyValueFromString("message", txt);
		AWAlienDescTextEnt[GetClientXUID(myuser)].__KeyValueFromString("color", color);
		// AWAlienDescTextEnt[GetClientXUID(myuser)].__KeyValueFromString("holdtime", NewHold.tostring());
		AWAlienDescTextEnt[GetClientXUID(myuser)].__KeyValueFromString("holdtime", "60");
		// AWAlienDescTextEnt[GetClientXUID(myuser)].__KeyValueFromString("fadeout", "1");
		//  EntFireByHandle(handle target, string action, string value, float delay, handle activator, handle caller)
		EntFireByHandle(AWAlienDescTextEnt[GetClientXUID(myuser)], "Display", "", 0.01, AWAlienDescTextEnt[GetClientXUID(myuser)].GetOwner(), AWAlienDescTextEnt[GetClientXUID(myuser)].GetOwner());
		// printl(myuser + " - color = " + color);
		// printl(" - text = " + txt);
	}
}

::AWAlienCount <- function(txt = "", myuser = null, color = "255 255 0")
{
	if (myuser != null)
	{
		if (!AWAlienCountTextEnt.rawin(GetClientXUID(myuser)) || AWAlienCountTextEnt[GetClientXUID(myuser)] == null)
		{
			AWAlienCountTextEnt[GetClientXUID(myuser)] <- Entities.CreateByClassname("game_text");
			AWAlienCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("channel", "4");
			AWAlienCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("x", "-1");
			AWAlienCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("y", "0.05");
			AWAlienCountTextEnt[GetClientXUID(myuser)].SetOwner(myuser);
		}
		
		AWAlienCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("message", txt);
		AWAlienCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("color", color);
		AWAlienCountTextEnt[GetClientXUID(myuser)].__KeyValueFromString("holdtime", "1");
		EntFireByHandle(AWAlienCountTextEnt[GetClientXUID(myuser)], "Display", "", 0.01, AWAlienCountTextEnt[GetClientXUID(myuser)].GetOwner(), AWAlienCountTextEnt[GetClientXUID(myuser)].GetOwner());
	}
}

::Update <- function()
{
	if(Start)
	{
		if (UpdateArray.len() > 0)
		{
			foreach (idx, val in UpdateArray)
			{
				local Override = 0;
				if (idx.IsValid())
				{
					Override = NetProps.GetPropInt(idx, "m_bPerformingOverride");
					if (Override == 0)
					{
						idx.SetVelocity(val);
					}
				}
				if (Override == 0)
				{
					UpdateArray.rawdelete(idx);
				}
			}
			// printl("now = " + UpdateArray.len());
		}
		if (TipSetting)
		{
			// printl(Time() - StartTime);
			if (Time() >= (TipTime + StartTime))
			{
				// printl(Time() + " -- " + TipTime);
				Tip();
				TipTime += TipTimeSecond;
			}
			// local TipOrNotToTip = RandomInt(0, (TipTimeSecond / UpdateRate));
			// if (TipOrNotToTip == 0)
			// {
				// Tip();
			// }
		}
		local hMarine = null;
		while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
		{
			// if (hMarine.GetOrigin().z < -550 && NotEnd)
			if (hMarine.GetOrigin().z < -1550 && NotEnd)
			{
				if (!BattleStart)
				{
					hMarine.SetOrigin(Vector(hMarine.GetOrigin().x, hMarine.GetOrigin().y, 100));
				}
				else
				{
					hMarine.SetOrigin(Vector(hMarine.GetOrigin().x, hMarine.GetOrigin().y, -400));
				}
			}
		}
		if (ThisIsCenterLeft == null)
		{
			ThisIsCenterLeft = Entities.FindByName(ThisIsCenterLeft, "ThisIsCenterLeft");
		}
		if (ThisIsCenterRight == null)
		{
			ThisIsCenterRight = Entities.FindByName(ThisIsCenterRight, "ThisIsCenterRight");
		}
		if (ThisIsCenterAir == null)
		{
			ThisIsCenterAir = Entities.FindByName(ThisIsCenterAir, "ThisIsCenterAir");
		}
		if (ThisIsCenter == null)
		{
			ThisIsCenter = Entities.FindByName(ThisIsCenter, "ThisIsCenter");
		}
		local lengthG = GreenAlienEnt.len();
		local lengthR = RedAlienEnt.len();
		GreenTeamAlienList["asw_drone"] = 0;
		GreenTeamAlienList["asw_boomer"] = 0;
		GreenTeamAlienList["asw_buzzer"] = 0;
		GreenTeamAlienList["asw_shieldbug"] = 0;
		GreenTeamAlienList["npc_antlion"] = 0;
		GreenTeamAlienList["npc_antlion_worker"] = 0;
		GreenTeamAlienList["npc_fastzombie"] = 0;
		GreenTeamAlienList["npc_zombie"] = 0;
		
		// GreenTeamAlienList["npc_antlionguard_cavern"] = 0;
		// GreenTeamAlienList["asw_mortarbug"] = 0;
		// GreenTeamAlienList["asw_shaman"] = 0;
		// GreenTeamAlienList["asw_harvester"] = 0;
		// GreenTeamAlienList["asw_parasite"] = 0;
		// GreenTeamAlienList["asw_parasite_defanged"] = 0;
		// GreenTeamAlienList["asw_ranger"] = 0;
		
		RedTeamAlienList["asw_drone"] = 0;
		RedTeamAlienList["asw_boomer"] = 0;
		RedTeamAlienList["asw_buzzer"] = 0;
		RedTeamAlienList["asw_shieldbug"] = 0;
		RedTeamAlienList["npc_antlion"] = 0;
		RedTeamAlienList["npc_antlion_worker"] = 0;
		RedTeamAlienList["npc_fastzombie"] = 0;
		RedTeamAlienList["npc_zombie"] = 0;
		
		// RedTeamAlienList["npc_antlionguard_cavern"] = 0;
		// RedTeamAlienList["asw_mortarbug"] = 0;
		// RedTeamAlienList["asw_shaman"] = 0;
		// RedTeamAlienList["asw_harvester"] = 0;
		// RedTeamAlienList["asw_parasite"] = 0;
		// RedTeamAlienList["asw_parasite_defanged"] = 0;
		// RedTeamAlienList["asw_ranger"] = 0;
		
		local GreenNum = 0;
		local RedNum = 0;
		if (OrdersDebug && GreenAlienEnt.len() > 0)
		{
			printl("=======Green========");
		}
		foreach (idx, val in GreenAlienEnt)
		{
			if (idx.IsValid() && idx != null)
			{
				GreenNum += 1;
				GreenTeamAlienList[idx.GetClassname()] += 1;
				if (OrdersDebug)
				{
					local Order = NetProps.GetPropInt(idx, "m_AlienOrders");
					local OrderObj = NetProps.GetPropEntity(idx, "m_AlienOrderObject");
					printl("Order = " + Order + " - Object = " + OrderObj);
				}
				// if (StompEffectOn.rawin(idx) && StompEffectOn[idx] != 0 && StompEffectPos.rawin(idx))
				// {
					// StompCharge(idx);
				// }
				/*if (StompEffectOn.rawin(idx) && StompEffectOn[idx] != 0)
				{
					if (StompEffectPos.rawin(idx))
					{
						// StompEffectPos[idx] = idx.GetOrigin();
						// StompCharge(idx);
						PushAway(idx, 0, 300);
					}
					else
					{
						StompEffectPos[idx] <- idx.GetOrigin();
						StompEffectDist[idx] <- 1;
						StompEffectSeq[idx] <- 0;
						// StompEffectPos.rawset(idx, idx.GetOrigin());
						// StompEffectDist.rawset(idx, 1);
						// StompEffectSeq.rawset(idx, 0);
					}
				}*/
			}
			else if (lengthG > 0)
			{
				GreenAlienEnt.rawdelete(idx);
			}
		}
		if (OrdersDebug && RedAlienEnt.len() > 0)
		{
			printl("=======Red========");
		}
		foreach (idx, val in RedAlienEnt)
		{
			if (idx.IsValid() && idx != null)
			{
				RedNum += 1;
				RedTeamAlienList[idx.GetClassname()] += 1;
				if (OrdersDebug)
				{
					local Order = NetProps.GetPropInt(idx, "m_AlienOrders");
					local OrderObj = NetProps.GetPropEntity(idx, "m_AlienOrderObject");
					printl("Order = " + Order + " - Object = " + OrderObj);
				}
				
			}
			else if (lengthR > 0)
			{
				RedAlienEnt.rawdelete(idx);
			}
		}
		local hPlayer = null;
		local color = "0 255 0"; // green
		if (RedNum > GreenNum)
		{
			color = "255 0 0";
		}
		else if (RedNum == GreenNum)
		{
			color = "255 255 0";
		}
		
		if ((GreenNum == 0 || RedNum == 0) && BattleStart && StealTimers.len() < 1 && StasisTimers.len() < 1)
		{
			if (timeEnd > 0)
			{
				timeEnd -= UpdateRate;
				if (GreenNum > RedNum)
				{
					ClientPrint(null, 4, "Green Team Wins this Round!");
				}
				else if (RedNum > GreenNum)
				{
					ClientPrint(null, 4, "Red Team Wins this Round!");
				}
				else
				{
					ClientPrint(null, 4, "This is a Draw!");
				}
			}
			else if (timeEnd < 0)
			{
				local hMarine = null;
				local GreenMarineNum = 0;
				local RedMarineNum = 0;
				while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
				{
					local faction = MarineTeamList[hMarine.GetMarineName()];
					if (faction == 1)
					{
						GreenMarineNum += 1;
					}
					else
					{
						RedMarineNum += 1;
					}
				}
				while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
				{
					local faction = MarineTeamList[hMarine.GetMarineName()];
					if (GreenNum > RedNum)
					{
						if (faction == 1)
						{
							AWGoldCountValue[hMarine] += (DefaultGoldWin/GreenMarineNum);
						}
						else
						{
							AWGoldCountValue[hMarine] += (DefaultGoldLoss/RedMarineNum);
						}
					}
					else if (RedNum > GreenNum)
					{
						if (faction == 1)
						{
							AWGoldCountValue[hMarine] += (DefaultGoldLoss/GreenMarineNum);
						}
						else
						{
							AWGoldCountValue[hMarine] += (DefaultGoldWin/RedMarineNum);
						}
					}
					else
					{
						if (faction == 1)
						{
							AWGoldCountValue[hMarine] += (DefaultGoldDraw/GreenMarineNum);
						}
						else
						{
							AWGoldCountValue[hMarine] += (DefaultGoldDraw/RedMarineNum);
						}
					}
					AWGoldCountValueRound[hMarine] <- AWGoldCountValue[hMarine];
				}
				if (GreenNum != RedNum)
				{
					local LightRoundName = "LightRound"+CurrentRound.tostring();
					local LightRound = null;
					while ((LightRound = Entities.FindByName(LightRound, LightRoundName)) != null)
					{
						if (GreenNum > RedNum)
						{
							DoEntFire(LightRoundName, "Color", "0 255 0", 0, null, null);
							Winner += 1;
						}
						else if (RedNum > GreenNum)
						{
							DoEntFire(LightRoundName, "Color", "255 0 0", 0, null, null);
							Winner -= 1;
						}
					}
					CurrentRound += 1;
					LightRoundName = "LightRound"+CurrentRound.tostring();
					if (CurrentRound == 11 || Winner > 10 || Winner < -10)
					{
						RestartFight();
						AWQueueTimerFunc(0, "EndMap");
						Start = false;
						return;
					}
					while ((LightRound = Entities.FindByName(LightRound, LightRoundName)) != null)
					{
						DoEntFire(LightRoundName, "Color", "255 255 0", 0, null, null);
					}
				}
				timeEnd = 0;
				RestartFight();
			}
		}
		
		// local hPlayer = null;
		// while ((hPlayer = Entities.FindByClassname(hPlayer, "player")) != null)
		// {
			// AWGoldCount("", hPlayer);
		// }
		while ((hPlayer = Entities.FindByClassname(hPlayer, "player")) != null)
		{
			local hMarine2 = NetProps.GetPropEntity(hPlayer, "m_hMarine");
			if (hMarine2 == null || !hMarine2.IsValid())
			{
				hMarine2 = NetProps.GetPropEntity(hPlayer, "m_hSpectatingMarine");
			}
			// local PlayerClient = GetClientXUID(hPlayer);
			local TextToSend = "";
			// local faction = "";
			// if (hMarine != null && hMarine.IsValid())
			// {
				// faction = MarineTeamList[hMarine.GetMarineName()];
			// }
			// else
			// {
				// return;
			// }
			if (!BattleStart)
			{
				local hWeaponAct = NetProps.GetPropEntity(hMarine2, "m_hActiveWeapon");
				if (hWeaponAct != null && RemoveWeapon)
				{
					hWeaponAct.SetClip1(1);
					hWeaponAct.SetClip2(0);
					hWeaponAct.SetClips(0);
				}
			}
			
			// TextToSend += "Green = " + GreenNum + " / Red = " + RedNum;
			TextToSend += "Red = " + RedNum + " / Green = " + GreenNum;
			
			AWAlienCount(TextToSend, hPlayer, color);
			AWGoldCount("", hPlayer);
		}
		
		local MarineWithin = null;
		local MarineList = {};
		
		// foreach (idx, val in AWAlienDescTextNum)
		// {
			// if (val != 0)
			// {
				// while((MarineWithin = Entities.FindByClassnameWithin(MarineWithin, "asw_marine", SpawnerWeaponPos[val], 140)) != null)
				// {
					// MarineList[MarineWithin] <- idx;
					// AWAlienDescTextTime[MarineWithin] -= UpdateRate;
					// if (AWAlienDescTextTime[MarineWithin] <= 0)
					// {
						// StartTouch(val);
					// }
				// }
			// }
		// }
		// local OutMarine = null;
		// while((OutMarine = Entities.FindByClassname(OutMarine, "asw_marine")) != null)
		// {
			// if (!(MarineList.rawin(OutMarine)) && OutMarine.IsInhabited())
			// {
				// if (!AWAlienDescTextNum.rawin(OutMarine) || AWAlienDescTextNum[OutMarine] != 0)
				// {
					// AWAlienDescTextNum[OutMarine] <- 0;
					// AWAlienDescTextTime[OutMarine] <- HoldTime;
				// }
				// AWAlienDescTextTime[OutMarine] -= UpdateRate;
				// if (AWAlienDescTextTime[OutMarine] <= 0)
				// {
					// ShowAlienDesc("", OutMarine, OutMarine.GetCommander(), color);
					// AWAlienDescTextTime[OutMarine] <- HoldTime;
				// }
			// }
		// }
		
		foreach (idx, val in SpawnerWeaponPos)
		{
			while((MarineWithin = Entities.FindByClassnameWithin(MarineWithin, "asw_marine", val, 140)) != null)
			{
				MarineList[MarineWithin] <- idx;
				GiveHint(idx);
			}
		}
		local OutMarine = null;
		while((OutMarine = Entities.FindByClassname(OutMarine, "asw_marine")) != null)
		{
			if (!(MarineList.rawin(OutMarine)) && OutMarine.IsInhabited())
			{
				ShowAlienDesc("", OutMarine, OutMarine.GetCommander(), color);
			}
		}
		// return UpdateRate;
	}
	else
	{
		if (!lobbyError)
		{
			local challname = Convars.GetStr("rd_challenge");
			local challonsl = Convars.GetStr("asw_horde_override");
			// local challff = Convars.GetStr("asw_marine_ff_absorption");
			if (challname != "0")
			{
				ClientPrint(null, 3, "This map can only be played in vanilla");
				ClientPrint(null, 3, "Reseting challenge");
				Convars.SetValueString("rd_challenge", "0");
			}
			if (challonsl != "0")
			{
				ClientPrint(null, 3, "This map can't be played with onslaught");
				ClientPrint(null, 3, "Reseting onslaught");
				Convars.SetValueString( "asw_horde_override", "0" );
				Convars.SetValueString( "asw_wanderer_override", "0" );
				local fuckyou = Convars.GetStr("asw_horde_override");
				if (fuckyou == "1")
				{
					ClientPrint(null, 3, "ERROR: Onslaught not resetted");
					ClientPrint(null, 3, "Disable challenge manually to fix!");
				}
			}
			// if (challff != "1")
			// {
				// ClientPrint(null, 3, "This map can't be played with hardcore");
				// ClientPrint(null, 3, "Reseting friendly fire");
				// Convars.SetValueString( "asw_marine_ff_absorption", "1" );
				// Convars.SetValueString( "asw_marine_ff", "1" );
				// Convars.SetValueString( "asw_marine_death_protection", "1" );
				// Convars.SetValueString( "asw_marine_ff_dmg_base", "1" );
			// }
		}
	}
	return UpdateRate;
}

::AWQueueTimerFunc <- function(time = 0, func = "", param = "", param2 = "", param3 = "", param4 = "", param5 = "")
{
	if (SlowCreatorArray.len() > 0)
	{
		// printl("yes " + SlowCreatorArray.len());
		SlowArrayCheck <- {};
		local Area1 = 1000;
		local Area2 = 500;
		// local Factor1 = 2;
		// local Factor2 = 100;
		foreach (idx, val in SlowCreatorArray)
		{
			if (idx != null && idx.IsValid())
			{
				local SlowedAlien = null;
				local CreatorFaction = NetProps.GetPropInt(idx, "m_nFaction");
				// printl(idx);
				if (CreatorFaction == 0)
				{
					break;
				}
				while((SlowedAlien = Entities.FindByClassnameWithin(SlowedAlien, "asw_drone", idx.GetOrigin(), Area1)) != null)
				{
					if (idx == null || !idx.IsValid())
					{
						break;
					}
					// printl("slow " + SlowedAlien + " - " + val);
					local EntToBuffSpeed = (NetProps.GetPropFloat(SlowedAlien, "m_fSpeedScale"));
					local EntToBuffFaction = NetProps.GetPropInt(SlowedAlien, "m_nFaction");
					// printl(CreatorFaction + " != " + EntToBuffFaction);
					if (!SlowArrayCheck.rawin(SlowedAlien))
					{
						SlowArrayCheck[SlowedAlien] <- {};
						SlowArrayCheck[SlowedAlien]["avg"] <- 1;
					}
					
					if (EntToBuffFaction != CreatorFaction && val < 1)
					{
						SlowArrayCheck[SlowedAlien][val] <- 1;
						// if (!SlowArray.rawin(SlowedAlien) || !SlowArrayCheck[SlowedAlien].rawin(val))
						// {
							// NetProps.SetPropFloat(SlowedAlien, "m_fSpeedScale", EntToBuffSpeed);
							// SlowArray[SlowedAlien] <- SlowArrayCheck[SlowedAlien]["avg"];
							// printl(SlowedAlien + " " + CreatorFaction + " - " + NetProps.GetPropFloat(SlowedAlien, "m_fSpeedScale") + " val = " + SlowArrayCheck[SlowedAlien]["avg"]);
						// }
					}
					if (EntToBuffFaction == CreatorFaction && val > 1)
					{
						SlowArrayCheck[SlowedAlien][val] <- 1;
						// if (!SlowArray.rawin(SlowedAlien) || !SlowArrayCheck[SlowedAlien].rawin(val))
						// {
							// NetProps.SetPropFloat(SlowedAlien, "m_fSpeedScale", EntToBuffSpeed);
							// SlowArray[SlowedAlien] <- SlowArrayCheck[SlowedAlien]["avg"];
							// printl(SlowedAlien + " " + CreatorFaction + " - " + NetProps.GetPropFloat(SlowedAlien, "m_fSpeedScale") + " val = " + SlowArrayCheck[SlowedAlien]["avg"]);
						// }
					}
					
					if (SlowArrayCheck[SlowedAlien].rawin("avg") && SlowArrayCheck[SlowedAlien].len() != 1)
					{
						EntToBuffSpeed /= SlowArrayCheck[SlowedAlien]["avg"];
						printl("DEFAULT SPEED = " + EntToBuffSpeed);
						local MakeAVG = 1;
						foreach (speedidx, speedval in SlowArrayCheck[SlowedAlien])
						{
							if (speedidx != "avg")
							{
								MakeAVG *= speedidx;
							}
						}
						SlowArrayCheck[SlowedAlien]["avg"] <- MakeAVG;
						EntToBuffSpeed *= MakeAVG;
						printl(SlowedAlien + " - avg = " + MakeAVG + " --- " + EntToBuffSpeed + " len " + SlowArrayCheck[SlowedAlien].len());
						
						if (!SlowArray.rawin(SlowedAlien) || SlowArray[SlowedAlien] != SlowArrayCheck[SlowedAlien]["avg"])
						{
							NetProps.SetPropFloat(SlowedAlien, "m_fSpeedScale", EntToBuffSpeed);
							SlowArray[SlowedAlien] <- SlowArrayCheck[SlowedAlien]["avg"];
							// printl(SlowedAlien + " " + CreatorFaction + " - " + NetProps.GetPropFloat(SlowedAlien, "m_fSpeedScale") + " val = " + SlowArrayCheck[SlowedAlien]["avg"]);
						}
					}
				}
			}
			else
			{
				SlowCreatorArray.rawdelete(idx);
			}
		}
		foreach (idx, val in SlowArray)
		{
			if (idx == null || !idx.IsValid())
			{
				try
				{
				SlowArray.rawdelete(idx);
				}
				catch(error)
				{
					printl(error);
				}
				break;
			}
			if (!SlowArrayCheck.rawin(idx) || SlowArrayCheck[idx]["avg"] != val)
			{
				local EntToBuffSpeed = (NetProps.GetPropFloat(idx, "m_fSpeedScale") / SlowArray[idx]);
				NetProps.SetPropFloat(idx, "m_fSpeedScale", EntToBuffSpeed);
				SlowArray.rawdelete(idx);
				printl(idx + " DELETED - " + NetProps.GetPropFloat(idx, "m_fSpeedScale"));
			}
			/*else if (SlowArrayCheck[idx]["avg"] != val)
			{
				// local EntToBuffSpeed = (NetProps.GetPropFloat(idx, "m_fSpeedScale") / val);
				// NetProps.SetPropFloat(idx, "m_fSpeedScale", EntToBuffSpeed);
				SlowArrayCheck[idx].rawdelete(val);
				// printl(idx + " DELETED2 - " + NetProps.GetPropFloat(idx, "m_fSpeedScale"));
			}*/
		}
	}
	if (func == "Restart")
	{
		AWTimers["Restart"] = true;
		timeRestart <- time;
	}
	if (AWTimers["Restart"])
	{
		ClientPrint(null, 4, "Restarting in " + timeRestart.tointeger() + "sec");
		if (timeRestart <= 0)
		{
			Director.RestartMission();
		}
		timeRestart -= 1;
	}
	if (func == "Special")
	{
		AWTimers["Special"] = true;
		SpecialTimers[param] <- time;
		SpecialType[param] <- param2;
	}
	if (AWTimers["Special"])
	{
		local SpecialLen = SpecialTimers.len();
		if (SpecialLen < 1)
		{
			AWTimers["Special"] = false;
			return;
		}
		foreach(idx, val in SpecialTimers)
		{
			if (idx != null && idx.IsValid())
			{
				SpecialTimers[idx] -= 1;
				if (idx != null && idx.IsAlien())
				{
					if (SpecialType[idx] == "Push")
					{
						if (SpecialTimers[idx] > 0)
						{
							PushAway(idx, 50, 10000, 500);
							// StompCharge(idx);
						}
						else
						{
							SpecialTimers.rawdelete(idx);
							SpecialType.rawdelete(idx);
							StompEffectOn[idx] = 0;
						}
					}
				}
			}
			else
			{
				SpecialTimers.rawdelete(idx);
				SpecialType.rawdelete(idx);
			}
		}
	}
	if (func == "Buff")
	{
		AWTimers["Buff"] = true;
		BuffTimers[param] <- time;
	}
	if (AWTimers["Buff"])
	{
		local BuffLen = BuffTimers.len();
		if (BuffLen < 1)
		{
			AWTimers["Buff"] = false;
			return;
		}
		foreach(idx, val in BuffTimers)
		{
			if (idx != null && idx.IsValid())
			{
				BuffTimers[idx] -= 1;
				if (idx != null && idx.IsAlien() && BuffTimers[idx] <= 0 && OldHP.rawin(idx))
				{
					local IsFighting = true;
					local EntToBuffPos = idx.GetOrigin();
					local EntToBuffFaction = NetProps.GetPropInt(idx, "m_nFaction");
					// local EntToBuffFaction2 = NetProps.GetPropInt(idx, "m_nFaction");
					local EntToBuffSize = NetProps.GetPropFloat(idx, "m_fSizeScale");
					local EntToBuffSpeed = NetProps.GetPropFloat(idx, "m_fSpeedScale");
					local EntToBuffCurrHP = idx.GetHealth();
					local EntToBuffCurrMaxHP = idx.GetMaxHealth();
					local EntToBuffName = idx.GetName();
					
					local BuffedEnt = Entities.CreateByClassname(idx.GetClassname());
					BuffedEnt.SetOrigin(EntToBuffPos);
					// NetProps.SetPropInt(BuffedEnt, "m_iHealthBonus", 0);
					NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize/BuffMultSize);
					NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed/BuffMultSpeed);
					if (EntToBuffFaction == 1)
					{
						EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
						GreenAlienEnt.rawdelete(idx);
						GreenAlienEnt[BuffedEnt] <- 1;
					}
					else if (EntToBuffFaction == 2)
					{
						EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 255", 0, this, this);
						RedAlienEnt.rawdelete(idx);
						RedAlienEnt[BuffedEnt] <- 1;
					}
					else
					{
						EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 100 100 100", 0, this, this);
						GreyAlienEnt.rawdelete(idx);
						GreyAlienEnt[BuffedEnt] <- 1;
					}
					if (StasisTimers.rawin(idx))
					{											
						StasisTimers[BuffedEnt] <- StasisTimers[idx];
						StasisTimers.rawdelete(idx);
						StasisFaction[BuffedEnt] <- StasisFaction[idx];
						StasisFaction.rawdelete(idx);
						BuffedEnt.Wake(false);
						IsFighting = false;
					}
					if (StealTimers.rawin(idx))
					{
						StealTimers[BuffedEnt] <- StealTimers[idx];
						StealTimers.rawdelete(idx);
						StealFaction[BuffedEnt] <- StealFaction[idx];
						StealFaction.rawdelete(idx);
						// if (EntToBuffFaction == 1)
						// {
							// EntToBuffFaction2 = 2;
						// }
						// else
						// {
							// EntToBuffFaction2 = 1;
						// }
					}
					// if (BuffTimers.rawin(idx))
					// {
						// NetProps.SetPropInt(BuffedEnt, "m_iHealthBonus", EntToBuffHP);
						// NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
						// NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
											
						// BuffTimers[BuffedEnt] <- BuffTimers[idx];
						// BuffTimers.rawdelete(idx);
					// }
					
					local Stun1 = NetProps.GetPropFloat(idx, "m_flElectroStunSlowMoveTime");
					local Stun2 = NetProps.GetPropInt(idx, "m_bElectroStunned");
					local Fire = NetProps.GetPropInt(idx, "m_bOnFire");
					local Ice = NetProps.GetPropFloat(idx, "m_flFrozenTime");
					local Ice2 = NetProps.GetPropFloat(idx, "m_flFreezeResistance");
					
					if (SlowCreatorArray.rawin(idx))
					{
						SlowCreatorArray[BuffedEnt] <- SlowCreatorArray[idx];
						SlowCreatorArray.rawdelete(idx);
					}
					
					BuffedEnt.Spawn();
					BuffedEnt.Activate();
					// if (EntToBuffName == "Special1" || EntToBuffName == "Special2" || EntToBuffName == "Special3")
					// {
						// BuffedEnt.SetModel("models/aliens/droaw/dron2.mdl");
					// }
					// if (EntToBuffName == "Special4" || EntToBuffName == "Special5" || EntToBuffName == "Special6")
					// {
						// BuffedEnt.SetModel("models/aliens/droaw/dron1.mdl");
					// }
					// if (EntToBuffName == "Special7" || EntToBuffName == "Special8")
					// {
						// BuffedEnt.SetModel("models/aliens/droaw/droaw.mdl");
					// }
					NetProps.SetPropInt(BuffedEnt, "m_nFaction", EntToBuffFaction);
					NetProps.SetPropFloat(BuffedEnt, "m_flElectroStunSlowMoveTime", Stun1);
					NetProps.SetPropInt(BuffedEnt, "m_bElectroStunned", Stun2);
					NetProps.SetPropInt(BuffedEnt, "m_bOnFire", Fire);
					// NetProps.SetPropFloat(BuffedEnt, "m_flFrozenTime", Ice);
					NetProps.SetPropFloat(BuffedEnt, "m_flFreezeResistance", Ice2);
					local CurrentTime = Ice - Time();
					if (CurrentTime > 0)
					{
						BuffedEnt.Freeze(CurrentTime);
					}
					
					BuffedEnt.Wake(IsFighting);
					BuffedEnt.SetName(EntToBuffName);
					
					// if (OldHP.rawin(idx))
					// {
						// OldHP[BuffedEnt] <- EntToBuffCurrHP;
						// OldHP.rawdelete(idx);
					// }
					// local NewHP = floor(EntToBuffCurrHP / BuffMultHP);
					local NewHP = EntToBuffCurrHP;
					// if (NewHP > EntToBuffCurrMaxHP)
					if (NewHP > OldHP[idx])
					{
						NewHP = OldHP[idx];
						// NewHP = EntToBuffCurrMaxHP;
					}
					// local NewMaxHP = floor(EntToBuffCurrMaxHP / BuffMultHP);
					local NewMaxHP = EntToBuffCurrMaxHP;
					// local NewHP = EntToBuffCurrHP - BuffHP;
					// if (NewHP < 0)
					// {
						// NewHP = 1;
					// }
					
					BuffedEnt.SetHealth(NewHP);
					BuffedEnt.SetMaxHealth(NewMaxHP);
					MakeDemDrones("model", BuffedEnt);
					MakeDemDrones("flinch", BuffedEnt);
					// MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction2);
					MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction);
					
					DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt);
					
					BuffTimers.rawdelete(idx);
					idx.Destroy();
				}
			}
			else
			{
				BuffTimers.rawdelete(idx);
			}
		}
	}
	if (func == "Stasis")
	{
		AWTimers["Stasis"] = true;
		StasisTimers[param] <- time;
		StasisFaction[param] <- param2;
	}
	if (AWTimers["Stasis"])
	{
		local StasisLen = StasisTimers.len();
		if (StasisLen < 1)
		{
			AWTimers["Stasis"] = false;
			return;
		}
		foreach(idx, val in StasisTimers)
		{
			if (idx != null && idx.IsValid())
			{
				StasisTimers[idx] -= 1;
				// printl("STASIS NUM = "+StasisLen);
				if (idx != null && idx.IsAlien() && StasisTimers[idx] == 0)
				{
					local IsFighting = true;
					local EntToBuffPos = idx.GetOrigin();
					local EntToBuffFaction = StasisFaction[idx];
					// local EntToBuffHP = NetProps.GetPropInt(idx, "m_iHealthBonus");
					local EntToBuffSize = NetProps.GetPropFloat(idx, "m_fSizeScale");
					local EntToBuffSpeed = NetProps.GetPropFloat(idx, "m_fSpeedScale");
					local EntToBuffCurrHP = idx.GetHealth();
					local EntToBuffCurrMaxHP = idx.GetMaxHealth();
					local EntToBuffName = idx.GetName();
					
					local BuffedEnt = Entities.CreateByClassname(idx.GetClassname());
					BuffedEnt.SetOrigin(EntToBuffPos);
					NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
					NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
								
					if (EntToBuffFaction == 1)
					{
						EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
						GreenAlienEnt[BuffedEnt] <- 1;
					}
					else
					{
						EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 255 0 0", 0, this, this);
						RedAlienEnt[BuffedEnt] <- 1;
					}
					if (GreenAlienEnt.rawin(idx))
					{
						GreenAlienEnt.rawdelete(idx);
					}
					else if (RedAlienEnt.rawin(idx))
					{
						RedAlienEnt.rawdelete(idx);
					}
					else
					{
						GreyAlienEnt.rawdelete(idx);
					}
					
					// if (StasisTimers.rawin(idx))
					// {											
						// StasisTimers[BuffedEnt] <- StasisTimers[idx];
						// StasisTimers.rawdelete(idx);
						// StasisFaction[BuffedEnt] <- StasisFaction[idx];
						// StasisFaction.rawdelete(idx);
						// IsFighting = false;
						// BuffedEnt.Wake(false);
					// }
					if (StealTimers.rawin(idx))
					{
						StealTimers[BuffedEnt] <- StealTimers[idx];
						StealTimers.rawdelete(idx);
						StealFaction[BuffedEnt] <- StealFaction[idx];
						StealFaction.rawdelete(idx);
					}
					if (BuffTimers.rawin(idx))
					{
						// NetProps.SetPropInt(BuffedEnt, "m_iHealthBonus", EntToBuffHP);
						// NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
						// NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
						BuffTimers[BuffedEnt] <- BuffTimers[idx];
						BuffTimers.rawdelete(idx);
					}
					if (OldHP.rawin(idx))
					{
						OldHP[BuffedEnt] <- EntToBuffCurrHP;
						OldHP.rawdelete(idx);
					}
					
					local Stun1 = NetProps.GetPropFloat(idx, "m_flElectroStunSlowMoveTime");
					local Stun2 = NetProps.GetPropInt(idx, "m_bElectroStunned");
					local Fire = NetProps.GetPropInt(idx, "m_bOnFire");
					local Ice = NetProps.GetPropFloat(idx, "m_flFrozenTime");
					local Ice2 = NetProps.GetPropFloat(idx, "m_flFreezeResistance");
					
					if (SlowCreatorArray.rawin(idx))
					{
						SlowCreatorArray[BuffedEnt] <- SlowCreatorArray[idx];
						SlowCreatorArray.rawdelete(idx);
					}
					
					BuffedEnt.Spawn();
					BuffedEnt.Activate();
					// if (EntToBuffName == "Special1" || EntToBuffName == "Special2" || EntToBuffName == "Special3")
					// {
						// BuffedEnt.SetModel("models/aliens/droaw/dron2.mdl");
					// }
					// if (EntToBuffName == "Special4" || EntToBuffName == "Special5" || EntToBuffName == "Special6")
					// {
						// BuffedEnt.SetModel("models/aliens/droaw/dron1.mdl");
					// }
					// if (EntToBuffName == "Special7" || EntToBuffName == "Special8")
					// {
						// BuffedEnt.SetModel("models/aliens/droaw/droaw.mdl");
					// }
					NetProps.SetPropInt(BuffedEnt, "m_nFaction", EntToBuffFaction);
					NetProps.SetPropFloat(BuffedEnt, "m_flElectroStunSlowMoveTime", Stun1);
					NetProps.SetPropInt(BuffedEnt, "m_bElectroStunned", Stun2);
					NetProps.SetPropInt(BuffedEnt, "m_bOnFire", Fire);
					// NetProps.SetPropFloat(BuffedEnt, "m_flFrozenTime", Ice);
					NetProps.SetPropFloat(BuffedEnt, "m_flFreezeResistance", Ice2);
					local CurrentTime = Ice - Time();
					if (CurrentTime > 0)
					{
						BuffedEnt.Freeze(CurrentTime);
					}
					
					BuffedEnt.Wake(IsFighting);
					BuffedEnt.SetName(EntToBuffName);
					BuffedEnt.SetHealth(EntToBuffCurrHP);
					BuffedEnt.SetMaxHealth(EntToBuffCurrMaxHP);
					MakeDemDrones("model", BuffedEnt);
					MakeDemDrones("flinch", BuffedEnt);
					MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction);
					
					DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt);
					
					StasisTimers.rawdelete(idx);
					StasisFaction.rawdelete(idx);
					idx.Destroy();
				}
			}
			else
			{
				StasisTimers.rawdelete(idx);
				StasisFaction.rawdelete(idx);
			}
		}
	}
	if (func == "Steal")
	{
		AWTimers["Steal"] = true;
		StealTimers[param] <- time;
		StealFaction[param] <- param2;
	}
	if (AWTimers["Steal"])
	{
		local StealLen = StealTimers.len();
		// printl("LEN="+StealLen);
		if (StealLen < 1)
		{
			AWTimers["Steal"] = false;
			return;
		}
		foreach(idx, val in StealTimers)
		{
			if (idx != null && idx.IsValid())
			{
				StealTimers[idx] -= 1;
				// printl("STEAL"+idx+"="+val+"========"+StealTimers[idx]);
				if (idx != null && idx.IsAlien() && StealTimers[idx] == 0)
				{
					local IsFighting = true;
					local EntToBuffPos = idx.GetOrigin();
					local EntToBuffFaction = NetProps.GetPropInt(idx, "m_nFaction");
					// local EntToBuffHP = NetProps.GetPropInt(idx, "m_iHealthBonus");
					local EntToBuffSize = NetProps.GetPropFloat(idx, "m_fSizeScale");
					local EntToBuffSpeed = NetProps.GetPropFloat(idx, "m_fSpeedScale");
					local EntToBuffCurrHP = idx.GetHealth();
					local EntToBuffCurrMaxHP = idx.GetMaxHealth();
					local EntToBuffName = idx.GetName();
					
					local BuffedEnt = Entities.CreateByClassname(idx.GetClassname());
					BuffedEnt.SetOrigin(EntToBuffPos);
					NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
					NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
					
					if (EntToBuffFaction != 0)
					{
						local faction = 1;
						if (EntToBuffFaction == 1)
						{
							faction = 2;
						}
						
						if (faction == 1)
						{
							EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
							GreenAlienEnt[BuffedEnt] <- 1;
						}
						else
						{
							EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 255", 0, this, this);
							RedAlienEnt[BuffedEnt] <- 1;
						}
						if (GreenAlienEnt.rawin(idx))
						{
							GreenAlienEnt.rawdelete(idx);
						}
						else if (RedAlienEnt.rawin(idx))
						{
							RedAlienEnt.rawdelete(idx);
						}
						else
						{
							GreyAlienEnt.rawdelete(idx);
						}
						
						if (StasisTimers.rawin(idx))
						{											
							StasisTimers[BuffedEnt] <- StasisTimers[idx];
							StasisTimers.rawdelete(idx);
							StasisFaction[BuffedEnt] <- StasisFaction[idx];
							StasisFaction.rawdelete(idx);
							GreyAlienEnt[BuffedEnt] <- 1;
							IsFighting = false;
						}
						// if (StealTimers.rawin(idx))
						// {											
							// StealTimers[BuffedEnt] <- StealTimers[idx];
							// StealTimers.rawdelete(idx);
							// StealFaction[BuffedEnt] <- StealFaction[idx];
							// StealFaction.rawdelete(idx);
						// }
						if (BuffTimers.rawin(idx))
						{
							// NetProps.SetPropInt(BuffedEnt, "m_iHealthBonus", EntToBuffHP);
							// NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
							// NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
							BuffTimers[BuffedEnt] <- BuffTimers[idx];
							BuffTimers.rawdelete(idx);
						}
						if (OldHP.rawin(idx))
						{
							OldHP[BuffedEnt] <- EntToBuffCurrHP;
							OldHP.rawdelete(idx);
						}
						
						local Stun1 = NetProps.GetPropFloat(idx, "m_flElectroStunSlowMoveTime");
						local Stun2 = NetProps.GetPropInt(idx, "m_bElectroStunned");
						local Fire = NetProps.GetPropInt(idx, "m_bOnFire");
						local Ice = NetProps.GetPropFloat(idx, "m_flFrozenTime");
						local Ice2 = NetProps.GetPropFloat(idx, "m_flFreezeResistance");
						
						if (SlowCreatorArray.rawin(idx))
						{
							SlowCreatorArray[BuffedEnt] <- SlowCreatorArray[idx];
							SlowCreatorArray.rawdelete(idx);
						}
					
						BuffedEnt.Spawn();
						BuffedEnt.Activate();
						// if (EntToBuffName == "Special1" || EntToBuffName == "Special2" || EntToBuffName == "Special3")
						// {
							// BuffedEnt.SetModel("models/aliens/droaw/dron2.mdl");
						// }
						// if (EntToBuffName == "Special4" || EntToBuffName == "Special5" || EntToBuffName == "Special6")
						// {
							// BuffedEnt.SetModel("models/aliens/droaw/dron1.mdl");
						// }
						// if (EntToBuffName == "Special7" || EntToBuffName == "Special8")
						// {
							// BuffedEnt.SetModel("models/aliens/droaw/droaw.mdl");
						// }
						NetProps.SetPropInt(BuffedEnt, "m_nFaction", faction);
						NetProps.SetPropFloat(BuffedEnt, "m_flElectroStunSlowMoveTime", Stun1);
						NetProps.SetPropInt(BuffedEnt, "m_bElectroStunned", Stun2);
						NetProps.SetPropInt(BuffedEnt, "m_bOnFire", Fire);
						// NetProps.SetPropFloat(BuffedEnt, "m_flFrozenTime", Ice);
						NetProps.SetPropFloat(BuffedEnt, "m_flFreezeResistance", Ice2);
						local CurrentTime = Ice - Time();
						if (CurrentTime > 0)
						{
							BuffedEnt.Freeze(CurrentTime);
						}
					
						BuffedEnt.Wake(IsFighting);
						BuffedEnt.SetName(EntToBuffName);
						BuffedEnt.SetHealth(EntToBuffCurrHP);
						BuffedEnt.SetMaxHealth(EntToBuffCurrMaxHP);
						MakeDemDrones("model", BuffedEnt);
						MakeDemDrones("flinch", BuffedEnt);
						MakeDemDrones("hpbar", BuffedEnt, faction);
						
						DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt);
						
						StealTimers.rawdelete(idx);
						StealFaction.rawdelete(idx);
						idx.Destroy();
					}
					else
					{
						StealTimers.rawdelete(idx);
						StealFaction.rawdelete(idx);
					}
				}
			}
			else
			{
				StealTimers.rawdelete(idx);
				StealFaction.rawdelete(idx);
			}
		}
	}
	if (func == "Battle")
	{
		AWTimers["Battle"] = true;
		AWGiveBuffGear();
		Debug();
		local hWeapon = null;
		if (RemoveWeapon)
		{
			foreach (idx, val in SpawnerWeaponList)
			{
				while ((hWeapon = Entities.FindByClassname(hWeapon, idx)) != null)
				{
					hWeapon.Destroy();
				}
			}
		}
		// DoEntFire("GoToMiddle", "SendOrders","", 0, null, null);
	}
	if (AWTimers["Battle"])
	{
		// timeBattle -= 1;
		timeRefresh -= 1;
		timeTeleport -= 1;
		// foreach(idx, val in GreenAlienEnt)
		// {
			// printl(idx + " HP = " + idx.GetHealth());
		// }
		// foreach(idx, val in RedAlienEnt)
		// {
			// printl(idx + " HP = " + idx.GetHealth());
		// }
		if (timeTeleport == 0)
		{
			Debug();
			timeTeleport = DefaulttimeTeleport;
			ClientPrint(null, 4, "Teleporting Aliens");
		}
		if (timeRefresh <= 0)
		{
			// DoEntFire("GoToMiddle", "SendOrders","", 0, null, null);
			foreach(idx, val in GreenAlienEnt)
			{
				if (idx.IsValid() && idx != null)
				{
					GoToMiddle(idx, "Green");
				}
			}
			foreach(idx, val in RedAlienEnt)
			{
				if (idx.IsValid() && idx != null)
				{
					GoToMiddle(idx, "Red");
				}
			}
			timeRefresh = DefaulttimeRefresh;
		}
	}
	if (func == "Preparation")
	{
		AWTimers["Preparation"] = true;
	}
	if (AWTimers["Preparation"])
	{
		if (timePrep <= 0)
		{
			AWTimers["Preparation"] = false;
			// Convars.ExecuteConCommand("ai_setenabled 1");
			ClientPrint(null, 4, "Round " + CurrentRound.tostring() + " Begins !");
			BattleStart = true;
			local hMarine = null;
			if (RemoveWeapon)
			{
				while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
				{
					hMarine.RemoveWeapon(0);
					hMarine.RemoveWeapon(1);
					hMarine.RemoveWeapon(2);
				}
			}
			timePrep = DefaulttimePrep;
			timeRefresh = DefaulttimeRefresh;
			timeTeleport = DefaulttimeTeleport;
			timeEnd = DefaulttimeEnd;
			timeEndMap = DefaulttimeEndMap;
			timeDebug = DefaulttimeDebug;
			// DoEntFire("GoToMiddle", "SendOrders","", 0, null, null);
			/// SPEED AURA
			foreach(idx, val in GreenAlienEnt)
			{
				if (idx.IsValid() && idx != null)
				{
					GoToMiddle(idx, "Green");
					if (idx.GetName() == "Special8")
					{
						SlowCreatorArray[idx] <- 0.5;
					}
					if (idx.GetName() == "Special6")
					{
						SlowCreatorArray[idx] <- 0.7;
					}
				}
			}
			foreach(idx, val in RedAlienEnt)
			{
				if (idx.IsValid() && idx != null)
				{
					GoToMiddle(idx, "Red");
					if (idx.GetName() == "Special8")
					{
						SlowCreatorArray[idx] <- 0.5;
					}
				}
			}
			AWQueueTimerFunc(0, "Battle");
			Convars.ExecuteConCommand("ai_setenabled 1");
		}
	}
	if (func == "EndMap")
	{
		AWTimers["EndMap"] = true;
		if (Winner > 0)
		{
			ClientPrint(null, 3, "Green Team Wins!");
		}
		else if (Winner < 0)
		{
			ClientPrint(null, 3, "Red Team Wins!");
		}
		else
		{
			ClientPrint(null, 3, "This is a Draw!");
		}
		// local hMarine = null;
		// while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
		// {
			// if (Winner > 0 && (hMarine.GetMarineName() == "Jaeger" || hMarine.GetMarineName() == "Wolfe" || hMarine.GetMarineName() == "Bastille" || hMarine.GetMarineName() == "Vegas"))
			// {
				// hMarine.Destroy();
			// }
			// else if (Winner < 0 && (hMarine.GetMarineName() == "Sarge" || hMarine.GetMarineName() == "Wildcat" || hMarine.GetMarineName() == "Faith" || hMarine.GetMarineName() == "Crash"))
			// {
				// hMarine.Destroy();
			// }
			// else if (Winner == 0)
			// {
				// hMarine.Destroy();
			// }
		// }
		NotEnd = false;
	}
	if (AWTimers["EndMap"])
	{
		timeEndMap -= 1;
		// if (timeEndMap > 11)
		// {
			// local hMarine = null;
			// while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
			// {
				// local hParticle = CreateParticleFunc(1, hMarine.GetOrigin(), Vector(0, 0, 0), "marine_resurrection_glow2", hMarine);
			// }
		// }
		// else if (timeEndMap == 11)
		// {
			// local hMarine = null;
			// while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
			// {
				// EndPosition[hMarine] <- hMarine.GetOrigin();
			// }
		// }
		if (timeEndMap == 8)
		{
			local DeadMarine = null;
			local Countx = 0;
			local County = 0;
			
			// local GreenEnt = Entities.FindByName(null, "GreenEntity");
			// local RedEnt = Entities.FindByName(null, "RedEntity");
			// EntFireByHandle(RedEnt, "addoutput", "rendercolor 255 0 0", 0, this, this);
			// EntFireByHandle(GreenEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
			while ((DeadMarine = Entities.FindByClassname(DeadMarine, "asw_marine")) != null)
			{
				if (Winner > 0 && MarineTeamList[DeadMarine.GetMarineName()] == 2) // green wins
				{
					DeadMarine.SetOrigin(Vector(1200+Countx,150+County,-1294));
					DeadMarine.SetHealth(10);
					// DeadMarine.Destroy();
					// NetProps.SetPropInt(DeadMarine, "m_nFaction", 1);
				}
				else if (Winner < 0 && MarineTeamList[DeadMarine.GetMarineName()] == 1) // red wins
				{
					DeadMarine.SetOrigin(Vector(1200+Countx,150+County,-1294));
					DeadMarine.SetHealth(10);
					// DeadMarine.Destroy();
					// NetProps.SetPropInt(DeadMarine, "m_nFaction", 1);
				}
				else if (Winner == 0)
				{
					DeadMarine.SetOrigin(Vector(1200+Countx,150+County,-1294));
					DeadMarine.SetHealth(10);
					// DeadMarine.TakeDamage(10, 64, null);
					// DeadMarine.Destroy();
					// NetProps.SetPropInt(DeadMarine, "m_nFaction", 1);
				}
				// Countx += 160;
				// if (Countx > 480)
				Countx -= 160;
				if (Countx < -480)
				{
					County = 160;
					Countx = 0;
				}
				// if (Winner > 0)
				// {
					// NetProps.SetPropInt(GreenEnt, "m_nFaction", 1);
					// EntFireByHandle(RedEnt, "SetHealth", "1", 0, null, RedEnt);
					// EntFireByHandle(GreenEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
					// EntFireByHandle(RedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
				// }
				// else
				// {
					// NetProps.SetPropInt(RedEnt, "m_nFaction", 1);
					// EntFireByHandle(GreenEnt, "SetHealth", "1", 0, null, GreenEnt);
					// EntFireByHandle(GreenEnt, "addoutput", "rendercolor 255 0 0", 0, this, this);
					// EntFireByHandle(RedEnt, "addoutput", "rendercolor 255 0 0", 0, this, this);
				// }
			}
			Convars.ExecuteConCommand("ai_setenabled 1");
			local triggermul = Entities.FindByName(null, "CamTrigger");
			DoEntFire("!self", "FireUser1", "", 0, triggermul, triggermul);
			Convars.SetValue("asw_controls", 1);
			
			// local GreenEnt = Entities.FindByName(null, "GreenEntity");
			// local RedEnt = Entities.FindByName(null, "RedEntity");
			// printl(GreenEnt);
			// EntFireByHandle(RedEnt, "addoutput", "rendercolor 255 0 0", 0, this, this);
			// EntFireByHandle(GreenEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
			// if (Winner > 0)
			// {
				// EntFireByHandle(RedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
			// }
			// else if (Winner < 0)
			// {
				// EntFireByHandle(GreenEnt, "addoutput", "rendercolor 255 0 0", 0, this, this);
			// }
			// local GreenEnt = Entities.FindByName(null, "GreenEntity");
			// local RedEnt = Entities.FindByName(null, "RedEntity");
			// EntFireByHandle(RedEnt, "addoutput", "rendercolor 255 0 0", 0, this, this);
			// EntFireByHandle(GreenEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
			// EntFireByHandle(RedEnt, "SetRelationship", "asw_marine D_NU 1", 0, null, RedEnt);
			// EntFireByHandle(GreenEnt, "SetRelationship", "asw_marine D_NU 1", 0, null, GreenEnt);
			
		}
		else if (timeEndMap < 8 && timeEndMap >= 0)
		{
			if (timeEndMap == 7)
			{
				local GreenEnt = Entities.FindByName(null, "GreenEntity");
				local RedEnt = Entities.FindByName(null, "RedEntity");
				EntFireByHandle(RedEnt, "addoutput", "rendercolor 255 0 0", 0, this, this);
				EntFireByHandle(GreenEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
				if (Winner > 0)
				{
					EntFireByHandle(RedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
				}
				else if (Winner < 0)
				{
					EntFireByHandle(GreenEnt, "addoutput", "rendercolor 255 0 0", 0, this, this);
				}
			}
			
			local DeadMarine = null;
			while ((DeadMarine = Entities.FindByClassname(DeadMarine, "asw_marine")) != null)
			{
				if (Winner > 0 && MarineTeamList[DeadMarine.GetMarineName()] == 2) // green wins
				{
					// DeadMarine.SetOrigin(Vector(943,260,-1294));
					// DeadMarine.SetHealth(10);
					DeadMarine.TakeDamage(30, 64, null);
					// DeadMarine.Destroy();
					// NetProps.SetPropInt(DeadMarine, "m_nFaction", 1);
				}
				else if (Winner < 0 && MarineTeamList[DeadMarine.GetMarineName()] == 1) // red wins
				{
					// DeadMarine.SetOrigin(Vector(943,260,-1294));
					// DeadMarine.SetHealth(10);
					DeadMarine.TakeDamage(30, 64, null);
					// DeadMarine.Destroy();
					// NetProps.SetPropInt(DeadMarine, "m_nFaction", 1);
				}
				else if (Winner == 0)
				{
					// DeadMarine.SetOrigin(Vector(943,260,-1294));
					// DeadMarine.SetHealth(10);
					DeadMarine.TakeDamage(30, 64, null);
					// DeadMarine.Destroy();
					// NetProps.SetPropInt(DeadMarine, "m_nFaction", 1);
				}
			}
			
			// Convars.SetValue("asw_controls", 1);
		}
		else if (timeEndMap < 0)
		{
			FinishMap();
		}
	}
	if (func == "Debug")
	{
		AWTimers["Debug"] = true;
		timeDebug = time;
	}
	if (AWTimers["Debug"])
	{
		timeDebug -= 1;
		if (timeDebug <= 0)
		{
			Debug2();
		}
	}
}

::CreateParticleFunc <- function(arg_flAliveTime, arg_vecOrigin, arg_vecAngles, arg_strParticleClass, arg_Attach, arg_Delay, arg_hParent)
{
	local hParticle = Entities.CreateByClassname("info_particle_system");
	hParticle.__KeyValueFromString("effect_name", arg_strParticleClass);
	hParticle.__KeyValueFromString("start_active", "1");
	hParticle.SetOrigin(arg_vecOrigin);
	hParticle.SetAnglesVector(arg_vecAngles);
	hParticle.SetOwner(arg_hParent);
	hParticle.Spawn();
	hParticle.Activate();
	if (arg_hParent != "")
		DoEntFire("!self", "SetParent", "!activator", arg_Delay, arg_hParent, hParticle);
	if (arg_Attach != "")
		DoEntFire("!self", "SetParentAttachment", arg_Attach, arg_Delay, arg_hParent, hParticle);
	if (arg_flAliveTime != "")
	    DoEntFire("!self", "Kill", "", arg_flAliveTime, null, hParticle);
	return hParticle;
}

::Tip <- function()
{
	local LastRandomTip = 4;
	local RandomTip = RandomInt( 0, LastRandomTip );
	local message = "";
	if (LastTip == RandomTip)
	{
		if (RandomTip == LastRandomTip)
		{
			RandomTip = 0;
		}
		else
		{
			RandomTip += 1;
		}
	}
	if (RandomTip == 0)
	{
		message = "Tip : You can change hpbar settings by writing in chat : &hpbar";
	}
	else if (RandomTip == 1)
	{
		message = "Tip : You don't need to spend all your gold, you can save it for later rounds!";
	}
	else if (RandomTip == 2)
	{
		message = "Tip : Each class has a different ability with the sniper rifle";
	}
	else if (RandomTip == 3)
	{
		message = "Tip : Buffs only last " + BuffTime + " sec, make it count!";
	}
	else if (RandomTip == 4)
	{
		message = "Tip : Write &tips to remove the tips!";
	}
	else if (RandomTip == 5)
	{
		message = "Tip : ";
	}
	LastTip = RandomTip;
	ClientPrint(null, 3, message);
}

::FreeFight <- function()
{
	if (EverythingFree == "OFF")
	{
		SpawnerWeaponGold["Special1"] <- 0; // fodder
		SpawnerWeaponGold["Special2"] <- 0; // regular
		SpawnerWeaponGold["Special3"] <- 0; // medium tank
		SpawnerWeaponGold["Special4"] <- 0; // medium attacker
		SpawnerWeaponGold["Special5"] <- 0; // fat tank
		SpawnerWeaponGold["Special6"] <- 0; // assassin
		SpawnerWeaponGold["Special7"] <- 0; // queen
		SpawnerWeaponGold["Special8"] <- 0; // king
		ClientPrint(null, 3, "Everything is now FREE!!!");
		EverythingFree = "ON";
	}
	else if (EverythingFree == "ON")
	{
		SpawnerWeaponGold["Special1"] <- 1; // fodder
		SpawnerWeaponGold["Special2"] <- 2; // regular
		SpawnerWeaponGold["Special3"] <- 5; // medium tank
		SpawnerWeaponGold["Special4"] <- 7; // medium attacker
		SpawnerWeaponGold["Special5"] <- 15; // fat tank
		SpawnerWeaponGold["Special6"] <- 20; // assassin
		SpawnerWeaponGold["Special7"] <- 50; // queen
		SpawnerWeaponGold["Special8"] <- 50; // king
		ClientPrint(null, 3, "Price is back to normal");
		EverythingFree = "OFF";
	}
}

::HPBarToggle <- function(type)
{
	if (type == "Default")
	{
		SpecialHPBAR["Special1"] <- 0; // fodder
		SpecialHPBAR["Special2"] <- 0; // regular
		SpecialHPBAR["Special3"] <- 0; // medium tank
		SpecialHPBAR["Special4"] <- 0; // medium attacker
		SpecialHPBAR["Special5"] <- 1; // fat tank
		SpecialHPBAR["Special6"] <- 0; // assassin
		SpecialHPBAR["Special7"] <- 1.2; // queen
		SpecialHPBAR["Special8"] <- 1.4; // king
	}
	else if (type == "All")
	{
		SpecialHPBAR["Special1"] <- 1; // fodder
		SpecialHPBAR["Special2"] <- 1; // regular
		SpecialHPBAR["Special3"] <- 1; // medium tank
		SpecialHPBAR["Special4"] <- 1; // medium attacker
		SpecialHPBAR["Special5"] <- 1; // fat tank
		SpecialHPBAR["Special6"] <- 1; // assassin
		SpecialHPBAR["Special7"] <- 1.2; // queen
		SpecialHPBAR["Special8"] <- 1.4; // king
	}
	else if (type == "None")
	{
		SpecialHPBAR["Special1"] <- 0; // fodder
		SpecialHPBAR["Special2"] <- 0; // regular
		SpecialHPBAR["Special3"] <- 0; // medium tank
		SpecialHPBAR["Special4"] <- 0; // medium attacker
		SpecialHPBAR["Special5"] <- 0; // fat tank
		SpecialHPBAR["Special6"] <- 0; // assassin
		SpecialHPBAR["Special7"] <- 0; // queen
		SpecialHPBAR["Special8"] <- 0; // king
	}
	else if (type == "Toggle")
	{
		if (HPBarType == "Default")
		{
			HPBarType = "All";
			if (BattleStart)
			{
				ClientPrint(null, 3, "HP Bar Setting : All");
				ClientPrint(null, 4, "HP Bar Setting : All");
				ClientPrint(null, 3, "Applied on next game");
			}
			else
			{
				ClientPrint(null, 3, "HP Bar Setting : All");
				ClientPrint(null, 4, "HP Bar Setting : All");
				ClientPrint(null, 3, "Applying now. Restarting Preparation Phase.");
				RestartFightWithGold();
			}
			return;
		}
		if (HPBarType == "None")
		{
			HPBarType = "Default";
			if (BattleStart)
			{
				ClientPrint(null, 3, "HP Bar Setting : Default");
				ClientPrint(null, 4, "HP Bar Setting : Default");
				ClientPrint(null, 3, "Applied on next game");
			}
			else
			{
				ClientPrint(null, 3, "HP Bar Setting : Default");
				ClientPrint(null, 4, "HP Bar Setting : Default");
				ClientPrint(null, 3, "Applying now. Restarting Preparation Phase.");
				RestartFightWithGold();
			}
			return;
		}
		if (HPBarType == "All")
		{
			HPBarType = "None";
			if (BattleStart)
			{
				ClientPrint(null, 3, "HP Bar Setting : None");
				ClientPrint(null, 4, "HP Bar Setting : None");
				ClientPrint(null, 3, "Applied on next game");
			}
			else
			{
				ClientPrint(null, 3, "HP Bar Setting : None");
				ClientPrint(null, 4, "HP Bar Setting : None");
				ClientPrint(null, 3, "Applying now. Restarting Preparation Phase.");
				RestartFightWithGold();
			}
			return;
		}
	}
}

::GetDescText <- function(hNum, hPlayer = null, hMarine = null)
{
	local message1 = "";
	local message2 = "";
	local message3 = "";
	local message4 = "";
	local message5 = "";
	local message6 = "";
	local message7 = "";
	local message8 = "";
	local Name = SpawnerWeaponName[hNum];
	local Class = SpawnerWeaponClass[hNum];
	local HP = SpecialHP["Special"+hNum];
	local DMG = SpecialDMG["Special"+hNum];
	local SPD = SpecialSPD["Special"+hNum];
	local CritD = SpecialCritDamage["Special"+hNum];
	local CritC = SpecialCrit["Special"+hNum];
	local Block = SpecialBlock["Special"+hNum];
	local Special = SpawnerWeaponExtra[hNum];
	local Cost = SpawnerWeaponGold["Special"+hNum];
	message1 = "Race : " + Name + " (" + Class + ")";
	message2 = "\nHP : " + HP;
	message3 = "\nDMG : " + DMG;
	message4 = "\nSPD : x" + SPD;
	message5 = "\nCrit : " + CritC + "% (x" + CritD + ")";
	message6 = "\nBlock : " + Block + "%";
	if (Special != "")
	{
		message7 = "\n" + Special;
	}
	message8 = "\nPrice : " + Cost + "G";
	
	local hPlayer2 = null;
	local color = "255 255 0";
	local hPos = SpawnerWeaponPos[hNum];
	local TextToSend = message1+message2+message3+message4+message5+message6+message7+message8;
	if (hPlayer != null && hMarine.IsInhabited())
	{
		local EntToBuffFaction = MarineTeamList[hMarine.GetMarineName()];
		if (EntToBuffFaction == 1)
		{
			color = "0 255 0";
		}
		else
		{
			color = "255 0 0";
		}
		// ShowAlienDesc(TextToSend, hPlayer, color);
		// AWAlienDescTextNum[hPlayer] <- hNum;
		return TextToSend;
	}
}

::GiveHint <- function(hNum = "")
{
	if (hNum == "")
	{
		return;
	}
	local hMarine = null;
	local hPos = SpawnerWeaponPos[hNum];
	local Description = SpawnerWeaponDesc[hNum];
	// while((hMarine = Entities.FindByClassnameWithin(hMarine, "asw_marine", hPos, 150)) != null)
	// {
		// ClientPrint(hMarine.GetCommander(), 3, Description);
	// }
	
	local message1 = "";
	local message2 = "";
	local message3 = "";
	local message4 = "";
	local message5 = "";
	local message6 = "";
	local message7 = "";
	local message8 = "";
	local message9 = "";
	local Name = SpawnerWeaponName[hNum];
	local Class = SpawnerWeaponClass[hNum];
	local HP = SpecialHP["Special"+hNum];
	local DMG = SpecialDMG["Special"+hNum];
	local SPD = SpecialSPD["Special"+hNum];
	local CritD = SpecialCritDamage["Special"+hNum];
	local CritC = SpecialCrit["Special"+hNum];
	local Block = SpecialBlock["Special"+hNum];
	local Special = SpawnerWeaponExtra[hNum];
	local Cost = SpawnerWeaponGold["Special"+hNum];
	message1 = "Race : " + Name + " (" + Class + ")";
	message2 = "\nHP : " + HP;
	message3 = "\nDMG : " + DMG;
	message4 = "\nSPD : x" + SPD;
	message5 = "\nCrit : " + CritC + "% (x" + CritD + ")";
	message6 = "\nBlock : " + Block + "%";
	// if (Special != "")
	// {
		// message7 = "\n" + Special;
	// }
	if (Special == "")
	{
		message7 = "\nSpecial : None";
	}
	else
	{
		message7 = "\nSpecial : " + Special;
	}
	message8 = "\nPrice : " + Cost + " Gold";
	message9 = "\n\n" + Description;
	
	local color = "255 255 0";
	local hPos = SpawnerWeaponPos[hNum];
	local TextToSend = message1+message2+message3+message4+message5+message6+message7+message8+message9;
	
	while((hMarine = Entities.FindByClassnameWithin(hMarine, "asw_marine", hPos, 140)) != null)
	{
		// ClientPrint(hMarine.GetCommander(), 3, Description);
	// }
		if (hMarine.GetCommander() != null && hMarine != null && hMarine.IsInhabited())
		{
			local EntToBuffFaction = MarineTeamList[hMarine.GetMarineName()];
			if (EntToBuffFaction == 1)
			{
				color = "0 255 0";
			}
			else
			{
				color = "255 0 0";
			}
			ShowAlienDesc(TextToSend, hMarine, hMarine.GetCommander(), color);
			AWAlienDescTextNum[hMarine] <- hNum;
			AWAlienDescTextTime[hMarine] <- HoldTime;
		}
	}
}

::StartTouch <- function(hNum = "") // Hooked with OnStartTouch
{
	if (hNum == "")
	{
		return;
	}
	local hMarine = null;
	local hPos = SpawnerWeaponPos[hNum];
	local Description = SpawnerWeaponDesc[hNum];
	// while((hMarine = Entities.FindByClassnameWithin(hMarine, "asw_marine", hPos, 150)) != null)
	// {
		// ClientPrint(hMarine.GetCommander(), 3, Description);
	// }
	
	local message1 = "";
	local message2 = "";
	local message3 = "";
	local message4 = "";
	local message5 = "";
	local message6 = "";
	local message7 = "";
	local message8 = "";
	local message9 = "";
	local Name = SpawnerWeaponName[hNum];
	local Class = SpawnerWeaponClass[hNum];
	local HP = SpecialHP["Special"+hNum];
	local DMG = SpecialDMG["Special"+hNum];
	local SPD = SpecialSPD["Special"+hNum];
	local CritD = SpecialCritDamage["Special"+hNum];
	local CritC = SpecialCrit["Special"+hNum];
	local Block = SpecialBlock["Special"+hNum];
	local Special = SpawnerWeaponExtra[hNum];
	local Cost = SpawnerWeaponGold["Special"+hNum];
	message1 = "Race : " + Name + " (" + Class + ")";
	message2 = "\nHP : " + HP;
	message3 = "\nDMG : " + DMG;
	message4 = "\nSPD : x" + SPD;
	message5 = "\nCrit : " + CritC + "% (x" + CritD + ")";
	message6 = "\nBlock : " + Block + "%";
	// if (Special != "")
	// {
		// message7 = "\n" + Special;
	// }
	if (Special == "")
	{
		message7 = "\nSpecial : None";
	}
	else
	{
		message7 = "\nSpecial : " + Special;
	}
	message8 = "\nPrice : " + Cost + " Gold";
	message9 = "\n\n" + Description;
	
	local color = "255 255 0";
	local hPos = SpawnerWeaponPos[hNum];
	local TextToSend = message1+message2+message3+message4+message5+message6+message7+message8+message9;
	
	while((hMarine = Entities.FindByClassnameWithin(hMarine, "asw_marine", hPos, 140)) != null)
	{
		// ClientPrint(hMarine.GetCommander(), 3, Description);
	// }
		if (hMarine.GetCommander() != null && hMarine != null && hMarine.IsInhabited())
		{
			local EntToBuffFaction = MarineTeamList[hMarine.GetMarineName()];
			if (EntToBuffFaction == 1)
			{
				color = "0 255 0";
			}
			else
			{
				color = "255 0 0";
			}
			// ShowAlienDesc(TextToSend, hMarine, hMarine.GetCommander(), color);
			AWAlienDescTextNum[hMarine] <- hNum;
			AWAlienDescTextTime[hMarine] <- HoldTime;
		}
	}
}

::GiveWeapon <- function(hNum = "") // Hooked with OnTrigger
{
	if (hNum == "")
	{
		return;
	}
	local hMarine = null;
	local hPos = SpawnerWeaponPos[hNum];
	local hItem = SpawnerWeaponNum[hNum];
	while((hMarine = Entities.FindByClassnameWithin(hMarine, "asw_marine", hPos, 140)) != null)
	{
		// GiveHint(hNum, hMarine.GetCommander(), hMarine);
		foreach(idx, val in SpawnerWeaponList)
		{
			if (val == hItem)
			{
				local hWeaponAct = NetProps.GetPropEntity(hMarine, "m_hActiveWeapon");
				if (hWeaponAct == null || (hWeaponAct != null && hWeaponAct.GetClassname() != idx))
				{
					hMarine.RemoveWeapon(0);
					hMarine.GiveWeapon(idx, 0);
				}
				break;
			}
		}
	}
}

::StartFight <- function()
{
	if (AWTimers["Preparation"])
	{
		timePrep = 0;
		// Convars.ExecuteConCommand("ai_setenabled 1");
	}
}

::FinishMap <- function()
{
	DoEntFire("asw_objective_triggered", "setcomplete", "", 0.5, null, null);
	DoEntFire("asw_objective_kill_eggs", "addoutput", "Optional 1", 0, null, null);
	DoEntFire("asw_objective_destroy_goo", "addoutput", "Optional 1", 0, null, null);
	DoEntFire("asw_objective_escape", "addoutput", "Optional 1", 0, null, null);
	DoEntFire("asw_objective_countdown", "addoutput", "Optional 1", 0, null, null);
	// Convars.SetValue("asw_controls", 1);
}

::RestartFightWithGold <- function()
{
	local hMarine = null;
	while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
	{
		AWGoldCountValue[hMarine] <- AWGoldCountValueRound[hMarine];
	}
	RestartFight();
}

::RestartFight <- function()
{
	BattleStart = false;
	foreach(idx, val in GreenTeamAlienList)
	{
		local EntityToDelete = null;
		while((EntityToDelete = Entities.FindByClassname(EntityToDelete, idx)) != null)
		{
			EntityToDelete.Destroy();
		}
	}
	timePrep = DefaulttimePrep;
	// timeBattle = DefaulttimeBattle;
	timeRefresh = DefaulttimeRefresh;
	timeTeleport = DefaulttimeTeleport;
	timeEnd = DefaulttimeEnd;
	AWTimers["Battle"] = false;
	AWTimers["Buff"] = false;
	AWTimers["Steal"] = false;
	AWTimers["Stasis"] = false;
	local hMarine = null;
	while((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
	{
		hMarine.SetOrigin(OriginArray[hMarine]);
		if (RemoveWeapon)
		{
			hMarine.RemoveWeapon(0);
			hMarine.RemoveWeapon(1);
			hMarine.RemoveWeapon(2);
		}
	}
	local hWeapon = null;
	foreach (idx, val in BuffWeaponList)
	{
		while((hWeapon = Entities.FindByClassname(hWeapon, idx)) != null)
		{
			hWeapon.Destroy();
		}
	}
	Preparation();
}

::AWGiveBuffGear <- function()
{
	local hMarine = null;
	while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
	{
		if (RemoveWeapon)
		{
			hMarine.RemoveWeapon(0);
			hMarine.RemoveWeapon(1);
			hMarine.RemoveWeapon(2);
		hMarine.GiveWeapon("asw_weapon_sniper_rifle", 0);
		}
		// local MarineCName = hMarine.GetMarineName();
		// if (MarineCName == "Faith" || MarineCName == "Bastille")
		// {
			// hMarine.GiveWeapon("asw_weapon_medrifle", 0);
		// }
		// else if (MarineCName == "Jaeger" || MarineCName == "Sarge")
		// {
			// hMarine.GiveWeapon("asw_weapon_grenade_launcher", 0);
		// }
		// else if (MarineCName == "Wolfe" || MarineCName == "Wildcat")
		// {
			// hMarine.GiveWeapon("asw_weapon_pistol", 0);
		// }
		// else if (MarineCName == "Crash" || MarineCName == "Vegas")
		// {
			// hMarine.GiveWeapon("asw_weapon_deagle", 0);
		// }
		if (RemoveWeapon)
		{
			local hWeaponAct = NetProps.GetPropEntity(hMarine, "m_hActiveWeapon");
			hWeaponAct.SetClip1(DefaultBuffWeapon);
			hWeaponAct.SetClip2(0);
			hWeaponAct.SetClips(0);
		}
	}
}

::Debug <- function()
{
	local incr = 140;
	local incrx = 0;
	local incry = 0;
	local SequenceSpawn = 0;
	DebugGreen <- {};
	DebugRed <- {};
					
	foreach (idx, val in GreenAlienEnt)
	{
		if (idx != null && idx.IsValid())
		{
			local EntPos = Vector(600+incrx, -128+incry, -800);
			SequenceSpawn += 1;
			if (SequenceSpawn == 1)
			{
				incry += incr;
			}
			else if (SequenceSpawn == 2)
			{
				incry *= -1;
			}
			else if (SequenceSpawn == 3)
			{
				incry -= incr;
			}
			else
			{
				incry *= -1;
				SequenceSpawn = 0;
			}
			if (incry > 800)
			{
				incrx += incr;
				incry = 0;
			}
			if (incrx > 700)
			{
				DebugGreen[idx] <- 1;
			}
			idx.SetOrigin(EntPos);
			GoToMiddle(idx, "Green");
		}
	}
	incrx = 0;
	incry = 0;
	SequenceSpawn = 0;
	foreach (idx, val in RedAlienEnt)
	{
		if (idx != null && idx.IsValid())
		{
			local EntPos = Vector(-1200-incrx, -128+incry, -800);
			SequenceSpawn += 1;
			if (SequenceSpawn == 1)
			{
				incry += incr;
			}
			else if (SequenceSpawn == 2)
			{
				incry *= -1;
			}
			else if (SequenceSpawn == 3)
			{
				incry -= incr;
			}
			else
			{
				incry *= -1;
				SequenceSpawn = 0;
			}
			if (incry > 800)
			{
				incrx += incr;
				incry = 0;
			}
			if (incrx > 700)
			{
				DebugRed[idx] <- 1;
			}
			idx.SetOrigin(EntPos);
			GoToMiddle(idx, "Red");
		}
	}
	if (DebugRed.len() > 0 || DebugGreen.len() > 0)
	{
		AWQueueTimerFunc(DefaulttimeDebug, "Debug");
	}
}

::Debug2 <- function()
{
	AWTimers["Debug"] = false;
	local incr = 140;
	local incrx = 0;
	local incry = 0;
	local SequenceSpawn = 0;
	local NewDebugGreen = {};
	local NewDebugRed = {};
	foreach (idx, val in DebugGreen)
	{
		if (idx != null && idx.IsValid())
		{
			local EntPos = Vector(600+incrx, -128+incry, -800);
			SequenceSpawn += 1;
			if (SequenceSpawn == 1)
			{
				incry += incr;
			}
			else if (SequenceSpawn == 2)
			{
				incry *= -1;
			}
			else if (SequenceSpawn == 3)
			{
				incry -= incr;
			}
			else
			{
				incry *= -1;
				SequenceSpawn = 0;
			}
			if (incry > 800)
			{
				incrx += incr;
				incry = 0;
			}
			if (incrx > 700)
			{
				NewDebugGreen[idx] <- 1;
			}
			idx.SetOrigin(EntPos);
			GoToMiddle(idx, "Green");
		}
	}
	incrx = 0;
	incry = 0;
	SequenceSpawn = 0;
	foreach (idx, val in DebugRed)
	{
		if (idx != null && idx.IsValid())
		{
			local EntPos = Vector(-1200-incrx, -128+incry, -800);
			SequenceSpawn += 1;
			if (SequenceSpawn == 1)
			{
				incry += incr;
			}
			else if (SequenceSpawn == 2)
			{
				incry *= -1;
			}
			else if (SequenceSpawn == 3)
			{
				incry -= incr;
			}
			else if (SequenceSpawn == 4)
			{
				incry *= -1;
				SequenceSpawn = 0;
			}
			if (incry > 800)
			{
				incrx += incr;
				incry = 0;
			}
			if (incrx > 700)
			{
				NewDebugRed[idx] <- 1;
			}
			idx.SetOrigin(EntPos);
			GoToMiddle(idx, "Red");
		}
	}
	if (NewDebugRed.len() > 0 || NewDebugGreen.len() > 0)
	{
		DebugGreen <- NewDebugGreen;
		DebugRed <- NewDebugRed;
		AWQueueTimerFunc(DefaulttimeDebug, "Debug");
	}
}

::Preparation <- function()
{
	// ClientPrint(null, 3, "You have " + timePrep + "sec to prepare!");
	ClientPrint(null, 3, "Prepare for Round " + CurrentRound.tostring() + " !");
	if (HPBarType == "Default")
	{
		HPBarToggle("Default");
	}
	else if (HPBarType == "All")
	{
		HPBarToggle("All");
	}
	else if (HPBarType == "None")
	{
		HPBarToggle("None");
	}
	
	/// Challenge Check
	Convars.SetValue( "asw_horde_override", 0 );
	Convars.SetValue( "asw_wanderer_override", 0 );
	local fuckyou = Convars.GetStr("asw_horde_override");
	if (fuckyou == "1")
	{
		ClientPrint(null, 3, "You fucked up the map... Time to RESTART!!!");
		AWQueueTimerFunc(10, "Restart");
	}
	Convars.ExecuteConCommand("ai_setenabled 0");
	AWQueueTimerFunc(0, "Preparation");
}

::OnGameplayStart <- function()
{
	Start = true;
	StartTime = Time();
	SetCvars();
	AWGoldCount();
	
	local hMarine = null;
	while((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
	{
		OriginArray[hMarine] <- hMarine.GetOrigin();
		
		if (RemoveWeapon)
		{
			hMarine.RemoveWeapon(0);
			hMarine.RemoveWeapon(1);
			hMarine.RemoveWeapon(2);
		}
		
		hMarine.__KeyValueFromInt("modelscale", 1.5);
		if(ChangeModel)
		{
			if (hMarine.GetMarineName() == "Faith" || hMarine.GetMarineName() == "Wildcat")
			{
				hMarine.SetModel(MarineFModel);
			}
			else
			{
				hMarine.SetModel(MarineModel);
			}
			// hMarine.SetModel("models/aliens/droaw/droaw.mdl");
			// hMarine.SetModel("models/aliens/drone/drone.mdl");
			// hMarine.SetPoseParameter( "idle", 0 );
			// hMarine.StopAnimation();
		}
		
		local faction = MarineTeamList[hMarine.GetMarineName()];
		if (faction == 1)
		{
			EntFireByHandle(hMarine, "addoutput", "rendercolor 0 255 0", 0, this, this);
			// hMarine.SetModel(MarineModelGreen);
		}
		else
		{
			EntFireByHandle(hMarine, "addoutput", "rendercolor 255 0 0", 0, this, this);
			// hMarine.SetModel(MarineModelRed);
		}
		if (hMarine.IsInhabited())
		{
			AWGoldCount(DefaultGold.tostring(), hMarine.GetCommander());
			
		}
	}
	Preparation();
	// Tip();
}

::OnGameEvent_player_say <- function(params)
{
	if (!("text" in params))
		return;
	else if (params["text"] == null)
		return;
	
	local strText = params["text"].tolower();
	
	switch (strText)
	{
		// case "&asbi":
		// {
			// ClientPrint(null, 3, "ONSLAUGHT OFF");
			// Convars.SetValue( "asw_horde_override", 0 );
			// Convars.SetValue( "asw_wanderer_override", 0 );
			// Convars.SetValue( "asw_marine_ff_absorption", 1 );
			// Convars.SetValue( "asw_marine_ff", 1 );
			// Convars.SetValue( "asw_marine_death_protection", 1 );
			// Convars.SetValue( "asw_marine_ff_dmg_base", 1 );
		// }
		// return
		case "&free":
		{
			FreeFight();
		}
		return
		case "&win":
		{
			// FinishMap();
			AWQueueTimerFunc(0, "EndMap");
		}
		return;
		case "&debug":
		{
			Debug();
			printl("Debug 1");
		}
		return;
		case "&debug2":
		{
			Debug2();
			printl("Debug 2");
		}
		return;
		case "&photo":
		{
			if (("userid" in params))
			{
				local hPlayer = GetPlayerFromUserID(params["userid"]);
				local Spec = NetProps.GetPropEntity(hPlayer, "m_hSpectatingMarine");
				local InUse = NetProps.GetPropEntity(hPlayer, "m_hMarine");
				if (InUse != null)
				{
					local CurrPos = InUse.GetOrigin();
					InUse.SetOrigin(CurrPos + Vector(0,0,-200));
				}
				// printl(hPlayer + "----"+ Spec + "---------" + InUse);
			}
		}
		return;
		case "&pos":
		{
			local hMarine = null;
			while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
			{
				printl(hMarine.GetMarineName()+" : "+hMarine.GetOrigin()+"\n");
			}
		}
		return;
		case "&start":
		{
			if (!BattleStart)
			{
				timePrep = 0;
			}
		}
		return;
		case "&restart":
		{
			RestartFightWithGold();
		}
		return;
		// case "&shotgun":
		// {
			// local hMarine = null;
			// while ((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null)
			// {
				// hMarine.GiveWeapon("asw_weapon_shotgun", 0);
			// }
		// }
		// return;
		case "&hpbar":
		{
			HPBarToggle("Toggle");
		}
		return;
		case "&tips":
		{
			if (TipSetting)
			{
				TipSetting = false;
				ClientPrint(3, null, "Tips : OFF");
				return;
			}
			else
			{
				TipSetting = true;
				ClientPrint(3, null, "Tips : ON");
				return;
			}
		}
		return;
	}
}

::OnGameEvent_weapon_fire <- function(params)
{
	local SpawnerItem = EntIndexToHScript(params["weapon"]);
	local CurrMarine = EntIndexToHScript(params["marine"]);
	// local CurrID = EntIndexToHScript(params["userid"]);
	
	local faction = MarineTeamList[CurrMarine.GetMarineName()];
	local SpawnedEntity = null;
	local SpawnedName = "";
	foreach(idx, val in SpawnerWeaponList)
	{
		if (SpawnerItem.GetClassname() == idx)
		{
			// if (val == "asw_drone")
			if (val == "Special1")
			{
				SpawnedEntity = Entities.CreateByClassname("asw_drone");
				SpawnedEntity.SetName("Special1");
				SpawnedName = "Special1";
			}
			// else if (val == "asw_buzzer")
			else if (val == "Special2")
			{
				SpawnedEntity = Entities.CreateByClassname("asw_drone");
				SpawnedEntity.SetName("Special2");
				SpawnedName = "Special2";
			}
			// else if (val == "asw_shieldbug")
			else if (val == "Special3")
			{
				SpawnedEntity = Entities.CreateByClassname("asw_drone");
				SpawnedEntity.SetName("Special3");
				SpawnedName = "Special3";
			}
			// else if (val == "asw_boomer")
			else if (val == "Special4")
			{
				SpawnedEntity = Entities.CreateByClassname("asw_drone");
				SpawnedEntity.SetName("Special4");
				SpawnedName = "Special4";
			}
			// else if (val == "npc_antlion")
			else if (val == "Special5")
			{
				SpawnedEntity = Entities.CreateByClassname("asw_drone");
				SpawnedEntity.SetName("Special5");
				SpawnedName = "Special5";
			}
			// else if (val == "npc_antlion_worker")
			else if (val == "Special6")
			{
				SpawnedEntity = Entities.CreateByClassname("asw_drone");
				SpawnedEntity.SetName("Special6");
				SpawnedName = "Special6";
			}
			// else if (val == "npc_zombie")
			else if (val == "Special7")
			{
				SpawnedEntity = Entities.CreateByClassname("asw_drone");
				SpawnedEntity.SetName("Special7");
				SpawnedName = "Special7";
			}
			// else if (val == "npc_fastzombie")
			else if (val == "Special8")
			{
				SpawnedEntity = Entities.CreateByClassname("asw_drone");
				SpawnedEntity.SetName("Special8");
				SpawnedName = "Special8";
			}
		}
	}
	if (SpawnedEntity == null)
	{
		if (SpawnerItem.GetClassname() == "asw_weapon_sniper_rifle")
		{
			local MarineCName = CurrMarine.GetMarineName();
			if (MarineCName == "Faith" || MarineCName == "Bastille")
			{
				SpawnedEntity = "Steal";
			}
			else if (MarineCName == "Jaeger" || MarineCName == "Sarge")
			{
				SpawnedEntity = "Fear";
			}
			else if (MarineCName == "Wolfe" || MarineCName == "Wildcat")
			{
				SpawnedEntity = "Stasis";
			}
			else if (MarineCName == "Crash" || MarineCName == "Vegas")
			{
				SpawnedEntity = "Buff";
			}
		}
	}
	
	local hMarine = null;
	while((hMarine = Entities.FindByClassname(hMarine, "asw_marine")) != null )
	{
		if (hMarine == CurrMarine && hMarine.IsInhabited())
		{
			local VecCrosshairOrigin = NetProps.GetPropVector(hMarine.GetCommander(), "m_vecCrosshairTracePos");
			VecCrosshairOrigin += Vector(0,0,30);
			
			if (SpawnedEntity == "Buff")
			{
				local EntToBuff = null;
				local TryCount = 0;
				while((EntToBuff = Entities.FindInSphere(EntToBuff, VecCrosshairOrigin, MaxRange)) != null)
				{
					if( EntToBuff.IsAlien() && !StasisTimers.rawin(EntToBuff) && faction == NetProps.GetPropInt(EntToBuff, "m_nFaction") && NetProps.GetPropInt(EntToBuff, "m_nFaction") != 0 && !BuffTimers.rawin(EntToBuff))
					{
						// printl("buffing now " + EntToBuff);
						local EntToBuffPos = EntToBuff.GetOrigin();
						local EntToBuffFaction = NetProps.GetPropInt(EntToBuff, "m_nFaction");
						// local EntToBuffFaction2 = NetProps.GetPropInt(EntToBuff, "m_nFaction");
						// local EntToBuffHP = NetProps.GetPropInt(EntToBuff, "m_iHealthBonus");
						local EntToBuffSize = NetProps.GetPropFloat(EntToBuff, "m_fSizeScale");
						local EntToBuffSpeed = NetProps.GetPropFloat(EntToBuff, "m_fSpeedScale");
						local EntToBuffCurrHP = EntToBuff.GetHealth();
						local EntToBuffCurrMaxHP = EntToBuff.GetMaxHealth();
						local EntToBuffName = EntToBuff.GetName();
						
						local BuffedEnt = Entities.CreateByClassname(EntToBuff.GetClassname());
						BuffedEnt.SetOrigin(EntToBuffPos);
						BuffedEnt.SetName(EntToBuffName);
						NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize*BuffMultSize);
						NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed*BuffMultSpeed);
						if (EntToBuffFaction == 1)
						{
							EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
							GreenAlienEnt.rawdelete(EntToBuff);
							GreenAlienEnt[BuffedEnt] <- 1;
						}
						else
						{
							EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 255", 0, this, this);
							RedAlienEnt.rawdelete(EntToBuff);
							RedAlienEnt[BuffedEnt] <- 1;
						}
						
						if (StealTimers.rawin(EntToBuff))
						{
							StealTimers[BuffedEnt] <- StealTimers[EntToBuff];
							StealTimers.rawdelete(EntToBuff);
							// if (EntToBuffFaction == 1)
							// {
								// EntToBuffFaction2 = 2;
							// }
							// else
							// {
								// EntToBuffFaction2 = 1;
							// }
						}
						
						if (SlowCreatorArray.rawin(EntToBuff))
						{
							SlowCreatorArray[BuffedEnt] <- SlowCreatorArray[EntToBuff];
							SlowCreatorArray.rawdelete(EntToBuff);
						}
						
						local Stun1 = NetProps.GetPropFloat(EntToBuff, "m_flElectroStunSlowMoveTime");
						local Stun2 = NetProps.GetPropInt(EntToBuff, "m_bElectroStunned");
						local Fire = NetProps.GetPropInt(EntToBuff, "m_bOnFire");
						local Ice = NetProps.GetPropFloat(EntToBuff, "m_flFrozenTime");
						local Ice2 = NetProps.GetPropFloat(EntToBuff, "m_flFreezeResistance");
		
						EntToBuff.Destroy();
						BuffedEnt.Spawn();
						BuffedEnt.Activate();
						NetProps.SetPropInt(BuffedEnt, "m_nFaction", EntToBuffFaction);
						
						NetProps.SetPropFloat(BuffedEnt, "m_flElectroStunSlowMoveTime", Stun1);
						NetProps.SetPropInt(BuffedEnt, "m_bElectroStunned", Stun2);
						NetProps.SetPropInt(BuffedEnt, "m_bOnFire", Fire);
						// NetProps.SetPropFloat(BuffedEnt, "m_flFrozenTime", Ice);
						NetProps.SetPropFloat(BuffedEnt, "m_flFreezeResistance", Ice2);
						local CurrentTime = Ice - Time();
						if (CurrentTime > 0)
						{
							BuffedEnt.Freeze(CurrentTime);
						}
						
						OldHP[BuffedEnt] <- EntToBuffCurrHP;
						BuffedEnt.SetHealth(EntToBuffCurrHP + (EntToBuffCurrMaxHP * BuffMultHP));
						BuffedEnt.SetMaxHealth(EntToBuffCurrMaxHP);
						MakeDemDrones("model", BuffedEnt);
						MakeDemDrones("flinch", BuffedEnt);
						// MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction2);
						MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction);
						
						DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt);
						if (faction == 1)
						{
							GoToMiddle(BuffedEnt, "Green");
						}
						else
						{
							GoToMiddle(BuffedEnt, "Red");
						}
						AWQueueTimerFunc(BuffTime, "Buff", BuffedEnt);
						return;
					}
					else
					{
						// printl(EntToBuff + " - " + TryCount);
						TryCount += 1;
						if (TryCount > MaxTry)
						{
							return;
						}
					}
				}
				// printl("buffing what " + EntToBuff + " - " + faction + " - " + NetProps.GetPropInt(EntToBuff, "m_nFaction"));
			}
			else if (SpawnedEntity == "Steal")
			{
				local EntToBuff = null;
				local TryCount = 0;
				// while((EntToBuff = Entities.FindInSphere(EntToBuff, VecCrosshairOrigin, 50)) != null && EntToBuff.IsAlien() && !StasisTimers.rawin(EntToBuff) && !StealTimers.rawin(EntToBuff)&& NetProps.GetPropInt(EntToBuff, "m_nFaction") != 0 && NetProps.GetPropInt(EntToBuff, "m_nFaction") != faction)
				while((EntToBuff = Entities.FindInSphere(EntToBuff, VecCrosshairOrigin, MaxRange)) != null)
				{
					if( EntToBuff.IsAlien() && !StasisTimers.rawin(EntToBuff) && !StealTimers.rawin(EntToBuff)&& NetProps.GetPropInt(EntToBuff, "m_nFaction") != 0 && NetProps.GetPropInt(EntToBuff, "m_nFaction") != faction)
					{
						local EntToBuffPos = EntToBuff.GetOrigin();
						local EntToBuffFaction = NetProps.GetPropInt(EntToBuff, "m_nFaction");
						// local EntToBuffHP = NetProps.GetPropInt(EntToBuff, "m_iHealthBonus");
						local EntToBuffSize = NetProps.GetPropFloat(EntToBuff, "m_fSizeScale");
						local EntToBuffSpeed = NetProps.GetPropFloat(EntToBuff, "m_fSpeedScale");
						local EntToBuffCurrHP = EntToBuff.GetHealth();
						local EntToBuffCurrMaxHP = EntToBuff.GetMaxHealth();
						local EntToBuffName = EntToBuff.GetName();
						
						local BuffedEnt = Entities.CreateByClassname(EntToBuff.GetClassname());
						BuffedEnt.SetOrigin(EntToBuffPos);
						BuffedEnt.SetName(EntToBuffName);
						
						if (faction == 1)
						{
							EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
						}
						else
						{
							EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 255", 0, this, this);
						}
						if (GreenAlienEnt.rawin(EntToBuff))
						{
							GreenAlienEnt.rawdelete(EntToBuff);
						}
						else
						{
							RedAlienEnt.rawdelete(EntToBuff);
						}
						if (faction == 1)
						{
							GreenAlienEnt[BuffedEnt] <- 1;
						}
						else
						{
							RedAlienEnt[BuffedEnt] <- 1;
						}
						
						// NetProps.SetPropInt(BuffedEnt, "m_iHealthBonus", EntToBuffHP);
						NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
						NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
						
						if (BuffTimers.rawin(EntToBuff))
						{					
							BuffTimers[BuffedEnt] <- BuffTimers[EntToBuff];
							BuffTimers.rawdelete(EntToBuff);
						}
						
						if (OldHP.rawin(EntToBuff))
						{
							OldHP[BuffedEnt] <- OldHP[EntToBuff];
							OldHP.rawdelete(EntToBuff);
						}
						
						if (SlowCreatorArray.rawin(EntToBuff))
						{
							SlowCreatorArray[BuffedEnt] <- SlowCreatorArray[EntToBuff];
							SlowCreatorArray.rawdelete(EntToBuff);
						}
						
						local Stun1 = NetProps.GetPropFloat(EntToBuff, "m_flElectroStunSlowMoveTime");
						local Stun2 = NetProps.GetPropInt(EntToBuff, "m_bElectroStunned");
						local Fire = NetProps.GetPropInt(EntToBuff, "m_bOnFire");
						local Ice = NetProps.GetPropFloat(EntToBuff, "m_flFrozenTime");
						local Ice2 = NetProps.GetPropFloat(EntToBuff, "m_flFreezeResistance");
						
						EntToBuff.Destroy();
						BuffedEnt.Spawn();
						BuffedEnt.Activate();
						NetProps.SetPropInt(BuffedEnt, "m_nFaction", faction);
						
						NetProps.SetPropFloat(BuffedEnt, "m_flElectroStunSlowMoveTime", Stun1);
						NetProps.SetPropInt(BuffedEnt, "m_bElectroStunned", Stun2);
						NetProps.SetPropInt(BuffedEnt, "m_bOnFire", Fire);
						// NetProps.SetPropFloat(BuffedEnt, "m_flFrozenTime", Ice);
						NetProps.SetPropFloat(BuffedEnt, "m_flFreezeResistance", Ice2);
						local CurrentTime = Ice - Time();
						if (CurrentTime > 0)
						{
							BuffedEnt.Freeze(CurrentTime);
						}
						
						BuffedEnt.SetHealth(EntToBuffCurrHP);
						BuffedEnt.SetMaxHealth(EntToBuffCurrMaxHP);
						MakeDemDrones("model", BuffedEnt);
						MakeDemDrones("flinch", BuffedEnt);
						MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction);
						
						DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt);
						if (faction == 1)
						{
							GoToMiddle(BuffedEnt, "Green");
						}
						else
						{
							GoToMiddle(BuffedEnt, "Red");
						}
						AWQueueTimerFunc(StealTime, "Steal", BuffedEnt, EntToBuffFaction);
						return;
					}
					else
					{
						// printl(EntToBuff + " - " + TryCount);
						TryCount += 1;
						if (TryCount > MaxTry)
						{
							return;
						}
					}
				}
			}
			else if (SpawnedEntity == "Stasis")
			{
				local EntToBuff = null;
				local TryCount = 0;
				// while((EntToBuff = Entities.FindInSphere(EntToBuff, VecCrosshairOrigin, 50)) != null && EntToBuff.IsAlien() && NetProps.GetPropInt(EntToBuff, "m_nFaction") != 0 && !StasisTimers.rawin(EntToBuff))
				while((EntToBuff = Entities.FindInSphere(EntToBuff, VecCrosshairOrigin, MaxRange)) != null)
				{
					if( EntToBuff.IsAlien() && NetProps.GetPropInt(EntToBuff, "m_nFaction") != 0 && !StasisTimers.rawin(EntToBuff))
					{
						local EntToBuffPos = EntToBuff.GetOrigin();
						local EntToBuffFaction = NetProps.GetPropInt(EntToBuff, "m_nFaction");
						local IsStolen = EntToBuffFaction;
						if (StealFaction.rawin(EntToBuff))
						{
							IsStolen = StealFaction[EntToBuff];
						}
						// local EntToBuffHP = NetProps.GetPropInt(EntToBuff, "m_iHealthBonus");
						local EntToBuffSize = NetProps.GetPropFloat(EntToBuff, "m_fSizeScale");
						local EntToBuffSpeed = NetProps.GetPropFloat(EntToBuff, "m_fSpeedScale");
						local EntToBuffCurrHP = EntToBuff.GetHealth();
						local EntToBuffCurrMaxHP = EntToBuff.GetMaxHealth();
						local EntToBuffName = EntToBuff.GetName();
						
						local BuffedEnt = Entities.CreateByClassname(EntToBuff.GetClassname());
						BuffedEnt.SetOrigin(EntToBuffPos);
						
						if (EntToBuffFaction == 1)
						{
							GreenAlienEnt.rawdelete(EntToBuff);
							GreyAlienEnt[BuffedEnt] <- 1;
						}
						else
						{
							RedAlienEnt.rawdelete(EntToBuff);
							GreyAlienEnt[BuffedEnt] <- 1;
						}
						// NetProps.SetPropInt(BuffedEnt, "m_iHealthBonus", EntToBuffHP);
						NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
						NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
						EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 100 100 100", 0, this, this);
						BuffedEnt.Wake(false);
						
						if (StealTimers.rawin(EntToBuff))
						{
							StealFaction[BuffedEnt] <- StealFaction[EntToBuff];
							StealTimers[BuffedEnt] <- StealTimers[EntToBuff];
							StealFaction.rawdelete(EntToBuff);
							StealTimers.rawdelete(EntToBuff);
						}
						if (BuffTimers.rawin(EntToBuff))
						{
							BuffTimers[BuffedEnt] <- BuffTimers[EntToBuff];
							BuffTimers.rawdelete(EntToBuff);
						}
						if (OldHP.rawin(EntToBuff))
						{
							OldHP[BuffedEnt] <- OldHP[EntToBuff];
							OldHP.rawdelete(EntToBuff);
						}
						
						if (SlowCreatorArray.rawin(EntToBuff))
						{
							SlowCreatorArray[BuffedEnt] <- SlowCreatorArray[EntToBuff];
							SlowCreatorArray.rawdelete(EntToBuff);
						}
						
						EntToBuff.Destroy();
						BuffedEnt.Spawn();
						BuffedEnt.Activate();
						NetProps.SetPropInt(BuffedEnt, "m_nFaction", 0);
						BuffedEnt.SetName(EntToBuffName);
						BuffedEnt.SetHealth(EntToBuffCurrHP);
						BuffedEnt.SetMaxHealth(EntToBuffCurrMaxHP);
						MakeDemDrones("model", BuffedEnt);
						// MakeDemDrones("flinch", BuffedEnt);
						MakeDemDrones("hpbar", BuffedEnt);
						DoEntFire("!self", "AddOutput", "freezable false", 0, null, BuffedEnt);
						DoEntFire("!self", "AddOutput", "flammable false", 0, null, BuffedEnt);
						DoEntFire("!self", "AddOutput", "teslable false", 0, null, BuffedEnt);
						DoEntFire("!self", "AddOutput", "flinchable false", 0, null, BuffedEnt);
						// if (EntToBuffName == "Special1" || EntToBuffName == "Special2" || EntToBuffName == "Special3")
						// {
							// BuffedEnt.SetModel("models/aliens/droaw/dron2.mdl");
						// }
						// if (EntToBuffName == "Special4" || EntToBuffName == "Special5" || EntToBuffName == "Special6")
						// {
							// BuffedEnt.SetModel("models/aliens/droaw/dron1.mdl");
						// }
						// if (EntToBuffName == "Special7" || EntToBuffName == "Special8")
						// {
							// BuffedEnt.SetModel("models/aliens/droaw/droaw.mdl");
						// }
						
						DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt);
						AWQueueTimerFunc(StasisTime, "Stasis", BuffedEnt, IsStolen);
						return;
					}
					else
					{
						// printl(EntToBuff + " - " + TryCount);
						TryCount += 1;
						if (TryCount > MaxTry)
						{
							return;
						}
					}
				}
			}
			else if (SpawnedEntity == "Fear")
			{
				local EntToBuff = null;
				local TryCount = 0;
				// while((EntToBuff = Entities.FindInSphere(EntToBuff, VecCrosshairOrigin, 50)) != null && EntToBuff.IsAlien())
				while((EntToBuff = Entities.FindInSphere(EntToBuff, VecCrosshairOrigin, MaxRange)) != null)
				{
					if (EntToBuff.IsAlien())
					{
						local incrx = RandomInt(0, 768);
						local incry = RandomInt(0, 1536);
						if (GreenAlienEnt.rawin(EntToBuff))
						{
							EntToBuff.SetOrigin(Vector(640+incrx, -896+incry, -800));
							// EntToBuff.OrderMoveTo(ThisIsCenterRight, false);
							GoToMiddle(EntToBuff, "Green");
						}
						else if (RedAlienEnt.rawin(EntToBuff))
						{
							EntToBuff.SetOrigin(Vector(-2048+incrx, -896+incry, -800));
							// EntToBuff.OrderMoveTo(ThisIsCenterLeft, false);
							GoToMiddle(EntToBuff, "Red");
						}
						return;
					}
					else
					{
						// printl(EntToBuff + " - " + TryCount);
						TryCount += 1;
						if (TryCount > MaxTry)
						{
							return;
						}
					}
				}
			}
			else
			{
				SpawnedEntity.SetOrigin(VecCrosshairOrigin);
				local SpawnedClass = SpawnedEntity.GetClassname();
				if (SpawnedName == "")
				{
					SpawnedEntity.SetName(SpawnedEntity.GetClassname());
					SpawnedName = SpawnedEntity.GetClassname();
				}
				local MarineGold = AWGoldCountValue[hMarine];
				local EntityGold = SpawnerWeaponGold[SpawnedName];
				local EnoughGold = false;
				// printl(SpawnedName +"----"+SpawnedEntity)
				if ((MarineGold - EntityGold) >= 0)
				{
					EnoughGold = true;
				}
				
				if (faction == 1)
				{
					EntFireByHandle(SpawnedEntity, "addoutput", "rendercolor 0 255 0", 0, this, this);
				}
				else
				{
					EntFireByHandle(SpawnedEntity, "addoutput", "rendercolor 255", 0, this, this);
				}
				SpawnerItem.SetClip1(0);
				
				local MaxReached = 0;
				if (MarineTeamList[hMarine.GetMarineName()] == 1)
				{
					MaxReached = AlienMaxCountList[SpawnedEntity.GetClassname()] - GreenTeamAlienList[SpawnedEntity.GetClassname()];
				}
				else
				{
					MaxReached = AlienMaxCountList[SpawnedEntity.GetClassname()] - RedTeamAlienList[SpawnedEntity.GetClassname()];
				}
				if (EnoughGold && MaxReached > 0)
				{
					AWGoldCountValue[hMarine] -= EntityGold;
					if (faction == 1)
					{
						GreenAlienEnt[SpawnedEntity] <- 1;
					}
					else
					{
						RedAlienEnt[SpawnedEntity] <- 1;
					}
					
					MakeDemDrones("speed", SpawnedEntity);
					SpawnedEntity.Spawn();
					SpawnedEntity.Activate();
					MakeDemDrones("model", SpawnedEntity);
					MakeDemDrones("flinch", SpawnedEntity);
					MakeDemDrones("hp", SpawnedEntity);
					MakeDemDrones("hpbar", SpawnedEntity, faction);
					// if (faction == 1)
					// {
						// GoToMiddle(SpawnedEntity, "Green");
					// }
					// else
					// {
						// GoToMiddle(SpawnedEntity, "Red");
					// }
					
					NetProps.SetPropInt(SpawnedEntity, "m_nFaction", faction);
					
					DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, SpawnedEntity);
					
				}
				else
				{
					SpawnedEntity.Destroy();
					if (!EnoughGold)
					{
						ClientPrint(null, 3, "You need more gold!");
					}
					if (MaxReached <= 0)
					{
						ClientPrint(null, 3, "More of that unit will crash the game!");
					}
				}
			}
			
		}
	}
}

::OnGameEvent_entity_killed <- function(params)
{
	local hAlien = EntIndexToHScript(params["entindex_killed"]);
	if (!hAlien)
		return;
		
	if (hAlien.GetName() == "Special1")
	{
		SpawnMore(hAlien);
		return;
	}
	if (hAlien.GetName() == "Special3")
	{
		SpawnMore(hAlien);
		return;
	}
	if (hAlien.GetName() == "Special4")
	{
		// DropFreezeGrenade(0, 5, 5, hAlien.GetOrigin() + Vector(0, 0, 10));
		DropStunGrenade(0, 100, hAlien.GetOrigin() + Vector(0, 0, 10));
		return;
	}
	if (hAlien.GetName() == "Special2")
	{
		StartFire(hAlien.GetOrigin(), 5, 3210 );
		// DropIncendiaryGrenade(10, 100, hAlien.GetOrigin() + Vector(0, 0, 10));
		// DropIncendiaryGrenade(100, 300, hAlien.GetOrigin());
		return;
	}
	if (hAlien.GetName() == "Special7")
	{
		// DropStunGrenade(0, 100, victim.GetOrigin() + Vector(0, 0, 10));
		CreateParticleFunc(2, hAlien.GetOrigin(), Vector(0, 0, 0), "barrel_rad_gas_cloud", "", 0, "");
		TeleportMe(hAlien);
		return;
	}
}

::OnTakeDamage_Alive_Any <- function( victim, inflictor, attacker, weapon, damage, damageType, ammoName )
{
	// if (victim.IsAlien())
	// {
		// printl("STUN " + NetProps.GetPropFloat(victim, "m_flElectroStunSlowMoveTime"));
		// printl("STUN2 " + NetProps.GetPropInt(victim, "m_bElectroStunned"));
		// printl("FIRE " + NetProps.GetPropInt(victim, "m_bOnFire"));
		// printl("ICE " + NetProps.GetPropFloat(victim, "m_flFrozenTime"));
		// printl("ICE2 " + NetProps.GetPropFloat(victim, "m_flFreezeResistance"));
	// }
	// printl(attacker + " - " + inflictor + " - " + victim);
	// printl(attacker + " - " + NetProps.GetPropFloat(attacker, "m_flFreezeResistance") + victim + " - " + NetProps.GetPropFloat(victim, "m_flFreezeResistance") );
	local blockChance = 0;
	local critChance = 0;
	if (victim.GetName() != "" && victim != "" && victim != null && victim.IsAlien() && attacker.GetName() != "" && attacker != "" && attacker != null && attacker.IsAlien() && victim.GetClassname() == "asw_drone" && attacker.GetClassname() == "asw_drone")
	{
		blockChance = SpecialBlock[victim.GetName()];
		critChance = SpecialCrit[attacker.GetName()];
	}
	local critDamage = 0;
	local blockRoll = RandomInt(1, 100);
	local critRoll = RandomInt(1, 100);
	local height = NetProps.GetPropFloat(victim, "m_fSizeScale") * 120;
	if (GreyAlienEnt.rawin(victim))
	{
		return 0;
	}
	if (blockRoll <= blockChance)
	{
		// CreateParticleFunc(2, victim.GetOrigin() + Vector(0, 0, height), Vector(0, 0, 0), "fast_reload_child_glow2", "", 0, "");
		// PushAway(victim, 10, 3000, 200, null);
		PushAway(victim, 10, 30000, 200, attacker);
		 // local Distance = 3000;
		 // local Radius = 200;
		  // local PushVec = (attacker.GetOrigin() - victim.GetOrigin());
		  // PushVec.z = 0;
		  // local VectorLength = sqrt(pow((victim.GetOrigin().x - attacker.GetOrigin().x), 2) + pow((victim.GetOrigin().y - attacker.GetOrigin().y), 2));
		  // PushVec.x /= VectorLength;
		  // PushVec.y /= VectorLength;
		  // printl("Push Vector -> " + PushVec + " --- Vector Length " + VectorLength);
		  // PushVec *= Distance;
		  // printl(attacker + " Position -> " + attacker.GetOrigin());
		  // attacker.SetVelocity(PushVec);
		return 0;
	}
	// else
	// {
		// printl(blockRoll + " > " + blockChance);
	// }
	if (critRoll <= critChance)
	{
		CreateParticleFunc(2, victim.GetOrigin() + Vector(0, 0, height), Vector(0, 0, 0), "reload_fail_splash", "", 0, "");
		critDamage = damage * SpecialCritDamage[attacker.GetName()];
	}
	
	if (attacker.GetName() == "Special4")
	{
		// DropFreezeGrenade(0, 10, 100, attacker.GetOrigin() + Vector(0, 0, 10));
		// DropStunGrenade(0, 100, attacker.GetOrigin() + Vector(0, 0, 10));
	}
	
	if (victim.GetName() == "Special2" && attacker.GetClassname() == "asw_drone" && inflictor.GetClassname() != "asw_grenade_cluster" && inflictor.GetClassname() != "env_explosion" && inflictor.GetClassname() != "asw_env_explosion")
	{
		Convars.SetValue("sk_plr_dmg_asw_r_g", 100);
		printl(victim + " - " + Time());
		ExplodeOnMe(victim);
	}
	
	if (victim.GetName() == "Special7" && attacker.GetClassname() == "asw_drone")
	{
		if (StompEffectOn.rawin(victim) && StompEffectOn[victim] != 0)
		{
			return 0;
		}
		local CurrHP = victim.GetHealth();
		local CurrMaxHP = victim.GetMaxHealth();
		local Ratio = (CurrHP.tofloat() / CurrMaxHP.tofloat()) * 100;
		if ((Ratio < 500) && (!StompEffectOn.rawin(victim)))
		{
			printl("STOMP TIME : " + CurrHP + " / " + CurrMaxHP + " = " + Ratio + " % ");
			StompEffectOn[victim] <- 1;
			StompEffectPos[victim] <- victim.GetOrigin();
			StompEffectDist[victim] <- 1;
			StompEffectSeq[victim] <- 0;
			AWQueueTimerFunc(15, "Special", victim, "Push");
			return 0;
		}
	}
	if (attacker.GetName() == "Special1" || attacker.GetName() == "Special2" || attacker.GetName() == "Special3" || attacker.GetName() == "Special4" || attacker.GetName() == "Special5" || attacker.GetName() == "Special6" || attacker.GetName() == "Special7" || attacker.GetName() == "Special8")
	{
		local Modifier = NetProps.GetPropFloat(attacker, "m_fSizeScale") / SpecialSize[attacker.GetName()]
		return ((SpecialDMG[attacker.GetName()] + critDamage) * Modifier);
	}
	return damage + critDamage;
}

::SpawnMore <- function (idx)
{
	local IsFighting = true;
	local EntToBuffPos = idx.GetOrigin();
	local EntToBuffFaction = NetProps.GetPropInt(idx, "m_nFaction");
	// local EntToBuffFaction2 = NetProps.GetPropInt(idx, "m_nFaction");
	
	if (idx != null && idx.IsValid() && idx.GetName() == "Special1" && (NetProps.GetPropFloat(idx, "m_fSizeScale") / 2) > 0.3)
	{
		local EntToBuffName = idx.GetName();
		local EntToBuffSize = (NetProps.GetPropFloat(idx, "m_fSizeScale") / 2);
		local EntToBuffSpeed = (NetProps.GetPropFloat(idx, "m_fSpeedScale") / 2);
		// local EntToBuffCurrHP = idx.GetHealth();
		local EntToBuffCurrMaxHP = (idx.GetMaxHealth() / 2);
		
		local BuffedEnt = Entities.CreateByClassname(idx.GetClassname());
		BuffedEnt.SetOrigin(EntToBuffPos);
		NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
		NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
		local BuffedEnt2 = Entities.CreateByClassname(idx.GetClassname());
		BuffedEnt2.SetOrigin(EntToBuffPos + Vector(30,30,0));
		NetProps.SetPropFloat(BuffedEnt2, "m_fSizeScale", EntToBuffSize);
		NetProps.SetPropFloat(BuffedEnt2, "m_fSpeedScale", EntToBuffSpeed);
		
		if (EntToBuffFaction == 1) // Green
		{
			EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
			GreenAlienEnt[BuffedEnt] <- 1;
			EntFireByHandle(BuffedEnt2, "addoutput", "rendercolor 0 255 0", 0, this, this);
			GreenAlienEnt[BuffedEnt2] <- 1;
		}
		else
		{
			EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 255", 0, this, this);
			RedAlienEnt[BuffedEnt] <- 1;
			EntFireByHandle(BuffedEnt2, "addoutput", "rendercolor 255", 0, this, this);
			RedAlienEnt[BuffedEnt2] <- 1;
		}
		
		if (GreenAlienEnt.rawin(idx))
		{
			GreenAlienEnt.rawdelete(idx);
		}
		else if (RedAlienEnt.rawin(idx))
		{
			RedAlienEnt.rawdelete(idx);
		}
		else
		{
			GreyAlienEnt.rawdelete(idx);
		}
		
		if (StasisTimers.rawin(idx))
		{											
			StasisTimers[BuffedEnt] <- StasisTimers[idx];
			StasisTimers[BuffedEnt2] <- StasisTimers[idx];
			StasisTimers.rawdelete(idx);
			StasisFaction[BuffedEnt] <- StasisFaction[idx];
			StasisFaction[BuffedEnt2] <- StasisFaction[idx];
			StasisFaction.rawdelete(idx);
			GreyAlienEnt[BuffedEnt] <- 1;
			GreyAlienEnt[BuffedEnt2] <- 1;
			IsFighting = false;
		}
		if (StealTimers.rawin(idx))
		{											
			StealTimers[BuffedEnt] <- StealTimers[idx];
			StealTimers[BuffedEnt2] <- StealTimers[idx];
			StealTimers.rawdelete(idx);
			StealFaction[BuffedEnt] <- StealFaction[idx];
			StealFaction[BuffedEnt2] <- StealFaction[idx];
			StealFaction.rawdelete(idx);
			// if (EntToBuffFaction == 1)
			// {
				// EntToBuffFaction2 = 2;
			// }
			// else
			// {
				// EntToBuffFaction2 = 1;
			// }
		}
		if (BuffTimers.rawin(idx))
		{							
			BuffTimers[BuffedEnt] <- BuffTimers[idx];
			BuffTimers[BuffedEnt2] <- BuffTimers[idx];
			BuffTimers.rawdelete(idx);
		}
		if (OldHP.rawin(idx))
		{
			OldHP[BuffedEnt] <- OldHP[idx];
			OldHP[BuffedEnt2] <- OldHP[idx];
			OldHP.rawdelete(idx);
		}
		
		local Stun1 = NetProps.GetPropFloat(idx, "m_flElectroStunSlowMoveTime");
		local Stun2 = NetProps.GetPropInt(idx, "m_bElectroStunned");
		local Fire = NetProps.GetPropInt(idx, "m_bOnFire");
		local Ice = NetProps.GetPropFloat(idx, "m_flFrozenTime");
		local Ice2 = NetProps.GetPropFloat(idx, "m_flFreezeResistance");
		
		BuffedEnt.Spawn();
		BuffedEnt.Activate();
		BuffedEnt2.Spawn();
		BuffedEnt2.Activate();
		
		NetProps.SetPropInt(BuffedEnt, "m_nFaction", EntToBuffFaction);
		NetProps.SetPropFloat(BuffedEnt, "m_flElectroStunSlowMoveTime", Stun1);
		NetProps.SetPropInt(BuffedEnt, "m_bElectroStunned", Stun2);
		NetProps.SetPropInt(BuffedEnt, "m_bOnFire", Fire);
		// NetProps.SetPropFloat(BuffedEnt, "m_flFrozenTime", Ice);
		NetProps.SetPropFloat(BuffedEnt, "m_flFreezeResistance", Ice2);
		
		BuffedEnt.Wake(IsFighting);
		BuffedEnt.SetName(EntToBuffName);
		BuffedEnt.SetHealth(EntToBuffCurrMaxHP);
		BuffedEnt.SetMaxHealth(EntToBuffCurrMaxHP);
		MakeDemDrones("model", BuffedEnt);
		MakeDemDrones("flinch", BuffedEnt);
		// MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction2);
		MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction);
		
		NetProps.SetPropInt(BuffedEnt2, "m_nFaction", EntToBuffFaction);
		NetProps.SetPropFloat(BuffedEnt2, "m_flElectroStunSlowMoveTime", Stun1);
		NetProps.SetPropInt(BuffedEnt2, "m_bElectroStunned", Stun2);
		NetProps.SetPropInt(BuffedEnt2, "m_bOnFire", Fire);
		// NetProps.SetPropFloat(BuffedEnt2, "m_flFrozenTime", Ice);
		NetProps.SetPropFloat(BuffedEnt2, "m_flFreezeResistance", Ice2);
		
		local CurrentTime = Ice - Time();
		if (CurrentTime > 0)
		{
			BuffedEnt.Freeze(CurrentTime);
			BuffedEnt2.Freeze(CurrentTime);
		}
		
		BuffedEnt2.Wake(IsFighting);
		BuffedEnt2.SetName(EntToBuffName);
		BuffedEnt2.SetHealth(EntToBuffCurrMaxHP);
		BuffedEnt2.SetMaxHealth(EntToBuffCurrMaxHP);
		MakeDemDrones("model", BuffedEnt2);
		MakeDemDrones("flinch", BuffedEnt2);
		// MakeDemDrones("hpbar", BuffedEnt2, EntToBuffFaction2);
		MakeDemDrones("hpbar", BuffedEnt2, EntToBuffFaction);
		
		DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt);
		DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt2);
		
		StealTimers.rawdelete(idx);
		StealFaction.rawdelete(idx);
		idx.Destroy();
	}
	if (idx != null && idx.IsValid() && idx.GetName() == "Special3" && idx.GetMaxHealth() > 0)
	{
		// printl(idx + " - " + idx.GetMaxHealth());
		local EntToBuffName = idx.GetName();
		local EntToBuffSize = (NetProps.GetPropFloat(idx, "m_fSizeScale"));
		local EntToBuffSpeed = (NetProps.GetPropFloat(idx, "m_fSpeedScale"));
		local EntToBuffCurrMaxHP = 3;
		// local EntToBuffCurrHP = idx.GetHealth();
		if (idx.GetMaxHealth() <= 3)
		{
			EntToBuffCurrMaxHP = idx.GetMaxHealth() - 1;
		}
		
		local BuffedEnt = Entities.CreateByClassname(idx.GetClassname());
		BuffedEnt.SetOrigin(EntToBuffPos);
		NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
		NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
		
		if (EntToBuffFaction == 1) // Green
		{
			EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
			GreenAlienEnt[BuffedEnt] <- 1;
		}
		else
		{
			EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 255", 0, this, this);
			RedAlienEnt[BuffedEnt] <- 1;
		}
		
		if (GreenAlienEnt.rawin(idx))
		{
			GreenAlienEnt.rawdelete(idx);
		}
		else if (RedAlienEnt.rawin(idx))
		{
			RedAlienEnt.rawdelete(idx);
		}
		else
		{
			GreyAlienEnt.rawdelete(idx);
		}
		
		if (StasisTimers.rawin(idx))
		{											
			StasisTimers[BuffedEnt] <- StasisTimers[idx];
			StasisTimers.rawdelete(idx);
			StasisFaction[BuffedEnt] <- StasisFaction[idx];
			StasisFaction.rawdelete(idx);
			GreyAlienEnt[BuffedEnt] <- 1;
			IsFighting = false;
		}
		if (StealTimers.rawin(idx))
		{											
			StealTimers[BuffedEnt] <- StealTimers[idx];
			StealTimers.rawdelete(idx);
			StealFaction[BuffedEnt] <- StealFaction[idx];
			StealFaction.rawdelete(idx);
			// if (EntToBuffFaction == 1)
			// {
				// EntToBuffFaction2 = 2;
			// }
			// else
			// {
				// EntToBuffFaction2 = 1;
			// }
		}
		if (BuffTimers.rawin(idx))
		{							
			BuffTimers[BuffedEnt] <- BuffTimers[idx];
			BuffTimers.rawdelete(idx);
		}
		if (OldHP.rawin(idx))
		{
			OldHP[BuffedEnt] <- OldHP[idx];
			OldHP.rawdelete(idx);
		}
		
		local Stun1 = NetProps.GetPropFloat(idx, "m_flElectroStunSlowMoveTime");
		local Stun2 = NetProps.GetPropInt(idx, "m_bElectroStunned");
		local Fire = NetProps.GetPropInt(idx, "m_bOnFire");
		local Ice = NetProps.GetPropFloat(idx, "m_flFrozenTime");
		local Ice2 = NetProps.GetPropFloat(idx, "m_flFreezeResistance");
					
		BuffedEnt.Spawn();
		BuffedEnt.Activate();
		
		NetProps.SetPropInt(BuffedEnt, "m_nFaction", EntToBuffFaction);
		NetProps.SetPropFloat(BuffedEnt, "m_flElectroStunSlowMoveTime", Stun1);
		NetProps.SetPropInt(BuffedEnt, "m_bElectroStunned", Stun2);
		NetProps.SetPropInt(BuffedEnt, "m_bOnFire", Fire);
		// NetProps.SetPropFloat(BuffedEnt, "m_flFrozenTime", Ice);
		NetProps.SetPropFloat(BuffedEnt, "m_flFreezeResistance", Ice2);
		local CurrentTime = Ice - Time();
		if (CurrentTime > 0)
		{
			BuffedEnt.Freeze(CurrentTime);
		}
					
		BuffedEnt.Wake(IsFighting);
		BuffedEnt.SetName(EntToBuffName);
		BuffedEnt.SetHealth(EntToBuffCurrMaxHP);
		BuffedEnt.SetMaxHealth(EntToBuffCurrMaxHP);
		MakeDemDrones("model", BuffedEnt);
		MakeDemDrones("flinch", BuffedEnt);
		// MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction2);
		MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction);
		
		DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt);
		
		StealTimers.rawdelete(idx);
		StealFaction.rawdelete(idx);
		idx.Destroy();
		
		/*// idx.SetHealth(100);
		local timer = Entities.CreateByClassname("logic_timer");
		timer.__KeyValueFromFloat("RefireTime", 3);
		DoEntFire("!self", "Disable", "", 0, null, timer);
		timer.ValidateScriptScope();
		local timerScope = timer.GetScriptScope();
		
		timerScope.BuffedEnt <- BuffedEnt;
		// timerScope.idx <- idx;
		timerScope.TimerFunc <- function()
		{
			// printl("HELLO");
			BuffedEnt.Destroy();
			// idx.Destroy();
			self.DisconnectOutput("OnTimer", "TimerFunc");
			self.Destroy();
		}
		timer.ConnectOutput("OnTimer", "TimerFunc");
		DoEntFire("!self", "Enable", "", 0, null, timer);*/
	}
}

::TeleportMe <- function (idx, type = 1)
{
	if (idx.GetMaxHealth() > 1)
	{
	// printl(idx + " - " + idx.GetMaxHealth());
	local IsFighting = true;
	local EntToBuffPos = idx.GetOrigin();
	local EntToBuffFaction = NetProps.GetPropInt(idx, "m_nFaction");
	// local EntToBuffFaction2 = NetProps.GetPropInt(idx, "m_nFaction");
	local EntToBuffName = idx.GetName();
	local EntToBuffSize = (NetProps.GetPropFloat(idx, "m_fSizeScale"));
	local EntToBuffSpeed = (NetProps.GetPropFloat(idx, "m_fSpeedScale"));
	local EntToBuffCurrMaxHP = idx.GetMaxHealth();
	local EntToBuffCurrHP = idx.GetHealth();
	
	if (EntToBuffCurrHP <= 0)
	{
		EntToBuffCurrMaxHP = 1;
		EntToBuffCurrHP = 1;
	}
	
	local BuffedEnt = Entities.CreateByClassname(idx.GetClassname());
	local RandomX1 = RandomInt(0, 1);
	local RandomY1 = RandomInt(0, 1);
	local RandomX = RandomInt(100, 500);
	local RandomY = RandomInt(100, 500);
	if (RandomX1 == 1)
	{
		RandomX *= -1;
	}
	if (RandomY1 == 1)
	{
		RandomY *= -1;
	}
	BuffedEnt.SetOrigin(EntToBuffPos + Vector(RandomX, RandomY, 100));
	NetProps.SetPropFloat(BuffedEnt, "m_fSizeScale", EntToBuffSize);
	NetProps.SetPropFloat(BuffedEnt, "m_fSpeedScale", EntToBuffSpeed);
	
	if (EntToBuffFaction == 1) // Green
	{
		EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 0 255 0", 0, this, this);
		GreenAlienEnt[BuffedEnt] <- 1;
	}
	else
	{
		EntFireByHandle(BuffedEnt, "addoutput", "rendercolor 255", 0, this, this);
		RedAlienEnt[BuffedEnt] <- 1;
	}
	
	if (GreenAlienEnt.rawin(idx))
	{
		GreenAlienEnt.rawdelete(idx);
	}
	else if (RedAlienEnt.rawin(idx))
	{
		RedAlienEnt.rawdelete(idx);
	}
	else
	{
		GreyAlienEnt.rawdelete(idx);
	}
	
	if (StasisTimers.rawin(idx))
	{											
		StasisTimers[BuffedEnt] <- StasisTimers[idx];
		StasisTimers.rawdelete(idx);
		StasisFaction[BuffedEnt] <- StasisFaction[idx];
		StasisFaction.rawdelete(idx);
		GreyAlienEnt[BuffedEnt] <- 1;
		IsFighting = false;
	}
	if (StealTimers.rawin(idx))
	{											
		StealTimers[BuffedEnt] <- StealTimers[idx];
		StealTimers.rawdelete(idx);
		StealFaction[BuffedEnt] <- StealFaction[idx];
		StealFaction.rawdelete(idx);
		// if (EntToBuffFaction == 1)
		// {
			// EntToBuffFaction2 = 2;
		// }
		// else
		// {
			// EntToBuffFaction2 = 1;
		// }
	}
	if (BuffTimers.rawin(idx))
	{							
		BuffTimers[BuffedEnt] <- BuffTimers[idx];
		BuffTimers.rawdelete(idx);
	}
	if (OldHP.rawin(idx))
	{
		OldHP[BuffedEnt] <- OldHP[idx];
		OldHP.rawdelete(idx);
	}
	
	local Stun1 = NetProps.GetPropFloat(idx, "m_flElectroStunSlowMoveTime");
	local Stun2 = NetProps.GetPropInt(idx, "m_bElectroStunned");
	local Fire = NetProps.GetPropInt(idx, "m_bOnFire");
	local Ice = NetProps.GetPropFloat(idx, "m_flFrozenTime");
	local Ice2 = NetProps.GetPropFloat(idx, "m_flFreezeResistance");
					
	BuffedEnt.Spawn();
	BuffedEnt.Activate();
	
	NetProps.SetPropInt(BuffedEnt, "m_nFaction", EntToBuffFaction);
	NetProps.SetPropFloat(BuffedEnt, "m_flElectroStunSlowMoveTime", Stun1);
	NetProps.SetPropInt(BuffedEnt, "m_bElectroStunned", Stun2);
	NetProps.SetPropInt(BuffedEnt, "m_bOnFire", Fire);
	// NetProps.SetPropFloat(BuffedEnt, "m_flFrozenTime", Ice);
	NetProps.SetPropFloat(BuffedEnt, "m_flFreezeResistance", Ice2);
	local CurrentTime = Ice - Time();
	if (CurrentTime > 0)
	{
		BuffedEnt.Freeze(CurrentTime);
	}
					
	BuffedEnt.Wake(IsFighting);
	BuffedEnt.SetName(EntToBuffName);
	BuffedEnt.SetHealth(EntToBuffCurrHP);
	BuffedEnt.SetMaxHealth(EntToBuffCurrMaxHP);
	MakeDemDrones("model", BuffedEnt);
	MakeDemDrones("flinch", BuffedEnt);
	// MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction2);
	MakeDemDrones("hpbar", BuffedEnt, EntToBuffFaction);
	
	DoEntFire("!self", "SetRelationship", "asw_marine D_NU 1", 0, null, BuffedEnt);
	
	StealTimers.rawdelete(idx);
	StealFaction.rawdelete(idx);
	idx.Destroy();
	
	CreateParticleFunc(2, BuffedEnt.GetOrigin(), Vector(0, 0, 0), "barrel_rad_gas_cloud", "", 0, "");
	}
}

::ExplodeOnMe <- function (victim, type = 1)
{
	local GrenadeSpawn = function(victim){
		local hGrenadeCluster = Entities.CreateByClassname("asw_grenade_cluster");
		hGrenadeCluster.SetOrigin(victim.GetOrigin() + Vector(0, 0, 10));
		hGrenadeCluster.SetAnglesVector(victim.GetAngles());
		hGrenadeCluster.SetOwner(victim);
		hGrenadeCluster.Spawn();
		CreateParticleFunc("", hGrenadeCluster.GetOrigin(), Vector(0, 0, 0), "ranger_projectile_main_trail", "fuse", 0, hGrenadeCluster);
		return hGrenadeCluster;
	}
	local TrueExplosion = function(grenade){
		local explosion = Entities.CreateByClassname("env_explosion");
		explosion.SetOwner(grenade.GetOwner());
		return explosion;
	}
	local SetThinkFunc = function(explosion, hGrenadeCluster){
		explosion.ValidateScriptScope();
		local explosionScope = explosion.GetScriptScope();
		explosionScope.hGrenadeCluster <- hGrenadeCluster;
		explosionScope.CreateParticleFunc <- CreateParticleFunc;
		explosionScope.func <- function(){
			if (hGrenadeCluster && hGrenadeCluster.IsValid()){
					DoEntFire("!self", "Explode", "", 0, null, self);
					DoEntFire("!self", "Kill", "", 0, null, hGrenadeCluster);
					CreateParticleFunc(0.5, hGrenadeCluster.GetOrigin(), Vector(0, 0, 0), "mortar_explosion", "", 0, "");
					self.EmitSound("ASWGrenade.Explode");
					self.Destroy();
			} else
			{
				DoEntFire("!self", "Kill", "", 0, null, self);
			}
		}
		AddThinkToEnt(explosion, "func");
		// return explosion;
	}
	local hGrenadeCluster = GrenadeSpawn(victim);
	SetThinkFunc(TrueExplosion(hGrenadeCluster), hGrenadeCluster);
}

::MakeDemDrones <- function (Parameter, Entity, Faction = "", Multiplier = 1)
{
	local EntToBuffName = Entity.GetName();
	// if (EntToBuffName == "Special1" || EntToBuffName == "Special2" || EntToBuffName == "Special3" || EntToBuffName == "Special4" || EntToBuffName == "Special5" || EntToBuffName == "Special6" || EntToBuffName == "Special7" || EntToBuffName == "Special8")
	// {
	local CurrSize = NetProps.GetPropFloat(Entity, "m_fSizeScale");
	local NewCurrSize = NetProps.GetPropFloat(Entity, "m_fSizeScale") / SpecialSize[EntToBuffName];
	// printl(CurrSize + "-" + NetProps.GetPropFloat(Entity, "m_fSizeScale") + " / " + SpecialSize[EntToBuffName]);
	if (CurrSize != 1 && NewCurrSize != 1)
	{
		Multiplier *= NewCurrSize;
	}
		if (Parameter == "model")
		{
			Entity.SetModel(SpecialMDL[EntToBuffName]);
		}
		if (Parameter == "hp")
		{
			Entity.SetHealth((SpecialHP[EntToBuffName] * Multiplier));
			Entity.SetMaxHealth((SpecialHP[EntToBuffName] * Multiplier));
		}
		if (Parameter == "speed")
		{
			NetProps.SetPropFloat(Entity, "m_fSpeedScale", (SpecialSPD[EntToBuffName] * Multiplier));
			NetProps.SetPropFloat(Entity, "m_fSizeScale", (SpecialSize[EntToBuffName] * Multiplier));
		}
		if (Parameter == "flinch")
		{
			if (SpecialIce[EntToBuffName] == 1)
			{
				DoEntFire("!self", "AddOutput", "freezable false", 0, null, Entity);
			}
			if (SpecialFire[EntToBuffName] == 1)
			{
				DoEntFire("!self", "AddOutput", "flammable false", 0, null, Entity);
			}
			if (SpecialTesla[EntToBuffName] == 1)
			{
				DoEntFire("!self", "AddOutput", "teslable false", 0, null, Entity);
			}
			if (SpecialFlinch[EntToBuffName] == 1)
			{
				DoEntFire("!self", "AddOutput", "flinchable false", 0, null, Entity);
			}
			// EntFireByHandle(Entity, "addoutput", "flammable false", 0, this, this);
					// NetProps.SetPropInt(Entity, "m_bFlammable", 0);
					// NetProps.SetPropInt(Entity, "m_bTeslable", 0);
					// NetProps.SetPropInt(Entity, "m_bFreezable", 0);
					// NetProps.SetPropInt(Entity, "m_bFlinchable", 0);
			// DoEntFire("!self", "addoutput", "flinchable false", 0, null, Entity);
			// DoEntFire("!self", "addoutput", "flammable false", 0, null, Entity);
			// DoEntFire("!self", "addoutput", "freezable false", 0, null, Entity);
			// DoEntFire("!self", "AddOutput", "flinchable false", 0, null, Entity);
		}
		if (Parameter == "hpbar")
		{
			if (SpecialHPBAR[EntToBuffName] > 0)
			{
				healthbar <- null;
				healthbar = Entities.CreateByClassname("asw_health_bar");
				local hpname = UniqueString();
				//healthbar.__KeyValueFromString("parentname",boss_drone_unique_name);	// doesn't work
				if (Faction == 1)
				{
					healthbar.__KeyValueFromString("color", "0 255 0 255");
				}
				else if (Faction == 2)
				{
					healthbar.__KeyValueFromString("color", "255 0 0 255");
				}
				else
				{
					healthbar.__KeyValueFromString("color", "100 100 100 255");
				}
				healthbar.__KeyValueFromString("StartDisabled", "0");
				healthbar.__KeyValueFromString("scale", (SpecialHPBAR[EntToBuffName] * Multiplier).tostring());
				healthbar.__KeyValueFromString("hideatfullhealth", "0");
				// healthbar.SetName(HPBarCount + "_healthbar");
				healthbar.SetName(hpname);
				//healthbar.SetName("healthbar");

				healthbar.Spawn();
				healthbar.Activate();

				EntFireByHandle(healthbar, "SetParent", "!activator", 0, Entity, Entity);
				EntFireByHandle(healthbar, "SetParentAttachment", "blood_spray", 0, null, null);
				Entity.ValidateScriptScope();
				local EntityScope = Entity.GetScriptScope();
				EntityScope.hpname <- hpname;
				
				EntityScope.SpecialDroneDied <- function()
				{
					local healthbar = Entities.FindByName(hpname);
					if ( healthbar )
						healthbar.Destroy();
					
					self.DisconnectOutput("OnDeath", "SpecialDroneDied");
				}

				// self.ValidateScriptScope();
				// self.GetScriptScope().BossDroneDied <- BossDroneDied;
				// self.ConnectOutput("OnDeath", "SpecialDroneDied");
			}
		}
	// }
}

::GoToMiddle <- function (Entity, Faction = null)
{
	local Order = NetProps.GetPropInt(Entity, "m_AlienOrders");
	local OrderObj = NetProps.GetPropEntity(Entity, "m_AlienOrderObject");
	if (Order == 4)
	{
		if (Faction == "Green")
		{
			Entity.OrderMoveTo(ThisIsCenterRight, false);
		}
		else if (Faction == "Red")
		{
			Entity.OrderMoveTo(ThisIsCenterLeft, false);
		}
		else
		{
			Entity.OrderMoveTo(ThisIsCenter, false);
		}
	}
}

::PushAway <- function (Entity, Damage = 30, Distance = 3000, Area = 200, Target = null)
{
	local PushedEnt = null;
	local FactionEnt = NetProps.GetPropInt(Entity, "m_nFaction");
	if (Target != null)
	{
		local height = NetProps.GetPropFloat(Entity, "m_fSizeScale") * 120;
		CreateParticleFunc(2, Entity.GetOrigin() + Vector(0, 0, height), Vector(0, 0, 0), "fast_reload_child_glow2", "", 0, "");
		local PushVec = (Target.GetOrigin() - Entity.GetOrigin());
		PushVec.z = 0;
		
		local VectorLength = sqrt(pow((Entity.GetOrigin().x - Target.GetOrigin().x), 2) + pow((Entity.GetOrigin().y - Target.GetOrigin().y), 2));
		
		PushVec.x /= VectorLength;
		PushVec.y /= VectorLength;
		PushVec *= Distance;
		// printl(Target + " -> " + Target.GetOrigin());
		// Target.SetVelocity(PushVec);
		UpdateArray.rawset(Target, PushVec);
		// printl("Target Now -> " + Target.GetOrigin());
		// printl("Push Vec -> " + PushVec);
		local HPEnt = Target.GetHealth();
		if (Damage > 0)
		{
			HPEnt -= Damage;
			// printl(Target + " : " + Target.GetHealth() + " ---- " + Damage + " --- " + VectorLength + " -> " + PushVec);
			// printl(Target + " : " + Target.GetHealth() + " ---- " + Damage + " --- " + " -> " + PushVec);
			if (HPEnt <= 0)
			{
				Target.TakeDamage(Damage, 64, Entity);
			}
			else
			{
				Target.SetHealth(HPEnt);
			}
			// printl(Target.GetHealth());
		}
	}
	else
	{
		local height = NetProps.GetPropFloat(Entity, "m_fSizeScale") * 120;
		// local height = NetProps.GetPropFloat(Entity, "m_fSizeScale") * 0;
		CreateParticleFunc(2, Entity.GetOrigin() + Vector(0, 0, height), Vector(0, 0, 0), "impact_water_child_rings", "", 0, "");
		CreateParticleFunc(2, Entity.GetOrigin() + Vector(0, 0, height), Vector(0, 0, 0), "impact_puddle_ring", "", 0, "");
		CreateParticleFunc(2, Entity.GetOrigin() + Vector(0, 0, height), Vector(0, 0, 0), "impact_metal_child_glow", "", 0, "");
		CreateParticleFunc(2, Entity.GetOrigin() + Vector(0, 0, height), Vector(0, 0, 0), "impact_dirt_child_bounce", "", 0, "");
		while((PushedEnt = Entities.FindByClassnameWithin(PushedEnt, "asw_drone", Entity.GetOrigin(), Area)) != null)
		{
			local PushedFactionEnt = NetProps.GetPropInt(PushedEnt, "m_nFaction");
			if (FactionEnt != PushedFactionEnt)
			{			
				local PushVec = (PushedEnt.GetOrigin() - Entity.GetOrigin());
				PushVec.z = 0;
				
				local VectorLength = sqrt(pow((Entity.GetOrigin().x - PushedEnt.GetOrigin().x), 2) + pow((Entity.GetOrigin().y - PushedEnt.GetOrigin().y), 2));
				
				PushVec.x /= VectorLength;
				PushVec.y /= VectorLength;
				
				// printl("Push Vector -> " + PushVec + " --- Vector Length " + VectorLength);
				PushVec *= Distance;
				// printl(PushedEnt + " -> " + PushedEnt.GetOrigin());
				PushedEnt.SetVelocity(PushVec);
				// printl(PushedEnt + " Position -> " + PushedEnt.GetOrigin());
				// printl("Target Now -> " + PushedEnt.GetOrigin());
				// printl("Push Vec -> " + PushVec);
				// PushedEnt.SetVelocity(PushVec);
				local HPEnt = PushedEnt.GetHealth();
				if (Damage > 0)
				{
					HPEnt -= Damage;
					// printl(PushedEnt + " : " + PushedEnt.GetHealth() + " ---- " + Damage);
					if (HPEnt <= 0)
					{
						PushedEnt.TakeDamage(Damage, 64, Entity);
					}
					else
					{
						PushedEnt.SetHealth(HPEnt);
					}
					// printl(PushedEnt.GetHealth());
				}
			}
		}
	}
}

::StompCharge <- function (Entity, Faction = null)
{
	local Order = NetProps.GetPropInt(Entity, "m_AlienOrders");
	local OrderObj = NetProps.GetPropEntity(Entity, "m_AlienOrderObject");
	local EntityPos = Entity.GetOrigin()
	// local Stomp = StompEffectPos[Entity];
	// local StompSequence = StompEffectSeq[Entity];
	// printl(Order);
	// if (Order == 4)
	if (StompEffectDist[Entity] <= StompEffectMaxDist)
	{
		// if (StompEffectSeq[Entity] > 360)
		// {
			// StompEffectSeq[Entity] = 0;
		// }
		
		// StompEffectSeq[Entity] = atan2(StompEffectPos[Entity].y - EntityPos.y, StompEffectPos[Entity].x - EntityPos.x) * 180 / PI;
		// StompEffectSeq[Entity] = atan2(StompEffectPos[Entity].y, EntityPos.x) * 180 / PI;
		// StompEffectSeq[Entity] += 0.1
		StompEffectSeq[Entity] += (10 / StompEffectDist[Entity].tofloat());
		StompEffectDist[Entity] += 1;
		
		// local CircleX = 100 * cos(StompEffectSeq[Entity] * PI / 180)
		// local CircleY = 100 * sin(StompEffectSeq[Entity] * PI / 180)
		local CircleX = StompEffectDist[Entity] * cos(StompEffectSeq[Entity])
		local CircleY = StompEffectDist[Entity] * sin(StompEffectSeq[Entity])
		
		// local TargetOfMove = g_PlaguePosition[hMarine].x = (hMarine.GetOrigin()).x + CircleX
		// g_PlaguePosition[hMarine].y = (hMarine.GetOrigin()).y + CircleY
		local TargetOfMove = Vector(0,0,0);
		TargetOfMove.x = StompEffectPos[Entity].x + CircleX;
		TargetOfMove.y = StompEffectPos[Entity].y + CircleY;
		TargetOfMove.z = StompEffectPos[Entity].z;
		
		// printl(Entity + " ------- " + EntityPos + " ------- " + StompEffectSeq[Entity] + " -------- " + StompEffectDist[Entity]);
		Entity.SetOrigin(TargetOfMove);
		// Entity.OrderMoveTo(TargetOfMove, true);
	}
	else
	{
		// StompEffectPos = EntityPos;
		// StompEffectDist = 1;
		// StompEffectSeq = 0;
		// StompEffectOn[Entity] = 0;
		StompEffectPos.rawdelete(Entity);
		StompEffectDist.rawdelete(Entity);
		StompEffectSeq.rawdelete(Entity);
		StompEffectOn[Entity] = 0;
	}
}

::SetCvars <- function()
{
	/// No Damage
	Convars.SetValue("rd_shotgun_dmg_base", 0.0001);
	Convars.SetValue("rd_rifle_dmg_base", 0.0001);
	Convars.SetValue("rd_prifle_dmg_base", 0.0001);
	Convars.SetValue("rd_autogun_dmg_base", 0.0001);
	Convars.SetValue("rd_vindicator_dmg_base", 0.0001);
	Convars.SetValue("rd_pistol_dmg_base", 0.0001);
	Convars.SetValue("rd_railgun_dmg_base", 0.0001);
	Convars.SetValue("rd_pdw_dmg_base", 0.0001);
	Convars.SetValue("rd_flamer_dmg_base", 0.0001);
	Convars.SetValue("rd_minigun_dmg_base", 0.0001);
	Convars.SetValue("rd_sniper_dmg_base", 0.0001);
	Convars.SetValue("rd_chainsaw_dmg_base", 0.0001);
	Convars.SetValue("rd_grenade_launcher_dmg_base", 0.0001);
	Convars.SetValue("rd_grenade_launcher_projectile_direct_dmg", 0.0001);
	Convars.SetValue("rd_mininglaser_dmg_base", 0.0001);
	Convars.SetValue("rd_deagle_dmg_base", 0.0001);
	Convars.SetValue("rd_devastator_dmg_base", 0.0001);
	Convars.SetValue("rd_combat_rifle_dmg_base", 0.0001);
	Convars.SetValue("rd_heavy_rifle_dmg_base", 0.0001);
	Convars.SetValue("rd_medrifle_dmg_base", 0.0001);
	
	Convars.SetValue("asw_skill_melee_dmg_base", 0);
	Convars.SetValue("asw_skill_melee_dmg_step", 0);
	Convars.SetValue("asw_skill_piercing_base", 0);
	Convars.SetValue("asw_skill_piercing_step", 0);
	Convars.SetValue("asw_skill_vindicator_pellets_base", 0);
	Convars.SetValue("asw_skill_vindicator_pellets_step", 0);
	Convars.SetValue("asw_skill_autogun_base", 0);
	Convars.SetValue("asw_skill_autogun_step", 0);
	
	Convars.SetValue("asw_skill_accuracy_deagle_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_deagle_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_flamer_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_flamer_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_heavy_rifle_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_heavy_rifle_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_medrifle_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_medrifle_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_pdw_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_pdw_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_pistol_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_pistol_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_prifle_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_prifle_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_railgun_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_railgun_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_rifle_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_rifle_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_shotgun_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_shotgun_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_sniper_rifle_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_sniper_rifle_dmg_step", 0);
	Convars.SetValue("asw_skill_accuracy_tesla_cannon_dmg_base", 0);
	Convars.SetValue("asw_skill_accuracy_tesla_cannon_dmg_step", 0);
	
	
	/// marine speed
	// Convars.SetValue("asw_skill_agility_movespeed_base", 1000);
	// Convars.SetValue("asw_skill_agility_movespeed_step", 0);
	// Convars.SetValue( "asw_marine_speed_scale_easy", 10 );
	// Convars.SetValue( "asw_marine_speed_scale_normal", 10 );
	// Convars.SetValue( "asw_marine_speed_scale_hard", 10 );
	// Convars.SetValue( "asw_marine_speed_scale_insane", 10 );
	
	/// gameplay
	// Convars.SetValue( "asw_marine_rolls", 0 );
	// Convars.SetValue("rd_marine_jump_height", 100);
	// Convars.SetValue("asw_marine_gravity", 1);
	// Convars.SetValue( "rd_hackall", 1 );
	Convars.ExecuteConCommand("rda_hide_backpack");
	
	// Convars.SetValue("think_limit", 1);
}

::LobbyStart <- function()
{
	if (RemoveWeapon)
	{
		Convars.SetValueString("rd_weapons_regular_allowed", "0");
	}
	Convars.SetValue("rd_weapons_regular_class_unrestricted", -2);
	Convars.SetValueString("rd_weapons_extra_class_unrestricted", "4");
	
	// Convars.SetValueString("rd_challenge", "montest");
	Convars.SetValueString("rd_challenge", "0");
	Convars.SetValueString( "asw_horde_override", "0" );
	Convars.SetValueString( "asw_wanderer_override", "0" );
	// Convars.SetValueString( "asw_marine_ff_absorption", "1" );
	// Convars.SetValueString( "asw_marine_ff", "1" );
	// Convars.SetValueString( "asw_marine_death_protection", "1" );
	// Convars.SetValueString( "asw_marine_ff_dmg_base", "1" );
	
	// Convars.SetValueString("asw_horde_override", "0");
	// Convars.SetValueString("asw_wanderer_override", "0");
	// Convars.SetValueString("asw_marine_ff_absorption", "1");
	// Convars.SetValue( "asw_marine_ff_absorption", 1 );
	// Convars.SetValue( "asw_marine_ff", 1 );
	// Convars.SetValue( "asw_marine_death_protection", 1 );
	// Convars.SetValue( "asw_marine_ff_dmg_base", 1 );
	// Convars.SetValue("asw_horde_override", 0);
	// Convars.SetValue("asw_wanderer_override", 0);
	// Convars.SetValue("asw_marine_ff_absorption", 1);
	// Convars.SetValue("mat_fullbright", 1);
	// Convars.SetValue("rd_weapons_regular_allowed", "26 10");
	// Convars.SetValue("rd_weapons_regular_allowed", "11 20 21 22"); // buff items
	// Convars.SetValueString("rd_weapons_regular_allowed", "0 1 3 10 12 22 23 25"); // regular items
	// Convars.SetValueString("rd_weapons_regular_allowed", "0 1 3 10 12 22 23 25 8"); // regular items + mortar
	// Convars.SetValueString("rd_weapons_regular_allowed", "0 1 3 10 12 16 23 25 8"); // regular items + mortar
	// Convars.SetValueString("rd_weapons_regular_allowed", "5 13 14 17 19 20");
	// Convars.SetValue("rd_weapons_regular_allowed_inverted", 1);
	// Convars.SetValueString("rd_weapons_extra_allowed", "4");
	// Convars.SetValue("asw_controls", 1);
}