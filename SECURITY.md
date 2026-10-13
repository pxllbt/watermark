# Security Policy

## Supported versions

| Version | Status |
| --- | --- |
| 1.0.x   | Current, receiving updates |

## What to know

Watermark is a simple client overlay — no root privileges, no privileged sockets, no filesystem mutations. It uses `ExclusionMode.Ignore` so it never captures pointer input or keystrokes. Update checks are read-only version lookups; no remote code execution.

## Reporting

Something not right? Don't open a public issue. Either [open a private advisory](https://github.com/pxllbt/watermark/security/advisories/new) or message me on GitHub with reproduction details and your environment.

Thanks for looking out for this.