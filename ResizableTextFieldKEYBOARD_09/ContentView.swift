//
//  ContentView.swift
//  ResizableTextFieldKEYBOARD_09
//
//  Created by emm on 10/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text("Chats")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }.padding()
            .background(Color.white)
            
            Spacer()
        }
        .background(Color.primary.opacity(0.06).edgesIgnoringSafeArea(.bottom))
    }
}
