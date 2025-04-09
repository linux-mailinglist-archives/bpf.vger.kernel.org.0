Return-Path: <bpf+bounces-55572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C99A82EC0
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682661B680B7
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB706277811;
	Wed,  9 Apr 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0B38VKj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1C1C5F2C;
	Wed,  9 Apr 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223464; cv=none; b=iTRarqsrjKqenT2AousRc1V17+Nm5AzA9+O5go6HEcU6qswlRFTKxdyqGDUyxpSDVay961W0okxdxKzBXU9gqEV8Nv3yM/YN2N27M0fBgozL4I8suoQmJ22LO9POOCCsr4MTlvAsF9kRKuTxQGABKR2UPoW++4oojn7nbagvtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223464; c=relaxed/simple;
	bh=YU9+Qliy0QOX2sgsuyWGCNBJntINoefQp4KfR0TS7Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRszfdWfpfonOkCNZVSYKMPu6rCgFHfKMLuizgdAXkEAounOoamyjeIjhk4EtCAlfemRQcOmj25nnLW39IxFpnCrhRWk/OBoAVX27ul3HgRbmWx237oZ2d/e8yxd3jsd7TK8VxOduSRpX9GpijdKep4ki4QeIBjU92N/tA3exw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0B38VKj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af9925bbeb7so25367a12.3;
        Wed, 09 Apr 2025 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744223462; x=1744828262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWp8HcqQEiUK9VmrP5Fyuyk5glVIpEEzW3GEoFZN0j0=;
        b=C0B38VKjU6ZJ/DQF0hBrocyih9iFhh5sEwILDd7b+pghaupOMc24Tw/2Lr/sxMYRHo
         ojM7oPoib5GfthhIjjkCJjpJG9YcTxZkukbIHSiFCkQg3z7cyo0D48P7Pmx7q2GWv6EP
         sg+XYERIzRAu0cQfDy10/oUaq6cwMQOWekvCC8ZPoFS2AscFmuaSK3EE8Ld2mk394P4I
         /r1NfAdxoTKr9wBLjLDm8sxhglmWMlrScNNWVRBpZ9TNqs6rgwiNyD3K7apZ8F7yseBZ
         eyayWavWbDAU3OhueVsIngYdXIZnrGCXcYhRyLCRYQzBkjKuwwyom0BYDNEZD61rJhyJ
         svww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744223462; x=1744828262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWp8HcqQEiUK9VmrP5Fyuyk5glVIpEEzW3GEoFZN0j0=;
        b=DiDQULtxgdL1aFNZXCC+FT+xzWMlvaUOzZhKnBRzK4Mk+cL3xOvpCx3Bk/LgugAZ2g
         KeI1CSnxTKffT1RqVfGWqA9U1x+xgNCaonVVNqDhWUrrQM4PdcheS/w5scL/xO42nB1W
         REhX8mj0zp8wIAzkzwwHP0jqEBwb5oTKdTb4YLG7tXpWpNx+wxfby4VlgnmvN4zkqefo
         1sjK0gzxMsxC3Ipm8SP7HX/g+kxB/6Zz7IJ2GDcF+iSffKnHx3b9yrx0/6gL/QiAgvM2
         xnGibif4jhNhJLZG4zQZF1npSW2oCU9LK8z2VRZZNs4CNdIpOM9VpPJ8ac3/930CTJPV
         WpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAMyOVW/LWFqlQxs8VkrD1gxdAPHP5Uyg6BqDsefvn9rLt2of2s6BNl2ydt9Qlb0GZkmu7ejEOIKWU0yhl@vger.kernel.org, AJvYcCVK+KrAK8mbtZ3liQlltGjnGXFDla/DpoaGuqbdLvO6WpSBhFHY0RsOI7XjjBtBCWZT//paFy9AWtJgW0M=@vger.kernel.org, AJvYcCVKoJjgdx2if7uqcNY+TNNhlTHfgh4+pS8AMGKDK1H/Fu1gb3WFLW1A0uM/82+W4+RqkBXpJhbq@vger.kernel.org, AJvYcCVLi+/6QOR5kyrXe1uLuwDDQU6XfdugRdH0OFV/IRVyw5gQJXpI2YDFc1YDSSM4NlunR/8=@vger.kernel.org, AJvYcCVRnSlreNp+7c4WFLC2tCTXn0qf4GkQo5HSnL+UIYPQcrs9+WouNNPJZJmTsmHW9SvetCusfhoZyO63D4A=@vger.kernel.org, AJvYcCWMsS6PUa0NHqfJqGV36y9QjTFNDCWpbpFEIp+HanKIwpGUfWTdX52XOvKeAKtQ5cUmRkrZ00Fs+nZehsZM@vger.kernel.org, AJvYcCX5D83aWP/RAyEOmEz9CZA0MKtrRC3zFDBKM16U9SME/yhhaHv+DGFLoeoKy4LTFuOBLrGkW0xxyz5F7/IaFW4=@vger.kernel.org, AJvYcCXjSpFz3iDcrBmeadmDIDj52RmsPp0kXBhxB3/rwcab52Q1eJjrsJ/J0pXhwODPlcSYouPykA7f0/fTHDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzy48iytOj6ujp4WHyG39zGD3pkLnq9Kn8VukTMLn0mWJLifXD
	h7TbL9kqu/RMO7OAvu4lC0oEDOaNmHU67OhzQDnl+AlGDu+UB39E
X-Gm-Gg: ASbGncvIzD4BX89Fa09A2pFMgHc0qck6SOOyD8vToa6AIf4Ub3P1IxhFR4IczUQW/wc
	PeGionZVeFcrPau7lloonv1bzDdDDWEua7gJUBNHqdNlYAn95N+EMNjVIgxHDzwQP5J/TeZHHZD
	5oBmkHDfB8IiivkzKcfp0dyyP3u+oW3MTtDgtMLbeI8382fX7zWJCs6yJ3HyG8xrIjb/7jpbsh5
	EiudvWJidSvyf4gh4KoK20ahc/CgW6HYgCmdE6Rg+vZSVA8zW2YAJJi15VtIQ8GJ/F1WQ1xde7b
	d/kD9Bqk+P98/jfO8/+tCkG3Pk7bes/F2dQqAV1geIGUmdtUzyM86ftql9mkrB05vWhI
X-Google-Smtp-Source: AGHT+IEojffDEHS0j3whbiNP8KyNCEs3sfRNMc8qkUsRgVj5cXjPuj6Pe0BT8ErsKVVmpVlb9KZMXw==
X-Received: by 2002:a17:90b:548b:b0:2fe:a742:51b0 with SMTP id 98e67ed59e1d1-306dd5789bbmr4467876a91.31.1744223461782;
        Wed, 09 Apr 2025 11:31:01 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306eaec023asm436047a91.33.2025.04.09.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:31:01 -0700 (PDT)
Date: Thu, 10 Apr 2025 02:30:50 +0800
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
	jirislaby@kernel.org, akpm@linux-foundation.org, jdelvare@suse.com,
	linux@roeck-us.net, alexandre.belloni@bootlin.com, pgaj@cadence.com,
	hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, Frank.Li@nxp.com,
	linux-hwmon@vger.kernel.org, linux-i3c@lists.infradead.org,
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v4 05/13] serial: max3100: Replace open-coded parity
 calculation with parity_odd()
Message-ID: <Z/a82sdjEDaqE9v0@visitorckw-System-Product-Name>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-6-visitorckw@gmail.com>
 <Z_atODqZDkff5sjj@yury>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_atODqZDkff5sjj@yury>

On Wed, Apr 09, 2025 at 01:24:08PM -0400, Yury Norov wrote:
> On Wed, Apr 09, 2025 at 11:43:48PM +0800, Kuan-Wei Chiu wrote:
> > Refactor parity calculations to use the standard parity_odd() helper.
> > This change eliminates redundant implementations.
> > 
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  drivers/tty/serial/max3100.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> > index f2dd83692b2c..36ed41eef7b1 100644
> > --- a/drivers/tty/serial/max3100.c
> > +++ b/drivers/tty/serial/max3100.c
> > @@ -16,6 +16,7 @@
> >  /* 4 MAX3100s should be enough for everyone */
> >  #define MAX_MAX3100 4
> >  
> > +#include <linux/bitops.h>
> >  #include <linux/container_of.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > @@ -133,7 +134,7 @@ static int max3100_do_parity(struct max3100_port *s, u16 c)
> >  	else
> >  		c &= 0xff;
> >  
> > -	parity = parity ^ (hweight8(c) & 1);
> > +	parity = parity ^ parity_odd(c);
> 
> This can be simplified for more unless I misunderstand something...
> 
I usually don't change the existing coding style since each subsystem
may have its own preferred style.  

But yeah, if this is the preferred way, I can make this change in the
next version.

Regards,
Kuan-Wei

> From: Yury Norov <yury.norov@gmail.com>
> Date:   Wed Apr 9 13:22:04 2025 -0400
> 
> serial: max3100: Replace open-coded parity
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index f2dd83692b2c..07d332b8e87d 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -121,20 +121,12 @@ static DEFINE_MUTEX(max3100s_lock);		   /* race on probe */
>  
>  static int max3100_do_parity(struct max3100_port *s, u16 c)
>  {
> -	int parity;
> -
> -	if (s->parity & MAX3100_PARITY_ODD)
> -		parity = 1;
> -	else
> -		parity = 0;
> -
>  	if (s->parity & MAX3100_7BIT)
>  		c &= 0x7f;
>  	else
>  		c &= 0xff;
>  
> -	parity = parity ^ (hweight8(c) & 1);
> -	return parity;
> +	return s->parity & MAX3100_PARITY_ODD ? !parity(c) : parity(c);
>  }
>  
>  static int max3100_check_parity(struct max3100_port *s, u16 c)

