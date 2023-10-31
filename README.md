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

4. Type chmod +x `authenticator.sh` and chmod +x `cleanup.sh` in the terminal and press enter. This will make the script executable.

5. Open the `config.sh` file, fill the `API_KEY` with your ArvanCloud API token

6. Install `certbot` and `jq` package

For Ubuntu/Debian:

```bash
sudo apt-get install certbot jq
```

For CentOS/RHEL:

```bash
sudo yum install certbot jq
```

7. Run the following command

```bash
certbot certonly --manual --manual-auth-hook ./authenticator.sh --manual-cleanup-hook ./cleanup.sh -d example.com -d *.example.com
```

8. Use the command `crontab -e` to open the cron jobs for renew certificates

```bash
crontab -e
```

9. Press `i` on the keyboard to insert a new line.

10. Type the following line

```bash
certbot renew --manual --manual-auth-hook /etc/letsencrypt/scripts/certbot-arvancloud/authenticator.sh --manual-cleanup-hook /etc/letsencrypt/scripts/certbot-arvancloud/cleanup.sh -d example.com -d *.example.com >> /etc/letsencrypt/scripts/certbot-arvancloud/certbot.renew.log
```

11. Press `Esc`.

12. Type `:wq` and press `Enter` to save the changes.

13. Now the script is ready to be used.
