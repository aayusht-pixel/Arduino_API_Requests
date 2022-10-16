var IotApi = require('@arduino/arduino-iot-client');
var rp = require('request-promise');
var XMLHttpRequest = require('xhr2'); // required to make Http Requests through Node

// generate main access token
async function getToken() {
    var options = {
        method: 'POST',
        url: 'https://api2.arduino.cc/iot/v1/clients/token',
        headers: { 'content-type': 'application/x-www-form-urlencoded' },
        json: true,
        form: {
            grant_type: 'client_credentials',
            client_id: 'xuHsCQjWyf9xFcCYZzAyVK5IpdKWybh6',
            client_secret: 'qYTFecGjt3ds3kvyTn0mtwiaTG9TH0SkxKPq3igyP62gqcFldnabWl48Hz4ctLef',
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

async function dashboard() {
    var client = IotApi.ApiClient.instance;
    // Configure OAuth2 access token for authorization: oauth2
    var oauth2 = client.authentications['oauth2'];
    oauth2.accessToken = await getToken();

    var dashboardv2 = '{"name": "Yutama_manual_v2"}' // {Dashboardv2} payload

    var xhr = new XMLHttpRequest();
    xhr.open("POST", 'https://api2.arduino.cc/iot/v2/dashboards'); // method to be used in the URL

    xhr.setRequestHeader("Accept", "application/json"); // accept data in JSON 
    xhr.setRequestHeader("Authorization", "Bearer " + oauth2.accessToken); // add Bearer access token from getToken()
    xhr.setRequestHeader("Content-Type", "application/json"); // set payload content type as JSON 

    // functiont to display stage change of XMLHttpRequest client
    xhr.onreadystatechange = function () {
        // check if the state an XMLHttpRequest client is in the DONE(==4) stage
        if (xhr.readyState === 4) { 
            console.log(xhr.status); // display status
            console.log(xhr.responseText); // display response text
        }
    };

    xhr.send(dashboardv2); // send Http Request 

}

dashboard();