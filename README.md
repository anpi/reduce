# No expiration

This is a Junction 2019 hackathon submission by Antti Aalto.
The code was written during the 44 hour competition. Because I'm an adult, I also
slept during the nights.

The corresponding backend is in [anpi/reduce-api](https://github.com/anpi/reduce-api).

# Motivation
Food left to rot in fridges and pantries is a major source of food waste. According to my pre-hackathon user research, the main reasons are consuming leftover are that a) people forget about their perishables and b) combining arbitrary ingredients is hard.
This app reminds you of those items when you enter a store and recommends you receipts that help you consume them with minimal effort.

# Product design
The app solves the problem of forgotten fruits by recommending recipes that most help them to consume their current potentially expiring products. To nudge the customer to reduce waste, the app sends a notification about perishables. When the customer opens the app, it shows a list of recipes ranked by how many risky items they contain. The customer can then use the recipe as a shopping list.

# Implementation
I implemented a mobile app using Flutter and an HTTP API using Finch. The app is multi-platform and can be run under both iOS and Android, and in order to use it had to learn the framework during the hackathon. I must say it's a truly beautiful framework.

Finch demonstrates a purely functional programming in writing a Scala backend. It uses the past purchase data provided by Kesko to look for potentially perishable products. It then calls the product and recipe search APIs to find recipes that most help the customer consume the perishables.

The biggest challenge was combining the past purchases with recipes, because the data models lacked common identifiers. This was solved with a tedious session of command line magic. The end result shows a surprisingly robust solution for a single customer, although I did not have time to finish the beacon part.
