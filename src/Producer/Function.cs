using Amazon.EventBridge;
using Amazon.EventBridge.Model;
using Amazon.Lambda.Core;
using System.Text.Json;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace Producer;
public class Function
{
    public async Task FunctionHandler(ILambdaContext context)
    {
        context.Logger.LogLine("Publishing events to EventBridge");

        using var client = new AmazonEventBridgeClient();        

        await client.PutEventsAsync(new PutEventsRequest
        {
            Entries = new List<PutEventsRequestEntry>
            {
                new()
                {
                    EventBusName = "default",
                    Source = "Producer Microservice",
                    DetailType = "AWS API Call from Producer Microservice",
                    Time = DateTime.UtcNow,
                    Detail = JsonSerializer.Serialize(new Event{ Version = 1 })
                },
                new()
                {
                    EventBusName = "default",
                    Source = "Producer Microservice",
                    DetailType = "AWS API Call from Producer Microservice",
                    Time = DateTime.UtcNow,
                    Detail = JsonSerializer.Serialize(new Event{ Version = 2 })
                },
                new()
                {
                    EventBusName = "default",
                    Source = "Producer Microservice",
                    DetailType = "AWS API Call from Producer Microservice",
                    Time = DateTime.UtcNow,
                    Detail = JsonSerializer.Serialize(new Event{ Version = 3 })
                }
            }
        });
        context.Logger.LogLine($"Events v1,v2 and v3 successfully published on EventBridge");
    }
}