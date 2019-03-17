//
//  ViewController.swift
//  ARKit 2
//
//  Created by nacire on 9/25/18.
//  Copyright © 2018 nacire. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var iPhoneXNode = SCNNode()

    @IBAction func changeScreen(_ sender: Any) {
        performSegue(withIdentifier: "MainToDialog", sender: nil)

    }

    @IBAction func plus(_ sender: Any) {
        let scalePlus = SCNAction.scale(by: 2, duration: 2)
        iPhoneXNode.runAction(scalePlus)

    }

    @IBAction func minus(_ sender: Any) {
        let scaleMinus = SCNAction.scale(by: 0.5, duration: 2)
        iPhoneXNode.runAction(scaleMinus)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainToDialog" {
            let toVC = segue.destination as! Dialog
            toVC.delegate = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) else {return}

        configuration.trackingImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1

        // Run the view's session
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        configuration.isLightEstimationEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate


    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()

        if anchor is ARImageAnchor {

            let plane = SCNPlane(width: 0.7, height: 0.35)
            let deviceScene = SKScene(fileNamed: "DeviceScene")
            let animator = SCNAction.scale(by: 10, duration: 4)

            plane.firstMaterial?.diffuse.contents = deviceScene
            plane.firstMaterial?.isDoubleSided = true
            plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)

            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2

            var iPhoneNode = SCNNode()
            let iPhoneScene = SCNScene(named: "art.scnassets/iPhoneX.scn")!
            iPhoneNode = iPhoneScene.rootNode.childNodes.first!
            iPhoneNode.position = SCNVector3(0, 0, 0.15)
            
            let min = iPhoneNode.boundingBox.min
            let max = iPhoneNode.boundingBox.max
            iPhoneNode.pivot = SCNMatrix4MakeTranslation(min.x + (max.x - min.x)/2, min.y + (max.y - min.y)/2, min.z + (max.z - min.z)/2)
            
            node.addChildNode(planeNode)
            planeNode.addChildNode(iPhoneNode)
            
            iPhoneNode.runAction(rotation())
            iPhoneNode.runAction(animator)
            iPhoneXNode = iPhoneNode
        }
        return node
    }

    func rotation() -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(360)), z: 0, duration: 3)
        let repeatAction = SCNAction.repeatForever(action)
        return repeatAction
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension ViewController: DialogDelegate {
    func screenImageButton(image: UIImage) {
        iPhoneXNode.geometry?.firstMaterial?.diffuse.contents = image
    }
    
  
    
}
