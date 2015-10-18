//
//  ViewControllerLogin.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/17/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ViewControllerLogin: UIViewController, UITextFieldDelegate
{
    var user = PFUser()
    
    @IBOutlet var userField: UITextField!
    @IBOutlet var senhaField: UITextField!
    
    @IBOutlet var divLabel: UILabel!
    @IBOutlet var labelBotao: UIButton!
    
    //constraints
    
    @IBOutlet var divTopConstraint: NSLayoutConstraint!
    @IBOutlet var botaoTopConstraint: NSLayoutConstraint!

    @IBAction func VoltarBt(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
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
    
    func isvalidEmail(email:String) -> Bool
    {
        if email == "" || email == " "
        {
            return false
        }
        
        print("validate emilId: \(email)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(email)
        
        return result
    }
    
    @IBAction func digitandoMode(sender: AnyObject)
    {
        if (userField.text != "")
        {
            labelBotao.setAttributedTitle(NSAttributedString(string: "Continuar"), forState: UIControlState.Normal)
            divLabel.text = "________________________"
            divTopConstraint.constant = 3
            botaoTopConstraint.constant = -5
        }
        else 
        {
            labelBotao.setAttributedTitle(NSAttributedString(string: "Login com Facebook"), forState: UIControlState.Normal)
            divLabel.text = "___________ ou ___________"
            divTopConstraint.constant = 14
            botaoTopConstraint.constant = 1
        }
    }
    
    @IBAction func Login(sender: AnyObject)
    {
        if ( userField.text == "") && ( senhaField.text == "")
        {
            alerta("Ops", message: "Preencha os campos obrigatorios", textoBt: "Ok")
        }
        else
        {
            if isvalidEmail(userField.text!) == true //é email
            {
                let 📒 = PFUser.query()
                
                if 📒 != nil
                {
                    📒!.whereKey("email", equalTo:self.userField.text!)
                    
                    📒!.findObjectsInBackgroundWithBlock(
                    { (objects: [PFObject]?, error: NSError?) -> Void in
                        
                        if objects != nil
                        {
                            if let objects:[PFObject] = objects
                            {
                                for object in objects
                                {
                                    //achamos o usuario atraves do email, agora achamos o username p loga-lo!
                                    let 💌:String = (object.objectForKey("username") as? String)!
                                    
                                    //login
                                    PFUser.logInWithUsernameInBackground(💌, password:self.senhaField.text!)
                                    {
                                        (user: PFUser?, error: NSError?) -> Void in
                                            
                                        if user != nil
                                        {
                                            //sucesso
                                            self.performSegueWithIdentifier("login", sender: self) //proxima tela
                                            //self.alerta("LOGADO por email", message: "bem vindo \(💌)", textoBt: "Ok")
                                                
                                        } else
                                        {
                                            if let erro = error?.userInfo["error"] as? String
                                            {
                                                self.alerta("Ops", message: erro, textoBt: "Ok")
                                            }
                                            else
                                            {
                                                self.alerta("Ops", message: "Erro inesperado!", textoBt: "Ok")
                                            }
                                        }
                                    }
                                    
                                    //break
                                }
                            }
                        }
                        else
                        {
                            //nao ha ocorrencias
                        }
                    })
                }
                else
                {
                    alerta("Sem conexao", message: "Sem conexao com a internet, tente novamente mais tarde", textoBt: "Ok")
                }
                
            }
            else//é username ou IDuser
            {
                PFUser.logInWithUsernameInBackground(userField.text!, password:senhaField.text!)
                {
                        (user: PFUser?, error: NSError?) -> Void in
                    
                        if user != nil
                        {
                            //sucesso
                            //self.alerta("LOGADO por iduser", message: "logado com sucesso", textoBt: "Ok")
                            self.performSegueWithIdentifier("login", sender: self) //proxima tela
                            
                        } else
                        {
                            if let erro = error?.userInfo["error"] as? String
                            {
                                self.alerta("Ops", message: erro, textoBt: "Ok")
                            }
                            else
                            {
                                self.alerta("Ops", message: "Erro inesperado!", textoBt: "Ok")
                            }
                        }
                }
            }
        }
    }
 
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool)
    {
//        let currentUser = PFUser.currentUser()
//        
//        if currentUser?.objectId != nil
//        {
//            print("LOGADO em tela login")
//        }
//        else
//        {
//            // MOSTRAR TELA DE LOGIN
//        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
       
        self.view.endEditing(true)//fecha teclado
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        //
        
        return true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
