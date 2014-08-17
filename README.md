# LAMP環境の開発環境を作成

## Vitural Box,Vagrant,Chef,knife-soloのインストール
#### Vitural Box
[こちら](https://www.virtualbox.org/wiki/Downloads)からインストール
#### Vagrant
gemを使って、インストール
```bash
gem install vagrant
```
#### Chef
```bash
gem install chef
```
#### knife-solo
```bash
gem install knife -solo
```
## 各種ソースコードをclone
適当なディレクトリで以下を実行
#### lamp-vagrant
```bash
git clone git@github.com:tatsuya2027/lamp-vagrant.git
```
#### yum,yum-repl,yum-ius
lamp-vagrantディレクトリで以下を実行
```bash
cd chef/site-cookbooks/
git clone https://github.com/opscode-cookbooks/yum.git
git clone https://github.com/opscode-cookbooks/yum-ius
git clone https://github.com/opscode-cookbooks/yum-epel
```
## VMの立ち上げ
lamp-vagrant/chefで以下を実行
```bash
vagrant up
vagrant ssh-config --host magento >> ~/.ssh/config
```
## knife-soloの実行
同じディレクトリで以下を実行
```bash
knife solo prepare magento
knife solo cook magento
```
## VMが正常に動いているかを確認
```bash
ssh magento
```
でVMに入り、
```bash
php -v
httpd -v
```
できちんとバージョンが出ていればOK
