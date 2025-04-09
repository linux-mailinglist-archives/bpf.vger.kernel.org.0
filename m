Return-Path: <bpf+bounces-55578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A2BA82FD4
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E201788A2
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378C27935E;
	Wed,  9 Apr 2025 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwxzjQ/6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88DA267B00;
	Wed,  9 Apr 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225014; cv=none; b=YnovAO7A1x9aRLldSpkOby7tA5kMiOlTpRwuKKUlzXunQKqPFAjJc34szFq4BFOBDLtXG0G5Jjiqlso5rJjaii6GG9RmcCKylcT8DoEl3AW6yE5SDEahRNbCsyB7oK+2zaCnc5DJskxLGPARjd0MUTHYpNwkWKO3OfJZ90tkGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225014; c=relaxed/simple;
	bh=xV0/chfmEtO9SuTIudGBT6j2Ld+A4bRf6t+AlvQT5mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4/gfOs88pVMbVrW+Auwzj8dDB+jL48Y1mh52l2lW45bgTBijhz1wI69//jkoPzg9lgawwF2b6ySdJ3wQEMcywfzbHrSs6+zpNtcGwKnqs0piaOn53ZN4jti+MqySzLB36EwcdTTlJBJcMxLtLPwZ+CA4dzpT6u6ri6qnG1QQEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwxzjQ/6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3031354f134so5558411a91.3;
        Wed, 09 Apr 2025 11:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744225012; x=1744829812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H44gXeIcAME6+J3Fln1VrlgyA4FgneecNdZbE5MtilQ=;
        b=LwxzjQ/6WXAtPsULkg23HWQUXNrw7CAkhAXu/ZlIjxIwL0c0y0nl1G6Ahdd+Y9e3Fb
         xfjYWT+SWvhVVHaNzETnosc+fVS133R2IrQY/N/IzWH1QuJfESCwv2mbVQT1IrF3Hcmp
         rX53zNxivG4UnBujicqQ1PmHYRxAjlA2SXgIRHCty9Y8zTZqKMuxo5bEDZkfg7Gm5z0Z
         2vl1KEhNR5pstBQ7M8+Oh08UQOLKCrqV6qcQziSuCTXpa0zk5d4r84lueBR/UYU6CZks
         nf28dLVH4IXZO8/t4f5ygo5O9RsHkidbP+BT8Zq7dynwh6T7RPfVLSZcw8lmnagAHo98
         gMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744225012; x=1744829812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H44gXeIcAME6+J3Fln1VrlgyA4FgneecNdZbE5MtilQ=;
        b=HcOzHNiOofyj+GS3/atppzbQk/lBwMyhOq3ABsTL+tjRGTKJe80uw/dNv8Ebp/Gb8d
         OOkBNl1AGXQOXzjoyXvII4x1C34lKUsEqIqDMjQbJK0huX87TNil0GEMQQ/S4gk/CiuT
         7KQGPESmOTzSpZZ0+3cVwu00SqW1m0XidprQBbF5ek/psY9kOCqwbgjVTnBZiypMU8jr
         HssWL7QCukhhYkmgjtoa9pstEp5gTU4XxI36qMG8+vWLc40sJNcz0pxprTaE8ceT9Btf
         BikKoooIhaDqQid6/MasWt5Zm2Jo/Yf60hhn4gqjW00lUwtRI//WY0IFtcZom7otm70Y
         Thqg==
X-Forwarded-Encrypted: i=1; AJvYcCUMW0EVwt0TUnTg0VEYXnzqrCJkb2APO/LcKzZzQM+5IZBPtFQ79sI8vx8yjF3R+Rxztt4qrj1SG5aLVPE=@vger.kernel.org, AJvYcCUcI5Qt8Pat1IZq6WfEY+P4EZMIjYkjM8l5qzPfFu9b/9voZC+re/uUjfSvCYsnnOPtdqGh+k9XrMG9wsxp+H0=@vger.kernel.org, AJvYcCV5JD7Ld03w1RxfVJ0BNWAqRgGaRF4jdOmHGE2kDMRmND/UqUpKM5WmLLVRWab/Wcu9ViA=@vger.kernel.org, AJvYcCVN2MnGoIlULKUVzshd8x3p9FBaTARmyTB1CxJrk6jZ8XD58lf2Q2ADHsTD//tWlUSeIRlpc49udimMyUM=@vger.kernel.org, AJvYcCWnK3WJZHSTbbFFdDURvdPO3dbhgYViEffYK654fGhwPYiK9xPNiKUg5PRssWz3mG9yaloc16wnpBx8q0M=@vger.kernel.org, AJvYcCX4+ZAb0m+7tYBKHe+wz4ADHFtkB8XpLI66dRdoIparVJg2Qbbgn7440xB7ZlYwJIEukE4u70DeqNv9STJT@vger.kernel.org, AJvYcCX9kWszKeEcgqcuznC3CkM1Gv89WlB3JoeTjQ/6W52WziMS7kdLleASigaV5a9AZkxMfnE7QCHk@vger.kernel.org, AJvYcCXQc0oksFHOCLnUIKCK3JjRunX9h/t5Ck9vS0HASsJv61o4BVsbwgmcsgH7BySZkEGw8LM++5O2GNtta+Hz@vger.kernel.org
X-Gm-Message-State: AOJu0YwytzmIvT82fhahCrZikLNOpxwPeYfx/gI/EtIoTEE5j9hqxyyS
	v1gGI1n0kf3bqBn2jRziTcmkpagbOLJSYjXfkU8/7yoPTZmoHlIL
X-Gm-Gg: ASbGncuyv3QgnnFRvLzut+XxUlHXNujC2LWA572Kz/s4wgCawwXZeW8xwMbthuWZnZu
	9W2YyKPhyoCCQ6L+oQNPI+7HAx3Wz6ax+EZy6Gk/XACY5Xrbk6vEoKuisq+wBIjjScZUt26xlPB
	/vDecFcPvWWRsrETWYnpe2/qxHZxSCcoo926W4eOdRkI5zc7IRiyMqu/+86ncATdKvVZi7Zg0ob
	zywBUeGMc1LeDl+/bQFok6FSy+FQj8+oYPhIBpudU2fsaXx9UHu+GOoabU4EQTWWQaGrOfES8Ee
	FU1XRWGv5jCTKZrt1zHmL6Pob/ePfa1I8ro07swd2/LUCVwUClJRQhZhP/BvTi2cVCT3EeVWPnd
	Gl1k=
X-Google-Smtp-Source: AGHT+IEU+9HbHaJYQfODCw2wi9ncyjloO96dCdgihc1EFdOo4Cq2cGK7FSRZJO7xATXKowJYXeayuQ==
X-Received: by 2002:a17:90b:53c8:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-30718b83034mr84933a91.20.1744225011817;
        Wed, 09 Apr 2025 11:56:51 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd12b4d5sm2218595a91.25.2025.04.09.11.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:56:51 -0700 (PDT)
Date: Thu, 10 Apr 2025 02:56:41 +0800
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
Subject: Re: [PATCH v4 02/13] media: media/test_drivers: Replace open-coded
 parity calculation with parity_odd()
Message-ID: <Z/bC6cygo0hem5IO@visitorckw-System-Product-Name>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-3-visitorckw@gmail.com>
 <Z_aobrK3t7zdwZRK@yury>
 <Z/a7DecDljuLtKeS@visitorckw-System-Product-Name>
 <Z_a_PzmNnvC2z7se@yury>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_a_PzmNnvC2z7se@yury>

On Wed, Apr 09, 2025 at 02:41:03PM -0400, Yury Norov wrote:
> On Thu, Apr 10, 2025 at 02:23:09AM +0800, Kuan-Wei Chiu wrote:
> > On Wed, Apr 09, 2025 at 01:03:42PM -0400, Yury Norov wrote:
> > > On Wed, Apr 09, 2025 at 11:43:45PM +0800, Kuan-Wei Chiu wrote:
> > > > Refactor parity calculations to use the standard parity_odd() helper.
> > > > This change eliminates redundant implementations.
> > > > 
> > > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > ---
> > > >  drivers/media/test-drivers/vivid/vivid-vbi-gen.c | 8 ++------
> > > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> > > > index 70a4024d461e..5e1b7b1742e4 100644
> > > > --- a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> > > > +++ b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> > > > @@ -5,6 +5,7 @@
> > > >   * Copyright 2014 Cisco Systems, Inc. and/or its affiliates. All rights reserved.
> > > >   */
> > > >  
> > > > +#include <linux/bitops.h>
> > > >  #include <linux/errno.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/ktime.h>
> > > > @@ -165,12 +166,7 @@ static const u8 vivid_cc_sequence2[30] = {
> > > >  
> > > >  static u8 calc_parity(u8 val)
> > > >  {
> > > > -	unsigned i;
> > > > -	unsigned tot = 0;
> > > > -
> > > > -	for (i = 0; i < 7; i++)
> > > > -		tot += (val & (1 << i)) ? 1 : 0;
> > > > -	return val | ((tot & 1) ? 0 : 0x80);
> > > > +	return val | (parity_odd(val) ? 0 : 0x80);
> > > 
> > > So, if val == 0 than parity_odd(val) is also 0, and this can be
> > > simplified just to:
> > >         return parity(val) ? 0 : 0x80;
> > > Or I miss something?
> > >
> > If val == 0x01, the return value of calc_parity() will remain 0x01.
> > If changed to return parity_odd(val) ? 0 : 0x80;, the return value will
> > be changed to 0x00.
> 
> Sorry, I meant
>         return val ? 0 : 0x80;
> 
> This 'val | (parity_odd(val)' is only false when val == 0, right?
> When val != 0, compiler will return true immediately, not even calling
> parity().
>
I'm still confused.

Maybe you're interpreting the code as:

	(val | parity(val)) ? 0 : 0x80

But what we're trying to do is:

	val | (parity(val) ? 0 : 0x80)

So, for example, if val == 0x06, the return value will be 0x86.
Only returning 0 or 0x80 seems wrong to me.
Or did I misunderstand something?

Regards,
Kuan-Wei

> I think we need a comment from authors.

