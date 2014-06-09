<cfscript>
	reportPath = ExpandPath( "/results" );

	try {
		testbox = new testbox.system.testing.TestBox( reporter="text", options={}, directory={
			recurse = true,
			mapping = "tests.tests",
			filter  = function( required path ){ return true; }
		} );

		plainTextResult = testbox.run();
		resultObject    = testbox.getResult();
		errors          = resultObject.getTotalFail() + resultObject.getTotalError();

		FileWrite( reportpath & "/testbox.properties", errors ? "testbox.failed=true" : "testbox.passed=true" );
		FileWrite( reportPath & "/output.txt", plainTextResult );
		content reset=true;Writeoutput( Trim( plainTextResult ) );
	} catch ( any e ) {
		plainTextResult = "An error occurred running the test suite. Message: #e.message#. Detail: #e.detail#. Serialized: #SerializeJson( e )#";

		FileWrite( reportpath & "/testbox.properties", "testbox.failed=true" );
		FileWrite( reportPath & "/output.txt", plainTextResult );
		content reset=true;Writeoutput( Trim( plainTextResult ) );
	}
</cfscript>