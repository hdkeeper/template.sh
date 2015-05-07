<VirtualHost $IP:$PORT>
	ServerName  $SITENAME
<if ${#ALIAS_LIST} -ne 0>
	ServerAlias $ALIAS_LIST
</if>
	ServerAdmin webmaster@$SITENAME
	DocumentRoot /home/$USERNAME/www
	CustomLog /home/$USERNAME/log/access.log combined
	ErrorLog  /home/$USERNAME/log/error.log
	<Directory "/home/$USERNAME/www">
		AllowOverride AuthConfig FileInfo Options Indexes Limit
		Allow from all
	</Directory>
	php_admin_value upload_tmp_dir /home/$USERNAME/tmp
	php_admin_value session.save_path /home/$USERNAME/tmp
	php_admin_value error_log /home/$USERNAME/log/php.log
	php_value include_path .:/home/$USERNAME/www/:
<if $USE_SSL = yes>
	SSLEngine on
	SSLCertificateFile      /home/$USERNAME/keys/$SITENAME.crt
	SSLCertificateKeyFile   /home/$USERNAME/keys/$SITENAME.key
</if>
</VirtualHost>
