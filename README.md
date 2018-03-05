# Local Dev Tools

### Setup

To run a local site, check out this repo and the repo of the site that you would like to run locally.

i.e.

```bash
git clone git@github.com:500RocketsMarketing/wp-local-dev.git
git clone git@github.com:500RocketsMarketing/wp-test-site.git
```

You will need to move the html folder and the initdata.sql files from your site repo into the local dev repo

i.e.

```bash
cp -r wp-test-site/html/ wp-local-dev/docker/
cp wp-test-site/initdata.sql wp-local-dev/docker/
```

Anytime the site repo changes you will need to 'git pull' and re-run
the above commands to copy in the new changes from git.

Open the file named rewrite_urls.sql and change all occurances of the word CHANGEME to the hostname
of the staging site you launching locally. For instance, if you were trying to boot 500 rockets main
site locally, use staging.500rockets.io as the value.

Once you have updated sql file execute run_url_rewrite.sh to run the sql.

```bash
./run_url_rewerite.sql
```

### Boot Site

To create the site fresh:

```bash
./create_site.sh
```

To reload the database without effecting file content:

```bash
./reload_db.sh
./run_url_rewrite.sh
```

To reload the file content without reloading the database:

```bash
./reload_files.sh
```

## Checkin changes to git

After you have modified things on your local site and you want to checkin, move the checkin_changes.sh
script into your site repo and execute it. This will copy the data out of the docker container into the 
current directory. Then git commit and push as normal

```bash
cp wp-local-dev/checkin_changes.sh wp-test-site
cd test-site
./checkin_changes.sh
git add -A .
git commit -m "messsage here"
git push
```
