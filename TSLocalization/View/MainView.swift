//
//  MainView.swift
//  TSLocalization
//
//  Created by apple on 13.02.2024.
//

import SwiftUI

struct MainView: View {
  @StateObject
  var presentationStrings: PresentationStrings = PresentationStrings(primaryCommponent: PresentationStrings.defaultPresentationStrings)

  var body: some View {
    NavigationStack {
      NavigationLink {
        ChooseLanguageView(presentationStrings: self.presentationStrings)
      } label: {
        Text(presentationStrings.get(value: "Open.Settings"))
      }
    }
  }
}

#Preview {
  MainView()
}
