# custom-resource

A Concourse resource type with the sole purpose of making it easier to write
your own custom resource types for testing without needing to go through the
trouble of creating a Docker image. Just provide your `check`, `in`, and `out`
scripts in the `source`, and you're good to go (assuming all you need is `jq`!)

## Example

```yaml
resource_types:
- name: custom
  type: registry-image
  source: {repository: aoldershaw/custom-resource}

resources:
- name: dumb-resource
  type: custom
  source:
    check_script: |
      jq -n '[{ref: "v1"}]'

    in_script: |
      jq -r '.version' <&0 > /tmp/version.json
      echo "foo" > $1/output
      jq -n '{version: $version[0]}' --slurpfile version /tmp/version.json

    out_script: |
      jq -n '{version: {ref: "v2"}}'
```
