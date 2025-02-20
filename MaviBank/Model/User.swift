//
//  User.swift
//  MaviBank
//
//  Created by TEST on 20.02.2025.
//

import Foundation


struct User: Identifiable{
    
    let id: UUID = UUID()
    let userName: String
    let userIban: Int
    var userBalance: Double
    
}
