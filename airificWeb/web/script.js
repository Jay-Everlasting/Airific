Chart.defaults.borderColor = "rgba(223, 240, 248, 0.2)";
Chart.defaults.color = "#dff0f8";

document.addEventListener("DOMContentLoaded", function () {
  var ctx = document.getElementById("myChart").getContext("2d");

  var data = {
    labels: ["Yellow", "Green", "Purple", "Orange"],
    datasets: [
      {
        label: "# of Votes",
        data: [3, 5, 2, 3],
        backgroundColor: ["rgba(255, 206, 86, 0.2)"],
        borderColor: ["rgba(255, 206, 86, 1)"],
        borderWidth: 1,
      },
    ],
  };

  var options = {
    responsive: false,
    maintainAspectRatio: false,
    scales: {
      y: {
        beginAtZero: true,
      },
    },
  };

  var myChart = new Chart(ctx, {
    type: "line",
    data: data,
    options: options,
  });
});

// funzione di testing
function test() {
  var t1 = document.getElementById("sel-gas").value;
  var t2 = document.getElementById("sel-grafico").value;
  var t3 = document.getElementById("sel-data-inizio").value;
  var t4 = document.getElementById("sel-data-fine").value;

  console.log("Lalaland = " + t1 + "  " + t2 + "  " + t3 + "  " + t4);
}
