//
//  InsertTestData.swift
//  CarTrack
//
//  Created by Prashant Singh on 13/5/21.
//

import CoreData
import UIKit

final class InsertTestData {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users: [UserCredentials]?
    
    func checkTestDataExists() {
        do {
            let request = UserCredentials.fetchRequest() as NSFetchRequest<UserCredentials>
            let userToValidate = "@"
            let predicate = NSPredicate(format: "userName LIKE %@", userToValidate)
            request.predicate = predicate
            self.users = try context.fetch(request)
            
            if self.users?.count == 0 {
                let newUser = UserCredentials(context: context)
                newUser.userName = "Abc@xyz.com"
                newUser.password = "singapore21"
                
                do {
                    try context.save()
                } catch {
                    print("Error: \(error)")
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
