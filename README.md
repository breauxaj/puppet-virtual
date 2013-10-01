virtual
=======

Enable the automatic installion of the VMware Tools Operating System Specific
Packages using yum. The fact evaluates the VM to determine which version of ESX
the host is running and installs the corresponding tools.

This module only fingerprints 3 known ESX versions, 4.1, 5.0 and 5.1.

Samples
-------
```
include virtual
```
