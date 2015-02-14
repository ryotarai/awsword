# Awsword

## Installation

    $ gem install awsword

## Usage

```
$ awsword ec2
```

## Configuration

awsword loads configuration located at `~/.awsword.yml`.

```yaml
default:
  ec2:
    vpc:
      vpc-123456:
        fqdn_suffix: .your.domain
```

### Profiles

You can define another configuration:

```yaml
your_profile:
  ec2:
    vpc:
      vpc-123456:
        fqdn_suffix: .your.domain
```

```
$ awsword ec2 --profile=your_profile
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/awsword/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
