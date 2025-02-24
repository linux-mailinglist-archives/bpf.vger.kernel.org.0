Return-Path: <bpf+bounces-52379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E43A42698
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D869188FC50
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7C3254861;
	Mon, 24 Feb 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTSbhAxR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E615E90;
	Mon, 24 Feb 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411362; cv=none; b=IFuS2J5ulD8S7afYs2pJjS7QCr5kd8cv154XnhkX+mBCa+tKpRRD8RK/1h3iTRvkZEvW00iHn26jBTI1dDmLt66bcJ0MNyp4R4v1djS8sgdGAhEPatA6ZV39NPg8iUDW7isc1rSO6khI+Tu2LKvIf9KxcwwXNHpJCONzl4gDeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411362; c=relaxed/simple;
	bh=f8eRj/AuYAHUZhC8jvYuxxDYnuW5TL83F7ZoXDKXJ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfRo7rTec28h2SeL1u5kTkk34df6P9yKPNm44BEULT4PieIaI1K4+Wu7NGi25Y+YGMzBiXC1dELQ3LqrtpssTsNa+agw4rPwtmw+kRfG1FUZEZODX6K2GYtt6bGO7cQR16P2z6Sgoatiphk2VK+4kWtQr6wrhxz3b8IqLb596q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTSbhAxR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220ec47991aso61789775ad.1;
        Mon, 24 Feb 2025 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740411360; x=1741016160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvUBzAQsQhizjRbALhklVYcHMIlUUFNb0lUUZGXIVX0=;
        b=CTSbhAxR00BOGQqfN4/XJySA6tKQwjjV+i2Gn+giHm7lfAJO1JHiWGTBhh/H46SkSW
         nPQBS1yyzUxdlDjUW1NIzhrApizN8AARhqbWflNizp1QdvR1IOshLZ0kaa/pI+tMGoKM
         Q3kD4s7CYZldwTAIRWc1VS7vz33Xw+hVQrZDlWpRR51NiZ1z4r7cqs6IjXyHnTfycmTS
         3NGrwHHktUVi4NrSE3JsKR8k2aDF5AtGtFfD4VZzJaSNGtWTl7QbOQxhudFflPo3aDLw
         3Q+vT1/ipJ9+bNhErVoMWAyHCOd/NuXwPdkXqh2KZKALjZsDJqDh6JfpdKfgVw0a+CGk
         ZyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740411360; x=1741016160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvUBzAQsQhizjRbALhklVYcHMIlUUFNb0lUUZGXIVX0=;
        b=aZWSiaqTwcfqwNsddP0SPOBecRzFJy+26sMjKyhQ4lTB8fZ0KcKcgbKHZ6gDUpNzKK
         OQ3VfzzcWEVitn8ER+ZpVH+v5CIQetBhhz04ieoAqtS0T6PfvLyA9CrOERYUkBEOYJyl
         Q+MhCRDSRXVGvJA4RT4Tp32FNCV4tkI4ClE0Ag7faqjWvDFyq7O4ZdsmvTa2sIowveut
         2Wae7/Do3eu2T+GqaMKqelZthDH9S53lUKa2gN7jKQFA76cvUiu4/Zuk77gtkN3Rl+Pk
         72Y6Fl/Bkhw9DIt41hFulZSiw5sWC9Vzl2gJMrXGT1PrBq8mus+P9bAN1AcQ7lQT6eqb
         tDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU88iHQ1AROnpOQh0y1vD6H3KlufijjX48TIh/gbVQKv2fJCoC2MEgXQxvcb5Rt1cy1pA0TwJtu@vger.kernel.org, AJvYcCUgpAQanoVvBxBweNkIZB3kvlwgR2EYfZA94Ch3msGpdhQ/Y4AoOmzFpjGYQu6wUXFTqJ+RA+X394s4md8=@vger.kernel.org, AJvYcCVJlouplWNbSR2DNuxCSYD2Js0mAxDg6UEYVTV1P/am+oVBXWMKYkVO/kS0pib8b1UADXU+5kbsXsEH21jtTpU=@vger.kernel.org, AJvYcCVPle4znU+I/ALLrhH7xQcGJGbFy/4E9YMN4no/doE4SyI/2xMaMEbArmnvpN+AUV20ZkIVj0zZdmO6xZA=@vger.kernel.org, AJvYcCW79pyE9jv6BnMMTbt7sSIMwd7sPKK73lAR0VEaNm83eBISdUaM8uyzhkncB/6uO4SGdEdYhPJp8s9uSgQI@vger.kernel.org, AJvYcCWqQQPj4G+DVuDQDZoreWROvhcMAz+wcR9E5i68obka7i99SJZDgW6kApVodIJ2Tr3A59RrLmFVpE+ruSqY@vger.kernel.org, AJvYcCXuaRXJZX3GvfljtLKoXFTR+mhARZTc3TC8MHV7qyzaUW6PcEihYiuWrnshGJaf888By3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKFwHo3cOdTBICifcMgserbxve+fqFkBp6WtAACxUuXDOZSgq
	tlR1W+wDTIAqGB2rmzrmoZWcCBuqlU4xZ6nbIlScQ7tFB0EkOsHn
X-Gm-Gg: ASbGncvQ03OVf/mkX9PQOy9eyW8VDO9p0pjRtt08Ccv+F+cc2AIJUvwaI4HWHZ+0VDJ
	h877HJAG/sclgHzHhLovgxbJrfQBQF28SYklcHBT4ullzmi5XJ+Z91DDve6tdfTMdYs1rGLRrfe
	+mL7/+oJ4XyRLkmmogsYJMN7s3oqGXxm80RVRGR8Ub+2RyNdXrDix/SbPBkBfZN31KobhnTauTX
	htMU0C5O/2VEBPrfNu2QUCQX7OqLTOmH74eYJKMeXJ/Gw57ZbZ0mXCHETKacCUfoaGCc8kdIQIp
	TTjioiqKIdRc3YYSsGYP/LfDfoya
X-Google-Smtp-Source: AGHT+IHd2msCEkxFy+eTP0g8bXm0gN1PJPrXpracR00S9KkpiQvppU+iNHJWil/lk2n6JQBTakl5Tg==
X-Received: by 2002:a17:902:f706:b0:220:faa2:c917 with SMTP id d9443c01a7336-2219ffa74demr245408665ad.34.1740411359935;
        Mon, 24 Feb 2025 07:35:59 -0800 (PST)
Received: from eleanor-wkdl ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f29sm181794265ad.37.2025.02.24.07.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:35:59 -0800 (PST)
Date: Mon, 24 Feb 2025 23:35:48 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, joel@jms.id.au, eajames@linux.ibm.com,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, hpa@zytor.com, alistair@popple.id.au,
	linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 00/17] Introduce and use generic parity32/64 helper
Message-ID: <Z7yR1C4nC1UTrX5e@eleanor-wkdl>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <1cebfebb9c205a1ebc5722ca7e3b87339ceb3c79.camel@ozlabs.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cebfebb9c205a1ebc5722ca7e3b87339ceb3c79.camel@ozlabs.org>

On Mon, Feb 24, 2025 at 03:58:49PM +0800, Jeremy Kerr wrote:
> More so than __builtin_parity() ?
> 
> I'm all for reducing the duplication, but the compiler may well have a
> better parity approach than the xor-folding implementation here. Looks
> like we can get this to two instructions on powerpc64, for example.

Hi Jeremy,

Thank for your input. We will do that in V2.

Best regards,
Yu-Chun Lin

