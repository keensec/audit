#!/usr/bin/env perl

my @array_pre_flag = ();

$ARGC = @ARGV;
if($ARGC gt 0){
    print qq{usage: perl aj.pl};
    exit;}

print "请手动确认 apache 配置主文件地址和 documentRoot 对应目录地址\n";
`sleep 1`;
print "apache2配置文件的路径是:\n1:/etc/apache2/apache2.conf\n2:/etc/httpd/conf/httpd.conf\n3:手动输入\n";
print "请输入序号(1 or 2 or 3):";
$tmp1 = <STDIN>;
chomp $tmp1;
if ( $tmp1 eq 1){
    $conf = "/etc/apache2/apache2.conf";
}elsif($tmp1 eq 2){
    $conf = "/etc/httpd/conf/httpd.conf";
}else{
    print "请输入apache配置文件的地址:";
    $conf=<STDIN>;
}
chomp $conf;
print "apache2 虚拟主机目录是:\n1:/var/www\n2:手动输入\n";
$tmp2 = <STDIN>;
chomp $tmp2;
if ($tmp2 eq 1){
    $host = "/var/www";
}else{
    print "请输入apache虚拟主机目录地址:";
    $host = <STDIN>;
}
chomp $host;
print "apache2配置文件的路径是: $conf ,apache2虚拟主机目录地址: $host ,确认请回车,否则请退出Ctrl-c\n";
<STDIN>;

# 请将bash命令放于 " 符号间.
# 请注意双引号" 和 $ 符号的转义.
$pre_cmd{'id'} = "echo result";
$pre_cmd{1} = "ps -ef | grep httpd";
$pre_cmd{2} = "ls -l $host";
$pre_cmd{3} = "ls -l $conf;ls -l /var/log/httpd/;ls -l /var/log/apache2/";
$pre_cmd{4} = "cat $conf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{5} = "echo '命令:ls -l /usr/local/apache2/htdocs/的结果是:';ls -l /usr/local/apache2/htdocs/;echo '命令:ls -l /usr/local/apache2/htdocs/的结果是:';ls -l /usr/local/apache2/cgi-bin/;echo '命令:ls -l /usr/local/apache2/manual的结果是:';ls -l /usr/local/apache2/manual";
$pre_cmd{6} = "cat $conf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{7} = "cat $conf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{8} = "cat $conf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{9} = "cat $conf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{10} = "cat $conf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{11} = "cat /var/log/httpd/error*;cat /var/log/apache2/error*";
$pre_cmd{12} = "apachectl -v;rpm -q httpd;rpm -q httpd";
$pre_cmd{13} = "cat $conf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{14} = "cat $conf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{15} = "cat $conf | grep -v -e '^ *#' -e '^\$'";

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
#end
#test

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
