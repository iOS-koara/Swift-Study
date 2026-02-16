//
//  LandmarkList.swift
//  Landmarks
//
//  Created by ara on 2/16/26.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        List(landmarks) { landmark in
            LandmarkRow(landmark: landmark)
        }
    }
}

#Preview {
    LandmarkList()
}
