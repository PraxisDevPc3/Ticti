//
//  ViewControllerRegistro.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ViewControllerRegistro: UIViewController, UITextFieldDelegate
{
    var user = PFUser()
    
    var indicadorAtividade = UIActivityIndicatorView()
    
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
            indicadorAtividade = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            indicadorAtividade.center = self.view.center
            indicadorAtividade.hidesWhenStopped = true
            indicadorAtividade.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            self.view.addSubview(indicadorAtividade)
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            

            user.username = userField.text
            user.password = senhaField.text
            
            //user.email = "email@example.com"
            // other fields can be set just like with PFObject
            //user["phone"] = "415-392-0202"
            
            user.signUpInBackgroundWithBlock(
                {
                    (sucess, error) -> Void in
                    
                    //encerra inidcadorAtividade
                    self.indicadorAtividade.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if let error = error //se existir erro
                    {
                        let errorString = error.userInfo["error"] as? String
                        
                        self.alerta("Ops", message: String(errorString!), textoBt: "Ok")
                    }
                    else
                    {
                        self.alerta("Sucesso!", message: "Cadastro realizado com sucesso!", textoBt: "Uhuu!")
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        //teclado inteligente - parte 1
        self.view.endEditing(true) //forca o fim da edicao
    }
    
    //teclado inteigente  - parte 2
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        userField.resignFirstResponder()
        senhaField.resignFirstResponder()
        
        return true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
