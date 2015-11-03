//
//  SecaoTopusers.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/21/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class SecaoTopusers: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet var ColectView2: UICollectionView!
    
    func colectionMudaFundo()
    {
        ColectView2.backgroundColor = UIColor.clearColor()
        ColectView2.pagingEnabled = false
        ColectView2.showsHorizontalScrollIndicator = false
        ColectView2.showsVerticalScrollIndicator = false
    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        if segue.identifier == "game"
//        {
//            if let destination = segue.destinationViewController as? Exibe
//            {
//                
//                let path = ColectView2.indexPathsForSelectedItems()
//                
//                destination.txtLabel.text = "wow \(path?.first?.row)"
//            }
//        }
//    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int//set qtde de celulas por sessoes [CollectionView]
    {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell //set celula [CollectionView]
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("videoCell", forIndexPath: indexPath)
        
        colectionMudaFundo()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        //x.goToNextController()
    }
    


// UICollectionViewDelegateFlowLayout

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize //set das celulas [CollectionView]
    {
        var itemsPerRow:CGFloat
        var hardCodedPadding:CGFloat
        let itemWidth:CGFloat
        let itemHeight:CGFloat
        
        
        itemsPerRow = 10
        hardCodedPadding = 5
        itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        
        
        return CGSize(width: 110 , height:110)
    }
    
}
