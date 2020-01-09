//
//  ViewController.swift
//  SecondApp_UserInteractionRandomColorBox
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
    var selectedBtnArr = [Int]()
    var randomArr = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            // Select Logic
            counter += 1
            sender.backgroundColor = .random
            sender.setTitle("\(counter)", for: .normal)
            selectedBtnArr.append(sender.tag)
        } else {
            // Deselect logic
            let deselectedBtn = view.viewWithTag(sender.tag) as! UIButton
            let deselectedNumber = Int(deselectedBtn.titleLabel!.text!)!
            deselectedBtn.backgroundColor = UIColor.white
            deselectedBtn.setTitle("", for: .normal)
            if Int(deselectedBtn.titleLabel!.text!)! != counter {
                for number in deselectedNumber...counter {
                    let btnTag = getButtonTagFromTitleNumber(number: number)
                    let btn = view.viewWithTag(btnTag) as! UIButton
                    if Int((btn.titleLabel?.text)!)! != 0 && btn != deselectedBtn{
                        btn.setTitle("\(Int((btn.titleLabel?.text)!)! - 1)", for: .normal)
                    }
                }
            }
            while let index = selectedBtnArr.firstIndex(of:sender.tag) {
                selectedBtnArr.remove(at: index)
            }
            counter -= 1
        }
    }
    
    func getButtonTagFromTitleNumber(number:Int) -> Int{
        for btnTag in selectedBtnArr {
            let btn = view.viewWithTag(btnTag) as! UIButton
            let selectedTagTitle = Int(btn.titleLabel!.text!)!
            if selectedTagTitle == number {
                return btnTag
            }
        }
        return 0
    }
}

