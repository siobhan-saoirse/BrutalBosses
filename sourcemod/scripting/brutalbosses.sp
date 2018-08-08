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
new bool:g_bIsAlyx[MAXPLAYERS + 1];
new bool:g_bIsBrutalScout[MAXPLAYERS + 1];
new bool:g_bIsBrutalKoloaxScout[MAXPLAYERS + 1];
new bool:g_bIsNobody[MAXPLAYERS + 1];

new Handle:hCvarBoo;

public OnPluginStart()
{
	AddCommandListener(Listener_taunt, "taunt");
	AddCommandListener(Listener_taunt, "+taunt");
	AddCommandListener(Listener_taunt2, "taunt");
	AddCommandListener(Listener_taunt2, "+taunt");

	RegAdminCmd("sm_brutalspy", Command_MiniBoss, ADMFLAG_CHEATS);
	RegAdminCmd("sm_brutalsniper", Command_MiniBoss2, ADMFLAG_CHEATS);
	RegAdminCmd("sm_brutalscout", Command_MiniBoss3, ADMFLAG_CHEATS);
	RegAdminCmd("sm_hyperscout", Command_YetAnotherBrutalScout, ADMFLAG_CHEATS);
	RegAdminCmd("sm_easterdemo", Command_EasterDemoman, ADMFLAG_CHEATS);
	RegAdminCmd("sm_painiscupcake", Command_Painis, ADMFLAG_CHEATS);
	RegAdminCmd("sm_demopan", Command_DemoPan, ADMFLAG_CHEATS);
	RegAdminCmd("sm_seeman", Command_SeeMan, ADMFLAG_CHEATS);
	RegAdminCmd("sm_seeldier", Command_Seeldier, ADMFLAG_CHEATS);
	RegAdminCmd("sm_betank",	Command_Tank, ADMFLAG_CHEATS);
	RegAdminCmd("sm_sans",	Command_Engie, ADMFLAG_CHEATS);
	RegAdminCmd("sm_brutalengie",	Command_Engie, ADMFLAG_CHEATS);
	RegAdminCmd("sm_brutalheavy",	Command_Heavy, ADMFLAG_CHEATS);
	RegAdminCmd("sm_bemonoculus",	Command_Monoculus, ADMFLAG_CHEATS);
	RegAdminCmd("sm_majorcrits",	Command_MajorCrits, ADMFLAG_CHEATS);
	RegAdminCmd("sm_ninjaspy",	Command_NinjaSpy, ADMFLAG_CHEATS);
	RegAdminCmd("sm_heavyvoice",	Command_HeavyVoice, ADMFLAG_CHEATS);
	RegAdminCmd("sm_baldi",	Command_Baldi, ADMFLAG_CHEATS);
	RegAdminCmd("sm_alyx", Command_Alyx, ADMFLAG_CHEATS);
	RegAdminCmd("sm_sentry",	Command_Sentry, ADMFLAG_CHEATS);
	RegAdminCmd("sm_sentry_level1",	Command_Sentry1, ADMFLAG_CHEATS);
	RegAdminCmd("sm_sentry_level2",	Command_Sentry2, ADMFLAG_CHEATS);
	RegAdminCmd("sm_airstrike",	Command_Airstrikef, ADMFLAG_CHEATS);
	RegAdminCmd("sm_koloax",	Command_KoloaxScout, ADMFLAG_CHEATS);
	RegAdminCmd("sm_seamus",	Command_Nobody, ADMFLAG_CHEATS);
	RegAdminCmd("sm_seamusmario",	Command_Nobody, ADMFLAG_CHEATS);
	hCvarBoo = CreateConVar("sm_brutalbosses_boo", "2", "2-Boo stuns nearby enemies; 1-Boo is sound only; 0-no Boo", FCVAR_PLUGIN, true, 0.0, true, 2.0);
	AddNormalSoundHook(TankSH);
	AddNormalSoundHook(BrutalBossSH);
	AddNormalSoundHook(SniperSH);
	AddNormalSoundHook(BrutalEngineerSH);
	AddNormalSoundHook(BrutalHeavySH);
	AddNormalSoundHook(BrutalScoutSH);
	AddNormalSoundHook(AlyxSH);
	AddNormalSoundHook(SeeSH);
	
	HookEvent("player_death", Event_Death, EventHookMode_Post);
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
	PrecacheSound("freak_fortress_2/ninjaspy/kill_demo.wav");
	PrecacheSound("freak_fortress_2/ninjaspy/kill_heavy.wav");
	PrecacheSound("freak_fortress_2/ninjaspy/kill_soldier.wav");
	PrecacheSound("freak_fortress_2/ninjaspy/ninjaspy_begin2.wav");
	PrecacheSound("freak_fortress_2/ninjaspy/ninjaspy_begin3.wav");
	PrecacheModel(DemoPan);
	PrecacheModel(AXE);
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

public Action:Command_Alyx(int client, int args)
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

public Action:Command_Monoculus(int client, int args)
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
}

MakeSpy(client)
{
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
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bIsBrutal[client] = true
}

MakeSentry(client)
{
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
	TF2Attrib_SetByName(weapon, "move speed bonus", 9999.0);
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
	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	SetModel(client, "models/freak_fortress_2/koloax/koloax.mdl");
	EmitSoundToAll("freak_fortress_2/koloax/intro1.wav");
	TF2_SetPlayerClass(client, TFClass_Scout);
	TF2_RemoveWeaponSlot(client, 0);
	MakeKoloaxScoutMelee(client);
	MakeKoloaxScoutSecondary(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 10.0);
	g_bIsBrutalKoloaxScout[client] = true
}

MakeNobody(client)
{
	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	SetModel(client, "models/freak_fortress_2/seamusmario/seamusmario.mdl");
	EmitSoundToAll("freak_fortress_2/seamusmario/intro1.wav");
	TF2_SetPlayerClass(client, TFClass_Soldier);
	TF2_RemoveWeaponSlot(client, 0);
	MakeNobodyMelee(client);
	MakeNobodyPrimary(client);
	TF2_SetHealth(client, 10000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 10.0);
	g_bIsNobody[client] = true
}

public Action:Listener_taunt2(iClient, const String:command[], args)
{
	if(!g_bIsNobody[iClient])
		return Plugin_Continue;
		
	if (GetEntProp(iClient, Prop_Send, "m_hGroundEntity") == -1) return Plugin_Continue;
	MakeRageNobody(iClient);
}

MakeRageNobody(client)
{
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

public Action:Listener_taunt(iClient, const String:command[], args)
{
	if(!g_bIsBrutalKoloaxScout[iClient])
		return Plugin_Continue;
		
	if (GetEntProp(iClient, Prop_Send, "m_hGroundEntity") == -1) return Plugin_Continue;
	MakeAngryKoloaxScout(iClient);
}

MakeAngryKoloaxScout(client)
{
	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.75);
	SetEntPropFloat(client, Prop_Send, "m_flModelScale", 1.75);
	SetModel(client, "models/freak_fortress_2/koloax/koloax.mdl");
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

MakeAlyx(client)
{
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
}

MakePan(client)
{
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
	TF2_SetHealth(client, 8175);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bIsBrutal[client] = true
}

MakeSeeman(client)
{
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
	TF2_SetHealth(client, 8175);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bSee[client] = true
}

MakeBaldi(client)
{
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
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bIsBrutal[client] = true
}


MakeSeeldier(client)
{
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
	TF2_SetHealth(client, 8175);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bSee[client] = true
}

MakeHeavy(client)
{
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
	TF2_SetHealth(client, 8175);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bIsHeavy[client] = true
}

MakePainisCupcake(client)
{
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
	TF2_SetHealth(client, 1000);
	EmitSoundToAll(IAmPainisCupcake);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bIsBrutal[client] = true
}

MakeEaster(client)
{
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
	TF2_SetHealth(client, 1000);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
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
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bSniper[client] = true
}

MakeBrutalScout(client)
{
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
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bIsBrutalScout[client] = true
}

MakeNinjaSpy(client)
{
	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	UpdatePlayerHitbox(client, 1.5);
	TF2_SetPlayerClass(client, TFClass_Spy);
	TF2_RegeneratePlayer(client);
	new String:randomsound[250]
	SetModel(client, NinjaSpy);
	Format(randomsound, sizeof(randomsound), "sound/freak_fortress_2/ninjaspy/ninjaspy_begin%i.wav", GetRandomInt(2, 3));
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
	TF2_SetHealth(client, 9125);
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	g_bNinjaSpy[client] = true;
}

MakeBrutalEngie(client)
{
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
	TF2_SetHealth(client, 9999);
	TF2_AddCondition(client, TFCond_Kritzkrieged, 999999.0);
	g_bEngie[client] = true
}

MakeMonoculus(client)
{
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
	TF2_AddCondition(client, TFCond_MarkedForDeath, 999999.0);
	TF2_SetHealth(client, 30000);
	TF2_AddCondition(client, TFCond_Kritzkrieged, 999999.0);
	if (GetEntityMoveType(client) != MOVETYPE_FLY)
	{
		SetEntityMoveType(client, MOVETYPE_FLY);
	}
	g_bHalloween[client] = true
}

MakeTank(client)
{
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
	TF2_AddCondition(client, TFCond_Kritzkrieged, 999999.0);
	TF2_SetHealth(client, 30000);
	g_bTank[client] = true;
}

MakeMajorCrits(client)
{
	SetEntProp(client, Prop_Send, "m_bIsMiniBoss", true);
	SetEntPropFloat(client, Prop_Send, "m_flModelScale", 1.8);
	UpdatePlayerHitbox(client, 1.8);
	TF2_SetPlayerClass(client, TFClass_Soldier);
	TF2_RegeneratePlayer(client);
	SetModel(client, "models/bots/soldier_boss/bot_soldier_boss.mdl");
	new weapon = GetPlayerWeaponSlot(client, 0);
	TF2_AddCondition(client, TFCond_Kritzkrieged, 999999.0);
	TF2_RemoveWeaponSlot(client, -2);
	TF2_RemoveWeaponSlot(client, -1);
	TF2_RemoveWeaponSlot(client, 2);
	TF2_RemoveWeaponSlot(client, 1);
	TF2_RemoveWeaponSlot(client, 5);
	TF2_RemoveWeaponSlot(client, 3);
	TF2_RemoveWeaponSlot(client, 7);
	TF2_RemoveWeaponSlot(client, 4);
	TF2Attrib_SetByName(weapon, "damage bonus", 9999.0);
	TF2Attrib_SetByName(weapon, "fire rate bonus", 0.25);
	TF2Attrib_SetByName(weapon, "move speed bonus", 0.5);
	TF2Attrib_SetByName(weapon, "dmg taken from fire increased", 2.5);
	TF2Attrib_SetByName(weapon, "dmg taken from crit increased", 2.3);
	TF2Attrib_SetByName(weapon, "dmg taken from bullets increased", 2.5);
	TF2Attrib_SetByName(weapon, "dmg taken from blast increased", 2.5);
	TF2Attrib_SetByName(weapon, "clip size bonus", 20.0);
	TF2Attrib_SetByName(weapon, "faster reload rate", -1.6);
	TF2Attrib_SetByName(weapon,	"hidden primary max ammo bonus ", 9999.0);
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

stock UpdatePlayerHitbox(const iClient, const Float:flScale)
{
	static const Float:vecTF2PlayerMin[3] = { -24.5, -24.5, 0.0 }, Float:vecTF2PlayerMax[3] = { 24.5,  24.5, 83.0 };
   
	decl Float:vecScaledPlayerMin[3], Float:vecScaledPlayerMax[3];

	vecScaledPlayerMin = vecTF2PlayerMin;
	vecScaledPlayerMax = vecTF2PlayerMax;
   
	ScaleVector(vecScaledPlayerMin, flScale);
	ScaleVector(vecScaledPlayerMax, flScale);
   
	SetEntPropVector(iClient, Prop_Send, "m_vecSpecifiedSurroundingMins", vecScaledPlayerMin);
	SetEntPropVector(iClient, Prop_Send, "m_vecSpecifiedSurroundingMaxs", vecScaledPlayerMax);
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

public Event_Death(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	new deathflags = GetEventInt(event, "death_flags");
	if (!(deathflags & TF_DEATHFLAG_DEADRINGER))
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
		if (IsValidClient(client) && g_bIsNobodu[client])
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
		if (IsValidClient(client) && g_bIsAlyx[client])
		{	
			RemoveModel(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			g_bIsAlyx[client] = false;
		}
		if (IsValidClient(client) && g_bHalloween[client])
		{	
			RemoveModel(client)
			TF2Attrib_RemoveAll(client);
			TF2_RegeneratePlayer(client);
			if (GetEntityMoveType(client) == MOVETYPE_FLY)
			{
				SetEntityMoveType(client, MOVETYPE_WALK);
			}
			g_bHalloween[client] = false;
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
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
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
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
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
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
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
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
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
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
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
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
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
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
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
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
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
		
		Format(weaponAttribs, sizeof(weaponAttribs), "264 ; 1.75 ; 263 ; 1.3 ; 15 ; 0 ; 26 ; 1000 ; 2 ; 999.0 ; 107 ; 4.0 ; 109 ; 0.0 ; 62 ; 0.70 ; 205 ; 0.05 ; 206 ; 0.05 ; 68 ; -2 ; 69 ; 0.0 ; 53 ; 1.0 ; 27 ; 1.0");
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
	if (g_bIsAlyx[client])
	{
		g_bIsAlyx[client] = false
	}
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
		if (!IsValidClient(i) || !IsPlayerAlive(i) || HorsemannTeam == GetClientTeam(i))
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
			DoHorsemannScare(entity);
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
				DoHorsemannScare(entity);
			}
			return Plugin_Changed;
		}
		if (StrContains(sample, "vo/scout", false) != -1)
		{
			Format(sample, sizeof(sample), "sound/vo/scout_dominationhvy%i.mp3", GetRandomInt(01, 10));
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
				DoHorsemannScare(entity);
			}
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}

public Action AlyxSH(clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed)
{
	if (entity > 0 && entity <= MaxClients && IsClientInGame(entity))
	{
		if (!g_bIsAlyx[entity]) return Plugin_Continue;
		
		if (StrContains(sample, "vo/scout", false) != -1)
		{
			Format(sample, sizeof(sample), "sound/vo/npc/alyx/gordon_dist01.wav");
			PrecacheSound(sample);
			EmitSoundToAll(sample, entity, channel, level, flags, volume);
			
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}
