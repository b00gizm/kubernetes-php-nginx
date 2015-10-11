<?php

$app = new Silex\Application();

$app['debug'] = true;

$app->register(new JDesrosiers\Silex\Provider\CorsServiceProvider(), [
    "cors.allowOrigin" => "*",
]);

$app['redis.prefix'] = 'todos:';
$app['redis.client'] = new Predis\Client('tcp://redis:6379');

$app->get('/api/todos', function() use ($app) {
    /** @var Predis\Client $client */
    $client = $app['redis.client'];

    $todos = [];
    $keys = $client->keys($app['redis.prefix'].'todo:*');
    foreach ($keys as $key) {
        $todos[] = json_decode($client->get($key));
    }

    return $app->json($todos);
});

$app->get('/api/todos/{id}', function($id) use ($app) {
    /** @var Predis\Client $client */
    $client = $app['redis.client'];
    $todo = $client->get($app['redis.prefix'].'todo:'.$id);
    if (!$todo) {
        $error = ['error' => 'Todo not found.'];

        return $app->json($error, 404);
    }

    return $app->json(json_decode($todo));
});

$app->post('/api/todos', function(\Symfony\Component\HttpFoundation\Request $req) use ($app) {
    if (!$req->get('title')) {
        $error = ['error' => 'Title is missing.'];

        return $app->json($error, 400);
    }

    /** @var Predis\Client $client */
    $client = $app['redis.client'];
    $id = $client->incr($app['redis.prefix'].'currentId');

    $todo = [
        'id'          => $id,
        'title'       => $req->get('title'),
        'done'        => false,
        'createdAt'   => (new \DateTime())->getTimestamp(),
        'completedAt' => null,
    ];

    $client->set($app['redis.prefix'].'todo:'.$id, json_encode($todo));

    return $app->json($todo, 201);
});

$app->put('/api/todos/{id}', function($id, \Symfony\Component\HttpFoundation\Request $req) use ($app) {
    /** @var Predis\Client $client */
    $client = $app['redis.client'];

    $todo = $client->get($app['redis.prefix'].'todo:'.$id);
    if (!$todo) {
        $error = ['error' => 'Todo not found.'];

        return $app->json($error, 404);
    }

    $todo = json_decode($todo, true);
    $todo['title'] = $req->get('title');
    $todo['done']  = (bool)$req->get('done');
    $todo['completedAt'] = (bool)$req->get('done') === true ? (new \DateTime())->getTimestamp() : false;

    $client->set($app['redis.prefix'].'todo:'.$id, json_encode($todo));

    return $app->json(null, 204);
});

$app->delete('/api/todos/{id}', function($id) use ($app) {
    /** @var Predis\Client $client */
    $client = $app['redis.client'];

    $client->del([$app['redis.prefix'].'todo:'.$id]);

    return $app->json(null, 200);
});

$app->after($app["cors"]);

return $app;
