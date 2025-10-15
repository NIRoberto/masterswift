# 🚀 MasterSwift Setup Guide

Complete step-by-step instructions to run the MasterSwift e-commerce app.

## 📋 Prerequisites

- **macOS** with Xcode 15.0+
- **iOS Simulator** or **Physical iPhone** (iOS 17.0+)
- **Firebase Account** (free)
- **Internet Connection**

## 🔧 Step-by-Step Setup

### 1️⃣ Download the Project

```bash
# Clone or download the project
git clone <repository-url>
cd MasterSwift
```

### 2️⃣ Firebase Project Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click **"Create a project"**
3. Enter project name: `MasterSwift-YourName`
4. **Disable Google Analytics** (optional)
5. Click **"Create project"**

#### Enable Authentication
1. In Firebase Console → **Authentication**
2. Click **"Get started"**
3. Go to **"Sign-in method"** tab
4. Click **"Email/Password"**
5. **Enable** the first option
6. Click **"Save"**

#### Setup Firestore Database
1. In Firebase Console → **Firestore Database**
2. Click **"Create database"**
3. Choose **"Start in test mode"**
4. Select your **region** (closest to you)
5. Click **"Done"**

#### Enable Billing (Required)
1. Go to **Project Settings** → **Usage and billing**
2. Click **"Modify plan"**
3. Select **"Blaze (Pay as you go)"**
4. Add payment method
5. **Don't worry**: Free tier covers development usage

#### Download Configuration File
1. In Firebase Console → **Project Settings**
2. Click **iOS** app icon
3. Enter **Bundle ID**: `com.yourname.MasterSwift`
4. Click **"Register app"**
5. **Download** `GoogleService-Info.plist`
6. **Important**: Save this file!

### 3️⃣ Xcode Setup

#### Add Firebase Configuration
1. Open **Xcode**
2. Open `MasterSwift.xcodeproj`
3. **Drag** `GoogleService-Info.plist` into Xcode
4. Make sure **"Add to target"** is checked
5. Click **"Finish"**

#### Verify Bundle ID
1. Select **MasterSwift** project in Xcode
2. Go to **"Signing & Capabilities"**
3. Change **Bundle Identifier** to match Firebase: `com.yourname.MasterSwift`

### 4️⃣ Run the App

1. Select **iPhone Simulator** or your device
2. Press **`Cmd + R`** to build and run
3. Wait for build to complete

## 📱 Using the App

### First Time Setup
1. App opens to **Login screen**
2. Tap **"Sign up"** to create account
3. Fill in:
   - **Email**: your-email@example.com
   - **Full Name**: Your Name
   - **Password**: minimum 6 characters
4. Tap **"SIGN UP"**

### App Features
- **Home**: Browse products, logout button
- **Categories**: Browse by food categories
- **Cart**: Add/remove items, checkout
- **Orders**: View order history
- **Profile**: Manage account, addresses, payments

## 🐛 Troubleshooting

### Common Issues

#### "Database does not exist" Error
- **Solution**: Complete Step 2️⃣ - Setup Firestore Database

#### "Billing not enabled" Error
- **Solution**: Complete Step 2️⃣ - Enable Billing (free tier)

#### App crashes on launch
- **Solution**: Verify `GoogleService-Info.plist` is added to Xcode project

#### Login/Register not working
- **Solution**: Check Firebase Authentication is enabled

### Check Logs
- Open **Xcode Console** (View → Debug Area → Console)
- Look for emoji logs:
  - 🔄 = Process starting
  - ✅ = Success
  - ❌ = Error
  - ⚠️ = Warning

## 🎯 Testing the App

### Test User Registration
1. Create account with valid email
2. Check Firebase Console → Authentication → Users
3. Should see new user listed

### Test Shopping Cart
1. Browse products on Home tab
2. Tap product → "Add to Cart"
3. Go to Cart tab → verify item appears
4. Items persist after app restart

### Test Data Persistence
1. Add items to cart
2. Close app completely
3. Reopen app → cart items should remain

## 🆘 Need Help?

### Firebase Console Links
- **Authentication**: https://console.firebase.google.com/project/YOUR_PROJECT/authentication
- **Firestore**: https://console.firebase.google.com/project/YOUR_PROJECT/firestore
- **Project Settings**: https://console.firebase.google.com/project/YOUR_PROJECT/settings/general

### Verification Checklist
- [ ] Firebase project created
- [ ] Authentication enabled (Email/Password)
- [ ] Firestore database created
- [ ] Billing enabled
- [ ] `GoogleService-Info.plist` downloaded and added to Xcode
- [ ] Bundle ID matches Firebase configuration
- [ ] App builds and runs without errors

---

**🎉 You're all set! Enjoy your e-commerce app!**