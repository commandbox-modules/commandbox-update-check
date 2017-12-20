component {
	
	function configure() {
		
		settings = {
			// Turn the entire module on/off
			'enable' : true,
			// Turn the CLI check on/off
			'CLIcheck' : true,
			// Turn the system modules check on/off
			'systemModulesCheck' : true,
			// Follow the CommandBox bleeding edge
			'latest' : false
		};
		
	}
		
	
    function onCLIStart( interceptData ) {
    	
    	// Only run for interactive shell
        if( interceptData.shellType == 'interactive' && isBoolean( settings.enable ) && settings.enable ) {
        	
        	if( isBoolean( settings.CLIcheck ) && settings.CLIcheck ) {
	        	systemOutput( '', true );
	        	systemOutput( 'Checking to see if your CLI version is current...', true );
	            shell.callCommand( 'upgrade' & ( settings.latest ? ' --latest' : '' ) );
        	}
        	
        	if( isBoolean( settings.systemModulesCheck ) && settings.systemModulesCheck ) {	
        		systemOutput( '', true );
	        	systemOutput( 'Checking to see if your system modules are current...', true );	            
	            shell.callCommand( 'outdated --system' );        		
        	}        	
            
        }
        
    }
    
}