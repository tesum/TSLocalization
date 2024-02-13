//
//  BackButton.swift
//  TSLocalization
//
//  Created by apple on 13.02.2024.
//

import SwiftUI

struct BackButton: View {
  var title: String = "Back"
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack(spacing: 0) {
        Image(systemName: "chevron.backward")
          .frame(width: 24, height: 24)
        Text(title)
          .font(.body)
//        Spacer()
      }
    }
  }
}

#Preview {
  BackButton() {}
}
