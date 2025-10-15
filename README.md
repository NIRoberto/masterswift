# MasterSwift E-Commerce App 🛍️

A fully functional e-commerce iOS app built with SwiftUI and Firebase, featuring complete authentication, shopping cart, and user management.

## ✨ Features

### 🔐 Authentication
- **Email/Password Registration & Login**
- **Form Validation** with real-time feedback
- **Loading States** with visual indicators
- **Error Handling** with user-friendly messages
- **Session Management** - stay logged in

### 🛒 Shopping Experience
- **Product Catalog** with categories
- **Shopping Cart** with quantity controls
- **Persistent Cart** - saves across app sessions
- **Add to Cart** with confirmation alerts
- **Order History** with status tracking

### 👤 User Management
- **User Profile** with avatar initials
- **Edit Profile** information
- **Address Book** for delivery addresses
- **Payment Methods** management
- **Notification Settings**
- **Account Deletion** with confirmation

### 📱 Navigation
- **5-Tab Interface**: Home, Categories, Cart, Orders, Profile
- **Clean UI/UX** with professional design
- **Responsive Layout** for all screen sizes

## 🏗️ Architecture

### **MVVM Pattern**
- `AuthViewModel` - Handles authentication logic
- `CartViewModel` - Manages shopping cart state
- Clean separation of concerns

### **Firebase Integration**
- **Firebase Auth** - User authentication
- **Firestore** - User data & cart persistence
- **Offline Support** - Works without internet

### **SwiftUI Components**
- Reusable UI components
- Environment objects for state management
- Navigation with proper data flow

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- Firebase account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd MasterSwift
   ```

2. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Authentication (Email/Password)
   - Create Firestore Database in test mode
   - Download `GoogleService-Info.plist`
   - Add it to your Xcode project

3. **Enable Billing** (Required for Firestore)
   - Go to Firebase Console → Project Settings → Usage and billing
   - Set up billing (free tier available)

4. **Open in Xcode**
   ```bash
   open MasterSwift.xcodeproj
   ```

5. **Run the app**
   - Select your target device/simulator
   - Press `Cmd + R` to build and run

## 📊 Database Structure

### Firestore Collections

```
users/
  {userId}/
    - id: String
    - email: String
    - fullName: String
    - initials: String

carts/
  {userId}/
    - items: Array
      - productId: String
      - productName: String
      - productCategory: String
      - productPrice: Double
      - quantity: Int
```

## 🛠️ Configuration

### Firebase Rules (Development)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## 📱 App Flow

1. **Launch** → Check authentication state
2. **Unauthenticated** → Login/Register screens
3. **Authenticated** → Main tab interface
4. **Shopping** → Browse → Add to cart → Checkout
5. **Profile** → Manage account settings

## 🔧 Development

### Key Files
- `AuthViewModel.swift` - Authentication logic
- `CartViewModel.swift` - Shopping cart management
- `RootView.swift` - Navigation controller
- `ContentView.swift` - Main product display

### Logging
Comprehensive logging throughout the app:
- 🔄 Process indicators
- ✅ Success confirmations
- ❌ Error details
- ⚠️ Warnings and fallbacks

## 📝 TODO / Future Enhancements

- [ ] Payment integration (Stripe/Apple Pay)
- [ ] Push notifications for orders
- [ ] Product search functionality
- [ ] Wishlist feature
- [ ] Order tracking with real-time updates
- [ ] Admin panel for product management

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Firebase for backend services
- SwiftUI for the modern UI framework
- Apple for iOS development tools

---

**Built with ❤️ using SwiftUI and Firebase**