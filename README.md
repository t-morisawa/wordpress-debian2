# 概要

* sshエージェントを持つDebianを作るDockerfile
* そこにWordPress(LEMPベース)をpushするansible playbook

## 動作確認端末

* Docker in Mac
* debian 9.5

# 使用方法
## 事前準備
### HTTPS化をしない場合

HTTPS化をしない場合は、site.ymlの `letsencrypt` の行を削除してください。


### HTTPS化をする場合

hostsを編集してください。
証明書生成時に必要なメールアドレスとホスト名を指定する必要があります。
デタラメなメールアドレスを入力した場合エラーになります。

```
[wordpress-server]
xxx.xxx.xxx.xxx ansible_ssh_user=foo server_hostname=example.com letsencrypt_email=me@example.com
```


## ローカル起動方法
```
docker build . -t wordpress-debian2
docker run --privileged -d -p 2222:22 -p 8080:80 wordpress-debian2
ansible-playbook -i hosts site.yml --ask-pass --ask-sudo-pass
ホストで http://127.0.0.1:8080/ へアクセス
```

ansible-playbook実行時に求められるSSHパスワードは `testuser`

sudoパスワードは初回実行時に設定する。

## リモート起動方法

1. hostsを編集してIPとSSHユーザ名を指定する
```
[wordpress-server]
xxx.xxx.xxx.xxx ansible_ssh_user=foo
# 127.0.0.1 ansible_ssh_user=testuser ansible_ssh_port=2222
```

2. 環境構築を行う
```
ansible-playbook -i hosts site.yml
```

3. hostsに記載したURLへアクセスする
```
http://xxx.xxx.xxx.xxx
```

WPなり設定画面なりが見えていればOK

### GCPの場合

インスタンスにSSHログインできるようにしておく必要がある。
https://console.cloud.google.com/compute/metadata/sshKeys

ここで指定したユーザ名が、ansible_ssh_userとなる

# 補足
* nginx, php-fpmについて、ansibleのserviceモジュールでの起動が出来なかったためcommandを利用している。
* [wordpress-debian](https://github.com/t-morisawa/wordpress-debian)はコンテナの中でansible-playbookを実行させていたが、こちらはホストOSからpushする形で構成管理している。
