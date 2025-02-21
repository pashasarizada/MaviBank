//
//  HomeView.swift
//  MaviBank
//
//  Created by TEST on 21.02.2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var bankViewModel = BankViewModel(bankName: "Mavi Bank Panel")
    @State private var showUserAddSheet = false
    @State private var showMoneyTransferSheet = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .leading) {
                    Color.blue
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 120)
                    
                    Text(bankViewModel.bankName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                        .padding(.leading)
                }

                List(bankViewModel.bank.bankUsers) { user in
                    VStack(alignment: .leading) {
                        Text(user.userName)
                            .font(.headline)
                        Text("Bakiye: \(user.userBalance, specifier: "%.2f")₺")
                            .font(.subheadline)
                            .foregroundColor(.green)
                        Text("IBAN: \(user.userIban)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                
                HStack {
                    Button("Add Customer") {
                        showUserAddSheet = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                    Button("Money Transfer") {
                        showMoneyTransferSheet = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .onAppear {
                if bankViewModel.bank.bankUsers.isEmpty {
                    bankViewModel.addUser(name: "Kanka", iban: 123456, balance: 1000.0)
                    bankViewModel.addUser(name: "Brada", iban: 654321, balance: 2000.0)
                }
            }
            
            .sheet(isPresented: $showUserAddSheet) {
                AddUserView(bankViewModel: bankViewModel)
            }
            .sheet(isPresented: $showMoneyTransferSheet) {
                MoneyTransferView(bankViewModel: bankViewModel)
            }
        }
    }
}

#Preview {
    HomeView()
}
