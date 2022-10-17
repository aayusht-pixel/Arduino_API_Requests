var IotApi = require('@arduino/arduino-iot-client');
var XMLHttpRequest = require('xhr2'); // required to make Http Requests through Node

var payloadProperty = JSON.stringify(require('./createPropertiesPayload3.json')); // include dashboard upadate in a JSON file
// console.log(payloadDashboard); // display the payload in raw JSON format, for testing 

// get the access token, from a separate file for security
var tokenGetter = require('./getToken');

// make PUT request to create properties for a thing
async function myHttpRequest(myUrl, myMethod, myToken) {
    var xhr = new XMLHttpRequest();
    xhr.open(myMethod, myUrl); // method to be used in the URL
    xhr.setRequestHeader("Accept", "application/json"); // accept data in JSON 
    xhr.setRequestHeader("Authorization", "Bearer " + myToken); // add Bearer access token from getToken()
    xhr.setRequestHeader("Content-Type", "application/json"); // set payload content type as JSON 
    // function to display stage change of XMLHttpRequest client
    xhr.onreadystatechange = function () {
        // check if the state an XMLHttpRequest client is in the DONE(==4) stage
        if (xhr.readyState === 4) {
            console.log(xhr.status); // display status
            console.log(xhr.responseText); // display response text
        }
    };
    xhr.send(payloadProperty); // send Http Request
}

async function run() {
    var client = IotApi.ApiClient.instance;
    // Configure OAuth2 access token for authorization: oauth2
    var oauth2 = client.authentications['oauth2'];
    oauth2.accessToken = await tokenGetter.getToken();
    var url = 'https://api2.arduino.cc/iot/v2/things/7ea1ea47-9ca5-4805-94eb-8185d489ac1a/properties'; // URL of target thing to create properties for
    var targetMethod = 'PUT'; // method to be used in the URL
    myHttpRequest(url, targetMethod, oauth2.accessToken);
}

run();