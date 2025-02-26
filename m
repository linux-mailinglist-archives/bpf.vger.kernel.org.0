Return-Path: <bpf+bounces-52675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE7A468C1
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20433AEF39
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2417E22A7E6;
	Wed, 26 Feb 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STKhS2iH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE142A8C1;
	Wed, 26 Feb 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592797; cv=none; b=Ip1Vx9dU1WA+Ai5aIOSPPVyCXKqgQWX4tDqNQpBNuR9ROQw4FqtKArMXyiDOaaErCrkC4wNGlDD34SlgP3zV3dQgIIYPHSquAqzIFuny0Nlma6Jkbapv1piEwRh70kATsZv79P1kpqIZAk2/MIvUTv2uSjsmzPR6z3/lVvmmIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592797; c=relaxed/simple;
	bh=NgL7kzU8DCxs2aqncslIBjrb2AeIRzc4rI9CzlkoJnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhMuEReKCO3skQuUK5XriM1CQFkBK7WxSmL7gee5rVzI3FpDwRYIE10ZaobqlB9ToZi7yLxvueCpmLdkU332UdxHxVnle6Edfaz+RQ0GPm/jHVFWoOISshnuyW66Cf8+w7SVFG0JRHQBJNU3naQFPvIbu818966X0KF4jOdhvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STKhS2iH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220e83d65e5so623085ad.1;
        Wed, 26 Feb 2025 09:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740592795; x=1741197595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLZRzBzitap92yZk251lvU9DytAtAlhsYa/CQwhvV8Q=;
        b=STKhS2iHxgaS1szjmMC1mTeWJNsONfdDL581017gu22tcyyt6/pp98x+LxU5sC+Sti
         ApQcwWfvuSGIJXAELy8JSaLK+rGLk9IlIJB9LWzC4QMPxQX63mEmxVZ57C1ADkgp5rJV
         t7miUx8BoPH+OqJ0G/lnoXsfLE962k5o2ia0mIZdqGsQQ8cICnvMFJXr5y9hQ0kEiQNv
         RwrQ0PgZlBPiVD7ZIpWCehCGp08qDGmqmjtJwENzTryrRBlkp1PDAEdeCJ9eBVEKFqqM
         JwROLBvRJ4oTDfj0rVD4E3dFf+fcpBvoMnmoudRSaB5bPTwOJZUtK4dO0By5l5DIe0+A
         Pmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592795; x=1741197595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLZRzBzitap92yZk251lvU9DytAtAlhsYa/CQwhvV8Q=;
        b=exEe3HS7wDS2+mCAGN3cC8xcapyR8OYeyd8dsGoMet96ohBS9gBCQmpHz1hGZKTaIq
         saIx4kpevpUHolDoRvnM4CHjeNNZXTJKBwJ4OtQ11Bo3/yQp2NLXCM8Lswa5y3EYx/eo
         p+alN9x7wy1hWmoRX2NI6m4YmG3iVU04mN9RJXhCAExCbC37HkV7Z1F9rKpswwLha/hL
         gKfwnhCarTQ0UvItS3Th9KGgWpAeG3OqPCBlAGky0gC3EMO/PhuQwr/JJjZgnIouOeJ9
         fiS1TzhPZZ1zm+cy63ZFIOQfVWRu2uTxnlPvCKj4cfKD0Hsii0J2VC+5bsEhB5ktbUho
         n4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCULRgjwXSuT2OYBCtx1z6f7dCT6UrjMKx/mSe4c604u10y3Od3tWfkBUoKLt0sd/sEySSLSDvtWfmN6ZrK+@vger.kernel.org, AJvYcCUYkpZJLUpFFiRxT+rj7LmpyE6LyXGenlANFZbRUx4RcYbsgvymibpSQulpwNYQsY/NvrY=@vger.kernel.org, AJvYcCUm3wcStNywyUZJ/3etPZwh0UwnPAbULmh3/Qk0IYMGowykySe6Z5hbKE9YGtE9AWj4eNC40aSvMvRqpA6ZoM0=@vger.kernel.org, AJvYcCUmKDn27OzRO56WcVx6ulKUOZ7iJKbCq1VhRIbxxaHZMm8RRgUXOeUcjF79XubT30Z6RLUrq6l1RYH+B9OE@vger.kernel.org, AJvYcCVjetR3QUCIUBQUkDIy6UNITur4t37hqXa7Pg/yxzVoWosWeFlIWBDXiM2KZT2xOPwdJMq63njP@vger.kernel.org, AJvYcCWKPuOq1tVS4KJUzR1bti82mmJigDRoRQgJB4RJ1/Hn8zFVSx0GkM64PlE/6ybmDlmDwYR66uXh5OGaUxs=@vger.kernel.org, AJvYcCXsG0iIQtQGdfB2KLZCXLgr0Nnff/a3iTew7JQZjpVsPIEbOn/pShV2BPMpwnSG5mOvGDD/Y8Sa0aRDXkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2nWMXe36z8Arjt5pAHCA96iuAbgEi4kls9wIECMYKxAxNLPs
	lloDQKWgH7Qn9oEXOZ5gpjhS1v2amw2+iTTDeWB1TgWG3YPMm+xU
X-Gm-Gg: ASbGnctqVgNRmO//Jb768n8lrIpykAnJPjIjWn8GdWk9oLqAZA9rMkCMayKV0tuluTe
	3k3i0RuhhHIDAGVQNy5ZbnZH1UqktlT3PsvsvdRzVma5fd1yIJUObwfRLvN+at5fp0y/HzL25ja
	7cdXsr8ZmW3/JB/h7qCJcsdX3VIB8tvISEo11S4vtZxkd+EsvQHRvtfTAyD6koKJw2Wp3A6sCmg
	O4E8bOGoFjSGCHDcD98RuHlh9LebUXIrGkL/wTW6jvaupjEo/yxWwT2/3dHQcFeOTy0vAPk6ZLs
	5m1K49BszDaDvwCSmYva19f/J7w5ZdkmzvjITSEikY6pKiSoBOEIkg==
X-Google-Smtp-Source: AGHT+IFPX6/YemPi/DqumfrbMAfmVM+yJTxaN3xhdxU4AjgnAZPzxKGRLUd3gIiPdvk59fs7FScnAQ==
X-Received: by 2002:a05:6a21:600c:b0:1ee:c74c:2436 with SMTP id adf61e73a8af0-1f10ae2ec90mr8029040637.34.1740592795469;
        Wed, 26 Feb 2025 09:59:55 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aedaab2e8fbsm3541850a12.64.2025.02.26.09.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:59:54 -0800 (PST)
Date: Thu, 27 Feb 2025 01:59:44 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
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
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
Message-ID: <Z79WkNp6p06fV/f9@visitorckw-System-Product-Name>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-3-visitorckw@gmail.com>
 <Z7zIBwH4aUA7G9MY@thinkpad>
 <Z73FxIv353lbXO3A@visitorckw-System-Product-Name>
 <b5236ae4-7ebe-4a88-bbc9-3b9b3374de53@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5236ae4-7ebe-4a88-bbc9-3b9b3374de53@kernel.org>

Hi Jiri,

On Wed, Feb 26, 2025 at 08:14:14AM +0100, Jiri Slaby wrote:
> On 25. 02. 25, 14:29, Kuan-Wei Chiu wrote:
> > > +#define parity(val)					\
> > > +({							\
> > > +	u64 __v = (val);				\
> > > +	int __ret;					\
> > > +	switch (BITS_PER_TYPE(val)) {			\
> > > +	case 64:					\
> > > +		__v ^= __v >> 32;			\
> > > +		fallthrough;				\
> > > +	case 32:					\
> > > +		__v ^= __v >> 16;			\
> > > +		fallthrough;				\
> > > +	case 16:					\
> > > +		__v ^= __v >> 8;			\
> > > +		fallthrough;				\
> > > +	case 8:						\
> > > +		__v ^= __v >> 4;			\
> > > +		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
> > > +		break;					\
> > > +	default:					\
> > > +		BUILD_BUG();				\
> > > +	}						\
> > > +	__ret;						\
> > > +})
> > > +
> > > +#define parity8(val)	parity((u8)(val))
> > > +#define parity32(val)	parity((u32)(val))
> > > +#define parity64(val)	parity((u64)(val))
> > What do you think about using these inline functions instead of macros?
> > Except for parity8(), each function is a single line and follows the
> > same logic. I find inline functions more readable, and coding-style.rst
> > also recommends them over macros.
> 
> Not in cases where macros are inevitable. I mean, do we need parityXX() for
> XX in (8, 16, 32, 64) at all? Isn't the parity() above enough for everybody?
> And if not, you can have all those parityXX() as inlines as you suggest, but
> also provide a macro such as the above to call (optimized) parityXX() as per
> datatype len.
> 
I agree that we can add a macro to call parity8/16/32/64 based on the
data type size. However, I think we should still keep parity8/16/32/64.
As Peter and David discussed, the x86-specific implementations of
parity8() and parity16() might use different instructions instead of
just XORing and calling another function, as in the generic version.

My current idea is to follow David's suggestion and use
__builtin_parity when there is no architecture-specific implementation.
In lib/, we can provide a generic weak function implementation of
__parity[sdt]i2.

Any comments or suggestions are welcome!

Regards,
Kuan-Wei

static inline parity32(u32 val)
{
    return __builtin_const_p(val) ? _parity_const(val) : _parity32(val);
}

#ifndef _parity32
static inline _parity32(u32 val)
{
    return __builtin_parity(val);
}
#endif

int __weak __paritysi2(u32 val);
int __weak __paritysi2(u32 val)
{
    val ^= val >> 16;
    val ^= val >> 8;
    val ^= val >> 4;
    return (0x6996 >> (val & 0xf)) & 1;
}
EXPORT_SYMBOL(__paritysi2);

