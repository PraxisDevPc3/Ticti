//
//  ViewControllerRegistro.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//
// falta verificar se os emails de input existem, ai colocar spinners qndo for verificar isso
// bloquear para Portaint
// escurecer fundo spinner
// verificar falta de internet

import UIKit
import Parse

class ViewControllerRegistro: UIViewController, UITextFieldDelegate
{
    var user = PFUser()
    
    var indicadorAtividade = UIActivityIndicatorView()
    
    var etapa:Int = 0 /*[0] regsitro face; 
                        [1] submeter email, se ok, e continuar; 
                        [2] submete nome e sobrenome e continuar
                        [3] submete senha, se ok, e continua
                        [4] submete ID, se ok, e continua pro editor de perfil
                        [5] sucesso
                        [6] fracasso*/
    
    @IBOutlet var userField: UITextField!
    @IBOutlet var linhaDiv: UILabel!
    @IBOutlet var singInFace: UIButton!
    @IBOutlet var constraintLinhaDiv: NSLayoutConstraint!
    @IBOutlet var constraintButtonSignUp: NSLayoutConstraint!
    @IBOutlet var topBarNavigation: UINavigationBar!
    
    @IBAction func voltarBotao(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    
    func spinner() -> Void
    {
        indicadorAtividade = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        indicadorAtividade.center = self.view.center
        indicadorAtividade.hidesWhenStopped = true
        indicadorAtividade.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(indicadorAtividade)
        indicadorAtividade.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func spinnerEncerra() -> Void
    {
        //encerra inidcadorAtividade
        self.indicadorAtividade.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
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

    func atualizaRegistro(etapa:Int)//atualiza todo contexto de registro a medida que o usuario vi avancando
    {
        switch etapa
        {
//            case 0:
//                print("case0")
//            
//            case 1:
//                print("case1")
            
            case 2:
                topBarNavigation.topItem?.title = "Qual seu nome?"
                userField.placeholder = "Nome e Sobrenome"
                singInFace.setAttributedTitle(NSAttributedString(string: "Continuar"), forState: .Normal)
                userField.text = ""
                userField.keyboardType = UIKeyboardType.Default
                self.view.endEditing(true) //guarda teclado
            
            case 3:
                topBarNavigation.topItem?.title = "Segurança nunca é demais"
                userField.placeholder = "Senha entre 6 e 8 digitos"
                userField.secureTextEntry = true
                userField.text = ""
                self.view.endEditing(true) //guarda teclado
            
            case 4:
                topBarNavigation.topItem?.title = "Agora o seu ID"
                userField.placeholder = "ID user"
                userField.text = ""
                userField.secureTextEntry = false
                userField.font = UIFont(name: linhaDiv.font!.fontName, size: 15)//de algum modo a fonte mudou quando .secureTextfield foi desligado
                self.view.endEditing(true) //guarda teclado
            
            case 5:
                print("case5")
            
            default://6
                print("caseDefault")
        }
    }
   
    @IBAction func digitandoMode(sender: AnyObject) //atualiza o textField e o botao de submissao de acordo com os eventos
    {
        if etapa < 2 //apenas no inicio do registro isso vai acontecer
        {
            if (userField.text != "")
            {
                singInFace.setAttributedTitle(NSAttributedString(string: "Continuar"), forState: UIControlState.Normal)
                linhaDiv.text = "__________________________"
                constraintLinhaDiv.constant = -2
                constraintButtonSignUp.constant = -6
                
            }
            else
            {
                singInFace.setAttributedTitle(NSAttributedString(string: "Registrar com Facebook"), forState: UIControlState.Normal)
                linhaDiv.text = "___________ ou ___________"
                constraintLinhaDiv.constant = 8
                constraintButtonSignUp.constant = 6
            }

        }
    }
    
    @IBAction func registrarFuncao(sender: AnyObject)//processa as submissoes
    {
        if (etapa == 0 && userField.text == "")
        {
            etapa = 0 //registro face
        }
        else if (etapa == 0 && userField.text != "")
        {
            etapa = 1
        }
        
        switch etapa
        {
            case 0:
                alerta("Face", message: "Solicitacao pelo face", textoBt: "Ok")
            
                //implementar registro face
            
            case 1:
                if !isvalidEmail(userField.text!)
                {
                    alerta("Ops", message: "Ops, E-mail invalido", textoBt: "Ok")
                }
                else
                {
                    user.email = userField.text
                    
                    //user.username = userField.text
                    //user.password = senhaField.text
                    //user["phone"] = "415-392-0202"
                    
                    etapa = 2
                    
                    atualizaRegistro(etapa)
                }

            
            case 2:
                if(userField.text == "" || userField.text == " ")
                {
                    alerta("Ops", message: "Ops, preciso que informe seu nome. :)", textoBt: "Ok")
                }
                else
                {
                    user["nome"] = userField.text
                    etapa = 3
                    
                    atualizaRegistro(etapa)
                }
            
            case 3:
                if( !(userField.text?.characters.count >= 6 && userField.text?.characters.count <= 8) )
                {
                    alerta("Ops", message: "Ops, preciso de uma senha valida entre 6 e 8 digitos", textoBt: "Ok")
                    userField.text = "" //limpa textfield
                }
                else
                {
                    user.password = userField.text
                    
                    etapa = 4
                    
                    atualizaRegistro(etapa)
                }
            
            case 4:
                if(userField.text == "" || userField.text == " ")
                {
                    alerta("Ops", message: "Ops, esse ID já está sendo usado. Crie outro.", textoBt: "Ok")
                }
                else
                {
                    spinner()
                    
                    user.username = userField.text//tem que ser username pq ele barra usersnames repetidos
                    
                    user.signUpInBackgroundWithBlock(
                        {
                            (sucess, error) -> Void in
                            
                            self.spinnerEncerra()
                            
                            if let error = error //se existir erro
                            {
                                let errorString = error.userInfo["error"] as? String
                                
                                self.alerta("Ops", message: String(errorString!), textoBt: "Ok")
                                
                                self.etapa = 6 //Fracasso
                            }
                            else
                            {
                                self.etapa = 5 //sucesso
                                self.performSegueWithIdentifier("login", sender: self) //proxima tela
                            }
                        }
                    )
                    
                }

            default:
                print("fudeu o registro")
        }

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //inicia formulario de cadastro
        userField.placeholder = "email@example.com"

    }
    
    override func viewDidAppear(animated: Bool)
    {
//        let currentUser = PFUser.currentUser()
//        
//        if currentUser?.objectId != nil
//        {
//            print("LOGADO em tela registro")
//        }
//        else
//        {
//            // MOSTRAR TELA DE LOGIN
//        }
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
        
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        //apenas vertical
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
