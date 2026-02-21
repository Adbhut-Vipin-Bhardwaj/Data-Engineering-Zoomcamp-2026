"""Template for building a `dlt` pipeline to ingest data from a REST API."""

import dlt
from dlt.sources.rest_api import rest_api_resources
from dlt.sources.rest_api.typing import RESTAPIConfig


# if no argument is provided, `access_token` is read from `.dlt/secrets.toml`
@dlt.source
def open_library_rest_api_source(access_token: str = dlt.secrets.value):
    """Define dlt resources from REST API endpoints."""
    # Open Library Search API configuration
    # we will query `search.json?q=harry+potter` and load all documents
    config: RESTAPIConfig = {
        "client": {
            # base url for the Open Library API (no auth required for search)
            "base_url": "https://openlibrary.org",
        },
        "resources": [
            {
                "name": "search",
                # every resource must declare its endpoint details under `endpoint`
                "endpoint": {
                    "path": "search.json",
                    # default method is GET so we can omit it
                    "params": {"q": "harry potter"},
                    # the search response wraps results under `docs`
                    "data_selector": "docs",
                },
                # choose a unique identifier field from each doc (if available)
                "primary_key": "key",
            }
        ],
    }

    yield from rest_api_resources(config)


pipeline = dlt.pipeline(
    pipeline_name='open_library_pipeline',
    destination='duckdb',
    # `refresh="drop_sources"` ensures the data and the state is cleaned
    # on each `pipeline.run()`; remove the argument once you have a
    # working pipeline.
    refresh="drop_sources",
    # show basic progress of resources extracted, normalized files and load-jobs on stdout
    progress="log",
)


if __name__ == "__main__":
    load_info = pipeline.run(open_library_rest_api_source())
    print(load_info)  # noqa: T201
