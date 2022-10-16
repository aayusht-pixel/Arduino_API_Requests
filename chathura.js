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
            client_id: 'RUhPBAg7Bb2KWCcdPxPtXC0yRbS2mGVB',
            client_secret: 'OasuS2H67guBKKShoj6dWk4NzwcfYtbRZJwVIM1ztyUNHfIS0AIw1z4KCh2oFqiC',
            audience: 'https://api2.arduino.cc/iot'
        }
    };

    try {
        const response = await rp(options);
        return response['access_token'];
    } catch (error) {
        console.error("Failed getting an access token: " + error)
    }
}

async function dash() {
    var client = IotApi.ApiClient.instance;
    // Configure OAuth2 access token for authorization: oauth2
    var oauth2 = client.authentications['oauth2'];
    oauth2.accessToken = await getToken();

    var api = new IotApi.DashboardsV2Api(client)
    var dashboardv2 = {
        "created_by": {
            "user_id": "3d2d11a0-74ba-4b59-9e8b-f263037d6009",
            "username": "liquimech_tester"
        },
        "id": "2deabc26-4232-4a45-9ba7-ce05bea1f9a3",
        "name": "Chathura",
        "widgets": [{
            "has_unlinked_variable": false,
            "height": 6,
            "height_mobile": 4,
            "id": "11111111-2222-3333-4444-555555555555",
            "name": "Switch",
            "options": {
                "icon": "switch",
                "readOnly": false,
                "section": "section-1",
                "showLabels": true
            },
            "type": "Switch",
            "width": 6,
            "width_mobile": 4,
            "x": 0,
            "x_mobile": 0,
            "y": 0,
            "y_mobile": 0
        }]

    }
    // {Dashboardv2} 
    var opts = {
        'xOrganization': "bcae8b6f-83ec-4de6-80d4-0a360a18d32f" // {String} 
    };

    api.dashboardsV2Create(dashboardv2, opts).then(function (data) {
        console.log('API called successfully. Returned data: ' + data);
    }, function (error) {
        console.error(error);
    });
}

dash();