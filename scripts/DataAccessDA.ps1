$da = [System.Data.Odbc.OdbcDataAdapter]::new('select * from gem', 'DSN=gems')
$ds = [System.Data.DataSet]::new()
$da.fill($ds)
$ds.Tables[0] | ft
