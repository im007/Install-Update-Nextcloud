# Install & Update Nextcloud
Updating Nextcloud on Linux can be a hassle.

I developed a Bash script which streamlines the installation and updates of the Nextcloud AppImage.

## Running the script
**Download & run the `install-or-update_Nextcloud.sh` file.**

Make it executable by running: 

`chmod +x install-or-update_Nextcloud.sh`

## Automating Updates
**To enable "automatic updates," create a cron job that periodically runs the script.**

*Example:*

In your terminal, type:

`crontab -e`

Add the following lines to your crontab file (_please edit the "/path/to" with the path to the script_):
```bash
#Search for Nextcloud updates every 4 hours & install them when an update is available.
0 */4 * * * /path/to/install-or-update_Nextcloud.sh
```

With this setup, you'll have a convenient solution for installing and updating Nextcloud, along with a way to automate the process, ensuring your Nextcloud desktop client is always up-to-date.
