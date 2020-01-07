//
//  ViewController.swift
//  FirstApp_NumberSwap
//
//  Created by vibin joby on 2020-01-06.
//  Copyright © 2020 vibin joby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var counter = 1
    @IBOutlet var lblTxt:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        if counter < 10 {
            lblTxt?.text = "\(String(describing: counter))"
            counter += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.performSegue(withIdentifier: "showSecondView", sender: ViewController.self)
            }
        } else {
            lblTxt?.text = "GAME OVER"
            lblTxt.font = lblTxt.font.withSize(20)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondView" {
            let controller = segue.destination as! SecondaryViewController
            controller.counter = self.counter
        }
    }
}

