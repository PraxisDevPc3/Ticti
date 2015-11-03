//
//  CategoryRow.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/21/15.
//  Copyright © 2015 Parse. All rights reserved.
//
import UIKit
import Parse

var qtdeDeJogos = Int()

class CategoryRow : UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet var ColecView: UICollectionView!
    
    var vetorDeObjetos:Array<PFObject>!
    var vetorImagens:Array<UIImage>!

    func Load()
    {
        ColecView.backgroundColor = UIColor.clearColor()
        ColecView.showsHorizontalScrollIndicator = false
        ColecView.showsVerticalScrollIndicator = false
   
    }
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        //essa funcao demora
        
        let query = PFQuery(className:"Jogos")
        
        query.findObjectsInBackgroundWithBlock
            { (objects, error) -> Void in
                
                if error != nil
                {
                    let erro_string = error!.userInfo["error"] as! String
                    
                    print("Nao achou o numero de jogos - erro: \(erro_string)")
                    
                    qtdeDeJogos = 0
                    
                }
                else
                {
                    self.vetorDeObjetos = objects
                    
                    let objectsImages = objects! as [PFObject]
                    
                    qtdeDeJogos = Int( objects!.count )
                    
                    for obj:PFObject in objectsImages
                    {
                        let img = obj["imagem"] as! PFFile
                        
                        img.getDataInBackgroundWithBlock(
                        {
                            (imageData, error) -> Void in
                            
                            if (error == nil)
                            {
                                if let image = UIImage(data: imageData! as NSData)
                                {
                                    self.vetorImagens.append(image)
                                }
                                else
                                {
                                    print("Deu errado")
                                    print(img.description)
                                }
                                
                            }
                        })
                    
                    }
                
                }
            }
        
        Load()
        
    }
   
//UICollectionViewDataSource

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int//set qtde de itens por sessoes [CollectionView]
    {
//        let n = numDeJogos()
//        
//        if n > 0
//        {
//            return numDeJogos()
//            
//        }else
//        {
//            return 0
//        }
        
        print("aqui esta o valor = \(qtdeDeJogos)")
        
        //return qtdeDeJogos
        
        return 4
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell //set celula [CollectionView]
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("videoCell", forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
//        query.findObjectsInBackgroundWithBlock
//        { (objects, error) -> Void in
//                
//                if error != nil
//                {
//                    let erro_string = error!.userInfo["error"] as! String
//                    
//                    print("Nao achou jogos - erro: \(erro_string)")
//                    
//                    self.num = 0
//                }
//                else
//                {
//                    
//                    controller.goToNextController(objects![indexPath.row].objectForKey("nome") as! String,  gameDescription: objects![indexPath.row].objectForKey("descricao") as! String,
//                        gameImage: UIImage(named:"steveJobs")!)
//                }
//                
//        }

        
        //controller.goToNextController("TicTac", gameDescription: "Joguinho da Velha bla bla bla bla", gameImage: UIImage(named:"steveJobs")!)
        
        controller.goToNextController(
            vetorDeObjetos![indexPath.row].objectForKey("nome") as! String,
            gameDescription: vetorDeObjetos![indexPath.row].objectForKey("descricao") as! String,
            gameImage: UIImage(named: "steveJobs")! //vetorImagens[indexPath.row]
        )
    }
    


//UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize //set das celulas [CollectionView]
    {
        var itemsPerRow:CGFloat
        var hardCodedPadding:CGFloat
        var itemWidth = CGFloat()
        var itemHeight = CGFloat()
        
      
        itemsPerRow = 4
        hardCodedPadding = 5
        itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)

        
        return CGSize(width: 300, height: itemHeight)
    }
    
}
