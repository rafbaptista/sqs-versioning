using Amazon.Lambda.CloudWatchEvents;
using Amazon.Lambda.Core;
using Amazon.Lambda.SQSEvents;
using Producer;
using System.Text.Json;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace Consumer;
public class Function
{
    public void FunctionHandler(
        SQSEvent sqsEvent, 
        ILambdaContext context)
    {
        var message = sqsEvent.Records[0];
        var content = JsonSerializer.Deserialize<CloudWatchEvent<Event>>(message.Body, new JsonSerializerOptions 
        {
            PropertyNameCaseInsensitive = true
        });
        
        context.Logger.LogLine($"Event received from queue: {message.Body}");
        context.Logger.LogLine($"Event version: {content?.Detail?.Version}");
    }
}
