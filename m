Return-Path: <bpf+bounces-52505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8FA440F6
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 14:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E38177EB3
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69726989E;
	Tue, 25 Feb 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQPxoo+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09F1C8600;
	Tue, 25 Feb 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490194; cv=none; b=MAfvpF00drrCdtGEwTD5VrJj4BhCjEwzfVtX5c0Yo05OyNBba09W0Wq3GZTFgkvMONOfX8XjhlaQh3PDdTDsczj+Knl0MBEUudmpQHWro+UigJkosTqaq3TMJmSFnV6MZzuEfo2TwUj0syguzv4+WQqzwm5fqm/+o09Dr8/FAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490194; c=relaxed/simple;
	bh=IV9pRGxFK2DrtjZkiJyzjsjNw8Mw0JCY+k9J5CdGxZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmRDlMgaMi4zqfuEEz/6r2u4Xi3HEi7OvaNF2TbsFKjhMxb0E6Eb1NY4bTn55B6IbyT6z37I4yiW81z42wLLX765HGDqyI5nF+IRQ6X6jKIXP5GxYwHEOcYPF4Mmis8DS/SKZ2NOY+ys/pz1UNJtIM9IkI0qPuFjxXbtw/7mHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQPxoo+w; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso7239205a91.3;
        Tue, 25 Feb 2025 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740490192; x=1741094992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+KT3KVpGLuA4u2NJNwnGzORc7aygCrbdYn7UVwmV+4=;
        b=TQPxoo+wdE2rqVazCzm+HUMS+R4vvlOtYbRCs6f82uFhavM25oFu26oBcS9Jlm9BIy
         ladBYUeHrU5JxF+6sYG/boW8gHeZB62pKArrebgHZ+68ECfKdkR+nrQGzL2BhD0BkLor
         XBB9h1ogWRn+/KEM9uu2nBhdaCqbf4piJzmDz4zEBFxpvJbJOTQ5dDfpYJMQ2AS5ytJe
         cYyQecVc83NWO6pUIhl2j2CKfRQT5jv03DeB7Bh8F4v/r2aUnusZIuWtZYE3eGDNffWX
         s2SagQW6Nmno5boIXRXhL/EbJ5INliJm3DwACpK3Ue8s8pJ2YIbDiSrQZVYLv0lvLAlF
         mFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490192; x=1741094992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+KT3KVpGLuA4u2NJNwnGzORc7aygCrbdYn7UVwmV+4=;
        b=uoIFYixrW30dLS6uu9BKyM7SUH1hIADHIj0WsioUIf67G+rLMEnRAH6PfF1L2K6Vc7
         xnPfGft0mPcgZ26rIJXODvAiwa8GT7Tlo3MaWpqgiEnJMbhsXb/D+Ci25T/iUIa7QN/9
         33SPE5KNUa0HmYgN6/3ntyCGt6Ld1T4xl/Sd28hyxj/fIHAJ5K5X40bJKuC359ZqXmy7
         IWYU4Aoc9nnVOx2AchA/UhOHZ4ktuT5nQ1Ay7vDEpTrMgDPJlIab6osjfsym9jncq4g3
         5WW6cfwVoQfK/f1YobtJBPX+NQ9OlZ0N0qq/Xaa/MO+GaUi4T6+O2vn4PjpOHA4xSG+K
         6rTg==
X-Forwarded-Encrypted: i=1; AJvYcCUC59F+KKgFCo1AhUAIf+Bd5ymk65dgXTFNM2r/TPfWyzT5aOLS6ObEzzZlKaYUL3ByiN3V+ukr@vger.kernel.org, AJvYcCV+zDlcekj01JKYEkL+XmG0XLmA5GoJt+V6S1bVq1vnAsw0s9i4g66eVV75sJMcI4TNeMDc35WhinFhM1Oj@vger.kernel.org, AJvYcCWApCTOOLjnIWZI0RtlXXTZTPhGJ66H5gHVsgSpEyuqxzvT9AUXhytzL9wGGAvCiz6ghTXpzmxnxwBEVMM=@vger.kernel.org, AJvYcCWQQRm+RL45vpgzsfUFFoZD/mW8x1QEWif3JRg2dYplCYplt4LffTl+2COv6GIO6L+Bq+zShTTRmCFT3WIn@vger.kernel.org, AJvYcCWaWiKXZKUjKdVhGaNEBkNsg2funj1gCbsBY93tb2d0lbbTrxp9cPkuD1fuxKWolnYxzpNlXsTjKQQo99PUKXw=@vger.kernel.org, AJvYcCWfs5ePypY2AU54Iof69rIi1VUHd+33XxtAkXkgVG92r1le0hJYcSz+U4Y/JbFdUwfSNP8=@vger.kernel.org, AJvYcCXrErbDyztFnEYm7YZO0dkDUygAfiofrBBxqmQwGNfemtUU0wxaVoyolZM41EnoU+ceLYCoVuegK52fBEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFNNrzzAC7h5MnoekXNbVCEAvhbMtfzqKLtAy9g+0tTd3kVcri
	G7WZrNQ3Kgu41n98cWTmZhH8kS+1t2T19HiS8wZRsGCGa7UQ4Evw
X-Gm-Gg: ASbGncuRGqjPFfXnVC2y7/PXltHg3IGvE1pdN4N5GAB6jTn4syTPFHCQCOWKBN7Gl0F
	yjpeNvd9YcMzFfYdIolxVJnZxtLx8sIuZCklJ6AeVe1CO1cmnWsmB0pgCiHn8R9H5ZgGdBrH8Ve
	6xvYyxH9Mlmr3d2CKHaGEbj3zBQ0b20taUX3Su+O2iT0jq8k48LI1Xt1JVLTl2P6tg6p77Xh9DH
	mopKlwdQpbR/AOev6bkg+m1TQtljj6alp56JfdH4HCauJVEjbQsnzF8Lbd1ozCyfZonAeVt9pov
	xB36EVSvjQ/q0D19jRkeP3wyHoQu++IsIPyT5DBsfXFVaiNCNO4T7w==
X-Google-Smtp-Source: AGHT+IHJCYV1yTKSOK6eGDyBnxKUrcQWKWx/K+mHz5nLdmHbZ4ukNdWQzUzjXs+WMIoPjs0tLGemNA==
X-Received: by 2002:a17:90b:3941:b0:2fa:e9b:33ab with SMTP id 98e67ed59e1d1-2fce78acd26mr32192478a91.16.1740490191556;
        Tue, 25 Feb 2025 05:29:51 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02d51fsm8424850a91.2.2025.02.25.05.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:29:50 -0800 (PST)
Date: Tue, 25 Feb 2025 21:29:40 +0800
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
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
Message-ID: <Z73FxIv353lbXO3A@visitorckw-System-Product-Name>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-3-visitorckw@gmail.com>
 <Z7zIBwH4aUA7G9MY@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zIBwH4aUA7G9MY@thinkpad>

Hi Yury,

On Mon, Feb 24, 2025 at 02:27:03PM -0500, Yury Norov wrote:
> On Mon, Feb 24, 2025 at 12:42:02AM +0800, Kuan-Wei Chiu wrote:
> > Several parts of the kernel open-code parity calculations using
> > different methods. Add a generic parity64() helper implemented with the
> > same efficient approach as parity8().
> 
> No reason to add parity32() and parity64() in separate patches

Ack.

>  
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  include/linux/bitops.h | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index fb13dedad7aa..67677057f5e2 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -281,6 +281,28 @@ static inline int parity32(u32 val)
> >  	return (0x6996 >> (val & 0xf)) & 1;
> >  }
> >  
> > +/**
> > + * parity64 - get the parity of an u64 value
> > + * @value: the value to be examined
> > + *
> > + * Determine the parity of the u64 argument.
> > + *
> > + * Returns:
> > + * 0 for even parity, 1 for odd parity
> > + */
> > +static inline int parity64(u64 val)
> > +{
> > +	/*
> > +	 * One explanation of this algorithm:
> > +	 * https://funloop.org/codex/problem/parity/README.html
> 
> This is already referenced in sources. No need to spread it for more.

Ack.

> 
> > +	 */
> > +	val ^= val >> 32;
> > +	val ^= val >> 16;
> > +	val ^= val >> 8;
> > +	val ^= val >> 4;
> > +	return (0x6996 >> (val & 0xf)) & 1;
> 
> It's better to avoid duplicating the same logic again and again.

Ack.

> 
> > +}
> > +
> 
> So maybe make it a macro?
> 
> 
> From f17a28ae3429f49825d65ebc0f7717c6a191a3e2 Mon Sep 17 00:00:00 2001
> From: Yury Norov <yury.norov@gmail.com>
> Date: Mon, 24 Feb 2025 14:14:27 -0500
> Subject: [PATCH] bitops: generalize parity8()
> 
> The generic parity calculation approach may be easily generalized for
> other standard types. Do that and drop sub-optimal implementation of
> parity calculation in x86 code.
> 
> Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> ---
>  arch/x86/kernel/bootflag.c | 14 +-----------
>  include/linux/bitops.h     | 47 +++++++++++++++++++++++++++-----------
>  2 files changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
> index 3fed7ae58b60..4a85c69a28f8 100644
> --- a/arch/x86/kernel/bootflag.c
> +++ b/arch/x86/kernel/bootflag.c
> @@ -2,6 +2,7 @@
>  /*
>   *	Implement 'Simple Boot Flag Specification 2.0'
>   */
> +#include <linux/bitops.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> @@ -20,19 +21,6 @@
>  
>  int sbf_port __initdata = -1;	/* set via acpi_boot_init() */
>  
> -static int __init parity(u8 v)
> -{
> -	int x = 0;
> -	int i;
> -
> -	for (i = 0; i < 8; i++) {
> -		x ^= (v & 1);
> -		v >>= 1;
> -	}
> -
> -	return x;
> -}
> -
>  static void __init sbf_write(u8 v)
>  {
>  	unsigned long flags;
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index c1cb53cf2f0f..29601434f5f4 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -230,10 +230,10 @@ static inline int get_count_order_long(unsigned long l)
>  }
>  
>  /**
> - * parity8 - get the parity of an u8 value
> + * parity - get the parity of a value
>   * @value: the value to be examined
>   *
> - * Determine the parity of the u8 argument.
> + * Determine parity of the argument.
>   *
>   * Returns:
>   * 0 for even parity, 1 for odd parity
> @@ -241,24 +241,45 @@ static inline int get_count_order_long(unsigned long l)
>   * Note: This function informs you about the current parity. Example to bail
>   * out when parity is odd:
>   *
> - *	if (parity8(val) == 1)
> + *	if (parity(val) == 1)
>   *		return -EBADMSG;
>   *
>   * If you need to calculate a parity bit, you need to draw the conclusion from
>   * this result yourself. Example to enforce odd parity, parity bit is bit 7:
>   *
> - *	if (parity8(val) == 0)
> + *	if (parity(val) == 0)
>   *		val ^= BIT(7);
> + *
> + * One explanation of this algorithm:
> + * https://funloop.org/codex/problem/parity/README.html
>   */
> -static inline int parity8(u8 val)
> -{
> -	/*
> -	 * One explanation of this algorithm:
> -	 * https://funloop.org/codex/problem/parity/README.html
> -	 */
> -	val ^= val >> 4;
> -	return (0x6996 >> (val & 0xf)) & 1;
> -}
> +#define parity(val)					\
> +({							\
> +	u64 __v = (val);				\
> +	int __ret;					\
> +	switch (BITS_PER_TYPE(val)) {			\
> +	case 64:					\
> +		__v ^= __v >> 32;			\
> +		fallthrough;				\
> +	case 32:					\
> +		__v ^= __v >> 16;			\
> +		fallthrough;				\
> +	case 16:					\
> +		__v ^= __v >> 8;			\
> +		fallthrough;				\
> +	case 8:						\
> +		__v ^= __v >> 4;			\
> +		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
> +		break;					\
> +	default:					\
> +		BUILD_BUG();				\
> +	}						\
> +	__ret;						\
> +})
> +
> +#define parity8(val)	parity((u8)(val))
> +#define parity32(val)	parity((u32)(val))
> +#define parity64(val)	parity((u64)(val))
>  
What do you think about using these inline functions instead of macros?
Except for parity8(), each function is a single line and follows the
same logic. I find inline functions more readable, and coding-style.rst
also recommends them over macros.

Regards,
Kuan-Wei

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index c1cb53cf2f0f..d518a382f1fe 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -260,6 +260,26 @@ static inline int parity8(u8 val)
 	return (0x6996 >> (val & 0xf)) & 1;
 }
 
+static inline parity16(u16 val)
+{
+	return parity8(val ^ (val >> 8));
+}
+
+static inline parity16(u16 val)
+{
+	return parity8(val ^ (val >> 8));
+}
+
+static inline parity32(u32)
+{
+	return parity16(val ^ (val >> 16));
+}
+
+static inline parity64(u64)
+{
+	return parity32(val ^ (val >> 32));
+}
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word


>  /**
>   * __ffs64 - find first set bit in a 64 bit word
> -- 
> 2.43.0
> 

