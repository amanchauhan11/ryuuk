# Ryuuk

Ryuuk is a prospective concurrent web-server written in C++.
Currently Ryuuk runs only in POSIX compliant environments only.

## Building

***nix systems**
```
$ git clone https://github.com/amanchauhan11/ryuuk
$ cd ryuuk
$ mkdir build && cd build
$ cmake ..
$ make -ji # where i = no. of cores you can spare
```

## Why

We made this webserver as part of our college project "Empowering India’s emerging Internet users with Data Compression"
under PR101 which aims at identifying and improvising different formats suitable for compression of web data like text, html, images and videos. Through this server we wanted to learn a thing or two about http and multithreading.


## References

* https://tools.ietf.org/html/rfc723<0-7>  
* https://tools.ietf.org/html/rfc2616  
* http://www2005.org/cdrom/docs/p730.pdf  
