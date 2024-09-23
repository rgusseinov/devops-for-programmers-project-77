resource "datadog_monitor" "foo" {
  name               = "Ruslan Hexlet for monitor foo"
  type               = "metric alert"
  message            = "Monitor triggered. Notify: @hipchat-channel"
  escalation_message = "Escalation message @pagerduty"

  query = "avg(last_1h):avg:aws.ec2.cpu{environment:foo,host:foo} by {host} > 4"

  monitor_thresholds {
    warning           = 2
    warning_recovery  = 1
    critical          = 4
    critical_recovery = 3
  }
}

resource "datadog_monitor" "healthcheck" {
  name  = "Healthcheck monitor - ${uuid()}"
  type  = "service check"
  query = "\"http.can_connect\".over(\"*\").by(\"*\").last(3).count_by_status()"

  message = "{{host.name}} not available"
}

