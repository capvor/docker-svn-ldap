# svnldap



```shell
docker run -d --name my_svnldap \
  --network test-tier \
  -p 52121:443 \
  -v /root/my/svn_data:/var/svn \
  -e AUTH_NAME='"Example.Inc Subversion Repository"' \
  -e AUTH_LDAP_URL='"ldap://host/ou=Users,dc=Example?uid"' \
  -e AUTH_LDAP_BIND_DN='"cn=Manager,dc=Example"' \
  -e AUTH_LDAP_BIND_PW='"secret"' \
  capvor/svnldap
```

https://ip:52121/svn/



authz文件是SVN授权文件的模板，如果之前在/var/svn下没有authz文件，需要将其拷贝过去。


## 创建SVN仓库
```
# 进入容器
docker exec -it container /bin/bash
# 切换用户身份为 www-data
su - www-data -s /bin/bash

# 切换到/var/svn目录下，并创建svn仓库
cd /var/svn
svnadmin create repos1

# 编辑 /var/svn/authz 文件，配置仓库授权
vi /var/svn/authz

```

