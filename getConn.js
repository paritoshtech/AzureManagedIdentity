const azi = require('@azure/identity');
const pg = require('pg');

async function connectToDB()
{
    const clientId=process.argv[2]
    const creds = new azi.ManagedIdentityCredential(clientId=clientId);

    console.log("clientId ",clientId)

let tokenJson = await creds.getToken("https://ossrdbms-aad.database.windows.net")


console.log("Got the token ",tokenJson.token)



const config = {
    host: 'test-activedirectory.postgres.database.azure.com',
    // Do not hard code your username and password.
    // Consider using Node environment variables.
    user: 'demo@test-activedirectory',     
    password: tokenJson.token,
    database: 'test-ad',
    port: 5432,
    ssl: true
};

const client = new pg.Client(config);

console.log('connecting DB');
await client.connect();
console.log('connected DB');

let resp = await client.query(`SELECT * FROM user_entry`)
console.log(resp.rows)
await client.end();
console.log("Client Disconnected ")
}
connectToDB().then(res=>{
    console.log("function completed")
    return "Success";}).catch(err => {console.error(err);})