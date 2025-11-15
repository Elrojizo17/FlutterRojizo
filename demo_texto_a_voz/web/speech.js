var recognition = null;

function webSpeechListen(callback) {
    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

    if (!SpeechRecognition) {
        callback("ERROR_NO_SUPPORT");
        return;
    }

    recognition = new SpeechRecognition();
    recognition.lang = "es-CO";
    recognition.continuous = true;
    recognition.interimResults = false;
    recognition.maxAlternatives = 1;

    recognition.onresult = function(event) {
        const text = event.results[event.results.length - 1][0].transcript;
        callback(text);
    };

    recognition.onerror = function(event) {
        console.error("Speech error:", event.error);
        callback("ERROR_" + event.error);
    };

    recognition.start();
    }

    function webSpeechStop() {
    if (recognition) {
        recognition.stop();
    }
    }

