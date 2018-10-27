//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Mac on 7/30/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var trayUp: CGPoint!
     var trayDown: CGPoint!
     var newCreatedFace: UIImageView!
     var faceCreatedCenter: CGPoint!
    var frame: CGRect!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//self.trayOriginalCenter =
        // Do any additional setup after loading the view.
        //pinchGestureRecognizer.delegate = self
        trayCenterWhenOpen = self.trayView.center
        trayCenterWhenClosed = CGPoint(x: self.trayView.center.x, y: self.trayView.center.y + 160)
//        var frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        var blueView = UIView(frame: frame)
//        blueView.backgroundColor = UIColor.blue
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let position = sender.location(in: trayView)
        //let velocity = sender.velocity(in: trayView)
        //let translation = sender.translation(in: trayView)
        
        if sender.state == .began {
            print("Gesture began at: \(position)")
            trayOriginalCenter = self.trayView.center
        } else if sender.state == .changed {
            print("Gesture changed at: \(position)")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + sender.translation(in: trayView).y)
            
        } else if sender.state == .ended {
            print("Gesture ended at: \(position)")
            if sender.velocity(in: trayView).y > 0 { // moving down
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                    self.trayView.center = self.trayCenterWhenClosed
                }, completion: nil)
                
            } else { // moving up
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                    self.trayView.center = self.trayCenterWhenOpen
                }, completion: nil)
            }
        }
    
}
    
    
    @IBAction func onTapTray(_ sender: UITapGestureRecognizer) {
        if trayView.center.y == trayCenterWhenOpen.y {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                self.trayView.center = self.trayCenterWhenClosed
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                self.trayView.center = self.trayCenterWhenOpen
            }, completion: nil)
        }
}
    
    //The new view
    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            faceCreatedCenter = sender.view?.center
            let imageView = sender.view as! UIImageView
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            // Create a new image view that has the same image as the one currently panning
            newCreatedFace = UIImageView(image: imageView.image)
            newCreatedFace.frame.size = CGSize(width: 100.0, height: 100.0)
            //imageView.image = UIImage(named: "smiley_face")
            newCreatedFace.isUserInteractionEnabled = true
            newCreatedFace.addGestureRecognizer(panGesture)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newCreatedFace)
            
            // Initialize the position of the new face.
            newCreatedFace.center = imageView.center
            newCreatedFace.center.y += trayView.frame.origin.y
        } else if sender.state == .changed {
            newCreatedFace.center = CGPoint(x: faceCreatedCenter.x + sender.translation(in: newCreatedFace).x, y: 347 + faceCreatedCenter.y + sender.translation(in: newCreatedFace).y)
            
        } else if sender.state == .ended {
            
        }
    }

    var originalCenter = CGPoint()

    @objc func didPan(sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            originalCenter = (sender.view?.center)!
            print("Gesture began")
            sender.view?.transform = CGAffineTransform(scaleX: 2, y: 2)
        } else if sender.state == .changed {
            print("Gesture is changing")
            sender.view?.center = CGPoint(x: (originalCenter.x) + sender.translation(in: sender.view).x, y: (originalCenter.y) + sender.translation(in: sender.view).y)
            print("x: \(sender.translation(in: sender.view).x)")
            print("y: \(sender.translation(in: sender.view).y)")
        } else if sender.state == .ended {
            print("Gesture ended")
            sender.view?.transform = CGAffineTransform.identity
        }
    }
}
