//
//  Favoritos.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/23/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class Favoritos: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet var ColecView3: UICollectionView!
    
    func colectionMudaFundo()
    {
        ColecView3.backgroundColor = UIColor.clearColor()
        ColecView3.showsHorizontalScrollIndicator = false
        ColecView3.showsVerticalScrollIndicator = false
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int//set qtde de celulas por sessoes [CollectionView]
    {
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell //set celula [CollectionView]
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("videoCell3", forIndexPath: indexPath)
        
        colectionMudaFundo()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        //controller.goToNextController()
    }
    
    
    
// UICollectionViewDelegateFlowLayout
    
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
