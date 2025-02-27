Return-Path: <bpf+bounces-52779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68B5A486D0
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C656618892C2
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0A71E8330;
	Thu, 27 Feb 2025 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2CPtnoX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5C1DDC29;
	Thu, 27 Feb 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677828; cv=none; b=AR7wnk5c7f5o3Bjl2LIZjcz9dZUsLwuhSv1GPJbV6vNm5abTB0epkSduUZhg7ofTw936rF1Z7lLqxUxBlfhYbbcDK4yN9BbdpIvHBRjOg7Vzw16pdplOytspWD0GZYDsbmnfZIfoK8pQzK+dazbtRvVZczNRiM+Knlfq9xsUEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677828; c=relaxed/simple;
	bh=3VhhTqGt87a5LXVZ8xAbJKCD+r0MSBo9AvP4EXdhZvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezwsb0trh6xyZeC+AoW6+B+ljnMChTreoH31oFLGPbRllrsMUlUjfhGqF33Ol1UH0l2W94vCQxc6AW+5+flmKmwHXo2VWkYwpm8GeT0u4ZqoF2IVVKy4ZqlYyE+00iA9tSHrrIPMbw0iejaa7+kzwWEDMDSwR68BAlLu+ShxVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2CPtnoX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223378e2b0dso20452605ad.0;
        Thu, 27 Feb 2025 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740677826; x=1741282626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUAFuA6WyxlqIwMao9P+DyP+C2TxjteBYJ1MyyDLQfw=;
        b=k2CPtnoXP+Nu/D9591DpLIaKIB63ulgvz8LnuAS0Gvpy9tT7B2X8uSVT7amvEwHYN5
         xVS9I4r+3RVO5D94QO85PqOFY6Zp3qgx98bOkOWLt4Wiu4tiG3UvwEUzcWqicEPZg3wW
         DrpkJcct3mPAd/teLAglXvpBIOZv2OhEqbg7BVLvTD4piL1wskgOYWI2OFLey43KQVwz
         JujPkxDVtkSPoC9Y01eeNxNLX06GizP3MKRHs/aT0whflsBfOXPBPxHEMdx10HKEdUdm
         nHuxJQeCsYqKcBCUaLS1TSAkaUoK/66c657XNZ7MzdvTOdCV8F7+j+hc7+9LtJ8CFncw
         YQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740677826; x=1741282626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUAFuA6WyxlqIwMao9P+DyP+C2TxjteBYJ1MyyDLQfw=;
        b=CBW51xVRP/LaIIU1A6CZ4OkqZgrUu7nfhjFZxIgfGDo1MHeLTMhoBk9ls9aSHnsDEJ
         Hq+I/rEhi3ZvI+LTdwCfGZPul2qRFflSFwVypc9sxMGK/73EaXD81gNmJRO0ZxnRshjC
         7byUXeIDC5XhpRRdk/keR4/Vqaj2Sj0ftemu+0NRgC7BFGizWLQ1wt1UjWNHW1fnLBHZ
         hBc+KIaV2cj5yQ7MPhgs3lgClVUJC0CF+Nfh7gwYi28ihhiy7Ar+Vi5sw+vXQ/R8/cB4
         vZNw/Bb2hoblNmV89dDBLZrPAHpgzRpiI9+tsCit7EyEDhQ7BOiCMi9O+FIj2ZOp5UCx
         nSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9j0q98O9kyB9dWy5+b/tCfcMULttjt2DdRUxvfMxTLipKIVPbXk36nnKn8ofIZXzKtnv5o5EW8XCJzfM2@vger.kernel.org, AJvYcCUU6DzcBdtZZlq0E1+Y65cMvM5A/vA56hExKka8pqUJSXol/OIszuzTLD7LRf8m3msgoow=@vger.kernel.org, AJvYcCUWoy5TgbRAMHlO22hv3NOK7IdgC4Dqz/uXeEKAGFFb9bQuPI97kIfvolb6QfhpcjBc5CtbcUB/iRGVdqj1Gf0=@vger.kernel.org, AJvYcCVYyDkiB2aBGstAzk7mXzYSeUUTbes3GGJGZGd7CCnrhDl1n3r5rSSQJf5eVYm6EFMZ+GdoGX19igFjUuk=@vger.kernel.org, AJvYcCVlFQZSDXAlsbdAdSwO1zAj04bh4oPZ6xPbwX22YjTub52352CSEKLD7CiQJjZrQp2E8tAUgrr4@vger.kernel.org, AJvYcCWOtFmG0JEQTKrqkgsWR/0Jav2B60EvClk8mWib2+01meIMohoVedGCHepPH//u4qoj5PIzSpZ0IxR9GjhB@vger.kernel.org, AJvYcCX1xVA7bQ90BxTYRQOzgeZ8GmLaqz5Ju20K54lixDEkIlByWx1apZHF9TG2jT8v5/Uayny7RHf4pqeUhPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKRHiQFsKxRA/aOoRfrGExObZRfbhIy6eAK1GbCUQvo3xvzOUH
	3M6UBSB0EaoN1bNAwSbbAuGw2bfeZfCy/gR4LMK0dymuk5b6Uu7C
X-Gm-Gg: ASbGncs53cL6ikyZG4g3aeg9EySDog3pal+DI2I48LU8w6YCk+ekeaiHRf1K53mh2y3
	+BhxobvZ76YBn+DXHMq12bFe97eX0jQCyuuMCYylHw/Yl/UWSsJL7WF44n/xXJwCHvhQO3q69oK
	PQEoouzvrFevT7/yAsIhAfYkD4XLbcRjcDMf9yazm7xeSU+LjSo/YWFwTqWWODEmrdwY+0WHVjl
	kowOZGonIYgf+9GfkpJfBDRu880K4DuM4v/Di256mKI0+MTK6v6SiD+1ohubIjOVNmk3ePSNKRL
	mggknlz/2No67vWDjkJj+nM45VuFkp/IJl9vmpaBeLYcQM2g9w==
X-Google-Smtp-Source: AGHT+IGK2yvXxMwGzFuS4qAPXT9dc4oLUeTze+y8wAtciDVfBiItiQouqHwlR4imml9fxjD4qYJfDg==
X-Received: by 2002:a05:6a20:9146:b0:1ee:d6da:b651 with SMTP id adf61e73a8af0-1f0fc993ffdmr22305716637.35.1740677825727;
        Thu, 27 Feb 2025 09:37:05 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19d3fsm1745501a12.18.2025.02.27.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:37:05 -0800 (PST)
Date: Thu, 27 Feb 2025 12:37:02 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
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
	akpm@linux-foundation.org, hpa@zytor.com, alistair@popple.id.au,
	linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
Message-ID: <Z8Civv0QaBzmFPTq@thinkpad>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-3-visitorckw@gmail.com>
 <Z7zIBwH4aUA7G9MY@thinkpad>
 <Z73FxIv353lbXO3A@visitorckw-System-Product-Name>
 <b5236ae4-7ebe-4a88-bbc9-3b9b3374de53@kernel.org>
 <Z79ebv630yuNOJKV@thinkpad>
 <a8c29dec-6178-4f8f-80f5-aece636c410b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c29dec-6178-4f8f-80f5-aece636c410b@kernel.org>

On Thu, Feb 27, 2025 at 07:38:58AM +0100, Jiri Slaby wrote:
> On 26. 02. 25, 19:33, Yury Norov wrote:
> > > Not in cases where macros are inevitable. I mean, do we need parityXX() for
> > > XX in (8, 16, 32, 64) at all? Isn't the parity() above enough for everybody?
> > 
> > The existing codebase has something like:
> > 
> >          int ret;
> > 
> >          ret = i3c_master_get_free_addr(m, last_addr + 1);
> >          ret |= parity8(ret) ? 0 : BIT(7)
> > 
> > So if we'll switch it to a macro like one above, it will become a
> > 32-bit parity. It wouldn't be an error because i3c_master_get_free_addr()
> > returns an u8 or -ENOMEM, and the error code is checked explicitly.
> > 
> > But if we decide to go with parity() only, some users will have to
> > call it like parity((u8)val) explicitly. Which is not bad actually.
> 
> That cast looks ugly -- we apparently need parityXX(). (In this particular
> case we could do parity8(last_addr), but I assume there are more cases like
> this.) Thanks for looking up the case for this.

This parity8() is used in just 2 drivers - i3c and hwmon/spd5118. The hwmon
driver looks good. I3C, yeah, makes this implied typecast, which is nasty
regardless.

This is the new code, and I think if we all agree that generic parity()
would be a better API, it's a good time to convert existing users now.

Thanks,
Yury

