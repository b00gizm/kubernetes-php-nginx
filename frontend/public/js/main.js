var todoApp = angular.module('todoApp', []);

todoApp.controller('TodoListCtrl', function ($scope, $http) {

    var apiHost = CONFIG.apiHost;
    var apiPort = CONFIG.apiPort;

    $scope.todos = [];

    $http
        .get('http://' + apiHost + ':' + apiPort + '/api/todos')
        .then(function(resp) {
            $scope.todos = resp.data.map(function(todo) {
                todo.done = todo.done ? 1 : 0;
                return todo;
            });
        });
    ;

    function transformRequest(obj) {
        var str = [];
        for(var p in obj)
            str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
        return str.join("&");
    }

    $scope.save = function(newTodo) {
        var promise = $http({
            method: 'POST',
            url: 'http://' + apiHost + ':' + apiPort + '/api/todos',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: transformRequest,
            data: { title: newTodo.title }
        });

        promise.then(function(resp) {
            $scope.todos.push(resp.data);
            newTodo.title = '';
        });
    };

    $scope.update = function(todoId) {
        var todos = $scope.todos.filter(function(todo) {
            return todo.id == todoId;
        });

        todo = todos[0];
        if (todo) {
            var promise = $http({
                method: 'PUT',
                url: 'http://' + apiHost + ':' + apiPort + '/api/todos/' + todo.id,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                transformRequest: transformRequest,
                data: { title: todo.title, done: todo.done }
            });
        }
    };

});
