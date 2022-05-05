//
//  KeyboardMonitor.swift
//  Mewt
//
//  Created by Björn Orri Sæmundsson on 05.05.22.
//

import Foundation
import AppKit

class KeyboardMonitor {
    
    let onKeyboardActivity: () -> Void
    
    init(onKeyboardActivity: @escaping () -> Void) {
        self.onKeyboardActivity = onKeyboardActivity
    }
    
    func startMonitoring() {
        NSEvent.addGlobalMonitorForEvents(matching: [NSEvent.EventTypeMask.keyDown, NSEvent.EventTypeMask.keyUp], handler: { (event: NSEvent) in
            self.onKeyboardActivity()
        })
        NSEvent.addGlobalMonitorForEvents(matching: NSEvent.EventTypeMask.flagsChanged, handler: { (event: NSEvent) in
            self.onKeyboardActivity()
        })
        NSEvent.addLocalMonitorForEvents(matching: [NSEvent.EventTypeMask.keyDown, NSEvent.EventTypeMask.keyUp], handler: { (event: NSEvent) in
            self.onKeyboardActivity()
            return event
        })
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.flagsChanged, handler: { (event: NSEvent) in
            self.onKeyboardActivity()
            return event
        })
    }
}
