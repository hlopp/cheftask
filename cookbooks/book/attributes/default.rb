default[:book][:packages] = [
    'epel-release', 
    'lsof', 
    'htop', 
    'vim-enhanced.x86_64',
]

default[:book][:users] = [
    {
      'username' => 'Jack',
      'password' => '1234',
      'uid' => 601,
      'gid' => 'user',
      'comment' => 'test user',
      'home_dir' => '/home/Jack/',
      'def_shell' => '/bin/bash/',
    },
    {
      'username' => 'John',
      'password' => '123456',
      'uid' => 602,
      'gid' => 'user',
      'comment' => 'test user',
      'home_dir' => '/home/John/',
      'def_shell' => '/bin/bash/',
    },
]
