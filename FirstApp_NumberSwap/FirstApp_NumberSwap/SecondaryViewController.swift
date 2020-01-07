//
//  SecondViewController.swift
//  FirstApp_NumberSwap
//
//  Created by vibin joby on 2020-01-06.
//  Copyright © 2020 vibin joby. All rights reserved.
//

import UIKit
class SecondaryViewController: UIViewController {
    @IBOutlet var lblTxt:UILabel!
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        if counter <= 10 {
            self.lblTxt?.text = "\(self.counter)"
            counter += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.performSegue(withIdentifier: "showFirstSegue", sender: SecondaryViewController.self)
            }
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
        if segue.identifier == "showFirstSegue" {
            let controller = segue.destination as! ViewController
            controller.counter = self.counter
        }
    }
}
