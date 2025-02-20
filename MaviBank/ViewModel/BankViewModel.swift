//
//  BankViewModel.swift
//  MaviBank
//
//  Created by TEST on 20.02.2025.
//

import Foundation

class BankViewModel: ObservableObject{
    
    @Published  var bank: Bank
    
    init(bankName: String) {
        self.bank = Bank(bankName: bankName, bankUsers: [])
    }
     
    var bankName: String{
        bank.bankName
    }
    
    
    func addUser(name:String,iban:Int, balance:Double){
        
        let newUser = User(userName: name, userIban: iban, userBalance: balance)
        bank.addUser(newUser)
        objectWillChange.send() // for  ui update
    }
    
    func transferMoney(from senderId: UUID, to receiverIban: Int, amount:Double) ->Bool {
        
        let successful =  bank.transferMoney(from: senderId, to: receiverIban, amount: amount)
            if successful{
                objectWillChange.send()
            }
            return successful
        
    }
    
    
}
