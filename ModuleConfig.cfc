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
    	
   		var cr = chr( 10 );
	        		
	    try {

	    	// Only run for interactive shell
	        if( interceptData.shellType == 'interactive' && isBoolean( settings.enable ) && settings.enable ) {
	    
	    		// Abort if there is a dateLastChecked setting, it's a date, and it's within the last day
	    		if( !isNull( settings.dateLastChecked ) && isDate( settings.dateLastChecked ) && dateDiff( 'd', settings.dateLastChecked, now() ) < 1 ) {
	    			return;
	    		}   

				if( wirebox.getInstance( 'configService' ).getSetting( 'offlineMode', false ) ) {
		        	shell.printString( 'CommandBox is in offline mode, skipping update checks.' & cr  );
					return;	
				}
					        	
	        	if( isBoolean( settings.CLIcheck ) && settings.CLIcheck ) {
		        	shell.printString( cr );
		        	shell.printString( 'Checking to see if your CLI version is current...' & cr );
		            shell.callCommand( 'upgrade' & ( settings.latest ? ' --latest' : '' ) );
	        	}
	        	
	        	if( isBoolean( settings.systemModulesCheck ) && settings.systemModulesCheck ) {	
	        		shell.printString(  cr );
		        	shell.printString( 'Checking to see if your system modules are current...' & cr );	            
		            shell.printString( 
		            	wirebox.getInstance( name='commandDSL', initArguments={ name : 'outdated' } )
			            	.flags( 'system', 'hideUpToDate' )
			            	.run( returnOutput=true )
			       	);
	        	}        	
	            
	            
	            configService = wirebox.getInstance( 'configService' );
				var configSettings = ConfigService.getconfigSettings();
				configSettings[ 'modules' ][ 'commandbox-update-check' ][ 'dateLastChecked' ] = now(); 
				configService.setConfigSettings( configSettings );
		
	        }

        } catch ( any e ) {

        	shell.printString( 'Ouch! I was not able to check for updates for some reason. Make sure you are connected to the internet.' & cr  );
        	shell.printString( e.message & cr  );
        	shell.printString( cr );

        }
        
    }
    
}
