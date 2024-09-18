import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Provider/search_provider.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 35,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(
                  color: Color.fromARGB(255, 153, 155, 157), Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(
                    color: Color.fromARGB(255, 153, 155, 157),
                    Icons.mic_none_rounded),
                onPressed: () {
                  final query = (context
                          .findAncestorWidgetOfExactType<TextField>()
                          ?.controller
                          ?.text ??
                      '');
                  if (query.isNotEmpty) {
                    searchProvider.performSearch(query);
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Color(0xFF005799), width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Color(0xFF005799), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Color(0xFF005799), width: 1.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        if (searchProvider.isLoading)
          const Center(child: CircularProgressIndicator())
        else
          Text(searchProvider.searchResult),
      ],
    );
  }
}
