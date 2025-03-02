Return-Path: <bpf+bounces-52995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B0A4B2C7
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2625016B937
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D071E9B14;
	Sun,  2 Mar 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN9+Cr4x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26DA1B6D06;
	Sun,  2 Mar 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931338; cv=none; b=SyO32OS70kk0l6xTg+B7YTnpwGoGCBHqMc/cKKH4kG+SLrLHhuilUX8rsssqXckj7H3Fw40OfEAl6l82NqoVdjDlAOmxRmfpEMlx6E9RuMO+8WghTxThgEBZZnUfnYq+OOLuH+AvlG7IEVLoeru8+HIImNEjCtPk8Kuu40VhpAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931338; c=relaxed/simple;
	bh=42nc8rGbs4ozsfj3Z5uw223OqXhRXX42NQdy9kalxow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJdBcguYpQWO8asw1USB69AVufa8zKf5nRlVPBsgHmOgzB5gLor2kwuYTFQtisGIR7k8LXBQt9igd1vYrkPOk2NXKcD/9aeWjFrJs6CdAkPAit125V3p2ev4BKn0aU+dQobIZ1rpz1qf9HhIMhvJBJulVnMzSFEk2aNjkBfFW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN9+Cr4x; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e60b81c29c5so1276934276.1;
        Sun, 02 Mar 2025 08:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740931336; x=1741536136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqMp5vaYpnKO6cXrhbgbA0K1fLl4S3iWDDCzq3bGh4s=;
        b=LN9+Cr4xjdvZcDsgj0V6tkS65zXp0cIZmDXiu4NJCXMrNSPhyaSN8wc4ZQJpNLgGeO
         W2m9yRxmlLxJwJWM0Q3vOeC0KOxaBiBtHkrkCH++gqGU9G1dq6+xfv+NRTlXGQM49KF/
         CZV79r2m6gHXHUUobmJNWOj5vzDB1btDn8vR6v2nKmgO0RKw6fj1GkgrfBQxNGUqCRjj
         TyYKscoa4573tW5qUkQe9Cy+khTi+67BezsD9Fro/eUFTmig9dl0kRNjD0iSsTJbBwfq
         c5vRJ4RL8yzcFXSLmh3Znq47PNuDZ3BOSQx2bMcCHldcRE5yrj/7wCO0HrOcStQlTm8Y
         0Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740931336; x=1741536136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqMp5vaYpnKO6cXrhbgbA0K1fLl4S3iWDDCzq3bGh4s=;
        b=kKWMw/nmFbrYo/SE0rXFSSppfnV8U/Roq9WOwDL1YoMiyPfHkcKrmH4hPJblnQz1V4
         G7TUaIMs6y7Wjt+Vlqr7ivWLYfBagXdAa0ZZVQacfNRNG5bKI8ylldA1UG6asOFPRUxE
         hVr3nOQJnvpn1iL5r+dHwezdgRk5lUQ+VFWgOen2WVv72bUvd2yS+jAGR9O+M0Y3pPeB
         GqNrCkaes3q6SDrqeGpDT+lDYmmE2wgfOV6ZHDAGFmKKPkiadN/ntMqJPG/3Rdj/wfe+
         a2Ed0AhYhd84x3NbZgswKTYKx6V2loLC5qkmH6RMhC3AscMHupQHa7rJcl1PEfxtJSP0
         ycDA==
X-Forwarded-Encrypted: i=1; AJvYcCUtwQKuJjbYzoOrufOLXwuE7QPjjCyzEb9uU1KJvwrn8g/pVmSXK7S+UKODEh4hvDr6diglD4Bc@vger.kernel.org, AJvYcCUyMmUYXIx6kQwiEH19nDaGg2M/TLXmKZbmGnyhe+9EmKJsR84tYrr02gdPHavXQxR8MDVLUBKKLPhSVk08@vger.kernel.org, AJvYcCVCgLqzz0nAADxxkqYP9wr2BwHPz9awYcSCnfIwo6CjF16I6JpsI6lFrMzu331saPqLJ0UssS1JC7EPQGc=@vger.kernel.org, AJvYcCW/m7N9eYXCVHc8gVjibCRpvzeRfsNaoclGKfFNAQ/Sf6m4Q/YKONOspqByiipYPpGcak0gDsdk2ndiJwg=@vger.kernel.org, AJvYcCWLwMZGTdX+4dNPw3jmem0oPzzUW3CUjkoPTVGjQSixLRVthuQFbX1Wh2X80dOuxJIz0Eo=@vger.kernel.org, AJvYcCXY9YgSdCyaj2CnDH23aYaSHsIZXbXgLbGuABLaAuHg9h9s8o4AHgzkgw+Oe/7xtcn7NCjT5HUAcEY3OXH8LRA=@vger.kernel.org, AJvYcCXmJ6Gc6cho2KLfZh6TRfKjeOX86sq2TjQ1U2Zwbf/I1CMLQSRXC8Xe7DyLkDpS+JFqx57Dte5Bm68W8+I5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xXRjRywPxjNlBnMy/dl0mr1iwGANC/l3zzCeMdN5ES+XMCf5
	FZulCrH75cvT33g7LxTcVRtysOCKH1oEytzDPCLcDEOpAhYOxW80
X-Gm-Gg: ASbGncsZKpGYFskqX2ONxjKoRi/30rSE7hazVVft5NirWJ9mmfDKcmGwlKtNHQQ5Li/
	RrErlkqDtk93Zs75RtD6hGB8K3qSyHkAF8tC4eAn/chCgIbdnAn9Ndjwhtfz+EVCwtEUTzNzJbH
	k1GarvAcU7+B956WnXy7byE0CnFmrLBLSwEpKsraASdD9kmyU15szqCVk14KShujXbB3A7pecAo
	AdnEl0g28+JMg80Yrjifmc9i31bHWkWr79Uq2RoFVhMI51F6zwcimNDCrDSaVJODciqjj+mDL0q
	Ud5EomWMXFxpoxekyz20ZKOh+7S7rXp6Td0Lf0WB+ISGkN4KWp8XE3QkmY+NvdKmEJ8AE/RZ2kk
	VaGDW
X-Google-Smtp-Source: AGHT+IGTA2Ffxb6HyDj6e6db1ev2VVk/M561S2KqXTIWcogd5CMLT4NZ5B2IRrPsjUAAQ5n/S5KqaA==
X-Received: by 2002:a05:6902:1089:b0:e60:88f9:b081 with SMTP id 3f1490d57ef6-e60b23f8464mr13571127276.17.1740931335559;
        Sun, 02 Mar 2025 08:02:15 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3a417a6sm2354159276.28.2025.03.02.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:02:14 -0800 (PST)
Date: Sun, 2 Mar 2025 11:02:12 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
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
Message-ID: <Z8SBBM_81wyHfvC0@thinkpad>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
 <20250301142409.2513835-2-visitorckw@gmail.com>
 <Z8PMHLYHOkCZJpOh@thinkpad>
 <Z8QUsgpCB0m2qKJR@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8QUsgpCB0m2qKJR@visitorckw-System-Product-Name>

On Sun, Mar 02, 2025 at 04:20:02PM +0800, Kuan-Wei Chiu wrote:
> Hi Yury,
> 
> On Sat, Mar 01, 2025 at 10:10:20PM -0500, Yury Norov wrote:
> > On Sat, Mar 01, 2025 at 10:23:52PM +0800, Kuan-Wei Chiu wrote:
> > > Add generic C implementations of __paritysi2(), __paritydi2(), and
> > > __parityti2() as fallback functions in lib/parity.c. These functions
> > > compute the parity of a given integer using a bitwise approach and are
> > > marked with __weak, allowing architecture-specific implementations to
> > > override them.
> > > 
> > > This patch serves as preparation for using __builtin_parity() by
> > > ensuring a fallback mechanism is available when the compiler does not
> > > inline the __builtin_parity().
> > > 
> > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > >  lib/Makefile |  2 +-
> > >  lib/parity.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 49 insertions(+), 1 deletion(-)
> > >  create mode 100644 lib/parity.c
> > > 
> > > diff --git a/lib/Makefile b/lib/Makefile
> > > index 7bab71e59019..45affad85ee4 100644
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -51,7 +51,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
> > >  	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
> > >  	 percpu-refcount.o rhashtable.o base64.o \
> > >  	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
> > > -	 generic-radix-tree.o bitmap-str.o
> > > +	 generic-radix-tree.o bitmap-str.o parity.o
> > >  obj-y += string_helpers.o
> > >  obj-y += hexdump.o
> > >  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> > > diff --git a/lib/parity.c b/lib/parity.c
> > > new file mode 100644
> > > index 000000000000..a83ff8d96778
> > > --- /dev/null
> > > +++ b/lib/parity.c
> > > @@ -0,0 +1,48 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * lib/parity.c
> > > + *
> > > + * Copyright (C) 2025 Kuan-Wei Chiu <visitorckw@gmail.com>
> > > + * Copyright (C) 2025 Yu-Chun Lin <eleanor15x@gmail.com>
> > > + *
> > > + * __parity[sdt]i2 can be overridden by linking arch-specific versions.
> > > + */
> > > +
> > > +#include <linux/export.h>
> > > +#include <linux/kernel.h>
> > > +
> > > +/*
> > > + * One explanation of this algorithm:
> > > + * https://funloop.org/codex/problem/parity/README.html
> > 
> > I already asked you not to spread this link. Is there any reason to
> > ignore it?
> > 
> In v2, this algorithm was removed from bitops.h, so I moved the link
> here instead. I'm sorry if it seemed like I ignored your comment.

Yes, it is.
 
> In v1, I used the same approach as parity8() because I couldn't justify
> the performance impact in a specific driver or subsystem. However,
> multiple people commented on using __builtin_parity or an x86 assembly
> implementation. I'm not ignoring their feedback-I want to address these

Please ask those multiple people: are they ready to maintain all that
zoo of macros, weak implementations, arch implementations and stubs
for no clear benefit? Performance is always worth it, but again I see
not even a hint that the drivers care about performance. You don't
measure it, so don't care as well. Right?

> comments. Before submitting, I sent an email explaining my current
> approach: using David's suggested method along with __builtin_parity,
> but no one responded. So, I decided to submit v2 for discussion
> instead.

For discussion use tag RFC.

> 
> To avoid mistakes in v3, I want to confirm the following changes before
> sending it:
> 
> (a) Change the return type from int to bool.
> (b) Avoid __builtin_parity and use the same approach as parity8().
> (c) Implement parity16/32/64() as single-line inline functions that
>     call the next smaller variant after xor.
> (d) Add a parity() macro that selects the appropriate parityXX() based
>     on type size.
> (e) Update users to use this parity() macro.
> 
> However, (d) may require a patch affecting multiple subsystems at once
> since some places that already include bitops.h have functions named
> parity(), causing conflicts. Unless we decide not to add this macro in
> the end.
> 
> As for checkpatch.pl warnings, they are mostly pre-existing coding
> style issues in this series. I've kept them as-is, but if preferred,
> I'm fine with fixing them.

Checkpatch only complains on new lines. Particularly this patch should
trigger checkpatch warning because it adds a new file but doesn't touch
MAINTAINERS. 

> If anything is incorrect or if there are concerns, please let me know.
> 
> Regards,
> Kuan-Wei
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index c1cb53cf2f0f..47b7eca8d3b7 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -260,6 +260,43 @@ static inline int parity8(u8 val)
>  	return (0x6996 >> (val & 0xf)) & 1;
>  }
> 
> +static inline bool parity16(u16 val)
> +{
> +	return parity8(val ^ (val >> 8));
> +}
> +
> +static inline bool parity32(u32 val)
> +{
> +	return parity16(val ^ (val >> 16));
> +}
> +
> +static inline bool parity64(u64 val)
> +{
> +	return parity32(val ^ (val >> 32));
> +}

That was discussed between Jiri and me in v2. Fixed types functions
are needed only in a few very specific cases. With the exception of
I3C driver (which doesn't look good for both Jiri and me), all the
drivers have the type of variable passed to the parityXX() matching 
the actual variable length. It means that fixed-type versions of the
parity() are simply not needed. So if we don't need them, please don't
introduce it.

> +#define parity(val)			\
> +({					\
> +	bool __ret;			\
> +	switch (BITS_PER_TYPE(val)) {	\
> +	case 64:			\
> +		__ret = parity64(val);	\
> +		break;			\
> +	case 32:			\
> +		__ret = parity32(val);	\
> +		break;			\
> +	case 16:			\
> +		__ret = parity16(val);	\
> +		break;			\
> +	case 8:				\
> +		__ret = parity8(val);	\
> +		break;			\
> +	default:			\
> +		BUILD_BUG();		\
> +	}				\
> +	__ret;				\
> +})
> +
>  /**
>   * __ffs64 - find first set bit in a 64 bit word
>   * @word: The 64 bit word

