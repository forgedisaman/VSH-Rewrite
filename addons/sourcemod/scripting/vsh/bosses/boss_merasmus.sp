//Models made by bentorianbezil
#define MERASMUS_MODEL "models/player/vsh_rewrite/merasmus/merasmus.mdl"
#define MERASMUS_MODEL_WAND "models/player/vsh_rewrite/merasmus/c_merasmus_staff.mdl"
#define MERASMUS_MODEL_ARMS "models/player/vsh_rewrite/merasmus/c_merasmus_arms.mdl"

static char g_strMerasmusRoundStart[][] = {
	"vo/halloween_merasmus/sf12_appears02.mp3",
	"vo/halloween_merasmus/sf12_appears04.mp3",
	"vo/halloween_merasmus/sf12_appears08.mp3",
	"vo/halloween_merasmus/sf12_appears17.mp3"
};

static char g_strMerasmusWin[][] = {
	"vo/halloween_merasmus/sf14_merasmus_stalemate_01.mp3",
	"vo/halloween_merasmus/sf12_leaving09.mp3"
};

static char g_strMerasmusLose[][] = {
	"vo/halloween_merasmus/hall2015_fightmeras_win_12.mp3",
	"vo/halloween_merasmus/sf12_defeated07.mp3"
};

static char g_strMerasmusRage[][] = {
	"vo/halloween_merasmus/sf12_bcon_held_up12.mp3",
	"vo/halloween_merasmus/sf12_bcon_held_up30.mp3"
};

static char g_strMerasmusJump[][] = {
	"vo/halloween_merasmus/sf12_wheel_gravity01.mp3",
	"vo/halloween_merasmus/sf12_wheel_gravity02.mp3",
	"vo/halloween_merasmus/sf12_wheel_gravity04.mp3"
};

static char g_strMerasmusKillScout[][] = {
	"vo/halloween_merasmus/sf14_merasmus_necromasher_08.mp3"
};
static char g_strMerasmusKillSoldier[][] = {	
	"vo/halloween_merasmus/sf12_appears13.mp3"
};

static char g_strMerasmusKillPyro[][] = {
	"vo/halloween_merasmus/sf12_wheel_fire04.mp3"
};

static char g_strMerasmusKillDemoman[][] = {
	"vo/halloween_merasmus/sf12_grenades05.mp3"
};

static char g_strMerasmusKillHeavy[][] = {
	"vo/halloween_merasmus/sf12_grenades03.mp3"
};

static char g_strMerasmusKillEngineer[][] = {
	"vo/halloween_merasmus/hall2015_fightmeras_01.mp3"
};

static char g_strMerasmusKillMedic[][] = {
	"vo/halloween_merasmus/sf14_merasmus_necromasher_03.mp3"
};

static char g_strMerasmusKillSniper[][] = {
	"vo/halloween_merasmus/sf12_found08.mp3",
	"vo/halloween_merasmus/sf12_found07.mp3"
};

static char g_strMerasmusKillSpy[][] = {
	"vo/halloween_merasmus/sf12_found02.mp3"
};

static char g_strMerasmusKillBuilding[][] = {
	"vo/halloween_merasmus/sf14_merasmus_effect_noguns_01.mp3"
};

static char g_strMerasmusLastMan[][] = {
	"vo/halloween_merasmus/sf14_merasmus_minigame_overtime_03.mp3",
	"vo/halloween_merasmus/sf14_merasmus_minigame_overtime_04.mp3",
	"vo/halloween_merasmus/sf14_merasmus_necromasher_miss_03.mp3"
};

static char g_strMerasmusBackStabbed[][] = {
	"vo/halloween_merasmus/hall2015_fightmeras_win_06.mp3",
	"vo/halloween_merasmus/sf12_magic_backfire06.mp3"
};

static int g_iMerasmusModelWand = -1;
static int g_iMerasmusModelArms = -1;

methodmap CMerasmus < SaxtonHaleBase
{
	public CMerasmus(CMerasmus boss)
	{
		boss.CallFunction("CreateAbility", "CBombProjectile");
		CWeaponSpells weaponSpells = boss.CallFunction("CreateAbility", "CWeaponSpells");
		weaponSpells.AddSpells(haleSpells_Jump);
		weaponSpells.flRageRequirement = 0.0;
		weaponSpells.flCooldown = 5.0;
		
		
		boss.iBaseHealth = 800;
		boss.iHealthPerPlayer = 800;
		boss.nClass = TFClass_Sniper;
		boss.iMaxRageDamage = 2500;
	}
	
	public void GetBossName(char[] sName, int length)
	{
		strcopy(sName, length, "Merasmus");
	}
	
	public void GetBossInfo(char[] sInfo, int length)
	{
		StrCat(sInfo, length, "\nHealth: Medium");
		StrCat(sInfo, length, "\n ");
		StrCat(sInfo, length, "\nAbilities");
		StrCat(sInfo, length, "\n- rocket jump spell");
		StrCat(sInfo, length, "\n ");
		StrCat(sInfo, length, "\nRage");
		StrCat(sInfo, length, "\n- scares nearby players");
		StrCat(sInfo, length, "\n- 200%% Rage: extended radius and 7.5 scare time");
	}
	
	public void OnSpawn()
	{
		char attribs[128];
		Format(attribs, sizeof(attribs), "2 ; 2.40 ; 252 ; 0.5 ; 259 ; 1.0");
		int iWeapon = this.CallFunction("CreateWeapon", 3, "tf_weapon_club", 666, TFQual_Haunted, attribs);
		if (iWeapon > MaxClients)
		{
			SetEntProp(iWeapon, Prop_Send, "m_nModelIndexOverrides", g_iMerasmusModelWand);
			
			int iViewModel = CreateViewModel(this.iClient, g_iMerasmusModelWand);
			SetEntPropEnt(iViewModel, Prop_Send, "m_hWeaponAssociatedWith", iWeapon);
			SetEntPropEnt(iWeapon, Prop_Send, "m_hExtraWearableViewModel", iViewModel);
			
			CreateViewModel(this.iClient, g_iMerasmusModelArms);
			SetEntProp(GetEntPropEnt(this.iClient, Prop_Send, "m_hViewModel"), Prop_Send, "m_fEffects", EF_NODRAW);
			
			SetEntPropEnt(this.iClient, Prop_Send, "m_hActiveWeapon", iWeapon);
		}
		
		/*
		Wand attributes:
		
		2: damage bonus
		252: reduction in push force taken from damage
		259: Deals 3x falling damage to the player you land on
		214: kill_eater
		*/
	}
	
	public void GetModel(char[] sModel, int length)
	{
		strcopy(sModel, length, MERASMUS_MODEL);
	}
	
	public void OnWeaponSwitchPost(int iWeapon)
	{
		SetEntProp(GetEntPropEnt(this.iClient, Prop_Send, "m_hViewModel"), Prop_Send, "m_fEffects", EF_NODRAW);
	}
	
	public void GetSound(char[] sSound, int length, SaxtonHaleSound iSoundType)
	{
		switch (iSoundType)
		{
			case VSHSound_RoundStart: strcopy(sSound, length, g_strMerasmusRoundStart[GetRandomInt(0,sizeof(g_strMerasmusRoundStart)-1)]);
			case VSHSound_Win: strcopy(sSound, length, g_strMerasmusWin[GetRandomInt(0,sizeof(g_strMerasmusWin)-1)]);
			case VSHSound_Lose: strcopy(sSound, length, g_strMerasmusLose[GetRandomInt(0,sizeof(g_strMerasmusLose)-1)]);
			case VSHSound_Rage: strcopy(sSound, length, g_strMerasmusRage[GetRandomInt(0,sizeof(g_strMerasmusRage)-1)]);
			case VSHSound_KillBuilding: strcopy(sSound, length, g_strMerasmusKillBuilding[GetRandomInt(0,sizeof(g_strMerasmusKillBuilding)-1)]);
			case VSHSound_Lastman: strcopy(sSound, length, g_strMerasmusLastMan[GetRandomInt(0,sizeof(g_strMerasmusLastMan)-1)]);
			case VSHSound_Backstab: strcopy(sSound, length, g_strMerasmusBackStabbed[GetRandomInt(0,sizeof(g_strMerasmusBackStabbed)-1)]);
		}
	}
	
	public void GetSoundKill(char[] sSound, int length, TFClassType nClass)
	{
		switch (nClass)
		{
			case TFClass_Scout: strcopy(sSound, length, g_strMerasmusKillScout[GetRandomInt(0,sizeof(g_strMerasmusKillScout)-1)]);
			case TFClass_Soldier: strcopy(sSound, length, g_strMerasmusKillSoldier[GetRandomInt(0,sizeof(g_strMerasmusKillSoldier)-1)]);
			case TFClass_Pyro: strcopy(sSound, length, g_strMerasmusKillPyro[GetRandomInt(0,sizeof(g_strMerasmusKillPyro)-1)]);
			case TFClass_DemoMan: strcopy(sSound, length, g_strMerasmusKillDemoman[GetRandomInt(0,sizeof(g_strMerasmusKillDemoman)-1)]);
			case TFClass_Heavy: strcopy(sSound, length, g_strMerasmusKillHeavy[GetRandomInt(0,sizeof(g_strMerasmusKillHeavy)-1)]);
			case TFClass_Engineer: strcopy(sSound, length, g_strMerasmusKillEngineer[GetRandomInt(0,sizeof(g_strMerasmusKillEngineer)-1)]);
			case TFClass_Medic: strcopy(sSound, length, g_strMerasmusKillMedic[GetRandomInt(0,sizeof(g_strMerasmusKillMedic)-1)]);
			case TFClass_Sniper: strcopy(sSound, length, g_strMerasmusKillSniper[GetRandomInt(0,sizeof(g_strMerasmusKillSniper)-1)]);
			case TFClass_Spy: strcopy(sSound, length, g_strMerasmusKillSpy[GetRandomInt(0,sizeof(g_strMerasmusKillSpy)-1)]);
		}
	}
	
	public Action OnSoundPlayed(int clients[MAXPLAYERS], int &numClients, char sample[PLATFORM_MAX_PATH], int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
	{
		if (strncmp(sample, "vo/", 3) == 0)//Block voicelines
			return Plugin_Handled;
		return Plugin_Continue;
	}
	
	public void Precache()
	{
		PrecacheModel(MERASMUS_MODEL);
		g_iMerasmusModelWand = PrecacheModel(MERASMUS_MODEL_WAND);
		g_iMerasmusModelArms = PrecacheModel(MERASMUS_MODEL_ARMS);
		
		for (int i = 0; i < sizeof(g_strMerasmusRoundStart); i++) PrecacheSound(g_strMerasmusRoundStart[i]);
		for (int i = 0; i < sizeof(g_strMerasmusWin); i++) PrecacheSound(g_strMerasmusWin[i]);
		for (int i = 0; i < sizeof(g_strMerasmusLose); i++) PrecacheSound(g_strMerasmusLose[i]);
		for (int i = 0; i < sizeof(g_strMerasmusRage); i++) PrecacheSound(g_strMerasmusRage[i]);
		for (int i = 0; i < sizeof(g_strMerasmusJump); i++) PrecacheSound(g_strMerasmusJump[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillScout); i++) PrecacheSound(g_strMerasmusKillScout[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillSoldier); i++) PrecacheSound(g_strMerasmusKillSoldier[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillPyro); i++) PrecacheSound(g_strMerasmusKillPyro[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillDemoman); i++) PrecacheSound(g_strMerasmusKillDemoman[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillHeavy); i++) PrecacheSound(g_strMerasmusKillHeavy[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillEngineer); i++) PrecacheSound(g_strMerasmusKillEngineer[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillMedic); i++) PrecacheSound(g_strMerasmusKillMedic[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillSniper); i++) PrecacheSound(g_strMerasmusKillSniper[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillSpy); i++) PrecacheSound(g_strMerasmusKillSpy[i]);
		for (int i = 0; i < sizeof(g_strMerasmusKillBuilding); i++) PrecacheSound(g_strMerasmusKillBuilding[i]);
		for (int i = 0; i < sizeof(g_strMerasmusLastMan); i++) PrecacheSound(g_strMerasmusLastMan[i]);
		for (int i = 0; i < sizeof(g_strMerasmusBackStabbed); i++) PrecacheSound(g_strMerasmusBackStabbed[i]);
		
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/merasmus.mdl");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/merasmus.sw.vtx");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/merasmus.vvd");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/merasmus.phy");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/merasmus.dx80.vtx");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/merasmus.dx90.vtx");
		
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_staff.mdl");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_staff.sw.vtx");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_staff.vvd");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_staff.phy");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_staff.dx80.vtx");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_staff.dx90.vtx");
		
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_arms.sw.mdl");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_arms.sw.sw.vtx");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_arms.sw.vvd");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_arms.sw.dx80.vtx");
		AddFileToDownloadsTable("models/player/vsh_rewrite/merasmus/c_merasmus_arms.sw.dx90.vtx");
	}
};