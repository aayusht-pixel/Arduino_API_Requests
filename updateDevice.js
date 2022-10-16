var IotApi = require('@arduino/arduino-iot-client');
var rp = require('request-promise');

async function getToken() {
    var options = {
        method: 'POST',
        url: 'https://api2.arduino.cc/iot/v1/clients/token',
        headers: { 'content-type': 'application/x-www-form-urlencoded' },
        json: true,
        form: {
            grant_type: 'client_credentials',
            client_id: 'rx0ph5orF5cdSfxKuAofB6fJtQAG1j9x',
            client_secret: 'it8b8tyEVU3ANB3xq4nFrO2Py6uQSDSVJfRgR5Sj3LDRxZrf0Mwbu6xM3cy4pa46',
            audience: 'https://api2.arduino.cc/iot'
        }
    };

    try {
        const response = await rp(options);
        return response['access_token'];
    }
    catch (error) {
        console.error("Failed getting an access token: " + error)
    }
}

async function run() {
    var client = IotApi.ApiClient.instance;
    // Configure OAuth2 access token for authorization: oauth2
    var oauth2 = client.authentications['oauth2'];
    oauth2.accessToken = await getToken();

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