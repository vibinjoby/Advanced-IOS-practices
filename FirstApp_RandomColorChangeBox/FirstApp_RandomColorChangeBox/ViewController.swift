//
//  ViewController.swift
//  FirstApp_RandomColorChangeBox
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
    
    var counter = 0
    var randomArr = [Int]()
    var timer:Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    
    @objc func startCountdown(){
        var randomNum = 0
        if counter == 16 {
            stopTimer()
        } else {
            if randomArr.count > 0 {
                repeat {
                    randomNum = Int(arc4random_uniform(16))
                } while randomArr.contains(randomNum) && randomArr.count < 16 || randomNum == 0
                randomArr.append(randomNum)
            } else {
                randomNum = Int(arc4random_uniform(16))
                randomArr.append(randomNum)
            }
            counter += 1
            let btn: UIButton = view.viewWithTag(randomNum) as! UIButton
            btn.backgroundColor = .random
            btn.setTitle("\(counter)", for: .normal)
        }
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
        target: self,
        selector: #selector(startCountdown),
        userInfo: nil,
        repeats: true)
    }
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
}

