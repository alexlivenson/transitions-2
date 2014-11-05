//
//  MainViewController.swift
//  Transitions_2
//
//  Created by alex livenson on 11/3/14.
//  Copyright (c) 2014 alex.livenson. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let transitionManager = TransitionManager()
    let transitionManager2 = TransitionManager_2()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMainView(segue: UIStoryboardSegue) {
        // xcode bug does not unwind after messing around with transperency
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let toVC = segue.destinationViewController as UIViewController
        toVC.transitioningDelegate = self.transitionManager2
    }
    

}
