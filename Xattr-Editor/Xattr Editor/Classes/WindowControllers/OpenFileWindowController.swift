//
//  OpenFileWindowController.swift
//  Xattr Editor
//
//  Created by Richard Csiko on 2017. 01. 21..
//

import Cocoa

class OpenFileWindowController: NSWindowController {
    @IBOutlet var dragView: DragDestinationView!

    var openCallback: ((_ url: URL) -> Void)? {
        didSet {
            dragView.dropCallback = openCallback
        }
    }
}
