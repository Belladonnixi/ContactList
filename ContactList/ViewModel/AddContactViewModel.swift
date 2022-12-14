///
///  AddContactViewModel.swift
///  ContactList
///
///  Created by Jessica Ernst on 05.10.22.
///  Copyright © 2022 Jessica Ernst. All rights reserved.
///

import CoreData
import SwiftUI

struct AddContactViewModel {
    func fetchContact(for objectId: NSManagedObjectID, context: NSManagedObjectContext) ->
    Contact? {
        guard let contact = context.object(with: objectId) as? Contact else {
            return nil
        }
        return contact
    }
    
    func saveContact(
        contactId: NSManagedObjectID?,
        with contactValues: ContactValues,
        in context: NSManagedObjectContext
    ) {
        let contact: Contact
        if let objectId = contactId,
           let fetchedContact = fetchContact(for: objectId, context: context) {
            contact = fetchedContact
        } else {
            contact = Contact(context: context)
        }
        
        contact.name = contactValues.name
        contact.lastName = contactValues.lastName
        contact.birthdate = contactValues.birthdate
        contact.email = contactValues.email
        contact.notes = contactValues.notes
        contact.picture = contactValues.picture
        
        do {
          try context.save()
        } catch {
          print("Save error: \(error)")
        }
    }
    
    func getImageFromData(contact: Contact) -> UIImage  {
            //this is just a placeholder
        var finalImage = (UIImage(systemName: "person.circle.fill"))
            if let data = contact.picture {
                if let image = UIImage(data: data as Data) {
                    finalImage = image
                    }
                }
                return finalImage!
            }
}
