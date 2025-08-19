# AddToTask

**AddToTask** is a PowerShell script designed to add devices (computers) to a scheduled task in **IVANTI Endpoint Manager (EPM)**. This script features a simple graphical user interface (GUI) for entering a task ID and a list of computers.

## Features
- User-friendly GUI built with WPF.
- Quickly adds multiple machines to a scheduled task.
- Leverages a web service to interact with IVANTI Endpoint Manager.

## Prerequisites
- **PowerShell**: Version 5.1 or higher.
- **.NET Framework**: Ensure PowerShell is configured to run scripts with a graphical interface (STA mode).
- Credentials with access to IVANTI Endpoint Manager services.

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/DavidWuibaille/IVANTI.git
   cd IVANTI/AddToTask
