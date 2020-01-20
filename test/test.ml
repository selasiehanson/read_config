let set_and_retrieve () =
  Read_config.read_and_place "../../../.env";
  Alcotest.(check string) "Check HOST" "localhost" (Read_config.var ~key:"HOST");
  Alcotest.(check string)
    "Check DB_URL" "localhost:5463"
    (Read_config.var ~key:"DB_URL");
  Alcotest.(check string)
    "Check STRING_KEY" "HELLO"
    (Read_config.var ~key:"STRING_KEY");
  Alcotest.(check string)
    "Check HOST_WITH_QUOTES_AND_EQUALS" "localhost=127.0.0.1"
    (Read_config.var ~key:"HOST_WITH_QUOTES_AND_EQUALS")

let test_set = [ ("\xF0\x9F\x90\xAB", `Quick, set_and_retrieve) ]

let () = Alcotest.run "Read_config Var tests" [ ("set_and_retrieve", test_set) ]
