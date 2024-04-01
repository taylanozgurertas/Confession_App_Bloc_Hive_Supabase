# Confession App

This is my project and it has Solid Clean Architecture implementation. 
This project can be used for starting a project which has an auth feature. 

It contains:

- SOLID Principles and its usage in Clean Architecture.
- Bloc & Cubit State Management
- Supabase (But Database changing can be done easily without too much refactoring)
- Get_It
- Dependency Injection
- Uploading Blogs from Supabase, fetching blogs
- Storing Blogs with Hive
- Auth feature
- Users can log in or sign up and add new things in the home page

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

![image](https://r.resimlink.com/x9deB0n-msqS.png)
![image](https://r.resimlink.com/lWvS52.png)
![image](https://r.resimlink.com/FVrmgln-.png)
![image](https://r.resimlink.com/rSIYj1T69F.png)
![image](https://r.resimlink.com/ab1PIhfOE43.png)
![image](https://r.resimlink.com/Mz_b1yNBUrR.png)

Have a nice day!
