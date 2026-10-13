# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Security Model

Watermark (`pix.watermark`) is a pure client overlay for Quickshell:
1. **No System Privilege**: The overlay requires no root privileges, creates no privileged sockets, and performs no filesystem mutations.
2. **Click-Through Transparency**: By declaring `exclusionMode: ExclusionMode.Ignore`, the layer never captures pointer input, cannot intercept keystrokes, and cannot hijack user clicks.
3. **Passive Update Checking**: Update notifications run read-only version checks without executing unverified remote payloads.

## Reporting a Vulnerability

If you discover a security issue or unexpected behavior in Watermark, please report it responsibly:

1. **Do not open a public issue.**
2. Send an email to the repository maintainer via their GitHub profile or open a private advisory at [GitHub Security Advisories](https://github.com/pxllbt/watermark/security/advisories/new).
3. Include reproduction details and your environment configuration.

We appreciate your help keeping Watermark safe for everyone.
