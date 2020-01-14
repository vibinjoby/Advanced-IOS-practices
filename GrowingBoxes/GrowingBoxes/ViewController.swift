//
//  ViewController.swift
//  GrowingBoxes
//
//  Created by vibin joby on 2020-01-13.
//  Copyright © 2020 vibin joby. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

extension CGRect {
    var center: CGPoint { return CGPoint(x: midX , y: midY ) }
}

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var viewBox: UIView!
    
    @IBOutlet weak var lblTxt: UILabel!
    var timer_1s:Timer?
    var timer_1m:Timer?
    var counter = 0
    let screenWidth = UIScreen.main.bounds.width
    var grow = true
    var incrNum = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBox.center.x = UIScreen.main.bounds.midX
        viewBox.center.y = UIScreen.main.bounds.midY
        
        lblTxt.center.x = UIScreen.main.bounds.midX
        lblTxt.center.y = UIScreen.main.bounds.midY
        
        startTimer()
    }
    
    @objc func growingBoxes() {
        let xPosition = viewBox.frame.origin.x
        let yPosition = viewBox.frame.origin.y
        
        let width  = viewBox.frame.size.width
        let height  = viewBox.frame.size.height
        if counter != 0 {
            lblTxt.text = "\(counter)"
        }
        
        if viewBox.frame.size.width < 50 {
            grow = true
            counter += 1
        }
        
        if viewBox.frame.size.width < screenWidth && grow{
            print("mid x of view box \(viewBox.frame.midX)")
            print("mid y of view box \(viewBox.frame.midY)")
            
            print("mid x of UISCREEN box \(UIScreen.main.bounds.midX)")
            print("mid y of UISCREEN box \(UIScreen.main.bounds.midY)")
            
            viewBox.frame = CGRect(x: xPosition, y: yPosition, width:  width + CGFloat(incrNum), height: height + CGFloat(incrNum))
        } else {
            grow = false
            viewBox.frame = CGRect(x: xPosition, y: yPosition, width:  width - CGFloat(incrNum), height: height - CGFloat(incrNum))
        }
        viewBox.center.x = UIScreen.main.bounds.midX
        viewBox.center.y = UIScreen.main.bounds.midY
        
    }
    
    func changeColor() {
        viewBox.backgroundColor = .random
    }
    
    func startTimer() {
        if timer_1s == nil {
            timer_1s = Timer.scheduledTimer(timeInterval: 0.1,
            target: self,
            selector: #selector(growingBoxes),
            userInfo: nil,
            repeats: true)
        }
        if timer_1m == nil {
            timer_1m = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                self.changeColor()
            })
        }
    }
    
    func stopTimer() {
        if timer_1m != nil {
            timer_1m?.invalidate()
            timer_1m = nil
        }
        if timer_1s != nil {
            timer_1s?.invalidate()
            timer_1s = nil
        }
    }

    @IBAction func onSliderChange(_ slider: UISlider) {
        if timer_1s != nil {
            incrNum = Int(slider.value)
        }
    }
    
}

