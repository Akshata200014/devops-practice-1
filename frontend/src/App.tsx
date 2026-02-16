import { useEffect, useState } from 'react'
import './App.css'

function App() {
  const [message, setMessage] = useState('Loading...')

  useEffect(() => {
	 const fetchData = async () => {
  try {
    // 1. Just use the relative path. 
    // The browser automatically adds the current server's IP.
    const response = await fetch("/api/hello/");
    
    const data = await response.json();
    setMessage(data.message);
  } catch (error) {
    setMessage('Failed to connect to the backend.');
    console.error(error);
  }
};
    fetchData();
  }, [])

  return (
    <div className="App">
      <h1>DevOps Assessment</h1>
      <div className="card">
        <p>Backend Status: <strong>{message}</strong></p>
      </div>
    </div>
  )
}

export default App
