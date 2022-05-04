# Foodtruck

This is a dead simple Phoenix LiveView app that allows a user to quickly search the names
and menus of the foodtrucks listed in the CSV file available at:
https://data.sfgov.org/api/views/rqzj-sfat/rows.csv

I used the `--no-ecto` option when setting it up because I didn't see any need for a
database.

As soon as the app sees a request for the index page (the only page) it grabs the latest
version of the CSV file from the endpoint using the HTTPoison library.  It then parses
the CSV and extracts the only three columns that it cares about: the truck's name, menu,
and address.

I am aware that using `Enum.at` is not recommended in Elixir for extracting items from a
list because it can be inefficient for large lists, but I was under time pressure and
this list is not likely to become of unmanageable length and I guess I don't have any
other solution at the tip of my fingers.

Upon the initial mount of the page the app sets a variable called `search` to `false` and
every row is simply displayed in a table.

There is a search bar in a form at the top and I use the `phx-change` and `phx-debounce`
functionality to listen to anything that the user types into this search box.  When the
`handle_event` method is called via `phx-change` I make a regex from the string that the
user has typed, set the `search` variable to `true`, and then put some if-else logic in
a loop in the `index_live.html.heex` template so that only rows that match the search
string are displayed.

I didn't want to duplicate the display logic for the rows in both the if and the else
parts, so I made a live component to display each row.

To start this app, just clone it, run `mix deps.get` and then `mix phx.server`
and then visition http://localhost:4000

I suppose I should have added some more tests, but I have not yet done much testing in
Elixir and I was already over my 3-hour time limit.  Adding a CSV file as a fixture and
then testing the search functionality would be the next step if I were to carry on this
project.



