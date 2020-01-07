//
//  ViewController.swift
//  ThreadApp
//
//  Created by vibin joby on 2020-01-06.
//  Copyright © 2020 vibin joby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var resultsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView.hidesWhenStopped = true
        // Do any additional setup after loading the view.
    }
    
    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 1)
        return "Hi there"
    }
    func processData(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        let message = "Number of chars: \(String(data).count)"
        return message
    }
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }

    @IBAction func doButton(_ sender: UIButton) {
        let startTime = NSDate()
        self.resultsTextView.text = ""
        spinnerView.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let fetchedData = self.fetchSomethingFromServer()
            let processedData = self.processData(fetchedData)
            let firstResult = self.calculateFirstResult(processedData)
            let secondResult = self.calculateSecondResult(processedData)
            let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
            DispatchQueue.main.async {
                self.resultsTextView.text = resultsSummary
                self.spinnerView.stopAnimating()
            }
            let endTime = NSDate()
            print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
        }
    }
    
}

