# [jaesin/psalm-builder](https://hub.docker.com/r/jaesin/psalm-builder)

Builds a phar for [Psalm](https://github.com/vimeo/psalm) so it can be easily 
used from docker without having to require psalm in the project. You can copy
psalm to your docker image with:

```Dockerfile
COPY --from=jaesin/psalm-builder:latest /usr/local/bin/psalm /usr/local/bin/psalm
```

Development by Jaesin Mulenex at <https://github.com/jaesin/psalm-builder>.
