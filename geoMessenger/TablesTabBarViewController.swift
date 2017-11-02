//
//  ViewController.swift
//  geoMessenger
//
//  Created by Victoria Leaf on 11/1/17.
//  Copyright © 2017 Victoria Leaf. All rights reserved.
//

import UIKit
class TablesTabBarViewController: UITabBarController {
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.tabBar.barTintColor = UIColor(red:0.20, green:0.50, blue:0.86, alpha:1.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
