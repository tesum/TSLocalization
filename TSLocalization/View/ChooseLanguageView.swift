//
//  ChooseLanguageView.swift
//  TSLocalization
//
//  Created by apple on 13.02.2024.
//

import SwiftUI

enum LanguageSupported: String, Identifiable, CaseIterable {
  var id : String { UUID().uuidString }

  case ru
  case en
  case uz

  var fullName: String {
    switch self {
    case .ru: return "Русский"
    case .en: return "English"
    case .uz: return "O'zbek"
    }
  }
}

struct ChooseLanguageView: View {
  @Environment(\.presentationMode)
  var presentationMode: Binding<PresentationMode>

  @StateObject
  var presentationStrings: PresentationStrings
  var languages: [LanguageSupported] = LanguageSupported.allCases

  var body: some View {
    NavigationStack {
      List(languages) { language in
        HStack {
          Text(language.fullName)
          Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
          selectLanguage(language)
        }
      }
      .listStyle(.insetGrouped)
      .navigationTitle(self.presentationStrings.get(value: "Open.Settings"))
      .navigationBarBackButtonHidden()
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          BackButton(title: self.presentationStrings.get(value: "Back.Button")) {
            presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
  }

  private func selectLanguage(_ language: LanguageSupported) {
    presentationStrings.changeLocalization(to: language)
  }
}

#Preview {
  ChooseLanguageView(presentationStrings: PresentationStrings(primaryCommponent: PresentationStrings.defaultPresentationStrings))
}
