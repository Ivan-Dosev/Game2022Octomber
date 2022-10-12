//
//  PipeNode.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//


import SpriteKit
import SwiftUI

typealias IsTopPipe = Bool

class PipeNode: SKSpriteNode {
    
    // MARK: - Initializers
    
    init?(textures: (pipe: String, cap: String), of size: CGSize, side: IsTopPipe) {

        guard let img = UIImage(named: textures.pipe) , let tiledCGImage = img.resized(to: size) else {
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>")
            return  nil
            
        }
        let backgroundTexture = SKTexture(image: tiledCGImage)
        let pipe = SKSpriteNode(texture: backgroundTexture)
      
        pipe.zPosition = 1
        
        let cap = SKSpriteNode(imageNamed: textures.cap)
        cap.position = CGPoint(x: 0.0, y: side ? -pipe.size.height / 2 + cap.size.height / 2 : pipe.size.height / 2 - cap.size.height / 2)
        // Make the cap's width a bit wider, so it looks more realistic
        cap.size = CGSize(width: pipe.size.width + pipe.size.width / 6, height: cap.size.height)
        cap.zPosition = 5
        pipe.addChild(cap)
        
        if side {
            let angle: CGFloat = 180.0
            cap.zRotation = angle.toRadians
        }
        
        super.init(texture: backgroundTexture, color: .red, size: backgroundTexture.size())
        
        // Add physics body
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = PhysicsCategories.pipe.rawValue
        physicsBody?.contactTestBitMask =  PhysicsCategories.player.rawValue
        physicsBody?.collisionBitMask = PhysicsCategories.player.rawValue
        physicsBody?.isDynamic = false
        zPosition = 20
        
        self.addChild(pipe)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
