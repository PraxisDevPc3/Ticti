//
//  TabPerfilController.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/20/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class TabPerfilController: UIViewController {

    @IBAction func logout(sender: AnyObject)
    {
        PFUser.logOut()
        
        print("Logout")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        //apenas vertical
        return UIInterfaceOrientationMask.Portrait
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
