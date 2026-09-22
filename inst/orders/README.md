# Contributed reading orders

See `example-ordering.txt` for a complete example. Add a UTF-8 `.txt` file
here with one existing chapter label per line, in the desired reading order.
Choose an original, descriptive lowercase name made of letters, numbers,
hyphens and underscores, such as `master-physics-centered-order.txt`, to avoid
conflicts with future contributions. A label may appear more than once. An
existing file can be uploaded from your computer through GitHub's **Add file → Upload files**.

After this file is included in a package release, readers can call
`contentsNew("master-physics-centered-order")`. To try it before release, pass
`order_file = "inst/orders/master-physics-centered-order.txt"` from the repository root.
