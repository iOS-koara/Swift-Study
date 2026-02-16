//
//  ContentView.swift
//  Landmarks
//
//  Created by ara on 2/15/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
