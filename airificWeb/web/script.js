Chart.defaults.borderColor = "rgba(223, 240, 248, 0.2)";
Chart.defaults.color = "#dff0f8";

document.addEventListener("DOMContentLoaded", function () {
  var ctx = document.getElementById("myChart").getContext("2d");

  var data = {
    labels: [
      "21:53:29",
      "22:13:29",
      "22:33:29",
      "22:53:29",
      "23:13:29",
      "23:33:28",
      "21:53:29",
      "22:13:29",
      "22:33:29",
      "22:53:29",
      "23:13:29",
      "23:33:28",
      "23:53:28",
      "21:53:29",
      "22:13:29",
      "22:33:29",
      "22:53:29",
      "23:13:29",
      "23:33:28",
      "23:53:28",
      "21:53:29",
      "22:13:29",
      "22:33:29",
      "22:53:29",
      "23:13:29",
    ],
    datasets: [
      {
        label: "# of Votes",
        data: [
          3.21, 2.67, 2.26, 1.95, 2.05, 1.85, 0.11, 0.15, 0.13, 0.1, 0.11, 0.11,
          0.46, 2.51, 2.12, 1.89, 3.32, 1.79, 2.41, 1.75, 0.16, 0.18, 0.14,
          0.19, 0.1,
        ],
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
    type: "bar",
    data: data,
    options: options,
  });
});

/* -- ↓ METHODS TO GENERATE AND DOWNLOAD PDF FILE ↓ -- */
/* DA AGIUSTARE */
function generatePDF() {
  const pdfDoc = new jsPDF();
  // Add table
  pdfDoc.autoTable({
    head: [["Ora", "CO Value"]],
    body: [
      ["21:53:29", "3.21"],
      ["22:13:29", "2.67"],
      ["22:33:29", "2.26"],
      ["22:53:29", "1.95"],
      ["23:13:29", "2.05"],
      ["23:33:28", "1.85"],
      ["21:53:29", "0.11"],
      ["22:13:29", "0.15"],
      ["22:33:29", "0.13"],
      ["22:53:29", "0.1"],
      ["23:13:29", "0.11"],
      ["23:33:28", "0.11"],
      ["23:53:28", "0.46"],
      ["21:53:29", "2.51"],
      ["22:13:29", "2.12"],
      ["22:33:29", "1.89"],
      ["22:53:29", "3.32"],
      ["23:13:29", "1.79"],
      ["23:33:28", "2.41"],
      ["23:53:28", "1.75"],
      ["21:53:29", "0.16"],
      ["22:13:29", "0.18"],
      ["22:33:29", "0.14"],
      ["22:53:29", "0.19"],
      ["23:13:29", "0.1"],
    ],
  });

  // Add chart image as data URI
  const chartCanvas = document.getElementById("myChart");
  const chartImageURI = chartCanvas.toDataURL("image/jpeg", 1.0);
  pdfDoc.addImage(chartImageURI, "JPEG", 10, 100, 190, 80);

  pdfDoc.save("report.pdf");
}
