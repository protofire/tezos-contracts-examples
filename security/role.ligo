// Allowed roles, you can add a new annotation right here, for example 'Dev' or 'Moderator'
type role is Admin | User | NoRole

type action is
  | MakeAdmin of (address)
  | MakeUser of (address)
  | RemoveRole of (address)

type store is record
  users: big_map(address, role);
end  

type return is list(operation) * store

// Function that checks if an account is an User role
// Must be integrated into functions that can only be used by an User 
function isUser (const addressOwner : address; var store : store) : bool is
  block {
    var isUser: bool := case Big_map.find_opt(addressOwner, store.users) of
      | None -> False
      | Some(userRole) ->
          case userRole of
            | Admin -> False
            | NoRole -> False
            | User -> True
          end
    end;
  } with isUser;

// Function that checks if an account is an Admin role
// Must be integrated into functions that can only be used by an Admin 
function isAdmin (const addressOwner : address; var store : store) : bool is
  block {
    var isAdmin: bool := case Big_map.find_opt(addressOwner, store.users) of
      | None -> False
      | Some(userRole) ->
          case userRole of
            | Admin -> True
            | NoRole -> False
            | User -> False
          end
    end;
  } with isAdmin;

// Add/Update an account with an Admin role
function makeAdmin (const userAddress : address; var store : store) : return is
  block {
    const newUsers : big_map(address, role) = Big_map.update(userAddress, Some(Admin), store.users);
  } with ((nil : list (operation)), store with record [users = newUsers;]);

// Add/Update an account with an User role
function makeUser (const userAddress : address; var store : store) : return is
  block {
    const newUsers : big_map(address, role) = Big_map.update(userAddress, Some(User), store.users);
  } with ((nil : list (operation)), store with record [users = newUsers;]);

// Remove a role to some user
function removeRole (const userAddress : address; var store : store) : return is
  block {
    const newUsers : big_map(address, role) = Big_map.update(userAddress, Some(NoRole), store.users);
  } with ((nil : list (operation)), store with record [users = newUsers;]);

function main (const action: action; var store: store): return is
  block {
    skip
  } with case action of
    | MakeAdmin(n) -> makeAdmin(n, store)
    | MakeUser(n) -> makeUser(n, store)
    | RemoveRole(n) -> removeRole(n, store)
  end;