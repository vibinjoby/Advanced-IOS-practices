//
//  ViewController.swift
//  MemoryGame
//
//  Created by vibin joby on 2020-01-11.
//  Copyright © 2020 vibin joby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var btnIndexArr = [Int]()
    var totalTime = 0.0
    var firstClickNum :UIImage?
    var secondClickNum :UIImage?
    var firstClickTag = 0
    var secondClickTag = 0
    var score = 0
    var timer:Timer?
    var numbersFoundArr = [UIImage]()
    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var completedTimeLbl: UILabel!
    
    @IBOutlet weak var scoreLbl: UILabel!
    var btnImagesDict = [Int:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeImagesRandomly()
    }
    
    func placeImagesRandomly() {
        var randomNum = 0
        for index in 1...16 {
            let btn:UIButton = view.viewWithTag(index) as! UIButton
            repeat {
                randomNum = Int.random(in: 1...8)
            } while checkForDuplicateImg(randomNum)
            btnImagesDict[index] = "\(randomNum).png"
            btn.setTitle("", for: .normal)
            btnIndexArr.append(randomNum)
        }
    }
    
    @IBAction func onBoxClick(_ sender:UIButton) {
        if timer == nil {
            startTimer()
        }
        let img = UIImage(named:"\(btnImagesDict[sender.tag]!)")
        sender.setBackgroundImage(img,for: .normal)

        if firstClickNum == nil {
            firstClickNum = sender.currentBackgroundImage!
            firstClickTag = sender.tag
        } else if secondClickNum == nil {
            secondClickNum = sender.currentBackgroundImage!
            secondClickTag = sender.tag
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.firstClickNum = nil
                self.secondClickNum = nil
                
                let btn1 = self.view.viewWithTag(self.firstClickTag) as! UIButton
                let btn2 = self.view.viewWithTag(self.secondClickTag) as! UIButton
                
                btn1.setBackgroundImage(UIImage(), for: .normal)
                btn2.setBackgroundImage(UIImage(), for: .normal)
            }
        }
        
        if secondClickNum != nil && !numbersFoundArr.contains(secondClickNum!) {
            if firstClickTag != secondClickTag {
                if firstClickNum == secondClickNum && firstClickNum != nil {
                    numbersFoundArr.append(secondClickNum!)
                    score += 1
                    scoreLbl.text = "Your score is : \(score)"
                }
            }
            if score == 8 {
                completedLbl.text = "Congrats..You Completed this Game"
                completedTimeLbl.text = "Game completed in \(String(describing: Double(round(1000*totalTime)/1000)))"
                stopTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.resetButtonMaze()
                }
                saveData()
            }
        }
        
    }
    
    func checkForDuplicateImg(_ imgNumber:Int) -> Bool{
        var isDuplicateExceeded = false
        let duplicates = Array(Set(btnIndexArr.filter({ (i: Int) in btnIndexArr.filter({ $0 == i }).count > 1})))
        for idx in 0..<duplicates.count {
            if duplicates[idx] == imgNumber {
                isDuplicateExceeded = true
            }
        }
        return isDuplicateExceeded
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            self.totalTime += 0.1
        })
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
        }
    }
    
    func resetButtonMaze() {
        for index in 1...16 {
            let btn:UIButton = view.viewWithTag(index) as! UIButton
            btn.isUserInteractionEnabled = false
            let img = UIImage(named:"\(btnImagesDict[index]!)")
            btn.setBackgroundImage(img,for: .normal)
        }
    }
    
    func saveData() {
        UserDefaults.standard.mutableArrayValue(forKey: "GameTime").add(Double(round(1000*totalTime)/1000))
        loadData()
    }
    
    func loadData() {
        let timeArr = UserDefaults.standard.mutableArrayValue(forKey: "GameTime")
        print(timeArr)
    }


}

