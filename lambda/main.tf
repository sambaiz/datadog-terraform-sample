resource "datadog_monitor" "lambda-error-alert" {
  name    = "lambda-error-alert"
  type    = "metric alert"
  message = "Error occurred. @slack-alert"

  # Note: We highly recommend a delay of at least 900s for AWS metrics.
  evaluation_delay = 900

  query = "sum(last_1m):avg:aws.lambda.errors{*} by {functionname}.as_count() >= 3"

  thresholds {
    ok                = 0
    critical          = 3
    critical_recovery = 2
  }

  renotify_interval = 10
}

resource "datadog_monitor" "lambda-warn-log-alert" {
  name    = "lambda-warn-log-alert"
  type    = "log alert"
  message = "Many warn logs are being outputted. @slack-alert"

  query = "logs(\"service:lambda WARN\").index(\"main\").rollup(\"count\").by(\"functionname\").last(\"5m\") > 4"

  thresholds {
    ok       = 0
    warning  = 2
    critical = 4
  }

  renotify_interval = 10
}
