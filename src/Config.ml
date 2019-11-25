open Core
open Stdio
(* 1. read files in directory. Try to look for a .env file *)
(* 2. If absent do nothing *)
(* 3. if present evaluate against current env by setting *)

(* we should probably keep a map to keep things in memory *)

let parse_line line =
  match String.split line ~on: '=' with
  | k :: v :: _ -> Some (k, v)
  | _ -> None


let place_env  ~key ~value =
  Unix.putenv ~key ~data:value

let load_file file =
  In_channel.with_file file ~f: (fun inc ->
    In_channel.input_lines inc
  |> List.map ~f:parse_line
  )

let read_config_file file =
  let result = match Sys.file_exists file with
  | `Yes -> true
  | `No -> false
  | `Unknown -> false
  in
  match result with
  | true -> load_file file
  | false  -> []

(* Public interface *)
(* todo. Confi.mli file *)
let var ~key =
  match Sys.getenv key with
  | Some (value) -> value
  | None -> ""


let read_and_place file =
  List.iter (read_config_file file) ~f:(fun env_var ->
    match env_var with
    | Some (k, v) -> place_env ~key:k ~value: v
    | None -> ()
    )
