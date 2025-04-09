Return-Path: <bpf+bounces-55571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA89A82EA4
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559FF8A0760
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1B277809;
	Wed,  9 Apr 2025 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9r/mblB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7FA1C5D63;
	Wed,  9 Apr 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223173; cv=none; b=pT+iMKYkQ7Mwx5cTcxg96ptSslryUqvN7y/Td+z1h1yQMnDoSv2r9giVll/SPsa67Ph6yTgX5P6dh3DIl+7Q8IjgjeAjFN7p5lWMTpH05WjY2e7r6SkZUYoy55jeGWAzv3Am0HfQ4ZInBgSrk22bjj6L3KejA8x31JBQfBilth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223173; c=relaxed/simple;
	bh=WinZEkBYoroDVCRkU7XKcwh4/NdCurc0ZL1FOEMbSZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzRSTmSqMvpCFPTYG1pebBhvaJwqCiir5AIgqG4ZTIFS0I5L54ayIQkDbwYwnMWHWpDibdzTvMA75Rhj+CwEbGVIq7dtmlUmCMGDh7MSe3CUbxwwgd/U2p85naM26vqiM50EDNjQH4lISzOjTCF9Azm8oK9OiusdDJTJrEKbKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9r/mblB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2295d78b45cso97198795ad.0;
        Wed, 09 Apr 2025 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744223170; x=1744827970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1ALuPxklMKuCrsJA1BlLBcVNfra0g2589L/7At2Du0=;
        b=D9r/mblBQhaF5ZAN0DO1kygobk99eWqTkcdIgtJum5ENtjfVfPOt5+DCIbpw2Z74xH
         Di5BzHYw3l20WHbvWUgLhuQOB0gbsBc0rJv1M0z60jAW9J8n6hg1mIJPkJVwapbC8KMB
         OcL2vX80BnpeFmMyqsn3p/iUb1pHJwBI1BkeJ5pz8B0AqYQXiCXzvN95gvloIcmk+1Xo
         gmEQaIS077gmFWlqGjTr7zGTimEVdmPPQhmqS0Y1k2HwWUnhVVBcoCL4fdUOSwIwHt0t
         RChcHcsxyJ/tU1pTndvRpHtBSnW+un+OY2/uMMfXHE5XxVBShVVfXzuAgKgL3Fb+6Iha
         go7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744223170; x=1744827970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1ALuPxklMKuCrsJA1BlLBcVNfra0g2589L/7At2Du0=;
        b=uN54J2nfsY7bh176BPrHMo9wdRp7bpRnml/p7FUWQNosbtKqHxp+5YhX5ticWJir0c
         k128E1lEQFPY0kOzxO76kFl+9X36AuP58gP3I2qGiJ3/lFMKEwg3DW4HaaMAzwKXD22Q
         0zupAZUe6rlF+1L5bqkA/ChNUFUj/hyIoRS2Sp3IMrSvEmdn2MHt1MT2krr13bIfSRAk
         /rGBMYM3UG8DL2mQZ7LBwMfksvyJvaIN1v/4U068esmOzpeyfPn3mCHM5I07gXyUmd1i
         qvQOMX8j8R9XA95rwyUsdiWWNN9LI9utERtnlO5LxxSehlJj8P+w4bJRuRQg92od9qgQ
         /SRg==
X-Forwarded-Encrypted: i=1; AJvYcCUJwd6U7riEK55syItBqCceHmIxoXrwFheefQ1UWzEP7woBUZQWXRlTMMJlvc2j1dSIb8c8rRX8G0FUOyU=@vger.kernel.org, AJvYcCUuWA++uUg4Sdl1sSrv2Apwcpr17yawFjUjeb2h7RBopIPS3I1ERJaYEAxB1Xf/k045S5UQ8CGqG9wwSKc=@vger.kernel.org, AJvYcCVX/AIMAUWQY3HleOPb9TCTR6xJ8RVyJ8ucHCMxPWDL+RfftsOgYdmzo6T2o4ToUjDxKtzhud4Ec/Fea6c=@vger.kernel.org, AJvYcCVqwXrjllG06KNOvKwK1fSfEeFyxX1+sXDUYK/egzkmshBvQwnmnE7iDpjpjiuEE7LNlh3ugbLSXSfDwpr5q2o=@vger.kernel.org, AJvYcCW5jDKjhtiGkshXExPIENhYUdfcgksK38JElhxN5Ww78Or8nL3iPEdeLW7KqKgM/+1RN+3I1KuJ@vger.kernel.org, AJvYcCWRHL8Iva8xkx9EkolgXHMHRf90w25PmhtWSvoweMgiGKCw8Vi5ArbN4+/ifzqEy/PIsmA=@vger.kernel.org, AJvYcCWTGEL+wnMLKToRm3mHW4rZ9eeW3Iw3JWmejAEa05xwfSdaDKTcGYbV2y0p+hObYegn8HpeCCqIcmVUcDrQ@vger.kernel.org, AJvYcCX+wGz2lqhhf6P8r8Rt+pMeIKSMJRql6AUOPQO8cAI8S+MUMqhN+F4Zl4h9J6NcIuKQJ/iG9LdpnbqBrpGw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+VfI307wtMB7E7gRSTGFhLmkEhGdoKR+rMP3Kqng4P07VvZDD
	99k4vUPW3tsWksZPJ2ozF3ueJLBNSLY2joQKTFNvEejNN+EWJEx+
X-Gm-Gg: ASbGncuxQWIfOGX41YnRObJlImVidIbZc6u8ZjyfrCW91vtwy7mbKkmiCNK7OXV/MQV
	zzXJRFT3jYqzupEKFm9WRwBosLPL6ZQsu9/JUm7K7MYZ1AKI+Rdph6XUMXu0RTexYZYUQiwi1WL
	I4qwx4hcCa4d04hvmMg1ktdRrJieqNySY8X9dC30J1X57ItujmeR96xaw8mQw5tcyV3hXinoEU4
	CkLTtyjqv8+mfXrU+tfKZEr2pJFvNR1SuJ+hMLKcI1NpYVOa/ptZvJomQt1ARtUxthsS8otDNZy
	AVBcwqSR7O2kHEtltJOdbakdSuG8Egq7wbui1+KYhoMCHYv9ju36FE8KbAMbK9fZRy8K
X-Google-Smtp-Source: AGHT+IHxr1Oj9fnHqk53IrCpefkxN1EZlxBB9xX9PT7N6JSO9pAzGlE3xPUsehJPiW2WyRgXiugOJQ==
X-Received: by 2002:a17:90b:2dca:b0:2ff:53a4:74f0 with SMTP id 98e67ed59e1d1-306dd56a24cmr4495494a91.29.1744223170249;
        Wed, 09 Apr 2025 11:26:10 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df08f71dsm1819399a91.23.2025.04.09.11.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:26:09 -0700 (PDT)
Date: Thu, 10 Apr 2025 02:25:59 +0800
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
Subject: Re: [PATCH v4 01/13] bitops: Change parity8() to parity_odd() with
 u64 input and bool return type
Message-ID: <Z/a7t1yATUXn11vD@visitorckw-System-Product-Name>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-2-visitorckw@gmail.com>
 <Z_anYpZw_E8ehN21@yury>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_anYpZw_E8ehN21@yury>

On Wed, Apr 09, 2025 at 12:59:14PM -0400, Yury Norov wrote:
> On Wed, Apr 09, 2025 at 11:43:44PM +0800, Kuan-Wei Chiu wrote:
> > Redesign the parity8() helper as parity_odd(), changing its input type
> > from u8 to u64 to support broader use cases and its return type from
> > int to bool to clearly reflect the function's binary output. The
> > function now returns true for odd parity and false for even parity,
> > making its behavior more intuitive based on the name.
> > 
> > Also mark the function with __attribute_const__ to enable better
> > compiler optimization, as the result depends solely on its input and
> > has no side effects.
> > 
> > While more efficient implementations may exist, further optimization is
> > postponed until a use case in performance-critical paths arises.
> > 
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  arch/x86/kernel/bootflag.c               |  4 ++--
> >  drivers/hwmon/spd5118.c                  |  2 +-
> >  drivers/i3c/master/dw-i3c-master.c       |  2 +-
> >  drivers/i3c/master/i3c-master-cdns.c     |  2 +-
> >  drivers/i3c/master/mipi-i3c-hci/dat_v1.c |  2 +-
> >  include/linux/bitops.h                   | 19 ++++++++++++-------
> >  6 files changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
> > index 73274d76ce16..86aae4b2bfd5 100644
> > --- a/arch/x86/kernel/bootflag.c
> > +++ b/arch/x86/kernel/bootflag.c
> > @@ -26,7 +26,7 @@ static void __init sbf_write(u8 v)
> >  	unsigned long flags;
> >  
> >  	if (sbf_port != -1) {
> > -		if (!parity8(v))
> > +		if (!parity_odd(v))
> >  			v ^= SBF_PARITY;
> >  
> >  		printk(KERN_INFO "Simple Boot Flag at 0x%x set to 0x%x\n",
> > @@ -57,7 +57,7 @@ static bool __init sbf_value_valid(u8 v)
> >  {
> >  	if (v & SBF_RESERVED)		/* Reserved bits */
> >  		return false;
> > -	if (!parity8(v))
> > +	if (!parity_odd(v))
> >  		return false;
> >  
> >  	return true;
> > diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
> > index 358152868d96..15761f2ca4e9 100644
> > --- a/drivers/hwmon/spd5118.c
> > +++ b/drivers/hwmon/spd5118.c
> > @@ -298,7 +298,7 @@ static umode_t spd5118_is_visible(const void *_data, enum hwmon_sensor_types typ
> >   */
> >  static bool spd5118_vendor_valid(u8 bank, u8 id)
> >  {
> > -	if (parity8(bank) == 0 || parity8(id) == 0)
> > +	if (!parity_odd(bank) || !parity_odd(id))
> >  		return false;
> >  
> >  	id &= 0x7f;
> > diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> > index 611c22b72c15..dc61d87fcd94 100644
> > --- a/drivers/i3c/master/dw-i3c-master.c
> > +++ b/drivers/i3c/master/dw-i3c-master.c
> > @@ -867,7 +867,7 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
> >  		master->devs[pos].addr = ret;
> >  		last_addr = ret;
> >  
> > -		ret |= parity8(ret) ? 0 : BIT(7);
> > +		ret |= parity_odd(ret) ? 0 : BIT(7);
> >  
> >  		writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(ret),
> >  		       master->regs +
> > diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
> > index fd3752cea654..df14f978a388 100644
> > --- a/drivers/i3c/master/i3c-master-cdns.c
> > +++ b/drivers/i3c/master/i3c-master-cdns.c
> > @@ -889,7 +889,7 @@ static u32 prepare_rr0_dev_address(u32 addr)
> >  	ret |= (addr & GENMASK(9, 7)) << 6;
> >  
> >  	/* RR0[0] = ~XOR(addr[6:0]) */
> > -	ret |= parity8(addr & 0x7f) ? 0 : BIT(0);
> > +	ret |= parity_odd(addr & 0x7f) ? 0 : BIT(0);
> >  
> >  	return ret;
> >  }
> > diff --git a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
> > index 85c4916972e4..d692a299607d 100644
> > --- a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
> > +++ b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
> > @@ -114,7 +114,7 @@ static void hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
> >  	dat_w0 = dat_w0_read(dat_idx);
> >  	dat_w0 &= ~(DAT_0_DYNAMIC_ADDRESS | DAT_0_DYNADDR_PARITY);
> >  	dat_w0 |= FIELD_PREP(DAT_0_DYNAMIC_ADDRESS, address) |
> > -		  (parity8(address) ? 0 : DAT_0_DYNADDR_PARITY);
> > +		  (parity_odd(address) ? 0 : DAT_0_DYNADDR_PARITY);
> >  	dat_w0_write(dat_idx, dat_w0);
> >  }
> >  
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index c1cb53cf2f0f..7c4c8afccef1 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -230,35 +230,40 @@ static inline int get_count_order_long(unsigned long l)
> >  }
> >  
> >  /**
> > - * parity8 - get the parity of an u8 value
> > - * @value: the value to be examined
> > + * parity_odd - get the parity of an u64 value
> > + * @val: the value to be examined
> >   *
> > - * Determine the parity of the u8 argument.
> > + * Determine the parity of the u64 argument.
> >   *
> >   * Returns:
> > - * 0 for even parity, 1 for odd parity
> > + * false for even parity, true for odd parity
> >   *
> >   * Note: This function informs you about the current parity. Example to bail
> >   * out when parity is odd:
> >   *
> > - *	if (parity8(val) == 1)
> > + *	if (parity_odd(val))
> >   *		return -EBADMSG;
> >   *
> >   * If you need to calculate a parity bit, you need to draw the conclusion from
> >   * this result yourself. Example to enforce odd parity, parity bit is bit 7:
> >   *
> > - *	if (parity8(val) == 0)
> > + *	if (!parity_odd(val))
> >   *		val ^= BIT(7);
> >   */
> > -static inline int parity8(u8 val)
> > +#ifndef parity_odd
> 
> Please don't add this guard. We've got no any arch implementations
> so far, and this is a dead code. Those adding arch code will also
> add the ifdefery.
>
Ack.
Will do in next version.

Regards,
Kuan-Wei

> > +static inline __attribute_const__ bool parity_odd(u64 val)
> >  {
> >  	/*
> >  	 * One explanation of this algorithm:
> >  	 * https://funloop.org/codex/problem/parity/README.html
> >  	 */
> > +	val ^= val >> 32;
> > +	val ^= val >> 16;
> > +	val ^= val >> 8;
> >  	val ^= val >> 4;
> >  	return (0x6996 >> (val & 0xf)) & 1;
> >  }
> > +#endif
> >  
> >  /**
> >   * __ffs64 - find first set bit in a 64 bit word
> > -- 
> > 2.34.1

