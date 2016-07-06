## Pritunl as a Docker container

DRAFT, Needs Revision

Just build it or pull it from rickalm/pritunl. Run it something like this:

```
docker run -d -privileged -p 1194:1194/udp -p 1194:1194/tcp -p 9700:9700/tcp rickalm/pritunl
```

If you have a mongodb somewhere you'd like to use for this rather than starting the built-in one you can
do so through the MONGODB_URI env var like this:

```
docker run -d -privileged -e MONGODB_URI=mongodb://some-mongo-host:27017/pritunl -p 1194:1194/udp -p 1194:1194/tcp -p 9700:9700/tcp rickalm/pritunl
```

Then you're on your own, but take a look at http://pritunl.com or https://github.com/pritunl/pritunl
