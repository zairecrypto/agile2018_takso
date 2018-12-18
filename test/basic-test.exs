cd Desktop
mix new testing
cd testing
touch test/basic-test.exs

elixir -e "ExUnit.start()" -r basic-test.exs