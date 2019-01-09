#include <sourcemod>
#include <tf2>
#include <tf2_stocks>
#include <sdkhooks>
#include <tf2attributes>
#include <tf2items>
#include <sdktools>

#define HHH	 "/vo/spy_stabtaunt16.mp3"
#define HHH3 "/vo/sniper_incoming01.mp3"
#define HHH6 "/vo/sniper_incoming01.mp3"
#define Monoculus "ui/halloween_boss_summoned_monoculus.wav"
#define HHH2 "models/player/spy.mdl"
#define HHH4 "models/player/sniper.mdl"
#define HHH5 "models/player/scout.mdl"
#define HHH7 "models/bots/boss_bot/boss_tank.mdl"
#define HHH8 "models/player/engineer.mdl"
#define BOO "vo/halloween_scream4.mp3"
#define See "freak_fortress_2/seeman/seeman_see.wav"
#define See2 "freak_fortress_2/seeman/seeldier_see.wav"
#define Painis "models/player/soldier.mdl"
#define EasterDemo "models/player/saxton_hale/easter_demo.mdl"
#define IAmPainisCupcake "vo/soldier_jeers07.mp3"
#define DEATH	"#mvm/sentrybuster/mvm_sentrybuster_explode.wav"
#define DEATH2 "#mvm/mvm_tank_explode.wav"
#define DEATH2_1 "#mvm/mvm_tank_end.wav"
#define AXE "models/empty.mdl"
#define Baldi "#freak_fortress_2/baldi/intro.mp3"
#define SOUND_KILLDEMO	"sound/%sfreak_fortress_2/ninjaspy/kill_demo.wav"
#define SOUND_KILLPYRO	"sound/freak_fortress_2/ninjaspy/kill_pyro.wav"
#define SOUND_KILLSCOUT	"sound/freak_fortress_2/ninjaspy/kill_scout.wav"
#define SOUND_KILLSOLDIER	"sound/freak_fortress_2/ninjaspy/kill_soldier.wav"
#define SOUND_KILLHEAVY	"sound/freak_fortress_2/ninjaspy/kill_heavy.wav"
#define DemoPan "models/freak_fortress_2/demopan/demopan_v1.mdl"
#define NinjaSpy "models/freak_fortress_2/ninjaspy/ninjaspy_v2_2.mdl"
#define SPAWN1			"saxton_hale/saxton_hale_132_start_1.wav"
#define SPAWN2			"saxton_hale/saxton_hale_132_start_2.wav"
#define SPAWN3			"saxton_hale/saxton_hale_132_start_3.wav"
#define SPAWN4			"saxton_hale/saxton_hale_132_start_4.wav"
#define SPAWN5			"saxton_hale/saxton_hale_132_start_5.wav"
#define SPAWN6			"saxton_hale/saxton_hale_132_stub_4.wav"
#define FAIL1			"saxton_hale/saxton_hale_responce_fail1.wav"
#define FAIL2			"saxton_hale/saxton_hale_responce_fail2.wav"
#define FAIL3			"saxton_hale/saxton_hale_responce_fail3.wav"
#define SOUND_JUMP1			"saxton_hale/saxton_hale_responce_jump1.wav"
#define SOUND_JUMP2			"saxton_hale/saxton_hale_responce_jump2.wav"
#define SOUND_JUMP3			"saxton_hale/saxton_hale_132_jump_1.wav"
#define SOUND_JUMP4			"saxton_hale/saxton_hale_132_jump_2.wav"
#define SOUND_TAUNT1		"saxton_hale/saxton_hale_responce_rage1.wav"
#define SOUND_TAUNT2		"saxton_hale/saxton_hale_responce_rage2.wav"
#define SOUND_TAUNT3		"saxton_hale/saxton_hale_responce_rage3.wav"
#define SOUND_TAUNT4		"saxton_hale/saxton_hale_responce_rage4.wav"

public Plugin:myinfo = 
{
	name = "[TF2] Be the Brutal Bosses",
	author = "Seamus's Server",
	description = "",
	version = "1.0",
	url = ""
}

new bool:g_bIsHHH[MAXPLAYERS + 1];
new bool:g_bIsHeavy[MAXPLAYERS + 1];
new bool:g_bIsHeavyVoice[MAXPLAYERS + 1];
new bool:g_bIsBrutal[MAXPLAYERS + 1];
new bool:g_bTank[MAXPLAYERS + 1];
new bool:g_bSniper[MAXPLAYERS + 1];
new bool:g_bMC[MAXPLAYERS + 1];
new bool:g_bEngie[MAXPLAYERS + 1];
new bool:g_bSee[MAXPLAYERS + 1];
new bool:g_bHalloween[MAXPLAYERS + 1];
new bool:g_bNinjaSpy[MAXPLAYERS + 1];
/*new bool:g_bIsAlyx[MAXPLAYERS + 1];*/
new bool:g_bIsBrutalScout[MAXPLAYERS + 1];
new bool:g_bIsBrutalKoloaxScout[MAXPLAYERS + 1];
new bool:g_bIsNobody[MAXPLAYERS + 1];
new bool:g_bIsDrunk[MAXPLAYERS + 1];
new bool:g_bIsSaxton[MAXPLAYERS + 1];
new bool:g_bNPCFootsteps[MAXPLAYERS + 1];
new bool:g_bSuperJumps;
new bool:g_bEnabled;
new g_iRage						[MAXPLAYERS + 1];
new g_iRaging;
new bool:g_bSounds;

new Handle:hCvarBoo;
new Handle:hCvarHealth;
new Handle:g_hCvarSuperJumps;
new Handle:g_hCvarEnabled;
new Handle:g_hCvarRaging;
new Handle:g_hCvarSounds;

public OnPluginStart()
{
	AddCommandListener(Listener_taunt, "taunt");
	AddCommandListener(Listener_taunt, "+taunt");
	AddCommandListener(Listener_taunt2, "taunt");
	AddCommandListener(Listener_taunt2, "+taunt");
	AddCommandListener(TauntCmd, "taunt");
	AddCommandListener(TauntCmd, "+taunt");
	AddCommandListener(TauntCmd2, "taunt");
	AddCommandListener(TauntCmd2, "+taunt");
	AddCommandListener(TauntCmd3, "taunt");
	AddCommandListener(TauntCmd3, "+taunt");
	AddCommandListener(TauntCmd4, "taunt");
	AddCommandListener(TauntCmd4, "+taunt");
	AddCommandListener(TauntCmd5, "taunt");
	AddCommandListener(TauntCmd5, "+taunt");
	AddCommandListener(TauntCmd6, "taunt");
	AddCommandListener(TauntCmd6, "+taunt");

	RegAdminCmd("sm_brutalspy", Command_MiniBoss, ADMFLAG_CHEATS);
	RegAdminCmd("sm_brutalsniper", Command_MiniBoss2, ADMFLAG_CHEATS);
	RegAdminCmd("sm_brutalscout", Command_MiniBoss3, ADMFLAG_CHEATS);
	RegAdminCmd("sm_hyperscout", Command_YetAnotherBrutalScout, ADMFLAG_CHEATS);
	RegAdminCmd("sm_easterdemo", Command_EasterDemoman, ADMFLAG_CHEATS);
	RegAdminCmd("sm_painiscupcake", Command_Painis, ADMFLAG_CHEATS);
	RegAdminCmd("sm_demopan", Command_DemoPan, ADMFLAG_CHEATS);
	RegAdminCmd("sm_seeman", Command_SeeMan, ADMFLAG_CHEATS);
	RegAdminCmd("sm_seeldier", Command_Seeldier, ADMFLAG_CHEATS);
	RegAdminCmd("sm_saxton2", Command_Saxton2, ADMFLAG_CHEATS);
	RegAdminCmd("sm_betank",	Command_Tank, ADMFLAG_CHEATS);
	RegAdminCmd("sm_sans",	Command_Engie, ADMFLAG_CHEATS);
	RegAdminCmd("sm_brutalengie",	Command_Engie, ADMFLAG_CHEATS);
	RegAdminCmd("sm_brutalheavy",	Command_Heavy, ADMFLAG_CHEATS);
	/*RegAdminCmd("sm_bemonoculus",	Command_Monoculus, ADMFLAG_CHEATS);*/
	RegAdminCmd("sm_majorcrits",	Command_MajorCrits, ADMFLAG_CHEATS);
	RegAdminCmd("sm_ninjaspy",	Command_NinjaSpy, ADMFLAG_CHEATS);
	RegAdminCmd("sm_heavyvoice",	Command_HeavyVoice, ADMFLAG_CHEATS);
	RegAdminCmd("sm_baldi",	Command_Baldi, ADMFLAG_CHEATS);
	/*RegAdminCmd("sm_alyx", Command_Alyx, ADMFLAG_CHEATS);*/
	RegAdminCmd("sm_sentry",	Command_Sentry, ADMFLAG_CHEATS);
	RegAdminCmd("sm_sentry_level1",	Command_Sentry1, ADMFLAG_CHEATS);
	RegAdminCmd("sm_sentry_level2",	Command_Sentry2, ADMFLAG_CHEATS);
	RegAdminCmd("sm_airstrike",	Command_Airstrikef, ADMFLAG_CHEATS);
	RegAdminCmd("sm_drunk",	Command_Drunk, ADMFLAG_GENERIC);
	RegAdminCmd("sm_koloax",	Command_KoloaxScout, ADMFLAG_CHEATS);
	RegAdminCmd("sm_seamus",	Command_Nobody, ADMFLAG_CHEATS);
	RegAdminCmd("sm_seamusmario",	Command_Nobody, ADMFLAG_CHEATS);
	RegAdminCmd("sm_losky", LoskyPoppedUp, ADMFLAG_ROOT);
	RegConsoleCmd("sm_changefootstep", Command_ChangeFootstep, "Change to NPC Footsteps");
	hCvarBoo = CreateConVar("sm_brutalbosses_boo", "2", "2-Boo stuns nearby enemies; 1-Boo is sound only; 0-no Boo", FCVAR_PLUGIN, true, 0.0, true, 2.0);
	hCvarHealth = CreateConVar("sm_brutalbosses_health", "10000", "Amount of health to ADD to the Brutal Boss (stacks on current class health)", FCVAR_PLUGIN);
	AddNormalSoundHook(TankSH);
	AddNormalSoundHook(BrutalBossSH);
	AddNormalSoundHook(SniperSH);
	AddNormalSoundHook(BrutalEngineerSH);
	AddNormalSoundHook(BrutalHeavySH);
	AddNormalSoundHook(BrutalScoutSH);
	/*AddNormalSoundHook(AlyxSH);*/
	AddNormalSoundHook(SeeSH);
	AddNormalSoundHook(BurpSH);
	AddNormalSoundHook(NPCFootstepSH);
	AddNormalSoundHook(SaxtonSH);
	AutoExecConfig(true, "plugin.brutalbosses");
	g_hCvarSuperJumps = CreateConVar("sm_brutalbosses_superjumps", "1", "Enable super jumps\n0 = Disabled\n1 = Enabled", _, true, 0.0, true, 1.0);
	g_bSuperJumps = GetConVarBool(g_hCvarSuperJumps);
	g_hCvarEnabled = CreateConVar("sm_brutalbosses_enabled", "1", "Enable Be The Saxton\n0 = Disabled\n1 = Enabled", _, true, 0.0, true, 1.0);
	g_bEnabled = GetConVarBool(g_hCvarEnabled);
	g_hCvarRaging = CreateConVar("sm_brutalbosses_raging", "2", "Rage percent regeneration\n0 = Disabled", _, true, 0.0);
	g_iRaging = GetConVarInt(g_hCvarRaging);
	g_hCvarSounds = CreateConVar("sm_bethesaxton_sounds", "1", "Enable saxton sounds\n0 = Disabled\n1 = Enabled", _, true, 0.0, true, 1.0);
	g_bSounds = GetConVarBool(g_hCvarSounds);
	HookConVarChange(g_hCvarSounds, OnConVarChange);
	HookConVarChange(g_hCvarRaging, OnConVarChange);
	HookConVarChange(g_hCvarEnabled, OnConVarChange);
	HookConVarChange(g_hCvarSuperJumps, OnConVarChange);
	
	CreateTimer(0.2, Timer_SuperJump, _, TIMER_REPEAT);
	CreateTimer(0.2, Timer_SuperJump2, _, TIMER_REPEAT);
	CreateTimer(0.2, Timer_SuperJump3, _, TIMER_REPEAT);
	CreateTimer(0.2, Timer_SuperJump4, _, TIMER_REPEAT);
	CreateTimer(0.2, Timer_SuperJump5, _, TIMER_REPEAT);
	CreateTimer(0.2, Timer_SuperJump6, _, TIMER_REPEAT);
	CreateTimer(1.0, Timer_RageMeter, _, TIMER_REPEAT);
	CreateTimer(1.0, Timer_RageMeter2, _, TIMER_REPEAT);
	CreateTimer(1.0, Timer_RageMeter3, _, TIMER_REPEAT);
	CreateTimer(1.0, Timer_RageMeter4, _, TIMER_REPEAT);
	CreateTimer(1.0, Timer_RageMeter5, _, TIMER_REPEAT);
	CreateTimer(1.0, Timer_RageMeter6, _, TIMER_REPEAT);
	
	HookEvent("player_death", Event_DeathPre, EventHookMode_Pre);
	HookEvent("player_death", Event_Death, EventHookMode_Post);

	LoadTranslations("brutalbosses.phrases");
}
public OnMapStart()
{
	PrecacheSound(HHH);
	PrecacheSound(HHH3);
	PrecacheSound(HHH7);
	PrecacheSound(IAmPainisCupcake);
	PrecacheModel(HHH2);
	PrecacheModel(HHH4);
	PrecacheModel(HHH5);
	PrecacheModel(HHH8);
	PrecacheSound(SPAWN1, true);
	PrecacheSound(SPAWN2, true);
	PrecacheSound(SPAWN3, true);
	PrecacheSound(FAIL1, true);
	PrecacheSound(FAIL2, true);
	PrecacheSound(FAIL3, true);
	PrecacheSound(SPAWN4, true);
	PrecacheSound(SPAWN5, true);
	PrecacheSound(SPAWN6, true);
	PrecacheModel(NinjaSpy);
	PrecacheModel("models/props_halloween/halloween_demoeye.mdl");
	PrecacheSound(Monoculus);
	PrecacheSound(Baldi);
	PrecacheSound("DEATH2");
	PrecacheSound("DEATH2_1");
	PrecacheSound("vo/mvm_tank_alerts01.mp3");
	PrecacheSound("#mvm/mvm_tank_end.wav");
	PrecacheSound("#mvm/mvm_tank_start.wav");
	PrecacheSound("#mvm/mvm_tank_explode.wav");
	PrecacheSound("freak_fortress_2/koloax/intro1.wav");
	PrecacheSound("freak_fortress_2/koloax/spystab2.wav");
	PrecacheSound("freak_fortress_2/seamusmario/intro.wav");
	PrecacheSound("freak_fortress_2/seamusmario/intro.wav");
	PrecacheSound("freak_fortress_2/seamusmario/spystab2.wav");
	PrecacheSound("freak_fortress_2/ninjaspy/kill_demo.wav");
	PrecacheSound("freak_fortress_2/ninjaspy/kill_heavy.wav");
	PrecacheSound("freak_fortress_2/ninjaspy/kill_soldier.wav");
	PrecacheSound("freak_fortress_2/ninjaspy/ninjaspy_begin2.wav");
	PrecacheSound("freak_fortress_2/ninjaspy/ninjaspy_begin3.wav");
	PrecacheSound("freak_fortress_2/seeman/seeman_see.wav");
	PrecacheSound("freak_fortress_2/seeman/seeman_rage.wav");
	PrecacheSound("freak_fortress_2/seeman/seeldier_see.wav");
	PrecacheSound(SOUND_TAUNT1, true);
	PrecacheSound(SOUND_TAUNT2, true);
	PrecacheSound(SOUND_TAUNT3, true);
	PrecacheSound(SOUND_TAUNT4, true);
	PrecacheModel(DemoPan);
	PrecacheModel(AXE);
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.dx80.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.dx90.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.sw.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.vvd");
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.phy");
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.mdl");
	AddFileToDownloadsTable("models/freak_fortress_2/baldi/baldi.mdl");
	AddFileToDownloadsTable("models/freak_fortress_2/baldi/baldi.dx80.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/baldi/baldi.dx90.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/baldi/baldi.sw.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/baldi/baldi.vvd");
	AddFileToDownloadsTable("models/freak_fortress_2/baldi/baldi.phy");
	AddFileToDownloadsTable("models/freak_fortress_2/demopan/demopan_v1.mdl");
	AddFileToDownloadsTable("models/freak_fortress_2/demopan/demopan_v1.dx80.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/demopan/demopan_v1.dx90.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/demopan/demopan_v1.sw.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/demopan/demopan_v1.vvd");	
	AddFileToDownloadsTable("models/freak_fortress_2/gentlespy/the_gentlespy_v1.mdl");
	AddFileToDownloadsTable("models/freak_fortress_2/gentlespy/the_gentlespy_v1.dx80.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/gentlespy/the_gentlespy_v1.dx90.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/gentlespy/the_gentlespy_v1.sw.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/gentlespy/the_gentlespy_v1.vvd");	
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.mdl");
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.phy");	
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.dx80.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.dx90.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.sw.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/koloax/koloax_v1.vvd");	
	AddFileToDownloadsTable("models/freak_fortress_2/ninjaspy/ninjaspy_v2_2.dx80.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/ninjaspy/ninjaspy_v2_2.dx90.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/ninjaspy/ninjaspy_v2_2.sw.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/ninjaspy/ninjaspy_v2_2.mdl");
	AddFileToDownloadsTable("models/freak_fortress_2/ninjaspy/ninjaspy_v2_2.vvd");	
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeman_v0.dx80.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeman_v0.dx90.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeman_v0.sw.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeman_v0.mdl");
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeman_v0.vvd");
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeldier_v0.dx80.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeldier_v0.dx90.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeldier_v0.sw.vtx");
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeldier_v0.mdl");
	AddFileToDownloadsTable("models/freak_fortress_2/seeman/seeldier_v0.vvd");
	AddFileToDownloadsTable("materials/freak_fortress_2/gentlespy_tex/stylish_spy_blue.vmt");
	AddFileToDownloadsTable("materials/freak_fortress_2/gentlespy_tex/stylish_spy_blue.vtf");
	AddFileToDownloadsTable("materials/freak_fortress_2/gentlespy_tex/stylish_spy_blue_invun.vmt");
	AddFileToDownloadsTable("materials/freak_fortress_2/gentlespy_tex/stylish_spy_blue_invun.vtf");
	AddFileToDownloadsTable("materials/freak_fortress_2/gentlespy_tex/stylish_spy_red.vmt");
	AddFileToDownloadsTable("materials/freak_fortress_2/gentlespy_tex/stylish_spy_red.vtf");
	AddFileToDownloadsTable("materials/freak_fortress_2/gentlespy_tex/stylish_spy_red_invun.vmt");
	AddFileToDownloadsTable("materials/freak_fortress_2/gentlespy_tex/stylish_spy_red_invun.vtf");
	AddFileToDownloadsTable("materials/freak_fortress_2/ninjaspy/spy_black.vmt");
	AddFileToDownloadsTable("materials/freak_fortress_2/ninjaspy/spy_black.vtf");
	AddFileToDownloadsTable("materials/freak_fortress_2/ninjaspy/spy_head_red.vmt");
	AddFileToDownloadsTable("materials/freak_fortress_2/ninjaspy/spy_head_red.vtf");
	AddFileToDownloadsTable("materials/freak_fortress_2/ninjaspy/fez_red.vmt");
	AddFileToDownloadsTable("materials/freak_fortress_2/ninjaspy/fez_red.vtf");
	AddFileToDownloadsTable("materials/stone_m/stv_model/baldi_tex.vmt");
	AddFileToDownloadsTable("materials/stone_m/stv_model/baldi_tex.vtf");
	AddFileToDownloadsTable("models/lazy_zombies_v2/demo.dx80.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/demo.dx90.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/demo.sw.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/demo.vvd");
	AddFileToDownloadsTable("models/lazy_zombies_v2/demo.phy");
	AddFileToDownloadsTable("models/lazy_zombies_v2/demo.mdl");
	AddFileToDownloadsTable("models/lazy_zombies_v2/engineer.dx80.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/engineer.dx90.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/engineer.sw.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/engineer.vvd");
	AddFileToDownloadsTable("models/lazy_zombies_v2/engineer.phy");
	AddFileToDownloadsTable("models/lazy_zombies_v2/engineer.mdl");	
	AddFileToDownloadsTable("models/lazy_zombies_v2/heavy.dx80.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/heavy.dx90.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/heavy.sw.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/heavy.vvd");
	AddFileToDownloadsTable("models/lazy_zombies_v2/heavy.phy");
	AddFileToDownloadsTable("models/lazy_zombies_v2/heavy.mdl");	
	AddFileToDownloadsTable("models/lazy_zombies_v2/medic.dx80.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/medic.dx90.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/medic.sw.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/medic.vvd");
	AddFileToDownloadsTable("models/lazy_zombies_v2/medic.phy");
	AddFileToDownloadsTable("models/lazy_zombies_v2/medic.mdl");
	AddFileToDownloadsTable("models/lazy_zombies_v2/pyro.dx80.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/pyro.dx90.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/pyro.sw.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/pyro.vvd");
	AddFileToDownloadsTable("models/lazy_zombies_v2/pyro.phy");
	AddFileToDownloadsTable("models/lazy_zombies_v2/pyro.mdl");
	AddFileToDownloadsTable("models/lazy_zombies_v2/scout.dx80.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/scout.dx90.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/scout.sw.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/scout.vvd");
	AddFileToDownloadsTable("models/lazy_zombies_v2/scout.phy");
	AddFileToDownloadsTable("models/lazy_zombies_v2/scout.mdl");
	AddFileToDownloadsTable("models/lazy_zombies_v2/sniper.dx80.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/sniper.dx90.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/sniper.sw.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/sniper.vvd");
	AddFileToDownloadsTable("models/lazy_zombies_v2/sniper.phy");
	AddFileToDownloadsTable("models/lazy_zombies_v2/sniper.mdl");
	AddFileToDownloadsTable("models/lazy_zombies_v2/soldier.dx80.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/soldier.dx90.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/soldier.sw.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/soldier.vvd");
	AddFileToDownloadsTable("models/lazy_zombies_v2/soldier.phy");
	AddFileToDownloadsTable("models/lazy_zombies_v2/soldier.mdl");
	AddFileToDownloadsTable("models/lazy_zombies_v2/spy.dx80.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/spy.dx90.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/spy.sw.vtx");
	AddFileToDownloadsTable("models/lazy_zombies_v2/spy.vvd");
	AddFileToDownloadsTable("models/lazy_zombies_v2/spy.phy");
	AddFileToDownloadsTable("models/lazy_zombies_v2/spy.mdl");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/demoman_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/demoman_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/demoman_blue_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/demoman_head_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/demoman_head_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/demoman_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/demoman_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/demoman_red_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/demoman_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/smiley.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/demo/smiley.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_blue_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_head_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_head_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_red_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_mech_hand.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_mech_hand.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_mech_hand_blue.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_mech_hand_blue.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/engineer_mech_hand_phongmask.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/engineer/skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/heavy_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/hvyweapon_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/heavy_blue_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/heavy_blue_zombie_alphatest_sheen.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/heavy_head_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/heavy_head_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/heavy_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/hvyweapon_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/heavy_red_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/heavy_red_zombie_alphatest_sheen.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/hvyweapon_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/hvyweapon/eyeball_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_blue_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_head_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_head_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_backpack_red.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_backpack_red.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_backpack_blue.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_backpack_blue.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_red_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/medic_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/medic/eyeball_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_blue_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_head_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_head_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_red_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/pyro_lightwarp.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/scout_skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/pyro/scout_skeleton.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/scout_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/scout_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/scout_blue_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/scout_head_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/scout_head_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/scout_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/scout_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/scout_red_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/scout_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/scout/eyeball_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_blue_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_head_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_head_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_head_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_head_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_red_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_lens.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/sniper_lens.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/c_arrow.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/c_arrow.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/hwn_heavy_hat.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/hwn_heavy_hat.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/hwn_heavy_hat_blue.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/hwn_heavy_hat_blue.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/sniper/eyeball_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/soldier_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/soldier_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/soldier_blue_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/soldier_head_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/soldier_head_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/soldier_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/soldier_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/soldier_red_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/soldier_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/eyeball_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/w_rocket01.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/soldier/w_rocket01.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_blue_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_head_blue_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_head_blue_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_head_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_head_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_red_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_red_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_red_zombie_alphatest.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/spy_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/skeleton.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/eyeball_zombie.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/eyeball_zombie.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_demo.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_engi.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_heavy.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_pyro.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_scout.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_sniper.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_soldier.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_spy.vmt");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_demo.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_engi.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_heavy.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_pyro.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_scout.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_sniper.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_soldier.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/spy/mask_spy.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/shared/eyeball_invun.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/shared/flat_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/shared/shared_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/shared/skeleton.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/shared/tfwater001_normal.vtf");
	AddFileToDownloadsTable("materials/models/lazy_zombies/shared/weapon_lightwarp.vtf");
}

public Action:Command_MiniBoss(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeSpy(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Saxton2(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeSaxton(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" as Saxton Hale!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_ChangeFootstep(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		ChangeFootstep(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Drunk(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		GetDrunk(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Nobody(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeNobody(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_YetAnotherBrutalScout(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeHyperScout(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_KoloaxScout(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeKoloaxScout(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}


public Action:Command_Airstrikef(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeAirstrike(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Engie(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeBrutalEngie(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Sentry(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeSentry(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Sentry2(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeSentry2(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Sentry1(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeSentry1(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_HeavyVoice(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeHeavyVoice(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

MakeHeavyVoice(client)
{
	g_bIsHeavyVoice[client] = true
}

ChangeFootstep(client)
{
	g_bNPCFootsteps[client] = true
}

public Action:Command_Heavy(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeHeavy(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_MajorCrits(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeMajorCrits(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Bosss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

/*public Action:Command_Alyx(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeAlyx(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Bosss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}
*/
public Action:Command_Voice(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeVoice(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

MakeVoice(client)
{
	g_bIsHeavy[client] = true
	PrintToChat(client, "[SM] This voice change will last forever untill the server restarts. ")
}

public Action:Command_Painis(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakePainisCupcake(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_EasterDemoman(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeEaster(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Baldi(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeBaldi(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_NinjaSpy(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeNinjaSpy(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_DemoPan(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakePan(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_SeeMan(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeSeeman(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Seeldier(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeSeeldier(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

public Action:Command_Tank(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeTank(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

/*public Action:Command_Monoculus(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeMonoculus(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}*/

MakeSpy(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;
		
	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Spy);
	TF2_RegeneratePlayer(client);
	EmitSoundToAll(HHH);
	SetModel(client, HHH2);
	new weapon = GetPlayerWeaponSlot(client, 2);
	TF2Attrib_SetByName(weapon, "damage bonus", 2.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 0.7);
	TF2Attrib_SetByName(weapon, "move speed bonus", 2.0);
	TF2Attrib_SetByName(weapon, "cannot be backstabbed", 1.0);
	TF2Attrib_SetByName(weapon, "max health additive bonus", 8000.0);
	TF2_SetHealth(client, 8125);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bIsBrutal[client] = true
}

GetDrunk(client)
{
	g_bIsDrunk[client] = true;
}

MakeSentry(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Engineer);
	TF2_RegeneratePlayer(client);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 4);
	SetModel(client, "models/buildables/sentry3.mdl");
	MakeSentryWeapon(client);
	TF2_SetHealth(client, 216);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 10.0);
	g_bIsBrutal[client] = true
}

MakeAirstrike(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Soldier);
	TF2_RegeneratePlayer(client);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 4);
	new weapon = GetPlayerWeaponSlot(client, 0);
	TF2Attrib_SetByName(weapon, "damage bonus", 2.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 0.1);
	TF2Attrib_SetByName(weapon, "move speed bonus", 10000.0);
	TF2Attrib_SetByName(weapon, "cannot be backstabbed", 1.0);
	TF2Attrib_SetByName(weapon, "max health additive bonus", 10000.0);
	TF2Attrib_SetByName(weapon, "clip size bonus", 10000.0);
	TF2Attrib_SetByName(weapon, "faster reload rate", -1.6);	
	SetModel(client, "models/player/soldier.mdl");
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 10.0);
	g_bIsBrutal[client] = true
}

MakeHyperScout(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Scout);
	MakeHyperScoutGun(client);
	MakeHyperScoutMilk(client);
	MakeHyperScoutMelee(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 10.0);
	g_bIsBrutalScout[client] = true
}

MakeKoloaxScout(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	SetModel(client, "models/freak_fortress_2/koloax/koloax_v1.mdl");
	EmitSoundToAll("freak_fortress_2/koloax/intro1.wav");
	TF2_SetPlayerClass(client, TFClass_Scout);
	TF2_RemoveWeaponSlot(client, 0);
	MakeKoloaxScoutMelee(client);
	MakeKoloaxScoutSecondary(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 10.0);
	g_bIsBrutalKoloaxScout[client] = true;
	new iEntity = -1;
	while((iEntity = FindEntityByClassname(iEntity, "tf_wearable")) != -1)
	{
		if(GetEntPropEnt(iEntity, Prop_Send, "m_hOwnerEntity") == client)
			AcceptEntityInput(iEntity, "Kill");
	}
}

MakeNobody(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	SetModel(client, "models/freak_fortress_2/seamusmario/seamusmario.mdl");
	EmitSoundToAll("freak_fortress_2/seamusmario/intro.wav");
	TF2_SetPlayerClass(client, TFClass_Soldier);
	TF2_RemoveWeaponSlot(client, 0);
	MakeNobodyMelee(client);
	MakeNobodyPrimary(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 10.0);
	g_bIsNobody[client] = true
}

public Action:Listener_taunt2(client, const String:command[], args)
{
	if(!g_bIsNobody[client])
		return Plugin_Continue;
		
	if (GetEntProp(client, Prop_Send, "m_hGroundEntity") == -1) return Plugin_Continue;
	MakeRageNobody(client);
}

MakeRageNobody(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	SetModel(client, "models/freak_fortress_2/seamusmario/seamusmario.mdl");
	EmitSoundToAll("freak_fortress_2/seamusmario/spystab2.wav");
	TF2_SetPlayerClass(client, TFClass_Soldier);
	TF2_RemoveWeaponSlot(client, 0);
	MakeNobodyMelee(client);
	MakeNobodyPrimary(client);
	TF2_SetHealth(client, 10000);
	TF2_RemoveCondition(client, TFCond_Taunting);
	TF2_AddCondition(client, TFCond_Bonked,	 4.5);
	TF2_AddCondition(client, TFCond_Kritzkrieged, 60.0);
	TF2_AddCondition(client, TFCond_Overhealed, 60.0);
	TF2_AddCondition(client, TFCond_MegaHeal, 60.0);
	TF2_AddCondition(client, TFCond_DefenseBuffed, 60.0);
	TF2_AddCondition(client, TFCond_Buffed, 60.0);
	TF2_AddCondition(client, TFCond_UberBulletResist, 60.0);
	TF2_AddCondition(client, TFCond_UberFireResist, 60.0);
	TF2_AddCondition(client, TFCond_UberBlastResist, 60.0);
	TF2_AddCondition(client, TFCond_UberchargedCanteen, 60.0);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 5.0);
	decl Float:fOrigin1[3];
	GetEntPropVector(client, Prop_Send, "m_vecOrigin", fOrigin1);

	decl Float:fOrigin2[3];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(GetClientTeam(i) != GetClientTeam(client) && IsPlayerAlive(i) && i != client)
		{
			GetEntPropVector(i, Prop_Send, "m_vecOrigin", fOrigin2);
			if(!TF2_IsPlayerInCondition(i, TFCond_Ubercharged) && GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
			{
				new iFlags = TF_STUNFLAGS_GHOSTSCARE;
				TF2_StunPlayer(i, 20.0, _, iFlags, client);
			}
		}
	}
}

public Action:TauntCmd(iClient, const String:strCommand[], iArgc)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	if(!IsValidClient(iClient) || !IsPlayerAlive(iClient) || !g_bIsSaxton[iClient] || !g_bEngie[iClient] || !g_bIsBrutal[iClient] || !g_bIsBrutalScout[iClient] || !g_bIsHeavy[iClient] || g_iRage[iClient] < 100)
		return Plugin_Continue;

	decl Float:fOrigin[3];
	GetEntPropVector(iClient, Prop_Send, "m_vecOrigin", fOrigin);
	fOrigin[2] += 20.0;

	TF2_AddCondition(iClient, TFCond:42, 4.0);
	CreateTimer(0.6, Timer_UseRage, GetClientUserId(iClient), TIMER_FLAG_NO_MAPCHANGE);
	g_iRage[iClient] = 0;
	if(g_bSounds)
	{
		switch(GetRandomInt(0, 3))
		{
			case 0: EmitSoundToAll(SOUND_TAUNT1, iClient, SNDCHAN_VOICE);
			case 1: EmitSoundToAll(SOUND_TAUNT2, iClient, SNDCHAN_VOICE);
			case 2: EmitSoundToAll(SOUND_TAUNT3, iClient, SNDCHAN_VOICE);
			case 3: EmitSoundToAll(SOUND_TAUNT4, iClient, SNDCHAN_VOICE);
		}
	}
	return Plugin_Continue;
}

public Action:TauntCmd2(iClient, const String:strCommand[], iArgc)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	if(!IsValidClient(iClient) || !IsPlayerAlive(iClient) | !g_bIsBrutal[iClient] || g_iRage[iClient] < 100)
		return Plugin_Continue;

	decl Float:fOrigin[3];
	GetEntPropVector(iClient, Prop_Send, "m_vecOrigin", fOrigin);
	fOrigin[2] += 20.0;

	TF2_AddCondition(iClient, TFCond:42, 4.0);
	TF2_AddCondition(iClient, TFCond_DefenseBuffed, 20.0);
	TF2_AddCondition(iClient, TFCond_Buffed, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBulletResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberFireResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBlastResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberchargedCanteen, 20.0);
	CreateTimer(0.6, Timer_UseRage2, GetClientUserId(iClient), TIMER_FLAG_NO_MAPCHANGE);
	g_iRage[iClient] = 0;
	if(g_bSounds)
	{
		EmitSoundToAll("ambient/atmosphere/terrain_rumble1.wav", iClient, _, SNDLEVEL_TRAIN);
	}
	return Plugin_Continue;
}

public Action:TauntCmd3(iClient, const String:strCommand[], iArgc)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	if(!IsValidClient(iClient) || !IsPlayerAlive(iClient) | !g_bIsBrutalScout[iClient] || g_iRage[iClient] < 100)
		return Plugin_Continue;

	decl Float:fOrigin[3];
	GetEntPropVector(iClient, Prop_Send, "m_vecOrigin", fOrigin);
	fOrigin[2] += 20.0;

	TF2_AddCondition(iClient, TFCond:42, 4.0);
	TF2_AddCondition(iClient, TFCond_DefenseBuffed, 20.0);
	TF2_AddCondition(iClient, TFCond_Buffed, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBulletResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberFireResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBlastResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberchargedCanteen, 20.0);
	CreateTimer(0.6, Timer_UseRage2, GetClientUserId(iClient), TIMER_FLAG_NO_MAPCHANGE);
	g_iRage[iClient] = 0;
	if(g_bSounds)
	{
		EmitSoundToAll("ambient/atmosphere/terrain_rumble1.wav", iClient, _, SNDLEVEL_TRAIN);
	}
	return Plugin_Continue;
}

public Action:TauntCmd4(iClient, const String:strCommand[], iArgc)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	if(!IsValidClient(iClient) || !IsPlayerAlive(iClient) | !g_bEngie[iClient] || g_iRage[iClient] < 100)
		return Plugin_Continue;

	decl Float:fOrigin[3];
	GetEntPropVector(iClient, Prop_Send, "m_vecOrigin", fOrigin);
	fOrigin[2] += 20.0;

	TF2_AddCondition(iClient, TFCond:42, 4.0);
	TF2_AddCondition(iClient, TFCond_DefenseBuffed, 20.0);
	TF2_AddCondition(iClient, TFCond_Buffed, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBulletResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberFireResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBlastResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberchargedCanteen, 20.0);
	CreateTimer(0.6, Timer_UseRage2, GetClientUserId(iClient), TIMER_FLAG_NO_MAPCHANGE);
	g_iRage[iClient] = 0;
	if(g_bSounds)
	{
		EmitSoundToAll("ambient/atmosphere/terrain_rumble1.wav", iClient, _, SNDLEVEL_TRAIN);
	}
	return Plugin_Continue;
}

public Action:TauntCmd5(iClient, const String:strCommand[], iArgc)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	if(!IsValidClient(iClient) || !IsPlayerAlive(iClient) | !g_bIsHeavy[iClient] || g_iRage[iClient] < 100)
		return Plugin_Continue;

	decl Float:fOrigin[3];
	GetEntPropVector(iClient, Prop_Send, "m_vecOrigin", fOrigin);
	fOrigin[2] += 20.0;

	TF2_AddCondition(iClient, TFCond:42, 4.0);
	TF2_AddCondition(iClient, TFCond_DefenseBuffed, 20.0);
	TF2_AddCondition(iClient, TFCond_Buffed, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBulletResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberFireResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBlastResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberchargedCanteen, 20.0);
	CreateTimer(0.6, Timer_UseRage2, GetClientUserId(iClient), TIMER_FLAG_NO_MAPCHANGE);
	g_iRage[iClient] = 0;
	if(g_bSounds)
	{
		EmitSoundToAll("ambient/atmosphere/terrain_rumble1.wav", iClient, _, SNDLEVEL_TRAIN);
	}
	return Plugin_Continue;
}

public Action:TauntCmd6(iClient, const String:strCommand[], iArgc)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	if(!IsValidClient(iClient) || !IsPlayerAlive(iClient) | !g_bSee[iClient] || g_iRage[iClient] < 100)
		return Plugin_Continue;

	decl Float:fOrigin[3];
	GetEntPropVector(iClient, Prop_Send, "m_vecOrigin", fOrigin);
	fOrigin[2] += 20.0;

	TF2_AddCondition(iClient, TFCond:42, 4.0);
	TF2_AddCondition(iClient, TFCond_DefenseBuffed, 20.0);
	TF2_AddCondition(iClient, TFCond_Buffed, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBulletResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberFireResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberBlastResist, 20.0);
	TF2_AddCondition(iClient, TFCond_UberchargedCanteen, 20.0);
	CreateTimer(0.6, Timer_UseRage3, GetClientUserId(iClient), TIMER_FLAG_NO_MAPCHANGE);
	g_iRage[iClient] = 0;
	if(g_bSounds)
	{
		EmitSoundToAll("freak_fortress_2/seeman/seeman_see.wav");
		EmitSoundToAll("freak_fortress_2/seeman/seeman_rage.wav");
	}
	return Plugin_Continue;
}

public Action:Listener_taunt(client, const String:command[], args)
{
	if(!g_bIsBrutalKoloaxScout[client])
		return Plugin_Continue;
		
	if (GetEntProp(client, Prop_Send, "m_hGroundEntity") == -1) return Plugin_Continue;
	MakeAngryKoloaxScout(client);
}

MakeAngryKoloaxScout(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.75);
	SetEntPropFloat(client, Prop_Send, "m_flModelScale", 1.75);
	SetModel(client, "models/freak_fortress_2/koloax/koloax_v1.mdl");
	EmitSoundToAll("freak_fortress_2/koloax/spystab2.wav", client);
	TF2_SetPlayerClass(client, TFClass_Scout);
	TF2_RemoveWeaponSlot(client, 0);
	MakeAngryKoloaxScoutMelee(client);
	MakeKoloaxScoutSecondary(client);
	TF2_SetHealth(client, 10000);
	TF2_RemoveCondition(client, TFCond_Taunting);
	TF2_AddCondition(client, TFCond_Bonked,	 2.0);
	TF2_AddCondition(client, TFCond_Kritzkrieged, 60.0);
	TF2_AddCondition(client, TFCond_Overhealed, 60.0);
	TF2_AddCondition(client, TFCond_MegaHeal, 60.0);
	TF2_AddCondition(client, TFCond_DefenseBuffed, 60.0);
	TF2_AddCondition(client, TFCond_Buffed, 60.0);
	TF2_AddCondition(client, TFCond_UberBulletResist, 60.0);
	TF2_AddCondition(client, TFCond_UberFireResist, 60.0);
	TF2_AddCondition(client, TFCond_UberBlastResist, 60.0);
	TF2_AddCondition(client, TFCond_UberchargedCanteen, 60.0);
	TF2_SetPlayerPowerPlay(client, true);
	decl Float:fOrigin1[3];
	GetEntPropVector(client, Prop_Send, "m_vecOrigin", fOrigin1);

	decl Float:fOrigin2[3];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(GetClientTeam(i) != GetClientTeam(client) && IsPlayerAlive(i) && i != client)
		{
			GetEntPropVector(i, Prop_Send, "m_vecOrigin", fOrigin2);
			if(!TF2_IsPlayerInCondition(i, TFCond_Ubercharged) && GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
			{
				new iFlags = TF_STUNFLAGS_GHOSTSCARE;
				TF2_StunPlayer(i, 10.0, _, iFlags, client);
			}
		}
	}
}

MakeSentry2(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Engineer);
	TF2_RegeneratePlayer(client);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 4);
	SetModel(client, "models/buildables/sentry2.mdl");
	MakeSentryWeapon2(client);
	TF2_SetHealth(client, 150);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 10.0);
	g_bIsBrutal[client] = true
}

MakeSentry1(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Engineer);
	TF2_RegeneratePlayer(client);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 4);
	SetModel(client, "models/buildables/sentry1.mdl");
	MakeSentryWeapon1(client);
	TF2_SetHealth(client, 150);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 10.0);
	g_bIsBrutal[client] = true
}

/*MakeAlyx(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	TF2_SetPlayerClass(client, TFClass_Scout);
	TF2_RegeneratePlayer(client);
	TF2_SetHealth(client, 50);
	SetModel(client, "models/alyx.mdl");
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, 3);
	g_bIsAlyx[client] = true
}*/

MakePan(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_DemoMan);
	TF2_RegeneratePlayer(client);
	SetModel(client, DemoPan);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	GiveDemoPan(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bIsBrutal[client] = true
}

MakeSeeman(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_DemoMan);
	TF2_RegeneratePlayer(client);
	EmitSoundToAll(See);
	SetModel(client, "models/freak_fortress_2/seeman/seeman_v0.mdl");
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	MakeSee(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bSee[client] = true
}

MakeBaldi(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Sniper);
	TF2_RegeneratePlayer(client);
	EmitSoundToAll(Baldi);
	SetModel(client, "models/freak_fortress_2/baldi/baldi.mdl");
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	MakeBaldiWeapon(client);
	TF2_SetHealth(client, 3100);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bIsBrutal[client] = true
}


MakeSeeldier(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Soldier);
	TF2_RegeneratePlayer(client);
	EmitSoundToAll(See2);
	SetModel(client, "models/freak_fortress_2/seeman/seeldier_v0.mdl");
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	MakeSee(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bSee[client] = true
}

MakeHeavy(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Heavy);
	TF2_RegeneratePlayer(client);
	SetModel(client, "models/player/heavy.mdl");
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 4);
	TF2_RemoveWeaponSlot(client, 6);
	TF2_RemoveWeaponSlot(client, 3);
	GiveFists(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bIsHeavy[client] = true
}

MakePainisCupcake(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Soldier);
	TF2_RegeneratePlayer(client);
	SetModel(client, Painis);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	GivePainis(client);
	TF2_SetHealth(client, 10000);
	EmitSoundToAll(IAmPainisCupcake);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	
	 new iEntity = -1;
	while((iEntity = FindEntityByClassname(iEntity, "tf_wearable")) != -1)
	{
		if(GetEntPropEnt(iEntity, Prop_Send, "m_hOwnerEntity") == client)
			AcceptEntityInput(iEntity, "Kill");
	}
	
	g_bIsBrutal[client] = true
}

MakeSaxton(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Soldier);
	SetModel(client, "models/player/saxton_hale/saxton_hale.mdl");
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	GivePainis(client);
	TF2_SetHealth(client, 10000);
	SpawnSaxtonSound();
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	
	new iEntity = -1;
	while((iEntity = FindEntityByClassname(iEntity, "tf_wearable")) != -1)
	{
		if(GetEntPropEnt(iEntity, Prop_Send, "m_hOwnerEntity") == client)
			AcceptEntityInput(iEntity, "Kill");
	}
	
	g_bIsSaxton[client] = true
}

public Action:Timer_SuperJump(Handle:hTimer)
{
	if(!g_bEnabled || !g_bSuperJumps)
		return Plugin_Continue;

	static iJumpCharge[MAXPLAYERS + 1];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(!IsPlayerAlive(i) || !g_bIsSaxton[i])
			return Plugin_Continue;

		new iButtons = GetClientButtons(i);
		if((iButtons & IN_DUCK || iButtons & IN_ATTACK2) && iJumpCharge[i] >= 0 && !(iButtons & IN_JUMP))
		{
			if(iJumpCharge[i] + 5 < 25)
				iJumpCharge[i] += 5;
			else
				iJumpCharge[i] = 25;
			PrintCenterText(i, "%t", "jump_status", iJumpCharge[i] * 4);
		}
		else if(iJumpCharge[i] < 0)
		{
			iJumpCharge[i] += 5;
			PrintCenterText(i, "%t %i", "jump_status_2", -iJumpCharge[i] / 20);
		}
		else
		{
			decl Float:fAngles[3];
			GetClientEyeAngles(i, fAngles);

			if(fAngles[0] < -45.0 && iJumpCharge[i] > 1)
			{
				decl Float:fVelocity[3];
				GetEntPropVector(i, Prop_Data, "m_vecVelocity", fVelocity);

				SetEntProp(i, Prop_Send, "m_bJumping", 1);

				fVelocity[2] = 750 + iJumpCharge[i] * 13.0;
				fVelocity[0] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				fVelocity[1] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				TeleportEntity(i, NULL_VECTOR, NULL_VECTOR, fVelocity);

				iJumpCharge[i] = -120;

				decl Float:fPosition[3];
				GetEntPropVector(i, Prop_Send, "m_vecOrigin", fPosition);
				
				if(g_bSounds)
				{
					new iRandom = GetRandomInt(0, 3);
					switch(iRandom)
					{
						case 0: EmitSoundToAll(SOUND_JUMP1, i, SNDCHAN_VOICE);
						case 1: EmitSoundToAll(SOUND_JUMP2, i, SNDCHAN_VOICE);
						case 2: EmitSoundToAll(SOUND_JUMP3, i, SNDCHAN_VOICE);
						case 3: EmitSoundToAll(SOUND_JUMP4, i, SNDCHAN_VOICE);
					}
				}
			}
			else
			{
				iJumpCharge[i] = 0;
				PrintCenterText(i, "");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_SuperJump2(Handle:hTimer)
{
	if(!g_bEnabled || !g_bSuperJumps)
		return Plugin_Continue;

	static iJumpCharge[MAXPLAYERS + 1];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(!IsPlayerAlive(i) || !g_bIsBrutal[i])
			return Plugin_Continue;

		new iButtons = GetClientButtons(i);
		if((iButtons & IN_DUCK || iButtons & IN_ATTACK2) && iJumpCharge[i] >= 0 && !(iButtons & IN_JUMP))
		{
			if(iJumpCharge[i] + 5 < 25)
				iJumpCharge[i] += 5;
			else
				iJumpCharge[i] = 25;
			PrintCenterText(i, "%t", "jump_status", iJumpCharge[i] * 4);
		}
		else if(iJumpCharge[i] < 0)
		{
			iJumpCharge[i] += 5;
			PrintCenterText(i, "%t %i", "jump_status_2", -iJumpCharge[i] / 20);
		}
		else
		{
			decl Float:fAngles[3];
			GetClientEyeAngles(i, fAngles);

			if(fAngles[0] < -45.0 && iJumpCharge[i] > 1)
			{
				decl Float:fVelocity[3];
				GetEntPropVector(i, Prop_Data, "m_vecVelocity", fVelocity);

				SetEntProp(i, Prop_Send, "m_bJumping", 1);

				fVelocity[2] = 750 + iJumpCharge[i] * 13.0;
				fVelocity[0] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				fVelocity[1] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				TeleportEntity(i, NULL_VECTOR, NULL_VECTOR, fVelocity);

				iJumpCharge[i] = -120;

				decl Float:fPosition[3];
				GetEntPropVector(i, Prop_Send, "m_vecOrigin", fPosition);
			}
			else
			{
				iJumpCharge[i] = 0;
				PrintCenterText(i, "");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_SuperJump3(Handle:hTimer)
{
	if(!g_bEnabled || !g_bSuperJumps)
		return Plugin_Continue;

	static iJumpCharge[MAXPLAYERS + 1];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(!IsPlayerAlive(i) || !g_bIsBrutalScout[i])
			return Plugin_Continue;

		new iButtons = GetClientButtons(i);
		if((iButtons & IN_DUCK || iButtons & IN_ATTACK2) && iJumpCharge[i] >= 0 && !(iButtons & IN_JUMP))
		{
			if(iJumpCharge[i] + 5 < 25)
				iJumpCharge[i] += 5;
			else
				iJumpCharge[i] = 25;
			PrintCenterText(i, "%t", "jump_status", iJumpCharge[i] * 4);
		}
		else if(iJumpCharge[i] < 0)
		{
			iJumpCharge[i] += 5;
			PrintCenterText(i, "%t %i", "jump_status_2", -iJumpCharge[i] / 20);
		}
		else
		{
			decl Float:fAngles[3];
			GetClientEyeAngles(i, fAngles);

			if(fAngles[0] < -45.0 && iJumpCharge[i] > 1)
			{
				decl Float:fVelocity[3];
				GetEntPropVector(i, Prop_Data, "m_vecVelocity", fVelocity);

				SetEntProp(i, Prop_Send, "m_bJumping", 1);

				fVelocity[2] = 750 + iJumpCharge[i] * 13.0;
				fVelocity[0] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				fVelocity[1] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				TeleportEntity(i, NULL_VECTOR, NULL_VECTOR, fVelocity);

				iJumpCharge[i] = -120;

				decl Float:fPosition[3];
				GetEntPropVector(i, Prop_Send, "m_vecOrigin", fPosition);
			}
			else
			{
				iJumpCharge[i] = 0;
				PrintCenterText(i, "");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_SuperJump4(Handle:hTimer)
{
	if(!g_bEnabled || !g_bSuperJumps)
		return Plugin_Continue;

	static iJumpCharge[MAXPLAYERS + 1];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(!IsPlayerAlive(i) || !g_bEngie[i])
			return Plugin_Continue;

		new iButtons = GetClientButtons(i);
		if((iButtons & IN_DUCK || iButtons & IN_ATTACK2) && iJumpCharge[i] >= 0 && !(iButtons & IN_JUMP))
		{
			if(iJumpCharge[i] + 5 < 25)
				iJumpCharge[i] += 5;
			else
				iJumpCharge[i] = 25;
			PrintCenterText(i, "%t", "jump_status", iJumpCharge[i] * 4);
		}
		else if(iJumpCharge[i] < 0)
		{
			iJumpCharge[i] += 5;
			PrintCenterText(i, "%t %i", "jump_status_2", -iJumpCharge[i] / 20);
		}
		else
		{
			decl Float:fAngles[3];
			GetClientEyeAngles(i, fAngles);

			if(fAngles[0] < -45.0 && iJumpCharge[i] > 1)
			{
				decl Float:fVelocity[3];
				GetEntPropVector(i, Prop_Data, "m_vecVelocity", fVelocity);

				SetEntProp(i, Prop_Send, "m_bJumping", 1);

				fVelocity[2] = 750 + iJumpCharge[i] * 13.0;
				fVelocity[0] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				fVelocity[1] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				TeleportEntity(i, NULL_VECTOR, NULL_VECTOR, fVelocity);

				iJumpCharge[i] = -120;

				decl Float:fPosition[3];
				GetEntPropVector(i, Prop_Send, "m_vecOrigin", fPosition);
			}
			else
			{
				iJumpCharge[i] = 0;
				PrintCenterText(i, "");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_SuperJump5(Handle:hTimer)
{
	if(!g_bEnabled || !g_bSuperJumps)
		return Plugin_Continue;

	static iJumpCharge[MAXPLAYERS + 1];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(!IsPlayerAlive(i) || !g_bIsHeavy[i])
			return Plugin_Continue;

		new iButtons = GetClientButtons(i);
		if((iButtons & IN_DUCK || iButtons & IN_ATTACK2) && iJumpCharge[i] >= 0 && !(iButtons & IN_JUMP))
		{
			if(iJumpCharge[i] + 5 < 25)
				iJumpCharge[i] += 5;
			else
				iJumpCharge[i] = 25;
			PrintCenterText(i, "%t", "jump_status", iJumpCharge[i] * 4);
		}
		else if(iJumpCharge[i] < 0)
		{
			iJumpCharge[i] += 5;
			PrintCenterText(i, "%t %i", "jump_status_2", -iJumpCharge[i] / 20);
		}
		else
		{
			decl Float:fAngles[3];
			GetClientEyeAngles(i, fAngles);

			if(fAngles[0] < -45.0 && iJumpCharge[i] > 1)
			{
				decl Float:fVelocity[3];
				GetEntPropVector(i, Prop_Data, "m_vecVelocity", fVelocity);

				SetEntProp(i, Prop_Send, "m_bJumping", 1);

				fVelocity[2] = 750 + iJumpCharge[i] * 13.0;
				fVelocity[0] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				fVelocity[1] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				TeleportEntity(i, NULL_VECTOR, NULL_VECTOR, fVelocity);

				iJumpCharge[i] = -120;

				decl Float:fPosition[3];
				GetEntPropVector(i, Prop_Send, "m_vecOrigin", fPosition);
			}
			else
			{
				iJumpCharge[i] = 0;
				PrintCenterText(i, "");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_SuperJump6(Handle:hTimer)
{
	if(!g_bEnabled || !g_bSuperJumps)
		return Plugin_Continue;

	static iJumpCharge[MAXPLAYERS + 1];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(!IsPlayerAlive(i) || !g_bSee[i])
			return Plugin_Continue;

		new iButtons = GetClientButtons(i);
		if((iButtons & IN_DUCK || iButtons & IN_ATTACK2) && iJumpCharge[i] >= 0 && !(iButtons & IN_JUMP))
		{
			if(iJumpCharge[i] + 5 < 25)
				iJumpCharge[i] += 5;
			else
				iJumpCharge[i] = 25;
			PrintCenterText(i, "%t", "jump_status", iJumpCharge[i] * 4);
		}
		else if(iJumpCharge[i] < 0)
		{
			iJumpCharge[i] += 5;
			PrintCenterText(i, "%t %i", "jump_status_2", -iJumpCharge[i] / 20);
		}
		else
		{
			decl Float:fAngles[3];
			GetClientEyeAngles(i, fAngles);

			if(fAngles[0] < -45.0 && iJumpCharge[i] > 1)
			{
				decl Float:fVelocity[3];
				GetEntPropVector(i, Prop_Data, "m_vecVelocity", fVelocity);

				SetEntProp(i, Prop_Send, "m_bJumping", 1);

				fVelocity[2] = 750 + iJumpCharge[i] * 13.0;
				fVelocity[0] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				fVelocity[1] *= (1 + Sine(float(iJumpCharge[i]) * FLOAT_PI / 50));
				TeleportEntity(i, NULL_VECTOR, NULL_VECTOR, fVelocity);

				iJumpCharge[i] = -120;

				decl Float:fPosition[3];
				GetEntPropVector(i, Prop_Send, "m_vecOrigin", fPosition);
				if(g_bSounds)
				{
					EmitSoundToAll("freak_fortress_2/seeman/seeman_see.wav", i, _, SNDLEVEL_TRAIN);
				}
			}
			else
			{
				iJumpCharge[i] = 0;
				PrintCenterText(i, "");
			}
		}
	}
	return Plugin_Continue;
}


public SpawnSaxtonSound()
{
	new soundswitch;
	soundswitch = GetRandomInt(1, 6);	
	switch(soundswitch)
	{
		case 1:
		{
			EmitSoundToAll(SPAWN1);
		}
		case 2:
		{
			EmitSoundToAll(SPAWN2);
		}
		case 3:
		{
			EmitSoundToAll(SPAWN3);
		}
		case 4:
		{
			EmitSoundToAll(SPAWN4);
		}
		case 5:
		{
			EmitSoundToAll(SPAWN5);
		}
		case 6:
		{
			EmitSoundToAll(SPAWN6);
		}
	}
}

public DeadSaxtonSound()
{
	new soundswitch;
	soundswitch = GetRandomInt(1, 3);	
	switch(soundswitch)
	{
		case 1:
		{
			EmitSoundToAll(FAIL1);
		}
		case 2:
		{
			EmitSoundToAll(FAIL2);
		}
		case 3:
		{
			EmitSoundToAll(FAIL3);
		}
	}
}

MakeEaster(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_DemoMan);
	TF2_RegeneratePlayer(client);
	SetModel(client, EasterDemo);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	GiveEastDemo(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bIsBrutal[client] = true
}

public Action:Command_MiniBoss2(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeCBC(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

MakeCBC(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Sniper);
	TF2_RegeneratePlayer(client);
	EmitSoundToAll(HHH3);
	SetModel(client, HHH4);
	new weapon = GetPlayerWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Primary);
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);
	TF2Attrib_SetByName(weapon, "damage bonus", 2.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 0.7);
	TF2Attrib_SetByName(weapon, "move speed bonus", 2.0);
	TF2Attrib_SetByName(weapon, "cannot be backstabbed", 1.0);
	TF2Attrib_SetByName(weapon, "max health additive bonus", 8000.0);
	TF2_SetHealth(client, 8125);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bSniper[client] = true
}

MakeBrutalScout(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Scout);
	TF2_RegeneratePlayer(client);
	EmitSoundToAll("vo/scout_incoming01.mp3");
	SetModel(client, HHH5);
	new weapon = GetPlayerWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Primary);
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);
	TF2Attrib_SetByName(weapon, "damage bonus", 2.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 0.7);
	TF2Attrib_SetByName(weapon, "move speed bonus", 2.0);
	TF2Attrib_SetByName(weapon, "cannot be backstabbed", 1.0);
	TF2Attrib_SetByName(weapon, "max health additive bonus", 8000.0);
	TF2_SetHealth(client, 8125);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bIsBrutalScout[client] = true
}

MakeNinjaSpy(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Spy);
	TF2_RegeneratePlayer(client);
	new String:randomsound[250]
	SetModel(client, NinjaSpy);
	Format(randomsound, sizeof(randomsound), "freak_fortress_2/ninjaspy/ninjaspy_begin%i.wav", GetRandomInt(2, 3));
	EmitSoundToAll(randomsound);
	new weapon = GetPlayerWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, -2);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 7);
	TF2_RemoveWeaponSlot(client, 4);
	TF2Attrib_SetByName(weapon, "damage bonus", 2.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 0.7);
	TF2Attrib_SetByName(weapon, "move speed bonus", 2.0);
	TF2Attrib_SetByName(weapon, "cannot be backstabbed", 1.0);
	TF2Attrib_SetByName(weapon, "max health additive bonus", 9000.0);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	g_bNinjaSpy[client] = true;
}

MakeBrutalEngie(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Engineer);
	TF2_RegeneratePlayer(client);
	SetModel(client, HHH8);
	EmitSoundToAll(HHH3);
	new weapon = GetPlayerWeaponSlot(client, 0);
	TF2Attrib_SetByName(weapon, "damage bonus", 2.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 0.7);
	TF2Attrib_SetByName(weapon, "move speed bonus", 2.0);
	TF2Attrib_SetByName(weapon, "cannot be backstabbed", 1.0);
	TF2Attrib_SetByName(weapon, "max health additive bonus", 8000.0);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_Kritzkrieged, 1000099.0);
	g_bEngie[client] = true
}

MakeMonoculus(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Soldier);
	TF2_RegeneratePlayer(client);
	SetModel(client, "models/props_halloween/halloween_demoeye.mdl");
	EmitSoundToAll(Monoculus);
	new weapon = GetPlayerWeaponSlot(client, 0);
	TF2Attrib_SetByName(weapon, "damage bonus", 2.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 1.2);
	TF2Attrib_SetByName(weapon, "move speed bonus", 2.0);
	TF2Attrib_SetByName(weapon, "cannot be backstabbed", 1.0);
	TF2Attrib_SetByName(weapon, "max health additive bonus", 30000.0);
	TF2_RemoveWeaponSlot(client, -2);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 7);
	TF2_RemoveWeaponSlot(client, 4);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 1000099.0);
	TF2_SetHealth(client, 30000);
	TF2_AddCondition(client, TFCond_Kritzkrieged, 1000099.0);
	if (GetEntityMoveType(client) != MOVETYPE_FLY)
	{
		SetEntityMoveType(client, MOVETYPE_FLY);
	}
	g_bHalloween[client] = true
}

MakeTank(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Engineer);
	TF2_RegeneratePlayer(client);
	EmitSoundToAll("vo/mvm_tank_alerts01.mp3");
	EmitSoundToAll("#mvm/mvm_tank_start.wav");
	SetModel(client, HHH7);
	new weapon = GetPlayerWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, -2);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 0);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 7);
	TF2_RemoveWeaponSlot(client, 4);
	TF2Attrib_SetByName(weapon, "damage bonus", 2.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 0.7);
	TF2Attrib_SetByName(weapon, "move speed bonus", 0.4);
	TF2Attrib_SetByName(weapon, "dmg taken from fire increased", 1.5);
	TF2Attrib_SetByName(weapon, "dmg taken from crit increased", 1.3);
	TF2Attrib_SetByName(weapon, "dmg taken from bullets increased", 1.5);
	TF2Attrib_SetByName(weapon, "dmg taken from blast increased", 1.5);
	TF2Attrib_SetByName(weapon, "cannot be backstabbed", 1.0);
	TF2Attrib_SetByName(weapon, "max health additive bonus", 30000.0);
	TF2_AddCondition(client, TFCond_Kritzkrieged, 1000099.0);
	TF2_SetHealth(client, 30000);
	g_bTank[client] = true;
}

MakeMajorCrits(client)
{
	if(!g_bEnabled)
		return Plugin_Continue;

	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	SetEntPropFloat(client, Prop_Send, "m_flModelScale", 1.8);
	UpdatePlayerHitbox(client, 1.8);
	TF2_SetPlayerClass(client, TFClass_Soldier);
	TF2_RegeneratePlayer(client);
	SetModel(client, "models/bots/soldier_boss/bot_soldier_boss.mdl");
	new weapon = GetPlayerWeaponSlot(client, 0);
	TF2_AddCondition(client, TFCond_Kritzkrieged, 1000099.0);
	TF2_RemoveWeaponSlot(client, -2);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 7);
	TF2_RemoveWeaponSlot(client, 4);
	TF2Attrib_SetByName(weapon, "damage bonus", 10000.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 0.25);
	TF2Attrib_SetByName(weapon, "move speed bonus", 0.5);
	TF2Attrib_SetByName(weapon, "dmg taken from fire increased", 2.5);
	TF2Attrib_SetByName(weapon, "dmg taken from crit increased", 2.3);
	TF2Attrib_SetByName(weapon, "dmg taken from bullets increased", 2.5);
	TF2Attrib_SetByName(weapon, "dmg taken from blast increased", 2.5);
	TF2Attrib_SetByName(weapon, "clip size bonus", 20.0);
	TF2Attrib_SetByName(weapon, "faster reload rate", -1.6);
	TF2Attrib_SetByName(weapon,	"hidden primary max ammo bonus ", 10000.0);
	TF2Attrib_SetByName(weapon, "cannot be backstabbed", 1.0);
	TF2Attrib_SetByName(weapon, "max health additive bonus", 30000.0);
	TF2Attrib_SetByName(weapon, "override footstep sound set", 3.0);
	TF2_SetHealth(client, 30000);
	g_bMC[client] = true;
}

public Action:Command_MiniBoss3(int client, int args)
{
	decl String:arg1[32];
	if (args < 1)
	{
		arg1 = "@me";
	}
	else GetCmdArg(1, arg1, sizeof(arg1));
	new String:target_name[MAX_TARGET_LENGTH];
	new target_list[MAXPLAYERS], target_count;
	new bool:tn_is_ml;
 
	if ((target_count = ProcessTargetString(
			arg1,
			client,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE|(args < 1 ? COMMAND_FILTER_NO_IMMUNITY : 0),
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	for (new i = 0; i < target_count; i++)
	{
		MakeBrutalScout(target_list[i]);
		LogAction(client, target_list[i], "\"%L\" made \"%L\" a Brutal Boss!", client, target_list[i]);
	}
	
	return Plugin_Handled
}

stock UpdatePlayerHitbox(const client, const Float:flScale)
{
	static const Float:vecTF2PlayerMin[3] = { -24.5, -24.5, 0.0 }, Float:vecTF2PlayerMax[3] = { 24.5,  24.5, 83.0 };
   
	decl Float:vecScaledPlayerMin[3], Float:vecScaledPlayerMax[3];

	vecScaledPlayerMin = vecTF2PlayerMin;
	vecScaledPlayerMax = vecTF2PlayerMax;
   
	ScaleVector(vecScaledPlayerMin, flScale);
	ScaleVector(vecScaledPlayerMax, flScale);
   
	SetEntPropVector(client, Prop_Send, "m_vecSpecifiedSurroundingMins", vecScaledPlayerMin);
	SetEntPropVector(client, Prop_Send, "m_vecSpecifiedSurroundingMaxs", vecScaledPlayerMax);
}

stock TF2_SetHealth(client, NewHealth)
{
	SetEntProp(client, Prop_Send, "m_iHealth", NewHealth, 1);
	SetEntProp(client, Prop_Data, "m_iHealth", NewHealth, 1);
}

public Action:SetModel(client, const String:model[])
{
	if (IsValidClient(client) && IsPlayerAlive(client))
	{
		SetVariantString(model);
		AcceptEntityInput(client, "SetCustomModel");

		SetEntProp(client, Prop_Send, "m_bUseClassAnimations", 1);
	}
}

stock bool:IsValidClient(client)
{
	if (client <= 0) return false;
	if (client > MaxClients) return false;
	return IsClientInGame(client);
}



stock TF2_GetNameOfClass(TFClassType:class, String:name[], maxlen)
{
	switch (class)
	{
		case TFClass_Scout: Format(name, maxlen, "scout");
		case TFClass_Soldier: Format(name, maxlen, "soldier");
		case TFClass_Pyro: Format(name, maxlen, "pyro");
		case TFClass_DemoMan: Format(name, maxlen, "demoman");
		case TFClass_Heavy: Format(name, maxlen, "heavy");
		case TFClass_Engineer: Format(name, maxlen, "engineer");
		case TFClass_Medic: Format(name, maxlen, "medic");
		case TFClass_Sniper: Format(name, maxlen, "sniper");
		case TFClass_Spy: Format(name, maxlen, "spy");
	}
}

public Event_DeathPre(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	new deathflags = GetEventInt(event, "death_fags");
	new iVictim = GetClientOfUserId(GetEventInt(event, "userid"));
	if(!IsValidClient(iVictim))
		return Plugin_Continue;

	new iAttacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	if(!IsValidClient(iAttacker) || !IsPlayerAlive(iAttacker) || !g_bIsSaxton[iAttacker])
		return Plugin_Continue;

	new iCustom = GetEventInt(event, "customkill");
	if(iCustom != TF_CUSTOM_BOOTS_STOMP)
		SetEventString(event, "weapon", "fists");
}

public Event_Death(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	new deathflags = GetEventInt(event, "death_flags");
	if (!(deathflags && TF_DEATHFLAG_DEADRINGER))
	{
		if (IsValidClient(client) && g_bIsBrutal[client])
		{	
			RemoveModelBrutal(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bIsBrutal[client] = false;
		}
		if (IsValidClient(client) && g_bIsBrutalScout[client])
		{	
			RemoveModelScout(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bIsBrutalScout[client] = false;
		}
		if (IsValidClient(client) && g_bIsBrutalKoloaxScout[client])
		{	
			RemoveModelScout(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bIsBrutalKoloaxScout[client] = false;
		}
		if (IsValidClient(client) && g_bIsNobody[client])
		{	
			RemoveModelScout(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bIsNobody[client] = false;
		}
		if (IsValidClient(client) && g_bTank[client])
		{	
			RemoveModelBrutal(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bTank[client] = false;
			EmitSoundToAll(DEATH2);
			EmitSoundToAll(DEATH2_1);
			AttachParticle(client, "mvm_tank_destroy");
			AttachParticle(client, "mvm_hatch_destroy");
			AttachParticle(client, "fluidSmokeExpl_ring_mvm");
			CreateTimer(0.0, Timer_RemoveRagdoll, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
		}
		if (IsValidClient(client) && g_bSniper[client])
		{	
			RemoveModelBrutal(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bSniper[client] = false;
		}
		if (IsValidClient(client) && g_bSee[client])
		{	
			RemoveModelBrutal(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bSee[client] = false;
		}
		if (IsValidClient(client) && g_bEngie[client])
		{	
			RemoveModel(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bEngie[client] = false;
		}
		if (IsValidClient(client) && g_bIsHeavy[client])
		{	
			RemoveModelBrutal(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bIsHeavy[client] = false;
		}
		if (IsValidClient(client) && g_bNinjaSpy[client])
		{	
			RemoveModelBrutal(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bIsHeavy[client] = false;
		}
		if (IsValidClient(client) && g_bMC[client])
		{	
			RemoveModel(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bMC[client] = false;
		}
		/*if (IsValidClient(client) && g_bIsAlyx[client])
		{	
			RemoveModel(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bIsAlyx[client] = false;
		}*/
		if (IsValidClient(client) && g_bIsSaxton[client])
		{	
			RemoveModel(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			DeadSaxtonSound();
			g_bIsSaxton[client] = false;
		}
	}
}

public Action:Timer_RemoveRagdoll(Handle:timer, any:uid)
{
	new client = GetClientOfUserId(uid);
	if (!IsValidClient(client)) return;
	new ragdoll = GetEntPropEnt(client, Prop_Send, "m_hRagdoll");
	if (!IsValidEntity(ragdoll) || ragdoll <= MaxClients) return;
	AcceptEntityInput(ragdoll, "Kill");
}

stock bool:AttachParticle(Ent, String:particleType[], bool:cache=false) // from L4D Achievement Trophy
{
	new particle = CreateEntityByName("info_particle_system");
	if (!IsValidEdict(particle)) return false;
	new String:tName[128];
	new Float:f_pos[3];
	if (cache) f_pos[2] -= 3000;
	else
	{
		GetEntPropVector(Ent, Prop_Send, "m_vecOrigin", f_pos);
		f_pos[2] += 60;
	}
	TeleportEntity(particle, f_pos, NULL_VECTOR, NULL_VECTOR);
	Format(tName, sizeof(tName), "target%i", Ent);
	DispatchKeyValue(Ent, "targetname", tName);
	DispatchKeyValue(particle, "effect_name", particleType);
	DispatchSpawn(particle);
	SetVariantString(tName);
	AcceptEntityInput(particle, "SetParent", particle, particle, 0);
	ActivateEntity(particle);
	AcceptEntityInput(particle, "start");
	CreateTimer(10.0, DeleteParticle, particle);
	return true;
}

public Action:DeleteParticle(Handle:timer, any:Ent)
{
	if (!IsValidEntity(Ent)) return;
	new String:cls[25];
	GetEdictClassname(Ent, cls, sizeof(cls));
	if (StrEqual(cls, "info_particle_system", false)) AcceptEntityInput(Ent, "Kill");
	return;
}

public Event_NinjaSpyDeath(Handle:hEvent, const String:name[], bool:dontBroadcast)
{
	new iVictim = GetClientOfUserId(GetEventInt(hEvent, "userid"));
	if(!IsValidClient(iVictim))
		return Plugin_Continue;

	new iAttacker = GetClientOfUserId(GetEventInt(hEvent, "attacker"));
	if(!IsValidClient(iAttacker) || !IsPlayerAlive(iAttacker) || !g_bNinjaSpy[iAttacker])
		return Plugin_Continue;

	new iCustom = GetEventInt(hEvent, "customkill");
	if(iCustom != TF_CUSTOM_BOOTS_STOMP)
		SetEventString(hEvent, "weapon", "fists");
	
	if(GetRandomInt(0, 2) == 1)
	{
		new TFClassType:iClass = TF2_GetPlayerClass(iVictim);
		switch(iClass)
		{
			case TFClass_Scout: EmitSoundToAll(SOUND_KILLSCOUT, iAttacker, SNDCHAN_VOICE);
			case TFClass_Pyro: EmitSoundToAll(SOUND_KILLPYRO, iAttacker, SNDCHAN_VOICE);
			case TFClass_DemoMan: EmitSoundToAll(SOUND_KILLDEMO, iAttacker, SNDCHAN_VOICE);
			case TFClass_Heavy: EmitSoundToAll(SOUND_KILLHEAVY, iAttacker, SNDCHAN_VOICE);
			case TFClass_Soldier: EmitSoundToAll(SOUND_KILLSOLDIER, iAttacker, SNDCHAN_VOICE);
		}
	}
	
	return Plugin_Handled;
}

stock GivePainis(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_shovel");
		TF2Items_SetItemIndex(hWeapon, 5);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; %d ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 6 ; 1.2 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0 ; 334 ; 1", GetConVarInt(hCvarHealth));
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock GiveEastDemo(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_bottle");
		TF2Items_SetItemIndex(hWeapon, 5);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; %d ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 6 ; 1.2 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0 ; 334 ; 1", GetConVarInt(hCvarHealth));
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock GiveDemoPan(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_bottle");
		TF2Items_SetItemIndex(hWeapon, 264);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; %d ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 6 ; 1.2 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0 ; 334 ; 1", GetConVarInt(hCvarHealth));
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
		SetEntProp(weapon, Prop_Send, "m_iWorldModelIndex", PrecacheModel(AXE));
		SetEntProp(weapon, Prop_Send, "m_nModelIndexOverrides", PrecacheModel(AXE), _, 0);
	}	
}

stock MakeSee(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_bottle");
		TF2Items_SetItemIndex(hWeapon, 5);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; %d ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 6 ; 1.2 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0 ; 334 ; 1", GetConVarInt(hCvarHealth));
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
		SetEntProp(weapon, Prop_Send, "m_iWorldModelIndex", PrecacheModel(AXE));
		SetEntProp(weapon, Prop_Send, "m_nModelIndexOverrides", PrecacheModel(AXE), _, 0);
	}	
}

stock MakeHyperScoutMelee(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_bat");
		TF2Items_SetItemIndex(hWeapon, 325);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; %d ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 6 ; 1.2 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0 ; 334 ; 1", GetConVarInt(hCvarHealth));
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock MakeKoloaxScoutMelee(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_bat");
		TF2Items_SetItemIndex(hWeapon, 264);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}


stock MakeNobodyMelee(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_sword");
		TF2Items_SetItemIndex(hWeapon, 128);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock MakeNobodyPrimary(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Primary);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_rocketlauncher");
		TF2Items_SetItemIndex(hWeapon, 513);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock MakeAngryKoloaxScoutMelee(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_bat");
		TF2Items_SetItemIndex(hWeapon, 264);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "330 ; 3 ; 6 ; 0.5 ; 264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock MakeKoloaxScoutSecondary(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_cleaver");
		TF2Items_SetItemIndex(hWeapon, 812);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; %d ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 6 ; 1.2 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0 ; 334 ; 1", GetConVarInt(hCvarHealth));
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock MakeHyperScoutMilk(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_jar_milk");
		TF2Items_SetItemIndex(hWeapon, 222);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; %d ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 6 ; 1.2 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0 ; 334 ; 1", GetConVarInt(hCvarHealth));
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock MakeHyperScoutGun(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Primary);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_scattergun");
		TF2Items_SetItemIndex(hWeapon, 13);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 13);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "6 ; 0.8 ; 4 ; 1.2 ; 2 ; 2");
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock MakeBaldiWeapon(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_bat");
		TF2Items_SetItemIndex(hWeapon, 0);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; %d ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 6 ; 1.2 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0 ; 334 ; 1", GetConVarInt(hCvarHealth));
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
	}	
}

stock MakeSentryWeapon(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Primary);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_minigun");
		TF2Items_SetItemIndex(hWeapon, 41);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "26 ; 216.0 ; 402 ; 1.0 ; 107 ; -1.0 ; 57 ; 80");
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
		SetEntProp(weapon, Prop_Send, "m_iWorldModelIndex", PrecacheModel(AXE));
		SetEntProp(weapon, Prop_Send, "m_nModelIndexOverrides", PrecacheModel(AXE), _, 0);
	}	
}

stock MakeSentryWeapon1(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_pistol");
		TF2Items_SetItemIndex(hWeapon, 23);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "26 ; 216.0 ; 402 ; 1.0 ; 107 ; -1.0 ; 57 ; 80 ; 6 ; 1.75");
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
		SetEntProp(weapon, Prop_Send, "m_iWorldModelIndex", PrecacheModel(AXE));
		SetEntProp(weapon, Prop_Send, "m_nModelIndexOverrides", PrecacheModel(AXE), _, 0);
	}	
}

stock MakeSentryWeapon2(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Primary);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_minigun");
		TF2Items_SetItemIndex(hWeapon, 41);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "26 ; 216.0 ; 402 ; 1.0 ; 107 ; -1.0 ; 57 ; 80 ; 6 ; 1.35");
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
		SetEntProp(weapon, Prop_Send, "m_iWorldModelIndex", PrecacheModel(AXE));
		SetEntProp(weapon, Prop_Send, "m_nModelIndexOverrides", PrecacheModel(AXE), _, 0);
	}	
}


stock GiveFists(client)
{
	TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
	new Handle:hWeapon = TF2Items_CreateItem(OVERRIDE_ALL|FORCE_GENERATION);
	if (hWeapon != INVALID_HANDLE)
	{
		TF2Items_SetClassname(hWeapon, "tf_weapon_fists");
		TF2Items_SetItemIndex(hWeapon, 5);
		TF2Items_SetLevel(hWeapon, 100);
		TF2Items_SetQuality(hWeapon, 5);
		new String:weaponAttribs[881];
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; %d ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 6 ; 1.2 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0 ; 334 ; 1", GetConVarInt(hCvarHealth));
		new String:weaponAttribsArray[32][32];
		new attribCount = ExplodeString(weaponAttribs, " ; ", weaponAttribsArray, 32, 32);
		if (attribCount > 0) {
			TF2Items_SetNumAttributes(hWeapon, attribCount/2);
			new i2 = 0;
			for (new i = 0; i < attribCount; i+=2) {
				TF2Items_SetAttribute(hWeapon, i2, StringToInt(weaponAttribsArray[i]), StringToFloat(weaponAttribsArray[i+1]));
				i2++;
			}
		} else {
			TF2Items_SetNumAttributes(hWeapon, 0);
		}
		new weapon = TF2Items_GiveNamedItem(client, hWeapon);
		EquipPlayerWeapon(client, weapon);

		CloseHandle(hWeapon);
		SetEntProp(weapon, Prop_Send, "m_iWorldModelIndex", PrecacheModel(AXE));
		SetEntProp(weapon, Prop_Send, "m_nModelIndexOverrides", PrecacheModel(AXE), _, 0);
	}	
}


public Action:RemoveModelHeavy(client)
{
	if (IsValidClient(client))
	{
		new weapon = GetPlayerWeaponSlot(client, 0); 
		
		TF2Attrib_RemoveAll(weapon);
		SetEntPropFloat(client, Prop_Send, "m_flModelScale", 1.0);
		UpdatePlayerHitbox(client, 1.0);

		SetVariantString("");
		AcceptEntityInput(client, "SetCustomModel");
	}
}

public Action:RemoveModelBrutal(client)
{
	if (IsValidClient(client))
	{
		new weapon = GetPlayerWeaponSlot(client, 2); 
		new weapon2 = GetPlayerWeaponSlot(client, 0); 
		
		TF2Attrib_RemoveAll(weapon);
		TF2Attrib_RemoveAll(weapon2);
		SetEntPropFloat(client, Prop_Send, "m_flModelScale", 1.0);
		UpdatePlayerHitbox(client, 1.0);

		SetVariantString("");
		AcceptEntityInput(client, "SetCustomModel");
	}
}

public Action:RemoveModelScout(client)
{
	if (IsValidClient(client))
	{
		new weapon = GetPlayerWeaponSlot(client, 2); 
		new weapon3 = GetPlayerWeaponSlot(client, 1); 
		new weapon2 = GetPlayerWeaponSlot(client, 0); 
		
		TF2Attrib_RemoveAll(weapon);
		TF2Attrib_RemoveAll(weapon2);
		TF2Attrib_RemoveAll(weapon3);
		SetEntPropFloat(client, Prop_Send, "m_flModelScale", 1.0);
		UpdatePlayerHitbox(client, 1.0);

		SetVariantString("");
		AcceptEntityInput(client, "SetCustomModel");
	}
}

public Action:RemoveModel(client)
{
	if (IsValidClient(client))
	{
		new weapon = GetPlayerWeaponSlot(client, 0); 
		
		TF2Attrib_RemoveAll(weapon);
		SetEntPropFloat(client, Prop_Send, "m_flModelScale", 1.0);
		UpdatePlayerHitbox(client, 1.0);

		SetVariantString("");
		AcceptEntityInput(client, "SetCustomModel");
	}
}

public Action:RemoveModelTank(client)
{
	if (IsValidClient(client))
	{
		new weapon = GetPlayerWeaponSlot(client, 2); 
		
		TF2Attrib_RemoveAll(weapon);
		SetEntPropFloat(client, Prop_Send, "m_flModelScale", 1.0);
		UpdatePlayerHitbox(client, 1.0);

		SetVariantString("");
		AcceptEntityInput(client, "SetCustomModel");
	}
}

public OnClientPutInServer(client)
{
	OnClientDisconnect_Post(client);
}

public OnClientDisconnect_Post(client)
{
	if (g_bIsBrutal[client])
	{
		g_bIsBrutal[client] = false;
	}
	if (g_bMC[client])
	{
		g_bMC[client] = false;
	}
	if (g_bSee[client])
	{
		g_bSee[client] = false;
	}
	if (g_bSniper[client])
	{
		g_bSniper[client] = false;
	}
	if (g_bTank[client])
	{
		g_bTank[client] = false;
	}
	if (g_bEngie[client])
	{
		g_bEngie[client] = false;
	}
	if (g_bMC[client])
	{
		g_bMC[client] = false;
	}
	if (g_bHalloween[client])
	{
		g_bHalloween[client] = false
	}
	if (g_bNinjaSpy[client])
	{
		g_bNinjaSpy[client] = false
	}
	/*if (g_bIsAlyx[client])
	{
		g_bIsAlyx[client] = false
	}*/
}

DoScare(client)
{
	decl Float:Position[3];
	decl Float:pos[3];
	new Team;

	GetClientAbsOrigin(client, Position);
	Team = GetClientTeam(client);
	TF2_StunPlayer(client, 1.3, 1.0, TF_STUNFLAG_SLOWDOWN|TF_STUNFLAG_NOSOUNDOREFFECT);
	for (new i = 1; i <= MaxClients; i++)
	{
		if (!IsValidClient(i) || !IsPlayerAlive(i) || Team == GetClientTeam(i))
			continue;

		GetClientAbsOrigin(i, pos);
		if (GetVectorDistance(Position, pos) <= 500 && !g_bIsBrutal[i])
		{
			TF2_StunPlayer(i, 4.0, 0.3, TF_STUNFLAGS_GHOSTSCARE|TF_STUNFLAG_SLOWDOWN);
		}
	}
}

public Action:BrutalBossSH(clients[64], &numClients, String:sample[PLATFORM_MAX_PATH], &entity, &channel, &Float:volume, &level, &pitch, &flags)
{
//	decl String:clientModel[64];
	if (!IsValidClient(entity)) return Plugin_Continue;
//	GetClientModel(entity, clientModel, sizeof(clientModel));
	if (!g_bIsBrutal[entity]) return Plugin_Continue;
	new boo = GetConVarInt(hCvarBoo);
	if (boo && StrContains(sample, "_medic0", false) != -1)
	{
		sample = BOO;
		if (boo > 1)
		{
			DoScare(entity);
		}
		return Plugin_Changed;
	}
	return Plugin_Continue;
}

public Action TankSH(clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (entity > 0 && entity <= MaxClients && IsClientInGame(entity))
	{
		if (!g_bTank[entity]) return Plugin_Continue;
		
		if (StrContains(sample, "vo/engineer", false) != -1)
		{
			Format(sample, sizeof(sample), "mvm/mvm_tank_horn.wav");
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}

public Action SniperSH(clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (entity > 0 && entity <= MaxClients && IsClientInGame(entity))
	{
		if (!g_bSniper[entity]) return Plugin_Continue;
		
		if (StrContains(sample, "vo/sniper", false) != -1)
		{
			Format(sample, sizeof(sample), "/vo/sniper_revenge%i.mp3", GetRandomInt(10, 25));
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}

public Action BrutalEngineerSH(clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (entity > 0 && entity <= MaxClients && IsClientInGame(entity))
	{
		if (!g_bEngie[entity]) return Plugin_Continue;
		
		if (StrContains(sample, "vo/engineer", false) != -1)
		{
			Format(sample, sizeof(sample), "/vo/engineer_dominationheavy%i.mp3", GetRandomInt(10, 15));
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}


public Action BrutalHeavySH(clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (entity > 0 && entity <= MaxClients && IsClientInGame(entity))
	{
		if (!g_bIsHeavy[entity]) return Plugin_Continue;
		
		if (StrContains(sample, "vo/heavy", false) != -1)
		{
			Format(sample, sizeof(sample), "/vo/heavy_sf12_seeking0%i.mp3", GetRandomInt(1, 2));
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}

public Action BrutalScoutSH(clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (entity > 0 && entity <= MaxClients && IsClientInGame(entity))
	{
		if (!g_bIsBrutalScout[entity]) return Plugin_Continue;
		
		new boo = GetConVarInt(hCvarBoo);
		if (boo && StrContains(sample, "_medic0", false) != -1)
		{
			sample = BOO;
			if (boo > 1)
			{
				DoScare(entity);
			}
			return Plugin_Changed;
		}
		if (StrContains(sample, "vo/scout", false) != -1)
		{
			Format(sample, sizeof(sample), "vo/scout_dominationhvy0%i.mp3", GetRandomInt(1, 9));
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}

public Action BurpSH(clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (entity > 0 && entity <= MaxClients && IsClientInGame(entity))
	{
		if (!g_bIsDrunk[entity]) return Plugin_Continue;
		if (StrContains(sample, "vo/demoman", false) != -1)
		{
			Format(sample, sizeof(sample), "vo/burp0%i.mp3", GetRandomInt(2, 7));
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
		if (StrContains(sample, "vo/", false) != -1)
		{
			Format(sample, sizeof(sample), "vo/demoman_gibberish0%i.mp3", GetRandomInt(1, 9));
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}

public Action SeeSH(clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (entity > 0 && entity <= MaxClients && IsClientInGame(entity))
	{
		if (!g_bSee[entity]) return Plugin_Continue;
		
		if (StrContains(sample, "vo/demoman", false) != -1)
		{
			Format(sample, sizeof(sample), "freak_fortress_2/seeman/seeman_see.wav");
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
		else if (StrContains(sample, "vo/soldier", false) != -1)
		{
			Format(sample, sizeof(sample), "freak_fortress_2/seeman/seeldier_see.wav");
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
		new boo = GetConVarInt(hCvarBoo);
		if (boo && StrContains(sample, "_medic0", false) != -1)
		{
			sample = See;
			if (boo > 1)
			{
				DoScare(entity);
			}
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}

public Action:NPCFootstepSH(clients[64], &numClients, String:sound[PLATFORM_MAX_PATH], &Ent, &channel, &Float:volume, &level, &pitch, &flags)
{
	if (Ent > 0 && Ent <= MaxClients && IsClientInGame(Ent))
	{
		if (!g_bNPCFootsteps[Ent]) return Plugin_Continue;
		
		if(StrContains(sound, "player/footsteps/", false) != -1)
		{
			Format(sound, sizeof(sound), "npc/footsteps/hardboot_generic%i.wav", GetRandomInt(1,6));
			PrecacheSound(sound);
			EmitSoundToAll(sound, Ent, SNDCHAN_STATIC, SNDLEVEL_SCREAMING, _, 0.4);
			return Plugin_Stop;
		}
		return Plugin_Changed;
	}

	return Plugin_Continue;
}

/*public Action AlyxSH(clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (entity > 0 && entity <= MaxClients && IsClientInGame(entity))
	{
		if (!g_bIsAlyx[entity]) return Plugin_Continue;
		
		if (StrContains(sample, "vo/scout", false) != -1)
		{
			Format(sample, sizeof(sample), "vo/npc/alyx/gordon_dist01.wav");
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}*/

public Action LoskyPoppedUp(int client, int argsx)
{
	char sPath[PLATFORM_MAX_PATH];
	CreateTimer(0.65, Timer_Beep, _, TIMER_FLAG_NO_MAPCHANGE);
	PrintToChatAll("\x04NO! I WILL EAT MORE CAKES IF YOU DON'T ADD ME AS A BOSS! - Losky");
	LogError("[Seamus's Server] Error: Ahh! I must be dreaming! My server got hacked by a bootleg mario kart 7 logo! dagnabbit damnit! (you did the easter egg, good job!)", sPath);
}

public Action:Timer_Beep(Handle:timer){
	for(new i=1;i<=MaxClients;i++){
		if(IsClientInGame(i)){
			ClientCommand(i, "playgamesound vo/heavy_no02.mp3");
			TF2_StunPlayer(i, 5.0, 0.0, TF_STUNFLAGS_GHOSTSCARE);
		}
	}
	return Plugin_Continue;
}

public OnConVarChange(Handle:hConvar, const String:strOldValue[], const String:strNewValue[])
{
	if(hConvar == g_hCvarSuperJumps)
		g_bSuperJumps = GetConVarBool(g_hCvarSuperJumps);
	if(hConvar == g_hCvarEnabled)
		g_bEnabled = GetConVarBool(g_hCvarEnabled);
	if(hConvar == g_hCvarRaging)
		g_iRaging = GetConVarInt(g_hCvarRaging);
	if(hConvar == g_hCvarSounds)
		g_bSounds = GetConVarBool(g_hCvarSounds);
}

public Action:Timer_RageMeter(Handle:hTimer)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(g_bIsSaxton[i])
		{
			SetGlobalTransTarget(i);
			if(g_iRage[i] + g_iRaging <= 100 - g_iRaging)
			{
				g_iRage[i] += g_iRaging;
				PrintHintText(i, "%t %", "rage_status", g_iRage[i]);
			}
			else
			{
				g_iRage[i] = 100;
				PrintHintText(i, "%t", "rage_full");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_RageMeter2(Handle:hTimer)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(g_bIsBrutal[i])
		{
			SetGlobalTransTarget(i);
			if(g_iRage[i] + g_iRaging <= 100 - g_iRaging)
			{
				g_iRage[i] += g_iRaging;
				PrintHintText(i, "%t %", "rage_status", g_iRage[i]);
			}
			else
			{
				g_iRage[i] = 100;
				PrintHintText(i, "%t", "rage_full");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_RageMeter3(Handle:hTimer)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(g_bIsBrutalScout[i])
		{
			SetGlobalTransTarget(i);
			if(g_iRage[i] + g_iRaging <= 100 - g_iRaging)
			{
				g_iRage[i] += g_iRaging;
				PrintHintText(i, "%t %", "rage_status", g_iRage[i]);
			}
			else
			{
				g_iRage[i] = 100;
				PrintHintText(i, "%t", "rage_full");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_RageMeter4(Handle:hTimer)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(g_bIsHeavy[i])
		{
			SetGlobalTransTarget(i);
			if(g_iRage[i] + g_iRaging <= 100 - g_iRaging)
			{
				g_iRage[i] += g_iRaging;
				PrintHintText(i, "%t %", "rage_status", g_iRage[i]);
			}
			else
			{
				g_iRage[i] = 100;
				PrintHintText(i, "%t", "rage_full");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_RageMeter5(Handle:hTimer)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(g_bEngie[i])
		{
			SetGlobalTransTarget(i);
			if(g_iRage[i] + g_iRaging <= 100 - g_iRaging)
			{
				g_iRage[i] += g_iRaging;
				PrintHintText(i, "%t %", "rage_status", g_iRage[i]);
			}
			else
			{
				g_iRage[i] = 100;
				PrintHintText(i, "%t", "rage_full");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_RageMeter6(Handle:hTimer)
{
	if(!g_bEnabled || g_iRaging <= 0)
		return Plugin_Continue;

	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(g_bSee[i])
		{
			SetGlobalTransTarget(i);
			if(g_iRage[i] + g_iRaging <= 100 - g_iRaging)
			{
				g_iRage[i] += g_iRaging;
				PrintHintText(i, "%t %", "rage_status", g_iRage[i]);
			}
			else
			{
				g_iRage[i] = 100;
				PrintHintText(i, "%t", "rage_full");
			}
		}
	}
	return Plugin_Continue;
}

public Action:Timer_UseRage(Handle:hTimer, any:iClientId)
{
	new iClient = GetClientOfUserId(iClientId);
	if(!IsValidClient(iClient))
		return Plugin_Continue;

	TF2_RemoveCondition(iClient, TFCond_Taunting);

	decl Float:fOrigin1[3];
	GetEntPropVector(iClient, Prop_Send, "m_vecOrigin", fOrigin1);

	decl Float:fOrigin2[3];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(GetClientTeam(i) != GetClientTeam(iClient) && IsPlayerAlive(i) && i != iClient)
		{
			GetEntPropVector(i, Prop_Send, "m_vecOrigin", fOrigin2);
			if(!TF2_IsPlayerInCondition(i, TFCond_Ubercharged) && GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
			{
				new iFlags = TF_STUNFLAGS_GHOSTSCARE;
				TF2_StunPlayer(i, 5.0, _, iFlags, iClient);
			}
		}
	}

	new iEntity = -1;
	while((iEntity = FindEntityByClassname(iEntity, "obj_sentrygun")) != -1)
	{
		if(GetEntProp(iEntity, Prop_Send, "m_iTeamNum") == GetClientTeam(iClient))
			continue;

		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin2);
		if(GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
		{
			SetEntProp(iEntity, Prop_Send, "m_bDisabled", 1);
			AttachParticle(iEntity, "yikes_fx", 75.0);
			SetVariantInt(GetEntProp(iEntity, Prop_Send, "m_iHealth") / 2);
			AcceptEntityInput(iEntity, "RemoveHealth");
			CreateTimer(8.0, Timer_ReEnableSentry, EntIndexToEntRef(iEntity));
		}
	}

	while((iEntity = FindEntityByClassname(iEntity, "obj_dispenser")) != -1)
	{
		if(GetEntProp(iEntity, Prop_Send, "m_iTeamNum") == GetClientTeam(iClient))
			continue;

		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin2);
		if(GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
		{
			SetVariantInt(1);
			AcceptEntityInput(iEntity, "RemoveHealth");
		}
	}

	while((iEntity = FindEntityByClassname(iEntity, "obj_teleporter")) != -1)
	{
		if(GetEntProp(iEntity, Prop_Send, "m_iTeamNum") == GetClientTeam(iClient))
			continue;

		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin2);
		if(GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
		{
			SetVariantInt(1);
			AcceptEntityInput(iEntity, "RemoveHealth");
		}
	}
	return Plugin_Continue;
}

public Action:Timer_UseRage2(Handle:hTimer, any:iClientId)
{
	new iClient = GetClientOfUserId(iClientId);
	if(!IsValidClient(iClient))
		return Plugin_Continue;

	TF2_RemoveCondition(iClient, TFCond_Taunting);

	decl Float:fOrigin1[3];
	GetEntPropVector(iClient, Prop_Send, "m_vecOrigin", fOrigin1);

	decl Float:fOrigin2[3];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(GetClientTeam(i) != GetClientTeam(iClient) && IsPlayerAlive(i) && i != iClient)
		{
			GetEntPropVector(i, Prop_Send, "m_vecOrigin", fOrigin2);
			if(!TF2_IsPlayerInCondition(i, TFCond_Ubercharged) && GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
			{
				new iFlags = TF_STUNFLAGS_GHOSTSCARE;
				TF2_StunPlayer(i, 5.0, _, iFlags, iClient);
			}
		}
	}

	new iEntity = -1;
	while((iEntity = FindEntityByClassname(iEntity, "obj_sentrygun")) != -1)
	{
		if(GetEntProp(iEntity, Prop_Send, "m_iTeamNum") == GetClientTeam(iClient))
			continue;

		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin2);
		if(GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
		{
			SetEntProp(iEntity, Prop_Send, "m_bDisabled", 1);
			AttachParticle(iEntity, "yikes_fx", 75.0);
			SetVariantInt(GetEntProp(iEntity, Prop_Send, "m_iHealth") / 2);
			AcceptEntityInput(iEntity, "RemoveHealth");
			CreateTimer(8.0, Timer_ReEnableSentry, EntIndexToEntRef(iEntity));
		}
	}

	while((iEntity = FindEntityByClassname(iEntity, "obj_dispenser")) != -1)
	{
		if(GetEntProp(iEntity, Prop_Send, "m_iTeamNum") == GetClientTeam(iClient))
			continue;

		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin2);
		if(GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
		{
			SetVariantInt(1);
			AcceptEntityInput(iEntity, "RemoveHealth");
		}
	}

	while((iEntity = FindEntityByClassname(iEntity, "obj_teleporter")) != -1)
	{
		if(GetEntProp(iEntity, Prop_Send, "m_iTeamNum") == GetClientTeam(iClient))
			continue;

		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin2);
		if(GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
		{
			SetVariantInt(1);
			AcceptEntityInput(iEntity, "RemoveHealth");
		}
	}
	return Plugin_Continue;
}


public Action:Timer_UseRage3(Handle:hTimer, any:iClientId)
{
	new iClient = GetClientOfUserId(iClientId);
	if(!IsValidClient(iClient))
		return Plugin_Continue;

	decl Float:fOrigin1[3];
	GetEntPropVector(iClient, Prop_Send, "m_vecOrigin", fOrigin1);

	decl Float:fOrigin2[3];
	for(new i = 1; i <= MaxClients; i++) if(IsValidClient(i))
	{
		if(GetClientTeam(i) != GetClientTeam(iClient) && IsPlayerAlive(i) && i != iClient)
		{
			GetEntPropVector(i, Prop_Send, "m_vecOrigin", fOrigin2);
			if(!TF2_IsPlayerInCondition(i, TFCond_Ubercharged) && GetVectorDistance(fOrigin1, fOrigin2) < 2000.0)
			{
				new iFlags = TF_STUNFLAGS_GHOSTSCARE;
				TF2_StunPlayer(i, 20.0, _, iFlags, iClient);
				TF2_RemoveCondition(i, TFCond:5);
			}
		}
	}

	new iEntity = -1;
	while((iEntity = FindEntityByClassname(iEntity, "obj_sentrygun")) != -1)
	{
		if(GetEntProp(iEntity, Prop_Send, "m_iTeamNum") == GetClientTeam(iClient))
			continue;

		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin2);
		if(GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
		{
			SetEntProp(iEntity, Prop_Send, "m_bDisabled", 1);
			AttachParticle(iEntity, "yikes_fx", 75.0);
			SetVariantInt(GetEntProp(iEntity, Prop_Send, "m_iHealth") / 2);
			AcceptEntityInput(iEntity, "RemoveHealth");
			CreateTimer(8.0, Timer_ReEnableSentry, EntIndexToEntRef(iEntity));
		}
	}

	while((iEntity = FindEntityByClassname(iEntity, "obj_dispenser")) != -1)
	{
		if(GetEntProp(iEntity, Prop_Send, "m_iTeamNum") == GetClientTeam(iClient))
			continue;

		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin2);
		if(GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
		{
			SetVariantInt(1);
			AcceptEntityInput(iEntity, "RemoveHealth");
		}
	}

	while((iEntity = FindEntityByClassname(iEntity, "obj_teleporter")) != -1)
	{
		if(GetEntProp(iEntity, Prop_Send, "m_iTeamNum") == GetClientTeam(iClient))
			continue;

		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin2);
		if(GetVectorDistance(fOrigin1, fOrigin2) < 800.0)
		{
			SetVariantInt(1);
			AcceptEntityInput(iEntity, "RemoveHealth");
		}
	}
	return Plugin_Continue;
}


public Action:Timer_ReEnableSentry(Handle:hTimer, any:iEntityId)
{
	new iEntity = EntRefToEntIndex(iEntityId);
	if(!IsValidEntityEx(iEntity))
		return Plugin_Continue;

	decl String:strClassname[64];
	GetEdictClassname(iEntity, strClassname, sizeof(strClassname));
	if(!StrEqual(strClassname, "obj_sentrygun"))
		return Plugin_Continue;

	SetEntProp(iEntity, Prop_Send, "m_bDisabled", 0);

	new iEntity2 = -1;
	while((iEntity2 = FindEntityByClassname(iEntity2, "info_particle_system")) != -1)
	{
		if(GetEntPropEnt(iEntity2, Prop_Send, "m_hOwnerEntity") == iEntity)
			AcceptEntityInput(iEntity2, "Kill");
	}
	return Plugin_Continue;
}

stock bool:IsValidEntityEx(iEntity)
{
	if(iEntity <= MaxClients || !IsValidEntity(iEntity))
		return false;
	return true;
}

public Action:SaxtonSH(iClients[64], &iClientCount, String:strSample[PLATFORM_MAX_PATH], &iEntity, &iChannel, &Float:fVolume, &iLevel, &iPitch, &iFlags)
{
	if(!g_bSounds || !IsValidClient(iEntity))
		return Plugin_Continue;

	if(g_bIsSaxton[iEntity] && StrContains(strSample, "saxton_hale", false) == -1)
		return Plugin_Stop;
	return Plugin_Continue;
}
