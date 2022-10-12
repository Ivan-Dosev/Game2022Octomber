//
//  ScroollNode.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//


import Foundation
import UIKit
import SpriteKit
import SwiftUI

class InfiniteSpriteScrollNode: SKNode {
    


    
    // MARK: - Constants
    
    let key = "bg"
    
    // MARK: - Properties
    
    var tiles: [SKNode]
    var background: SKNode
    var backgroundSpeed: TimeInterval
    
    let maxNumOfTiles = 2
    
    internal var delta = TimeInterval(0)
    internal var lastUpdateTime = TimeInterval(0)
    
    // MARK: - Initailziers
    
    init(fileName: String, scaleFactor scale: CGPoint = CGPoint(x: 1.0, y: 1.0), speed: TimeInterval = 100) {
        self.backgroundSpeed = speed
                 
        let yShift: CGFloat = 5.0
        
        tiles = [SKSpriteNode]()
        background = SKNode()
        let texture = SKTexture(imageNamed: fileName)
        let width = texture.size().width
        
        
        for x in 0...maxNumOfTiles {
            let tile = SKSpriteNode(texture: texture)
            tile.xScale = scale.x
            tile.yScale = scale.y
            tile.anchorPoint = .zero

            tile.position = CGPoint(x: CGFloat(x) * width * scale.x, y: yShift)
            tile.name = key
            tile.zPosition = 0
            background.addChild(tile)
        }
        
        super.init()
        
        background.enumerateChildNodes(withName: key) { [weak self] node, pointer in
            self?.tiles += [node]
        }
        
        self.addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    fileprivate func moveBackground() {
        let posX = -backgroundSpeed * delta
        background.position = CGPoint(x: background.position.x + CGFloat(posX), y: 0.0)
        
        let maxTiles = CGFloat(maxNumOfTiles)
        
        background.enumerateChildNodes(withName: key) { [weak self] node, stop in
            if let unwrappedSelf = self {
                let background_screen_position = unwrappedSelf.background.convert(node.position, to: unwrappedSelf)
                
                if background_screen_position.x <= -node.frame.size.width {
                    node.position = CGPoint(x: node.position.x + (node.frame.size.width * maxTiles), y: node.position.y)
                }
            } else {
                debugPrint(#function + " could not unwrap self, current enumeration iteration will be skipped")
                
            }
        }
    }
}

// MARK: - Extension that adds support for Updatable protocol
extension InfiniteSpriteScrollNode: Updatable {
    
    // MARK: - Conformance to the Updtable protocol

    func update(_ currentTime: TimeInterval, deltaBool : Bool) {

        if !deltaBool {
            let computedUpdatable = computeUpdatable(currentTime: currentTime)
            delta = computedUpdatable.delta
            lastUpdateTime = computedUpdatable.lastUpdateTime
            moveBackground()
        }else {
            let computedUpdatable = computeUpdatable(currentTime: currentTime)
            delta = computedUpdatable.delta
            lastUpdateTime = computedUpdatable.lastUpdateTime
        }
          

       
    }
}


enum NodeScale: Float {
    case gameBackgroundScale
}

extension NodeScale {
    
    func getValue() -> Float {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        
        switch self {
        case .gameBackgroundScale:
            return isPad ? 1.5 : 1.35
        }
    }
}

extension CGPoint {
    init(x: Float, y: Float) {
        self.init()
        self.x = CGFloat(x)
        self.y = CGFloat(y)
    }
}


protocol Updatable: AnyObject {
    
    // MARK: - Properties
    
    var delta: TimeInterval { get }
    var lastUpdateTime: TimeInterval { get }
   // var shouldUpdate: Bool { get set }
    
    // MARK: - Methods
    
    func update(_ currentTime: TimeInterval, deltaBool : Bool)
}


extension Updatable {
    
    /// Ensures that frame updates happen with the same time interval between each frame
    ///
    /// - Parameter currentTime: you need to pass here the current time (TimeInterval) from the scene update method
    /// - Returns: is a tuple containing computed delta and lastUpdateTime properties that need to be set to the protocol properties
    func computeUpdatable(currentTime: TimeInterval) -> (delta: TimeInterval, lastUpdateTime: TimeInterval) {
        let delta = (self.lastUpdateTime == 0.0) ? 0.0 : currentTime - self.lastUpdateTime
        let lastUpdateTime = currentTime

        return (delta: delta, lastUpdateTime: lastUpdateTime)
    }
}
struct PhysicsCategories : OptionSet {
    let rawValue : UInt32
    
    static let boundary     = PhysicsCategories(rawValue: 1 << 0)
    static let player       = PhysicsCategories(rawValue: 1 << 1)
    static let pipe         = PhysicsCategories(rawValue: 1 << 2)
    static let gap          = PhysicsCategories(rawValue: 1 << 3)
}


extension UIImage {
    
    func resized (to size : CGSize) -> UIImage? {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
