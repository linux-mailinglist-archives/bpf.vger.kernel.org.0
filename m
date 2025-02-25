Return-Path: <bpf+bounces-52590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C62A45073
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69ED01895D33
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C772309B1;
	Tue, 25 Feb 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUcU74Do"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8B22FF3A;
	Tue, 25 Feb 2025 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523589; cv=none; b=iwuvOuCru/NhDnyCbs8XISwXHUW3b8qIMGZ0pFrIfICQdekBccHeYHVNKFhgO1icncsHQ7pnRVbDvz5imu54AIk3nomWSJQXwcXiyMpskNZ6+xEvbu1TdF+yu6mU/L/z7iGReXLniOM1IZSPzIXC30bclW1GxtAwuTYna2+2ByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523589; c=relaxed/simple;
	bh=hDdsaKuLGPPO2QMEwawtpGkH8Byraw3yse7aBvdGdaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjnqrcmVOByK9mAtJZFKSxXPyL1DrhuqyzT709/JyaqfDID9bCSsI3BNxxwEaGRf6pYyGxDsjKhDEAzUvqnfPtJENrjteKOfgaNpjCsCHObKU6HDnn0Sr2TTd1vY02HQ1AUWBeQKn1B5sVQr5qMOq7Kew0eme1kJvsVudw00Twg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUcU74Do; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so1710225e9.0;
        Tue, 25 Feb 2025 14:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740523586; x=1741128386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xEzm5a7MvJg/wvZ+Z8+F/9tGDPPJZX+eI/HEgAntBA=;
        b=IUcU74DoHKoBFhqHqPpR5SQggee6J36UZ4NL0eZTB51wogpIgFfTaYaQmoMUX73S+W
         GIGnZyyQch8RlMP2+aWkw8z9gtDj+SkMnOAU3QdZdgcNmskGUpLHqZQ26PZGpTO/9suV
         DKLXPzdO88LBf6oe+cWPeGPgYX7fUUTzCrDssHWP+pOy8cf2VCpuBz0BB51inAxXuoTu
         BVmSxG6ZtxjhY9a3/1sJL8tC0I6Km09/eQ2O2gEcLjpxygtMO3z42WhWS7lwXDKK3Wwh
         T6Q2tf0XjG78mopihuebjDmZJ2R+tvWEGth/a/NAe5MeCAX7xqG1SjKX1q7/W0WX6Yaz
         3Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523586; x=1741128386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xEzm5a7MvJg/wvZ+Z8+F/9tGDPPJZX+eI/HEgAntBA=;
        b=kJzv/PnasdCF9hx4KALki2q+ZRShawgrDQIVC7HXzLi0rAsoHEcTSVqZARLZxgojvM
         XqgpzenpK0/Gvbl9oaoAbd4MHz/cK2iQmd2sqSUilRq+oDRf7qVbZKnbMs5uK0dhJfrq
         uHC9KARaijowWK1K6Ubf4Nr91xWzjLYEgyjCje2kxivSpU44VT5ugBJCV+f9iV9rg+Mk
         bdf6XejXnTz0i9WpYYtu24WczX3GBSUpO6WETBWlYa20jN+G2z944f4ifqWMS5qk/7pL
         lPnOsG0+BzxYlqMLA9pWBy642EZcoEJow6H2Uk0yX75X2hD9KjS7dupCDJBpotI2Uryb
         iM7g==
X-Forwarded-Encrypted: i=1; AJvYcCVJF4nxrj6rsUgdeQo7ypN9E7cNSDhU2Ch9y0kavM508oRHnv9zqlm7CqTSmo+CPMGIb8c1+z0AM7RX7LR3@vger.kernel.org, AJvYcCWAnQil3ZMe5OwYmJd5zeQnS5p4a5XD9rYvI1sXduLBMUr6a2JQfvlCiOmtmhnytgPDismBecfHsrBiOtc=@vger.kernel.org, AJvYcCWuHIeeNNNEE8s2BxZpyEFew4Dq/dmjmQn8X8pqM4GBRkSfNsbi4wfaCnI7jie4cIXNDlqEnH5c@vger.kernel.org, AJvYcCX2cm8RJpTTUWr96GYqVxsVk7e38Wr0doLb779AfeWS9KUXLQVSUrOw5cYPwDayE6hx8PBglKb4+xub+AI=@vger.kernel.org, AJvYcCX32993tip4Wk+R1NVWEymsz5fL1oWPepAUmaueHIpI8ikdl9LSJkOIQKE8q65ZqNVRGMS+pyZW5fwmjdef@vger.kernel.org, AJvYcCX6c9M6BvnWv0Np7/MaLPokGIgMuhd/xoL3BN2eII5KXYz+bnjd9WL7WOkK+eG8YGof1VI41wpOnUKrfica75k=@vger.kernel.org, AJvYcCXCO/dX/I0Ax0KErb1V2SZet1QHNdpwdD1CmfJ+0qb1ir0wWm5j2dfg2oIM6DjlzrzS3AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWFRIH4+hD/+cBPeTvpiTRDdwWjaqVGuY7zZzmkxAbqvYdh9i
	qzwuiWYC0MvVBXJlsXnNYQLkF/Z9aHTvqGed8Oc+Nz+EB6W+uOhe
X-Gm-Gg: ASbGncu9hgNjwDor857YjeUfzzuAXzA4TCMlkxvcITLv9plqxosY7pTMbQ3AaC2izzd
	bdZdCGnoJHsaAfozyIpOX1FHOvG3ndtF3lkbYmJoGYjB18stMolGltDd6xvBif/dfPSSC4L1xz0
	pDUfUIAvynf30q1INtXOSNpBsI+WxqhebmOpEu8tPRpbqSKptcOW4uRa+Ab2SGsXdHwhxC7N6pE
	KiGSBf6nmjf6MuTi0ekNOPV5v5feJ6skhv96iY7CvGTHw6Sq9u32sufYoA2txEyvBP0rorONVMI
	Z/RXx7cqXBaN7ngFDdUaDerBjWywTbrJreicCK9oCdDjygGTka+8vF6PJMigibVC
X-Google-Smtp-Source: AGHT+IFjrInluoqnbFjbjbGFkCsa4TCd0YMAhHctzgy+ODQ6ToD9u7urtlYhpUHFZQok7JnATsU7Wg==
X-Received: by 2002:a05:6000:144d:b0:38f:4f17:ee29 with SMTP id ffacd0b85a97d-38f6f3dca7amr14183257f8f.17.1740523586194;
        Tue, 25 Feb 2025 14:46:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd88295dsm3621054f8f.45.2025.02.25.14.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:46:25 -0800 (PST)
Date: Tue, 25 Feb 2025 22:46:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
 eajames@linux.ibm.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
 hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
 johannes@sipsolutions.net, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, yury.norov@gmail.com, akpm@linux-foundation.org,
 mingo@kernel.org, alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH 03/17] x86: Replace open-coded parity calculation with
 parity8()
Message-ID: <20250225224623.6edaaaa9@pumpkin>
In-Reply-To: <e0b1c299-7f19-4453-a1ce-676068601213@zytor.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
	<20250223164217.2139331-4-visitorckw@gmail.com>
	<d080a2d6-9ec7-1c86-4cf4-536400221f68@gmail.com>
	<e0b1c299-7f19-4453-a1ce-676068601213@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 13:55:28 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On 2/24/25 07:24, Uros Bizjak wrote:
> > 
> > 
> > On 23. 02. 25 17:42, Kuan-Wei Chiu wrote:  
> >> Refactor parity calculations to use the standard parity8() helper. This
> >> change eliminates redundant implementations and improves code
> >> efficiency.  
...
> Of course, on x86, parity8() and parity16() can be implemented very simply:
> 
> (Also, the parity functions really ought to return bool, and be flagged 
> __attribute_const__.)
> 
> static inline __attribute_const__ bool _arch_parity8(u8 val)
> {
> 	bool parity;
> 	asm("and %0,%0" : "=@ccnp" (parity) : "q" (val));
> 	return parity;
> }
> 
> static inline __attribute_const__ bool _arch_parity16(u16 val)
> {
> 	bool parity;
> 	asm("xor %h0,%b0" : "=@ccnp" (parity), "+Q" (val));
> 	return parity;
> }

The same (with fixes) can be done for parity64() on 32bit.

> 
> In the generic algorithm, you probably should implement parity16() in 
> terms of parity8(), parity32() in terms of parity16() and so on:
> 
> static inline __attribute_const__ bool parity16(u16 val)
> {
> #ifdef ARCH_HAS_PARITY16
> 	if (!__builtin_const_p(val))
> 		return _arch_parity16(val);
> #endif
> 	return parity8(val ^ (val >> 8));
> }
> 
> This picks up the architectural versions when available.

Not the best way to do that.
Make the name in the #ifdef the same as the function and define
a default one if the architecture doesn't define one.
So:

static inline parity16(u16 val)
{
	return __builtin_const_p(val) ? _parity_const(val) : _parity16(val);
}

#ifndef _parity16
static inline _parity16(u15 val)
{
	return _parity8(val ^ (val >> 8));
}
#endif

You only need one _parity_const().

> 
> Furthermore, if a popcnt instruction is known to exist, then the parity 
> is simply popcnt(x) & 1.

Beware that some popcnt instructions are slow.

	David

> 
> 	-hpa
> 
> 


