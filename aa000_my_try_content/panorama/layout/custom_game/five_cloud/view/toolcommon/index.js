'use strict';

let prevAction = null

let ToggleHeroPanel = (action) => {
    let IsOpen = GameUI.FiveCloudLayer.IsOpen('heropick', 'center')
    GameUI.FiveCloudConfig.currentAction = action

    if (IsOpen) {
        if (prevAction != GameUI.FiveCloudConfig.currentAction) {
            GameUI.FiveCloudLayer.Close('heropick', 'center')
            $.Schedule(0.2, function () {
                GameUI.FiveCloudLayer.Open('heropick', 'center')
                GameUI.FiveCloudConfig.mouseClickListen = true
            })
        } else {
            GameUI.FiveCloudLayer.Close('heropick', 'center')
        }
    } else {
        GameUI.FiveCloudLayer.Open('heropick', 'center')
        GameUI.FiveCloudConfig.mouseClickListen = true
    }
    //preaction的作用是啥？
    prevAction = GameUI.FiveCloudConfig.currentAction

}

let arrowParticle = null

let MoveToPoint = () => {
    GameUI.FiveCloudLayer.CloseAll('center')
    GameUI.FiveCloudConfig.mouseClickListen = true
    GameUI.FiveCloudConfig.currentAction = 'MoveToPoint'

    let entindex = Players.GetLocalPlayerPortraitUnit()

    if (arrowParticle != null) {
        Particles.DestroyParticleEffect(arrowParticle, true)
        Particles.ReleaseParticleIndex(arrowParticle);
    }
    arrowParticle = Particles.CreateParticle('panorama/layout/custom_game/five_cloud/particles/selection/selection_grid_drag.vpcf', ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, entindex);

    const origin = Entities.GetAbsOrigin(entindex);

    origin[2] += 50;
    Particles.SetParticleControl(arrowParticle, 4, origin);

    Particles.SetParticleAlwaysSimulate(arrowParticle);

    MoveToParticlesThink()
}

let MoveToParticlesThink = () => {
    let entindex = Players.GetLocalPlayerPortraitUnit()
    if (GameUI.FiveCloudConfig.mouseClickListen) {
        var coordinates = GameUI.GetScreenWorldPosition(GameUI.GetCursorPosition())
        const origin = Entities.GetAbsOrigin(entindex)
        origin[2] += 50;
        Particles.SetParticleControl(arrowParticle, 4, origin);
        Particles.SetParticleControl(arrowParticle, 5, coordinates)
        Particles.SetParticleControl(arrowParticle, 2, [128, 128, 128]);

        $.Schedule(0, MoveToParticlesThink)
    } else {
        Particles.DestroyParticleEffect(arrowParticle, true)
        Particles.ReleaseParticleIndex(arrowParticle)
        if (GameUI.FiveCloudConfig.currentAction == 'MoveToPoint') {
            Particles.CreateParticle('particles/units/heroes/hero_antimage/antimage_blink_end_b.vpcf', ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, entindex)
        }

    }
}


let MouseOverRune = (strRuneID, strRuneTooltip) => {
    var runePanel = $('#' + strRuneID);
    runePanel.StartAnimating();
    $.DispatchEvent('UIShowTextTooltip', runePanel, strRuneTooltip);
}

let MouseOutRune = (strRuneID) => {
    var runePanel = $('#' + strRuneID);
    runePanel.StopAnimating();
    $.DispatchEvent('UIHideTextTooltip', runePanel);
}

let EntInfoButton = () => {
    GameUI.FiveCloudLayer.Toggle('entinfo', 'right')
}

let EntKVButton = () => {
    GameUI.FiveCloudLayer.Toggle('entkv', 'right')
    if (GameUI.FiveCloudLayer.IsOpen('entkv', 'right')){
        let ent = Players.GetLocalPlayerPortraitUnit()
        GameUI.FiveCloudSDK.SendCustomGameEvent('five_cloud_custom_event', { event: 'GetEntKV', ent: ent, kvType: 1, updateServerStatus: true })
    }
}

(function () {


    //
    GameUI.FiveCloudLayer.HoverDOTATooltip($('#ReplaceAbility'), '#ReplaceAbilityDescribe')
    

    //GameUI.FiveCloudLayer.HoverDOTATooltip($('#DistanceDescribe'), '#GetDistanceDescribe')

})();
