Return-Path: <bpf+bounces-55242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71725A7A7AF
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F191516CE8E
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44F2512D7;
	Thu,  3 Apr 2025 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brNiMAKg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB924BC06;
	Thu,  3 Apr 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696849; cv=none; b=iEJAQa1sN0IDZeUF3QEu0ya+nDFxt9H7Wfbx0MDZwJYwnCZY6cMGRMisAPUmqB+BnQDKWyTTaN+/M57Nw7JgBDRjl/IjrRvz2AAsa4OU5yyMw/yTYEulsk9W3JEr2OScj5nMynYpgj/8qJOPaUH27mVIBFsE1+1PVzjcKiCnZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696849; c=relaxed/simple;
	bh=g4yIIhJXJS+2HpRtFLQZWDfTqppjtp/hIdH2G/MZEpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAUn17NXigHs4Tr6bbQZ8TO4yBH10u+K7BSUCJescHHgPb5jWgw3rNR1S/2P9dAI33+yz3u5D+9ZKGvnkQZ1wr4/COTuDprgykfLb1yb106dBD+F2cU27q8rtUkLqSJ+Flezu8rQaCzFE2wLBQekkHktaT/MRJ0+xdDHtvT+3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brNiMAKg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so1263891b3a.0;
        Thu, 03 Apr 2025 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743696847; x=1744301647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NsvCi3xr0wqbxukv6gNk2KWJs6cd/sHgcwpQSSqpQSc=;
        b=brNiMAKgQ5lYjAZkAYVtcNERGXdLqBOX+G5GqlptHN+NtWr2A9+2pgwWcZmYt9uVQ5
         tTI5LDRiGRKUXzg3fKgL7A7rFW2a8VNuJ1fI39JaNuz1OAwTy4umz2X42OkPkw+6kDR/
         CsNOSVR6n82KCKOU8D7yhUtocKIZxz9FoSRzKLlVxVuvlhockGwYc0BrrR3TM/lPHIWc
         3EEQ2xgtyv7Zt5lqwSYezOMCEC3q5cPv7sbORbkWjvCI+GAZv3uqpoC3Ox642/1MxDdv
         YOn0XQBSR0lnKqZ+AUjdkvNkHJJRV46yaP8BNWF3RbAkro+qNMaJnwOPxqtCsjaPHxx0
         Jo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743696847; x=1744301647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsvCi3xr0wqbxukv6gNk2KWJs6cd/sHgcwpQSSqpQSc=;
        b=finE4JZ6/YTDs3xq32zJNAiWJZdy72r8IS26MYxdiyMzsANnnr62T4eBbyJUt0d1Qh
         VEFLmhDgXXyGffVeJrE8KAOLy9ybBAI2ILoYPxV09yCXWOaIdpHtXV1nwOGuKpAZTH8w
         ue2pGjbRk5hVx+/j1y/7aMdn8Iy+SGWhItXHOQAolS+SebmrfKu9X722gFJMleUH3Qpa
         DxU0CANnZImndiyLYiCSTARenp92cLCrlBpuYouMOWJgswu9Z6pTsMrdfvLcUy0iewLE
         ZoD5HkNijrLtD1pSBVS3z+9LG+DT/PFtScA18veeulDK4PxneRe6zfp2NScoL6G/fQHv
         qGGw==
X-Forwarded-Encrypted: i=1; AJvYcCUMjLt6Lj+ERjWzezq6iS6+JPMrN2O5lyAxNGrV02TGfjQTlun9EKQEEI0YyXnVDbh8/A90nf0wQUGpgY4=@vger.kernel.org, AJvYcCUukxQ/WBEbsub/WfyUUjq3BbnyVcGLFuCEdUA/oug9j8GyX8RH9c4/+3rKg959EKeHtwYNgbGIb2XMh5Sm@vger.kernel.org, AJvYcCUzx8wFxPpmr4+OPhdEBVf+XhMkjRgBtVHzateiPZRypb1YP000uiXOmLoJt4RmWwX/Rq9DcAqx8hgsgyBD+i0=@vger.kernel.org, AJvYcCV+9FI+GQoyuZJ7iDKB9LI5v6M3ZGKL7EHjO6XwPa/aSinFxAeNR3n9cM9/Y5Q3jW4UROBthB+3vYa5MDJI@vger.kernel.org, AJvYcCWoyKQdZ2r3cA0hOtSry3DUsd7w2ZUp0Ah7l+Lr9RULrFcRehfP3eR24krDe9xGLPBFiTujXG0V@vger.kernel.org, AJvYcCWzuNPaQIsKxSx+tK+ucExPWy97ZDupiPjbTQdAKxor1/+/qJungRam7E5Kc8Z/CxHGxaY=@vger.kernel.org, AJvYcCXCB3hR1/XxvrRWL830rH+De7r7l9F2ewuKL9m4QQ7sifPvtjFsFkoI84ZTxUy9V2D+GZk+5jEuMjvsQus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMJchLPNdKptWD56607MUA7M2lUHH6sq7pobwNHwjE/7lqkHi
	Tpma00taXC9E0gDgH3tYeiUkugzZQSBERR+XVReDEMEOhSACssr4
X-Gm-Gg: ASbGncsUFk13MZukUHAP2PUbnrEaCgI7DGbtGCiP3vpKDG5zunQDgISHshmCZxyz1AY
	WU+tXwFF+7fsFPc0+6aKSsjc5nTrLs3nsggyzKTykSh0rzcc9+S6sPQII5PqAV51fchhWfwA3RU
	1u3n2xp6zUF+bY0XjK8lskvUyVTpgdZKFeIdX+qRvasuMellp7WpFcOOZylxMPNvEJWiNZH6Yk+
	kb6Pk8sWSlq0Q6GyiUuS4ynw6v1kuzRfL0ge5u2WYC3vI4tvJ5mVSLJL3GLA27ssKSfyYbYk36k
	1QWFW2yRyNoAWKswgb9LAieFFlY85lNmQgXeCnvljwnQ
X-Google-Smtp-Source: AGHT+IGVU2+2TkhGwc9XcrbXTU+jprAkGrGQEy4B9m6YI+h73paRxRK7YqS+QjyFE8ZrGike3yIkRw==
X-Received: by 2002:a05:6a20:c886:b0:1ee:47e7:7e00 with SMTP id adf61e73a8af0-200f55ecf4dmr5333762637.13.1743696847264;
        Thu, 03 Apr 2025 09:14:07 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc3fd41dsm1416486a12.50.2025.04.03.09.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:14:06 -0700 (PDT)
Date: Thu, 3 Apr 2025 12:14:04 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
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
Message-ID: <Z-6zzP2O-Q7zvTLt@thinkpad>
References: <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>
 <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
 <Z9CyuowYsZyez36c@thinkpad>
 <80771542-476C-493E-858A-D2AF6A355CC1@zytor.com>
 <Z9GtcNJie8TRKywZ@thinkpad>
 <Z9G2Tyypb3iLoBjn@visitorckw-System-Product-Name>
 <Z9KMKwnZXA2mkD2s@visitorckw-System-Product-Name>
 <Z+AlyB461xwMxMtG@visitorckw-System-Product-Name>
 <eec0dfd7-5e4f-4a08-928c-b7714dbc4a17@zytor.com>
 <Z+6dh1ZVIKWWOKaP@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z+6dh1ZVIKWWOKaP@visitorckw-System-Product-Name>

On Thu, Apr 03, 2025 at 10:39:03PM +0800, Kuan-Wei Chiu wrote:
> On Tue, Mar 25, 2025 at 12:43:25PM -0700, H. Peter Anvin wrote:
> > On 3/23/25 08:16, Kuan-Wei Chiu wrote:
> > > 
> > > Interface 3: Multiple Functions
> > > Description: bool parity_odd8/16/32/64()
> > > Pros: No need for explicit casting; easy to integrate
> > >        architecture-specific optimizations; except for parity8(), all
> > >        functions are one-liners with no significant code duplication
> > > Cons: More functions may increase maintenance burden
> > > Opinions: Only I support this approach
> > > 
> > 
> > OK, so I responded to this but I can't find my reply or any of the
> > followups, so let me go again:
> > 
> > I prefer this option, because:
> > 
> > a. Virtually all uses of parity is done in contexts where the sizes of the
> > items for which parity is to be taken are well-defined, but it is *really*
> > easy for integer promotion to cause a value to be extended to 32 bits
> > unnecessarily (sign or zero extend, although for parity it doesn't make any
> > difference -- if the compiler realizes it.)
> > 
> > b. It makes it easier to add arch-specific implementations, notably using
> > __builtin_parity on architectures where that is known to generate good code.
> > 
> > c. For architectures where only *some* parity implementations are
> > fast/practical, the generic fallbacks will either naturally synthesize them
> > from components via shift-xor, or they can be defined to use a larger
> > version; the function prototype acts like a cast.
> > 
> > d. If there is a reason in the future to add a generic version, it is really
> > easy to do using the size-specific functions as components; this is
> > something we do literally all over the place, using a pattern so common that
> > it, itself, probably should be macroized:
> > 
> > #define parity(x) 				\
> > ({						\
> > 	typeof(x) __x = (x);			\
> > 	bool __y;				\
> > 	switch (sizeof(__x)) {			\
> > 		case 1:				\
> > 			__y = parity8(__x);	\
> > 			break;			\
> > 		case 2:				\
> > 			__y = parity16(__x);	\
> > 			break;			\
> > 		case 4:				\
> > 			__y = parity32(__x);	\
> > 			break;			\
> > 		case 8:				\
> > 			__y = parity64(__x);	\
> > 			break;			\
> > 		default:			\
> > 			BUILD_BUG();		\
> > 			break;			\
> > 	}					\
> > 	__y;					\
> > })
> >
> Thank you for your detailed response and for explaining the rationale
> behind your preference. The points you outlined in (a)–(d) all seem
> quite reasonable to me.
> 
> Yury,
> do you have any feedback on this?
> Thank you.

My feedback to you:

I asked you to share any numbers about each approach. Asm listings,
performance tests, bloat-o-meter. But you did nothing or very little
in that department. You move this series, and it means you should be
very well aware of alternative solutions, their pros and cons.

Instead, you started a poll to pick the best solution. This is not
what I expected, and this is not how the best solution can be found.

To H. Peter and everyone:

Thank you for sharing your opinion on this fixed parity(). Your
arguments may or may not be important, depending on what existing
users actually need. Unfortunately, Kuan-Wei didn't collect
performance numbers and opinions from those proposed users.

I already told that, and I will say again: with the lack of any
evidence that performance and/or code generation is important here,
the best solution is one that minimizes maintainers' (my!) burden.

In other words, bool parity(unsigned long long). I'm OK to maintain
a macro, as well. I understand that more complicated solutions may be
more effective. I will take them only if they will be well advocated.

I hope this will help us to stop moving this discussion back and forth
and save our time, guys.

Thanks,
Yury

