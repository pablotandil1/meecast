/* vim: set sw=4 ts=4 et: */
/*
 * This file is part of Meecast for Tizen
 *
 * Copyright (C) 2012 - 2013 Vlad Vasilyeu
 * 	for the code
 *
 * This software is free software; you can redistribute it and/or
 * modify it under the terms of the GNU  General Public License
 * as published by the Free Software Foundation; either version 2.1 of
 * the License, or (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 *  General Public License for more details.
 *
 * You should have received a copy of the GNU  General Public
 * License along with this software; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
*/
#ifndef _MEECAST_SERVICE_MESSAGE_PORT_H_
#define _MEECAST_SERVICE_MESSAGE_PORT_H_

#include <FApp.h>
#include <FBase.h>
#include <FIo.h>
#include "MeecastDynamicType.h"

//#include "SampleType.h"

class MeecastServiceMessagePort
	: public Tizen::Io::IMessagePortListener
{
public :
	MeecastServiceMessagePort(void);

	~MeecastServiceMessagePort(void);

	result Construct(const Tizen::Base::String& localPortName);

	virtual void OnMessageReceivedN(Tizen::Io::RemoteMessagePort* pRemoteMessagePort, Tizen::Base::Collection::IMap* pMessage);

	result SendMessage(const Tizen::Base::Collection::IMap* pMessage);

private :
	Tizen::Io::LocalMessagePort* __pLocalMessagePort;
	Tizen::Io::RemoteMessagePort* __pRemoteMessagePort;
};

#endif // _MEECAST_SERVICE_MESSAGE_PORT_H_