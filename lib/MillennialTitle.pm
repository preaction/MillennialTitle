package MillennialTitle;
our $VERSION = '0.001';
# ABSTRACT: Establish your nobility and status as a Millennial

=head1 SYNOPSIS

    perl bin/millennial-title daemon

=head1 DESCRIPTION

This web application generates flowery, honorific titles for
Millennials.  Since Millennials have been accused of destroying the
modern world, a sample accomplishment is also included, with a link to
the history of their nefarious deed...

=head1 SEE ALSO

L<Mojolicious>

=cut

use Mojo::Base 'Mojolicious';
use List::Util qw( uniq );
use v5.16;

my @MALE_RANKS = qw< King Knight Prince Lord Duke Emperor Marquis Count Baron >;
my @FEMALE_RANKS = qw< Queen Princess Knight Lady Duchess Empress Marquess Countess Baroness >;
my @ALL_RANKS = uniq @MALE_RANKS, @FEMALE_RANKS;

my @RANKS = qw<
    King Queen Knight Prince Princess Lord Lady Duke Duchess Empress
    Emperor Marquis Marquess Count Countess Baron Baroness
>;

my @OBJECTS = qw<
    Netflix Instagram Tinder Snapchat Uber Emoji Facebook Smartphone
    WiFi Meme Twitter Selfie Nostalgia Quinoa Organic Vape
    Hashtag Vintage
>;

my @ACTIONS = qw<
    Slayer Killer Mutilator Destroyer Decimator Ruiner Wrecker
    Annihilator Bane Assassin Vandal Demolisher Exterminator Waster
    Despoiler Devastator Butcher Eradicator Executioner Ravager
    Shatterer Smasher Crusher Pillager Ransacker Scourge Breaker
    Conqueror Crippler Devourer Destructor Doom Eliminator Oppressor
    Plunderer Saboteur
>;

my %KILLED = (
    Cruises => [qw<
        http://caribbeannewsservice.com/now/millennials-turning-away-from-cruises-and-casinos/
    >],
    'In-Person Meetings' => [qw<
        http://www.marketwatch.com/story/millennials-engage-with-their-smartphones-more-than-they-do-actual-humans-2016-06-21
    >],
    Homeownership => [qw<
        http://www.marketwatch.com/story/why-millennials-may-never-get-to-live-alone-2017-02-23
    >],
    'Chain Restaurants' => [qw<
        http://www.businessinsider.com/millennials-endanger-casual-dining-restaurants-2017-5
    >],
    'Fashion' => [qw<
        http://viewthevibe.com/millennials-fashion/
    >],
    'Focus Groups' => [qw<
        https://digiday.com/marketing/advertisingweek2015-how-millennials-killed-the-focus-group/
    >],
    'Vacations' => [qw<
        https://www.inc.com/jessica-stillman/hey-millennials-stop-killing-the-vacation.html
    >],
    'Paper Napkins' => [qw<
        http://www.businessinsider.com/millennials-hate-napkins-2016-3
    >],
    'Workdays' => [qw<
        http://www.digitalistmag.com/future-of-work/2016/05/12/did-millennials-kill-9-to-5-workday-or-point-out-its-dead-04174167
    >],
    'Bar Soap' => [qw<
        http://www.cbsnews.com/news/blame-millennials-for-the-vanishing-bar-of-soap/
    >],
    'Movie Theatres' => [qw<
        http://nypost.com/2016/04/15/millennials-are-killing-the-movie-business/
    >],
    'Running' => [qw<
        http://sportschatter.com/sports-talk/slideshow/millennials-ruining-sport-running/
    >],
    'Retail Shopping' => [qw<
        http://www.businessinsider.com/millennial-consumer-habits-robin-lewis-2016-6
    >],
    'Golf' => [qw<
        http://www.businessinsider.com/millennials-are-hurting-the-golf-industry-2016-7
    >],
    'Breakfast Cereal' => [qw<
        http://nation.foxnews.com/2016/03/14/are-lazy-millennials-killing-cereal-industry
    >],
    'Lunch' => [qw<
        http://fortune.com/video/2017/03/28/millennials-are-killing-lunch/
    >],
    'Dinner Dates' => [qw<
        http://nypost.com/2016/12/29/millennials-are-killing-the-dinner-date/
    >],
    'Brunch' => [qw<
        http://nypost.com/2017/03/23/millennials-have-officially-ruined-brunch/
    >],
    'The Food Industry' => [qw<
        https://theamericantribune.org/posts/millennials-are-killing-the-food-industry/
    >],
    'Relationships' => [qw<
        http://www.sheknows.com/love-and-sex/articles/1091871/millennial-daters-too-casual
    >],
    'Marriage' => [qw<
        https://www.bloomberg.com/news/articles/2017-04-04/young-americans-are-killing-marriage
    >],
    'Crowdfunding' => [qw<
        https://bossip.com/1315698/heres-how-millennials-have-killed-crowdfunding/
    >],
    'Fabric Softener' => [qw<
        https://consumerist.com/2016/12/16/fabric-softener-apparently-latest-victim-of-millennials-killing-spree/
    >],
    'Department Stores' => [qw<
        https://www.usatoday.com/videos/money/2017/02/24/millennials-killing-department-stores/98187754/
    >],
    'Casinos' => [qw<
        http://knockoutmag.com/12623/gambling/will-millennials-kill-gambling/
    >],
    'London Nightlife' => [qw<
        http://www.huffingtonpost.co.uk/vincent-dignan/how-technology-millennial_b_12727384.html
    >],
    'Beer' => [qw<
        http://www.businessinsider.com/millennials-are-killing-beer-2017-7
    >],
    'Fossil Fuels' => [qw<
        http://inthesetimes.com/article/20372/oil-industry-millennials-climate-change-socialism-capitalism
    >],
    'Marmalade' => [qw<
        http://metro.co.uk/2017/02/28/now-millennials-are-killing-marmalade-6478579/
    >],
);
my @KILLED = keys %KILLED;

sub startup {
    my ( $app ) = @_;
    push @{ $app->renderer->classes }, __PACKAGE__;

    if ( $ENV{MOJO_REVERSE_PROXY} ) {
        $app->hook(before_dispatch => sub {
            my ( $c ) = @_;
            $c->req->url->base->path( $ENV{MOJO_REVERSE_PROXY} . '/' );
        });
    }

    $app->plugin( 'AssetPack',
        pipes => [qw< Css JavaScript >],
    );
    $app->asset->process(
        'prereq.css' => (
            'http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.css',
            'http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap-theme.css',
        ),
    );
    $app->asset->process(
        'prereq.js' => (
            'http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js',
            'http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.js',
        ),
    );

    $app->routes->get( '/' )->name( 'index' )->to( cb => sub {
        my ( $c ) = @_;
        my $killed = $KILLED[ int rand @KILLED ];
        my $gender = $c->param( 'gender' );
        my @ranks = $gender eq 'male' ? @MALE_RANKS : $gender eq 'female' ? @FEMALE_RANKS : @ALL_RANKS;

        $c->render(
            template => 'index',
            rank => $ranks[ int rand @ranks ],
            object => $OBJECTS[ int rand @OBJECTS ],
            action => $ACTIONS[ int rand @ACTIONS ],
            killed => $killed,
            killed_source => $KILLED{ $killed }[ int rand @{ $KILLED{ $killed } } ],
        );
    } );
    $app->routes->get( '/list' )->name( 'list' )->to( cb => sub {
        my ( $c ) = @_;
        $c->render(
            template => 'list',
            killed => \%KILLED,
        );
    } );
}

1;
__DATA__

@@ index.html.ep
<title>Millennial Title Generator</title>
%= asset 'prereq.css'
%= asset 'prereq.js'
<style>
h1, h2, h3, h4, h5, h6 {
    text-align: center;
}
</style>
<div class="container">
    <h1>Millennial Title Generator</h1>
    <p>Millennials have been accused of destroying modern civilization. As
    a reward for a job well done, here's an honorific title, and a description of your
    accomplishment along with a link to the news report of your heroic deed. Wear it
    proudly!</p>

    <h2 style="margin-top: 2em">You Are...</h2>
    <h3><%= $rank %> <%= $object %></h3>
    <h3><a rel="nofollow" href="<%= $killed_source %>"><%= $action %> of <%= $killed %></a></h3>

    <form style="margin-top: 4em" class="form form-inline text-center" action="<%= url_for 'index' %>" method="GET">
        <button class="btn btn-primary">Get another</button>
        <select class="form-control" name="gender">
            <option value="">All Titles</option>
            <option value="male"
                <%= param( 'gender' ) eq 'male' ? 'selected' : '' %>
            >
                Male Titles
            </option>
            <option value="female"
                <%= param( 'gender' ) eq 'female' ? 'selected' : '' %>
            >
                Female Titles
            </option>
        </select>
    </form>

    <p class="text-center">
        <a href="<%= url_for 'list' %>">See all of Millennial's accomplishments</a>
    </p>
</div>

@@ list.html.ep
<title>Millennial Accomplishments</title>
%= asset 'prereq.css'
%= asset 'prereq.js'
<style>
h1, h2, h3, h4, h5, h6 {
    text-align: center;
}
</style>
<div class="container">
    <h1>Millennial Accomplishments</h1>
    <p>These are all the things millennials have been accused of killing.
    <a href="<%= url_for 'index' %>">Get a personal title and accomplishment</a>.</p>

    <dl>
        % my %killed = %{ stash 'killed' };
        % for my $killed ( sort keys %killed ) {
        <dt><%= $killed %></dt>
        <dd>
            <a href="<%= $killed{ $killed }[0] %>">
                <%= $killed{ $killed }[0] %>
            </a>
        </dd>
        % }
    </ul>
</div>
