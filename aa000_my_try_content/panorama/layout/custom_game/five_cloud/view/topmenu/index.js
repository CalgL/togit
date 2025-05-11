'use strict';

let ShowTopMenu = () => {

 
    GameUI.FiveCloudSDK.AddTopMenu(
            'file://{resources}/layout/custom_game/five_cloud/images/toolcommon.png',
            'toolCommonButton',
            () => { GameUI.FiveCloudLayer.Toggle('toolcommon', 'left') },
            10
    )
    
    
    



    GameUI.FiveCloudSDK.DrawTopMenu()

    $.Schedule(2, function () {
        GameUI.FiveCloudLayer.Open('topmenu', 'topmenu')
    })
}

(function () {
    GameEvents.Subscribe('ShowTopMenu', ShowTopMenu)
})();
