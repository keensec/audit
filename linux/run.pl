#!/usr/bin/env perl

my @array_pre_flag = ();

$ARGC = @ARGV;
if($ARGC gt 0){
    print qq{usage: perl aj.pl};
    exit;}

$pre_cmd{'id'} = "echo result";

# 请将bash命令放于 " 符号间.
$pre_cmd{1} = "cat /etc/shadow | grep -v -e '^ *#' -e '^\$'";
# end
$pre_cmd{2} = "cat /etc/passwd | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{3} = "cat /etc/passwd | grep -v -e '^ *#' -e '^\$';cat /etc/shadow | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{4} = "cat /etc/ssh/sshd_config | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{5} = "cat /etc/pam.d/passwd | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{6} = "cat /etc/login.defs | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{7} = "cat /etc/pam.d/login | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{8} = "cat /etc/securetty | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{9} = "ps -elf | grep telnet";
$pre_cmd{10} = "ssh -V; cat /etc/ssh/sshd_config | grep -i 'Protocol' ";
$pre_cmd{11} = "echo 待定";
$pre_cmd{12} = "grep ^+: /etc/passwd /etc/shadow /etc/group";
$pre_cmd{13} = "ls -l /etc/passwd /etc/shadow /etc/group";
$pre_cmd{14} = "cat /etc/ssh/sshd_config | grep -v -e '^ *#' -e '^\$' | grep -i 'permitRootlogin'";
$pre_cmd{15} = "cat /etc/passwd | awk -F: '{print \$1}' | grep -v -e '^ *#' -e '^\$';echo; [ -f /var/adm/loginlog ] && echo '存在/var/adm/loginlog文件' || echo '/var/adm/loginlog 文件不存在' ";
$pre_cmd{16} = "cat /etc/pam.d/passwd";
$pre_cmd{17} = "ls -l /etc/passwd /etc/shadow /etc/group";
$pre_cmd{18} = "cat  /etc/bashrc | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{19} = "cat /etc/syslog.conf | grep -v -e '^ *#' -e '^\$';echo;last ";
$pre_cmd{20} = "cat /etc/syslog.conf";
$pre_cmd{21} = "for i in `cat /etc/passwd | grep sh\$ | awk -F: '{print \$1}'`; do cd ~\$i ;echo -e \"\$i 的history文件\n\";cat .bash_history | tail -n 100;cat .sh_history| tail -n 100;cat .csh_history | tail -n 100; echo -e \"\n\n\"; done";
$pre_cmd{22} = "cat /var/log/secure";
$pre_cmd{23} = "who /var/log/wtmp";
$pre_cmd{24} = "cat /var/log/messages";
$pre_cmd{25} = "echo 待定";
$pre_cmd{26} = "ls -l /var/log";
$pre_cmd{27} = "echo 待定";
$pre_cmd{28} = "cat /etc/syslog.conf | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{29} = "echo 待定";
$pre_cmd{30} = "cat /etc/hosts.allow /etc/hosts.deny |grep -v -e '^ *#' -e '^\$'";
$pre_cmd{31} = "cat /etc/profile | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{32} = "systemctl list-unit-files";
$pre_cmd{33} = "cat /etc/ntp.conf |grep -v -e '^ *#' -e '^\$'";
$pre_cmd{34} = "cat /etc/resolv.conf";
# 请将id的值以类似下面的方式push@array_pre_flag
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
#end

sub add_item{
    my ($string, $flag, $command)= @_;
    $result = `$command`;
    chomp $result;
    $string .= "\t".'<item flag="'.$flag.'">'."\n";
    if ( $result eq "result" ){
        $command = "command";
    }
    $string .= "\t\t<command><![CDATA[".$command."]]></command>\n";
    $string .= "\t\t<value><![CDATA[".$result."]]></value>\n";
    $string .= "\t</item>\n";
    return $string;
}
sub generate_xml{
    my $xml_string = "";
    $xml_string .='<?xml version="1.0" encoding="UTF-8"?>'."\n";
    $xml_string .='<?xml-stylesheet type="text/xsl" href="result.xsl"?>'."\n";
    $xml_string .= '<result>'."\n";
    foreach $key (@array_pre_flag){
        $command = $pre_cmd{$key};
        $xml_string = &add_item( $xml_string, $key, $command );
    }
    $xml_string .= "</result>"."\n";
    $xmlfile = "result.xml";
    print "generate ".$xmlfile."\n";
    open XML,">./".$xmlfile or die "Cannot create xml file:$!";
    print XML $xml_string;
    print "Done\n";}
generate_xml();
