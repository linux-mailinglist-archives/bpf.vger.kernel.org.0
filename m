Return-Path: <bpf+bounces-54584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9BBA6CFDC
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 16:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAF916E9C8
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0E136672;
	Sun, 23 Mar 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSKErXam"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F6EEA8;
	Sun, 23 Mar 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742742997; cv=none; b=h8j6FEDi/DkOYrc4A6WbistRwRtUZwFZ6uT4oZD8iROn0syU6tcbQPCTLczhCo9OGW3lYod0iSR3WAtQM61Vj+HJAjPKNuu7PbKK5bPvLES+uYPAMXhLOTEXdgHvSM76fJYClcSyEgu2hhsgoGk25CAHsZE4zb77AoWNVngd2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742742997; c=relaxed/simple;
	bh=z1iry3Q+ZuonlJJ0TwlMVAFT0se2HxhIpoPnsRsnLsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsC9avdn5V7N5OgzT8CTEP6aiIhHlKTSSf/2JUctaWs3+FJtTqrvuiNBRgTBVzgLWdUtCnZy/SbQ1MNAuzeFPudle/friGxj8oeC0KLJ1LlIjw6l3hz3pFV5xgEDyr+FzaU/BfW6zzbJewI6htLS7IxszzoSrxgdjxrBV76Jh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSKErXam; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224019ad9edso86857995ad.1;
        Sun, 23 Mar 2025 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742742995; x=1743347795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8HAFSGGoHUlB/P//y8CRGPMxIiz2cZBE9oAiPUoftnU=;
        b=QSKErXam2M/O3L3qT9hiT/LG33negg+IlgrywqMrof0yVzQPGEO8pMXP5NBg9zKyNB
         5aQ5/axR7fELGSwcGzqs4Ls6A+MHtdFVxn41ScblbZgdJkRUKtsevNQO8AlqCu4yOUkB
         IKOadC2A3ssnQ+qnuk6Hkd4cxOFkt7zTCfwJKyl9E2Mb8/R68s9igYXSguHsJgaUse0J
         W70NvOTkGlTJFbH10x3O/LS2t1uJmBR/sLdMt9h7Zq2mX/t3C82wT4NSCfQSqxZbMbTS
         bHLWM38cBHkpsrin3WcCBS5LjsZIhJkMMq9fimWdSNXK/gHIo9nvkrK1tQR668tLLUZy
         GVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742742995; x=1743347795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HAFSGGoHUlB/P//y8CRGPMxIiz2cZBE9oAiPUoftnU=;
        b=IGeAD/cEFZTJXKjOtR4ucO07a3mkpPnft3u9FJua22FVRuRSE2h5ZH/y6M1bX+aBVh
         V1jTNR9jEINon2X05IY2iQ9bfBk4eszjStGiYtYRqeaAczkDGxXJSJ7Q/G97jI8bgurv
         9K6OSjSF3X0o5sIk+sxrmEyCiljC6qYIVuIK7SxoSERlDAJ8R6L6XoZiQMeoNWbSEQ2W
         4uMz6NJyHEvBeRKERdYFR32pVXJdfZ/7XJe7AcX6TgIzQDLyL+cHdPWe8tpaD4lwuMTV
         aKzscHDd4k7LYE9QmcGwZ8BqCnQ43IazbqX+UR8x7mH5yNJryEGK6d4xAqLxDOFZBrkW
         mtKA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Xw0v9ojtIYehIb2kR/2XB9VwSSJsLzXDj5gLrE8/5Gdm38qEalMQBrKVMHyVBdzEdUpK9kjd@vger.kernel.org, AJvYcCVU+Of6USSioyxNuo5IdCIWATJYaooAenKr4eb9H0FJ2qkOJEy/j8NXeJUNoXxS6Gpb6kY1jKwMxNdOGTZh@vger.kernel.org, AJvYcCVpkkFUxqc/wuVqnvhZXtviLd4ZE5eXQw0DqeSGHbZhfPd5MzdqS2XrV35lOfv84UsWVHEDuNE5lI117kM=@vger.kernel.org, AJvYcCVydyj1nXFQDpP9SNTvjtwjhBDF9aVFoNHTtiboBvJfW0yhCm6zP3RpYb0ePJ3FTFSDn2XqsKm4cLJcR4xv@vger.kernel.org, AJvYcCWEZcxqia3gXCYnh/A1uKylw8vzZ7zRJgLi9od+59xx2q7aFI8H84T10Urx2+X9CK+IzZNqpXnl/0XJpe0=@vger.kernel.org, AJvYcCX4RCUaVzTmys5wL9bRAr8L4SMjYRJVLKojuHhZUcH1pP2lcfDv2U4VObBvCtxA+GxIWis=@vger.kernel.org, AJvYcCXBSVsKoSCWAz5VyiJBiroGSLFolKjHw/il9YFZB8T5a4g0K3X2Sl/7DErVEGvnzCpVXOVWw4glANRaOyAFeTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RtgMAPbYx6CnzlH8PsLPdxnWweF5gwOI3Fng/WImvzT0UhV1
	YN4bf23XjMEEg1ODqXhb/5KDQcCCd+c2ZbIzTBKkKU0R6CFSbQmC
X-Gm-Gg: ASbGnct2vr76XZkQJBvEoyPRw4a1ebYFUw5JGCw939jmiNz5BBQXXNWkBw+llyb6X8u
	pOttVrNqsgECm1y1EibdqpevRNh/DjXvBsZpstVpabNiYLxaVfmnbLPHYF3B/uRSPI6iSLAwgs3
	5SGQXjo22U96msYWio4ChHviJ8lgJKrmMKVTTEs2DqIYL1jGcU6pSdq2kA+o+RNOgOBRGCP3m74
	e/wdpRda0YTUUDYqhWjh4lJixJ4a7nhJHKZcpcnZRZxrm/Ey1OHks4ssGA+9dh/te5fd8n8qxKq
	/pt98mOAfF+61MmM766RVzD3WYrQmsRCjGi9tya794eqm0yNvLXtjyFCsz+xGomPlq3fn4WI
X-Google-Smtp-Source: AGHT+IFu7aSko21Sw2wxa8CSJ3BoLCLGU4XDLggoCqJDcaLIBubWzqHl2YbchxgGWLxoXzaA2oGt1A==
X-Received: by 2002:a17:902:db12:b0:216:3d72:1712 with SMTP id d9443c01a7336-22780e1a30emr184600615ad.48.1742742994925;
        Sun, 23 Mar 2025 08:16:34 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22781207f3csm52440875ad.247.2025.03.23.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 08:16:34 -0700 (PDT)
Date: Sun, 23 Mar 2025 23:16:24 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
	akpm@linux-foundation.org, alistair@popple.id.au,
	andrew+netdev@lunn.ch, andrzej.hajda@intel.com,
	arend.vanspriel@broadcom.com, awalls@md.metrocast.net, bp@alien8.de,
	bpf@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev, dave.hansen@linux.intel.com,
	davem@davemloft.net, dmitry.torokhov@gmail.com,
	dri-devel@lists.freedesktop.org, eajames@linux.ibm.com,
	edumazet@google.com, eleanor15x@gmail.com,
	gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
	jernej.skrabec@gmail.com, jirislaby@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, johannes@sipsolutions.net, jonas@kwiboo.se,
	jserv@ccns.ncku.edu.tw, kuba@kernel.org, linux-fsi@lists.ozlabs.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux@rasmusvillemoes.dk, louis.peens@corigine.com,
	maarten.lankhorst@linux.intel.com, mchehab@kernel.org,
	mingo@redhat.com, miquel.raynal@bootlin.com, mripard@kernel.org,
	neil.armstrong@linaro.org, netdev@vger.kernel.org,
	oss-drivers@corigine.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, rfoss@kernel.org,
	richard@nod.at, simona@ffwll.ch, tglx@linutronix.de,
	tzimmermann@suse.de, vigneshr@ti.com, x86@kernel.org
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Message-ID: <Z+AlyB461xwMxMtG@visitorckw-System-Product-Name>
References: <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com>
 <5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com>
 <20250307195310.58abff8c@pumpkin>
 <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>
 <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
 <Z9CyuowYsZyez36c@thinkpad>
 <80771542-476C-493E-858A-D2AF6A355CC1@zytor.com>
 <Z9GtcNJie8TRKywZ@thinkpad>
 <Z9G2Tyypb3iLoBjn@visitorckw-System-Product-Name>
 <Z9KMKwnZXA2mkD2s@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9KMKwnZXA2mkD2s@visitorckw-System-Product-Name>

On Thu, Mar 13, 2025 at 03:41:49PM +0800, Kuan-Wei Chiu wrote:
> On Thu, Mar 13, 2025 at 12:29:13AM +0800, Kuan-Wei Chiu wrote:
> > On Wed, Mar 12, 2025 at 11:51:12AM -0400, Yury Norov wrote:
> > > On Tue, Mar 11, 2025 at 03:24:14PM -0700, H. Peter Anvin wrote:
> > > > On March 11, 2025 3:01:30 PM PDT, Yury Norov <yury.norov@gmail.com> wrote:
> > > > >On Sun, Mar 09, 2025 at 11:48:26PM +0800, Kuan-Wei Chiu wrote:
> > > > >> On Fri, Mar 07, 2025 at 12:07:02PM -0800, H. Peter Anvin wrote:
> > > > >> > On March 7, 2025 11:53:10 AM PST, David Laight <david.laight.linux@gmail.com> wrote:
> > > > >> > >On Fri, 07 Mar 2025 11:30:35 -0800
> > > > >> > >"H. Peter Anvin" <hpa@zytor.com> wrote:
> > > > >> > >
> > > > >> > >> On March 7, 2025 10:49:56 AM PST, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > > > >> > >> >> (int)true most definitely is guaranteed to be 1.  
> > > > >> > >> >
> > > > >> > >> >That's not technically correct any more.
> > > > >> > >> >
> > > > >> > >> >GCC has introduced hardened bools that intentionally have bit patterns
> > > > >> > >> >other than 0 and 1.
> > > > >> > >> >
> > > > >> > >> >https://gcc.gnu.org/gcc-14/changes.html
> > > > >> > >> >
> > > > >> > >> >~Andrew  
> > > > >> > >> 
> > > > >> > >> Bit patterns in memory maybe (not that I can see the Linux kernel using them) but
> > > > >> > >> for compiler-generated conversations that's still a given, or the manager isn't C
> > > > >> > >> or anything even remotely like it.
> > > > >> > >> 
> > > > >> > >
> > > > >> > >The whole idea of 'bool' is pretty much broken by design.
> > > > >> > >The underlying problem is that values other than 'true' and 'false' can
> > > > >> > >always get into 'bool' variables.
> > > > >> > >
> > > > >> > >Once that has happened it is all fubar.
> > > > >> > >
> > > > >> > >Trying to sanitise a value with (say):
> > > > >> > >int f(bool v)
> > > > >> > >{
> > > > >> > >	return (int)v & 1;
> > > > >> > >}    
> > > > >> > >just doesn't work (see https://www.godbolt.org/z/MEndP3q9j)
> > > > >> > >
> > > > >> > >I really don't see how using (say) 0xaa and 0x55 helps.
> > > > >> > >What happens if the value is wrong? a trap or exception?, good luck recovering
> > > > >> > >from that.
> > > > >> > >
> > > > >> > >	David
> > > > >> > 
> > > > >> > Did you just discover GIGO?
> > > > >> 
> > > > >> Thanks for all the suggestions.
> > > > >> 
> > > > >> I don't have a strong opinion on the naming or return type. I'm still a
> > > > >> bit confused about whether I can assume that casting bool to int always
> > > > >> results in 0 or 1.
> > > > >> 
> > > > >> If that's the case, since most people prefer bool over int as the
> > > > >> return type and some are against introducing u1, my current plan is to
> > > > >> use the following in the next version:
> > > > >> 
> > > > >> bool parity_odd(u64 val);
> > > > >> 
> > > > >> This keeps the bool return type, renames the function for better
> > > > >> clarity, and avoids extra maintenance burden by having just one
> > > > >> function.
> > > > >> 
> > > > >> If I can't assume that casting bool to int always results in 0 or 1,
> > > > >> would it be acceptable to keep the return type as int?
> > > > >> 
> > > > >> Would this work for everyone?
> > > > >
> > > > >Alright, it's clearly a split opinion. So what I would do myself in
> > > > >such case is to look at existing code and see what people who really
> > > > >need parity invent in their drivers:
> > > > >
> > > > >                                     bool      parity_odd
> > > > >static inline int parity8(u8 val)       -               -
> > > > >static u8 calc_parity(u8 val)           -               -
> > > > >static int odd_parity(u8 c)             -               +
> > > > >static int saa711x_odd_parity           -               +
> > > > >static int max3100_do_parity            -               -
> > > > >static inline int parity(unsigned x)    -               -
> > > > >static int bit_parity(u32 pkt)          -               -
> > > > >static int oa_tc6_get_parity(u32 p)     -               -
> > > > >static u32 parity32(__le32 data)        -               -
> > > > >static u32 parity(u32 sample)           -               -
> > > > >static int get_parity(int number,       -               -
> > > > >                      int size)
> > > > >static bool i2cr_check_parity32(u32 v,  +               -
> > > > >                        bool parity)
> > > > >static bool i2cr_check_parity64(u64 v)  +               -
> > > > >static int sw_parity(__u64 t)           -               -
> > > > >static bool parity(u64 value)           +               -
> > > > >
> > > > >Now you can refer to that table say that int parity(uXX) is what
> > > > >people want to see in their drivers.
> > > > >
> > > > >Whichever interface you choose, please discuss it's pros and cons.
> > > > >What bloat-o-meter says for each option? What's maintenance burden?
> > > > >Perf test? Look at generated code?
> > > > >
> > > > >I personally for a macro returning boolean, something like I
> > > > >proposed at the very beginning.
> > > > >
> > > > >Thanks,
> > > > >Yury
> > > > 
> > > > Also, please at least provide a way for an arch to opt in to using the builtins, which seem to produce as good results or better at least on some architectures like x86 and probably with CPU options that imply fast popcnt is available.
> > > 
> > > Yeah. And because linux/bitops.h already includes asm/bitops.h
> > > the simplest way would be wrapping generic implementation with
> > > the #ifndef parity, similarly to how we handle find_next_bit case.
> > > 
> > > So:
> > > 1. Kuan-Wei, please don't invent something like ARCH_HAS_PARITY;
> > > 2. This may, and probably should, be a separate follow-up series,
> > >    likely created by corresponding arch experts.
> > > 
> > I saw discussions in the previous email thread about both
> > __builtin_parity and x86-specific implementations. However, from the
> > discussion, I learned that before considering any optimization, we
> > should first ask: which driver or subsystem actually cares about parity
> > efficiency? If someone does, I can help with a micro-benchmark to
> > provide performance numbers, but I don't have enough domain knowledge
> > to identify hot paths where parity efficiency matters.
> > 
> IMHO,
> 
> If parity is never used in any hot path and we don't care about parity:
> 
> Then benchmarking its performance seems meaningless. In this case, a
> function with a u64 argument would suffice, and we might not even need
> a macro to optimize for different types—especially since the macro
> requires special hacks to avoid compiler warnings. Also, I don't think
> code size matters here. If it does, we should first consider making
> parity a non-inline function in a .c file rather than an inline
> function/macro in a header.
> 
> If parity is used in a hot path:
> 
> We need different handling for different type sizes. As previously
> discussed, x86 assembly might use different instructions for u8 and
> u16. This may sound stubborn, but I want to ask again: should we
> consider using parity8/16/32/64 interfaces? Like in the i3c driver
> example, if we only have a single parity macro that selects an
> implementation based on type size, users must explicitly cast types.
> If future users also need parity in a hot path, they might not be aware
> of this requirement and end up generating suboptimal code. Since we
> care about efficiency and generated code, why not follow hweight() and
> provide separate implementations for different sizes?
> 
It seems no one will reply to my two emails. So, I have summarized
different interface approaches. If there is a next version, I will send
it after the merge window closes.

Interface 1: Single Function
Description: bool parity_odd(u64)
Pros: Minimal maintenance cost
Cons: Difficult to integrate with architecture-specific implementations
      due to the inability to optimize for different argument sizes
Opinions: Jiri supports this approach

Interface 2: Single Macro
Description: parity_odd() macro
Pros: Allows type-specific implementation
Cons: Requires hacks to avoid warnings; users may need explicit
      casting; potential sub-optimal code on 32-bit x86
Opinions: Yury supports this approach

Interface 3: Multiple Functions
Description: bool parity_odd8/16/32/64()
Pros: No need for explicit casting; easy to integrate
      architecture-specific optimizations; except for parity8(), all
      functions are one-liners with no significant code duplication
Cons: More functions may increase maintenance burden
Opinions: Only I support this approach

Regards,
Kuan-Wei

