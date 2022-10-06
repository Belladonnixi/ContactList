//
//  CircleImage.swift
//  ContactList
//
//  Created by Jessica Ernst on 06.10.22.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .cornerRadius(50)
            .background(Color.black.opacity(0.3))
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 7)
            
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("doctor"))
    }
}
