import React, { Component } from 'react';
import { View, Text } from 'react-native';
import { PropTypes } from 'prop-types';
import { NativeModules, requireNativeComponent, findNodeHandle } from 'react-native';

export default class VXGMobileSDK extends Component {
    _root = null;

    constructor(props) {
        super(props)
    }

    open = async () => {
        await NativeModules.VXGMobileSDKManager.open(findNodeHandle(this._root));
    }
    
    close = async () => {
        await NativeModules.VXGMobileSDKManager.close(findNodeHandle(this._root));
    }

    play = async () => {
        await NativeModules.VXGMobileSDKManager.play(findNodeHandle(this._root));
    }

    pause = async () => {
        await NativeModules.VXGMobileSDKManager.pause(findNodeHandle(this._root));
    }

    applyConfig = async (cnf) => {
        await NativeModules.VXGMobileSDKManager.applyConfig(cnf, findNodeHandle(this._root));
    }

    _assignRoot = (rt) => {
        this._root = rt;
    }

    render() {
        return (
            <View style={{backgroundColor: 'black' }}>
                <RCTVXGMobileSDK ref={this._assignRoot} {...this.props}/>
            </View>
        );
    }
}

VXGMobileSDK.propTypes = {
    config: PropTypes.oneOfType([
        PropTypes.shape({
            connectionUrl: PropTypes.string,
            decodingType: PropTypes.number, // HW – 1 //SW – 0
            connectionNetworkProtocol: PropTypes.number,
            numberOfCPUCores: PropTypes.number,
            synchroEnable: PropTypes.number,
            connectionBufferingTime: PropTypes.number,
            connectionDetectionTime: PropTypes.number,
            startPreroll: PropTypes.number,
            aspectRatioMode: PropTypes.number,
            autoplay: PropTypes.boolean,
        }),
    ]),
    close: PropTypes.func,
    open: PropTypes.func,
    applyConfig: PropTypes.func,
    pause: PropTypes.func,
    play: PropTypes.func,
    stop: PropTypes.func,
};

// requireNativeComponent automatically resolves 'RCTVXGMobileSDK' to 'RCTVXGMobileSDKManager'
const RCTVXGMobileSDK = requireNativeComponent('RCTVXGMobileSDK', VXGMobileSDK);
