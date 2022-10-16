var ArduinoIotClient = require('@arduino/arduino-iot-client');
var rp = require('request-promise');
var XMLHttpRequest = require('xhr2');

async function getToken() {
    var options = {
        method: 'POST',
        url: 'https://api2.arduino.cc/iot/v1/clients/token',
        headers: { 'content-type': 'application/x-www-form-urlencoded' },
        json: true,
        form: {
            grant_type: 'client_credentials',
            client_id: '11BPBTVoGudlcJ8408X6HpTLYXGyEuJ1',
            client_secret: 'XJJ1N3B1BpggeI5qSpF3K3t6kYSa482Ry2lNe7ofcA0o71hTpIqgh1Nn883IHnIs',
            audience: 'https://api2.arduino.cc/iot'
        }
    };
    try {
        const response = await rp(options);
        console.log("Access token: " + response['access_token']);
        return response['access_token'];
    }
    catch (error) {
        console.error("Failed getting an access token: " + error)
    }
}

async function run() {
    var client = ArduinoIotClient.ApiClient.instance;
    var oauth2 = client.authentications['oauth2'];
    oauth2.accessToken = await getToken();

    var properties = '{"name": "random_value","permission": "READ_WRITE","type": "POWER","update_strategy": "ON_CHANGE"}'; //payload
    var xhr = new XMLHttpRequest();
    xhr.open("PUT", 'https://api2.arduino.cc/iot/v2/things/0c3ddb84-086d-45ba-b9ec-9443378438c2/properties'); // method to be used in the URL
    xhr.setRequestHeader("Accept", "application/json"); // accept data in JSON
    xhr.setRequestHeader("Authorization", "Bearer " + oauth2.accessToken); // add Bearer access token from getToken()
    xhr.setRequestHeader("Content-Type", "application/json"); // set payload content type as JSON

    // function to display stage change of XMLHttpRequest client
    xhr.onreadystatechange = function () {
        // check if the state an XMLHttpRequest client is in the DONE(==4) stage
        if (xhr.readyState === 4) {
            console.log(xhr.status); // display status
            console.log(xhr.responseText); // display response text
        }
    };
    xhr.send(properties); // send Http Request
}

run();