default[:book][:packages] = [
    'epel-release', 
    'lsof', 
    'htop', 
    'vim-enhanced.x86_64',
]

default[:book][:users] = [
    {
      'username' => 'Jack',
      'ssh_key' => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAxF/ShXb02JslBYdjt6bxhnSm1WnAbdOz5K49Ag4n4C0nRku1aSvcoIobZyc1qPi/Ha9ptzFONXhl3xngcUp/I6O4GHQO8K9jWS1dAQ/60G+0tmQK4UvXhJxuAF9b+eSs3FODs9m7+vAkpXBCVm5hoo5Uvj+1E+Mi+tWDaeWUdWiHUgOpBvG20dAF8LyQjLWOCcGwKYQTt7tvj/i57VAEsFpCAVuiRlEhJPUZ7B+VM3w+ugjsOmGeeDijLn7AZd4i1W8/1MzG7DKOd9Z5unQidTAf9M+QJljWN8JcJgyFkvmT/I3tCmw8D7mfVZbej0B8hNGDVw2xn+dggBiOsHmMQw== root@localhost.localdomain ',
      'uid' => 601,
      'gid' => 'user',
      'comment' => 'test user',
      'home_dir' => '/home/Jack',
      'def_shell' => '/bin/bash',
    },
    {
      'username' => 'John',
      'ssh_key' => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAxF/ShXb02JslBYdjt6bxhnSm1WnAbdOz5K49Ag4n4C0nRku1aSvcoIobZyc1qPi/Ha9ptzFONXhl3xngcUp/I6O4GHQO8K9jWS1dAQ/60G+0tmQK4UvXhJxuAF9b+eSs3FODs9m7+vAkpXBCVm5hoo5Uvj+1E+Mi+tWDaeWUdWiHUgOpBvG20dAF8LyQjLWOCcGwKYQTt7tvj/i57VAEsFpCAVuiRlEhJPUZ7B+VM3w+ugjsOmGeeDijLn7AZd4i1W8/1MzG7DKOd9Z5unQidTAf9M+QJljWN8JcJgyFkvmT/I3tCmw8D7mfVZbej0B8hNGDVw2xn+dggBiOsHmMQw== root@localhost.localdomain ',
      'uid' => 602,
      'gid' => 'user',
      'comment' => 'test user',
      'home_dir' => '/home/John',
      'def_shell' => '/bin/bash',
    },
]
