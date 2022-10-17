# Arduino_API_Requests
### This is my attempt at exploring the different API requests to the Arduino IoT Cloud API
I have tried to implement the functionalities using cURL and Node.js, with the main focus being on seamless token authentication and request using the latter. 
API requests through Node.js have been implemented using XMLHttpRequests

### Ignore getToken add
I have also avoided including my getToken function, as it includes my cliend ID and credentials, which I assume would be important. To do this for yourself, you can omit its inclusion to your commit by running the following commands in your terminal.
```
git add -u
git reset --(path to/getToken.js)
```

### Using ```.gitignore``` to manage important JSON files
You need to include a .gitignore in the root of your workspace, containing a list of important files that need to be omitted during the push to a repo. A really informative webpage on [.gitignore](https://www.atlassian.com/git/tutorials/saving-changes/gitignore) explains things clearly. 