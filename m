Return-Path: <bpf+bounces-52996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 118ADA4B3C9
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 18:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2121716D059
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DFD1EB190;
	Sun,  2 Mar 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku4nRnYD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056521EB18B;
	Sun,  2 Mar 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740936573; cv=none; b=fXiuxJ8ue79ZtmBy1nTDL1Hv+1uP/S/2crp8h/Jz6lYrJOVk1jyDvy1UbRrQEAPEbKeS/5DdrG1CD+Qq1Lr1dmRkvqvMbmLOP+oxKr72WTpTxyL5QLgCVXwx4xwcpNWZopZ5Hhj0oDwbrxGTnwLbWm3Zi7HCNa84msxhkk9vAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740936573; c=relaxed/simple;
	bh=mRzK81WHJHTndXXtB07n2RGrc5R8+JCcyGyDYlThWQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLJUwGfbywMoyTW+UYE/0g4nyx0Mz9OmJCTrMSUjfvO4RJJ6swmzlX9EXMX2UGxVs6AVBNNUtsZpvw3iARyLkUh4rldoMVc6cZj+umVgYvkgkLdm9HfEAhw+zCy8cPABoVjm/CHPlFNDYnmx/b2mX7/mjOsQrwr8W8SnFwnyUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku4nRnYD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223480ea43aso91883375ad.1;
        Sun, 02 Mar 2025 09:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740936571; x=1741541371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6ZCGe4y+NrZlyq86eJklBAPAtlKmsrb7/h5k5VN62A=;
        b=Ku4nRnYDsKQeqBrL5R7ViWfuqkwD/GDtFE3QY1+Wx3iCo1AVAKRcvpnv99rLFygaQ5
         vYSxiK+pepm5fzeQwpm8OEqNryu8S5Ez358WVtoM2Op802ak9A3pfpwdVj7LVeoj/68q
         W5yQKvsmkYoD8BG2WdRT8mI7OsrCHJNIF8eDYhOlIXAX0ItzaYZOzGqHvDGFxLhSeOtG
         GR1BndvA7+fNJ6BT3SQWQpZOW/NqHkljy2ABU+Du1FH8qltwSDlbi1t3a3vVZmcgM/T1
         HoTf/edBSpvYmbyCuGwL9LW1aiLyQN7rb5RLrZwwRaaIl6a+FEv2qpVhj7YvS9mqZd3J
         COyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740936571; x=1741541371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6ZCGe4y+NrZlyq86eJklBAPAtlKmsrb7/h5k5VN62A=;
        b=VlqtOrbZqTaNC0yxwSJnqybwpRAmyJfaes1EdCRyqqdo5YUIOwE3zGz2Jgq8oRkMvg
         7Ow2UMY8R7JIbZ4CtWGEOlhUoNY+YfAFP196ReeiTromBi4QFYYtS3XKwdexZol7dx+U
         f9F2RKlMQBB77w9fIXAfudB8DbtOcrm9NzhpGE3dDY73NuRcW1nImip4+KfHYMpIlWyp
         n5nN90Oam3zuWakzZH0Hrc+xAPaGQZkNIsMO9XjZwRwLU3XyiYaQSXm7vZ1sRfnH18i8
         rmx7prX0vNXpxBFWybkENOVo0sRhxb6dI7iZhRRDU6rVIZOrhCdXrv+B/h72I0hbSIS5
         zcdg==
X-Forwarded-Encrypted: i=1; AJvYcCUHzMUDET95R7nHWV8U+yXCjJQAmTc/3A4F0vABmk+pdRF+rG3JQtaxgX5BWXdpIpDvckc912TpG2sDpcJGCUk=@vger.kernel.org, AJvYcCUJbP8x7AfvVSu/JN0zUusr5nYdZFNB+cTVrgG6sX/l53WWGuT9gtK8WrEm0p4HQsaxYPNezOtOqxndA1pX@vger.kernel.org, AJvYcCVCjV34Z+6iKfKSS933Lb/WzUuDwNE0lVPJ1SFag8bqo0cn94CT0RbjxxfRpdiBSPmH6CA=@vger.kernel.org, AJvYcCVNBrM4m/KqOaEihT9b/6d/mV7zFHgcPCYjEiazt7h11Ej87/QydtB4xMfrwX37o7QZ8/1G4CoJWMQcfuE=@vger.kernel.org, AJvYcCVzt0ZAJjZTZUlSdxW1z0x9l44eqk5Nf5zvKr3aTCLkOqnDljHQpAJY9DstIz4a22d6/0LERDeui0C6XZDU@vger.kernel.org, AJvYcCXbG3sFkcv9SZMXfQyELzms79Crpfh6twf9Q1xZ2ZrKxvexEJ8YJvGFXOa/JU0FGeFNpeWTr7zX6MhFggA=@vger.kernel.org, AJvYcCXcEm8Mp15F4XkKFZv/HS3ohyRBpVe8yb24JAJWKTS5xAEk0FEoXDeEnVJI182BKc7PZQM/5/LA@vger.kernel.org
X-Gm-Message-State: AOJu0YxrAmUa7CglVjTKytQUA7XE9wtxgjZRsinMK7Vmq/SRS7JLF1u0
	Q5B6ZyRTKBr2HifzYBjs9DxOgZz5dZqc5G4JIsZyCBy2D2CYNR3z
X-Gm-Gg: ASbGnctMd/cOKA/TwJHJMI2F1jCT4TLaPY6JOETCCbJaUVr3ddM4xe21Cezpar0PEp9
	EDE+TL5x6S7UzB2ragVDQFwNMCmEA/2Lsyz/p8vR7yfqUhHv7O4FLH24+B9PiwFbTbZ5cGCqtF+
	2b6cOffXzLSyjf8q4dYvH0ooFt6FXPOxd7C8lntBYeU2EqCU69VTtZ84C0tuY1iR4pl4lXBsRlL
	YNNAtikpJ3twTaoSduziZQ3/tP/n9lBt2JaflzteSRyBkRdXNN99A/r7EWpmU2WtrI2lvt5YAkQ
	KixFCnA9yFagl/ZDTNo2/6WMJju8O3xyqJW9BMGJy3fyRBMZ++DvNvcdNpV0LfzPpMukljOl
X-Google-Smtp-Source: AGHT+IFt6urRym4WR3nEgHXocQXsBPo8f95q1Tv9F4zN9t1ak3mwZH/5HEBVwX+gwh+7S1iAMAQaDw==
X-Received: by 2002:a17:902:ce8f:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-22368fa8f91mr140115905ad.19.1740936571101;
        Sun, 02 Mar 2025 09:29:31 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc28esm62734585ad.166.2025.03.02.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 09:29:30 -0800 (PST)
Date: Mon, 3 Mar 2025 01:29:19 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
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
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 01/18] lib/parity: Add __builtin_parity() fallback
 implementations
Message-ID: <Z8SVb4xD4tTiMEpL@visitorckw-System-Product-Name>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
 <20250301142409.2513835-2-visitorckw@gmail.com>
 <Z8PMHLYHOkCZJpOh@thinkpad>
 <Z8QUsgpCB0m2qKJR@visitorckw-System-Product-Name>
 <Z8SBBM_81wyHfvC0@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8SBBM_81wyHfvC0@thinkpad>

Hi Yury,

On Sun, Mar 02, 2025 at 11:02:12AM -0500, Yury Norov wrote:
> On Sun, Mar 02, 2025 at 04:20:02PM +0800, Kuan-Wei Chiu wrote:
> > Hi Yury,
> > 
> > On Sat, Mar 01, 2025 at 10:10:20PM -0500, Yury Norov wrote:
> > > On Sat, Mar 01, 2025 at 10:23:52PM +0800, Kuan-Wei Chiu wrote:
> > > > Add generic C implementations of __paritysi2(), __paritydi2(), and
> > > > __parityti2() as fallback functions in lib/parity.c. These functions
> > > > compute the parity of a given integer using a bitwise approach and are
> > > > marked with __weak, allowing architecture-specific implementations to
> > > > override them.
> > > > 
> > > > This patch serves as preparation for using __builtin_parity() by
> > > > ensuring a fallback mechanism is available when the compiler does not
> > > > inline the __builtin_parity().
> > > > 
> > > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > ---
> > > >  lib/Makefile |  2 +-
> > > >  lib/parity.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 49 insertions(+), 1 deletion(-)
> > > >  create mode 100644 lib/parity.c
> > > > 
> > > > diff --git a/lib/Makefile b/lib/Makefile
> > > > index 7bab71e59019..45affad85ee4 100644
> > > > --- a/lib/Makefile
> > > > +++ b/lib/Makefile
> > > > @@ -51,7 +51,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
> > > >  	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
> > > >  	 percpu-refcount.o rhashtable.o base64.o \
> > > >  	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
> > > > -	 generic-radix-tree.o bitmap-str.o
> > > > +	 generic-radix-tree.o bitmap-str.o parity.o
> > > >  obj-y += string_helpers.o
> > > >  obj-y += hexdump.o
> > > >  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> > > > diff --git a/lib/parity.c b/lib/parity.c
> > > > new file mode 100644
> > > > index 000000000000..a83ff8d96778
> > > > --- /dev/null
> > > > +++ b/lib/parity.c
> > > > @@ -0,0 +1,48 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * lib/parity.c
> > > > + *
> > > > + * Copyright (C) 2025 Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > + * Copyright (C) 2025 Yu-Chun Lin <eleanor15x@gmail.com>
> > > > + *
> > > > + * __parity[sdt]i2 can be overridden by linking arch-specific versions.
> > > > + */
> > > > +
> > > > +#include <linux/export.h>
> > > > +#include <linux/kernel.h>
> > > > +
> > > > +/*
> > > > + * One explanation of this algorithm:
> > > > + * https://funloop.org/codex/problem/parity/README.html
> > > 
> > > I already asked you not to spread this link. Is there any reason to
> > > ignore it?
> > > 
> > In v2, this algorithm was removed from bitops.h, so I moved the link
> > here instead. I'm sorry if it seemed like I ignored your comment.
> 
> Yes, it is.
>  
> > In v1, I used the same approach as parity8() because I couldn't justify
> > the performance impact in a specific driver or subsystem. However,
> > multiple people commented on using __builtin_parity or an x86 assembly
> > implementation. I'm not ignoring their feedback-I want to address these
> 
> Please ask those multiple people: are they ready to maintain all that
> zoo of macros, weak implementations, arch implementations and stubs
> for no clear benefit? Performance is always worth it, but again I see
> not even a hint that the drivers care about performance. You don't
> measure it, so don't care as well. Right?
> 
> > comments. Before submitting, I sent an email explaining my current
> > approach: using David's suggested method along with __builtin_parity,
> > but no one responded. So, I decided to submit v2 for discussion
> > instead.
> 
> For discussion use tag RFC.
> 
> > 
> > To avoid mistakes in v3, I want to confirm the following changes before
> > sending it:
> > 
> > (a) Change the return type from int to bool.
> > (b) Avoid __builtin_parity and use the same approach as parity8().
> > (c) Implement parity16/32/64() as single-line inline functions that
> >     call the next smaller variant after xor.
> > (d) Add a parity() macro that selects the appropriate parityXX() based
> >     on type size.
> > (e) Update users to use this parity() macro.
> > 
> > However, (d) may require a patch affecting multiple subsystems at once
> > since some places that already include bitops.h have functions named
> > parity(), causing conflicts. Unless we decide not to add this macro in
> > the end.
> > 
> > As for checkpatch.pl warnings, they are mostly pre-existing coding
> > style issues in this series. I've kept them as-is, but if preferred,
> > I'm fine with fixing them.
> 
> Checkpatch only complains on new lines. Particularly this patch should
> trigger checkpatch warning because it adds a new file but doesn't touch
> MAINTAINERS. 
> 
For example, the following warning:

ERROR: space required after that ',' (ctx:VxV)
#84: FILE: drivers/input/joystick/sidewinder.c:368:
+                       if (!parity64(GB(0,33)))
                                          ^

This issue already existed before this series, and I'm keeping its
style unchanged for now.

> > If anything is incorrect or if there are concerns, please let me know.
> > 
> > Regards,
> > Kuan-Wei
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index c1cb53cf2f0f..47b7eca8d3b7 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -260,6 +260,43 @@ static inline int parity8(u8 val)
> >  	return (0x6996 >> (val & 0xf)) & 1;
> >  }
> > 
> > +static inline bool parity16(u16 val)
> > +{
> > +	return parity8(val ^ (val >> 8));
> > +}
> > +
> > +static inline bool parity32(u32 val)
> > +{
> > +	return parity16(val ^ (val >> 16));
> > +}
> > +
> > +static inline bool parity64(u64 val)
> > +{
> > +	return parity32(val ^ (val >> 32));
> > +}
> 
> That was discussed between Jiri and me in v2. Fixed types functions
> are needed only in a few very specific cases. With the exception of
> I3C driver (which doesn't look good for both Jiri and me), all the
> drivers have the type of variable passed to the parityXX() matching 
> the actual variable length. It means that fixed-type versions of the
> parity() are simply not needed. So if we don't need them, please don't
> introduce it.
>
So, I should add the following parity() macro in v3, remove parity8(),
and update all current parity8() users to use this macro, right?

I changed u64 to __auto_type and applied David's suggestion to replace
the >> 32 with >> 16 >> 16 to avoid compiler warnings.

Regards,
Kuan-Wei

#define parity(val)					\
({							\
	__auto_type __v = (val);			\
	bool __ret;					\
	switch (BITS_PER_TYPE(val)) {			\
	case 64:					\
		__v ^= __v >> 16 >> 16;			\
		fallthrough;				\
	case 32:					\
		__v ^= __v >> 16;			\
		fallthrough;				\
	case 16:					\
		__v ^= __v >> 8;			\
		fallthrough;				\
	case 8:						\
		__v ^= __v >> 4;			\
		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
		break;					\
	default:					\
		BUILD_BUG();				\
	}						\
	__ret;						\
})

