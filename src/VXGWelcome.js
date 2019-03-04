import React, { Component } from 'react';
import { StyleSheet, Text } from 'react-native';

export default class VXGWelcome extends Component {
    render() {
        return (
            <Text style={styles.welcome}>
                Welcome to sample app! {"\n"}
                You can try integrate VXG Mobile SDK {"\n"}
                to ReactNative App. {"\n"}
                Here you find several samples for do it.
            </Text>
        );
    }
}

const styles = StyleSheet.create({
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
        paddingTop: 50,
        paddingBottom: 50,
    },
});