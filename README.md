virtual
=======

Enable the automatic installion of the VMware Tools Operating System Specific
Packages using yum. The fact evaluates the VM to determine which version of ESX
the host is running and installs the corresponding tools.

This module only fingerprints 2 known ESX versions, 4.1 and 5.0.

Samples
-------
```
include virtual
```