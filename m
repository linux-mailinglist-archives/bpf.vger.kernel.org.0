Return-Path: <bpf+bounces-53111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4EFA4CC10
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 20:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146F5173E32
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F67233120;
	Mon,  3 Mar 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffQO1ly4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265DE1C8604;
	Mon,  3 Mar 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030668; cv=none; b=pehBhgYXA4lUe4DQBsVXgb62l2bZovaHz7r6ajFTuvPCwNgdVOF/S4Izz5SzNeT2l1fRiMGO7RDV3EUI/Z0OjtCygHnHYy1M+EElS4CiQe1DBlqmJT3C+vQlngGTg3XAdJew/wcgs+aEmMi0FkJirGAPkwSu41Ff8sSXuwMM62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030668; c=relaxed/simple;
	bh=1sKM3HmGmZ4XNV0R3wDe7YhC6/n+JJn0dGFKTpsVn9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1Z5AXP/wPjjWBNzOADLHpbZOpGX7jeqQT6Z4muYooehwII88bsoDrR3etUE7sB4wbfZ+HgjjbZC5jbjjjRPtREpiiEDyLmZmxHXW4BqRQBkec56znWqhuK1NiZVhxBC0WRXAv9H/C2l7tS9x13z6barhR+xp5NzaJ1ZxHDKO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffQO1ly4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso8529525e9.1;
        Mon, 03 Mar 2025 11:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741030662; x=1741635462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVBrsQeXraVCp2D/HwIHQkHOOS8UoeEI0fbbAugf/mo=;
        b=ffQO1ly43exgN9SDz4qmffmr29hTGvWd5bY448F/maMRvI/VaDwiwoGfWgAWyFwnak
         GM5RdO10zyqqj71DlIGhJ3bv34ka9inKiyOBcD108E3ZcbI0vyoE887cvP+Uu6nUeyh1
         VHN3MA5StaOT2mQTBpsplrBuH8csKFtsCH79HGRoL4oTjQmStMK5XYVEJ3obuVUoKS0U
         6af9S+Uc40xgCJj+cwpPPk9oq7JwH/jBBFhDHsI881mv6Xp458B6kU2wPCojkDBbQNXN
         wthQ8aU/j/fIUm7Jx3+kVqqeyJ+X5V+f7P2w3MfN4xH30AlUY4tvVzwLJX+r+jdNGr6Q
         STpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030662; x=1741635462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVBrsQeXraVCp2D/HwIHQkHOOS8UoeEI0fbbAugf/mo=;
        b=RPqDuRV8CuI07C9eUi/j4Cel/GjSuzie9byR48m63N39/WEZTA2Wv9yg5LNlP5egko
         RFYVS4Z9C/RkxPG4Lw0OjDuomix6yBqU91MPR0u08nRONzzWCQW9Fpv6B0ZRUo6UFp+J
         sVis8/7YCuuh/sW3Msa+l5dXu8OQ5lDA+4q7GJnYOaiGjaYU7f5bKiAE/arcNgRs0Ah/
         0mrPfaF9kMVajBaYw4sqMoDDZ52GrJ9TBG0thSlhX571boi+SGd0wJ4LfKqpcksLm1n9
         D6w5mDo/XVRGFX+KI4nOGa3igcDZBxN7MiDdoFB+mytfTINKvqtuylgryYFFDQhn8K7I
         Qt4g==
X-Forwarded-Encrypted: i=1; AJvYcCUfkWjWrS69QxH8gmkIswi6Gt+FO4rHgzf+hX1Gbryloz5oajVSWqXLoiT05Us6DnRRMhFlnerb@vger.kernel.org, AJvYcCUrQPrQgkSc3H76tPl8I3K5ULZe8jrmcYJKvFMBStPx5fZHT/HYAxaOWOf2TMONXbulLYI=@vger.kernel.org, AJvYcCUrojQdevuCIr2s/Ggmjq6D98+Yswvewp5hdHHQifXP21Z8KkXkH7v86zvs+J/9UeIZHZfvQpiOo5HI2u1t@vger.kernel.org, AJvYcCWMHq2W1gRHGlcZ2tvq5kdTy9VPFNH6GKx8ufp2F9nLB7d9u8KXsX+vsfsDrKYxbjvwtAme2wAd/nAKzI4=@vger.kernel.org, AJvYcCXD6FOIRZ5vrY1NJDX8GeoJF15ytyWg0uRPY5BeYo6OtJgmF2i97JVDK9XA9giHz7CapYev7wCjCEbVy9ujAps=@vger.kernel.org, AJvYcCXPKseUdbVuWyGVGGbVQ6Aqgd2LToWjyt49Ufa/zG4qLxBnTS7K5Hiz6z4K2B7Np3rbzRfghz3NyUWMyXk=@vger.kernel.org, AJvYcCXo2uecsV2Xkq2Ey2MOnkcRxAGayT7P2lVSsNpPoPeDyOqxFKBgXbEsw7dP8NBR40KvkVjkz1PZ8KbtXw0w@vger.kernel.org
X-Gm-Message-State: AOJu0YwR/P/6/+1YsXjiBPpAYIfIo32JUPy6g7yVaLplrtwezx6uAUnc
	O5T49efZjGEjacJMNnmscWyiNa2qnqYTRueMoblrCwp92yMhLH4z
X-Gm-Gg: ASbGncs1ZqwvTUgpB+1r3IVOAdd2QOrbLdNdjMAVpWEhiLJxmtIdWubtP97BM9eX0zI
	XgnehtYYNuT0Q2ahXgC6P6G1GeV+wc3ioQqOydZY0NuLH9bpQYcwUVaHQ59XT9FhZ+jIA4I8Ytv
	mWkByv1v2XOcWjWnm33Hd2kIrKz7LXSd0nEMffxV6rGkalqFh9Ng9ERlubb1RQf7CJ3ThNfjdOk
	j79Szw+fTp4tCVP5jnCdS+isPee5yO0Fb4EasmPjPSHANyxfO9L76GBgLKtx66iBeyZAT77+/+z
	G/9nCBmFSF75YLfi4fsJPWmzbw11+j5tsRUpsCUrOlbrw9IAjx6CWbt3E5fy8XREJOmdOhgjc3C
	ys2Nuy6w=
X-Google-Smtp-Source: AGHT+IE5SsMAFxGhtu6mLXRY5Pge6T5PIIN9j46P3NC9S6x1AuYKxmDUwUSvWRO/DaRfnfW/d1a6Iw==
X-Received: by 2002:a05:600c:1548:b0:439:685e:d4c8 with SMTP id 5b1f17b1804b1-43ba66fec18mr136187305e9.15.1741030662069;
        Mon, 03 Mar 2025 11:37:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7a73sm15704508f8f.50.2025.03.03.11.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:37:41 -0800 (PST)
Date: Mon, 3 Mar 2025 19:37:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dmitry.torokhov@gmail.com,
 mchehab@kernel.org, awalls@md.metrocast.net, hverkuil@xs4all.nl,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 louis.peens@corigine.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
 johannes@sipsolutions.net, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
 alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 andrew.cooper3@citrix.com, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 01/18] lib/parity: Add __builtin_parity() fallback
 implementations
Message-ID: <20250303193739.2a9cdc42@pumpkin>
In-Reply-To: <Z8XHnToOV03hiQKu@thinkpad>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
	<20250301142409.2513835-2-visitorckw@gmail.com>
	<Z8PMHLYHOkCZJpOh@thinkpad>
	<Z8QUsgpCB0m2qKJR@visitorckw-System-Product-Name>
	<Z8SBBM_81wyHfvC0@thinkpad>
	<Z8SVb4xD4tTiMEpL@visitorckw-System-Product-Name>
	<Z8XHnToOV03hiQKu@thinkpad>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 10:15:41 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> On Mon, Mar 03, 2025 at 01:29:19AM +0800, Kuan-Wei Chiu wrote:
> > Hi Yury,
> > 
> > On Sun, Mar 02, 2025 at 11:02:12AM -0500, Yury Norov wrote:  
> > > On Sun, Mar 02, 2025 at 04:20:02PM +0800, Kuan-Wei Chiu wrote:  
> > > > Hi Yury,
> > > > 
> > > > On Sat, Mar 01, 2025 at 10:10:20PM -0500, Yury Norov wrote:  
> > > > > On Sat, Mar 01, 2025 at 10:23:52PM +0800, Kuan-Wei Chiu wrote:  
> > > > > > Add generic C implementations of __paritysi2(), __paritydi2(), and
> > > > > > __parityti2() as fallback functions in lib/parity.c. These functions
> > > > > > compute the parity of a given integer using a bitwise approach and are
> > > > > > marked with __weak, allowing architecture-specific implementations to
> > > > > > override them.
> > > > > > 
> > > > > > This patch serves as preparation for using __builtin_parity() by
> > > > > > ensuring a fallback mechanism is available when the compiler does not
> > > > > > inline the __builtin_parity().
> > > > > > 
> > > > > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > ---
> > > > > >  lib/Makefile |  2 +-
> > > > > >  lib/parity.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  2 files changed, 49 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 lib/parity.c
> > > > > > 
> > > > > > diff --git a/lib/Makefile b/lib/Makefile
> > > > > > index 7bab71e59019..45affad85ee4 100644
> > > > > > --- a/lib/Makefile
> > > > > > +++ b/lib/Makefile
> > > > > > @@ -51,7 +51,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
> > > > > >  	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
> > > > > >  	 percpu-refcount.o rhashtable.o base64.o \
> > > > > >  	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
> > > > > > -	 generic-radix-tree.o bitmap-str.o
> > > > > > +	 generic-radix-tree.o bitmap-str.o parity.o
> > > > > >  obj-y += string_helpers.o
> > > > > >  obj-y += hexdump.o
> > > > > >  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> > > > > > diff --git a/lib/parity.c b/lib/parity.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..a83ff8d96778
> > > > > > --- /dev/null
> > > > > > +++ b/lib/parity.c
> > > > > > @@ -0,0 +1,48 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * lib/parity.c
> > > > > > + *
> > > > > > + * Copyright (C) 2025 Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > + * Copyright (C) 2025 Yu-Chun Lin <eleanor15x@gmail.com>
> > > > > > + *
> > > > > > + * __parity[sdt]i2 can be overridden by linking arch-specific versions.
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/export.h>
> > > > > > +#include <linux/kernel.h>
> > > > > > +
> > > > > > +/*
> > > > > > + * One explanation of this algorithm:
> > > > > > + * https://funloop.org/codex/problem/parity/README.html  
> > > > > 
> > > > > I already asked you not to spread this link. Is there any reason to
> > > > > ignore it?
> > > > >   
> > > > In v2, this algorithm was removed from bitops.h, so I moved the link
> > > > here instead. I'm sorry if it seemed like I ignored your comment.  
> > > 
> > > Yes, it is.
> > >    
> > > > In v1, I used the same approach as parity8() because I couldn't justify
> > > > the performance impact in a specific driver or subsystem. However,
> > > > multiple people commented on using __builtin_parity or an x86 assembly
> > > > implementation. I'm not ignoring their feedback-I want to address these  
> > > 
> > > Please ask those multiple people: are they ready to maintain all that
> > > zoo of macros, weak implementations, arch implementations and stubs
> > > for no clear benefit? Performance is always worth it, but again I see
> > > not even a hint that the drivers care about performance. You don't
> > > measure it, so don't care as well. Right?
> > >   
> > > > comments. Before submitting, I sent an email explaining my current
> > > > approach: using David's suggested method along with __builtin_parity,
> > > > but no one responded. So, I decided to submit v2 for discussion
> > > > instead.  
> > > 
> > > For discussion use tag RFC.
> > >   
> > > > 
> > > > To avoid mistakes in v3, I want to confirm the following changes before
> > > > sending it:
> > > > 
> > > > (a) Change the return type from int to bool.
> > > > (b) Avoid __builtin_parity and use the same approach as parity8().
> > > > (c) Implement parity16/32/64() as single-line inline functions that
> > > >     call the next smaller variant after xor.
> > > > (d) Add a parity() macro that selects the appropriate parityXX() based
> > > >     on type size.
> > > > (e) Update users to use this parity() macro.
> > > > 
> > > > However, (d) may require a patch affecting multiple subsystems at once
> > > > since some places that already include bitops.h have functions named
> > > > parity(), causing conflicts. Unless we decide not to add this macro in
> > > > the end.
> > > > 
> > > > As for checkpatch.pl warnings, they are mostly pre-existing coding
> > > > style issues in this series. I've kept them as-is, but if preferred,
> > > > I'm fine with fixing them.  
> > > 
> > > Checkpatch only complains on new lines. Particularly this patch should
> > > trigger checkpatch warning because it adds a new file but doesn't touch
> > > MAINTAINERS. 
> > >   
> > For example, the following warning:
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > #84: FILE: drivers/input/joystick/sidewinder.c:368:
> > +                       if (!parity64(GB(0,33)))
> >                                           ^
> > 
> > This issue already existed before this series, and I'm keeping its
> > style unchanged for now.
> >   
> > > > If anything is incorrect or if there are concerns, please let me know.
> > > > 
> > > > Regards,
> > > > Kuan-Wei
> > > > 
> > > > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > > > index c1cb53cf2f0f..47b7eca8d3b7 100644
> > > > --- a/include/linux/bitops.h
> > > > +++ b/include/linux/bitops.h
> > > > @@ -260,6 +260,43 @@ static inline int parity8(u8 val)
> > > >  	return (0x6996 >> (val & 0xf)) & 1;
> > > >  }
> > > > 
> > > > +static inline bool parity16(u16 val)
> > > > +{
> > > > +	return parity8(val ^ (val >> 8));
> > > > +}
> > > > +
> > > > +static inline bool parity32(u32 val)
> > > > +{
> > > > +	return parity16(val ^ (val >> 16));
> > > > +}
> > > > +
> > > > +static inline bool parity64(u64 val)
> > > > +{
> > > > +	return parity32(val ^ (val >> 32));
> > > > +}  
> > > 
> > > That was discussed between Jiri and me in v2. Fixed types functions
> > > are needed only in a few very specific cases. With the exception of
> > > I3C driver (which doesn't look good for both Jiri and me), all the
> > > drivers have the type of variable passed to the parityXX() matching 
> > > the actual variable length. It means that fixed-type versions of the
> > > parity() are simply not needed. So if we don't need them, please don't
> > > introduce it.
> > >  
> > So, I should add the following parity() macro in v3, remove parity8(),
> > and update all current parity8() users to use this macro, right?  
> 
> If you go with macro, please apply my patch and modify it in-place
> with this __auto_type thing and GCC hack. Feel free to add your
> co-developed-by, or tested, or whatever.
> 
> > I changed u64 to __auto_type and applied David's suggestion to replace
> > the >> 32 with >> 16 >> 16 to avoid compiler warnings.
> > 
> > Regards,
> > Kuan-Wei
> > 
> > #define parity(val)					\
> > ({							\
> > 	__auto_type __v = (val);			\
> > 	bool __ret;					\
> > 	switch (BITS_PER_TYPE(val)) {			\
> > 	case 64:					\
> > 		__v ^= __v >> 16 >> 16;			\
> > 		fallthrough;				\  
> 
> This hack should be GCC-only, and well documented.
> For clang it should be 
>  		__v ^= __v >> 32;			\

There is no point doing a conditional - it just obscures things.


> 
> > 	case 32:					\
> > 		__v ^= __v >> 16;			\
> > 		fallthrough;				\
> > 	case 16:					\
> > 		__v ^= __v >> 8;			\
> > 		fallthrough;				\
> > 	case 8:						\
> > 		__v ^= __v >> 4;			\
> > 		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
> > 		break;					\
> > 	default:					\
> > 		BUILD_BUG();				\
> > 	}						\
> > 	__ret;						\
> > })  


