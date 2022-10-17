var IotApi = require('@arduino/arduino-iot-client');

// get the access token, from a separate file for security
var tokenGetter = require('./getToken');

async function run() {
    var client = IotApi.ApiClient.instance;
    // Configure OAuth2 access token for authorization: oauth2
    var oauth2 = client.authentications['oauth2'];
    oauth2.accessToken = await tokenGetter.getToken();
    var api = new IotApi.DevicesV2Api()
    var id = 'ea726baa-f244-495a-b70d-b779be76268f'; // {String} The id of the device
    var devicev2 = {
        name: 'Aayush',
        serial: '4321',
        type: 'login_and_secretkey_wifi',
        fqbn: 'esp8266:esp8266:generic'
    }; // {Devicev2} 
    api.devicesV2Update(id, devicev2).then(function (data) {
        console.log('API called successfully. Returned data: ' + data);
    }, function (error) {
        console.error(error);
    });
}

run();