import { StatusBar } from 'expo-status-bar';
import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  TextInput,
  Button,
  TouchableHighlight,
  Image,
  Alert,
  Linking
} from 'react-native';



const CleverTap = require('clevertap-react-native');
CleverTap.setDebugLevel(3);

// if (Platform.OS === 'iOS') {
  CleverTap.registerForPush();
 // }

 CleverTap.initializeInbox();
 CleverTap.createNotificationChannel("1", "1", "CT React Native Testing", 5, true);
 CleverTap.enableDeviceNetworkInfoReporting(true);


 //Foregroung and background
CleverTap.addListener(CleverTap.CleverTapPushNotificationClicked, (event) => {
  alert(JSON.stringify(event));
     _handleCleverTapEvent(CleverTap.CleverTapPushNotificationClicked, event);

 });

 // Listener to handle incoming deep links
 Linking.addEventListener('url', _handleOpenUrl);

 CleverTap.addListener(CleverTap.CleverTapDisplayUnitsLoaded, (res) => {
  CleverTap.recordEvent('jkl')
 
  console.log("RES payload: ",res);

  var displayunit = res.displayUnits[0];
   console.log("displayunit payload: ",displayunit);

  console.log("displayunit WZRK_ID: ",displayunit.wzrk_id);
  // alert(`WZRK_ID: \n ${displayunit.wzrk_id}`);
  //console.log("displayunit payload: ",displayunit);

  //var c_kv = JSON.parse(displayunit.custom_kv.myKey);
  //console.log("CleverTapDisplayUnitsLoaded 1",c_kv.imageUrl);

  // CleverTap.pushDisplayUnitViewedEventForID(displayunit.wzrk_id);
  // CleverTap.pushDisplayUnitClickedEventForID(displayunit.wzrk_id);
 
});

 /// this handles the case where a deep link launches the application
 Linking.getInitialURL().then((url) => {
     if (url) {
         console.log('launch url', url);
         _handleOpenUrl({ url });
     }
 }).catch(err => console.error('launch url error', err));

 // check to see if CleverTap has a launch deep link
 // handles the case where the app is launched from a push notification containing a deep link
 CleverTap.getInitialUrl((err, url) => {
     if (url) {
         console.log('CleverTap launch url', url);
         _handleOpenUrl({ url }, 'CleverTap');
     } else if (err) {
         console.log('CleverTap launch url', err);
     }
 });

 function _handleOpenUrl(event, from) {
  console.log('handleOpenUrl', event.url, from);
  console.log('This is for testing');
}

function _handleCleverTapEvent(eventName, event) {
  console.log('handleCleverTapEvent', eventName, event);
  //ToastAndroid.show(`${eventName} called!`, ToastAndroid.SHORT);
}

export default class LoginView extends Component {

  constructor(props) {
    super(props);
    state = {
      email : '',
      password: '',
      name:'',
      phone_no:'',
      id:''
    }
  }

  onUser_Login = () => {
    alert('User Profile Updated');
  
   
     alert(this.state.email);
     console.log(this.state.email);
   
    //On user Login
    CleverTap.onUserLogin({
        'Name': this.state.name, 
        'Email': this.state.email, 
        'Identity':this.state.id,
        'custom1': 123,
        'birthdate': new Date('1992-12-22T06:35:31'),
        'Phone':this.state.phone_no
    })
    // console.log("Email before calling storage",this.state.email);
    // this.saveUserDataToSharedStorage(this.state.email);
  //SharedGroupPreferences.setItem("email", this.email, appGroupIdentifier);
  //console.log(SharedGroupPreferences.getItem("email", appGroupIdentifier));
    
  }
  onProfile = () => {
  CleverTap.profileSet({"Identity":this.state.phone_no,'Email': this.state.email});
  console.log("Profile Set,",this.state.email);
  }
  get_CTid=()=>{
    CleverTap.getCleverTapID((err, res) => {
      console.log('CleverTapID', res, err);
      alert(`CleverTapID: \n ${res}`);
    });
  //CleverTap.recordEvent('Viewed Clevertap ID');
  CleverTap.recordEvent('Check CTid');
  }

// async saveUserDataToSharedStorage(data) {

//     try {
//       console.log("Email ID from saveUserDataToSharedStorage",data)
//       console.log("Email ID this.state.email",this.state.email)
//       await DefaultPreference.setItem("email", this.state.email, appGroupIdentifier)
//       this.loadUsernameFromSharedStorage()
//     } catch(errorCode) {
//       // errorCode 0 = There is no suite with that name
//       console.log("Saved data error",errorCode)
//     }
//   }
  // async loadUsernameFromSharedStorage() {
  //   try {
  //     const loadedData = await DefaultPreference.getItem("email", appGroupIdentifier)
  //     console.log("This is LoadedData",loadedData)
  //     //this.setState({username:loadedData.name})
  //   } catch(errorCode) {
  //     // errorCode 0 = there is no value for that key
  //     console.log("loaded data ka error code",errorCode)
  //   }
  // }
 

  onClickListener = (viewId) => {
   Alert.alert("Alert", "Button pressed "+viewId);
 }
 
  render() {
    return (

      <View style={styles.container}>
        <View style={styles.inputContainer}>
          <Image style={styles.inputIcon} source={{uri: 'https://png.icons8.com/message/ultraviolet/50/3498db'}}/>
          <TextInput style={styles.inputs}
              placeholder="Name"
              keyboardType="email-address"
              underlineColorAndroid='transparent'
              onChangeText={(text) => this.setState({name:text})}/>
          </View>
        <View style={styles.inputContainer}>
          <Image style={styles.inputIcon} source={{uri: 'https://png.icons8.com/message/ultraviolet/50/3498db'}}/>
          <TextInput style={styles.inputs}
              placeholder="Email"
              keyboardType="email-address"
              underlineColorAndroid='transparent'
              onChangeText={(text) => this.setState({email:text})}/>
          </View>
        <View style={styles.inputContainer}>
          <Image style={styles.inputIcon} source={{uri: 'https://png.icons8.com/key-2/ultraviolet/50/3498db'}}/>
          <TextInput style={styles.inputs}
              placeholder="Password"
              secureTextEntry={true}
              underlineColorAndroid='transparent'
              onChangeText={(text) => this.setState({password: text})}/>
        </View>
        <View style={styles.inputContainer}>
          <Image style={styles.inputIcon} source={{uri: 'https://png.icons8.com/key-2/ultraviolet/50/3498db'}}/>
          <TextInput style={styles.inputs}
              placeholder="Phone Number"
              secureTextEntry={false}
              underlineColorAndroid='transparent'
              onChangeText={(text) => this.setState({phone_no: text})}/>
        </View>
        <View style={styles.inputContainer}>
          <Image style={styles.inputIcon} source={{uri: 'https://png.icons8.com/key-2/ultraviolet/50/3498db'}}/>
          <TextInput style={styles.inputs}
              placeholder="Identity"
              secureTextEntry={false}
              underlineColorAndroid='transparent'
              onChangeText={(text) => this.setState({id: text})}/>
        </View>
        <TouchableHighlight style={[styles.buttonContainer, styles.loginButton]} onPress={() => this.onUser_Login()}>
          <Text style={styles.loginText}>Login</Text>
        </TouchableHighlight>

        <TouchableHighlight style={styles.buttonContainer} onPress={()=>this.onProfile()} >
            <Text>Set Profile?</Text>
        </TouchableHighlight>

        <TouchableHighlight style={styles.buttonContainer} onPress={() => this.get_CTid()}>
            <Text>Get CleverTapID</Text>
        </TouchableHighlight>
      </View>
    );
  }
}


const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#DCDCDC',
  },
  inputContainer: {
      borderBottomColor: '#F5FCFF',
      backgroundColor: '#FFFFFF',
      borderRadius:30,
      borderBottomWidth: 1,
      width:250,
      height:45,
      marginBottom:20,
      flexDirection: 'row',
      alignItems:'center'
  },
  inputs:{
      height:45,
      marginLeft:16,
      borderBottomColor: '#FFFFFF',
      flex:1,
  },
  inputIcon:{
    width:30,
    height:30,
    marginLeft:15,
    justifyContent: 'center'
  },
  buttonContainer: {
    height:45,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom:20,
    width:250,
    borderRadius:30,
  },
  loginButton: {
    backgroundColor: "#00b5ec",
  },
  loginText: {
    color: 'white',
  }
});

// export default function App() {
//   return (
//     <View style={styles.container}>
//       <Text>Open up App.js to start working on your app!</Text>
//       <StatusBar style="auto" />
//     </View>
//   );
// }

// const styles = StyleSheet.create({
//   container: {
//     flex: 1,
//     backgroundColor: '#fff',
//     alignItems: 'center',
//     justifyContent: 'center',
//   },
// });
