# Arduino_API_Requests
## This is my attempt at exploring the different API requests to the Arduino IoT Cloud API
I have tried to implement the functionalities using cURL and Node.js, with the main focus being on seamless token authentication and request using the latter. 
API requests through Node.js have been implemented using XMLHttpRequests

### Ignore getToken add
I have also avoided including my getToken function, as it includes my cliend ID and credentials, which I assume would be important. To do this for yourself, you can omit its inclusion to your commit by running the following commands in your terminal.
```
git add -u
git reset --(path to/getToken.js)
```