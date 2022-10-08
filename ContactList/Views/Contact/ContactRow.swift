///
///  ContactRow.swift
///  ContactList
///
///  Created by Jessica Ernst on 29.09.22.
///  Copyright © 2022 Jessica Ernst. All rights reserved.
///

import SwiftUI

struct ContactRow: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var contact: Contact
    
    let viewModel = AddContactViewModel()
    
    var body: some View {
        HStack {
            CircleImage(image: Image(uiImage: viewModel.getImageFromData(contact: contact)))
                .frame(width: 60, height: 60)
                .aspectRatio(contentMode: .fit)
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
