//
//  InputController.swift
//  Mewt
//
//  Created by Björn Orri Sæmundsson on 05.05.22.
//

import Foundation
import AudioToolbox

class InputController {
    
    private var muted = false
    
    private var defaultInputDevice: AudioDeviceID {
        var inputDeviceID = kAudioObjectUnknown
        
        var propertyAddress = AudioObjectPropertyAddress(mSelector: kAudioHardwarePropertyDefaultInputDevice, mScope: kAudioObjectPropertyScopeGlobal, mElement: kAudioObjectPropertyElementMain)
        if (!AudioObjectHasProperty(AudioObjectID(kAudioObjectSystemObject), &propertyAddress)) {
            print("Cannot find default input device!")
            return inputDeviceID
        }
        var propertySize = UInt32(MemoryLayout<AudioObjectID>.stride)
        let status = AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &propertyAddress, 0, nil, &propertySize, &inputDeviceID)
        if (status != 0) {
            print("Cannot find default input device!")
        }
        return inputDeviceID
    }
    
    public func mute() {
        setMuted(true)
    }
    
    public func unmute() {
        setMuted(false)
    }
    
    public func isMuted() -> Bool {
        return muted
    }
    
    private func setMuted(_ muted: Bool) {
        var mute: UInt32 = muted ? 1 : 0
        var propertyAddress = AudioObjectPropertyAddress(mSelector: kAudioDevicePropertyMute, mScope: kAudioDevicePropertyScopeInput, mElement: kAudioObjectPropertyElementMain)

        let propertySize = UInt32(MemoryLayout<UInt32>.stride)
        AudioObjectSetPropertyData(defaultInputDevice, &propertyAddress, 0, nil, propertySize, &mute)
        self.muted = muted
    }
}
