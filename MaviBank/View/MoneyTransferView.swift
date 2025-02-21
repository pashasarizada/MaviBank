
//
//  TransferView.swift
//  MaviBank
//
//  Created by TEST on 21.02.2025.
//

import SwiftUI

struct MoneyTransferView: View {
    @ObservedObject var bankViewModel: BankViewModel //kullanici listesi ve transfer fonksiyonunu burdan aldim
    
    @State private var senderId: UUID?
    @State private var receiverIban = ""
    @State private var amount = ""
    @State private var transferMessage = ""

    @Environment(\.presentationMode) var presentationMode //transfer tamamlandiginda view'i kapatmak icin

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sender ")) {
                    Picker("Sender", selection: $senderId) {
                        ForEach(bankViewModel.bank.bankUsers) { user in
                            Text(user.userName).tag(user.id as UUID?)
                        }
                    }
                }

                Section(header: Text("Receiver IBAN")) {
                    TextField("Receiver IBAN", text: $receiverIban)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Amount")) {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }

                Button("Transfer") {
                    if let senderId = senderId, let receiverIban = Int(receiverIban), let amount = Double(amount) {
                        let success = bankViewModel.transferMoney(from: senderId, to: receiverIban, amount: amount)
                        transferMessage = success ? "Transfer Successful!" : "Transfer Failed!"
                    }
                }
                
                Text(transferMessage)
                    .foregroundColor(transferMessage == "Transfer Successful!" ? .green : .red)
            }
            .navigationTitle("Money Transfer")
        }
    }
}
