//
//  ContentView.swift
//  NetworkCall
//
//  Created by Mohammed Mubashir on 08/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing:20){
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 120,height: 120)
            
            Text("Username")
                .bold()
                .font(.title3)
            
            Text("This is where github bio will go")
                .padding()
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
