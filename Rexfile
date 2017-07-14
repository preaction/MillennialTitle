
=head1 NAME

Rexfile - Rex task configuration for MillennialTitle web application

=head1 SYNOPSIS

    # Deploy the web app from the local directory
    rex deploy_dev

=head1 DESCRIPTION

This file defines all the L<Rex|http://rexify.org> tasks used to deploy
this application.

=head1 SEE ALSO

L<Rex|http://rexify.org>

=cut

use Rex -feature => [ 1.4 ];
use Rex::Commands::Sync;

#######################################################################
# Groups
group web => 'preaction.me';

#######################################################################
# Settings

# Used to find local, dev copies of the dist
set 'dist_name' => 'MillennialTitle';

#######################################################################
# Environments

#######################################################################

=head1 TASKS

=head2 deploy

    rex deploy
    rex -E vm deploy

Deploy the CPAN Testers web app from CPAN. Do this task after releasing
a version of CPAN::Testers::Web to CPAN.

=cut

desc "Deploy the web app from CPAN";
task deploy =>
    group => 'web',
    sub {
        run 'source ~/.profile; cpanm MillennialTitle';
        run_task 'deploy_config', on => connection->server;
    };

=head2 deploy_dev

    rex -E vm deploy_dev

Deploy a pre-release, development version of the web app. Use this to
install to your dev VM to test things. Will run `dzil build` locally
to build the tarball, then sync that tarball to the remote and install
using `cpanm`.

=cut

task deploy_dev =>
    group => 'web',
    sub {
        my $dist_name = get 'dist_name';
        my $dist;
        LOCAL {
            Rex::Logger::info( 'Building dist' );
            run '/Users/doug/.perlbrew/libs/perl-5.24.0@Statocles/bin/dzil build';
            my @dists = sort glob "${dist_name}-*.tar.gz";
            $dist = $dists[-1];
        };

        Rex::Logger::info( 'Syncing ' . $dist );
        file '~/dist/' . $dist,
            source => $dist;

        Rex::Logger::info( 'Installing ' . $dist );
        run 'source ~/.profile; cpanm -v --with-recommends ~/dist/' . $dist;
        if ( $? ) {
            say last_command_output;
        }
        run_task 'deploy_config', on => connection->server;
    };

=head2 deploy_config

    rex deploy_config

Deploy the service scripts and configuration files, and then restart
the services.

=cut

task deploy_config =>
    group => 'web',
    sub {
        Rex::Logger::info( 'Deploying service config' );
        file '~/service/millennial-title/log/main',
            ensure => 'directory';
        file '~/service/millennial-title/run',
            source => 'etc/runit/millennial-title/run';
        file '~/service/millennial-title/log/run',
            source => 'etc/runit/millennial-title/log/run';

        Rex::Logger::info( 'Restarting' );
        run 'sv restart ~/service/millennial-title';
    };

#######################################################################

=head1 SUBROUTINES

