//
//  User.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let fullName: String
    let initials: String
    
    init(id: String, email: String, fullName: String) {
        self.id = id
        self.email = email
        self.fullName = fullName
        
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            // ✅ Fixed string interpolation here
            let firstInitial = components.givenName?.first.map { String($0) } ?? ""
            let lastInitial = components.familyName?.first.map { String($0) } ?? ""
            self.initials = firstInitial + lastInitial
        } else {
            self.initials = ""
        }
    }
}
