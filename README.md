## react-native-vxg-mobile-sdk

Please visit www.videoexpertsgroup.com for any additional questions and support. 

A `<VXGMobileSDK>` component for react-native


## Installation

Using npm:

```shell
npm install --save react-native-vxg-mobile-sdk
```

or using yarn:

```shell
yarn add react-native-vxg-mobile-sdk
```

<details>
  <summary>iOS</summary>

Run `react-native link react-native-vxg-mobile-sdk` to link the library.

Open your project in Xcode and create a link of ffmpeg.framework to Frameworks of main project:

<img src="./docs/img1_ffmpeg_include.png" width="40%">

After that, select the target of your application and select 'General' tab.
Scroll to 'Embedded Binaries' and tap the '+' button:

<img src="./docs/img2_embedded1.png" width="100%">

Select "ffmpeg.framework" from the list:

<img src="./docs/img2_embedded2.png" width="100%">

After that, select 'Build Settings' tab.
Find the option 'Framework Search Path' and double tap on it.
Tap the '+' button in the dialog and enter path to framework:

For emulator:

`$(PROJECT_DIR)/../node_modules/react-native-vxg-mobile-sdk/ios/ffmpeg/universal/`

For appstore:

`$(PROJECT_DIR)/../node_modules/react-native-vxg-mobile-sdk/ios/ffmpeg/appstore/`

<img src="./docs/img3_framework_search_paths.png" width="100%">

</details>

<details>
  <summary>Android</summary>
    TODO
</details>

<details>
  <summary>Windows</summary>
    You can request by email.
</details>

## Usage

```javascript
// Within your render function, assuming you have a file called
import React, { Component } from 'react';
import { StyleSheet, Button, Text, View } from 'react-native';
import { VXGMobileSDK } from 'react-native-vxg-mobile-sdk';

export default class SimplePlayerScreen extends Component {
    _url = null;
    constructor() {
      super();
      this._url = 'rtsp://184.72.239.149/vod/mp4:BigBuckBunny_115k.mov';
    }

    render() {
        return (
            <View style={styles.container}>
                <Text>Example 1: Simple Player</Text>
                <VXGMobileSDK 
                    style={styles.player}
                    config={{"connectionUrl": this._url, "autoplay": true}}></VXGMobileSDK>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        padding: 30,
        marginTop: 65,
        alignItems: "stretch"
    },
    player: {
        paddingTop: 20,
        borderWidth: 1,
        borderColor: 'black',
        width: '100%',
        height: 250,
    },
});
```
