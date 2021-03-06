/* vim: set sw=4 ts=4 et: */
/*
 * This file is part of Other Maemo Weather(omweather) - MeeCast
 *
 * Copyright (C) 2006-2012 Vlad Vasilyeu
 *     for the code
 *
 * Copyright (C) 2008 Andrew Zhilin
 *		      az@pocketpcrussia.com
 *	for default icon set (Glance)
 *
 * This software is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2.1 of
 * the License, or (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU weather-config.h General Public
 * License along with this software; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
*/
/*******************************************************************************/


#ifndef VISIBLE_H
#define VISIBLE_H
////////////////////////////////////////////////////////////////////////////////
#include <string>
#include <math.h>
#include <limits.h>
#include <iostream>
////////////////////////////////////////////////////////////////////////////////
namespace Core{
    class Visible{
        std::string *_units;
        float _value;
        public:
            Visible(const float value = INT_MAX, const std::string& units = "m");
            Visible(const Visible& visible);
            Visible& operator=(const Visible& visible);
            virtual ~Visible();
            void units(const std::string& name);
            std::string& units() const;
            float value(const bool absolute = false);
            void value(const float value);
    };
} // namespace Core
////////////////////////////////////////////////////////////////////////////////
#endif // VISIBLE_H

