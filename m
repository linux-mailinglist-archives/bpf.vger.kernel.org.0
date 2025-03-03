Return-Path: <bpf+bounces-53102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472E6A4C977
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 18:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCF63A24E8
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1842641EC;
	Mon,  3 Mar 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH2YasrL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4722FE11;
	Mon,  3 Mar 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020883; cv=none; b=Be5tWsvUd2r46x2IVUaaQXwPsovR+BB2mq+5ehY5yFa69LV8fP4Blbl4IJfR6E/H64JESkGcqe9etRpPd8elq2THJgN5jmbhRwERYAyU/uRdWe1fGAm+hp6phVSgaQpf4LUuapLmMlTaKxBoxVtKulcf393Hkmf5//s79UuH+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020883; c=relaxed/simple;
	bh=kkvFR/IJHbl0LGFDEze2MZjviEc4qGy5WgIJZLMUixA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqziWm8qQ94YF6y139B4slsZcGBxgcJDfHvp2d3XGdUtJuCcvQQwNvKbBmBzcjVDFWVOMNjxK8lL5ZDChD3ghpUx7JYApDoSZ2cXPEj0bF49YV4pTOFDUtD/kQcyDr6hKcP83hmRQTuGTuRJIecQRN/vK/Tg7fYChjkT/SPw78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FH2YasrL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2238e884f72so32083065ad.3;
        Mon, 03 Mar 2025 08:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020880; x=1741625680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snQ/FfGFpVYJtbb054yayRa/GPJB9+XLRVNWjcRf72o=;
        b=FH2YasrLfj2cpywzuZP9mhJKJYhhVFdWXSAmLLzf5JivpByF1aF33VSg++IyP2TA/U
         s2O+F0NZ1rO5vGh9jjeIfKP3lAHyOetoAxLtBA0tGrKo7IjlkXM4JyJs3z6rlecvfpqO
         ehzC7B8w4uBqrubC3t2lP6Py/zMsbLbfx/gyulof+3889ZlEfDvOV4wQTLJrBZj7UQRT
         DAGSvbkdlxMzUgEc/lRtjb2o7vxRz5NbFab5w6nO8tqvJunKgabVnN/rEGQzRbBhldRk
         HiOh19h55Sl9M1JixQdb2sO2AITeEZKmAVZJ11CCQjZ47Woer2v67sf7fing7yLC7R89
         aSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020880; x=1741625680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snQ/FfGFpVYJtbb054yayRa/GPJB9+XLRVNWjcRf72o=;
        b=WlGyDQ+RJSOpFOX00+p+wxErdeoHkA848kBvXyo2XRrlv+u6GFKSHgiDb7UvQX5i8u
         KNEmwOfzQjlLfomcDuc185881A6HhNr958eBWMXYORybZtohjhdbpdgLMacA5oD3jPiR
         wrRi+sWdEzPqD+77VtXU4ZyEmXnRjH1rzwxDEqv038haGiF7Ia+BuoUfIV6bLrejNyku
         2TFcLcUIt3ZI3wy+x8k2+fzEaocID94IwN9Crm+582fZILch27msTq1WWmXdH4N1e1LO
         hbGkcm0YuedmVODB/OcBl9wZYlp1x7KV/1ikiC3AvXQFsA4ma73xyI3zXvgluOTee1zO
         sLaA==
X-Forwarded-Encrypted: i=1; AJvYcCU7x/jrwoPYIi7LXWgUyHNquArOC3RuahV9wPu9anb/hkR4c/W9Msg1yZmcTNk8r+IxXIH0No2ubbeLNMo=@vger.kernel.org, AJvYcCV/EfvguUk6V9UBkNWZoj4cfhCDRQFh/2bHT2CBHid29wsFbZi6KKTs7OuiKjm0eI87I6ZXHCpC2GrkEUhl6wM=@vger.kernel.org, AJvYcCVm+9pZfEEYBBkCpYDxdZYDX/5+gPYlGDGV5wfHTlYZmTwWQEiafQie0kiBz3W01N2qBwhchBreO3z8/HY=@vger.kernel.org, AJvYcCW+/cTZ9SHIcxjD0+d0t5JCI4aFYQHgSIW1YYVaMdU3cGh80hVgCyWkctFYvqccSg8S3mA=@vger.kernel.org, AJvYcCWDVfB8PsgB3Sf26WAGucKHGdoozFD23oBKkkEMq7aeE9DeyUFv88Em4vmjFJxbms1YUMIiW+otvL8+G6MA@vger.kernel.org, AJvYcCWK5CCq8BNm8pGNXHpCc/MXungVffv5Pe35Xx7ZPsFD409w6xu9AUQ+JFlLGru3l7JDvkQGS0mC@vger.kernel.org, AJvYcCWcBPvlV1NWGVYH6EmI/0Lru6HURIhI27RTBRaRObuH5xg7ipYuxQ4do++a0hj6+I26IR8kkAiKYho+xA27@vger.kernel.org
X-Gm-Message-State: AOJu0YwiC4RjtLEx4i46inwcXUASi8kCplAE7Q360tVB/FaLnPCGI1TO
	HeC7ofa8MEmXs4tv8JF8+EE0dr3Evr2TIPcGpvKfG5XulJLe/FQeBRE14N2z4zA=
X-Gm-Gg: ASbGncu/9NtTWWJzeAtjF8Z1mojkN0QDicPanbYsWSurMuQS2ce+Bv7gdu82Qu1MHtY
	Jlua03PhtU47ikzHWasGj8iDxdeLhTx9YDvLj0wtfUsSOiyuARBF47BYnWz+nMMQIR4DNnvBVX3
	Ei9XQUUSBbDTVhvUMqcxZ3FdGTXIy+E6U1Ds1/F6VUIVcSg4n2V2+XpNMG5ClRjFZLJ3znQFd/H
	TP04JkK4HszTHYHXNqETm3hYqjgSpGpx+nw8jp/X0S5s+FHrz1bthwKl18rp2SLMMOGSQ4tHpdD
	de+onLBMGpU8gXQxXyiej6b9yyRlAkMG4uWKEu7EC/mRL1fZoOMkYqfS2Wfqw8cIhoqWB9t4
X-Google-Smtp-Source: AGHT+IERzXXFV1wY4JOTqL7FEPHOnAzKcBtkbh1MW/f1V7zUkt/V5lVcottzvfcf37UkL0y23/7mVg==
X-Received: by 2002:a17:902:fc8d:b0:223:44dc:3f36 with SMTP id d9443c01a7336-2236925eef4mr232091065ad.43.1741020880198;
        Mon, 03 Mar 2025 08:54:40 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c59ecsm80088085ad.123.2025.03.03.08.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:54:39 -0800 (PST)
Date: Tue, 4 Mar 2025 00:54:30 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
	eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	andrew.cooper3@citrix.com, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 01/18] lib/parity: Add __builtin_parity() fallback
 implementations
Message-ID: <Z8XexgomsveMWK2U@visitorckw-System-Product-Name>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
 <20250301142409.2513835-2-visitorckw@gmail.com>
 <Z8PMHLYHOkCZJpOh@thinkpad>
 <Z8QUsgpCB0m2qKJR@visitorckw-System-Product-Name>
 <Z8SBBM_81wyHfvC0@thinkpad>
 <Z8SVb4xD4tTiMEpL@visitorckw-System-Product-Name>
 <20250302190954.2d7e068f@pumpkin>
 <Z8UYOD2tyjS25gIc@visitorckw-System-Product-Name>
 <Z8XOF2DMMRKqam6R@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XOF2DMMRKqam6R@thinkpad>

On Mon, Mar 03, 2025 at 10:43:28AM -0500, Yury Norov wrote:
> On Mon, Mar 03, 2025 at 10:47:20AM +0800, Kuan-Wei Chiu wrote:
> > > > #define parity(val)					\
> > > > ({							\
> > > > 	__auto_type __v = (val);			\
> > > > 	bool __ret;					\
> > > > 	switch (BITS_PER_TYPE(val)) {			\
> > > > 	case 64:					\
> > > > 		__v ^= __v >> 16 >> 16;			\
> > > > 		fallthrough;				\
> > > > 	case 32:					\
> > > > 		__v ^= __v >> 16;			\
> > > > 		fallthrough;				\
> > > > 	case 16:					\
> > > > 		__v ^= __v >> 8;			\
> > > > 		fallthrough;				\
> > > > 	case 8:						\
> > > > 		__v ^= __v >> 4;			\
> > > > 		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
> > > > 		break;					\
> > > > 	default:					\
> > > > 		BUILD_BUG();				\
> > > > 	}						\
> > > > 	__ret;						\
> > > > })
> > > 
> > > I'm seeing double-register shifts for 64bit values on 32bit systems.
> > > And gcc is doing 64bit double-register maths all the way down.
> > > 
> > > That is fixed by changing the top of the define to
> > > #define parity(val)					\
> > > ({							\
> > > 	unsigned int __v = (val);			\
> > > 	bool __ret;					\
> > > 	switch (BITS_PER_TYPE(val)) {			\
> > > 	case 64:					\
> > > 		__v ^= val >> 16 >> 16;			\
> > > 		fallthrough;				\
> > > 
> > > But it's need changing to only expand 'val' once.
> > > Perhaps:
> > > 	auto_type _val = (val);
> > > 	u32 __ret = val;
> > > and (mostly) s/__v/__ret/g
> > >
> > I'm happy to make this change, though I'm a bit confused about how much
> > we care about the code generated by gcc. So this is the macro expected
> > in v3:
> 
> We do care about code generated by any compiler. But we don't spread
> hacks here and there just to make GCC happy. This is entirely broken
> strategy. Things should work the other way: compiler people should
> collect real-life examples and learn from them.
> 
> I'm not happy even with this 'v >> 16 >> 16' hack, I just think that
> disabling Wshift-count-overflow is the worse option. Hacking the macro
> to optimize parity64() on 32-bit arch case doesn't worth it entirely.
> 
> In your patchset, you have only 3 drivers using parity64(). For each
> of them, please in the commit message refer that calling generic
> parity() with 64-bit argument may lead to sub-optimal code generation
> with a certain compiler against 32-bit arches. If you'll get a
> feedback that it's a real problem for somebody, we'll think about
> mitigating it. 
>
How about reconsidering using parity8/16/32/64() instead of adding a
parity() macro? They allow compiler to generate correct code without
any hacks, and each implementation is simple and just one line. Jiri
also agreed in the previous thread that we need parity8() in cases like
the i3c driver. I think this might be the easiest solution to satisfy
most people?

Regards,
Kuan-Wei

