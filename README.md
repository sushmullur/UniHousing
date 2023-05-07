# UniHousing App

This is a Flutter mobile application that connects students with people who have posted listings of properties with rooms available for students looking at housing accommodations and roommates. The app uses Supabase for the backend data management. The app allows users to view listings of housing options, view details about a listing, and post a listing.

## Getting Started

To get started with this project, you will need to have Flutter and Supabase set up on your machine.

### Prerequisites

- Flutter SDK installed on your machine. For more information on how to install Flutter, visit the [official documentation](https://flutter.dev/docs/get-started/install).
- A Supabase account. You can create an account for free at the [Supabase website](https://supabase.io/).

### Installation

1. Clone this repository to your machine using the following command:

   ```
   git clone https://github.com/<your_username>/UniHousing-App.git
   ```

2. In the project root directory, run the following command to install the dependencies:

   ```
   flutter pub get
   ```

3. Set up your Supabase project. Follow the [official Supabase documentation](https://supabase.io/docs/guides/api) to create your own Supabase project and retrieve your API endpoint and API key.

4. In the `lib` directory, create a file named `supabase_config.dart` with the following contents:

   ```dart
   import 'package:supabase/supabase.dart';

   final supabase = SupabaseClient(
     'YOUR_API_ENDPOINT',
     'YOUR_API_KEY',
   );
   ```

   Replace `YOUR_API_ENDPOINT` and `YOUR_API_KEY` with the values from your own Supabase project.

5. Run the app on a device or emulator using the following command:

   ```
   flutter run
   ```

## Features

- Users can view a list of available housing options.
- Users can view details about a housing listing.
- Users can post a housing listing.

## Contributing

If you want to contribute to this project, you can fork the repository and make changes on your own branch. Submit a pull request when you're ready to have your changes merged into the main branch.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
