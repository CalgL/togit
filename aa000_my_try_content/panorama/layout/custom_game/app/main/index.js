'use strict';


(function () {

	let path_game = 'app/'

	GameUI.FiveCloudSDK.AddTopMenu(
		's2r://panorama/images/hud/reborn/icon_combat_log_psd.vtex',
		'CombatLogButton',
		()=>{$.DispatchEvent('DOTAHUDToggleCombatLog')},
		0,
		'#DOTA_HUD_CombatLog'
	)

	

	GameUI.FiveCloudSDK.DrawTopMenu()

	GameUI.FiveCloudSDK.SendCustomGameEvent('app_event', { event: 'OnJsCompleted' })
})();

GameUI.FiveCloudSDK.Print("app/main/index.js init over")
