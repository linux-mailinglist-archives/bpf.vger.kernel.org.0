Return-Path: <bpf+bounces-53964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9858A5FB98
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C480170890
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1E26A0D9;
	Thu, 13 Mar 2025 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfgra5tU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4C2690E6;
	Thu, 13 Mar 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883084; cv=none; b=FRM+q+ANf7FThtbcNNXSVJtJ01fyahCaQaXyd1Bo47SyFJQVDhFS946yqoAYT9Ybr673UPYLG2jkMgqDv/TXFTjxU298mwlFnYnhqT6EISTgWCijgwll0Ipgch6U9LEdyiIhqUruXQDEUP8u5SooA9oF0dzf1kyX7fSmzM3nbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883084; c=relaxed/simple;
	bh=qRKmvdz41Z9reFxLxCZQ5RSEmJTdaZd8ctgs5m87/cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8QrlLM1alUUg/I8SBoygQwS5VkcNC5IITPGcDNppFscESx3muC15P4A8zzUzd5f+uWOrUyo5s1vW/SYQAZS8dKaM2mfoG2MtkC/EX16LOLlcX6o0Zi2i9uGmTAMZiZnrcw8jD8MX6GSZqLe51Occo1shzjGVMd7UUi1TUBviZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfgra5tU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22337bc9ac3so24733415ad.1;
        Thu, 13 Mar 2025 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741883082; x=1742487882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfjeDfcFtBUkNo/zS3F1TWi9ohbnRv2k3DpKMTE74P8=;
        b=Bfgra5tUYaxBQx2HPm502vUBmU7+dQuyCk/r0b2QoKLZNGYc7uqoVBLUJkcQDnykDm
         4gAAW7gkKEnTWK3KSPZ5j8lRDH/eg+hYOBd+wovTXyI4ttOyUg1hqg298pehyKIpB3+2
         Ld3NKA4DX0P252IZbXFIRBkoqa2xOAaakKXW0HrxFsGaOQX94kjpNDXbIvVS7OVURaNN
         6y5yv82rjwZ2yaFzkQR4nCkvVHoaHbPllj04xnK7Njfq1zKhSYpQgYsr/QDp6yZlIQR2
         L6tUhxGaHTVZQYWrt/IEmMVCdp+rYnZUye02wHx5O3Ev83bm7frolthpmeco/t4k7Tpg
         ezQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883082; x=1742487882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfjeDfcFtBUkNo/zS3F1TWi9ohbnRv2k3DpKMTE74P8=;
        b=P6BTkGekvAp6UHjUez47VmZ6MKEpiJnW05QstSM4O7TbBzpjc65xHLF6xj+WFr1e6S
         c0SzRgu46HI5VXLi9TJKw3u5Yy7ycAYlmcduQ48QoFOQBiFMELU/K6ppL8rkXfYjCVES
         /q8i5QPfQttux0Y5dl+ydkswf+HykZ3HrBg32IXX0jrzxeM/1ZlGyHuWvNPd5vbyUnWr
         MMoKb8dUZwpO5Ss6IKs9jOFGD1vk+wmeF3AOwuxASl6hGEwSM9Q+prg1PVL0oiwXyDEt
         bHDRowq41Icuzr7vmnTqi4a+g3vUkXlcPj1QMxGg9kX4LKz6BiESX8OoKfaZXZ5JB6uK
         3KjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIypO6g9Xjot2MA4TGFHP2lcXACBMjtgY065dtLk2H5TWNm6Hw15FxWO74hgrDMvf+tkJZEUg5Sma8K3cT@vger.kernel.org, AJvYcCVguatFknKpHaQ98RQZGZ23PiIb3R0W21ldgnqUX8Os2k5Oqosx7GyYMwE+agBI5d+64MgB2EYG@vger.kernel.org, AJvYcCVuxK/jzeR9cGqYGJ8iE0nv8syAGwi48qrnMwr3iuRQezblEIgJXiNfswl+D0JNOFs7gWWN66WNI8BTOpEw@vger.kernel.org, AJvYcCWZzDvT/xItXfL+IntLocj/2iacIqLa5N1PR4Qw3F/aqpdyblIlt/uXl2QXHwoxyNutDDF8iDVao/lsPa3ieBU=@vger.kernel.org, AJvYcCX08Z+A7o1VEEUw1w4sOBgfBkcRGn6KCVEP1hj9dNgnXnuun3UFkCITCfer0av5rpRdnS4=@vger.kernel.org, AJvYcCXAXy7F3M6EbHyVwETvOwzQepHXX0HT9WyO3Q7NeNctlbL/UGjxvPb4wSpwb1ilGyVWsj6/JMp6jjB3Ofc=@vger.kernel.org, AJvYcCXCzPWCd0cDCj+PHQdZbFhCgjhWE/nxI/Wr8fd4CsQKYY7kI3Ot/PH3RmCmIlv+Fns5Ahc2kymNPg/1jgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5R8FJFARqP1rqOx/CdZ3czOKdTiuvPdq8T6yNMFeJK7fkyPgb
	210Uepht7Ia0o4U9byDyAsCNq7pCAEwDAc8zZEZHxAEEy5NzE7YH
X-Gm-Gg: ASbGncs3yPmPEOogCuMN0UwGF58b2+UIpeO76YXNsTOMuT65oiMvosmJ5Koau6vcfi/
	6ZOcQivqV4g+MPiR1M2RWwKkG+WcMBQ/Z1rtiG8zyMrFhF3FWU/0Cz5IHuc4sVN6QQ2nW6dmqTg
	oqHDgkpHa4Au76oX19z6VhtR2Wd0Pzt1FQNc8GX9submCxsJmqNZ3J3Fn2Jg/k8Bz5z1biuaTgw
	M3XZLB3aF7XVq4de1AYaDSqN/fJyexS6o1IgTw+HO214FXKpTYJJh0xUrpV7ZRDKZoCnUpchPDK
	y/5/bRo0PKXxlPk3XUrje7T8LeLw19fiJFQT5DWvR/BZQjKbhO3h14I=
X-Google-Smtp-Source: AGHT+IEhm2UlrxnESPtEwBvMI/fgf4613dWJojNHjH0dA0YyQIoHXBBX22mwSMAlbcl6B7SrptBmaw==
X-Received: by 2002:a17:902:f552:b0:224:216e:332f with SMTP id d9443c01a7336-225931ad2bemr163943215ad.48.1741883081419;
        Thu, 13 Mar 2025 09:24:41 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbcba7sm15241975ad.173.2025.03.13.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:24:40 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:24:38 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
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
	akpm@linux-foundation.org, alistair@popple.id.au,
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
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
Message-ID: <Z9MGxknjluvbX19w@thinkpad>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
 <20250306162541.2633025-2-visitorckw@gmail.com>
 <9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org>
 <Z8ra0s9uRoS35brb@gmail.com>
 <a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org>
 <20250307193643.28065d2d@pumpkin>
 <cbb26a91-807b-4227-be81-8114e9ea72cb@intel.com>
 <0F794C6F-32A9-4F34-9516-CEE24EA4BC49@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0F794C6F-32A9-4F34-9516-CEE24EA4BC49@zytor.com>

On Wed, Mar 12, 2025 at 05:09:16PM -0700, H. Peter Anvin wrote:
> On March 12, 2025 4:56:31 PM PDT, Jacob Keller <jacob.e.keller@intel.com> wrote:

[...]

> >This is really a question of whether you expect odd or even parity as
> >the "true" value. I think that would depend on context, and we may not
> >reach a good consensus.
> >
> >I do agree that my brain would jump to "true is even, false is odd".
> >However, I also agree returning the value as 0 for even and 1 for odd
> >kind of made sense before, and updating this to be a bool and then
> >requiring to switch all the callers is a bit obnoxious...
> 
> Odd = 1 = true is the only same definition. It is a bitwise XOR, or sum mod 1.

The x86 implementation will be "popcnt(val) & 1", right? So if we
choose to go with odd == false, we'll have to add an extra negation.
So because it's a purely conventional thing, let's just pick a simpler
one?

Compiler's builtin parity() returns 1 for odd.

Thanks,
Yury

