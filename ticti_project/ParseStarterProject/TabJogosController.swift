//
//  TabJogosController.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/20/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var controller:TabJogosController!

class TabJogosController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet var tableView_Outlet: UITableView!
    
    var indicadorAtividade = UIActivityIndicatorView()
    
    let categories = ["Top Users", "Jogue agora :D", "Seus favoritos"]
    
    //vars de transporte da tela Exibe
    var gameName:String?
    var gameDescription:String?
    var gameImage:UIImage?
    
    func goToNextController(gameName:String, gameDescription:String, gameImage:UIImage)
    {
        
        self.gameName = gameName
        self.gameDescription = gameDescription
        self.gameImage = gameImage
        
        self.performSegueWithIdentifier("game", sender:self)

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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //exporta o controlador
        controller = self
        
        //retira as linhas de separacao
        tableView_Outlet.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? //set nome de sessoes [TAbleView]
    {

        return categories[section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int //set qtde sessoes [TAbleView]
    {
        return categories.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int//set qtde de celulas por sessao [TAbleView]
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell//set celula [TAbleView]
    {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0
        {
            cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! SecaoTopusers
        }
        else if indexPath.section == 1
        {
            cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
        }
        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier("cell3") as! Favoritos
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 120.0
        }
        
        return 300.0
    }
    
    //segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "game"
        {
            if let vc = segue.destinationViewController as? Exibe
            {
                //passa as infos pra a pagina Exibe
                vc.titulo = self.gameName!
                vc.descricao = self.gameDescription!
                vc.image = self.gameImage!
            }
        }
    }

}
