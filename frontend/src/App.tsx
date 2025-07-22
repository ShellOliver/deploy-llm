// import { Link, Route, Switch } from "wouter";
import "./App.css";
import { Home } from "./Home";
import { HeroUIProvider } from "@heroui/react";

function App() {
  return (
    <HeroUIProvider>
      <Home></Home>
    </HeroUIProvider>
  );
}

export default App;
