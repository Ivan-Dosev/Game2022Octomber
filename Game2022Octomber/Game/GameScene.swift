//
//  GameScene.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//


import SwiftUI
import SpriteKit
import GameplayKit


class Game_Scene : SKScene , SKPhysicsContactDelegate{
    
   // @Binding var PauseButton : Bool
    
  @Binding  var pauseButton : Bool
  @Binding var nameBG : String
  @Binding var score  : Int
  @Binding var reclama : Bool
   var startGame : Bool = Bool()
    
    private(set) var scoreSound = SKAction.playSoundFileNamed("Coin.wav", waitForCompletion: false)
    private(set) var hitSound = SKAction.playSoundFileNamed("Hit_Hurt.wav", waitForCompletion: false)
    
   
    var speedScene = 4.5
  
    
    var infiniteBackgroundNode: InfiniteSpriteScrollNode?
    var birdNode : BirdNode?
    
  //  var playerAnimation = [SKTexture]()
 //   let textureAtlas = SKTextureAtlas(named: "Arda")
  //  var player : SKSpriteNode?
    
    var backgroundSpeed = 2.5
    let maxNumOfTiles = 2
    
    var  bg : SKSpriteNode?
    var pipeWall = SKNode()
    var pipeAction = SKAction()
    
    var lastUpdateTime = TimeInterval(0)
    var sizeScene = CGSize(width: UIScreen.main.bounds.width * 1.5 , height: UIScreen.main.bounds.height )
    
    private(set) lazy var playingAudio: SKAudioNode = {
        let audioNode = SKAudioNode(fileNamed: "POL-flight-master-short.wav")
        audioNode.autoplayLooped = true
        audioNode.name = "playing audio"
        return audioNode
    }()
    
    init(pauseButton : Binding<Bool>, nameBG: Binding<String>, score: Binding<Int>, reclama: Binding<Bool> ) {
    _pauseButton = pauseButton
    _nameBG      = nameBG
    _score       = score
    _reclama     = reclama
 
        super.init(size: CGSize(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5))
        self.scaleMode = .aspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        view.allowsTransparency = true
        self.backgroundColor = .clear
        
        addChild(playingAudio)
        
        prepareWorld(for: self)
     
      let scaleFactor = NodeScale.gameBackgroundScale.getValue()
      infiniteBackgroundNode = InfiniteSpriteScrollNode(fileName: nameBG, scaleFactor: CGPoint(x: scaleFactor, y: scaleFactor))
      infiniteBackgroundNode!.zPosition = 0
  
      addChild(infiniteBackgroundNode!)
        
        birdNode = BirdNode(animationTimeInterval: 0.1, withTextureAtlas : "Arda" ,size: CGSize(width: 100, height: 100) )
        birdNode?.position = CGPoint(x: 100, y: 500)
        birdNode?.setScale(CGFloat(NodeScale.gameBackgroundScale.getValue()) * 0.6)
        addChild(birdNode!)
    
     //   setupPlayer()
        
    }
    
   
        override func update(_ currentTime: TimeInterval) {
            
            let positionBird = birdNode?.position
            if positionBird!.x < 100 {
                birdNode?.position = CGPoint(x: 100, y: positionBird!.y)
            }
        
            if pauseButton {
               
                physicsWorld.gravity = .zero
                birdNode?.physicsBody?.velocity = .zero
              //  playingAudio.isPaused = true
                pipeWall.isPaused = true
                
            }else{
                physicsWorld.gravity = CGVector(dx: 0, dy: -5)
                pipeWall.isPaused = false
             //   playingAudio.isPaused = false
            
                if startGame == false {
                    startGame = true
                    print("true")
              
                    pipeAction = PipeFactory.launch(for: sizeScene, targetNode: pipeWall)
                    pipeWall.run(pipeAction)
                    addChild(pipeWall)
                }
            }
            
                infiniteBackgroundNode?.update(currentTime,deltaBool: pauseButton )

        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //          if  startGame == false {
    //              startGame = true
    //              print("true")
               //   physicsWorld.gravity = CGVector(dx: 0, dy: -150)
            
    //          }else{
                  birdNode?.touchesBegan(touches, with: event)
     //         }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision:UInt32 = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        let player = PhysicsCategories.player.rawValue
        
        if collision == (player | PhysicsCategories.gap.rawValue) {
            score += 1
            print("score = \(score)")
         //   scoreLabel?.text = "Score \(score)"
            
         //   if isSoundOn { scene?.run(scoreSound) }
           scene?.run(scoreSound)
            
          //  notification.notificationOccurred(.success)
        }
        
        if collision == (player | PhysicsCategories.pipe.rawValue) {
            // game over state, the player has touched a pipe
         //   handleDeadState()
          //  if isSoundOn { scene?.run(hitSound) }
       
            reclama = true
            scene?.run(hitSound)
            pipeWall.removeFromParent()

            pauseButton = true
         
        }
        
        if collision == (player | PhysicsCategories.boundary.rawValue) {
            // game over state, the player has touched the boundary of the world (floor or ceiling)
            // player's position needs to be set to the default one
         //   handleDeadState()
         
     
            scene?.run(hitSound)
         //   pauseButton = true
        }
    }
    private func prepareWorld(for scene: SKScene) {
        scene.physicsWorld.gravity = CGVector(dx: 0.0, dy: -5)
        let rect = CGRect(x: 0, y: 0, width: scene.size.width, height: scene.size.height)
        scene.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        
        let boundary: PhysicsCategories = .boundary
        let player: PhysicsCategories = .player
        
        scene.physicsBody?.categoryBitMask = boundary.rawValue
        scene.physicsBody?.collisionBitMask = player.rawValue
        
        scene.physicsWorld.contactDelegate = self
    }

}


