//
//  ViewController.swift
//  ThirdApp_MoveBoxesInSquare
//
//  Created by vibin joby on 2020-01-08.
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

class ViewController: UIViewController {
    @IBOutlet weak var viewLbl: UILabel!
    @IBOutlet weak var viewBox: UIView!
    var timer:Timer?
    var isClockwise = true
    var goToTop = false
    var goToBottom = false
    var goToLeft = false
    var goToRight = true
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.05,
        target: self,
        selector: #selector(moveView),
        userInfo: nil,
        repeats: true)
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func moveView() {
        var xPosition = viewBox.frame.origin.x
        var yPosition = viewBox.frame.origin.y
        
        if isClockwise {
            if xPosition > screenWidth - 55 {
                resetBools()
                goToBottom = true
            }
            if yPosition > screenHeight - 55 {
                resetBools()
                goToLeft = true
            }
            if goToLeft && xPosition < 10 {
                resetBools()
                goToTop = true
            }
            if goToTop && yPosition < 50 {
                resetBools()
                goToBottom = true
                isClockwise = false
                viewBox.backgroundColor = .random
                counter += 1
                viewLbl.text = "\(counter)"
            }
        } else {
            if goToBottom && yPosition > screenHeight - 55 {
                resetBools()
                goToRight = true
            }
            if goToRight && xPosition > screenWidth - 55 {
                resetBools()
                goToTop = true
            }
            if goToTop && yPosition < 50 {
                resetBools()
                goToLeft = true
            }
            if goToLeft && xPosition < 10 {
                resetBools()
                goToRight = true
                isClockwise = true
                viewBox.backgroundColor = .random
                counter += 1
                viewLbl.text = "\(counter)"
            }
        }
        
        if goToBottom {
            yPosition += 10
        } else if goToTop {
            yPosition -= 10
        } else if goToLeft {
            xPosition -= 10
        } else if goToRight {
            xPosition += 10
        }
        
        print("x position \(xPosition)")
        print("y position \(yPosition)")
        
        let width = viewBox.frame.size.width
        let height = viewBox.frame.size.height
        self.viewBox.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        
    }
    func resetBools() {
        goToTop = false
        goToBottom = false
        goToLeft = false
        goToRight = false
    }

}

