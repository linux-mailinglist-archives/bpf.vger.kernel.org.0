Return-Path: <bpf+bounces-52681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B785DA469D9
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996617AAC57
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410142343C9;
	Wed, 26 Feb 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpawnAZq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D121CC53;
	Wed, 26 Feb 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594803; cv=none; b=S4QcQLqenvCMIsGbD88oYeeQkQIxjX5ynvei6QvwPoTvQSQ28ZQkfucZzkwzjmwBd9lnUV/ByRsLqKsChpMghrEXiCDce8ZFEoHYE0/wmmd2zY/AAyRejm2i4ObQP7qH4oIaZ6/f1TTco1Zjfl/1NZuZYbTDocuW7o7xGimGtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594803; c=relaxed/simple;
	bh=06Bx46w4WKqnLcEDcMImX2Rgvc4s7Az8+qGa2ZiH2i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K38H0bpA7GUHZm+YgoSnrBVQWzcsdFAMJkRgQKd4lJWwfLmRhqQnh6Vmr8wZ8hBN7GLT/yirWstq6yPjd9m16u78NyvG6TG0X9XA+mcDlxQoJ9zdcn/BszewItxfDTlk1OZiu1O+eKHf9GYNSkGJ7gW+gfbTPs4LHb8/UKz1kXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpawnAZq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22114b800f7so1069885ad.2;
        Wed, 26 Feb 2025 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740594801; x=1741199601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8NV8NW5Mq8hnlsfnK7VYLX7Lb9iIPf134td0bPOEzZY=;
        b=EpawnAZq/kdSM+6C3tHt1DTf10h9jzDh+WY2mSN4+gpboVFRDEHryGA/0t+fFgfAta
         yReRXzJB3JR+0vbRVUObb2ma49Z8CYIZmE2vyOlM6zlCAHObPMls0CzJCQwnOwy9//6h
         QbTqMa9Lww7VGBAtrnZHZX5PGwvL7Ray5MwuuOxeGYPVmSLn8fzJJY3Td9KdkomhHoaZ
         sZMpdDqgfL92HWT+a+Gs3UofhtamlGm/aglfBOjfC80zOLnfvqhX+wIVySV9I3IeZjkS
         8QlHXRuEG1vzmkuNqgvtH8kONxqCOvxHHd07TjqBHF8Ebur2rNX+cbn9bq50R+IZ2Ztw
         xEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594801; x=1741199601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NV8NW5Mq8hnlsfnK7VYLX7Lb9iIPf134td0bPOEzZY=;
        b=fa9Ky0jHC9BUNbJBYy171n8rC65LzlHvMMvK+s1wX+V0DsDyWjfepLwBptn1GNHtBw
         3LeCEuDSlB4jnkAJqPJk3Q02Y9duQvHUQEI0JVgp1KlG7J9H+Ef8FRFc4dlWv32Ro/ib
         6N3BIQDIZIfRkMrTIMAcuR20CUtp2cikehLg6jrKaDxA74im74uozY0l8L3MIIksR30m
         nzdoBeeIK220QqUmZXiT3JtpbHpqtgh/sq2kpFGN+Ozd+UGTUYs2Z1ul4UNc+WB32NyO
         kXdOY5pBkRNi3rLliJt9fNMDcAebPzIRqox3MTJMEN2J35ynTGf3LSDNd7Lrghe5PHzY
         aBgw==
X-Forwarded-Encrypted: i=1; AJvYcCU0HR1bgjQ8Jyr5IP3uaBHLHzWwGs5PgG2kstM3RITbLhLMOXa1IHoAuoY34JBTDGx4nx0=@vger.kernel.org, AJvYcCUOyJVXqU2p58b+PlLtWzqCm9M7IcWbxOpxxS07h8hn3hATQabj7vsVsjcIXNr2pUoNQYXMDAaEwB9+AkWm@vger.kernel.org, AJvYcCV0zPjq/B65QolHTSI3DwKfyUBJSbz6joMd8o0Iuol4krTiPHUYaL4JXGubdsJzGVB0GdLLuiXb9PT4Ix0=@vger.kernel.org, AJvYcCVwO1LPwYgrSVboCtdkOXZRiQgrk8Pv5snhpd7jc4VCwoZX5wiAFRLFEaCL87KbPnsADApvFYNoevjxgFGQ@vger.kernel.org, AJvYcCWIvHtg+wax6vXltb+6Q+st1agfA7oVs6RCnYIBLCKhxUpaf/NUkYYbkG0tsYQZ5UKoAZZKk2bDiCuRbys=@vger.kernel.org, AJvYcCXRB0QfiC7YSWTWesOIGgv6oEQccDVfW54p8ZnfHg5lMbQStWn1TT5Hk7YC5w0LI7vc8aVx9bntTqPhHeyu+qE=@vger.kernel.org, AJvYcCXUWnioz6RMKjH4TKMAUMuaBajfGMnSxoyPdfsQQXMGFqak9N5dFqHnZOWT2u3GwoJkN7H7M4HU@vger.kernel.org
X-Gm-Message-State: AOJu0YwydCMtNCDxOgNk6fUwcbNc/2Rc3Y/wqwRCgZxrAlUOh3VqtBUp
	kF+p/lUZM8X61dBCgpNOtOuMkU9RQ142YXQgxbuVqno25YYr3+YV
X-Gm-Gg: ASbGnct5PvI/yq/DSrzSRNbuHzzfjZhdj6VpJYHouEWBeROBIar8BxS1E7W17sAUfS6
	McZvsNqC5MZVA4LckJwjsQWNAESpux4P2dGYd3n6TPIyuB594JyIQaPgo/hTbnf4rLXYwmKg1ap
	bvLFLUg/bgxEYjdyMh4ZbsURp+xqoZlqaeEY66Me03JdiSL5bJJsRMCg39JlR8Lf09ECx2u/y1N
	FJBSXBp7ohcQz/aLyc8aEO8ybQbxoa1Oawv5rPCAGj0LDsnfWWTxykUZoXCSaSRDJmnur01iksG
	az2dMhbM4tSeMhdDPt1rAa2ejDEvE0kKQ8EFaeWAKAZxfZpFMw==
X-Google-Smtp-Source: AGHT+IEhO/8zynHAj/XQ8CfYcqOsDet7/XXIGYhA3zqO2mHTqzuioBsUax6Pz3NWu+JgRkwDnM6ajg==
X-Received: by 2002:a17:90b:2d88:b0:2ee:c918:cd60 with SMTP id 98e67ed59e1d1-2fe7e33d442mr6780868a91.20.1740594801403;
        Wed, 26 Feb 2025 10:33:21 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825eb82fsm1917776a91.32.2025.02.26.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:33:20 -0800 (PST)
Date: Wed, 26 Feb 2025 13:33:18 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
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
Message-ID: <Z79ebv630yuNOJKV@thinkpad>
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

The existing codebase has something like:

        int ret;

        ret = i3c_master_get_free_addr(m, last_addr + 1);
        ret |= parity8(ret) ? 0 : BIT(7)

So if we'll switch it to a macro like one above, it will become a
32-bit parity. It wouldn't be an error because i3c_master_get_free_addr()
returns an u8 or -ENOMEM, and the error code is checked explicitly. 

But if we decide to go with parity() only, some users will have to
call it like parity((u8)val) explicitly. Which is not bad actually.

> And if not, you can have all those parityXX() as inlines as you suggest, but
> also provide a macro such as the above to call (optimized) parityXX() as per
> datatype len.

Yes, if we need fixed-type parity's, they should all be one-liners
calling the same macro. Macros or inline functions - no preference for
me.

Thanks,
Yury

