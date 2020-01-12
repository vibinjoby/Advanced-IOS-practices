//
//  FinalScoreViewController.swift
//  MemoryGame
//
//  Created by vibin joby on 2020-01-11.
//  Copyright © 2020 vibin joby. All rights reserved.
//

import UIKit

class FinalScoreViewController: UITableViewController {
    
    var totalTime = Double()
    var timeArr = UserDefaults.standard.mutableArrayValue(forKey: "GameTime") as NSArray as! [Double]
    override func viewDidLoad() {
        timeArr.sort() { $0 < $1}
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArr.count + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Your Ranking is \(calculateRank())"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Updated Rankings"
        } else {
            cell.textLabel?.text = "\(indexPath.row - 1). \(timeArr[indexPath.row - 2])"
        }
        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")
        
        return cell
    }
    
    func calculateRank() -> Int{
        var userRank = 0
        let userLatestTime = Double(round(1000 * totalTime)/1000)
        var timeArr = UserDefaults.standard.mutableArrayValue(forKey: "GameTime") as NSArray as! [Double]
        timeArr.sort() { $0 < $1}
        if let index = timeArr.firstIndex(where: { $0 > userLatestTime }) {
            userRank = index
            timeArr.insert(userLatestTime, at: index)
        } else {
            userRank = timeArr.count - 1
        }
        return userRank
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
