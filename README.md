## kubernetes-php-nginx

Run Nginx + PHP (FPM) on your Kubernetes cluster!

This is an example project targeting anyone who is dying to find a pragmatic example and/or resources for getting started with [Kubernetes](http://kubernetes.io).

### Prerequisites

This example works best (only?) for a Kubernetes setup on your local machine with Vagrant. Please follow the instructions on the Kubernetes website and return here after everything is set up.

For convenience, I suggest to also install the Kubernetes CLI aka `kubectl` on your machine. On OS X (with Homebrew), it's as easy as

```bash
brew install kubernetes-cli
```

### Up and Running

Get up and running within seconds! Just run `kube-up.sh` inside the `kubernetes` folder:

```bash
$ kubernetes/kube-up.sh
services/php-fpm-svc
services/php-nginx-svc
replicationcontrollers/php-fpm
replicationcontrollers/php-nginx
---
When pod(s) are ready, hit http://10.245.1.3:30564 in your browser!
```

Here's what it does in a nutshell: It creates two pods, each running a [Docker](http://docker.io) container based on the [b00gizm/php-nginx](https://hub.docker.com/r/b00gizm/php-nginx/) image (see `Dockerfile` inside this repo for details). One pod is responsible for running the PHP FPM process and the other one for running Nginx.

It also creates two services, one for PHP FPM and one for Nginx, for load balancing traffic between the different pods. Without any changes, each service is only responsible for one pod, but you can scale this just as you like by changing the value for the `replication` fields inside `kubernetes/php-nginx-app.yml`

(I will elaborate on the nitty gritty details some time later, so please refer to the official [Kubernetes docs](http://kubernetes.io/v1.0), if you want details right know.)

Check if your pods are ready (running):

```bash
$ kubectl get po
NAME              READY     STATUS    RESTARTS   AGE
php-fpm-fyonz     1/1       Running   0          12s
php-nginx-eew3w   1/1       Running   0          12s
```

And then hit the URL dumped by `kube-up.sh` above in your browser (__please note that your actual IP address and port might and will vary!__) and you'll be greeted by a "Hello World" page.

After you're done, you can bring everything down via `kubernetes/kube-down.sh`.

### Running "locally" on Docker

If you're like me, you'll also like to test this app on your local Docker host:

```bash
docker build -t b00gizm/php-nginx .
...
docker tag b00gizm/php-nginx latest
docker/start-local.sh
993277dd6a21364139fa29a5ff2bf7eb5d25e07bba577d11b827bda41eb96fcb
984fa94801be481e86d68c86e86e1268c8da262983186bc0a4a7dfeca3d722e9
```

The app will be available in your browser via `http://<YOUR-DOCKER-HOST>:8080`

When you're done, just execute `docker/stop-local.sh` to stop it.

### Maintainer

Pascal Cremer

* Email: <hello@codenugget.co>
* Twitter: [@b00gizm](https://twitter.com/b00gizm)
* Web: [http://codenugget.co](http://codenugget.co)

### License

> The MIT License (MIT)
>
> Copyright (c) 2015 Pascal Cremer
>
>Permission is hereby granted, free of charge, to any person obtaining a copy
>of this software and associated documentation files (the "Software"), to deal
>in the Software without restriction, including without limitation the rights
>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>copies of the Software, and to permit persons to whom the Software is
>furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in all
>copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>SOFTWARE.
