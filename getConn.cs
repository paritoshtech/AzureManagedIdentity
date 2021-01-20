using System.Data.SqlClient; //v4.8.1

var accessToken = credential.GetToken(new TokenRequestContext(new[] { "https://database.windows.net/.default"})).Token;

using (var sqlConnection = new SqlConnection($"Server=tcp:{_sqlServerName},1433;Database={_sqlDatabaseName}"))
{
    sqlConnection.AccessToken = accessToken
    using (var sqlCommand = new SqlCommand())
    {
        sqlCommand.CommandType = System.Data.CommandType.Text;
        sqlCommand.CommandText = "INSERT INTO dbo.Tests VALUES(@Input)";
        sqlCommand.Parameters.AddWithValue("@Input", File.ReadAllText(_testFilePath));
        sqlCommand.Connection = sqlConnection;

        sqlConnection.Open();
        await sqlCommand.ExecuteNonQueryAsync();
    }
}