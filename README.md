ibm-devOps-services
===================

This project includes files needed to execute Kiuwan static analysis from IBM DevOps Services (beta integration).

Follow these instructions to configure your DevOps Services Project to analyze your project's source code with Kiuwan.

1. Create a new project in DevOps Services.
2. In 'BUILD & DEPLOY' view, create a new stage or click on the gear icon in the 'Pipeline' to configure the build stage.
2. Type the stage name.
3. Select 'Shell Script' builder.
4. Select your branch.
5. Type the 'Build archive directory' with path relative to the Build script location.
6. In Build script copy the next code snippet:

		#!/bin/bash
		#Invoke commands to build the project artifacts (i.e. mvn clean package)
		{replace with your build command or commands}
		
		#Set parameters for Kiuwan Local Analyzer
		export KIUWAN_SOURCE_CODE_DIRECTORY="{source directory}"
		export KIUWAN_APPLICATION_NAME="{application name}"
		export KIUWAN_ANALYSIS_LABEL="`date`"
		export KIUWAN_USER="{username of your Kiuwan account}"
		export KIUWAN_PASSWORD="{password of your Kiuwan account}"
		export KIUWAN_TECHNOLOGIES_TO_ANALYZE="{comma separated list of technologies to analyze}"
		export KIUWAN_INCLUDE_PATTERNS=""
		export KIUWAN_EXCLUDE_PATTERNS="**/src/test/**,**/__MACOSX/**,**/*.min.js,**/*.Designer.vb,**/*Reference.vb,**/*Service.vb,**/*Silverlight.vb,**/*.Designer.cs,**/*Reference.cs,**/*Service.cs,**/*Silverlight.cs"
		
		#Retrieve and execute the analysis with Kiuwan Local Analyzer
		curl -L https://raw.githubusercontent.com/kiuwan/ibm-devOps-services/master/scripts/kiuwan.sh | bash

	<sub><sup>\* Replace the fragments enclosed in curly braces with your configuration.</sup></sub> 

7. Configure the remaining options if needed and click 'Save'.
8. Launch a build and check the results.

#####SOME NOTES
* In **KIUWAN_SOURCE_CODE_DIRECTORY** you **MUST** assign a path relative to the Build script location.
* In **KIUWAN_TECHNOLOGIES_TO_ANALYZE** assign a list of technologies that your source codes are composed. i\.e\. If you have \.java files and \.js files put **java,javascript**
* In **KIUWAN_INCLUDE_PATTERNS** and **KIUWAN_EXCLUDE_PATTERNS** values you must write:

   A comma-separated [Ant-style](http://ant.apache.org/manual/dirtasks.html#patterns) patterns for including or excluding source code files.

   Ant patterns use \* and ? as wildcard \(\*\* corresponds to multiple directories).
   Examples:

      To exclude all java test files with name ending with "Test", use
      **/*Test.java
      as exclude pattern.
      To exclude all auto-generated source files in directories named "generated", use
      **/generated/**
      as exclude pattern.

   Rules are:

      If excludes provided, any input file matching one of the patterns will be ignored.
      If includes provided and no exclude pattern rejected the file, to be accepted as input file it must match at least one include pattern.
      If excludes provided but no explicit includes, any input file not rejected by one exclude pattern will be accepted.
      If includes provided with no explicit excludes, input file will be accepted only when matches at least one include pattern.
      If both explicit includes and excludes, excludes are checked before includes; a file will be accepted if does not match any exclude pattern but matches at least one include pattern.

#####EXAMPLE
Imagine that we have a maven project with java and javascript source codes.
Now, open stage configuration page in DevOps Services. Then,
* In 'Build archive directory' field we assign 'target', because maven generates the artifacts there.
* And, in 'Build script' field we put this script:

		#!/bin/bash
		#Invoke commands to build the project artifacts
		mvn package
		
		#Set parameters for Kiuwan Local Analyzer
		export KIUWAN_SOURCE_CODE_DIRECTORY="src"
		export KIUWAN_APPLICATION_NAME="My application"
		export KIUWAN_ANALYSIS_LABEL="`date`"
		export KIUWAN_USER="MykiuwanUsername"
		export KIUWAN_PASSWORD="MyKiuwanPassword"
		export KIUWAN_TECHNOLOGIES_TO_ANALYZE="java,javascript"
		export KIUWAN_INCLUDE_PATTERNS=""
		export KIUWAN_EXCLUDE_PATTERNS="**/src/test/**,**/__MACOSX/**,**/*.min.js,**/*.Designer.vb,**/*Reference.vb,**/*Service.vb,**/*Silverlight.vb,**/*.Designer.cs,**/*Reference.cs,**/*Service.cs,**/*Silverlight.cs"
		
		#Retrieve and execute the analysis with Kiuwan Local Analyzer
		curl -L https://raw.githubusercontent.com/kiuwan/ibm-devOps-services/master/scripts/kiuwan.sh | bash
		
We put 'mvn package', in the third line to build the artifacts. 
In KIUWAN_SOURCE_CODE_DIRECTORY we have assigned the value 'src' to indicate the location of the source codes.
And in KIUWAN_TECHNOLOGIES_TO_ANALYZE we put 'java,javascript' separated by comma to analyze those technologies. 
 
