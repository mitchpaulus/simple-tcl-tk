#!/usr/bin/env tclsh
package require Tk

# Function to browse for a directory
proc browseDir {} {
    global dirPath
    set dirPath [tk_chooseDirectory]
    .dirLabel configure -text $dirPath
}

# Function to write .msg files to emails.txt in the selected directory
proc writeFiles {} {
    global dirPath
    if {$dirPath eq ""} {
        tk_messageBox -message "No directory selected."
        return
    }
    set fileList [glob -nocomplain -directory $dirPath *.msg]
    set fileOut [open "${dirPath}/emails.txt" w]

    foreach file $fileList {
        puts $fileOut [file tail $file]
    }
    close $fileOut
    tk_messageBox -message "Files have been written to emails.txt in the selected directory."
}

# Create the main window
wm title . "Directory Browser"
set dirPath ""

# Add a label, directory path label, and buttons
label .dirPrompt -text "Choose a Directory: "
label .dirLabel -text "No directory selected" -relief ridge -width 100
button .browseButton -text "Browse" -command browseDir
button .writeButton -text "Write .msg Files to emails.txt" -command writeFiles

# Arrange the widgets
pack .dirPrompt -side top -fill x
pack .dirLabel -side top -fill x
pack .browseButton -side left -padx 10 -pady 10
pack .writeButton -side left -padx 10 -pady 10

# Run the event loop
tkwait window .
