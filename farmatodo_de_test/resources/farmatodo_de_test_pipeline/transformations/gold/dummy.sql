-- Please edit the sample below

CREATE OR REFRESH MATERIALIZED VIEW workspace.operations.dummy_gold AS
SELECT
    *
FROM workspace.operations.dummy_silver;