//
//  ViewController.swift
//  Mewt
//
//  Created by Björn Orri Sæmundsson on 05.05.22.
//

import Cocoa

class ViewController: NSViewController {
    
    let inputController = InputController()
    var keyboardMonitor: KeyboardMonitor!
    
    let debounceDelay = 0.5
    var debounceTimer:Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardMonitor = KeyboardMonitor(onKeyboardActivity: {
            if (!self.inputController.isMuted()) {
                self.inputController.mute()
            }
            
            self.debounceTimer?.invalidate()
            self.debounceTimer = Timer.scheduledTimer(withTimeInterval: self.debounceDelay, repeats: false) { _ in
                self.inputController.unmute()
            }
        })
        keyboardMonitor.startMonitoring()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

