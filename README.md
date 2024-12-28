---

# McPlugin Installer

Welcome to the **McPlugin Installer** by [XreatLabs](https://github.com/Xreatlabs)!  
This advanced script provides a unified solution for downloading and managing plugins and mods for Minecraft servers. It integrates with the APIs of **SpigotMC**, **Modrinth**, and **Hangar** to simplify the plugin and mod installation process.

---

## Features

- 🛠️ **Unified Plugin/Mod Installation**  
  Search and install plugins/mods from **SpigotMC**, **Modrinth**, and **Hangar** through a single interface.
  
- 📂 **Resource Management**  
  Easily view and manage all downloaded plugins/mods in a designated folder.

- 🧹 **Clear Resources**  
  Quickly delete all downloaded resources with a confirmation prompt.

- 🖥️ **Clean UI with XreatLabs Branding**  
  Includes an ASCII logo and a well-structured terminal interface.

---

## Getting Started

### Prerequisites
Ensure the following tools are installed on your system:
- **curl** (for API requests)
- **jq** (for parsing JSON)

You can install them using the following commands:
```bash
sudo apt update
sudo apt install -y curl jq


---

Installation

1. Clone the Repository

git clone https://github.com/Xreatlabs/McPlugin-installer.git
cd McPlugin-installer


2. Make the Script Executable

chmod +x mcplugin_installer.sh


3. Run the Installer

./mcplugin_installer.sh




---

Usage

1. Run the Script
Start the installer using:

./mcplugin_installer.sh


2. Main Menu Options

1️⃣ Install Plugin or Mod (Unified Search):
Enter the name of a plugin or mod to search across SpigotMC, Modrinth, and Hangar.

2️⃣ Show Downloaded Resources:
Displays all resources stored in the resources folder.

3️⃣ Clear All Downloaded Resources:
Deletes all downloaded files after confirmation.

4️⃣ Exit:
Exits the script.



3. Example Usage

To install the "EssentialsX" plugin:

Choose option 1.

Enter essentialsx when prompted.


The script will search all platforms and download the plugin from the first match.





---

Directory Structure

The following structure will be created upon running the script:

McPlugin-installer/
├── mcplugin_installer.sh  # Main script
├── resources/             # Folder for downloaded plugins/mods
└── README.md              # Project documentation

All downloaded resources will be stored in the resources/ directory.


---

Contributing

We welcome contributions from the community! To contribute:

1. Fork the Repository
Click the "Fork" button in the top-right corner of this page.


2. Clone Your Fork

git clone https://github.com/<your-username>/McPlugin-installer.git
cd McPlugin-installer


3. Create a New Branch

git checkout -b feature-branch-name


4. Make Changes
Edit the script or add new features.


5. Commit Changes

git add .
git commit -m "Add your message here"


6. Push Changes

git push origin feature-branch-name


7. Create a Pull Request
Open a pull request on the original repository to merge your changes.




---

License

This project is licensed under the MIT License.
See the LICENSE file for details.


---

Acknowledgments

Special thanks to:

SpigotMC, Modrinth, and Hangar for their APIs.

The Minecraft community for inspiration and feedback.



---
Developed with ❤️ by XreatLabs

---
