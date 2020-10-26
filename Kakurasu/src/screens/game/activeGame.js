import React, {PureComponent} from 'react';
import {AppRegistry, StyleSheet, StatusBar, Text, View} from 'react-native';
import {Kakurasu} from "kakurasu";

export default class ActiveGame extends PureComponent {
    constructor() {
        super();
        let game = new Kakurasu();
        this.state = {
            game: game
        }
    }

    render() {
        return (
            <View>
                <Text>
                    {this.state.game.print()}
                </Text>
            </View>
        );
    }
}

AppRegistry.registerComponent('ActiveGame', () => ActiveGame);
