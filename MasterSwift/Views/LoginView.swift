//
//  LoginView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Header
                VStack(spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    
                    Text("Welcome Back")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(.top, 50)
                
                Spacer()
                
                // Form fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                             title: "Email Address",
                             placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                             title: "Password",
                             placeholder: "Enter your password",
                             isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Error message
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                // Sign in button
                Button {
                    Task {
                        await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        } else {
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid || viewModel.isLoading)
                .opacity(formIsValid && !viewModel.isLoading ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                // Sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}