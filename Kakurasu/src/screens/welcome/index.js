import React, {PureComponent} from 'react';
import {AppRegistry, StyleSheet, StatusBar, Text, View} from 'react-native';
import AdBanner from "../../ads/AdBanner";

export default class Welcome extends PureComponent {
    constructor() {
        super();
    }

    render() {
        return (
            <View>
                <Text>
                    {"Hallo"}
                </Text>
                <AdBanner />
            </View>
        );
    }
}

AppRegistry.registerComponent('Welcome', () => Welcome);
