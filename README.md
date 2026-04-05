# Finance Tracker App

A comprehensive mobile finance tracking application built with Flutter that helps users manage their finances, track transactions, set savings goals, and gain insights into their spending patterns.

## 🌐 **Live Demo**

**Access the app at:** [http://localhost:8081](http://localhost:8081)

> **Note:** The app must be running locally. Follow the installation instructions below to start the development server.

##  Features

### 1. **Home Dashboard**
- **Current Balance Display**: Shows total balance with income and expense breakdown
- **Financial Summary Cards**: Quick view of weekly spending and trends
- **Savings Progress**: Visual progress indicator for active savings goals
- **Spending Chart**: Pie chart showing spending distribution by category
- **Recent Transactions**: Quick access to the latest 5 transactions
- **Pull-to-Refresh**: Refresh data with a simple swipe down

### 2. **Transaction Management**
- **Add Transactions**: Easy-to-use form for adding income or expenses
- **Edit & Delete**: Swipe actions for quick transaction management
- **Category Selection**: Pre-defined categories with icons for both income and expenses
- **Search & Filter**: Search transactions by category or notes, filter by type
- **Date Grouping**: Transactions organized by date (Today, Yesterday, specific dates)
- **Notes Support**: Add optional notes to transactions for better tracking

### 3. **Savings Goals**
- **Create Goals**: Set target amounts and deadlines for savings goals
- **Track Progress**: Visual progress bars showing completion percentage
- **Add Contributions**: Easily add money to existing goals
- **Goal Details**: View comprehensive information about each goal
- **Active/Completed Separation**: Organized view of ongoing and achieved goals
- **Days Remaining**: Countdown to goal deadline

### 4. **Insights & Analytics**
- **Monthly Overview**: Complete financial summary for the current month
- **Savings Rate**: Calculate and display your savings percentage
- **Weekly Comparison**: Compare current week spending with previous week
- **Top Spending Category**: Identify where most money is being spent
- **Category Breakdown**: Detailed breakdown with percentages and amounts
- **Transaction Statistics**: Total, income, expense counts, and average transaction amount

### 5. **User Experience**
- **Smooth Navigation**: Bottom navigation bar with 4 main sections
- **Empty States**: Helpful messages when no data is available
- **Loading States**: Progress indicators during data operations
- **Error Handling**: User-friendly error messages
- **Responsive Design**: Adapts to different screen sizes
- **Material Design 3**: Modern, clean UI following Material Design guidelines

## 🛠️ Technology Stack

- **Framework**: Flutter 3.11.4+
- **Language**: Dart
- **State Management**: Provider
- **Database**: SQLite (sqflite) with web support (sqflite_common_ffi_web)
- **Charts**: fl_chart for data visualization
- **UI Components**: 
  - flutter_slidable for swipe actions
  - font_awesome_flutter for additional icons
- **Date Formatting**: intl package

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.1.1
  sqflite: ^2.3.0
  sqflite_common_ffi_web: ^0.4.2+2
  path_provider: ^2.1.1
  path: ^1.8.3
  fl_chart: ^0.65.0
  intl: ^0.19.0
  font_awesome_flutter: ^10.6.0
  flutter_slidable: ^3.0.1
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.11.4 or higher)
- Dart SDK
- Chrome browser (for web testing)
- Android Studio / Xcode (for mobile testing)

### Installation

1. **Clone the repository**
   ```bash
   cd /path/to/your/directory
   git clone <repository-url>
   cd finance_tracker_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**

   **For Web (Chrome):**
   ```bash
   flutter run -d chrome --web-port=8081
   ```
   
   Then open your browser and navigate to: **http://localhost:8081**

   **For Android:**
   ```bash
   flutter run -d android
   ```

   **For iOS:**
   ```bash
   flutter run -d ios
   ```

4. **Access the app**
   - **Web:** [http://localhost:8081](http://localhost:8081)
   - **Mobile:** App will launch on connected device/emulator

## 🔗 **Quick Start**

If the app is already running, simply open: **[http://localhost:8081](http://localhost:8081)**

## � App Structure

```
lib/
├── main.dart                 # App entry point and main navigation
├── models/                   # Data models
│   ├── transaction.dart      # Transaction model
│   └── savings_goal.dart     # Savings goal model
├── database/                 # Database layer
│   └── database_helper.dart  # SQLite database operations
├── providers/                # State management
│   ├── transaction_provider.dart
│   └── savings_goal_provider.dart
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── transactions_screen.dart
│   ├── add_transaction_screen.dart
│   ├── goals_screen.dart
│   ├── add_goal_screen.dart
│   └── insights_screen.dart
├── widgets/                  # Reusable widgets
│   ├── summary_card.dart
│   └── spending_chart.dart
└── utils/                    # Utilities and constants
    └── constants.dart
```

## 💾 Database Schema

### Transactions Table
```sql
CREATE TABLE transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  amount REAL NOT NULL,
  type TEXT NOT NULL,           -- 'income' or 'expense'
  category TEXT NOT NULL,
  date TEXT NOT NULL,           -- ISO 8601 format
  notes TEXT
)
```

### Savings Goals Table
```sql
CREATE TABLE savings_goals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  targetAmount REAL NOT NULL,
  currentAmount REAL NOT NULL,
  startDate TEXT NOT NULL,      -- ISO 8601 format
  targetDate TEXT NOT NULL,     -- ISO 8601 format
  description TEXT
)
```

## 🎨 Design Decisions

### Product Thinking
- **User-First Approach**: Designed with simplicity and ease of use in mind
- **Visual Feedback**: Charts and progress indicators for quick understanding
- **Contextual Actions**: Swipe gestures for common operations
- **Smart Defaults**: Pre-defined categories to speed up data entry

### Architecture
- **Provider Pattern**: Chosen for its simplicity and Flutter integration
- **Separation of Concerns**: Clear separation between UI, business logic, and data
- **Reusable Components**: Modular widgets for consistency and maintainability

### UX Enhancements
- **Empty States**: Helpful guidance when no data exists
- **Loading States**: Visual feedback during operations
- **Error Handling**: User-friendly error messages
- **Pull-to-Refresh**: Intuitive data refresh mechanism

## 📊 Key Features Explained

### Transaction Categories

**Expense Categories:**
- Food & Dining
- Shopping
- Transportation
- Entertainment
- Bills & Utilities
- Healthcare
- Education
- Travel
- Groceries
- Other

**Income Categories:**
- Salary
- Freelance
- Business
- Investment
- Gift
- Bonus
- Other

### Insights Calculations

- **Savings Rate**: (Total Income - Total Expenses) / Total Income × 100
- **Weekly Comparison**: Current week expenses vs previous week expenses
- **Category Percentage**: Category Amount / Total Expenses × 100

## 🔧 Configuration

### Colors
The app uses a consistent color scheme defined in `utils/constants.dart`:
- Primary: #6C63FF (Purple)
- Secondary: #4CAF50 (Green)
- Income: #4CAF50 (Green)
- Expense: #FF6B6B (Red)
- Background: #F5F7FA (Light Gray)

### Currency
Currently set to Indian Rupees (₹). Can be modified in the formatting functions.

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📝 Future Enhancements

Potential features for future versions:
- [ ] Dark mode support
- [ ] Data export (CSV/PDF)
- [ ] Recurring transactions
- [ ] Budget limits with alerts
- [ ] Multi-currency support
- [ ] Cloud sync
- [ ] Biometric authentication
- [ ] Notifications and reminders
- [ ] Advanced analytics and reports
- [ ] Category customization

## 🐛 Known Issues

- Web version requires sqflite_common_ffi_web setup for full database functionality
- Some Material 3 features may show deprecation warnings (withOpacity)

## 📄 License

This project is created for educational and evaluation purposes.

## 👨‍💻 Developer Notes

### Assumptions Made
1. Single user application (no authentication required)
2. Local data storage only (no cloud sync)
3. Indian Rupee as default currency
4. Pre-defined categories (not customizable by user)
5. Web platform support prioritized for demo purposes

### Code Quality
- Follows Flutter best practices
- Consistent naming conventions
- Proper error handling
- Commented code where necessary
- Modular and maintainable structure

## 🤝 Contributing

This is an assignment project. For any questions or suggestions, please contact the developer.

## 📞 Support

For issues or questions:
1. Check the documentation above
2. Review the code comments
3. Contact the developer

---

**Built with ❤️ using Flutter**
