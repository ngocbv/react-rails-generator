import ReactDOM from "react-dom";
import {Router, Route, Link, browserHistory} from "react-router"

import injectTapEventPlugin from "react-tap-event-plugin";
injectTapEventPlugin();

import App from "./app";

const router = (
  <Router history={browserHistory}>
    <Route path="/" component={App}>
    </Route>
  </Router>
);

$(document).on("ready page:load", function() {
 ReactDOM.render(router, document.getElementById("react-wrapper"));
});
