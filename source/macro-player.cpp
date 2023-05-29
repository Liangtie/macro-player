#include <string>

#include "macro-player/macro-player.hpp"

#include <fmt/core.h>

exported_class::exported_class()
    : m_name {fmt::format("{}", "macro-player")}
{
}

auto exported_class::name() const -> const char*
{
  return m_name.c_str();
}
