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
    
    var indicadorAtividade:UIActivityIndicatorView?
    
    @IBOutlet var userField: UITextField!
    @IBOutlet var senhaField: UITextField!
    
    func alerta(title:String, message:String, textoBt:String)
    {
        let alerta = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alerta.addAction(UIAlertAction(title: textoBt, style: .Default, handler:
        { (alert) -> Void in
            
            alerta.dismissViewControllerAnimated(true, completion: nil)
        }
        ))
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    @IBAction func registrarFuncao(sender: AnyObject)
    {
        if(userField.text == "" || senhaField.text == "")
        {
            alerta("Ops", message: "Insira corretamente usuário e senha", textoBt: "OK")
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
