let set_and_retrieve () =
  Config.read_and_place ".env";
  Alcotest.(check string) "Check HOST" "localhost" (Config.var ~key:"HOST");
  Alcotest.(check string) "Check DB_URL" "localhost:5463" (Config.var ~key:"DB_URL");
;;

let test_set =  [
  "\xF0\x9F\x90\xAB", `Quick, set_and_retrieve;
]

let () =
  Alcotest.run "Config Var tests" [
    "set_and_retrieve", test_set;
  ]
