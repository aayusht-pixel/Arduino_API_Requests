# Arduino_API_Requests
This is my attempt at exploring the different API requests to the Arduino IoT Cloud API
I have tried to implement the functionalities using Node.js, with the main focus being on seamless token authentication and request. 
API requests through Node.js have been implemented using XMLHttpRequests. 
The basic flow of making API requests can be listed below: 
- Request the access token using your ```client_id``` and ```client_credentials```.
- Authenticate a targeted function using a header by including the access token as a bearer.

### Installing the XMLHttpRequest module
XMLHttpRequest is a built-in object in web browsers, and not included in Node. A third-party implementation for using XMLHttpRequest is ```xhr2```.
You can install it with npm.
```cpp
npm install xhr2
```
And then require it in your code.
```node
var XMLHttpRequest = require('xhr2');
var xhr = new XMLHttpRequest();
```


### Include your own ```getToken``` function
I have avoided including my ```getToken``` (shown in the official Arduino IoT Cloud documentation) function, as it includes my ```client_id``` and ```client_credentials```, which is unique to my Arduino Cloud account profile. To do this for yourself, you can omit its inclusion to your commit by running the following commands in your terminal.
```cpp
git add -u
git reset -- getToken.js
```
Alternatively, you can separate this function into a separate it into another file, and import it as a function, increasing code modularity and security.
```node
var rp = require('request-promise');

// function for main access token 
async function getToken() {
    var options = {
        method: 'POST',
        url: 'https://api2.arduino.cc/iot/v1/clients/token',
        headers: {
            'content-type': 'application/x-www-form-urlencoded'
        },
        json: true,
        form: {
            grant_type: 'client_credentials',
            client_id: 'YOUR_CLIENT_ID',
            client_secret: 'YOUR_CLIENT_CREDENTIALS',
            audience: 'https://api2.arduino.cc/iot'
        }
    };
    try {
        const response = await rp(options);
        return response['access_token']; // return the access token
    }
    catch (error) { 
        console.error("Failed getting an access token: " + error)
    }
}

module.exports = { getToken };  // makes getToken() accessible to any file that imports getToken.js
```

### Important information while making update requests on dashboards
When sending a dashboardUpdate request, we must include information on ALL of the widgets of a dashboard, even if some don't need to be updated, because our request OVERWRITES the contents of an existing dashboard.
Implementing this solution above results in our code file becoming cluttered with extraneous information, so I recommend importing any kind of payload from an external JSON file. This gives us greater freedom in formatting as well as removing clutter.
You can include this line in your cod. 
```node
var payload = JSON.stringify(require('path to/payload.JSON')); // include payload in a JSON file
```

### Using ```.gitignore``` to manage important JSON files
You may wish to include a .gitignore in the root of your workspace, containing a list of important files that need to be omitted during the push to a repo. A really informative webpage on [.gitignore](https://www.atlassian.com/git/tutorials/saving-changes/gitignore) explains things clearly. 
