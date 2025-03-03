Return-Path: <bpf+bounces-53096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1734EA4C57D
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206D8164781
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15E214A68;
	Mon,  3 Mar 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSW77dWK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605842139AF;
	Mon,  3 Mar 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016612; cv=none; b=dkwE+/hO3qoN2tnhMdZbHk6ZBABzyH1FzRGiPG/mnJQZtO9YbVBJZVTimuw8aLDItw67YYQh77y/TtT63FTpL/4at0Fi5OLN34uFEAPJBDZPvESGnNgLqXyrTJ8UaNvcjUmwJVVq8OPs4V3RTEeOAHuBbSvQGUFNLbcEmVuXf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016612; c=relaxed/simple;
	bh=e7sJsPxftEmqUF7aflD0iSt9xRNb7hVvNLp83A2uWUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExVFCEk3QObOG23CBGVE9CQ+dIXpODx875OUJ69brDh88WtbHsDemGJT3JscIT4YgPGcT7i33IzCNzVeG2LXl38mXx48IHgkpBkS4ZmE2bS5EqIlAUOVGyyFnCX+pw3J6e30mguxNf5xAWaXekArCQ4YKcb3HDHlSBQXcP60ihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSW77dWK; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e573136107bso3977622276.3;
        Mon, 03 Mar 2025 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016610; x=1741621410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bze7IhHFHWNKOAl2fnuzVpo5poDDbwUFQZHYPw6zzY=;
        b=MSW77dWKKqQYBCIuYbBldZvCWQBURrH6RSVrIpNFTXQSNAP7HH5YYJrPx+oEZsrdal
         AJJ/Dp6pSCBg5xQAmfjt8AbIB/Ru2EHASncEWqc+mDp2tBsoZEsvdspUoiXTr6dbLQw3
         Zx/BWpGkWqYOyn5zaSBTQPmh5p6QHYu38ngl7XR5DplVvGJ59jjKjx5DLqH1FEhvtpAY
         C64s2i6WEX0OwGpDMoRa1IdwAY6m11d+l0BvuO37W5Zh/1Azd4BaV0xD+BHwh7gAEySw
         unppoE5n41e4q8VzquI4rsEbHpLcALTV8QSy6fPgQYrvY8VL4EMhaS0OsYu6qicd9998
         PKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016610; x=1741621410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bze7IhHFHWNKOAl2fnuzVpo5poDDbwUFQZHYPw6zzY=;
        b=EiUtULyDpYRQ+yfdIBJfNTeqnI0bBvc5V1w0ZgIowNt9JGpHwusoFifqDDQJ/XiQBN
         43brz++vRCbEklJMo0K02zsqg93YNfD3aLkCvTzr65rHTzUVwlq4nNPYQiGTR9g+oY6Q
         J06V5D4elFSTqLoCRiqk70miDfX6gPL6TiCDU0UpPyc6PChH4G1sLBjWa76TQQwEyvgQ
         sB9QEvv25Ds2xm0w6QiXq/AOm7erpa/e/LASrmPwGCO3mIflD3rB7NGUI+sVX5hPXer0
         XMAzMLyXlfUTGUnprzVzc760duAh3P0ezANQwlNAIHds7p+d0WbZns2lFG3CibumdWXx
         CDSg==
X-Forwarded-Encrypted: i=1; AJvYcCUk0EY4SyY+CBSnHkpMue+TW7MR6YurwPNARyZPugnTJ703/lk+qdlXeoRDi9b154cN4NTb9fKBBfvSxaev@vger.kernel.org, AJvYcCUufWErN3Gf00htD+wfNx9QI9cawDBSnrSoCjxOcqvxWh6ktM+UxaqYV7HY/9Jn0cihRWj0SYbejtQ1AQI=@vger.kernel.org, AJvYcCV/+iOOOuu0W9J+kT3Cs3tvrtFo47/1e5iFESbpxTcrHJPKr6XWA78G25EWs91vxFfK6VpwrKZJFVot92VF@vger.kernel.org, AJvYcCVwXglx0EYn6ych4MDvm+FVjj+GP6U7yr5Gczp3p9dOe59l24rXIazxaFl4ZccKVqaLMEE=@vger.kernel.org, AJvYcCVzsCt6v/AmeVJEFvrZ8np9z9XTKcM6tIbiiHxhTPvkWNoEna9kjiAqmzJVsa7VxV0C8KgS7iQq@vger.kernel.org, AJvYcCWf2jjqoAAp6NwYStaHivhIRe9Wf/N5wJgTgM8/iMUgTkZK9D07Oeh4AdC8dGMSv/t1n33CCD+DaUqKl/w=@vger.kernel.org, AJvYcCWp9r2FNMe/rI1ykDlUp1KmUrHGzr0Yc47cUQ46MEROr0H588FWgOnw7DOL3vSZk3wyvwrhRfBku7AZxmzO54c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUn2XbWOJQXhaNQCWR4qFUNUmpoVGpbUCPlMPEO9/HVTOzoszU
	ScZmqg9yFDIeuAoctMssqO9YeU+FgJo/ewPtAMp1YyYGbuZsCxbS
X-Gm-Gg: ASbGnctxP0Saxc6TV060unwXbNIKhKfp5hTYXxNYSphjEFdWzW0L5wjh1WJ7/dkhFal
	y8hUSXoh7LtRD2uHgVn/YGKaakCZBAv9UMrwkjz07A1pU/JLgSrwzR0FKqMW+NS+s4bz8zmgI4s
	DpJ/6rR9Rt0XN3pkXWrqye7wo4rCuUyCB8IWBFP+eCdEfz9rQY9/7xPpgbm8yitJ/l4G3nq9eW+
	Mnd+n5IAliOCRz3nu8J92//c6myisor7K8umsunF0BNYBcg7xSfVCrofIAqUkxHNIMeWtdZKKdd
	YK2vOa8Hu7aOO3qLeDLYtnnP7Ji6oetnuDQYCk/SQROBOLhOUvaWGESjX3AgBVSQ167r9MstDwA
	JT/Ep
X-Google-Smtp-Source: AGHT+IG89LZIvDJlj/3HacLk9/vOGUR8YR6jlY63nvw+Gy77ela/IFHbq/QbvXbn9Hpv7+y9TBQguw==
X-Received: by 2002:a05:6902:2748:b0:e5d:dda6:d25 with SMTP id 3f1490d57ef6-e60b2f5f1d5mr16067385276.45.1741016609877;
        Mon, 03 Mar 2025 07:43:29 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3a20448sm3017480276.3.2025.03.03.07.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:43:29 -0800 (PST)
Date: Mon, 3 Mar 2025 10:43:28 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, tglx@linutronix.de,
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
	andrew.cooper3@citrix.com, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 01/18] lib/parity: Add __builtin_parity() fallback
 implementations
Message-ID: <Z8XOF2DMMRKqam6R@thinkpad>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
 <20250301142409.2513835-2-visitorckw@gmail.com>
 <Z8PMHLYHOkCZJpOh@thinkpad>
 <Z8QUsgpCB0m2qKJR@visitorckw-System-Product-Name>
 <Z8SBBM_81wyHfvC0@thinkpad>
 <Z8SVb4xD4tTiMEpL@visitorckw-System-Product-Name>
 <20250302190954.2d7e068f@pumpkin>
 <Z8UYOD2tyjS25gIc@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8UYOD2tyjS25gIc@visitorckw-System-Product-Name>

On Mon, Mar 03, 2025 at 10:47:20AM +0800, Kuan-Wei Chiu wrote:
> > > #define parity(val)					\
> > > ({							\
> > > 	__auto_type __v = (val);			\
> > > 	bool __ret;					\
> > > 	switch (BITS_PER_TYPE(val)) {			\
> > > 	case 64:					\
> > > 		__v ^= __v >> 16 >> 16;			\
> > > 		fallthrough;				\
> > > 	case 32:					\
> > > 		__v ^= __v >> 16;			\
> > > 		fallthrough;				\
> > > 	case 16:					\
> > > 		__v ^= __v >> 8;			\
> > > 		fallthrough;				\
> > > 	case 8:						\
> > > 		__v ^= __v >> 4;			\
> > > 		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
> > > 		break;					\
> > > 	default:					\
> > > 		BUILD_BUG();				\
> > > 	}						\
> > > 	__ret;						\
> > > })
> > 
> > I'm seeing double-register shifts for 64bit values on 32bit systems.
> > And gcc is doing 64bit double-register maths all the way down.
> > 
> > That is fixed by changing the top of the define to
> > #define parity(val)					\
> > ({							\
> > 	unsigned int __v = (val);			\
> > 	bool __ret;					\
> > 	switch (BITS_PER_TYPE(val)) {			\
> > 	case 64:					\
> > 		__v ^= val >> 16 >> 16;			\
> > 		fallthrough;				\
> > 
> > But it's need changing to only expand 'val' once.
> > Perhaps:
> > 	auto_type _val = (val);
> > 	u32 __ret = val;
> > and (mostly) s/__v/__ret/g
> >
> I'm happy to make this change, though I'm a bit confused about how much
> we care about the code generated by gcc. So this is the macro expected
> in v3:

We do care about code generated by any compiler. But we don't spread
hacks here and there just to make GCC happy. This is entirely broken
strategy. Things should work the other way: compiler people should
collect real-life examples and learn from them.

I'm not happy even with this 'v >> 16 >> 16' hack, I just think that
disabling Wshift-count-overflow is the worse option. Hacking the macro
to optimize parity64() on 32-bit arch case doesn't worth it entirely.

In your patchset, you have only 3 drivers using parity64(). For each
of them, please in the commit message refer that calling generic
parity() with 64-bit argument may lead to sub-optimal code generation
with a certain compiler against 32-bit arches. If you'll get a
feedback that it's a real problem for somebody, we'll think about
mitigating it. 
 
> #define parity(val)					\
> ({							\
> 	__auto_type __v = (val);			\
> 	u32 __ret = val;				\
> 	switch (BITS_PER_TYPE(val)) {			\
> 	case 64:					\
>                 __ret ^= __v >> 16 >> 16;		\
> 		fallthrough;				\
> 	case 32:					\
> 		__ret ^= __ret >> 16;			\
> 		fallthrough;				\
> 	case 16:					\
> 		__ret ^= __ret >> 8;			\
> 		fallthrough;				\
> 	case 8:						\
> 		__ret ^= __ret >> 4;			\
> 		__ret = (0x6996 >> (__ret & 0xf)) & 1;	\
> 		break;					\
> 	default:					\
> 		BUILD_BUG();				\
> 	}						\
> 	__ret;						\
> })

