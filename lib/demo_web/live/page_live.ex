defmodule DemoWeb.PageLive do
  use DemoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :config, :timer.seconds(:rand.uniform(5)))
    end

    {:ok, socket, temporary_assigns: [config: nil]}
  end

  @impl true
  def handle_info(:config, socket) do
    config = %{
      "data" => [
        %{
          "country" => "Lithuania",
          "litres" => 501.9,
          "units" => 250
        },
        %{
          "country" => "Czech Republic",
          "litres" => 301.9,
          "units" => 222
        },
        %{
          "country" => "Ireland",
          "litres" => 201.1,
          "units" => 170
        },
        %{
          "country" => "Germany",
          "litres" => 165.8,
          "units" => 122
        },
        %{
          "country" => "Australia",
          "litres" => 139.9,
          "units" => 99
        },
        %{
          "country" => "Austria",
          "litres" => 128.3,
          "units" => 85
        },
        %{
          "country" => "UK",
          "litres" => 99,
          "units" => 93
        },
        %{
          "country" => "Belgium",
          "litres" => 60,
          "units" => 50
        },
        %{
          "country" => "The Netherlands",
          "litres" => 50,
          "units" => 42
        }
      ],
      "xAxes" => [
        %{
          "type" => "CategoryAxis",
          "dataFields" => %{
            "category" => "country",
            "title" => %{
              "text" => "Countries"
            }
          }
        }
      ],
      "yAxes" => [
        %{
          "type" => "ValueAxis",
          "title" => %{
            "text" => "Litres sold (M)"
          }
        }
      ],
      "series" => [
        %{
          "type" => "ColumnSeries",
          "dataFields" => %{
            "valueY" => "litres",
            "categoryX" => "country"
          },
          "name" => "Sales",
          "columns" => %{
            "tooltipText" => "Series: {name}\nCategory: {categoryX}\nValue: {valueY}",
            "stroke" => "#ff0000",
            "fill" => "#00ff00"
          }
        },
        %{
          "type" => "LineSeries",
          "stroke" => "#CDA2AB",
          "strokeWidth" => 3,
          "dataFields" => %{
            "valueY" => "units",
            "categoryX" => "country"
          },
          "name" => "Units"
        }
      ]
    }

    {:noreply, assign(socket, config: Jason.encode_to_iodata!(config))}
  end
end
