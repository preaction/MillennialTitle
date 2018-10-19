
use utf8;
use Mojolicious::Lite;
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
    Hashtag Vintage Rosé
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
        https://www.entrepreneur.com/article/270786
    >],
    'Bar Soap' => [qw<
        http://www.cbsnews.com/news/blame-millennials-for-the-vanishing-bar-of-soap/
    >],
    'Movie Theatres' => [qw<
        http://nypost.com/2016/04/15/millennials-are-killing-the-movie-business/
    >],
    'Running' => [qw<
        http://sportschatter.com/sports-talk/slideshow/millennials-ruining-sport-running/
        https://www.wsj.com/articles/how-millennials-ended-the-running-boom-1462473195
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
        https://www.wsj.com/articles/fabric-softener-sales-are-losing-their-bounce-1481889602?mg=prod/accounts-wsj
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
        http://www.businessinsider.com/millennials-killing-beer-with-rose-obsession-2017-8
    >],
    'Fossil Fuels' => [qw<
        http://inthesetimes.com/article/20372/oil-industry-millennials-climate-change-socialism-capitalism
        http://www.businessinsider.com/why-millennials-wont-work-in-oil-2017-7
    >],
    'Marmalade' => [qw<
        http://metro.co.uk/2017/02/28/now-millennials-are-killing-marmalade-6478579/
    >],
    'Hooters' => [qw<
        http://www.businessinsider.com/hooters-business-strategy-shifts-2017-8
    >],
    'Motorcycles' => [qw<
        http://www.businessinsider.com/millennials-are-hurting-harley-davidson-sales-2017-7
    >],
    'Light Yogurt' => [qw<
        http://www.businessinsider.com/millennials-are-killing-light-yogurt-2016-9
    >],
    'Diamonds' => [qw<
        https://www.cnbc.com/2017/05/20/millennial-couples-arent-buying-diamonds.html
        https://www.cnbc.com/2016/06/16/blame-millennials-diamond-jewelry-business-in-a-rough-spot.html
    >],
    'Designer Handbags' => [qw<
        http://www.businessinsider.com/the-death-of-designer-handbags-2015-8
    >],
    'Gyms' => [qw<
        http://nypost.com/2016/10/17/millennials-are-killing-gyms-too/
    >],
    'Home Depot' => [qw<
        https://www.forbes.com/sites/jefffromm/2014/10/02/will-the-millennial-generation-kill-home-depot/
    >],
    'the NFL' => [qw<
        https://www.csmonitor.com/Commentary/Opinion/2012/1019/Millennial-generation-could-kill-the-NFL
    >],
    'Manners' => [qw<
        http://www.readunwritten.com/2014/07/16/please-and-thank-you-why-manners-mean-more-than-you-think/
    >],
    'Suits' => [qw<
        http://newbostonpost.com/blogs/millennials-killed-the-suit-but-created-a-culture/
    >],
    'the American Dream' => [qw<
        http://redalertpolitics.com/2015/12/11/poll-millennials-say-american-dream-dead-killed/
    >],
    'Canadian Tourism' => [qw<
        http://notable.ca/millennials-wanderlust-is-killing-the-canadian-tourism-industry/
    >],
    'Democracy' => [qw<
        https://medium.com/@TazBunnett/the-death-throes-of-democracy-murdered-by-millennials-135c28ed2be5
    >],
    'the European Union' => [qw<
        http://nationalinterest.org/feature/how-europes-millennials-killed-the-eu-16905
    >],
    'Banks' => [qw<
        https://techcrunch.com/2015/05/30/millennial-banks/
    >],
    'Credit Cards' => [qw<
        http://business.financialpost.com/personal-finance/debt/millennials-are-ditching-credit-cards-and-its-threatening-the-entire-industry
    >],
    'Kitchens' => [qw<
        https://www.forbes.com/sites/andriacheng/2018/06/26/millennials-are-ordering-food-for-delivery-more-but-are-they-killing-the-kitchen-too/
    >],
    'Mayonnaise' => [qw<
        https://www.phillymag.com/articles/2018/08/11/mayonnaise-industry-millennials/
    >],
    'American Cheese' => [qw<
        https://www.bloomberg.com/news/articles/2018-10-10/american-cheese-is-no-longer-america-s-big-cheese
        https://nypost.com/2018/10/11/millennials-blamed-for-killing-american-cheese/
        https://www.esquire.com/food-drink/a23709555/millennials-are-killing-american-cheese/
    >],
);
my @KILLED = keys %KILLED;

push @{ app->renderer->classes }, __PACKAGE__;

if ( $ENV{MOJO_REVERSE_PROXY} ) {
    app->hook(before_dispatch => sub {
        my ( $c ) = @_;
        $c->req->url->base->path( $ENV{MOJO_REVERSE_PROXY} . '/' );
    });
}

app->plugin( 'AssetPack',
    pipes => [qw< Css JavaScript >],
);
app->asset->process(
    'prereq.css' => (
        'http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.css',
        'http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap-theme.css',
    ),
);
app->asset->process(
    'prereq.js' => (
        'http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js',
        'http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.js',
    ),
);

app->routes->get( '/' )->name( 'index' )->to( cb => sub {
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
app->routes->get( '/list' )->name( 'list' )->to( cb => sub {
    my ( $c ) = @_;
    $c->render(
        template => 'list',
        killed => \%KILLED,
    );
} );

app->start;

1;
__DATA__

@@ layouts/default.html.ep
<title><%= title %></title>
%= asset 'prereq.css'
%= asset 'prereq.js'
<style>
h1, h2, h3, h4, h5, h6 {
    text-align: center;
}
</style>
<div class="container">
    %= content
</div>
<p class="text-center"><small>
    Made by <a href="http://preaction.me">preaction</a><br/>
    Made with <a href="http://perl.org">Perl</a> and <a href="http://mojolicious.org">Mojolicious</a>
</small></p>

@@ index.html.ep
% layout 'default';
% title 'Millennial Title Generator';
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

@@ list.html.ep
% layout 'default';
% title 'Millennial Accomplishments';
% my %killed = %{ stash 'killed' };

<h1>Millennial Accomplishments</h1>
<p>These are all the things millennials have been accused of killing.
<a href="<%= url_for 'index' %>">Get a personal title and accomplishment</a>.</p>

<h2>Kill Count: <%= scalar keys %killed %></h2>
<dl>
    % for my $killed ( sort keys %killed ) {
    <dt><%= $killed %></dt>
        % for my $url ( @{ $killed{ $killed } } ) {
        <dd><a href="<%= $url %>"><%= $url %></a></dd>
        % }
    % }
</ul>
