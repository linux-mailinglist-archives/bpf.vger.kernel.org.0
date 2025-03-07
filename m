Return-Path: <bpf+bounces-53597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDA6A57092
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 19:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AA87A8EBF
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E0241CA2;
	Fri,  7 Mar 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRoRJ+i6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08231194C9E;
	Fri,  7 Mar 2025 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372220; cv=none; b=PTMXaOx6sM+Mzdv3d1t3+TUoFEJsY2utKbEBoSAPAiT/GFJkYH6b0qeUbdyazbetr8A721z3WuRULHoiEN29w+xS7gp1C0GSaGSaXsJ0cFz4LGVburw0K1v4myuJP1ehBTucZjzzn15TMa95ICPDUsig1PsoKovuF7saGSTtZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372220; c=relaxed/simple;
	bh=EG2i3mXMsc7HiAgkyOkrmMVNlKKHXZ/6dKrOfBJXUBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeahBgH7BVxU3KigZT2S1O7bZRwH86Yas7TnhxOmL81dE8NpksIGoYFyilgjSxrE73pPUJfzDpFwUZ/AFDWF/8P3ohKYq2KSdnW/eT/CKyoQ1dl+EC0PcA+gucE8UWBOQ6oAM5KrIappZqBrjPDdkkBnwUrRaMYRfsRbTNptDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRoRJ+i6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2232aead377so45522305ad.0;
        Fri, 07 Mar 2025 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741372218; x=1741977018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADljs+6QUrhT8gv23eyNcU2smhHAIyZh+jPjPfAngag=;
        b=LRoRJ+i6nmPuw6J4mI0+/g5RuHMKEaRwxKUH0fsnU91Oi+6EqlRgZb9iPMFLJ1AbLf
         AA3+UiSeaJ0sWQNoDK8xSKSIxbiHUU+T2CqtmZb2SHJQ9L2PtR8nfwbBM5ZIORTedLlj
         XXZdLyXrkBifLzf3y59opc9DLMeylAxAv9oVvQI3vUZo7RmCj2tqPIvs28zzLeAEquAq
         MfSqhA7aZHqXUIB9iIBEaOribAeC/32Xsr3iN1QZn4Cg6Ud0aKcsiYnG2XesVyOFjixM
         PIy3vMEkhpCud1cLg7foEbHbZ8FcNqR3adQRJJAZgiRlAk7KP4NVCsEXekGHZnaJYF8V
         ONTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741372218; x=1741977018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADljs+6QUrhT8gv23eyNcU2smhHAIyZh+jPjPfAngag=;
        b=X9o0Ba43rVR2ETS5JIfOsEfjSHfpGLay4W2zyclTijsBzTfzJ6qOglBnUNRWgsdN/A
         HL8vb1azJpTAiMOx9aSvJT7i/pgp5J+eLlDv8iejWYVdiVMU5KTMJRtOIHEQttmzicVe
         k0UdjO+UqHkj14o4sNiX3rJWi0F1GeCMdllXFogYMuvWoj9vEr8C86CRYxO5c2Ns3Xy1
         jta9dY6kT39ui3qRIzNbD8I5ghJGNbT+QZfPWJxYZ0Faf5KY0ayMrzj+xOQWoR+TVtUz
         fD5T/yHdfDGNpzh8fxu8Uzz8oBSMT2tEa6w/2r7fGf87AJmyGii2V/K2n9JQSXzAlomI
         wwIA==
X-Forwarded-Encrypted: i=1; AJvYcCUKmEF+lNUJ304UBMSNrZOIwiXaAax6mSDmor7ApZ7jii6U0gXcE0E5TPlKu3kIggcwvWDmOIIdx5x4o1rzvp8=@vger.kernel.org, AJvYcCUbGTCE6szGWckdylirQfziyTkwq2kAeUnntBnoh6tiMN2vo2KfnqlomjBqBL4UnrHU4qalvKLlLArW70rL@vger.kernel.org, AJvYcCV9XdzGxV/JvCnpEuZhzrHM/en5rKGOoJLoGI708ePS3O0zV3eaAz3wHqeZSlzQfRznFtk=@vger.kernel.org, AJvYcCVUg2eBLF9+v6Y8c8YMyyDPKHTB+oIeWwOV0nao241YtVod9zwgDleEvhnhU6zx0KSaRN8Uitxhgt3L9lw=@vger.kernel.org, AJvYcCVzKEi4vRh8thBe0lCU/mvvMyB5HNdduuzF7Q1k6lIzELT2uOghjbjtLvrzRzbgSOBD/cM0vrOwBLneeLg=@vger.kernel.org, AJvYcCWhkugP8Uy/rwjLO97e5nqMWoVWC97rHA0PQhegUmZKK8GElF5j984oMV79hbMEbHLSTOD8qEvqS++0HmbJ@vger.kernel.org, AJvYcCXQliO0RH4F2IZeXYDjPeE8orqz9hw62/INKWBzGtO0ypR/Dyw7pbvEuR8uKkpVy4zf886drSNg@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGS03q3GlluOHNogL0a8ztc0jcM1gMuD0Og2hohrKLyr9yiZ0
	xLdrYIog5AvVGMC8i6Gvy9z+dOfBzuQy5OCJxBhCivm8gOYUzFgi
X-Gm-Gg: ASbGncsDxeWm+E9bidiY2AAss9EU4j34bh9pSViXuTqmYu4yFmTXfb+k469wwYKyo/l
	39G0LYXpvw+l3pkZGuwHKPqlfG+QNNMG2M2LsWGUBt4qaCzJcYckSeHWXPd5PcsgL3c00yncy5/
	D/vluuM2uVJT/dtlxHCddw8Y7JnYe+uKOjGWWozUjHmjEZ6Zpiwx6WLUVDDNFUW5Hq4wJbOK2qX
	r7srnl5fAUSTK11Z6orbjwK7vrn8mq5H7dseMzE3AgyMntd1PWotEmno2S9QBjxT/VuEUveMsZg
	q7NBIJQWRfWd9gZb5JQtUwAMIhNbU7IDDrAMLPgjbPvq9sL6vJ7QY7gHlJS2pHbwtFJpItN/
X-Google-Smtp-Source: AGHT+IHgn9VYVN+pY6VrcRSpGmZ1OnVGCCY/wp+YVj8MkJGAiDKX4lh0yxX6MBBGMkwIe7/wx2wiPQ==
X-Received: by 2002:a05:6a00:139a:b0:736:520a:58f9 with SMTP id d2e1a72fcca58-736aaadf082mr5830777b3a.17.1741372218220;
        Fri, 07 Mar 2025 10:30:18 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f7268sm3588473b3a.116.2025.03.07.10.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 10:30:17 -0800 (PST)
Date: Sat, 8 Mar 2025 02:30:07 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
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
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Message-ID: <Z8s7L+ZCI/yM5qm4@visitorckw-System-Product-Name>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
 <3dfc81eb-caa1-42fe-8fd6-61101de0ef13@kernel.org>
 <Z8sW4c5LxV-ITdCi@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8sW4c5LxV-ITdCi@thinkpad>

Hi Yury,

On Fri, Mar 07, 2025 at 10:55:13AM -0500, Yury Norov wrote:
> On Fri, Mar 07, 2025 at 07:57:48AM +0100, Jiri Slaby wrote:
> > On 06. 03. 25, 17:25, Kuan-Wei Chiu wrote:
> > > Several parts of the kernel contain redundant implementations of parity
> > > calculations for 16/32/64-bit values. Introduces generic
> > > parity16/32/64() helpers in bitops.h, providing a standardized
> > > and optimized implementation.
> > > 
> > > Subsequent patches refactor various kernel components to replace
> > > open-coded parity calculations with the new helpers, reducing code
> > > duplication and improving maintainability.
> > > 
> > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > > In v3, I use parityXX() instead of the parity() macro since the
> > > parity() macro may generate suboptimal code and requires special hacks
> > > to make GCC happy. If anyone still prefers a single parity() macro,
> > > please let me know.
> > 
> > What is suboptimal and where exactly it matters? Have you actually measured
> > it?
> 
> I asked exactly this question at least 3 times, and have never
> received perf tests or asm listings - nothing. I've never received
> any comments from driver maintainers about how performance of the
> parity() is important for them, as well.
> 
To be clear, I use parityXX() was mainly because you dislike the >>
16 >> 16 hack, and I dislike the #if gcc #else hack—not due to
performance or generated code considerations.

> With the absence of _any_ feedback, I'm not going to take this series,
> of course, for the reason: overengineering.
> 
I'm quite surprised that three separate one-line functions are
considered overengineering compared to a multi-line approach that
requires special handling to satisfy gcc.

> With that said, the simplest way would be replacing parity8(u8) with
> parity(u64) 'one size fits all' thing. I even made a one extra step,
> suggesting a macro that would generate a better code for smaller types
> with almost no extra maintenance burden. This is another acceptable
> option to me.
> 
I'm fine with unifying everything to a single parity(u64) function.
Before I submit the next version, please let me know if anyone has
objections to this approach.

Regards,
Kuan-Wei

