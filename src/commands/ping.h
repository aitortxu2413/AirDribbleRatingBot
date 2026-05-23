#pragma once
#include <cmath>
#include <print>
#include <format>

#include "../handlers/command_handler.h"

class PingCommand : public ICommand
{
public:
    std::string get_name() const override { return "ping"; }

    dpp::slashcommand definition(dpp::snowflake bot_id) const override
    {
        return dpp::slashcommand("ping", "¡Pong!", bot_id);
    }

    std::expected<std::string, std::string> execute(const dpp::slashcommand_t& event) const override
    {
        return std::format("¡Pong! 🏓 Latency: {:.0f}ms", event.from()->creator->rest_ping * 1000);
    }
};