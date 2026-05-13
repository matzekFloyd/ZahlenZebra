import "./style.css";
import { mountZahlenZebra } from "./sketch";

const root = document.getElementById("app");
if (root) {
  mountZahlenZebra(root);
}
