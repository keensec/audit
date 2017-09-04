#!/usr/bin/env perl

my @array_pre_flag = ();

$ARGC = @ARGV;
if($ARGC gt 0){
    print qq{usage: perl aj.pl};
    exit;}

print "请输入mysql账号:";
$root = <STDIN>;
chomp $root;
print "请输入 $root 的密码:";
$password = <STDIN>;
chomp $password;
print "user=$root ,password=$password";
print "正确请回车,错误ctrl-c退出\n";
<STDINT>;

# mysql -uroot -p123 -e ""
# 请将bash命令放于 " 符号间.
# 请注意双引号" 和 $ 符号的转义.
$pre_cmd{'id'} = "echo result";
$pre_cmd{1} = "cat /etc/shadow | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{2} = "cat /etc/my.cnf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{3} = "cat /etc/passwd | grep mysql";
$pre_cmd{4} = "iptables -nvL";
$pre_cmd{5} = "mysql -u$root -p$password -e \"show variables like 'datadir';\"";
$pre_cmd{6} = "cat ~/.mysql_history";
$pre_cmd{7} = "echo $MYSQL_PWD";
$pre_cmd{8} = "cat /etc/passwd | grep mysql";
$pre_cmd{9} = "ps -ef | grep mysql";
$pre_cmd{10} = "netstat -lntp";
$pre_cmd{11} = "mysql -u$root -p$password -e \"show variables like 'datadir';\"";
$pre_cmd{12} = "mysql -u$root -p$password -e \"show variables like 'basedir';\"";

$pre_cmd{13} = "ll /etc/my.cnf";
$pre_cmd{14} = "ll /var/log/mariadb/mariadb.log";
$pre_cmd{15} = "mysql -u$root -p$password -e \"show variables like 'ssl_ca';\";mysql -e \"show variables like 'ssl_cert';\"mysql -e \"show variables like 'ssl_key';\"";
$pre_cmd{16} = "mysql -u$root -p$password -e \"show variables like 'log_error';\"";
$pre_cmd{17} = "mysql -u$root -p$password -e \"show variables like 'log_bin';\";cat /etc/my.cnf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{18} = "cat /etc/my.cnf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{19} = "mysql -u$root -p$password -e \"show variables like 'version';\"";
$pre_cmd{20} = "mysql -u$root -p$password -e \"show databases like 'test';\"";
$pre_cmd{21} = "mysql -u$root -p$password -e \"select user from mysql.user where user = 'root';\"";
$pre_cmd{22} = "mysql -u$root -p$password -e \"select User, Password from mysql.user where length(password) < 41;\"";
$pre_cmd{23} = "mysql -u$root -p$password -e \"select user from mysql.user where host = '%';\"";
$pre_cmd{24} = "mysql -u$root -p$password -e \"select user, password from mysql.user where length(password) = 0 or password is null;\"";
$pre_cmd{25} = "mysql -u$root -p$password -e \"select user from mysql.user where user = '';\"";
$pre_cmd{26} = "mysql -u$root -p$password -e \"select user, host from mysql.user where (Select_priv = 'Y') or (Insert_priv = 'Y') or (Update_priv = 'Y') or (Delete_priv = 'Y') or (Create_priv = 'Y') or (Drop_priv = 'Y');\";mysql -uroot -p123 -e \"select user, host from mysql.db where db = 'mysql' and ( (Select_priv = 'Y') or Insert_priv = 'Y') or (Update_priv = 'Y') or (Delete_priv = 'Y') or (Create_priv = 'Y') or (Drop_priv = 'Y');\"";
$pre_cmd{27} = "mysql -u$root -p$password -e \"select user, host from mysql.user where File_priv = 'Y';\"";
$pre_cmd{28} = "mysql -u$root -p$password -e \"select user, host from mysql.user where Process_priv = 'Y';\"";
$pre_cmd{29} = "mysql -u$root -p$password -e \"select user, host from mysql.user where Super_priv = 'Y';\"";
$pre_cmd{30} = "mysql -u$root -p$password -e \"select user, host from mysql.user where Shutdown_priv = 'Y';\"";
$pre_cmd{31} = "mysql -u$root -p$password -e \"select user, host from mysql.user where Create_user_priv = 'Y';\"";
$pre_cmd{32} = "mysql -u$root -p$password -e \"select user, host from mysql.user where Reload_user_priv = 'Y';\"";
$pre_cmd{33} = "mysql -u$root -p$password -e \"select user, host from mysql.user where Grant_priv = 'Y';\"";
$pre_cmd{34} = "mysql -u$root -p$password -e \"show variables like 'local_infile';\"";
$pre_cmd{35} = "mysql -u$root -p$password -e \"show variables like 'old_passwords';\"";
$pre_cmd{36} = "mysql -u$root -p$password -e \"show variables like 'safe_show_database';\"";
$pre_cmd{37} = "mysql -u$root -p$password -e \"show variables like 'secure_auth';\"";
$pre_cmd{38} = "mysql -u$root -p$password -e \"show variables like 'skip_grant_tables';\"";
$pre_cmd{39} = "mysql -u$root -p$password -e \"show variables like 'have_merge_engine';\"";
$pre_cmd{40} = "mysql -u$root -p$password -e \"show variables like 'skip_networking';\"";
$pre_cmd{41} = "mysql -u$root -p$password -e \"select @@global.sql_mode;\"";
$pre_cmd{42} = "mysql -u$root -p$password -e \"select @@session.sql_mode;\"";
$pre_cmd{43} = "mysql -u$root -p$password -e \"show variables like 'have_symlink';\"";
$pre_cmd{44} = "mysql -u$root -p$password -e \"show variables like 'have_openssl';\"";
$pre_cmd{45} = "mysql -u$root -p$password -e \"show variables like 'ssl_cert';\"";
$pre_cmd{46} = "mysql -u$root -p$password -e \"show variables like 'ssl_key';\"";
$pre_cmd{47} = "mysql -u$root -p$password -e \"show variables like 'ssl_ca';\"";

# $pre_cmd{48} = "mysql -u$root -p$password -e """;
# $pre_cmd{49} = "mysql -u$root -p$password -e """;

push(@array_pre_flag, 'id');
push(@array_pre_flag, 1);
push(@array_pre_flag, 2);
push(@array_pre_flag, 3);
push(@array_pre_flag, 4);
push(@array_pre_flag, 5);
push(@array_pre_flag, 6);
push(@array_pre_flag, 7);
push(@array_pre_flag, 8);
push(@array_pre_flag, 9);
push(@array_pre_flag, 10);
push(@array_pre_flag, 11);
push(@array_pre_flag, 12);
push(@array_pre_flag, 13);
push(@array_pre_flag, 14);
push(@array_pre_flag, 15);
push(@array_pre_flag, 16);
push(@array_pre_flag, 17);
push(@array_pre_flag, 18);
push(@array_pre_flag, 19);
push(@array_pre_flag, 20);
push(@array_pre_flag, 21);
push(@array_pre_flag, 22);
push(@array_pre_flag, 23);
push(@array_pre_flag, 24);
push(@array_pre_flag, 25);
push(@array_pre_flag, 26);
push(@array_pre_flag, 27);
push(@array_pre_flag, 28);
push(@array_pre_flag, 29);
push(@array_pre_flag, 30);
push(@array_pre_flag, 31);
push(@array_pre_flag, 32);
push(@array_pre_flag, 33);
push(@array_pre_flag, 34);
push(@array_pre_flag, 35);
push(@array_pre_flag, 36);
push(@array_pre_flag, 37);
push(@array_pre_flag, 38);
push(@array_pre_flag, 39);
push(@array_pre_flag, 40);
push(@array_pre_flag, 41);
push(@array_pre_flag, 42);
push(@array_pre_flag, 43);
push(@array_pre_flag, 44);
push(@array_pre_flag, 45);
push(@array_pre_flag, 46);
push(@array_pre_flag, 47);
#end

sub add_item{
    my ($string, $flag, $value)= @_;
    $result = `$value`;
    chomp $result;
    $string .= "\t".'<item flag="'.$flag.'">'."\n";
    if ( $result eq "result" ){
        $value = "command";
    }
    $string .= "\t\t<command><![CDATA[".$value."]]></command>\n";
    $string .= "\t\t<value><![CDATA[".$result."]]></value>\n";
    $string .= "\t</item>\n";
    return $string;
}
sub generate_xml{
    my $xml_string = "";
    $xml_string .='<?xml version="1.0" encoding="UTF-8"?>'."\n";
    $xml_string .= '<result>'."\n";
    foreach $key (@array_pre_flag){
        $value = $pre_cmd{$key};
        $xml_string = &add_item( $xml_string, $key, $value );
    }
    $xml_string .= "</result>"."\n";
    $xmlfile = "result.xml";
    print "generate ".$xmlfile."\n";
    open XML,">./".$xmlfile or die "Cannot create xml file:$!";
    print XML $xml_string;
    print "Done\n";}
generate_xml();
