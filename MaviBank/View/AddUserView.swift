
//
//  AddUserView.swift
//  MaviBank
//
//  Created by TEST on 21.02.2025.
//

import SwiftUI

struct AddUserView: View {
    @ObservedObject var bankViewModel: BankViewModel
    
    @State private var userName = ""
    @State private var userIban = ""
    @State private var userBalance = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Kullanıcı Bilgileri")) {
                    TextField("Ad", text: $userName)
                    TextField("IBAN", text: $userIban)
                        .keyboardType(.numberPad)
                    TextField("Başlangıç Bakiyesi", text: $userBalance)
                        .keyboardType(.decimalPad)
                }
                
                Button("Ekle") {
                    if let iban = Int(userIban), let balance = Double(userBalance) {
                        bankViewModel.addUser(name: userName, iban: iban, balance: balance)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(userName.isEmpty || userIban.isEmpty || userBalance.isEmpty)
            }
            .navigationTitle("Kullanıcı Ekle")
        }
    }
}
