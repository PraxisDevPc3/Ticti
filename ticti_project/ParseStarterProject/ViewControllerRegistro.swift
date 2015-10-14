//
//  ViewControllerRegistro.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ViewControllerRegistro: UIViewController
{
    var user = PFUser()
    
    @IBOutlet var userField: UITextField!
    @IBOutlet var senhaField: UITextField!
    
    @IBAction func registrarFuncao(sender: AnyObject)
    {
        if(userField == "" || senhaField == "")
        {
            
        }
        else
        {
            user.username = userField.text
            user.password = senhaField.text
            
            //user.email = "email@example.com"
            // other fields can be set just like with PFObject
            //user["phone"] = "415-392-0202"
            
            user.signUpInBackgroundWithBlock(
                {
                    (sucess, error) -> Void in
                    
                    if let error = error //se existir erro
                    {
                        let errorString = error.userInfo["error"] as? String
                        
                        print(errorString)
                    }
                    else
                    {
                        print("cadastro feito com sucesso!")
                    }
                }
            )
            
        }
    }
    @IBAction func registrarComFacebook(sender: AnyObject)
    {
        //falta implementar
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
