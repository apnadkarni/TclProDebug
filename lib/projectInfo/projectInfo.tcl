# projectInfo.tcl --
#
#	The "one" location to update version and copyright information
#	for the complete xmlserver project.
#
# Copyright (c) 1998-2000 by Ajuba Solutions
# Copyright (c) 2017 Forward Folio LLC
#
# See the file "license.terms" for information on usage and redistribution
# of this file, and for a DISCLAIMER OF ALL WARRANTIES.
# 

package provide projectInfo 2.0
namespace eval projectInfo {
    # This is the primary product name


    variable companyName "Tcl Community"
    variable corporateName "Tcl Community"
    variable companyUrl  "http://www.tcl.tk"
    variable productName "TclPro"
    variable usersGuide "$productName User's Guide"

    # Let's get our bearings!

    variable installationDir [file dirname [file dirname [file norm [info script]]]]

    # This variable can be set to output version information.  This
    # will be set by the argument processing code in response to the
    # -version or -help flags that each product should implement.

    variable printCopyright 0

    # Copyright string - printed by all xmlserver apps.
    set year [clock format [clock seconds] -format "%Y"]
    variable copyright \
	    {This is open source software.
See the file "license.terms" for information
on usage and redistribution of this file.
}

    variable fullCopyright \
"TBA"

    # These variables hold the parts of a version string.

    variable major 2
    variable minor 0
    variable type .		;# One of "a", "b", or "."
    variable longType release	;# "alpha", "beta", "release"
    variable patch 0		;# One of 0, 1, ...
    variable shortVers 20

    variable baseVersion ${major}.${minor}
    variable patchLevel ${major}.${minor}${type}${patch}

    # This variable contains the version string that is printed in the
    # banner and may be used in otherplaces.

    variable versString $patchLevel

    # The directory name to propose to the user in the installers.

    if {$type == "."} {
        variable directoryName ${major}.${minor}
    } else {
        variable directoryName ${major}.${minor}${type}${patch}
    }

    # The current version of Acrobat Reader that we are shipping.

    variable acrobatVersion "3.02"

    # This variable holds the version number for the Scriptics License Server

    variable serverVersion $patchLevel

    variable shortTclVers "83"
    variable baseTclVers "8.6"
    variable patchTclVers "8.3.2"

    # This array holds the names of the executable files in each bin dir.

    array set executable {
	tclsh protclsh83
	wish prowish83
	tcldebugger prodebug
	tclchecker procheck
    }

    # This array holds the names of the source directories for each
    # source package that is installed with tclpro.

    array set srcDirs {
	tcl    tcl8.3.2
	tk     tk8.3.2
	itcl   itcl3.2
	tclx   tclx8.3
	expect expect5.32
    }

    # This array holds the version information for each
    # source package that is installed with TclPro.

    array set srcVers {
	tcl    8.3.2
	tk     8.3.2
	itcl   3.2.0
	tclx   8.3.0
	expect 5.32.2
    }

    # This array holds the names of the workspace directories for each
    # source package that is used by tclpro.

    array set localSrcDirs {
	tcl    tcl8.3.2
	tk     tk8.3.2
	itcl   itcl3.2
	tclx   tclx8.3
	expect expect5.32
    }

    # This variable contains the version string that is printed in the
    # banner and may be used in otherplaces.

    variable versString $patchLevel

    # The long version string is only used in the about box for the debugger.
    # It can contain a more readable string (such as "beta 2") and build num.

    variable longVersString "${major}.${minor} ${longType} ${patch}"

    # The preference version.  This is used to find the location of the
    # preferences file (or registry key).  It is different than the
    # application version so that new app version may use old preferences.
    # prefsVersion is the protocol version, prefsLocation becomes part
    # of the path (or key) and is more user visable.

    variable prefsVersion 4
    variable prefsLocation "2.0"

    # Don't forget previous values for prefsLocation so that we can
    # copy forward preferences/keys from older versions.

    variable prefsLocationHistory "2.0 1.5 1.4.1 1.4 1.3 1.2"

    # The root location of the preferences/license file(s).  The default
    # path to the license file is generated using $prefsRoot and
    # $prefsLocation.  We split them up so that we can use different
    # locations if needed (testing licenses, for example)

    variable prefsRoot {}
    if {$::tcl_platform(platform) == "windows"} {
        set prefsRoot "HKEY_CURRENT_USER\\SOFTWARE\\Scriptics\\$productName"
    } else {
        set prefsRoot [file join ~ .$productName]
    }

    # Values that contain various project related file extensions

    variable debuggerProjFileExt ".tpj"
    variable authorProjFileExt ".apj"
    variable docHandlerFileExt ".xdh"

    # This is the product ID that is used, along with the versString
    # to verify the license.  This variable cannot exceed twelve (12)
    # bits, that is a maximum of 4096.  Increment the number and ensure
    # that the no product ID is ever reused.

    #variable productID	2024		;# TclPro 1.1
    #variable productID	2050		;# TclPro 1.2b2
    #variable productID	2051		;# TclPro 1.2, 1.3b1-b4
    #variable productID	2052		;# TclPro 1.3
    #variable productID	3000		;# xmlserver 1.1
    #variable productID	2053		;# TclPro 1.4
    variable productID	2054		;# TclPro 1.4.1

    # Specify the packages for which the .pcx extension files will be sourced.
    # Package names match the file rootnames of the pcx files in the
    # tclchecker source dir.

    variable pcxPkgs [list ]

    # Specify the packages for which the .pdx extension files will be sourced.
    # Package names match the file rootnames of the pdx files in the
    # tcldebugger source dir.

    variable pdxPkgs [list uplevel]

    # Specify the installation directories containing .pcx and .pdx
    # extension files to be sourced by the checker and debugger.

    variable pcxPdxDir [file join $installationDir lib]

    # Specify other directories containing .pcx and .pdx extension
    # files via the following environment variable:
    
    variable pcxPdxVar TCLPRO_LOCAL

    # Store location of help file/url for modules in this product.

    variable helpFile
    array set helpFile [list tcl "" thisProduct ""]

    set docDir [file join $installationDir doc]
    if {$::tcl_platform(platform) == "windows"} {
	# Use the help file if it exists.

	set tmp [file join $docDir help "tcl$shortTclVers.hlp"]
	if {[file exists $tmp]} {
	    set helpFile(tcl) $tmp
	}
    }

    set helpFile(tcl) https://www.tcl.tk/man/tcl8.6/
    
    set tmp [file join $docDir html index.html]
    if {[file exists $tmp]} {
	set helpFile(thisProduct) $tmp
    } else {
	set helpFile(thisProduct) \
		http://www.tcl.tk/software/tclpro/doc/TclProUsersGuide14.pdf
    }

    # By defining these variables the startup sequence will check licenses
    if {0} {
    variable verifyLicense
    if {[info exist tk_version]} {
	set verifyLicense licenseWin::verifyLicense
    } else {
	set verifyLicense projectInfo::verifyLicense
    }
    }
}

# projectInfo::getPreviousPrefslocation --
#
#	This command will find the prefsLocation that was in use
#	before the specified version.
#
# Arguments:
#	curVer	"current" specified version.  If not specified, the
#		actual current version is used.
#
# Results:
#	Returns the prefsLocation that occurred before the specified
#	prefsLocation.  eg. Specifying 1.3 will cause the routine to
#	return 1.2 Returns an empty string if there was no previous
#	prefsLocation or if the "current" preference location could not
#	be found.

proc projectInfo::getPreviousPrefslocation {{curLoc {}}} {
    variable prefsLocation
    variable prefsLocationHistory

    if {[string length $curLoc] == 0} {
	set curLoc $prefsLocation
    }

    set prefIndex [lsearch $prefsLocationHistory $curLoc]

    if {$prefIndex == -1} {
	return {}
    }

    incr prefIndex

    return [lindex $prefsLocationHistory $prefIndex]
}

# projectInfo::printCopyrightOnly --
#
#	This command will print the copyright information to the tty
#	unless the printCopyright variable in this package has been 
#	set to 0.  We may want to rename 'printCopyright' below and
#	have it call this routine at a loater date.
#
# Arguments:
#	name	Product name - which will appear in the copyright line.
#	extra	Extra copyright lines that may be specific to an exe.
#
# Results:
#	None.  Information may be printed to stdout.

proc projectInfo::printCopyrightOnly {name {extra {}}} {
    variable printCopyright
    variable versString
    variable copyright

    if {$printCopyright} {
	puts stdout "$name -- Version $versString"
	puts stdout $copyright

	if {$extra != ""} {
	    puts stdout $extra
	}

	puts stdout {}
    }
}

# projectInfo::printCopyright --
#
#	This command will print the copyright information to the tty
#	unless the printCopyright variable in this package has been 
#	set to 0.  It will also confirm that the user has the correct
#	license to run this product.
#
# Arguments:
#	name	Product name - which will appear in the copyright line.
#	extra	Extra copyright lines that may be specific to an exe.
#
# Results:
#	None.  Information may be printed to stdout.

proc projectInfo::printCopyright {name {extra {}}} {
    variable printCopyright
    variable versString
    variable copyright

    if {$printCopyright} {
	puts stdout "$name -- Version $versString"
	puts stdout $copyright

	if {$extra != ""} {
	    puts stdout $extra
	}
    }
    if {[info exist projectInfo::verifyCommand]} {
	$projectInfo::verifyCommand $name $projectInfo::versString $projectInfo::productID \
		registeredName
    }

    if {$printCopyright && [info exist registeredName]} {
	puts stdout "This product is registered to: $registeredName"
    }
    if {$printCopyright} {
	puts stdout {}
    }
}

