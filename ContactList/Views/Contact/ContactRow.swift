//
//  ContactRow.swift
//  ContactList
//
//  Created by Jessica Ernst on 29.09.22.
//

import SwiftUI

struct ContactRow: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var contact: Contact
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text("\(contact.name ?? "") \(contact.lastName ?? "")")
                    .font(.headline)
            }
        }
        .padding()
        .frame(height: 60)
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(contact: getContact())
    }
}

func getContact() -> Contact {
    let contact = Contact(context: PersistenceController(inMemory: true).container.viewContext)
    contact.name = "Mark"
    contact.lastName = "Doe"
    return contact
}
