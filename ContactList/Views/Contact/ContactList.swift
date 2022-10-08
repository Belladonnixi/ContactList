///
///  ContactList.swift
///  ContactList
///
///  Created by Jessica Ernst on 29.09.22.
///  Copyright © 2022 Jessica Ernst. All rights reserved.
///

import SwiftUI


struct ContactList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],
        animation: .default)
    private var contacts: FetchedResults<Contact>
    
    @State private var addViewShown = false
    
    
    
    let viewModel = ContactListViewModel()
    
    let backgroundGradient = LinearGradient(
        colors: [Color.teal, Color.indigo],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        AddContactView(contactId: contact.objectID)
                    } label: {
                        ContactRow(contact: contact)
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        viewModel.deleteItems(
                            for: indexSet,
                            contacts: contacts,
                            viewContext: viewContext
                        )
                    }
                }
                .listRowBackground(backgroundGradient)
                
            }
            .toolbar {
                NavigationLink(destination: AddContactView(),
                               isActive: $addViewShown) {
                    Button {
                        addViewShown = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .navigationTitle("Contact List")
        }
    }
}




struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
