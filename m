Return-Path: <bpf+bounces-55231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49436A7A58B
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF633B0BF0
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D116E24EF91;
	Thu,  3 Apr 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAskKQkl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06762E3386;
	Thu,  3 Apr 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691157; cv=none; b=RjsbccIMbHhFIYGyZcdWroTK/wEdR9BbmKygPb4lSTQ8Ql4HGkR50w/jQw11Qi8bqFnMDiKHkZsZxFCD78uN2ej5elYJWh/A15s4VeegdxczJoz6UJnmg6QpDZOjcwQ6YM50uer7CUXFSN1s434VWEq2a6NGivDNC/mnUUnafqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691157; c=relaxed/simple;
	bh=dmX8ClR6s2gT1VOXeNIIzH890lXaEbUlMlb3oILAje8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBwfeOS4YfngygK02SN5AACj7zftNNAQval20PsfpjWo/0fc5KH/p/zqY0yDFuS24gnGHEuLnJLNzwww/bk/f9WBDWLFxyzCz1VWGy3nmvxRejO/gqjvU6QJ8bLao143GSaitXSU7lcQNA/bQLGu0EUyoXP88pLmITwH4CbdTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAskKQkl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b98acaadso1027972b3a.1;
        Thu, 03 Apr 2025 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743691155; x=1744295955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rvr0XxDHh05/lDdFnQkqZ5aBAiK03CfkHR41QzNZGHs=;
        b=eAskKQklC12e/ry9l7cH1ctbUMIvWFD4TYd+Df4dYRw2MC0E39OFsWe5QTt/E3G8GJ
         r1EWWiYTzJxHSZlI68BwRgwZ+46IkTs3uT4tcRHLY1j/z3zNwjzKXprH36WBLbMTvHnf
         ULTyq8ufdIImCpA9cL8e3XGNqKwM3VCAldYVJlcYP3+BUbS2e0TdM1A5KI/Tyv1UzYg3
         JvytZZaGh4Tf9RChBwXBGw/RINa4IV5SnSOvFXopClfhiHY47PwifbYgot1tB9KuYJmI
         cDnULyHfKNVTfXN2XYwujI4dtEieH0toB5EB20D0Obc+6IRFsH8H0n2jFu8R9XdtV+Tz
         okxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743691155; x=1744295955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvr0XxDHh05/lDdFnQkqZ5aBAiK03CfkHR41QzNZGHs=;
        b=QZpcmZ6rlls4IJSFgVD+R/YZrrxb9La8xo+Zzyjrwb/yjhOslL1irjMdXFHd1+Areq
         f49god6HTJ+j3PnViha9kzO+aj7F6pCjcATWGhuUrbu2EAmQ9eZ4kVosVzEZrqD+di6r
         36gPo3kLhVhFWxfc4TO0YuoHqZ9OlRN9Ti1S2WtoKowm+dyED4KDt+ukNsjkDmBQlZZL
         /yjoNIkeBd9Sh3QuJMVUC2iO4N9WjS9IZWlbmbe/ZQCuD6KpvH/eT54a8H14Yrp1qIYg
         Ae3+i4Nyg/bW+yYvb/qSe6d3aONoMRVCoQhl6nA1oi4Vqsv2d7e7bKHkRKS5z8yglDrB
         YGVg==
X-Forwarded-Encrypted: i=1; AJvYcCULsmrXYjV3MR8aKW5NGpQGcjvtbX4F4BBKNHzlpS3bMN3Hn6MX06LgrZjP3KwPc/Tr3E+YEOVZL3aANxct@vger.kernel.org, AJvYcCVVyDCqKTv/BVOXJ+ZAog2oZ8DwAeCrnDqvUViBOMJaaHqezE9WY7TkpB72h0SahbJ9hCU=@vger.kernel.org, AJvYcCVkj66LdSHEy530I8aZeqamjYlHjOAQC0YOorcQzb5uzQYa0hPxm17gqf+YcOsJXsZNCnNMgm9jnHqlgyBk6LA=@vger.kernel.org, AJvYcCWNpRm+bZ2OfwF03+IQzwg5IPkmBMz3VUk+ElB9szPqxtmAMMy1YF060H+0+NbJUVF0CyEH4PgoGrTBD88=@vger.kernel.org, AJvYcCXdFDrfQinB7VgtZUO6m4N68JX3qqA8SI8JjIbcMKbrh467BX2yrvUm/d/6RwIl7Rs/oR7zV4eQpdM79WY=@vger.kernel.org, AJvYcCXdosafBjnlO4vBbMVNH6aeN5rve+E5sStyeJq+/u+phIkm+A6YkNmzKNoPe7HayAk3Y7H8SZufmfz4E3Zy@vger.kernel.org, AJvYcCXffW0RFwDS2KuMuQKhgIBFeephHrqFyhlUmUubFc3LOdV0KP1WBvC7NvMwuWP02tVU/Gzo85t5@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSBzuInOu5hDkoYPKwMEZHPRLnl3GpMhl95fXRinQggvK4oDD
	bWho26PoaldQOtHBbg4gPY26A88xr/h6C4VlDQMNVhyWj81yFoOT
X-Gm-Gg: ASbGncuNQ0yG1NE8l6aaInEn9HvjEMCM5LffqR7KdGxE8ggeLV+9Oxhd+x9MxpUTUTo
	7nNp4gktau9DA5l1rFId/phnTNKKFy3kuDa0CoJXPv5bUXQzllV4OEisf7YUNALiyRHPkAFeGxk
	4z28sK3bSpMRRQ5CG3X+FFlFcJ2V6OTKLjSVC5EL9vMMqVcQk/fem9tZJcuvqi8iEw0iMG9kxBU
	pnzkNh5Hsqc1D2OmGLD07lKcZZGDWr8bUHoTlS9uo/V8nu7Z4WSoub9K0rb+to5DPprljtQMQnl
	UacM/tsauEhwUr33g0qoEFSlwtuuhT7fcTV3glcZrZPW8tl7jvrUrt1LsvWvIDWmW1w0cFD2
X-Google-Smtp-Source: AGHT+IEBLhxF2I4CcVDE0Ip1aaBG/9qxfajK2d8loqdQY51JgxIHQayN0kr/iRs9O5E0K4MztoDo5g==
X-Received: by 2002:a05:6a20:6f04:b0:1fd:e9c8:cf3b with SMTP id adf61e73a8af0-200e4cc69c1mr11499641637.30.1743691154910;
        Thu, 03 Apr 2025 07:39:14 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc2d331csm1285435a12.12.2025.04.03.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:39:13 -0700 (PDT)
Date: Thu, 3 Apr 2025 22:39:03 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Yury Norov <yury.norov@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>,
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
Message-ID: <Z+6dh1ZVIKWWOKaP@visitorckw-System-Product-Name>
References: <20250307195310.58abff8c@pumpkin>
 <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>
 <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
 <Z9CyuowYsZyez36c@thinkpad>
 <80771542-476C-493E-858A-D2AF6A355CC1@zytor.com>
 <Z9GtcNJie8TRKywZ@thinkpad>
 <Z9G2Tyypb3iLoBjn@visitorckw-System-Product-Name>
 <Z9KMKwnZXA2mkD2s@visitorckw-System-Product-Name>
 <Z+AlyB461xwMxMtG@visitorckw-System-Product-Name>
 <eec0dfd7-5e4f-4a08-928c-b7714dbc4a17@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eec0dfd7-5e4f-4a08-928c-b7714dbc4a17@zytor.com>

On Tue, Mar 25, 2025 at 12:43:25PM -0700, H. Peter Anvin wrote:
> On 3/23/25 08:16, Kuan-Wei Chiu wrote:
> > 
> > Interface 3: Multiple Functions
> > Description: bool parity_odd8/16/32/64()
> > Pros: No need for explicit casting; easy to integrate
> >        architecture-specific optimizations; except for parity8(), all
> >        functions are one-liners with no significant code duplication
> > Cons: More functions may increase maintenance burden
> > Opinions: Only I support this approach
> > 
> 
> OK, so I responded to this but I can't find my reply or any of the
> followups, so let me go again:
> 
> I prefer this option, because:
> 
> a. Virtually all uses of parity is done in contexts where the sizes of the
> items for which parity is to be taken are well-defined, but it is *really*
> easy for integer promotion to cause a value to be extended to 32 bits
> unnecessarily (sign or zero extend, although for parity it doesn't make any
> difference -- if the compiler realizes it.)
> 
> b. It makes it easier to add arch-specific implementations, notably using
> __builtin_parity on architectures where that is known to generate good code.
> 
> c. For architectures where only *some* parity implementations are
> fast/practical, the generic fallbacks will either naturally synthesize them
> from components via shift-xor, or they can be defined to use a larger
> version; the function prototype acts like a cast.
> 
> d. If there is a reason in the future to add a generic version, it is really
> easy to do using the size-specific functions as components; this is
> something we do literally all over the place, using a pattern so common that
> it, itself, probably should be macroized:
> 
> #define parity(x) 				\
> ({						\
> 	typeof(x) __x = (x);			\
> 	bool __y;				\
> 	switch (sizeof(__x)) {			\
> 		case 1:				\
> 			__y = parity8(__x);	\
> 			break;			\
> 		case 2:				\
> 			__y = parity16(__x);	\
> 			break;			\
> 		case 4:				\
> 			__y = parity32(__x);	\
> 			break;			\
> 		case 8:				\
> 			__y = parity64(__x);	\
> 			break;			\
> 		default:			\
> 			BUILD_BUG();		\
> 			break;			\
> 	}					\
> 	__y;					\
> })
>
Thank you for your detailed response and for explaining the rationale
behind your preference. The points you outlined in (a)–(d) all seem
quite reasonable to me.

Yury,
do you have any feedback on this?
Thank you.

Regards,
Kuan-Wei


