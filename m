Return-Path: <bpf+bounces-53688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A233A5857E
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 16:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031DC169F8D
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ECC1DF24A;
	Sun,  9 Mar 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb023g5+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9C187553;
	Sun,  9 Mar 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741535318; cv=none; b=X9EU2rh3s0wHOsdD1fq3cHXUVcp/4oydQw9wglR6kRuwR64RPuWgLuxCzzYpPHCidhdTWEKA91ENMjdiBm5ACp+A92/FAuZhYAU1KjERzwxUo5J0eZna4RaKZ7OS6tUV4PRaaIbEqyI/fCw8jiaYYEFl8Q+FIECd8slFBfhtQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741535318; c=relaxed/simple;
	bh=MZaV5bFfAdIoZnKuA7bGyEoUvV44zXeyNZF1dEi9Wnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afl7PP/hCpyWrJgbFMT/jI6XnAU8QLUW7F2KRxQdtkQNlQmuL0uv4z0UeHsNj7XltLH+t9/jKtqqpyMMWnwk02pIXDaOVZ1kPhlb1/6WPLVKSdQbTPg+HeX08FZxRYyHmrvLPssAO1kfC4EceIaaWYziiGLqFl3gfrqRgYDzWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb023g5+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22548a28d0cso26716505ad.3;
        Sun, 09 Mar 2025 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741535316; x=1742140116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgWYE3yJh/lyMxOG1Kh3pm47EvZJ8tal8TpSNO72h98=;
        b=Mb023g5+uVOcu8JaHTjZGuYc8dQUGb/wVTs/U1G88XEsEtxBx7/Wj8Ty8CkC8yVT+J
         BdZ6fnkLlURrUwJRX4rC7jQPp6DmtY4+jAicwx4UMVJfJjBjTe1ezo1EVM8m/9wLUmKJ
         ee+Dr6TyGw04l4wbO/w4cXpr7LAd3lW5Fh8bSdzdDKeDmCQ+S9+SRjvXzCq6wcJI/7za
         AnAkh/gdqPrCRLLrxkI1rMfSPE5JS3EHGdlV+RyYk7x1vZ3VVOHE3OEg/eY7atDN7mup
         QAw0oG4pelFc3Maw7Sf615ybYZioblJ8156NJ4utRyHG6fajLC04GkydO9bQwbFTyvnI
         hIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741535316; x=1742140116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgWYE3yJh/lyMxOG1Kh3pm47EvZJ8tal8TpSNO72h98=;
        b=Pqv3uRiGlV3ev4ZcwEF+WcwN8B4Hp8juSQT7spaHUAKBgzAuUyitasnLhzaESIHjWw
         eUgfCeYoq2hyhJtgI0TyjobVqI1uFtFe8iOvyGKl37uqGT7NcovOlC2LO9hTyvV4FTA5
         3MgDDF7KAAQyDvOscQpebyVcqjAR6R6ZARjUgH5s7nkF5pHF7NH+z8iBoaC9JKLiZge8
         LV7CXI4uneecMIbvSrjviMgmtz/asp11zRGmxU++gNA+0C44p2k53Tv5CZu0OfseXk8j
         1JnwDdqVJhk7pt84iF1UCUl0qcSbgGZfXxWCS2lipKL8Bu2WgoDx40om39Co/uewXAW4
         Yh2A==
X-Forwarded-Encrypted: i=1; AJvYcCU2AyOYYGPHyuCtEvToDyTh++J5CGi1PAJOuvquBZ5d2TblOsc9bntLZ8YbvE+/djtz3j8=@vger.kernel.org, AJvYcCU4pg3pNI7VHUVHVgW2RKUa/fC9c1vtfHJlIDzHFQjl+jK5+71dY3ZyOY1LUXf64Yee26PK+/D4AQSZMRg=@vger.kernel.org, AJvYcCVJMUgq74EXFJ/VwSIPwRpytXRtj75iItGP0PyCngj5oSH8geGV6nw+LTGyCqWooef3XfwjRuLsY37E0tHZ@vger.kernel.org, AJvYcCVoKoie5ul0b6aPB4wgHhZ2b3FeRUruXSxo2lm+8impw6ZYLD1Zu/oeM3JyawAf9CsWnWJpeXNT1JGt8f67cHw=@vger.kernel.org, AJvYcCWHaRiWhpd/2y51eN0MJta1AnNGXlia1FjTG3VcbzIErarf0bNemBs9yGi9aiYF+RODTpHfZBTh@vger.kernel.org, AJvYcCWP9Ru2tIayFmZ5dmlEyPexnMjZY6f7IIUb3226Tm6C9y2+FqfZZ/0p3Fcxlm27x90J7kTWdiY9csubW7GZ@vger.kernel.org, AJvYcCXj496AsOOfUgOODYdVPyaMuvdsBfdH5CV6K1mRsdRMyzPmbjN3h9aO6tjKEINuTipMxERJDD6h0KKIMqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDKdpiGpXBu3SOZFqr+G2hQ9rCQT0d38bEx96xcpPcQPqjXWk
	/WGWkYoMe1swKYli1/7Q/MdtRBIrQnksnGYO5F18JZtT5zH6KdyI
X-Gm-Gg: ASbGnctgNXMqR6S07sqK/jkbaSWOD0riZjOuMBT7txahX53pwMeiIyLHvOy9KBu4942
	WbEZtfs0oHzVWdFZj6PhWFro01rX1kuGjpLrz2ynzCWKcpLOcNiY3XKpwNVn8fFtzVpUUMwpTNp
	LfWdE/Y9e4efXxLA/TfcegRpygZ/FQYZcGoe4J/9PIkMI1yy8E2on/coDaqFPczpccjLQ+sBsBz
	L2kh118ZeQghJSO/n/wUGBA7LKOno++S6sKdaQ0qBisDrGT28F7D+4E8IofOo54LJd0S4iMJLve
	5XuTIeQrNhQ9SLXEfDbt5CpAKUGoNhakQ+IHXaF6rkKwggLKopjPx0JXINoRZ9GFQaEhy+K+
X-Google-Smtp-Source: AGHT+IEkPjdlZsP28acQWQx0Qye7i9usm3kNOW0i6DfYwW0Xas+u0oor8hXm2eg176ewgjMSRnRBqg==
X-Received: by 2002:a05:6a20:4328:b0:1f3:4661:d19e with SMTP id adf61e73a8af0-1f544acd6ffmr16482561637.9.1741535316400;
        Sun, 09 Mar 2025 08:48:36 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2894e3cdasm5384249a12.24.2025.03.09.08.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 08:48:35 -0700 (PDT)
Date: Sun, 9 Mar 2025 23:48:26 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Laight <david.laight.linux@gmail.com>,
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
	tzimmermann@suse.de, vigneshr@ti.com, x86@kernel.org,
	yury.norov@gmail.com
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Message-ID: <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
References: <4732F6F6-1D41-4E3F-BE24-E54489BC699C@zytor.com>
 <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com>
 <5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com>
 <20250307195310.58abff8c@pumpkin>
 <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>

On Fri, Mar 07, 2025 at 12:07:02PM -0800, H. Peter Anvin wrote:
> On March 7, 2025 11:53:10 AM PST, David Laight <david.laight.linux@gmail.com> wrote:
> >On Fri, 07 Mar 2025 11:30:35 -0800
> >"H. Peter Anvin" <hpa@zytor.com> wrote:
> >
> >> On March 7, 2025 10:49:56 AM PST, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >> >> (int)true most definitely is guaranteed to be 1.  
> >> >
> >> >That's not technically correct any more.
> >> >
> >> >GCC has introduced hardened bools that intentionally have bit patterns
> >> >other than 0 and 1.
> >> >
> >> >https://gcc.gnu.org/gcc-14/changes.html
> >> >
> >> >~Andrew  
> >> 
> >> Bit patterns in memory maybe (not that I can see the Linux kernel using them) but
> >> for compiler-generated conversations that's still a given, or the manager isn't C
> >> or anything even remotely like it.
> >> 
> >
> >The whole idea of 'bool' is pretty much broken by design.
> >The underlying problem is that values other than 'true' and 'false' can
> >always get into 'bool' variables.
> >
> >Once that has happened it is all fubar.
> >
> >Trying to sanitise a value with (say):
> >int f(bool v)
> >{
> >	return (int)v & 1;
> >}    
> >just doesn't work (see https://www.godbolt.org/z/MEndP3q9j)
> >
> >I really don't see how using (say) 0xaa and 0x55 helps.
> >What happens if the value is wrong? a trap or exception?, good luck recovering
> >from that.
> >
> >	David
> 
> Did you just discover GIGO?

Thanks for all the suggestions.

I don't have a strong opinion on the naming or return type. I'm still a
bit confused about whether I can assume that casting bool to int always
results in 0 or 1.

If that's the case, since most people prefer bool over int as the
return type and some are against introducing u1, my current plan is to
use the following in the next version:

bool parity_odd(u64 val);

This keeps the bool return type, renames the function for better
clarity, and avoids extra maintenance burden by having just one
function.

If I can't assume that casting bool to int always results in 0 or 1,
would it be acceptable to keep the return type as int?

Would this work for everyone?

Regards,
Kuan-Wei

