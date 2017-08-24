#!/usr/bin/perl

# Backuppc
use lib "/usr/local/BackupPC/lib";
use BackupPC::Lib;
use BackupPC::CGI::Lib;

#Other
use Data::Dumper;

# Globals
$bpc = BackupPC::Lib->new();
$hosts = $bpc->HostInfoRead();

# Collect Data
GetStatusInfo("jobs queueLen info");
&hosts_info();


# Functions
sub hosts_info
{
	print '{  "data":['."\n";
        my $comma='';
	while ( my ($host, $value) = each(%$hosts) )
	{
           print $comma.'    {"{#BACKUPHOST}":"'.$host.'"}'."\n";
           $comma=",";
        }
        print "  ]}";
}



sub GetStatusInfo
{
    my($status) = @_;
    ServerConnect();
    %Status = ()     if ( $status =~ /\bhosts\b/ );
    %StatusHost = () if ( $status =~ /\bhost\(/ );
    my $reply = $bpc->ServerMesg("status $status");
    $reply = $1 if ( $reply =~ /(.*)/s );
    eval($reply);
    # ignore status related to admin and trashClean jobs
    if ( $status =~ /\bhosts\b/ ) {
        foreach my $host ( grep(/admin/, keys(%Status)) ) {
            delete($Status{$host}) if ( $bpc->isAdminJob($host) );
        }
        delete($Status{$bpc->trashJob});
    }
}

#
# Returns the list of hosts that should appear in the navigation bar
# for this user.  If $getAll is set, the admin gets all the hosts.
# Otherwise, regular users get hosts for which they are the user or
# are listed in the moreUsers column in the hosts file.
#
sub GetUserHosts
{
    my($getAll) = @_;
    my @hosts;

    if ( $getAll ) {
        @hosts = sort keys %$Hosts;
    } else {
        @hosts = sort grep { $Hosts->{$_}{user} eq $User ||
                       defined($Hosts->{$_}{moreUsers}{$User}) } keys(%$Hosts);
    }
    return @hosts;
}


sub ServerConnect
{
    #
    # Verify that the server connection is ok
    #
    return if ( $bpc->ServerOK() );
    $bpc->ServerDisconnect();
    if ( my $err = $bpc->ServerConnect($Conf{ServerHost}, $Conf{ServerPort}) ) {
        if ( CheckPermission()
          && -f $Conf{ServerInitdPath}
          && $Conf{ServerInitdStartCmd} ne "" ) {
            my $content = eval("qq{$Lang->{Admin_Start_Server}}");
            Header(eval("qq{$Lang->{Unable_to_connect_to_BackupPC_server}}"), $content);
            Trailer();
            exit(1);
        } else {
            ErrorExit(eval("qq{$Lang->{Unable_to_connect_to_BackupPC_server}}"));
        }
    }
}



