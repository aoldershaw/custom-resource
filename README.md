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
      version="$(jq -r '.version' <&0)"
      echo "foo" > $1/output
      jq -n '{version: $version}' --arg version="$version"

    out_script: |
      jq -n '{version: {ref: "v2"}}'
```
