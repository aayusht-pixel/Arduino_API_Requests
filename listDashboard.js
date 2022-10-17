var IotApi = require('@arduino/arduino-iot-client'); // require the Arduino IoT API client
var XMLHttpRequest = require('xhr2'); // required to make Http Requests through Node

// get the access token, from a separate file for security
var tokenGetter = require('./getToken');

// make GET request to list dashboards
async function myHttpRequest(myUrl, myMethod, myToken) {
    var xhr = new XMLHttpRequest();
    xhr.open(myMethod, myUrl); // create request for target url
    xhr.setRequestHeader("Accept", "application/json"); // accept data in JSON 
    xhr.setRequestHeader("Authorization", "Bearer " + myToken); // add Bearer access token from getToken()
    xhr.setRequestHeader("Content-Type", "application/json"); // set payload content type as JSON 
    xhr.setRequestHeader("X-PrettyPrint", "1"); // request the output to be made pretty 
    // function to display stage change of XMLHttpRequest client
    xhr.onreadystatechange = function () {
        // check if the state an XMLHttpRequest client is in the DONE(==4) stage
        if (xhr.readyState === 4) {
            console.log(xhr.status); // display status
            console.log(xhr.responseText); // display response text
        }
    };
    xhr.onload = () => {
        const data = JSON.parse(xhr.responseText);  // method to convert the string returned by responseText to a JSON object
        console.log(data);  // log response
    };
    xhr.send(); // send Http Request and print output in user-friendly format
}

async function run() {
    var client = IotApi.ApiClient.instance;
    // Configure OAuth2 access token for authorization: oauth2
    var oauth2 = client.authentications['oauth2'];
    oauth2.accessToken = await tokenGetter.getToken();
    var url = 'https://api2.arduino.cc/iot/v2/dashboards'; // URL of target thing to show list of dashboards
    var targetMethod = 'GET'; // method to be used in the URL
    myHttpRequest(url, targetMethod, oauth2.accessToken);
}

run();