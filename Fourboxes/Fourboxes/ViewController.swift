//
//  ViewController.swift
//  Fourboxes
//
//  Created by vibin joby on 2020-01-13.
//  Copyright © 2020 vibin joby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer:Timer?

    @IBOutlet weak var topLeft: UIView!
    @IBOutlet weak var topRight: UIView!
    @IBOutlet weak var bottomLeft: UIView!
    @IBOutlet weak var bottomRight: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        startTimer()
        print("Screen mid \(UIScreen.main.bounds.midX) and \(UIScreen.main.bounds.midY)")
    }
    
    
    @objc func moveBoxes() {
        moveTopLeft()
        moveTopRight()
        moveBottomLeft()
        moveBottomRight()
    }
    
    func moveTopLeft() {
        if topLeft.frame.origin.x <= UIScreen.main.bounds.midX - 20 {
            let xposition = topLeft.frame.origin.x + UIScreen.main.bounds.width / 20
            let yposition = topLeft.frame.origin.y + UIScreen.main.bounds.height / 20
            
            let width = topLeft.frame.width
            let height = topLeft.frame.height
            
            topLeft.frame = CGRect(x: xposition,y:yposition,width: width,height: height)
            print("xposition \(xposition) yposition \(yposition)")
        }
    }
    
    func moveTopRight() {
        print("topRight.frame.origin.x \(topRight.frame.origin.x)")
        print("UIScreen.main.bounds.midX - 20 \(UIScreen.main.bounds.midX - 20)")
        if topRight.frame.origin.x >= UIScreen.main.bounds.midX - 20 {
            let xposition = topRight.frame.origin.x - 20
            let yposition = topLeft.frame.origin.y + UIScreen.main.bounds.height / 20
            
            let width = topRight.frame.width
            let height = topRight.frame.height
            
            topRight.frame = CGRect(x: xposition,y:yposition,width: width,height: height)
            print("xposition \(xposition) yposition \(yposition)")
        }
    }
    
    func moveBottomLeft() {
        
    }
    
    func moveBottomRight() {
        
    }
    
    func initialSetup() {
        let topLeftwidth = topLeft.frame.width
        let topLeftheight = topLeft.frame.height
        
        topLeft.frame = CGRect(x: UIScreen.main.bounds.minX,y:UIScreen.main.bounds.minY,width: topLeftwidth,height: topLeftheight)
        
        let topRightwidth = topRight.frame.width
        let topRightheight = topRight.frame.height
        
        topRight.frame = CGRect(x: UIScreen.main.bounds.maxX - 50,y:UIScreen.main.bounds.minY,width: topRightwidth,height: topRightheight)
        
        print("top Right xposition \(topRight.frame.origin.x) yposition \(topRight.frame.origin.y)")
    }
    
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1,
            target: self,
            selector: #selector(moveBoxes),
            userInfo: nil,
            repeats: true)
        }
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }


}

