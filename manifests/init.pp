class rebar {
    package {
        "git-core":
            ensure => installed
    }

    package {
        "erlang":
            ensure => installed
    }

    package {
        "make":
            ensure => installed
    }

    exec {
        "clone git repo":
            command => "git clone https://github.com/basho/rebar.git /tmp/rebar",
            creates => "/tmp/rebar",
            require => Package["git-core"]
    }

    exec {
        "make":
            command => "make",
            cwd => "/tmp/rebar",
            require => [Exec["clone git repo"], Package["erlang"], Package["make"]]
    }

    file {
        "/usr/local/bin/rebar":
            source => "/tmp/rebar/rebar",
            mode => "a+x",
            require => Exec["make"]
    }
}
