import { InterstitialAd, RewardedAd, BannerAd, TestIds, BannerAdSize } from '@react-native-firebase/admob';
import React, {PureComponent} from 'react';

export default class AdBanner extends PureComponent {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <BannerAd
                unitId={'ca-app-pub-3881794023646828/4699566563'}
                size={BannerAdSize.SMART_BANNER}
                onAdLoaded={() => {
                    console.log('Advert loaded');
                }}
                onAdFailedToLoad={(error) => {
                    console.warn('Advert failed to load: ', error);
                }}
            />
        );
    }
}