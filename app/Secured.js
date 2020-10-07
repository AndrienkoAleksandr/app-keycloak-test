import React, { Component } from 'react';
import Keycloak from 'keycloak-js';

class Secured extends Component {

  constructor(props) {
    super(props);
    this.state = { keycloak: null, authenticated: false };
  }

  componentDidMount() {
    // fetch('keycloak.json')
    // .then(response => response.json())
    // .then((jsonData) => {
    //    todo: logic here...  
    // })
    // .catch((error) => {
    //   // handle your errors here
    //   console.error(error)
    // })


      const keycloakConfig = {    
        // "realm": "demorealm",
        // "clientId": "react",
        "realm": "che",
        "clientId": "che-public",
        "url": "https://keycloak-test2.apps-crc.testing/auth/"
      };
      console.log(keycloakConfig);
      const keycloak = Keycloak(keycloakConfig);

      // Keycloak 6.0.1
      // keycloak.init({onLoad: 'login-required'})
      // .success(() => {
      //   console.log("Auth was done!");
      //   this.setState({ keycloak: keycloak, authenticated: true })
      // })
      // .error(error => {
      //   console.error("Keycloak initialization failed.", err);
      //   this.setState({ keycloak: keycloak, authenticated: false })
      // })

      // Keycloak 11.0.2
      keycloak.init({onLoad: 'login-required'}).then(authenticated => {
        console.log("Autentificated ? ", authenticated);
        this.setState({ keycloak: keycloak, authenticated: authenticated })
      }).catch(err => {
        this.setState({ keycloak: keycloak, authenticated: false })
        console.log("Total fail", err)
      });
  }

  render() {
    if (this.state.keycloak) {
      if (this.state.authenticated) return (
        <div>
          <p>Keycloak token is:</p>
          <p>{this.state.keycloak.token}</p>
        </div>
      ); else return (<div>Unable to authenticate!</div>)
    }
    return (
      <div>Initializing Keycloak...</div>
    );
  }
}
export default Secured;