// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Provider/signup_provider.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _MySignuppageState();
}

class _MySignuppageState extends State<Signuppage> {
  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                // ignore: duplicate_ignore
                // ignore: prefer_const_constructors
                Text(
                  'Nowhere News',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(30, 30, 0, 20),
                  child: Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 6),
                      child: Text('Username',
                          style: Theme.of(context).textTheme.bodyMedium),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: TextField(
                    onChanged: (value) => signupProvider.setUsername(value),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                    decoration: InputDecoration(
                      hintText: 'username',
                      contentPadding: EdgeInsets.all(8),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color:
                                Color(0xFF005799), // Border color when focused
                            width: 1.0,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ), // Adds a border
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 6),
                      child: Text('Email',
                          style: Theme.of(context).textTheme.bodyMedium),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: TextField(
                    onChanged: (value) => signupProvider.setEmail(value),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.all(8),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color:
                                Color(0xFF005799), // Border color when focused
                            width: 1.0,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ), // Adds a border
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 6),
                      child: Text('Password',
                          style: Theme.of(context).textTheme.bodyMedium),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: TextField(
                    onChanged: (value) => signupProvider.setPassword(value),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color:
                                Color(0xFF005799), // Border color when focused
                            width: 1.0,
                          )),
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ), // Adds a border
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 0, 6),
                      child: Text('Confirm Password',
                          style: Theme.of(context).textTheme.bodyMedium),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    onChanged: (value) =>
                        signupProvider.setConfirmPassword(value),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color:
                                Color(0xFF005799), // Border color when focused
                            width: 1.0,
                          )),
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ), // Adds a border
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF005799),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          signupProvider.submit();
                        },
                        child: Text(
                          'Sign Up',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white, // Override the color
                                  ),
                        )),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFF005799), // Custom color
                        thickness: 1, // Custom thickness
                        indent: 70, // Indent from the left
                        endIndent: 10, // Indent from the right
                        height: 40,
                      ),
                    ),
                    Text(
                      'Or',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Color(0xFF005799),
                            fontWeight: FontWeight.w400, // Override the color
                          ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFF005799), // Custom color
                        thickness: 1, // Custom thickness
                        indent: 10, // Indent from the left
                        endIndent: 70, // Indent from the right
                        height: 40,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          side: BorderSide(
                            color: Color(0xFF005799), // Blue border color
                            width: 1.0, // Border thickness
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Rounded corners
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'G+ Sign in with Google',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Color(0xFF005799), // Override the color
                              ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
