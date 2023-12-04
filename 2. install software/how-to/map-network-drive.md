# How-To: Map a network drive to windows explorer

> Requires `sshfs` installed (`sshfs-np` via scoop)

## Example

```
net use <drive letter>: \\sshfs\<username>@<address>
```

```
net use S: \\sshfs\admin@example.com
```

