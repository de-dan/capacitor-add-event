import { Calendar } from 'capacitor-add-event';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    Calendar.echo({ value: inputValue })
}
