import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';

// class App extends React.Component{
//     render(){
//         return(
//             <div>Hello World</div>
//         )
//     }
// }

// ReactDOM.render(<App />, document.getElementById('app'))


import App from './App';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('app')
);