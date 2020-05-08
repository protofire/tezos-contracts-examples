type request is record
  callback : contract(int)
end

type action is
  | GetBar of (request)
  | SetBar of (int)

type store is record
  bar: int;
end

type return is list (operation) * store

function getBar (const r: request; var store: store): return is (list [Tezos.transaction(store.bar, 0mutez, r.callback)], store);

function setBar (const value : int ; var store : store) : return is ((nil : list (operation)), store with record [bar = value]);

function main (const action: action; var store: store): return is
  block {
    skip
  } with case action of
    | GetBar(n) -> getBar(n, store)
    | SetBar(n) -> setBar(n, store)
  end;