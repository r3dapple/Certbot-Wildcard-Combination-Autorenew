# Certbot-Wildcard-Combination-Autorenew
This script autorenews a certificate that contains the wildcard certficate and the top-domain certificate

__So you get one certificate to rule them all. One certificate for all subdomains.__

So if you want to obtain a top level letsencrypt certificate, e.g. for r3dapple.de, certbot pretty much does everything for you. It uses the http-01 challenge which puts a file with a specific content under /var/www/r3dapple.de/.well-known/acme-challenge/, the letsencrypt server checks it and your certificate is authenticated

But if you want to have a wildcard certificate, which is a certificate for all your subdomains, your gonna have to do a dns-01 challenge. With the script provided under https://certbot.eff.org/docs/using.html?highlight=renew#pre-and-post-validation-hooks and your DNS server change to cloudflair this is also pretty doable.

But sadly the wildcard certificate \*.r3dapple.de does not include the top level certificate r3dapple.de. You could create seperate certificates with seperate virtual hosts but you can also combine them into one super certificate for your entire page.

These hooks automate the renewal of said super certificate.

The certbot command to start it is:

sudo certbot certonly --manual-public-ip-logging-ok --noninteractive --manual --manual-auth-hook /path/to/authenticator.sh --manual-cleanup-hook /path/to/cleanup.sh -d \*.r3dapple.de -d r3dapple.de
