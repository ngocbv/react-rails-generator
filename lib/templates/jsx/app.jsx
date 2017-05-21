import getMuiTheme from "material-ui/styles/getMuiTheme";
import MuiThemeProvider from "material-ui/styles/MuiThemeProvider";
import NotificationsIcon from 'material-ui/svg-icons/social/notifications';

class AppBarExampleComposition extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      logged: true,
    };
  }

  handleChange = (event, logged) => {
    this.setState({logged: logged});
  };

  render() {
    return (
      <div>
        <h3>AppBar</h3>
        <mui.Toggle
          label="Logged"
          defaultToggled={true}
          onToggle={this.handleChange}
          labelPosition="right"
          style={{margin: 20}}
        />
        <mui.AppBar
          title="Title"
          iconElementRight={this.state.logged ? <mui.FlatButton label="Logged" /> : <mui.FlatButton label="Login" />}
        />

        <h3>Badge</h3>
        <div>
          <mui.Badge
            badgeContent={4}
            primary={true}
          >
            <NotificationsIcon />
          </mui.Badge>
          <mui.Badge
            badgeContent={10}
            secondary={true}
            badgeStyle={{top: 12, right: 12}}
          >
            <mui.IconButton tooltip="Notifications">
              <NotificationsIcon />
            </mui.IconButton>
          </mui.Badge>
        </div>

        <h3>Date Picker</h3>
        <div>
          <mui.DatePicker hintText="Portrait Dialog" />
          <mui.DatePicker hintText="Landscape Dialog" mode="landscape" />
          <mui.DatePicker hintText="Dialog Disabled" disabled={true} />
        </div>
      </div>
    );
  }
}

export default class App extends React.Component {
 render() {
   return (
      <MuiThemeProvider muiTheme={getMuiTheme()}>
        // You can replace AppBarExampleComposition to your code
        <AppBarExampleComposition />
      </MuiThemeProvider>
   );
 }
}
