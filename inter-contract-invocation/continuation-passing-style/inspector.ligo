type action is
  | GetFoo of (unit)
  | SetFoo of (int)

type store is record
  foo: int;
end

type return is list (operation) * store

const emptyOps: list(operation) = list end

// This is a record, in case we need to add more properties, remember this is an example
type request is record
  callback : contract(int)
end

const destinationContactAddress: address = ("KT1TYv6hZbP49w3ynnd2C6D3sv8DoW26yDYe" : address)

function getFoo(var store: store): return is
    block {
        // The entry point where the information will arrive in THIS contract
        const requested : request = record [
            callback =  case (Tezos.get_entrypoint_opt("%setFoo", Tezos.self_address) : option(contract(int))) of 
                            | Some (cb) -> cb
                            | None -> (failwith ("Not a contract"): contract (int))
                        end;
        ];

        // The entry point of the contract, from where we are going to obtain the information
        // Must be of the same type, request, see the "contract(request)"
        const destination : contract (request) =
            case (Tezos.get_entrypoint_opt ("%getBar", destinationContactAddress) : option (contract (request))) of
                | Some (cb) -> cb
                | None -> (failwith ("Entrypoint not found.") : contract (request))
            end;

    } with (list [Tezos.transaction (requested, 0mutez, destination)], store);

function setFoo (const value : int ; var store : store) : return is
    block { 
        patch store with record [foo = value]
    } with (emptyOps, store);

function main (const action: action; var store: store): return is
  block {
    skip
  } with case action of
    | GetFoo(n) -> getFoo(store)
    | SetFoo(n) -> setFoo(n, store)
  end;