//
//  HardwareService.swift
//  HapticWith3dTouch
//
//  Created by Mikita Manko on 2/1/17.
//  Copyright © 2017 Mikita Manko. All rights reserved.
//


import Foundation
import SpriteKit
import AudioToolbox

class HardwareService {

    // Supported by iPhone 7/7+ only.
    private let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    
    // MARK: Force touch.
    
    func is3dTouchAvailable(traitCollection: UITraitCollection) -> Bool {
        return traitCollection.forceTouchCapability == UIForceTouchCapability.available
    }
    
    // MARK: Vibrate.
    
    func initDevice() {
        generator.prepare()
    }
    
    func vibrate() {
        generator.impactOccurred()
        generator.prepare()
    }
    
}

