package Catalyst::Plugin::ErrorCatcher::Plugin::CleanUp::Pg::TransactionAborted;
use strict;
use warnings;

sub tidy_message {
    my $plugin      = shift;
    my $errstr_ref  = shift;

    #  ERROR:  current transaction is aborted, commands ignored until end of
    #  transaction block [for Statement
    ${$errstr_ref} =~ s{
        \A
        .+?
        DBI \s Exception:
        .+?
        ERROR:\s+
        (
            current \s transaction \s is \s aborted, \s
            commands \s ignored \s until \s end \s of \s transaction \s block
        )
        \s \[ for \s Statement
        \s+
        .+
        $
    }{$1}xmsg;

    $errstr_ref;
}

1;



