Return-Path: <bpf+bounces-54066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE4BA61A1A
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 20:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88F8884E89
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFDE204F92;
	Fri, 14 Mar 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlLHyDl3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6952045A0;
	Fri, 14 Mar 2025 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741979174; cv=none; b=tpAxo9pujx8mJUp6oQD1LheZuE4/7SZPLrnyOlRljeabY9dv4U4sG9Y2BepZTvyhl5mGIk01+QcjIeymO7npc35objl4KTSwKkN4UbeiRipitNz4FZFzInTKrzRCnkoZMh9ndaM1ZOJ3zTHfsC97enx7qPzdu0lyDqi9KBnEs8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741979174; c=relaxed/simple;
	bh=ajFs9F0tAspFsaI2EHxXJ0ngkqO/JuYLnCLOEmhLTss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3GG2qKdlro5hEExXi4euScqjyxE2U4da6jrQI8yjR3Co76uaJ1Nn0w0t9Nm8OSw8YjKzywLo1ARtzS5fxxLfbEt25NrtuEqjRDu+X4pYNzVB6gM2BbGSCde0RRMDeGEz7gKC9H1tVG3ztE8a8o31wvPGFiI10pTiTACXtO4ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlLHyDl3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so349795e9.1;
        Fri, 14 Mar 2025 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741979170; x=1742583970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIoPbweeHXZ8jSMzIt/eB2E0Gri/NMU0G6vQgDoXF0o=;
        b=XlLHyDl3eUOprv01lXeEemsM1FgnYwaEs/0b5Chk/DA7ktGFKaVodjN0GQekqwUjhn
         bqz6dvobhPIgIuMFv5gOlIfNXXKN0CLf8OJSecqtxNgwmsIP+bUm2jQoKr6BJ2SZNIO5
         ZDZq2+lc1CijfG2ojAokidmCalOIq1KpGLlPxu4iDWNGUBvO426wr3rkxggd2rt3yN/V
         oLky0o/sk+KNqMAnj8PbkSuaLgr3ioJESog/1jva4X34+7666kT/oAG0PATA5V/Zrfou
         lV251g8RiGcgqe7+AEBNgFOt9Z/6sz0WI5EAoEK25J0H3Vl7Xu2yFthT1xfC/rZQzMxT
         M1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741979170; x=1742583970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIoPbweeHXZ8jSMzIt/eB2E0Gri/NMU0G6vQgDoXF0o=;
        b=AZYhYoQqdW15wamZsdWf7N/sgTikbrxPlqchufXJp2m3HsnFDTTQBHGsY4PHM9SWfB
         vfUvyM/Rd5rNBIC5QzGCC659s1xZduL5xoAkTG+bhvlgGK9ujIAOC9ceYqAzmzLpCfmI
         LUgYnY95tly3Z41zZwjYrLiYz0k8enwhnH+xe+Xr+sp104IWh7T5eUNF6h5fh3s3PxH3
         x7QCZNXydv7ocKbXDu56cUd9FdP+m/32cN/bKJBVmqb2DHi4z/JtN0jzuiuMEUAovP3w
         S6m06m35T/puFt9XuLH2p6WuITmWZwP5z6blxGPrCOlchFLzPdWWleXKHkasQUDvi4Oz
         0/xA==
X-Forwarded-Encrypted: i=1; AJvYcCU0fWx0MiJ96GFzzFC/asOs4Kg3xF8JFEc3LzKNVya/T/yUq60JrBh/1WGtxyVfB26xjNatXVwRVKBAVeY=@vger.kernel.org, AJvYcCUbAqPMXQI1rpULNbBTOsHJTKGcu75EWa00Vc6zLVZqnEDdBxOeZDnoia45E8vOyQ6rH3cyX+YT@vger.kernel.org, AJvYcCV85Wd3hCkA7WpLetwOIja3v5qZHIhDI0oSafly2rEgxqsMuVoItnFNr2nTLz6nwy2P1m5N9FLrPIQt4ImwLGk=@vger.kernel.org, AJvYcCVfgFhj40wxYlDAvV27ROdhViWQAotLjBnqXFuG2nMIpg47ray4DJHvMfqctEiM9tOl6oc=@vger.kernel.org, AJvYcCVoVrdKL5nEQ+u3eCtB2cJrhTXAr1H08c/WQCyZ/RWtY/l+Vy812eWcDETV0PFLe+I03dnFub5JUNfDkmE=@vger.kernel.org, AJvYcCXQfGXFGJDL/LvL5TBugYkV7biGENukGiB7ctrQBS3KIPuOl1e+oeESGDQdUOKqKRkVBS02morkqKff17nY@vger.kernel.org, AJvYcCXq291kN7oM93pqX24EUs31AYIbFltuLCxgORnco4H5fuJrf0qDDk4hHLDKckMATe9zwmg9N91cNUDwe2K+@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBlsu7uUqMD3E0XSTN1hRE2sFm/Xl+1jhObjkdjeIyX6GSPYO
	1pg4YsvDir5/6r+r4zqQfh0+cPcZWpy+x8qy6y5Y+KgXHEVnRIlq
X-Gm-Gg: ASbGncsOAgKHb1xE/Fj8LBYRbf46QM2ntS+roMiApYgDNk8SCi3r+beCZWDSVxfzAbb
	MYAWbY8lJTLJxTo+O096pScQh+UYWf+2ceZca5brwQYvqVl0DTl3XtVCHHGF+KaDjSUtzpscxEL
	1XqJ+wAKhIalf5otzLe/zQHHB6KugqYHSvz6ebtfh0PyP1Eap/OlDv1SMF8iZQXv2zPrOwZuU0V
	LKM4SVtERWr/MlHWy0/QxcKo+QJB3qv3kY759O3Du4QdRwrtANYBHkOaSH2DV46zy/7+LWYEoGj
	nGOh5o+pyF2/mwTFwhjltbqbyfY4Kx/AjDYm6tn+5yMmjvXP+cMFGyeAIOorSLjZE70MHfC/+OH
	2OK5VTJ0=
X-Google-Smtp-Source: AGHT+IEjEm1NLGYF77AUJiqADkJJt9c0HAwrROWKW9ldaOHP/gE/432Db9RpHAyqooeI7TNtApdt1Q==
X-Received: by 2002:a05:600c:4447:b0:43c:eea9:f45a with SMTP id 5b1f17b1804b1-43d1ec646demr47176475e9.4.1741979169941;
        Fri, 14 Mar 2025 12:06:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fae32sm25534355e9.31.2025.03.14.12.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 12:06:09 -0700 (PDT)
Date: Fri, 14 Mar 2025 19:06:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Yury Norov <yury.norov@gmail.com>,
 Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@kernel.org>, Kuan-Wei
 Chiu <visitorckw@gmail.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
 <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>,
 <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dmitry.torokhov@gmail.com>, <mchehab@kernel.org>,
 <awalls@md.metrocast.net>, <hverkuil@xs4all.nl>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <louis.peens@corigine.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>,
 <parthiban.veerasooran@microchip.com>, <arend.vanspriel@broadcom.com>,
 <johannes@sipsolutions.net>, <gregkh@linuxfoundation.org>,
 <akpm@linux-foundation.org>, <alistair@popple.id.au>,
 <linux@rasmusvillemoes.dk>, <Laurent.pinchart@ideasonboard.com>,
 <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <kuba@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsi@lists.ozlabs.org>,
 <dri-devel@lists.freedesktop.org>, <linux-input@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <oss-drivers@corigine.com>, <netdev@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
 <brcm80211-dev-list.pdl@broadcom.com>, <linux-serial@vger.kernel.org>,
 <bpf@vger.kernel.org>, <jserv@ccns.ncku.edu.tw>, Yu-Chun Lin
 <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
Message-ID: <20250314190604.53470966@pumpkin>
In-Reply-To: <b2b632cc-ca69-497f-9cf9-782bd02cac79@intel.com>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
	<20250306162541.2633025-2-visitorckw@gmail.com>
	<9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org>
	<Z8ra0s9uRoS35brb@gmail.com>
	<a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org>
	<20250307193643.28065d2d@pumpkin>
	<cbb26a91-807b-4227-be81-8114e9ea72cb@intel.com>
	<0F794C6F-32A9-4F34-9516-CEE24EA4BC49@zytor.com>
	<Z9MGxknjluvbX19w@thinkpad>
	<795281B1-9B8A-477F-8012-DECD14CB53E5@zytor.com>
	<b2b632cc-ca69-497f-9cf9-782bd02cac79@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 14:09:24 -0700
Jacob Keller <jacob.e.keller@intel.com> wrote:

> On 3/13/2025 9:36 AM, H. Peter Anvin wrote:
> > On March 13, 2025 9:24:38 AM PDT, Yury Norov <yury.norov@gmail.com> wrote:  
> >> On Wed, Mar 12, 2025 at 05:09:16PM -0700, H. Peter Anvin wrote:  
> >>> On March 12, 2025 4:56:31 PM PDT, Jacob Keller <jacob.e.keller@intel.com> wrote:  
> >>
> >> [...]
> >>  
> >>>> This is really a question of whether you expect odd or even parity as
> >>>> the "true" value. I think that would depend on context, and we may not
> >>>> reach a good consensus.
> >>>>
> >>>> I do agree that my brain would jump to "true is even, false is odd".
> >>>> However, I also agree returning the value as 0 for even and 1 for odd
> >>>> kind of made sense before, and updating this to be a bool and then
> >>>> requiring to switch all the callers is a bit obnoxious...  
> >>>
> >>> Odd = 1 = true is the only same definition. It is a bitwise XOR, or sum mod 1.  
> >>
> >> The x86 implementation will be "popcnt(val) & 1", right? So if we
> >> choose to go with odd == false, we'll have to add an extra negation.
> >> So because it's a purely conventional thing, let's just pick a simpler
> >> one?
> >>
> >> Compiler's builtin parity() returns 1 for odd.
> >>
> >> Thanks,
> >> Yury  
> > 
> > The x86 implementation, no, but there will be plenty of others having that exact definition.  
> 
> Makes sense to stick with that existing convention then. Enough to
> convince me.

There is the possibility that the compiler will treat the builtin as having
an 'int' result without the constraint of it being zero or one.
In which case the conversion to bool will be a compare.
This doesn't happen on x86-64 (gcc or clang) - but who knows elsewhere.

For x86 popcnt(val) & 1 is best (except for parity8) but requires a non-archaic cpu.
(Probably Nehelem or K10 or later - includes Sandy bridge and all the 'earth movers'.)
Since performance isn't critical the generic C code is actually ok.
(The 'parity' flag bit is only set on the low 8 bits.)

	David



