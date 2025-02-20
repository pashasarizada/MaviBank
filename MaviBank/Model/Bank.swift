//
//  Bank.swift
//  MaviBank
//
//  Created by TEST on 20.02.2025.
//

import Foundation


class Bank{
    
    let bankName: String
     var bankUsers:[User]
    
    init(bankName: String, bankUsers: [User]) {
        self.bankName = bankName
        self.bankUsers = bankUsers
    }
    
    func addUser(_ user: User){
        bankUsers.append(user)
    }
    
    
    func transferMoney(from senderId: UUID, to receiverIban:Int, amount: Double) -> Bool{
        
        guard let senderIndex = bankUsers.firstIndex(where:{$0.id == senderId}),
              let receiverIndex = bankUsers.firstIndex(where: { $0.userIban == receiverIban })
        else {
            return false
        }
        
        if(bankUsers[senderIndex].userBalance >= amount){
            bankUsers[senderIndex].userBalance -= amount
            bankUsers[receiverIndex].userBalance += amount
            return true
        } else {
            return false
        }
        
        
    }
    
}
