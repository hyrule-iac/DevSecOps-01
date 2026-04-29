using Prometheus;
using System.Diagnostics;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// 📊 Business & Performance Metrics
// 1. Feature Click Counter (Business Value)
var clickCounter = Metrics.CreateCounter("app_feature_clicks_total", "Total count of interactive site button clicks");

// 2. Error Counter (For Alerting and Rollbacks)
var errorCounter = Metrics.CreateCounter("app_business_errors_total", "Total count of simulated https 500 errors");

// 3. Latency Histogram (Critical for P95/P99 Grafana Dashboards and Argo Analysis)
var requestDuration = Metrics.CreateHistogram("app_request_duration_seconds", 
    "API request latency distribution", new HistogramConfiguration
{
    // Buckets from 10ms to ~10s to capture different latency profiles
    Buckets = Histogram.ExponentialBuckets(0.01, 2, 10) 
});

// 4. Active Tasks Gauge (Real-time monitoring)
var processingGauge = Metrics.CreateGauge("app_active_tasks", "Number of tasks currently being processed");

// Enable Prometheus scraping middleware
app.UseHttpMetrics();

// 🏠 Interactive Lab Interface
app.MapGet("/", () => Results.Content(@$"
    <html>
        <body style='font-family:sans-serif; background:#1a0f0f; color:white; text-align:center; padding-top:50px;'>
            <h1 style='color:#ff6b57;'> .NET 10 DevSecOps Lab API - DevSec V5</h1>
                <p>Status: <span style='color:#ff6b57;'>CANARY V3</span></p>
            <div style='margin:20px;'>
                <button onclick='fetch(""/click"")' style='padding:12px; background:#ffd54a; color:black; border:none; border-radius:5px; cursor:pointer; font-weight:bold;'>Generate Traffic</button>
                <button onclick='fetch(""/error"")' style='padding:12px; background:#d85a30; color:white; border:none; border-radius:5px; cursor:pointer; font-weight:bold;'>Simulate Error</button>
                <button onclick='fetch(""/slow"")' style='padding:12px; background:#ffb900; color:black; border:none; border-radius:5px; cursor:pointer; font-weight:bold;'>Simulate Latency</button>
            </div>
            <div style='margin-top:30px; color:#555; font-size:14px;'>
                <p>Metrics endpoint active at <a href='/metrics' style='color:#58a6ff; text-decoration:none;'>/metrics</a></p>
                <p>Use these buttons to trigger Argo Rollouts Analysis via Prometheus.</p>
            </div>
        </body>
    </html>
", "text/html"));

// ⚡ Endpoint: Healthy Traffic
app.MapGet("/click", () => {
    clickCounter.Inc();
    return Results.Ok(new { message = "Click registered successfully", timestamp = DateTime.UtcNow });
});

// ❌ Endpoint: Simulated Failures
app.MapGet("/error", () => {
    errorCounter.Inc();
    return Results.Problem("Simulated business logic failure for metrics testing", statusCode: 500);
});

// 🐢 Endpoint: Synthetic Latency (The "Canary Killer")
app.MapGet("/slow", async () => {
    using (requestDuration.NewTimer())
    using (processingGauge.TrackInProgress())
    {
        // Random delay between 500ms and 3000ms
        var delay = Random.Shared.Next(500, 3000);
        await Task.Delay(delay);
        return Results.Ok(new { message = $"Task completed in {delay}ms", status = "Latency Recorded" });
    }
});

// Expose Prometheus Scraping Endpoint
app.MapMetrics();

app.Run();