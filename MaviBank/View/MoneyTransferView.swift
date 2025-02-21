
//
//  TransferView.swift
//  MaviBank
//
//  Created by TEST on 21.02.2025.
//

import SwiftUI

struct MoneyTransferView: View {
    @ObservedObject var bankViewModel: BankViewModel
    
    @State private var senderId: UUID?
    @State private var receiverIban = ""
    @State private var amount = ""
    @State private var transferMessage = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Gönderen Kullanıcı")) {
                    Picker("Gönderen", selection: $senderId) {
                        ForEach(bankViewModel.bank.bankUsers) { user in
                            Text(user.userName).tag(user.id as UUID?)
                        }
                    }
                }

                Section(header: Text("Alıcı IBAN")) {
                    TextField("Alıcı IBAN", text: $receiverIban)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Miktar")) {
                    TextField("Tutar", text: $amount)
                        .keyboardType(.decimalPad)
                }

                Button("Transfer Et") {
                    if let senderId = senderId, let receiverIban = Int(receiverIban), let amount = Double(amount) {
                        let success = bankViewModel.transferMoney(from: senderId, to: receiverIban, amount: amount)
                        transferMessage = success ? "Transfer Başarılı!" : "Transfer Başarısız!"
                    }
                }
                
                Text(transferMessage)
                    .foregroundColor(transferMessage == "Transfer Başarılı!" ? .green : .red)
            }
            .navigationTitle("Para Transferi")
        }
    }
}
