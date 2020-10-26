import { InterstitialAd, RewardedAd, BannerAd, TestIds, BannerAdSize } from '@react-native-firebase/admob';
import { AdEventType } from '@react-native-firebase/admob';
import React, {PureComponent} from 'react';

export default class AdPage extends PureComponent {

    constructor(props) {
        super(props);
        const interstitial = InterstitialAd.createForAdRequest(TestIds.INTERSTITIAL, {
            requestNonPersonalizedAdsOnly: true,
        });
        this.state = {interstitial: interstitial};

        this.state.interstitial.onAdEvent((type) => {
            console.log("onAdEvent: ");
            console.log(type);
            if (type === AdEventType.LOADED) {
                interstitial.show();
            }
        });

        this.state.interstitial.load();
    }

    render() {
        return null;
    }
}