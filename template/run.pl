#!/usr/bin/env perl

my @array_pre_flag = ();

$ARGC = @ARGV;
if($ARGC gt 0){
    print qq{usage: perl aj.pl};
    exit;}

# 请将bash命令放于 " 符号间.
# 请注意双引号" 和 $ 符号的转义.
$pre_cmd{'id'} = "echo result";
$pre_cmd{1} = "cat /etc/shadow | grep -v -e '^ *#' -e '^\$'";

push(@array_pre_flag, 'id');
push(@array_pre_flag, 1);
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
    $xml_string .='<?xml-stylesheet type="text/xsl" href="result.xsl"?>'."\n";
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
