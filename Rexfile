
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

=cut

desc "Deploy the web app";
task deploy =>
    group => 'web',
    sub {
        file 'app/MillennialTitle', ensure => 'directory';
        file 'app/MillennialTitle/myapp.pl',
            source => 'myapp.pl';
        file 'app/MillennialTitle/cpanfile',
            source => 'cpanfile';
        run 'cd app/MillennialTitle; carton install';
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
        file '~/.config/systemd/user/millennial-title.service',
            source => 'etc/millennial-title.service';

        Rex::Logger::info( 'Restarting' );
        run 'systemctl --user enable millennial-title.service';
        run 'systemctl --user restart millennial-title.service';
    };
