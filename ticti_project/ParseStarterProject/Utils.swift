//
//  Utils.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Campos on 10/20/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class Utils
{
    class func alerta(title:String, message:String, textoBt:String)
    {
        let alerta = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alerta.addAction(UIAlertAction(title: textoBt, style: .Default, handler:
            { (alert) -> Void in
                
                alerta.dismissViewControllerAnimated(true, completion: nil)
            }
            ))
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
}
