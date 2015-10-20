//
//  PerfilViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/19/15.
//  Copyright © 2015 Parse. All rights reserved.
//
//bt de apagar fotos
//bt de submeter ou pular
//cortar a imagem ao mesmo tempo que o user seleciona a parte q ele quer

import UIKit
import Parse

class PerfilViewController: UIViewController, UINavigationControllerDelegate  //navegar entre apps e voltar
                                            , UIImagePickerControllerDelegate //camera ou biblioteca
{

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var sexoSControl: UISegmentedControl!
    
    let maxFileSize = 250*1024
    
    @IBAction func atualizaFoto(sender: AnyObject)
    {
        actionSheet("O que fazer agora?", message: "Escolha procurar fotos na biblioteca ou tirar uma agora")
    }
    
    @IBAction func submit(sender: AnyObject)
    {
        //verifica tamanho
        var comp:CGFloat = 0.5
        let maxCompression:CGFloat = 0.1
        
        var imageData = UIImageJPEGRepresentation(userImage.image!, comp)
        
        while (imageData!.length > maxFileSize) && (comp > maxCompression)
        {
            comp -= 0.1
            
            imageData = UIImageJPEGRepresentation(userImage.image!, comp)
        }
        
        //envia
        let post = PFUser.currentUser()
        
        let imageFile = PFFile(name: "imageUserProfile.jpeg", data: imageData!)
        
        post!["foto"] = imageFile
        post!["sexo"] = Bool(sexoSControl.selectedSegmentIndex)
        
        post!.saveInBackgroundWithBlock
            { (success, error) -> Void in
                
                if error == nil
                {
                    self.performSegueWithIdentifier("principal", sender: self)
                    
                } else
                {
                    print("--- ERRO ---")
                    
                    let errrro = error!.userInfo["error"] as? String
                    
                    print(errrro)
                    
                }
                
        }
    }
    
    func actionSheet(title:String, message:String)
    {
        let alerta = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        
       //opcoes
        
        let biblioteca = UIAlertAction(title: "Procurar por fotos", style: UIAlertActionStyle.Default)
        { (alert) -> Void in
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = true
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        let foto = UIAlertAction(title: "Tirar foto", style: UIAlertActionStyle.Default)
        { (alert) -> Void in
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.allowsEditing = true
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel)
            { (alert) -> Void in
                
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alerta.addAction(biblioteca)
        alerta.addAction(foto)
        alerta.addAction(cancel)
        
        //exibe
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) //assim q pega a imagem
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //pegou um imagem
        userImage.image = image
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.userImage.image = UIImage(named:"UserCircle.png")
        
        //aspecto arredondado e borda
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        self.userImage.layer.borderWidth = 3.0
        self.userImage.clipsToBounds = true
        self.userImage.layer.borderColor = UIColor.grayColor().CGColor
        
        if PFUser.currentUser()?.objectId != nil
        {
            print("user esta logado")
        }
    }

    override func didReceiveMemoryWarning()
    {
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
