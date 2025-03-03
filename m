Return-Path: <bpf+bounces-53095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F0A4C563
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3FB47A17C4
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C849723C8D7;
	Mon,  3 Mar 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXKPjZjF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDC21771E;
	Mon,  3 Mar 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015525; cv=none; b=KuLmpKw7pDXXECSU/H6nKMg0/RYZ/yXMFJZCFfpLEVt9ECujcerCetbWujOxu/+GYXEMjbdURWQfl7ApYFQzCy+9UuhUL3k8vVPOIVZgqPq9EEmmGPSAevCWmOqA1yW9JIZAoMzvG/dcNmVb64//hLb5gh0lkwK7n8fInp4xo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015525; c=relaxed/simple;
	bh=w/rH0xuaifnie3Y246Xozhb3kLqb2kCavS2PIlqeo3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnEOyXrtfU2kr6xH69AExL5IZD+9dszoNU8GVhppoe//HcJKvYwR2qch3gVTkSJPYpex+jouYNbCHXI2dCXz0Wi6GNKoDB6kNR8l5DP2Wm9kxk3U6HcqmGCRVVHqTuSPquC1fnog+5cCMrRWlMfBRNUcsFoEVcFRmbIHhXESazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXKPjZjF; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e60b81c29c5so1981111276.1;
        Mon, 03 Mar 2025 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015522; x=1741620322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCKvwZ5J/h+SCwpYc01AHUjT/aP2XxgC1fqBQTrA6YI=;
        b=FXKPjZjFNGjB0G079Ckr+zZ4eDbEMBku7vIYbtxscJYsgBwICpT9il7o6FERHrofSD
         yaG2VetGZJdvOPVETQVjTQJg45qC3/yOU2K9vmIbJwtNlmkrgncHhv+KZWfiF4jzezWv
         DieUo/s8MQcyV4gU5SEO7r0g55iZJQnUzy9+T0mmAZJ6pIm3rioSOJgHP8jEKiwRY5/t
         PcM5nQrb76F9/01FLPfZB4yPJl5k7zZWSvByVLvjxQPLQB+38h5n7nZ8BYcCEjTa4UAc
         8KxHCf9zmysdbWy/rFL3U7NP7JueON9iy45BEtM504J48xydJCYDDiD5lH4i00Gv9snX
         MFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015522; x=1741620322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCKvwZ5J/h+SCwpYc01AHUjT/aP2XxgC1fqBQTrA6YI=;
        b=YWA5uHUbR2fiGffEArw/kcSO/tL8U8aT77DjcIX0qsZ+BWDQP8DJdRjp+mpRuz1QxS
         mDsJ56Hd3Av3S1SLfqTESQTOyOKrl4J/9EueF17q18seQ2Y7TVOfhFxM781chprYcbd6
         LeeiLh1b/A1snB1YIvcbjv8OjXrFtnYvUyoO01rE4xtXeXtk40/knv5X/rmxOVeDmCnP
         5ek7hRCzaUFSfwyfPOzkTAccyJS5CgozzaGZ5uGvcskGFbw5WzTDzGjsSscegvUizPui
         54qh6vCMt6zKr7wk3931XOyjocpGSDpIc7cU4qTPU7hXBYnBLb7XJPDp4ORBLoRns4ds
         hMQg==
X-Forwarded-Encrypted: i=1; AJvYcCU7nWE5VCmYDyq7qxOo9C56wIZmkEuA+vEDzMVLs4uEF25nBx4hYdIwfZxYPTHD+nTjILym5euT3nyt2LBaGdM=@vger.kernel.org, AJvYcCUGp4WL075ceNaXEsk8hBMh/S4rY6aD4lC8WNu9pbLog0EWSjgZpJxcgKC1kUsUBzyAVkvXhCIh@vger.kernel.org, AJvYcCURJqL3th2msw1fg+jopBbP1KQtMpS+kSDSTCThwPpsFLSvkoMAsuv7pnnRUe9n+QirXV1QJjlZdFos5G3K@vger.kernel.org, AJvYcCVLyEeFfgQQ2rsHFQhx2CD8wCVYGNbzd6u9vldx5mEk3pUvjvuepxGHYAdJ4vieEwE7XqYrHEt7Pdi2cZ5T@vger.kernel.org, AJvYcCWeD3/cKwU/yRf6qT12+0kfaiBAORxs63WnudOk3zfmh7Rnp5iZ0JBupQjFSx/KEE9S0eU=@vger.kernel.org, AJvYcCXFRLYvmpdi8BTExnFfJTwBsYlnbsxBvdKySPPYenm7bs0oETAJWgowrAThA2xeRr9N3LrBl/04F/w4Tg8=@vger.kernel.org, AJvYcCXvBfPnToVH1eGMjSp605+OC471WDCJSGUmQiqtq5AN32NiXCdisR5M6KlbZS/Gk1OR3IVIo5PMqX3D130=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn11R2Av6vIf8mM6fmBaWAHzZVqjL6mvQVzGPYoLqHvMDXN6ns
	8Vg0LoEpAighhNtqFdK/qjv+z+RHgNHRt42xECLqdhGwpHUP8ulj
X-Gm-Gg: ASbGnctJIjFyUPRSx+L6a8CYyNRoDqegooX5L8FTx/WqmLe9DRhklyFchEyYPBWPNKR
	FKjhueB7mN3ki1iyAAV/PUnl8EnyWmRaEnjsX8759AueDOePRKGRqr2+NZ2Q6JP4qnTo49eF1Y3
	4FCPZSwUJyU5f9r8b5cAD7Xh9nPjn+qbvv8aN45EWD3LJ0Dudb9ybabBDDn8Thhc88BLQY8/kVe
	r/nAGhTX2vwEe4Gb+TGtKm1XT14px+lXtHq8t7xBMIPQw3frbltbTBjF8yitJK2OjHW1AFR3pvC
	sD+4CI6ltuQvbTmUnu1cvUne9TzavlUy4UC4VX0fFpoi/C4MWgefWA/WsTJ8JR7tZ60V3qRWh1Z
	lxz9g
X-Google-Smtp-Source: AGHT+IHSscIa3DfqfeKZ+gYLGMqXfo4aPZUveIfgdEWZZaokGaxFBKrjGL5p4Mklbl9y612Oe7mv4g==
X-Received: by 2002:a05:6902:2006:b0:e58:2a5:241a with SMTP id 3f1490d57ef6-e60b2377d4dmr14240074276.9.1741015522418;
        Mon, 03 Mar 2025 07:25:22 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3aafebcsm3002012276.51.2025.03.03.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:25:21 -0800 (PST)
Date: Mon, 3 Mar 2025 10:25:21 -0500
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
	andrew.cooper3@citrix.com, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 01/18] lib/parity: Add __builtin_parity() fallback
 implementations
Message-ID: <Z8XJ4XCByXOx4ZwY@thinkpad>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
 <20250301142409.2513835-2-visitorckw@gmail.com>
 <Z8PMHLYHOkCZJpOh@thinkpad>
 <Z8QUsgpCB0m2qKJR@visitorckw-System-Product-Name>
 <Z8SBBM_81wyHfvC0@thinkpad>
 <Z8SVb4xD4tTiMEpL@visitorckw-System-Product-Name>
 <20250302190954.2d7e068f@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302190954.2d7e068f@pumpkin>

On Sun, Mar 02, 2025 at 07:09:54PM +0000, David Laight wrote:
> > #define parity(val)					\
> > ({							\
> > 	__auto_type __v = (val);			\
> > 	bool __ret;					\
> > 	switch (BITS_PER_TYPE(val)) {			\
> > 	case 64:					\
> > 		__v ^= __v >> 16 >> 16;			\
> > 		fallthrough;				\
> > 	case 32:					\
> > 		__v ^= __v >> 16;			\
> > 		fallthrough;				\
> > 	case 16:					\
> > 		__v ^= __v >> 8;			\
> > 		fallthrough;				\
> > 	case 8:						\
> > 		__v ^= __v >> 4;			\
> > 		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
> > 		break;					\
> > 	default:					\
> > 		BUILD_BUG();				\
> > 	}						\
> > 	__ret;						\
> > })
> 
> I'm seeing double-register shifts for 64bit values on 32bit systems.
> And gcc is doing 64bit double-register maths all the way down.

If you don't like GCC code generation why don't you discuss it in GCC
maillist?
 
> That is fixed by changing the top of the define to
> #define parity(val)					\
> ({							\
> 	unsigned int __v = (val);			\
> 	bool __ret;					\
> 	switch (BITS_PER_TYPE(val)) {			\
> 	case 64:					\
> 		__v ^= val >> 16 >> 16;			\
> 		fallthrough;				\
> 
> But it's need changing to only expand 'val' once.
> Perhaps:
> 	auto_type _val = (val);
> 	u32 __ret = val;
> and (mostly) s/__v/__ret/g

You suggest another complication to mitigate a problem that most
likely doesn't exist. I looked through the series and found that
parity64() is used for I2C, joystick and a netronome ethernet card.

For I2C and joystick performance is definitely not a problem. For
ethernet - maybe. But I feel like you didn't compile that driver
for any 32-bit arch, and didn't test with a real hardware. So your
concern is a pure speculation.

NAK.

