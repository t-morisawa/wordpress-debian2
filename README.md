# 概要

* sshエージェントを持つDebianを作るDockerfile
* そこにWordPress(LEMPベース)をpushするansible playbook

## 動作確認端末

* Docker in Mac
* debian 9.5

# 使用方法

## 起動方法
```
docker build . -t wordpress-debian2
docker run --privileged -d -p 2222:22 -p 8080:80 wordpress-debian2
ansible-playbook -i hosts site.yml --ask-pass --ask-sudo-pass
ホストで http://127.0.0.1:8080/ へアクセス
```

# 補足
* nginx, php-fpmについて、ansibleのserviceモジュールでの起動が出来なかったためcommandを利用している。
* [wordpress-debian](https://github.com/t-morisawa/wordpress-debian)はコンテナの中でansible-playbookを実行させていたが、こちらはホストOSからpushする形で構成管理している。
