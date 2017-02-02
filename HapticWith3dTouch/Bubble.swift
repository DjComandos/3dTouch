//
//  Bubble.swift
//  HapticWith3dTouch
//
//  Created by Mikita Manko on 2/1/17.
//  Copyright © 2017 Mikita Manko. All rights reserved.
//


import SpriteKit

class Bubble : SKSpriteNode {
    
    private let onPressureMargin: CGFloat = 0.2
    
    private var bubble: SKShapeNode = SKShapeNode(circleOfRadius: 50)
    private var bursted = false
    private var handler: (()->())? = nil
    
    
    init() {
        let texture = SKTexture(imageNamed: "bubble")
        super.init(texture: texture, color: UIColor.lightGray, size: texture.size())
    }
    
    init(texture: SKTexture!) {
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func resize(_ bubbleWidth: CGFloat, bubbleHeight: CGFloat) {
        self.size = CGSize(width: bubbleWidth, height: bubbleHeight)
    }
    
    func setPressure(pressurePercent: CGFloat) {
        if !self.bursted {
            self.setScale(1 + onPressureMargin * pressurePercent)
            
            if (pressurePercent == 1) {
                self.handler?()
                self.bursted = true
                self.texture = SKTexture(imageNamed: "bubbleEmpty")
                self.setScale(1.0)
            }
        }
    }
    
    func isEqualNode(_ node: SKNode) -> Bool {
        return node == self || node == self.bubble
    }
    
    // MARK: Events
    
    func addOnBurstHandler(handler: @escaping ()->()) {
        self.handler = handler
    }
}
