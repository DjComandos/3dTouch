//
//  GameScene.swift
//  HapticWith3dTouch
//
//  Created by Mikita Manko on 2/1/17.
//  Copyright © 2017 Mikita Manko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private let bubbleRadius: CGFloat = 100
    private let hardwareService = HardwareService()
    
    private var bubble : Bubble?
    private var is3dTouchEnabled = false
    
    
    override func didMove(to view: SKView) {
        self.scene?.backgroundColor = UIColor(red:0.12, green:0.35, blue:0.43, alpha:1.0)
        
        hardwareService.initDevice()
        if(hardwareService.is3dTouchAvailable(traitCollection: self.view!.traitCollection)) {
            is3dTouchEnabled = true
        }
        
        createBubble()
    }
    

    // MARK: Factory methods for the bubble.
    
    private func createBubble() {
        bubble = Bubble()
        bubble?.position = CGPoint(x: frame.midX, y: frame.midY)
        bubble?.resize(bubbleRadius, bubbleHeight: bubbleRadius)
        bubble?.addOnBurstHandler(handler: self.onBurstHandler)
        self.addChild(bubble!)
    }
    
    func reCreateBubble() {
        bubble?.removeFromParent()
        createBubble()
    }
    
    // MARK: Handlers
    
    func onBurstHandler() {
        // boom!!!
        hardwareService.vibrate()
        
        // reload bubble in a while.
        Timer.scheduledTimer(timeInterval: 2.0, target: self,
                             selector: #selector(reCreateBubble), userInfo: nil, repeats: false)
    }
    
    
    // MARK: Touch event handlers
    
    func touchDown(touch: UITouch, atPoint pos : CGPoint) {
        // Nothing happens here.
    }
    
    func touchMoved(touch: UITouch, toPoint pos: CGPoint) {
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        if let bubble = bubble {
            if bubble.isEqualNode(node) {
                if is3dTouchEnabled {
                    bubble.setPressure(pressurePercent: touch.force / touch.maximumPossibleForce)
                } else {
                    // It is important to use touchMoved for iPhones w/o 3dTouch,
                    // So we can "emulate" it.
                    bubble.setPressure(pressurePercent: 1)
                }
            }
        }
    }
    
    func touchUp(touch: UITouch, atPoint pos : CGPoint) {
        
    }
    
    // MARK: Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(touch: t, atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(touch: t, toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(touch: t, atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(touch: t, atPoint: t.location(in: self)) }
    }
}
