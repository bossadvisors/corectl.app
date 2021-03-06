//
//  HelpingFunctions.swift
//  corectl
//
//  Created by Rimantas Mocevicius on 06/07/2016.
//  Copyright © 2016 The New Normal. All rights reserved.
//

import Foundation
import Cocoa

// check if corectl blobs exist
func check_that_corectl_blobs_are_in_place() {
    // Get App's resource folder
    let resoucesPathFromApp = Bundle.main.resourcePath!
    let bin_folder = resoucesPathFromApp + "/bin"

    // check for corectl files in user's home folder
    let filePath1 = NSHomeDirectory() + "/bin/corectl"
    if (FileManager.default.fileExists(atPath: filePath1))
    {
        print("corectl available");
    }
    else
    {
        print("corectl not available");
        runScript("copy_corectl_blobs.command", arguments: bin_folder )
    }
    //
    let filePath2 = NSHomeDirectory() + "/bin/corectld"
    if (FileManager.default.fileExists(atPath: filePath2))
    {
        print("corectld available");
    }
    else
    {
        print("corectld not available");
        runScript("copy_corectl_blobs.command", arguments: bin_folder )
    }
    //
    let filePath3 = NSHomeDirectory() + "/bin/corectld.runner"
    if (FileManager.default.fileExists(atPath: filePath3))
    {
        print("corectld.runner available");
    }
    else
    {
        print("corectld.runner not available");
        runScript("copy_corectl_blobs.command", arguments: bin_folder )
    }
    //
    let filePath4 = NSHomeDirectory() + "/bin/qcow-tool"
    if (FileManager.default.fileExists(atPath: filePath4))
    {
        print("qcow-tool available");
    }
    else
    {
        print("qcow-tool not available");
        runScript("copy_corectl_blobs.command", arguments: bin_folder )
    }
}


// start local docker registry
func startDockerRegistry() {
    let resoucesPathFromApp = Bundle.main.resourcePath!
    runScript("start_docker_registry.command", arguments: resoucesPathFromApp )
}


// Adds the app to the system's list of login items.
// NOTE: This is a relatively janky way of doing this. Using a
// bundled helper app is Apple's recommended approach, but that
// has a lot of configuration overhead to get right.
func addToLoginItems() {
    Process.launchedProcess(
        launchPath: "/usr/bin/osascript",
        arguments: [
            "-e",
            "tell application \"System Events\" to make login item at end with properties {path:\"/Applications/corectl.app\", hidden:false, name:\"Corectl\"}"
        ]
    )
}

// send notification to screen
func notifyUserWithTitle(_ title: String, text: String) {
    let notification: NSUserNotification = NSUserNotification()
    notification.title = title
    notification.informativeText = text
    NSUserNotificationCenter.default.deliver(notification)
}

