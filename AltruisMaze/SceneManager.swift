//
//  GameScene.swift
//  AltruisMaze
//
//  Created by Bomar, Shawn L on 2/23/20.
//  Copyright © 2020 Bomar-Pradhan. All rights reserved.
// Pratigya begins Firebase

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 0.15, green:0.15, blue:0.3, alpha: 1.0)
        
        //Frame Measurements for Positioning
        let refX = self.frame.size.width, refY = self.frame.size.height
        
        //Rotation Button
        let rotateButton = SKSpriteNode(imageNamed: "rotateButton.png")
        rotateButton.position = CGPoint(x: refX/11, y: refY/9)
        rotateButton.name = "rotateButton"
        self.addChild(rotateButton)
        
        //Message Board Button
        //Icon Credit: https://www.pngitem.com/
        let messageButton = SKSpriteNode(imageNamed: "messageButton.png")
        messageButton.position = CGPoint(x: refX - refX/10, y: refY - refY/9)
        messageButton.name = "messageButton"
        self.addChild(messageButton)
        
        //Player Appearance and Orientation
        let currentRoom = view.scene!.name
        let roomDirection = currentRoom?.last //Get last character of current room which is N or S
        var whichTim: String
        if roomDirection == "N" {whichTim = "Tim-NE.png"}
        else {whichTim = "Tim-SW.png"}
        let Player = SKSpriteNode(imageNamed: whichTim)
        Player.position = CGPoint(x: 1118.212, y: 450.682)
        Player.size = CGSize(width: 544.085, height: 485)
        Player.zPosition = 1
        scene?.addChild(Player)
        
        let textFieldFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 30))
        let textField = UITextField(frame: textFieldFrame)
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
        textField.placeholder = "Password?"
        self.view!.addSubview(textField)
        
    }
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {
        
        //Frictionless bounds set up on room
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0
        self.physicsBody = border
        self.lastUpdateTime = 0
        
        
      
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
               
            for node in nodesarray {
                
                let currentRoom = view?.scene!.name
                let roomDirection = currentRoom?.last //Get last character of current room which is N or S
                
                //Rotate Function
                if node.name == "rotateButton" {
                    
                    var nextRoom: String
                    nextRoom = String((currentRoom?.dropLast())!)
                    if( roomDirection == "N"){ //If North, new scene will face South in the same room.
                        nextRoom +=  "S"
                    }
                    else{                       //If South, new scene will face North in the same room.
                        nextRoom += "N"
                    }
                    let secondScene = GameScene(fileNamed: nextRoom)
                    let transition = SKTransition.fade(withDuration: 0.45)
                    secondScene?.scaleMode = .aspectFill
                    scene?.view?.presentScene(secondScene!, transition: transition)
                }
                
                //Door Transition between Room 1 & 2
                else if node.name == "codeDoor-Green"{
                    
                    var secondScene = GameScene(fileNamed: currentRoom!)
                    if currentRoom == "Room 1N" {secondScene = GameScene(fileNamed: "Room 2N")!}
                    else if currentRoom == "Room 2S" {secondScene = GameScene(fileNamed: "Room 1S")!}
                    let transition = SKTransition.fade(withDuration: 0.45)
                    secondScene!.scaleMode = .aspectFill

                    //Check Code
                    var code: Bool = true
                    //if textField.text == "12345" {code = true}
                    if code{scene?.view?.presentScene(secondScene!, transition: transition)}
                }
                
                else if node.name == "keyDoor-Red"{
                    var secondScene = GameScene(fileNamed: currentRoom!)
                    if currentRoom == "Room 1S" {secondScene = GameScene(fileNamed: "Room 3S")!}
                    else if currentRoom == "Room 3N" {secondScene = GameScene(fileNamed: "Room 1N")!}
                    let transition = SKTransition.fade(withDuration: 0.45)
                    secondScene!.scaleMode = .aspectFill
                    scene?.view?.presentScene(secondScene!, transition: transition)
                }
                //redkey taken from iconsdb.com and modified
                else if node.name == "redKey"{
                    node.removeFromParent()
                }
                
                else if node.name == "messageButton"{
                    let messageBoard = MessageBoard(fileNamed : "Message Board")
                    messageBoard!.PreviousRoom = currentRoom!
                    let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.45)
                    messageBoard!.scaleMode = .aspectFill
                    scene?.view?.presentScene(messageBoard!, transition: transition)
                }
            }
        }
    }
}
