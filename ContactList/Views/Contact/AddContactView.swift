///
///  AddContact.swift
///  ContactList
///
///  Created by Jessica Ernst on 29.09.22.
///  Copyright © 2022 Jessica Ernst. All rights reserved.
///

import SwiftUI
import CoreData

struct AddContactView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    @State var pickerPresented = false
    @State private var name = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var notes = ""
    @State private var profileText = ""
    @State private var picture = Data()
    @State private var birthdate = Date()
    @State private var nameError = false
    
    // MARK: - ImagePicker
    @State private var selectedImage = UIImage()
    @State private var showSheet = false
  
    
    var contactId: NSManagedObjectID?
    let viewModel = AddContactViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        HStack {
                            CircleImage(image: Image(uiImage: self.selectedImage))
                                .frame(width: 100, height: 100)
                                .padding()
                                .foregroundColor(Color.gray)
                            
                            Button {
                                withAnimation {
                                    pickerPresented = true
                                }
                            } label: {
                                Image(systemName: "camera.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color.teal)
                            }
                            .onTapGesture {
                                showSheet = true
                            }
                            .sheet(isPresented: $showSheet) {
                                ImagePicker(selectedImage: $selectedImage)
                            }
                        }
                    }
                    Section("Contact Info") {
                        VStack {
                            TextField(
                                "Name",
                                text: $name,
                                prompt: Text("Name")
                            )
                            if nameError {
                                Text("Name is required")
                                    .foregroundColor(.red)
                            }
                            
                            VStack {
                                TextField(
                                    "Last Name",
                                    text: $lastName,
                                    prompt: Text("Last Name")
                                )
                            }
                            
                            VStack {
                                TextField(
                                    "email",
                                    text: $email,
                                    prompt: Text("email")
                                )
                            }
                            
                            DatePicker(
                                "Birthdate",
                                selection: $birthdate,
                                displayedComponents: [.date])
                            
                            List {
                                Text("Notes")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                ZStack(alignment:. topLeading) {
                                    TextEditor(text: $notes)
                                        .foregroundColor(Color.black)
                                        .background(Color("textBackground"))
                                        .cornerRadius(10.0)
                                        .frame(height: 150.0)
                                }
                                .padding(.bottom)
                            }
                        }
                    }
                }
                
                Button {

                    let pickedImage = selectedImage.jpegData(compressionQuality: 1.0)
                    if name.isEmpty {
                        nameError = name.isEmpty
                    } else {
                        let values = ContactValues (
                            name: name,
                            lastName: lastName,
                            email: email,
                            birthdate: birthdate,
                            notes: notes,
                            picture: pickedImage ?? Data()
                            
                        )
                        
                        viewModel.saveContact(
                            contactId: contactId,
                            with: values,
                            in: viewContext)
                        presentation.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: 300)
                }
                .tint(Color.teal)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .controlSize(.large)
            }
        }
        .navigationTitle("\(contactId == nil ? "Add Contact" : "Edit Contact")")
        .onAppear {
            guard
                let objectId = contactId,
                let contact = viewModel.fetchContact(for: objectId, context: viewContext)
            else {
                return
            }
            
            name = contact.name!
            lastName = contact.lastName!
            email = contact.email!
            birthdate = contact.birthdate!
            notes = contact.notes!
            selectedImage = viewModel.getImageFromData(contact: contact)
        }
        
    }
    
}

struct AddContact_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
