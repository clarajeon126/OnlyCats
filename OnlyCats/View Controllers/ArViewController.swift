//
//  ArViewController.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/20/21.
//

import UIKit
import SceneKit
import ARKit

class ArViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    var catName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = false
        
        
        
        let scene = SCNScene()
        sceneView.scene = scene

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let result = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = result.last else {
            return
        }
        let hitTransform = SCNMatrix4.init(hitResult.worldTransform)
        let hitVector = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        print(hitVector)
        createCat(position: hitVector)
        
    }
    
    func createCat(position: SCNVector3){
        var catNode = collada2SCNNode(filepath: "art.scnassets/\(catName)model/\(catName).dae")

        catNode.position = position
        
        print("here")
        sceneView.scene.rootNode.addChildNode(catNode)
    }
    
    func collada2SCNNode(filepath:String) -> SCNNode {
        var node = SCNNode()
        let scene = SCNScene(named: filepath)
        var nodeArray = scene!.rootNode.childNodes

        for childNode in nodeArray {
            node.addChildNode(childNode as SCNNode)
        }
        return node
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
