//
//  EntityManagement.swift
//  ScratchApp
//
//  Created by HTS-676 on 01/01/25.
//

import Foundation
import CoreData
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class EntityManagement{
    static let shared = EntityManagement()
    
    func AddUser(name: String, email_id: String, phone_number: String, success: @escaping(Bool) -> Void, failure: @escaping(String) -> Void){
        let entity = NSEntityDescription.entity(forEntityName: "UserData", in: context)
        let newObj = NSManagedObject(entity: entity!, insertInto: context)
        newObj.setValue(name, forKey: "name")
        newObj.setValue(name, forKey: "email_id")
        newObj.setValue(phone_number, forKey: "phone_number")
        do{
            try context.save()
            success(true)
        }catch{
            debugPrint(error)
        }
    }
    
    func deleteUser(email_id:String, success: @escaping(Bool) -> Void, failure: @escaping(String) -> Void){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        request.predicate = NSPredicate(format: "email_id = %@", "\(email_id)")
        let clearRequest = NSBatchDeleteRequest(fetchRequest: request)
        do
        {
            try context.execute(clearRequest)
            try context.save()
            success(true)
        }
        catch _ {
            print("Could not delete")
            failure("Could not delete")
        }
    }
}
