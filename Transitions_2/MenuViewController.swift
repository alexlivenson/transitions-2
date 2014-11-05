//
//  MenuViewController.swift
//  Transitions_2
//
//  Created by alex livenson on 11/3/14.
//  Copyright (c) 2014 alex.livenson. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var imgAudio: UIImageView!
    @IBOutlet weak var imgChat: UIImageView!
    
    @IBOutlet weak var imgLink: UIImageView!
    @IBOutlet weak var imgCamera: UIImageView!
    
    @IBOutlet weak var imgQuote: UIImageView!
    @IBOutlet weak var imgText: UIImageView!
    
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
