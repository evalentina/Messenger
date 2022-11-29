//
//  ProfileModels.swift
//  Messenger
//
//  Created by Валентина Евдокимова on 26.11.2022.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
