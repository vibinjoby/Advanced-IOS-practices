//
//  ViewController.swift
//  SecondApp_ShiftingBlocks
//
//  Created by vibin joby on 2020-01-06.
//  Copyright © 2020 vibin joby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewBox: UIView!
    var timer:Timer?
    var goToTop = false
    var goToBottom = true
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func btnUp() {
        var xPosition = viewBox.frame.origin.x
        var yPosition = viewBox.frame.origin.y
        
        if goToBottom {
            yPosition += 20
        } else if goToTop {
            yPosition -= 20
        }
        
        if yPosition > screenHeight {
            xPosition = generateRandomXCordinate()
            yPosition = screenHeight - 70
            goToTop = true
            goToBottom = false
        } else if yPosition < 0 {
            xPosition = generateRandomXCordinate()
            yPosition +=  70
            goToTop = false
            goToBottom = true
        }

        let width = viewBox.frame.size.width
        let height = viewBox.frame.size.height

        UIView.animate(withDuration: 1.0, animations: {
            self.viewBox.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        })
    }
    
    func generateRandomXCordinate() -> CGFloat{
        let randomInt = Int.random(in: 1..<Int(screenWidth - 30))
        return CGFloat(randomInt)
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.3,
        target: self,
        selector: #selector(btnUp),
        userInfo: nil,
        repeats: true)
    }
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if timer != nil {
            stopTimer()
        } else {
            startTimer()
        }
    }


}

