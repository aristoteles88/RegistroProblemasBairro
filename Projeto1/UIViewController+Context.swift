//
//  UIViewController+Context.swift
//  Projeto1
//
//  Created by Aristóteles Júnior on 31/12/21.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
