# legacy-training
Example legacy app (joind.in) for workshops

## Database
```
mysql -u root
> create database joindin
```

```
mysql -u root joindin < joindin_example.sql
```

## Install dependencies

```
composer install
```

## Serving

```
sudo php -S 127.0.0.1:80
```

/etc/hosts
```
127.0.0.1 dev.joind.in
```

Browse to: 
 - http://dev.joind.in/event/view/52
 - http://dev.joind.in/talk/add/event/52


## Logs
system/logs/
