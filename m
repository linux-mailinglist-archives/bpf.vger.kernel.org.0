Return-Path: <bpf+bounces-55576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0ECA82F1C
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DB28A20A1
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BD0278179;
	Wed,  9 Apr 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbkaAKso"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEFF2777FF;
	Wed,  9 Apr 2025 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224068; cv=none; b=nKGP7fbrwqgDIVxV012Baa2nsXg+KTqxnFfqw02Nl3rqJJF1TogjONyatY2ig64I+uEMgML8gSPacZWy9WIYesaw/Pki6hoMpKcM8piaGW7WoZozi4ZvjPtT6eSi9EldUym8c9uvWEacdMFFus7ZTcqtSCiGBLpE0kF4RqIM6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224068; c=relaxed/simple;
	bh=Px0VYlUsPOBY2ltEO2TpWLS9AYWWswCUY8Dh5/BwVEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh+kn2Bd95E6avreCodvEr2vq/kqyFWnNPJ9NFJiWX+PZLjBC/lb7weFbNYSB/gI6N4FBc2y54dBvW/m2lbHyF8WeHBvy0VWmoL0XanrG0xOSx9j0xqXx72spz+0OrQfhlHqNqLZAuS3oSxgfLAxUvfxZIS+E4ZEoFYC+Uk5bGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbkaAKso; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736c1138ae5so7076260b3a.3;
        Wed, 09 Apr 2025 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744224066; x=1744828866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9MRs+OpXV0ogJQHvE9axw548ilRfDN2nGQrTik2VzY=;
        b=XbkaAKsovVrbyKzS7S6JtGY1PNiMUsSliBzg1Aw6cdStmss5NQNi6uAsiX1+8W0S4S
         WSgWGG72ATf5ZND1UOxmf/qQQDBIFgvuvf0uriaeEaEUzK5MlH48/w0JnjTbEtiJ9mhg
         mhG1r/lhVzHyExKJs2kG4vLmxuQkrocGC6QnOGfXuNH0PU9vCXs0edKHVpS8E9lLG5wT
         vnta1SLAtrzq49AXa0TWG+Eu2Mz+G56oTlypmy0/jTyZ9G0d+66dRNwgc6SIcMyzZGfx
         y+PwWxGQgAzEF2ZgXHovAZfgU/VZxnFTVKqnqm9+e4SVr9yEHCMAYzgXXhRpJbHdaI1K
         gwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224066; x=1744828866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9MRs+OpXV0ogJQHvE9axw548ilRfDN2nGQrTik2VzY=;
        b=EOjw0jKCMGNXTE7Z8+GDz8flXoFZXuOtZ2xR9l3mdikiVtpVFf307UBf+K0X7rPcYY
         gCk48XkunhmwOMbULnE6w8FAdtYGkq7D0xVLU0oqlceiYhUZUuhNWoC3aeuA53s6Cxlu
         43edg+0n3u7gu0OTCIc1s2L2iPC4Mgmti8gDlAPGtIYuiLgNVszbBQabMjUn4IY4qHyk
         6U0fj5y6q2yonIlDyVIT4n6cJU/yGuvNc5rxgt54lkox65usSk41uDFnoECCq0ePmZ7y
         rFMId8EDUOIyc7Cm/QmGrN2uEBMPWJB+aHs3MfWw0yQfKO65fUX+LZ2y94wEboH1utR3
         23zA==
X-Forwarded-Encrypted: i=1; AJvYcCU+/B3soVclKuI+D92SD4wtKV060NvUDLFzrW2MgxDvCQNP9P1aaaYgFj2kvt2ZqxqtCwcA3W3R@vger.kernel.org, AJvYcCUBBe1oNVOVxDW6zMvOeI1nwHuywNuAfKhuqzfAPHY/g45ZOYnNxJS2VCTzu1AIX9WAlTuucXoP8qioTlA=@vger.kernel.org, AJvYcCVEG38W5apF6YYQokThXKzUO6yAo8+/Od3AixCEuk036P2a5riGhCysBs7hfdML16cRhJR3rfTW2mQJQXU=@vger.kernel.org, AJvYcCVuWTmMwiWMVaB5pJJ7UqpR6L0q/kMVv7SonlkD9x6r+tYjLidEN2skR4aobWYNxBNBGYixqr+5GHo1OChv@vger.kernel.org, AJvYcCVx9SQHnNvMvoBys4UkYfVQ6KqRJmpBqXjHybpYn4TRnZAdIWBIO/SGEWy5w3dM8VXtKx6PIUuDSgyzeE8=@vger.kernel.org, AJvYcCW8tGdiBp14i6fmpDjVLBgMoPU8ZfjSPw6OCbZBzMSBW4zerO+4NXu2T50deqYO6GKgLsU5Yz4tCq3dUsG1PYg=@vger.kernel.org, AJvYcCWPkv7RKb1v7zvHufZrx8bauULo+g4OGhaB4GNkKEVw5deJBhHcBaWzAat8BeZlUsG9x11oAQWfXv3zDD4h@vger.kernel.org, AJvYcCWhUaVzgkTAdHatdHLI/IZMgODiArLWUylPExeIgd/x0H0e/dTHV+fmZF6T8IVrqJZs8Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBJIKk6iilSRCfYCWHciDWFu1BJvlObE9KYwDitrKaVXzbX6c
	5lfAa8+sMGe9BcFrIW2eDspMF/nhBFIZh9+Fk/MtNYgCpB4eGKoT
X-Gm-Gg: ASbGnct/mp9MXUOOjOu0uDxX8vebb5ayZ4xPDJL5jKrOkcEY4v5RBg97iwx6REycGg9
	guDVZq1RN0g44UyjsNzFbb/I3oEXGGfu7P8TOYQt280gsrJb0LlZCZdQym1+PCedWxYP5NYoTc/
	X1VfZgeYSFHoRwbhfVsSm4Y8RlSfQSvb0uHoSsJfNjRR1v0uBrmt+joDmfCQbE2DNBkM1d4KNfT
	4vqOLbHbddWwfGFq/UdL3BTNbG/VQsHbBhubF6PzMmu6UAf0Zqd+Qj6wiybePAzsNxXmEighe61
	cbW+g6+fxU+zB6EXlEGq7lbMsaBClNOuLaq3sfYRMRxg3xSJcEE=
X-Google-Smtp-Source: AGHT+IFBplIB7lbzzonBtacivuTbdfAuDOBFrLzj0CEeoRBndpxGhIacjgtf4O10nP956h0EjBOoEg==
X-Received: by 2002:a05:6a00:22c2:b0:736:5545:5b84 with SMTP id d2e1a72fcca58-73bafbbae8dmr4546648b3a.3.1744224066191;
        Wed, 09 Apr 2025 11:41:06 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e4f768sm1739807b3a.142.2025.04.09.11.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:41:05 -0700 (PDT)
Date: Wed, 9 Apr 2025 14:41:03 -0400
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
Message-ID: <Z_a_PzmNnvC2z7se@yury>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-3-visitorckw@gmail.com>
 <Z_aobrK3t7zdwZRK@yury>
 <Z/a7DecDljuLtKeS@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/a7DecDljuLtKeS@visitorckw-System-Product-Name>

On Thu, Apr 10, 2025 at 02:23:09AM +0800, Kuan-Wei Chiu wrote:
> On Wed, Apr 09, 2025 at 01:03:42PM -0400, Yury Norov wrote:
> > On Wed, Apr 09, 2025 at 11:43:45PM +0800, Kuan-Wei Chiu wrote:
> > > Refactor parity calculations to use the standard parity_odd() helper.
> > > This change eliminates redundant implementations.
> > > 
> > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > >  drivers/media/test-drivers/vivid/vivid-vbi-gen.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> > > index 70a4024d461e..5e1b7b1742e4 100644
> > > --- a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> > > +++ b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright 2014 Cisco Systems, Inc. and/or its affiliates. All rights reserved.
> > >   */
> > >  
> > > +#include <linux/bitops.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/ktime.h>
> > > @@ -165,12 +166,7 @@ static const u8 vivid_cc_sequence2[30] = {
> > >  
> > >  static u8 calc_parity(u8 val)
> > >  {
> > > -	unsigned i;
> > > -	unsigned tot = 0;
> > > -
> > > -	for (i = 0; i < 7; i++)
> > > -		tot += (val & (1 << i)) ? 1 : 0;
> > > -	return val | ((tot & 1) ? 0 : 0x80);
> > > +	return val | (parity_odd(val) ? 0 : 0x80);
> > 
> > So, if val == 0 than parity_odd(val) is also 0, and this can be
> > simplified just to:
> >         return parity(val) ? 0 : 0x80;
> > Or I miss something?
> >
> If val == 0x01, the return value of calc_parity() will remain 0x01.
> If changed to return parity_odd(val) ? 0 : 0x80;, the return value will
> be changed to 0x00.

Sorry, I meant
        return val ? 0 : 0x80;

This 'val | (parity_odd(val)' is only false when val == 0, right?
When val != 0, compiler will return true immediately, not even calling
parity().

I think we need a comment from authors.

