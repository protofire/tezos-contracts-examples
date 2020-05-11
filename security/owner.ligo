type action is AddOwner of (address)

// An unordered collections of owner accounts 
type store is record
  owners: set(address);
end  

type return is list(operation) * store

// Function that checks if an account is an owner
// Must be integrated into functions that can only be used by an owner 
function isOwner (const addressOwner : address; var store : store) : bool is store.owners contains addressOwner;

// Function that add an owner to the unordered collections of owners in the storage
function addOwner (const newOwnerAddress : address; var store : store) : return is
  block {
    const newOwners : set(address) = Set.add(newOwnerAddress, store.owners)
  } with ((nil : list (operation)), store with record [owners = newOwners;]);

function main (const action: action; var store: store): return is
  block {
    skip
  } with case action of
    AddOwner(n) -> addOwner(n, store)
  end;