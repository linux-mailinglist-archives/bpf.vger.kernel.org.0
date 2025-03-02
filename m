Return-Path: <bpf+bounces-52994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0AEA4B2B8
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 16:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A1A1891F0F
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CB61E9B0A;
	Sun,  2 Mar 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMfnxGBl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD52BB04;
	Sun,  2 Mar 2025 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740930467; cv=none; b=Pvath3FPrtdO9D+lGDdqfMwqw/2JrmSRc51TLE0FMcn2h06lEs6Hhqw8Pjwu9BGw/A2m68TTDQ3ckRsEvvAUqj5lhq5+RmTBFbz3k2GtGyEcY6qU1QzZoexLkFLE2VjvUSJyBvKrDzOvuLzazr2krIKPYcn4ENvwZFQnSeB2RLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740930467; c=relaxed/simple;
	bh=Okh8B31yIedOwS+wAZPKlNc0foFVtviDzKYErsu9Gw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlJQwn/runmiaoAOR6rkpC5BDhlkGFzG9K4RUCKCPQqJbL+Clir5G5rmiUFG3FfZvQ1Iy9yEjP3y1JHvLwC+qPknWdt3zi+VQA624G8B7dVTrHq7KcGCcZ7oRTBkNpKCaaCR0qVSMEp+kphgkw4USoUzGGFbVwWP8u9/zH0Y0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMfnxGBl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f9625c0fccso32353137b3.1;
        Sun, 02 Mar 2025 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740930464; x=1741535264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCT1sTVFptoP0GXpHD4z8aJ9CCOqcWh1+88rLPDB2Qo=;
        b=PMfnxGBlhlGGxwz2h+aXIC6YqSfvnS1XUurUVHPm4UGZf9dDm3GlEU23BIE2VrRXDG
         em4az6zxVD3GZUGNl24U2SSnlHofnpgFOdCApMfn09qo1ZBO1DG2ylf9dzIe3n08+2j3
         UOzsOoDz5UAmOH/DQnmzYkIaw6kGY4N/d2s+UkSef7bCeY7dN40E8wIkFaMe87Xc1sGo
         1TZixxTHNK8RrnXqLdSyHwFPATmjCPj3YRUzwJOxH9NTsld1NUTbdfcSptZACmpr8saP
         jdNTU6Oce/qr7r6Kraa3fFd7jpu6kq6+eeRE5xxuqKaAz7uhXxPmO80Jqt8Rtjw1Crvw
         rKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740930464; x=1741535264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCT1sTVFptoP0GXpHD4z8aJ9CCOqcWh1+88rLPDB2Qo=;
        b=vhR3pOWyYz4V/+Wdw5/YOQwWLuIZavdUNhXCnJd1BJ4eGL2uiN3g1TUDQ7EJ7H2IdF
         5TwqSp5WZeRjwznkDDwacTC6V9nYzPt4etAo9wCUQnOVspUnLrYUJgI5xbJ7b0JY3HY3
         aHfw1hQ0tj8nvUVyn5X9a1bPIOETsUYkhV840E8Z0+23wYJV59o3McJvUOxFbCphqlWw
         TKp1RY3Y02GijL8TUL9mR+Mp1q2RPC2fSJAy/TM+6o234cATXfwDX01Axd93bMVOW0pH
         anXAOP9YbMaTWhMlTyHay0mhtOmHpoz493VUN8XAK3NiGTeSRtGsqEwjXi5NhLZ1ITbB
         ij4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWr0wyCyah+rwxfpfRIe+sKglWNKlDK42Nu/u51+2KB6ANUgsU6Xd9vhRASzYwgcY+kCM=@vger.kernel.org, AJvYcCUePBVRT66mL+A1aGciRfT2JvHfZ1TA5VP1ZBdHW4MOupTflyimkGdwGdkWSF8JgGizCaDO8/uhoEV8oR4=@vger.kernel.org, AJvYcCW+2Bskq7NxoeJxof5/6ZfHqwj04pc8+CipZBFJQDtkLi3VuOssXaXhhSi+8zafuAkmsnEf893FaR2P8TA=@vger.kernel.org, AJvYcCW0Xtak2/fSL594EjznaL9728kXo/mwNHNlT925LUvPHlqzy61YytPpqQOfQFrrx259R+m5486A@vger.kernel.org, AJvYcCWejiRdfQTQTwO3BAfSWGRRFLbkhNCi9k4VtdFRNrKvyj8q++xC1gGZ45jiCvQXEeF7FNvy6ZEQOj3oLOIs@vger.kernel.org, AJvYcCXp17dnTaH8ntXrOBaySMauXtqbj0RFJLr384dTePFT+wifzomJ+MR39IFZKjrq/VbslBnkRqPqlUH/DmX3SFg=@vger.kernel.org, AJvYcCXr2+WP5+oBvajdRi3iUak9xXXYqDWY5ZVlFNODcl0AYXUpCs78midKUkas8HJj2S9NipauFBddcW8RTOOu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlmb59CQbQJmBg6Nv1dor3kGs+nYFvronikTEytzaN2SQG6HMr
	Hz9VmcYokAbFKTt0K8ZuabZ2AXVFqKb/Zj+bNh31F/B/kNL6WEHP
X-Gm-Gg: ASbGnculKKr02cpjQ4ZzjbjhKt59QlPna/hNZeM8CBFUweIMyVfqIeSxZvaKZxlDoFb
	pS+397zQe/muoC1y1lcym+8jN0x6we2liIU/DJzDsxtGeY/Otjp/vy/kMwtwgn+SMRyNSRiD2Z3
	b1hX3b2mtpfdq7TQCPU+hrn5KPxVXc/73AIv0gcNL1/UymxZLZuPaISNZIxkYOrdx8mLv+j+AMC
	NGuyjHga9SSoXGy5fxD5QKkaD/oFZkQOqtRTUObdC0Scs0R2ZlZ8Y9rGjuafWYt96jpCGc5Y02e
	tVn2rIlZwV2YLMZls5YbS/9Plq743ZoERI+A8Wlx028zVvGZfhw0V2IMln20FgD8gGleh/WtI+7
	+t4WM
X-Google-Smtp-Source: AGHT+IEfQ39kTql5XsYDhHYJ6TV6j9haA6dlCxpju/Rqc4ygrtquBMosdzic0x4c9/qeMrvSjUoEBQ==
X-Received: by 2002:a05:690c:6301:b0:6fd:4485:9255 with SMTP id 00721157ae682-6fd4a122c2amr115575717b3.24.1740930464153;
        Sun, 02 Mar 2025 07:47:44 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca41e81sm16218887b3.29.2025.03.02.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 07:47:43 -0800 (PST)
Date: Sun, 2 Mar 2025 10:47:41 -0500
From: Yury Norov <yury.norov@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
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
Message-ID: <Z8R9nQmfeVvfDiOn@thinkpad>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-3-visitorckw@gmail.com>
 <Z7zIBwH4aUA7G9MY@thinkpad>
 <20250226222911.22cb0c18@pumpkin>
 <Z8CpaaHv0ahHFVuK@thinkpad>
 <20250227215741.1c2e382f@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227215741.1c2e382f@pumpkin>

On Thu, Feb 27, 2025 at 09:57:41PM +0000, David Laight wrote:
> > It's still unclear to me that this parity thing is used in hot paths.
> > If that holds, it's unclear that your hand-made version is better than
> > what's generated by GCC.
> 
> I wasn't seriously considering doing that optimisation.
> Perhaps just hoping is might make a compiler person think :-)

David, can you suggest only things you're seriously considered to do?
Random suggestions distract my contributors and make them doing unneeded
work and experiments.

In the other thread you asked I Hsin to try your approach to GENMASK()
macro, saying you're lazy. I don't think this is the right way to
communicate, not mentioning that if you're lazy to try your own
approach, it doesn't sound nice to ask someone else to try it.

Thanks for understanding,
Yury

