//
//  LoadingBoxesView.swift
//  LoadingBoxesSceneKit
//
//  Created by Jose Luis Piedrahita on 06/01/16.
//  Copyright © 2016 Parallel Mobile. All rights reserved.
//

import SceneKit

class LoadingBoxesView: SCNView {

    override func awakeFromNib() {
        
        self.scene = SCNScene()
        self.scene?.rootNode.addChildNode(sceneNode())
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.usesOrthographicProjection = true
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 5)
        cameraNode.rotation = SCNVector4Make(1, 0, 0, -Float(M_PI_4))
        self.pointOfView = cameraNode
        
        self.antialiasingMode = .Multisampling2X
        self.autoenablesDefaultLighting = true
        self.allowsCameraControl = true
        self.showsStatistics = true
    }
    
    private func sceneNode() -> SCNNode {
        let sceneNode = SCNNode()
        
        let animationSpeed = 3.0
        let boxAnimationKey = "anim"
        
        // 4 boxes
        let numberOfBoxes = 4
        for boxIndex in 0 ..< numberOfBoxes {
            let boxNode = SCNNode(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0))
            boxNode.addAnimation(boxAnimation(duration: animationSpeed, timeOffset: animationSpeed / Double(numberOfBoxes) * Double(boxIndex)), forKey: boxAnimationKey)
            sceneNode.addChildNode(boxNode)
        }
        
        return sceneNode
    }
    
    private func boxAnimation(duration duration: CFTimeInterval, timeOffset: CFTimeInterval) -> CAAnimation {
        
        let boxAnimation = CAKeyframeAnimation(keyPath: "position")
        boxAnimation.repeatCount = Float.infinity
        boxAnimation.timeOffset = timeOffset
        boxAnimation.duration = duration
        
        boxAnimation.values = [
            NSValue(SCNVector3:SCNVector3(0, 0, 0)),
            NSValue(SCNVector3:SCNVector3(-1, 0, 0)),
            NSValue(SCNVector3:SCNVector3(-1, 1, 0)),
            NSValue(SCNVector3:SCNVector3(0, 1, 0)),
            NSValue(SCNVector3:SCNVector3(0, 1, 0)),
            NSValue(SCNVector3:SCNVector3(1, 1, 0)),
            NSValue(SCNVector3:SCNVector3(1, 0, 0)),
            NSValue(SCNVector3:SCNVector3(0, 0, 0)),
            NSValue(SCNVector3:SCNVector3(0, 0, 0))
        ]
        
        return boxAnimation
    }

}
