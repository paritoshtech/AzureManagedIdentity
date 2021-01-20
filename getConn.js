const azi = require('@azure/identity');
var creds = new azi.ManagedIdentityCredential();
var tokenP = creds.getToken('https://vault.azure.net')