import { useEffect, useState } from 'react'
import './App.css'

function App() {
  const [message, setMessage] = useState('Loading...')

  useEffect(() => {
    const fetchData = async () => {
      try {
        const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8000';
        const response = await fetch(`${apiUrl}/api/hello/`);
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
