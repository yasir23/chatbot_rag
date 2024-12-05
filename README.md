# LangGraph Retrieval Chat Bot Template

#### MongoDB Atlas

MongoDB Atlas is a fully-managed cloud database that includes vector search capabilities for AI-powered applications.

1. Create a free Atlas cluster:
- Go to the [MongoDB Atlas website](https://www.mongodb.com/cloud/atlas/register) and sign up for a free account.
- After logging in, create a free cluster by following the on-screen instructions.

2. Create a vector search index
- Follow the instructions at [the Mongo docs](https://www.mongodb.com/docs/atlas/atlas-vector-search/vector-search-type/)
- By default, we use the collection `langgraph_retrieval_agent.default` - create the index there
- Add an indexed filter for path `user_id`
- **IMPORTANT**: select Atlas Vector Search NOT Atlas Search when creating the index
Your final JSON editor configuration should look something like the following:

```json
{
  "fields": [
    {
      "numDimensions": 1536,
      "path": "embedding",
      "similarity": "cosine",
      "type": "vector"
    },
    {
      "path": "user_id",
      "type": "filter"
    }
  ]
}
```

The exact numDimensions may differ if you select a different embedding model.

2. Set up your environment:
- In the Atlas dashboard, click on "Connect" for your cluster.
- Choose "Connect your application" and copy the provided connection string.
- Create a `.env` file in your project root if you haven't already.
- Add your MongoDB Atlas connection string to the `.env` file:

```
MONGODB_URI="mongodb+srv://username:password@your-cluster-url.mongodb.net/?retryWrites=true&w=majority&appName=your-cluster-name"
```

Replace `username`, `password`, `your-cluster-url`, and `your-cluster-name` with your actual credentials and cluster information.

To use OpenAI's chat models:

1. Sign up for an [OpenAI API key](https://platform.openai.com/signup).
2. Once you have your API key, add it to your `.env` file:
```
OPENAI_API_KEY=your-api-key
```



### Setup Embedding Model

The defaults values for `embedding_model` are shown below:

```yaml
embedding_model: openai/text-embedding-3-small
```

Follow the instructions below to get set up, or pick one of the additional options.

#### OpenAI

To use OpenAI's embeddings:

1. Sign up for an [OpenAI API key](https://platform.openai.com/signup).
2. Once you have your API key, add it to your `.env` file:
```
OPENAI_API_KEY=your-api-key
```

#### Cohere

To use Cohere's embeddings:

1. Sign up for a [Cohere API key](https://dashboard.cohere.com/welcome/register).
2. Once you have your API key, add it to your `.env` file:

```bash
COHERE_API_KEY=your-api-key
```





<!--
End setup instructions
-->

## Using

Once you've set up your retriever saved your model secrets, it's time to try it out! First, let's add some information to the index. Open studio, select the "indexer" graph from the dropdown in the top-left, provide an example user ID in the configuration at the bottom, and then add some content to chat over.

```json
[{ "page_content": "My cat knows python." }]
```

When you upload content, it will be indexed under the configured user ID. You know it's complete when the indexer "delete"'s the content from its graph memory (since it's been persisted in your configured storage provider).

Next, open the "retrieval_graph" using the dropdown in the top-left. Ask it about your cat to confirm it can fetch the required information! If you change the `user_id` at any time, notice how it no longer has access to your information. The graph is doing simple filtering of content so you only access the information under the provided ID.

## How to customize

You can customize this retrieval agent template in several ways:

1. **Change the retriever**: You can switch between different vector stores (Elasticsearch, MongoDB, Pinecone) by modifying the `retriever_provider` in the configuration. Each provider has its own setup instructions in the "Getting Started" section above.

2. **Modify the embedding model**: You can change the embedding model used for document indexing and query embedding by updating the `embedding_model` in the configuration. Options include various OpenAI and Cohere models.

3. **Adjust search parameters**: Fine-tune the retrieval process by modifying the `search_kwargs` in the configuration. This allows you to control aspects like the number of documents retrieved or similarity thresholds.

4. **Customize the response generation**: You can modify the `response_system_prompt` to change how the agent formulates its responses. This allows you to adjust the agent's personality or add specific instructions for answer generation.

5. **Change the language model**: Update the `response_model` in the configuration to use different language models for response generation. Options include various Claude models from Anthropic, as well as models from other providers like Fireworks AI.

6. **Extend the graph**: You can add new nodes or modify existing ones in the `src/retrieval_agent/graph.py` file to introduce additional processing steps or decision points in the agent's workflow.

7. **Add new tools**: Implement new tools or API integrations in `src/retrieval_agent/tools.py` to expand the agent's capabilities beyond simple retrieval and response generation.

8. **Modify prompts**: Update the prompts used for query generation and response formulation in `src/retrieval_agent/prompts.py` to better suit your specific use case or to improve the agent's performance.

Remember to test your changes thoroughly to ensure they improve the agent's performance for your specific use case.

## Development

While iterating on your graph, you can edit past state and rerun your app from past states to debug specific nodes. Local changes will be automatically applied via hot reload. Try adding an interrupt before the agent calls tools, updating the default system message in `src/retrieval_agent/utils.py` to take on a persona, or adding additional nodes and edges!

Follow up requests will be appended to the same thread. You can create an entirely new thread, clearing previous history, using the `+` button in the top right.

You can find the latest (under construction) docs on [LangGraph](https://github.com/langchain-ai/langgraph) here, including examples and other references. Using those guides can help you pick the right patterns to adapt here for your use case.

LangGraph Studio also integrates with [LangSmith](https://smith.langchain.com/) for more in-depth tracing and collaboration with teammates.

<!--
Configuration auto-generated by `langgraph template lock`. DO NOT EDIT MANUALLY.
{
  "config_schemas": {
    "indexer": {
      "type": "object",
      "properties": {
        "embedding_model": {
          "type": "string",
          "default": "openai/text-embedding-3-small",
          "description": "Name of the embedding model to use. Must be a valid embedding model name.",
          "environment": [
            {
              "value": "cohere/embed-english-light-v2.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-english-light-v3.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-english-v2.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-english-v3.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-multilingual-light-v3.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-multilingual-v2.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-multilingual-v3.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "openai/text-embedding-3-large",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/text-embedding-3-small",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/text-embedding-ada-002",
              "variables": "OPENAI_API_KEY"
            }
          ]
        },
        "retriever_provider": {
          "enum": [
            "elastic",
            "elastic-local",
            "mongodb",
            "pinecone"
          ],
          "default": "elastic",
          "description": "The vector store provider to use for retrieval. Options are 'elastic', 'pinecone', or 'mongodb'.",
          "environment": [
            {
              "value": "elastic",
              "variables": [
                "ELASTICSEARCH_URL",
                "ELASTICSEARCH_API_KEY"
              ]
            },
            {
              "value": "elastic-local",
              "variables": [
                "ELASTICSEARCH_URL",
                "ELASTICSEARCH_USER",
                "ELASTICSEARCH_PASSWORD"
              ]
            },
            {
              "value": "mongodb",
              "variables": [
                "MONGODB_URI"
              ]
            },
            {
              "value": "pinecone",
              "variables": [
                "PINECONE_API_KEY",
                "PINECONE_INDEX_NAME"
              ]
            }
          ],
          "type": "string"
        }
      }
    },
    "retrieval_graph": {
      "type": "object",
      "properties": {
        "embedding_model": {
          "type": "string",
          "default": "openai/text-embedding-3-small",
          "description": "Name of the embedding model to use. Must be a valid embedding model name.",
          "environment": [
            {
              "value": "cohere/embed-english-light-v2.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-english-light-v3.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-english-v2.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-english-v3.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-multilingual-light-v3.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-multilingual-v2.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "cohere/embed-multilingual-v3.0",
              "variables": "COHERE_API_KEY"
            },
            {
              "value": "openai/text-embedding-3-large",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/text-embedding-3-small",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/text-embedding-ada-002",
              "variables": "OPENAI_API_KEY"
            }
          ]
        },
        "retriever_provider": {
          "enum": [
            "elastic",
            "elastic-local",
            "mongodb",
            "pinecone"
          ],
          "default": "elastic",
          "description": "The vector store provider to use for retrieval. Options are 'elastic', 'pinecone', or 'mongodb'.",
          "environment": [
            {
              "value": "elastic",
              "variables": [
                "ELASTICSEARCH_URL",
                "ELASTICSEARCH_API_KEY"
              ]
            },
            {
              "value": "elastic-local",
              "variables": [
                "ELASTICSEARCH_URL",
                "ELASTICSEARCH_USER",
                "ELASTICSEARCH_PASSWORD"
              ]
            },
            {
              "value": "mongodb",
              "variables": [
                "MONGODB_URI"
              ]
            },
            {
              "value": "pinecone",
              "variables": [
                "PINECONE_API_KEY",
                "PINECONE_INDEX_NAME"
              ]
            }
          ],
          "type": "string"
        },
        "response_model": {
          "type": "string",
          "default": "anthropic/claude-3-5-sonnet-20240620",
          "description": "The language model used for generating responses. Should be in the form: provider/model-name.",
          "environment": [
            {
              "value": "anthropic/claude-1.2",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-2.0",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-2.1",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-3-5-sonnet-20240620",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-3-haiku-20240307",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-3-opus-20240229",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-3-sonnet-20240229",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-instant-1.2",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-0125",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-0301",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-0613",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-1106",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-16k",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-16k-0613",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-0125-preview",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-0314",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-0613",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-1106-preview",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-32k",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-32k-0314",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-32k-0613",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-turbo",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-turbo-preview",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-vision-preview",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4o",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4o-mini",
              "variables": "OPENAI_API_KEY"
            }
          ]
        },
        "query_model": {
          "type": "string",
          "default": "anthropic/claude-3-haiku-20240307",
          "description": "The language model used for processing and refining queries. Should be in the form: provider/model-name.",
          "environment": [
            {
              "value": "anthropic/claude-1.2",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-2.0",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-2.1",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-3-5-sonnet-20240620",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-3-haiku-20240307",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-3-opus-20240229",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-3-sonnet-20240229",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "anthropic/claude-instant-1.2",
              "variables": "ANTHROPIC_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-0125",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-0301",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-0613",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-1106",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-16k",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-3.5-turbo-16k-0613",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-0125-preview",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-0314",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-0613",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-1106-preview",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-32k",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-32k-0314",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-32k-0613",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-turbo",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-turbo-preview",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4-vision-preview",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4o",
              "variables": "OPENAI_API_KEY"
            },
            {
              "value": "openai/gpt-4o-mini",
              "variables": "OPENAI_API_KEY"
            }
          ]
        }
      }
    }
  }
}
-->
