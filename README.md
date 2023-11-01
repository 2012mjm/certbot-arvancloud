# certbot DNS challenge hook for ArvanCloud CDN

## Usage

In order to use this script, follow these simple steps:

1. Run the following command in /etc/letsencrypt/scripts

```bash
cd /etc/letsencrypt/scripts
```

2. Clone the project

```bash
git clone https://github.com/javadmsd/certbot-arvancloud.git
```

3. Type `cd certbot-arvancloud` and press enter. You should now be in the certbot-arvancloud directory

4. Type `chmod +x authenticator.sh` and `chmod +x cleanup.sh` in the terminal and press enter. This will make the script executable.

5. Open the `config.sh` file, fill the `API_KEY` with your ArvanCloud API token

6. Install `certbot` package

```bash
sudo apt update
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
certbot --version
```

7. Install `jq` package

```bash
sudo apt-get install jq
```

8. Run the following command

```bash
certbot certonly --manual --manual-auth-hook ./authenticator.sh --manual-cleanup-hook ./cleanup.sh -d *.example.com
```

If you do not receive the following message at the end, continue with the steps

```
Certbot has set up a scheduled task to automatically renew this certificate in the background.
```

9. If Use the command `crontab -e` to open the cron jobs for renew certificates

```bash
crontab -e
```

10. Press `i` on the keyboard to insert a new line.

11. Type the following line

```bash
certbot renew --manual --manual-auth-hook /etc/letsencrypt/scripts/certbot-arvancloud/authenticator.sh --manual-cleanup-hook /etc/letsencrypt/scripts/certbot-arvancloud/cleanup.sh -d *.example.com >> /etc/letsencrypt/scripts/certbot-arvancloud/certbot.renew.log
```

12. Press `Esc`.

13. Type `:wq` and press `Enter` to save the changes.

14. Now the script is ready to be used.
