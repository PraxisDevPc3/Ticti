//
//  Exibe.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/22/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class Exibe: UIViewController
{

    var titulo:String = ""
    var descricao = ""
    var image = UIImage()
    
    @IBOutlet var txtLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBAction func voltarBt(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil) //pode chamar o jogo com o ocmpletion
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        txtLabel.text = self.titulo
        descriptionLabel.text = descricao
        imgView.image = image
    }
}
