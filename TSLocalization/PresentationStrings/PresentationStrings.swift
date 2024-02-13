//
//  PresentationStrings.swift
//  TSLocalization
//
//  Created by apple on 13.02.2024.
//

import Foundation

class PresentationStrings: ObservableObject {
  @Published
  var commponent: PresentationStringsComponent

  static let defaultLnaguageSupported: LanguageSupported = .en

  static var defaultPresentationStrings = PresentationStringsComponent(
    languageCode: defaultLnaguageSupported.rawValue,
    localizedName: defaultLnaguageSupported.fullName,
    dict: NSDictionary(
      contentsOf: URL(
        fileURLWithPath: Bundle.main.path(
          forResource: "Localizable",
          ofType: "strings",
          inDirectory: nil,
          forLocalization: defaultLnaguageSupported.rawValue
        )!
      )
    ) as! [String : String]
  )

  // MARK: Mock
  //  let downloadPresentationStrings = PresentationStrings(
  //    primaryCommponent: PresentationStringsComponent(
  //      languageCode: "custom",
  //      localizedName: "LOL",
  //      dict: [
  //        "Fact.Title": "РАНТАЙМ 😯",
  //        "Button.Default": "Не нажимать!!"
  //      ]
  //    )
  //  )

  init(primaryCommponent: PresentationStringsComponent) {
    self.commponent = primaryCommponent
  }

  func get(value: String) -> String {
    return commponent.dict[value] ?? "Unknown"
  }

  func changeLocalization(to language: LanguageSupported) {
    self.commponent = PresentationStringsComponent(
      languageCode: language.rawValue,
      localizedName: language.fullName,
      dict: NSDictionary(
        contentsOf: URL(
          fileURLWithPath: Bundle.main.path(
            forResource: "Localizable",
            ofType: "strings",
            inDirectory: nil,
            forLocalization: language.rawValue
          )!
        )
      ) as! [String : String]
    )
  }
  //
  //  // MARK: When installation
  //  func saveLocalization(_ component: PresentationStringsComponent) {
  //    do {
  //      var defaultComp = defaultPresentationStrings.primaryCommponent
  //      var copyDict = component.dict
  //      component.dict = defaultComp.dict
  //      copyDict.forEach { (key: String, value: String) in
  //        component.dict.updateValue(value, forKey: key)
  //      }
  //      let data = try JSONEncoder().encode(component)
  //      UserDefaults.standard.setValue(data, forKey: "LocaleComponent")
  //    } catch {
  //      print("SAVE ERROR")
  //    }
  //  }
  //
  //  func getLocalization() -> PresentationStringsComponent? {
  //    do {
  //      guard let data = UserDefaults.standard.object(forKey: "LocaleComponent") as? Data else { return nil }
  //      return try JSONDecoder().decode(PresentationStringsComponent.self, from: data)
  //    } catch {
  //      print("Get ERROR")
  //      return nil
  //    }
  //  }
}

extension PresentationStrings {
  typealias Component = PresentationStringsComponent
}


final class PresentationStringsComponent: Codable {
  let languageCode: String
  let localizedName: String
  var dict: Dictionary<String, String>

  init(languageCode: String, localizedName: String, dict: Dictionary<String, String>) {
    self.languageCode = languageCode
    self.localizedName = localizedName
    self.dict = dict
  }

  enum CodingKeys: String, CodingKey {
    case languageCode
    case localizedName
    case dict
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.languageCode = try container.decode(String.self, forKey: .languageCode)
    self.localizedName = try container.decode(String.self, forKey: .localizedName)
    self.dict = try container.decode(Dictionary<String, String>.self, forKey: .dict)
  }
}

extension PresentationStringsComponent: RawRepresentable {

  // RawRepresentable allows a UserModel to be store in AppStorage directly.

  public convenience init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
          let result = try? JSONDecoder().decode(PresentationStringsComponent.self, from: data)
    else {
      return nil
    }
    self.init(languageCode: result.languageCode, localizedName: result.localizedName, dict: result.dict)
  }

  var rawValue: String {
    guard let data = try? JSONEncoder().encode(self),
          let result = String(data: data, encoding: .utf8)
    else {
      return "[]"
    }
    return result
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(languageCode, forKey: .languageCode)
    try container.encode(localizedName, forKey: .localizedName)
    try container.encode(dict, forKey: .dict)
  }
}
