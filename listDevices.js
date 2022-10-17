var IotApi = require('@arduino/arduino-iot-client');

// get the access token, from a separate file for security
var tokenGetter = require('./getToken');

async function run() {
    var client = IotApi.ApiClient.instance;
    // Configure OAuth2 access token for authorization: oauth2
    var oauth2 = client.authentications['oauth2'];
    oauth2.accessToken = await tokenGetter.getToken();
    var api = new IotApi.DevicesV2Api(client)
    api.devicesV2List().then(devices => {
        console.log(devices);
    }, error => {
        console.log(error)
    });
}

run();