# Install-Update-Nextcloud
Bash script to install &amp; update the Nextcloud AppImage in Linux.

**Download & run the `install-or-update_Nextcloud.sh` file.**

If you want "automatic updates," create a cron job to run the script periodically.

*Example:*

Enter the following in your terminal:
`crontab -e`

Add the following lines to your crontab file:
```bash
#Search for Nextcloud updates every 4 hours & install them when an update is available.
0 */4 * * * /bin/bash /path/to/install-or-update_Nextcloud.sh
```
