# Clean Architecture Authentication App

This is my project and it has Solid Clean Architecture implementation. 
This project can be used for starting a project which has an auth feature. 

It contains:

- SOLID Principles and its usage in Clean Architecture.
- Bloc & Cubit State Management
- Supabase (But Database changing can be done easily without too much refactoring)
- Get_It
- Dependency Injection

I do some changes in presentation layer for to have different UI. 
Regards to Rivaan Ranawat. Thank you so much.

## How to Use This Project

If you are using Supabase just create "secrets" folder in common folder.
And create a "app_secrets.dart" file and this file should contain your Supabase anonKey and url.
You can customize all of this if you are using Firebase. 

app_secrets.dart can be like this:

```dart
class AppSecrets {
  static const supabaseUrl = "yoursupabaseurl";
  static const supabaseAnonKey = "yoursupabaseanonkey";
}
```

Have a nice day!