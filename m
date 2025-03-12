Return-Path: <bpf+bounces-53906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE051A5E1C6
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66019189F279
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03F230BFB;
	Wed, 12 Mar 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfeH07F3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040621D5CCC;
	Wed, 12 Mar 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796957; cv=none; b=eDk1jjhRdWcOCCoayoCdFCsJLwdjRrsoRTSpoeFV/N6Z3kw9FFtO76WAoxLEb78SGXNwBBGsuxbK1/6WEWryO4vl6/dfxzcE9hbeqpp+zgXNX0Y4/m/TfBx9EvHdKbPUHObZXG3fPf1l1nWd3N0BEQhRCpBE+vU+PZ72Rb5FQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796957; c=relaxed/simple;
	bh=MkquzNGR5u5FjZfmYraDvBYWVwSZLi6p7H/c2kA7eDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjD82RurLjEbVzWDY6fqkLjO1R30owQnMLx+aJdZNkZvBXCPdl7DEarbs74IvTrsBK6vBKHYBywuCXdQxJ0PFKvEQKo/Aqa0NjD+pLKuluSBX+Dl1uFB628RZQMyBmlkRpkuwH2ycrx6erh28oyN6x42T+PfbH6nwKsUl414x1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfeH07F3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22403cbb47fso1287985ad.0;
        Wed, 12 Mar 2025 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741796955; x=1742401755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhcfe4HGkn1nyr43hd6XB44u2jS51t/HM3EqUkeXy9c=;
        b=LfeH07F393rlxszrLKzP0gTb3+/lceKh6+N8gETikZGDiLQJBaj7e7/3hyASmBtka0
         KKIMxrNGGjzof89sPa+mh4L/huoSUBpgDp+AgjYbaYfoTtT+/tONPgUUi6BqDBtbCo+5
         fIliCaHf/DKdC/i63WF1l1XNHvulOkCs66Aa3MlEm3UFX4gMYJ+S4y3nuePAN7MzNblj
         q6wlSJ4qne3OPhHagYZKgiL62d6zSQSfrc/VN/pyuSO5B39fH8nDUP2oXTRUpw3AJHNL
         5iOk9SiPZZx+Qn+GjjdKbR68zS2ZPv9rfq8QANW4QxXsE76GpEB3YDe7LnH9XvAaqVSM
         NUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741796955; x=1742401755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhcfe4HGkn1nyr43hd6XB44u2jS51t/HM3EqUkeXy9c=;
        b=CBGTvydhWY1DNNb7FUp2+JcaiUPKd77seIu2/MlSpk9DU3IWVdPaAOv395Ooh350LX
         B+WSQhO9SBT03AIjpLlh6nBa682SzvoggRsKgX7hqCzkLE8fs1mkZ8XzgPhGbOlr8xzb
         Gg0J3+ll+2WfAKkGPv6NqoMVjVVE9eZ0PoptdWa+RNeL9R05Xct6ybtLrTSdCI2YpUV/
         sRLMr/CafgmUFXqdeRk3r6IN52mYWUTFHhWfeUP9mo8l1C7DjzwPwq3zZLmwrnhmePVy
         MGD8Bu35hhumc7LonpfSCHgt2q2+6k8g9eFzYw6aPmhkFuvIn0VvWSK2gGLlJF4MyzMa
         pIlw==
X-Forwarded-Encrypted: i=1; AJvYcCUVj8UROpb9QMK/wp3V1kgxKEQosAlcCRxpbzVgI/KT4eYZyZD3atLiqADmAwc5FdJ5FodYVGw51OdseXlTB6k=@vger.kernel.org, AJvYcCVPJ8yhdz5hT+8lmhHhvSW0NS4z8eYbAQfLzjS00LEoQ8ZHjTjYGOpaxw0/17uTOlkfjsKEKIzubLFiyea2@vger.kernel.org, AJvYcCVbFCFbit1bYHEBvoXSuhFywnq/TxauXL4Jt/TUA3o5z8+4tyLmASvwG8I8FeMglSWCTKNjpRVmFP5LbYFN@vger.kernel.org, AJvYcCW2e/o2xOD8fYev5Tny0ZPAXN9E4/0NNS0pl5kRMWDTVeArOMIwS0/RmZnllZqomRCQ44v67BPJ@vger.kernel.org, AJvYcCWBWc5RQX4b2v39dH+PJXFsX4xncjsmrYAaDotWbAsYlZuR2u7eBVsvgOWD97aqeXu18X4=@vger.kernel.org, AJvYcCWogQqn8Cj/sunKwz7A+WZdgVvm/etvLbzdq+5gzlHPkjbIyHzP8Z8aTYNQeHZe0XH91pZiR38Beem1KVM=@vger.kernel.org, AJvYcCX1hO9JxBxKUCNMR/Xm9NuQ3acnzOM1Y63bmNnajxbvsQReNDHQrGNvp16rZoGuZzLQr+IOIgf1t1sSSH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwefnMjVo7H8w+AHSLmSGqGjEryl4DGN8aWC7ef62O2QUH84OFy
	7Jxxtdb9qT5NfUuxtio5yVHXqNMiTVvrX2za2+7Ex4xUvAgFKt7S
X-Gm-Gg: ASbGncuozw5536fauNot/istVIorsXH+G8V2RGXMzkuabmmr03IGwvcB4cK6c9Zix/0
	9KjgJYpcmfRnGeMtZ+SLaERwzBvLV8it+TC5RJT+5SupbjHfA6kskvNDDkWbOXOaUejuxaCr8fQ
	LNg7lPWa/A1mhS8obJsE0oiSrKNhacixgggD0o3bReeBUcJDuLpfQdC+RBRb3SNi7vKZgYeTVST
	o897ZB75/4MAtB23pqhs7vj5w36VD9xGpKYDvYvubYHdTB9h3+wCA4K/m16X4RvVoGjxWsAnLl4
	n2P8kDEWdc+0Gv+8TGzLYLpY2qbiERGoFC7TaX8SVgZ0X8cxQMltbP/rPpTF/m9j9AI46ktQGFj
	qKajwXEg=
X-Google-Smtp-Source: AGHT+IEiP0tHquLMN5Gvv18JZ85TV9p3x6ZPq/xCnQ6CX9V0mfYcQUP3ZT96MUKotDyAatA1bKDzpQ==
X-Received: by 2002:a05:6a00:cc2:b0:736:6279:ca25 with SMTP id d2e1a72fcca58-736aaaed7admr38773850b3a.24.1741796953585;
        Wed, 12 Mar 2025 09:29:13 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bb5fcd68sm9479412b3a.135.2025.03.12.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 09:29:12 -0700 (PDT)
Date: Thu, 13 Mar 2025 00:29:03 +0800
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
Message-ID: <Z9G2Tyypb3iLoBjn@visitorckw-System-Product-Name>
References: <4732F6F6-1D41-4E3F-BE24-E54489BC699C@zytor.com>
 <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com>
 <5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com>
 <20250307195310.58abff8c@pumpkin>
 <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>
 <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
 <Z9CyuowYsZyez36c@thinkpad>
 <80771542-476C-493E-858A-D2AF6A355CC1@zytor.com>
 <Z9GtcNJie8TRKywZ@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9GtcNJie8TRKywZ@thinkpad>

On Wed, Mar 12, 2025 at 11:51:12AM -0400, Yury Norov wrote:
> On Tue, Mar 11, 2025 at 03:24:14PM -0700, H. Peter Anvin wrote:
> > On March 11, 2025 3:01:30 PM PDT, Yury Norov <yury.norov@gmail.com> wrote:
> > >On Sun, Mar 09, 2025 at 11:48:26PM +0800, Kuan-Wei Chiu wrote:
> > >> On Fri, Mar 07, 2025 at 12:07:02PM -0800, H. Peter Anvin wrote:
> > >> > On March 7, 2025 11:53:10 AM PST, David Laight <david.laight.linux@gmail.com> wrote:
> > >> > >On Fri, 07 Mar 2025 11:30:35 -0800
> > >> > >"H. Peter Anvin" <hpa@zytor.com> wrote:
> > >> > >
> > >> > >> On March 7, 2025 10:49:56 AM PST, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > >> > >> >> (int)true most definitely is guaranteed to be 1.  
> > >> > >> >
> > >> > >> >That's not technically correct any more.
> > >> > >> >
> > >> > >> >GCC has introduced hardened bools that intentionally have bit patterns
> > >> > >> >other than 0 and 1.
> > >> > >> >
> > >> > >> >https://gcc.gnu.org/gcc-14/changes.html
> > >> > >> >
> > >> > >> >~Andrew  
> > >> > >> 
> > >> > >> Bit patterns in memory maybe (not that I can see the Linux kernel using them) but
> > >> > >> for compiler-generated conversations that's still a given, or the manager isn't C
> > >> > >> or anything even remotely like it.
> > >> > >> 
> > >> > >
> > >> > >The whole idea of 'bool' is pretty much broken by design.
> > >> > >The underlying problem is that values other than 'true' and 'false' can
> > >> > >always get into 'bool' variables.
> > >> > >
> > >> > >Once that has happened it is all fubar.
> > >> > >
> > >> > >Trying to sanitise a value with (say):
> > >> > >int f(bool v)
> > >> > >{
> > >> > >	return (int)v & 1;
> > >> > >}    
> > >> > >just doesn't work (see https://www.godbolt.org/z/MEndP3q9j)
> > >> > >
> > >> > >I really don't see how using (say) 0xaa and 0x55 helps.
> > >> > >What happens if the value is wrong? a trap or exception?, good luck recovering
> > >> > >from that.
> > >> > >
> > >> > >	David
> > >> > 
> > >> > Did you just discover GIGO?
> > >> 
> > >> Thanks for all the suggestions.
> > >> 
> > >> I don't have a strong opinion on the naming or return type. I'm still a
> > >> bit confused about whether I can assume that casting bool to int always
> > >> results in 0 or 1.
> > >> 
> > >> If that's the case, since most people prefer bool over int as the
> > >> return type and some are against introducing u1, my current plan is to
> > >> use the following in the next version:
> > >> 
> > >> bool parity_odd(u64 val);
> > >> 
> > >> This keeps the bool return type, renames the function for better
> > >> clarity, and avoids extra maintenance burden by having just one
> > >> function.
> > >> 
> > >> If I can't assume that casting bool to int always results in 0 or 1,
> > >> would it be acceptable to keep the return type as int?
> > >> 
> > >> Would this work for everyone?
> > >
> > >Alright, it's clearly a split opinion. So what I would do myself in
> > >such case is to look at existing code and see what people who really
> > >need parity invent in their drivers:
> > >
> > >                                     bool      parity_odd
> > >static inline int parity8(u8 val)       -               -
> > >static u8 calc_parity(u8 val)           -               -
> > >static int odd_parity(u8 c)             -               +
> > >static int saa711x_odd_parity           -               +
> > >static int max3100_do_parity            -               -
> > >static inline int parity(unsigned x)    -               -
> > >static int bit_parity(u32 pkt)          -               -
> > >static int oa_tc6_get_parity(u32 p)     -               -
> > >static u32 parity32(__le32 data)        -               -
> > >static u32 parity(u32 sample)           -               -
> > >static int get_parity(int number,       -               -
> > >                      int size)
> > >static bool i2cr_check_parity32(u32 v,  +               -
> > >                        bool parity)
> > >static bool i2cr_check_parity64(u64 v)  +               -
> > >static int sw_parity(__u64 t)           -               -
> > >static bool parity(u64 value)           +               -
> > >
> > >Now you can refer to that table say that int parity(uXX) is what
> > >people want to see in their drivers.
> > >
> > >Whichever interface you choose, please discuss it's pros and cons.
> > >What bloat-o-meter says for each option? What's maintenance burden?
> > >Perf test? Look at generated code?
> > >
> > >I personally for a macro returning boolean, something like I
> > >proposed at the very beginning.
> > >
> > >Thanks,
> > >Yury
> > 
> > Also, please at least provide a way for an arch to opt in to using the builtins, which seem to produce as good results or better at least on some architectures like x86 and probably with CPU options that imply fast popcnt is available.
> 
> Yeah. And because linux/bitops.h already includes asm/bitops.h
> the simplest way would be wrapping generic implementation with
> the #ifndef parity, similarly to how we handle find_next_bit case.
> 
> So:
> 1. Kuan-Wei, please don't invent something like ARCH_HAS_PARITY;
> 2. This may, and probably should, be a separate follow-up series,
>    likely created by corresponding arch experts.
> 
I saw discussions in the previous email thread about both
__builtin_parity and x86-specific implementations. However, from the
discussion, I learned that before considering any optimization, we
should first ask: which driver or subsystem actually cares about parity
efficiency? If someone does, I can help with a micro-benchmark to
provide performance numbers, but I don't have enough domain knowledge
to identify hot paths where parity efficiency matters.

Regards,
Kuan-Wei


