### Ownership (owner.ligo):
Sometimes we need to add simple authorization and access control mechanisms to our contract. This example allows some users to perform some exclusive access to specific functions. This can be useful for simple systems or just quick prototyping.

### Owner dry-run commands

<pre><code>
ligo dry-run owner.ligo --format=json --syntax=pascaligo  main 'AddOwner(("tz1MbY6h2rAVGECbMj987EyrhBrqt6eoX9Q9": address))' 'record [owners = (set [] : set(address));]'
</code></pre>

<pre><code>
ligo dry-run owner.ligo --format=json --syntax=pascaligo  main 'AddOwner(("tz1MbY6h2rAVGECbMj987EyrhBrqt6eoX9Q9": address))' 'record [owners = set [("tz1h87vXP6GgNXnSyJFZsFvWCaTJdicAd5d8": address)];]'
</code></pre>

### Roles access control (role.ligo):
On occasions different levels of authorization are often needed. A role is an abstract name for the permission to access a particular set of resources or entry points
Its usage is easy, for each role that you want to define you can add as a union type annotation. We manage a big_map that holds the list of accounts with that role.


### Role dry-run commands

<pre><code>
ligo dry-run role.ligo --format=json --syntax=pascaligo  main 'MakeAdmin(("tz1MbY6h2rAVGECbMj987EyrhBrqt6eoX9Q9": address))' 'record [users = big_map [("tz1MbY6h2rAVGECbMj987EyrhBrqt6eoX9Q9": address) -> User];]'
</code></pre>

<pre><code>
ligo dry-run role.ligo --format=json --syntax=pascaligo  main 'MakeAdmin(("tz1MbY6h2rAVGECbMj987EyrhBrqt6eoX9Q9": address))' 'record [users = (big_map []: big_map(address, role));]'
</code></pre>

<pre><code>
ligo dry-run role.ligo --format=json --syntax=pascaligo  main 'MakeUser(("tz1MbY6h2rAVGECbMj987EyrhBrqt6eoX9Q9": address))' 'record [users = big_map [("tz1MbY6h2rAVGECbMj987EyrhBrqt6eoX9Q9": address) -> Admin];]'
</code></pre>

<pre><code>
ligo dry-run role.ligo --format=json --syntax=pascaligo  main 'RemoveRole(("tz1MbY6h2rAVGECbMj987EyrhBrqt6eoX9Q9": address))' 'record [users = big_map [("tz1MbY6h2rAVGECbMj987EyrhBrqt6eoX9Q9": address) -> Admin];]'
</code></pre>
