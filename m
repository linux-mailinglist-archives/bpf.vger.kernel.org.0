Return-Path: <bpf+bounces-52782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E1DA48743
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF71886A96
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C42F1F5820;
	Thu, 27 Feb 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXhWdZT+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1B9199239;
	Thu, 27 Feb 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679537; cv=none; b=YhdjqBQZUKT1Qrl+Fcr2004Q4olIvQod7hUAVDQK/zcg697uF16zMHzuxtjDya5qnI+9/LPv/n6UHXVSzlgvq58kTaWCV/GTPIJI1lAa/L9S8WgYgM62M8+KK87rSQho/Kd8A/+BlU3ZjhFP+EXsIr8TRC4+urT/u0WYlKXu490=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679537; c=relaxed/simple;
	bh=OqW0tsQmgxjdGZPx5rAhLoVP8V4pb2gw1BYl3oruHT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgDV0vBNodeEfsiCl+HwZUeMnFVnsjwphR1i5TMLYKxZRc5oZLY2mxWZ7ciZ3E6Bvu7gjywfmmYbN9pSqAKYHHiHnw6/FKrjGaWQsg3B9HM6kJqjO8esNBOYF0v/GiYoJzrh0QMAOvKM2xQxApaDoQ16Wu9O5ql4DjVWuOYGE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXhWdZT+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22128b7d587so26093375ad.3;
        Thu, 27 Feb 2025 10:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740679533; x=1741284333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlMEi7Una8TwxGaYzKJCUvFP5cGs/B6xguOFMjaN1Ww=;
        b=WXhWdZT++ZKFUZZuuaJgXszFfZKOpoSM/O04xrXT+dCiWQGM5+73jDujpOsXqYHnKM
         g9/PD2QiA40krUYtxjZWSMrDKF8TY2xBMgm7YbMLnErz8J87FgcVKACbY1TXCUEUvJfH
         5eJzjYEsqQ8OSXuU6lmpWcoLkpjFNoVNMmTNdg4SBcbdwMFO+WheE7bsRe3xutyyaUZZ
         taI5ldwnLBniPDkCI6+dY1H/Ccn1j3HsEX78vXmSa748gAFparbsKHEu85Y/qSi1Gna3
         4aW08JbW6UXbf9Hwv9j2WB+HICj7SJhR9c8WoDWGn3zIPHxTzEaQ+Pz4/nZ6NdhtbPsC
         GO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740679533; x=1741284333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlMEi7Una8TwxGaYzKJCUvFP5cGs/B6xguOFMjaN1Ww=;
        b=XtaUh+eB/z5dw3gFcWewVPWWyW9dDEBIj4Stz2ikvwqJ9pwiBO2poKzAMupGacarG/
         OJ+Fr6okO7zh+TwrXVOE9Pf9FhVc0XA50QIwc3u67zmuPEZzw7cXBtD0EAK5hTaSmK3u
         MtfbBN0LQIGg54C1IuoZoG0GKVhl+bD2+ixE4GewvmvdFEpAJNm9+xD2D5gmMhJ4Azfa
         5W/ybXTiMZcw3KTB06QugZhaBl+CbReqnK6l6z6DCgBmiReNiUT1+sM6KDM96CPV5l6i
         5i05+OxTX4ypaTpKpg0PlxHXtcwgtB5zO2YFUqncXo7gkslh8yCebX8vE/P6kCstbBk0
         9hTw==
X-Forwarded-Encrypted: i=1; AJvYcCU5z/4n8RaGNON2r6gttDPg27P4q0C9P//6AU4aB9ov6a2FmHm31ZUdPI4Fg/z6edP63ud/jxUu7M8etbY=@vger.kernel.org, AJvYcCUloTK7+5mLRr2JHYPKOeUnb8UWf6nax04Na2odSWkSdxQxVJ7u2M9NAarAqkbf544jVG+QGNZQPs9XlbWE@vger.kernel.org, AJvYcCV/6edSUYe4Icqo5rO05+Z99SWddner0zPXeZ8D9HMIBJc8u422XI/osqfAA/62fjnKkXgDKnxtSPUCiChJ@vger.kernel.org, AJvYcCV5O7ONXrrvXoiTzUhbga9I5ODFf6ZHJhOn7MBWLUFZ5/sJyFxAAsjycGnRmQ87xuaaFFEpfg7jDDWhnz0=@vger.kernel.org, AJvYcCV8w1FFuhbgINSlUhDwMbMZy6CminDJrsTdG3rBs37YjQEYm9w3Uv/QazZLDf9gqehte3j72SXY@vger.kernel.org, AJvYcCWvei9fQ/+f3Dd4L/7BpHlby/dVl5zabazVEZAzB0yy7FQoO9UgEFDIJjv/VgrADJUYQ4Q=@vger.kernel.org, AJvYcCXt4G3iGa4Zy6O0GWfwK+HOAXLDaDQ5xs0ZBAEr/2Z5RfZomVUKO/4DLbPIEwOA2kQwpgt9HKgKVacBtTpbK2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6G+IvkEVXjMvp/tBK/0KlwVtCFA9kKLVE5Myw4gs4IOSBozeo
	uM7adgKhJq3kBiUzCdGvET5MgYrLHz66E/yxOCl3nEDAHFcOVwj8XmRDEl1zBWQ=
X-Gm-Gg: ASbGncsfecPtMrsqPwlsOOrIlawfEP9l0pIAU68Oze4g1QwD1iNdNo0Yj5sd82ISFLm
	uzjGLjD73igTHNmT1gAYRgNBKFaPr7Oz4Z1Devhv8o+iqguu58i9CdXn+IjBtBppvw3NZXw2mS+
	aKQHO0WRgf/YXNU75qW2ooaNk9SFhRER3eJodMc3BOux0MAz6MX6DmhPpj+GIeXRF4LhnH+3Et4
	Yf5T776+KRyLSUMVYJkujEIQ3v4CzJxbz6Pc2Tl8GVvwAN1R2ZBeVIn+sNQIGBgtx8QhtSN+5GO
	z50GVUK/BrMVMfFbICctl6UMukYAdnpvlOIhx6AGrQuO0/2+kQ==
X-Google-Smtp-Source: AGHT+IEnEhzc2owT1KH+D6qO8Y01zbjbSELOHxZjQy0YabJgdb+peb2Mulxfa+PI8nU5R7zu0Cxkog==
X-Received: by 2002:a05:6a00:806:b0:732:2170:b6a3 with SMTP id d2e1a72fcca58-734ac44b986mr473864b3a.21.1740679532704;
        Thu, 27 Feb 2025 10:05:32 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a00600e1sm2015088b3a.171.2025.02.27.10.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:05:32 -0800 (PST)
Date: Thu, 27 Feb 2025 13:05:29 -0500
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
Message-ID: <Z8CpaaHv0ahHFVuK@thinkpad>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-3-visitorckw@gmail.com>
 <Z7zIBwH4aUA7G9MY@thinkpad>
 <20250226222911.22cb0c18@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226222911.22cb0c18@pumpkin>

On Wed, Feb 26, 2025 at 10:29:11PM +0000, David Laight wrote:
> On Mon, 24 Feb 2025 14:27:03 -0500
> Yury Norov <yury.norov@gmail.com> wrote:
> ....
> > +#define parity(val)					\
> > +({							\
> > +	u64 __v = (val);				\
> > +	int __ret;					\
> > +	switch (BITS_PER_TYPE(val)) {			\
> > +	case 64:					\
> > +		__v ^= __v >> 32;			\
> > +		fallthrough;				\
> > +	case 32:					\
> > +		__v ^= __v >> 16;			\
> > +		fallthrough;				\
> > +	case 16:					\
> > +		__v ^= __v >> 8;			\
> > +		fallthrough;				\
> > +	case 8:						\
> > +		__v ^= __v >> 4;			\
> > +		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
> > +		break;					\
> > +	default:					\
> > +		BUILD_BUG();				\
> > +	}						\
> > +	__ret;						\
> > +})
> > +
> 
> You really don't want to do that!
> gcc makes a right hash of it for x86 (32bit).
> See https://www.godbolt.org/z/jG8dv3cvs

GCC fails to even understand this. Of course, the __v should be an
__auto_type. But that way GCC fails to understand that case 64 is
a dead code for all smaller type and throws a false-positive 
Wshift-count-overflow. This is a known issue, unfixed for 25 years!

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=4210
 
> You do better using a __v32 after the 64bit xor.

It should be an __auto_type. I already mentioned. So because of that,
we can either do something like this:

  #define parity(val)					\
  ({							\
  #ifdef CLANG                                          \
  	__auto_type __v = (val);			\
  #else /* GCC; because of this and that */             \
  	u64 __v = (val);			        \
  #endif                                                \
  	int __ret;					\

Or simply disable Wshift-count-overflow for GCC.

> Even the 64bit version is probably sub-optimal (both gcc and clang).
> The whole lot ends up being a bit single register dependency chain.
> You want to do:

No, I don't. I want to have a sane compiler that does it for me.

> 	mov %eax, %edx
> 	shrl $n, %eax
> 	xor %edx, %eax
> so that the 'mov' and 'shrl' can happen in the same clock
> (without relying on the register-register move being optimised out).
> 
> I dropped in the arm64 for an example of where the magic shift of 6996
> just adds an extra instruction.

It's still unclear to me that this parity thing is used in hot paths.
If that holds, it's unclear that your hand-made version is better than
what's generated by GCC.

Do you have any perf test?

Thanks,
Yury

