Return-Path: <bpf+bounces-55247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D9CA7A83B
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5E47A5D65
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59D25178F;
	Thu,  3 Apr 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuHJyOdK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AB2512C9;
	Thu,  3 Apr 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699293; cv=none; b=caZVgsTGq3mHdKjWwJ5WNF5TOeHqEu4KmiLaz8JUZyT6qaGOD7lGz29rZ+e5YPZNkyFkJDuLi10rrFsqOTNOZPb8Youi3vI+9zBJmRoZq7tWWlFuLwbY0S85lDFFePRWFbqTtXDk4+RtR4SHS70xeKnG2t85JxJhfvL8H2aUGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699293; c=relaxed/simple;
	bh=sxhZhxhLY0BwekVxfSgxhKbAPa1FnVtYBhNgH8ZGXAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7srVelrz6S3toyjSVeQT2iMoiKY+sHkJ/ParfsYhtEBwkuwvJN+TJshh9hACuxIcUtpOIRo0nPCNLBPZazZNOMf7ViynAwbzO3/ISmtF8sUC6jq7K0WMIjzpbNO9SwD12S6rm72CccNFGU2baEEVzusVepA1g2U5dKi4E4HlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuHJyOdK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so962206b3a.3;
        Thu, 03 Apr 2025 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743699291; x=1744304091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDa5eNS7BwA8fLuFV+VPTYw9CpDmGbyK6UKEScOkVlM=;
        b=XuHJyOdKp+KVpWNaET6cFMoTxJIM/4nv7V8IeCvUq59U31+InKeHemM/Bc4IcL95Yq
         +dhkCL/H8qjPjUj4/wSF8aovobwUPN1M/mLNWzcz6D77JVML54l+tpBUpatZ+bhxlTpI
         3b74nbi66vyghgxXeEGx069jmcAZ8oKkczIthUyxJlZzBe1wdZ3h82plE7RNtFu/2yIz
         gSrWvYkyB59Z78ZH7bD6H0a9MBDxjYipFC9F5bt1wmNmatU2KFda5uwr45MVgJ4UAkD0
         G0aIHJtllGRPjP0wzz/daclw+/z0VPpg18wqXBWImoMgEOle/UyjQPIqQmf0jSFk43BE
         x8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699291; x=1744304091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDa5eNS7BwA8fLuFV+VPTYw9CpDmGbyK6UKEScOkVlM=;
        b=CxLFKeD0H5yOyMnkH4xuBCV1gSZtyRaAvmhKyGlT1Mwplgv5jw5E2QxFW9KF8hh3bw
         DpwCWPCZgP3lmHXTmwAv5tRWVwM9IG+nMuF9vSSx1+4R9OiJWHh5DLxFkPabJ1z7eCOO
         EKHncUAieKbW3UhUMyLWX0yRlZmg81R+FcUIb54n6sGH5Osf5lXoJRvE+5H+rdcbGYeo
         HXhWcnrAoa2UfqXnmcJgavSmo5U8x1J7goX6+ft4gWzPfIB0SKqw3jvTzrc6MN+Ss+SL
         65Jkiux/7y73NsIOMG87D2ZB+KFMAEyzzaBV03hQCJFnz5GDBTxDxKRBVGBEu9DFkr2H
         1Q+g==
X-Forwarded-Encrypted: i=1; AJvYcCU2W99SAYZxS02LIpy509IQX8JTENKvbvdAPEwvg5y8MhOLI1HQJXwjDrn+gs+Ld/g73dDEmR0TH1J9JFlg@vger.kernel.org, AJvYcCUMDHJFxqHJsSsyZhRX/j4UErk8K/3g3bsi+5toyRING3fN/+gUFW3D8HjDrTfXyfLEjttd8W2mN6PAujA=@vger.kernel.org, AJvYcCUl8dGL8RqG4wJvJtpSeAwEpJwPoQQAEnBxTXpaBEvDp72WLdsLqwQsWjyDWJ2445dfLoheAAjz2I/0PUU=@vger.kernel.org, AJvYcCWF96Fz+zXCDbd/mEEseXR7+zN6LMv26KkkYua3m6bJ4KGyshv5eqRTjIOMigxyy8PPwJG3J+Au@vger.kernel.org, AJvYcCX8uHRTEvajhEcj3dCefQUMC8NavVsjxBmWXzvPfDV7CsWtoL6rPoNzsqWomWbPrDrbd2qkq+c2cY9i5sD/wuE=@vger.kernel.org, AJvYcCXSQRdVApxfh5D3QSt0S55XSeRcYDZY9JQpg51RYtd+Z6+hEinnYS2OiR8d7Lrv30vKCwUJP9roVQIK7gp2@vger.kernel.org, AJvYcCXzhjpL7eidVcIl+LGJ4UGZboao8pihnLnzVuX7uAg20fu9hyfMHEmAXU2aTk+jMeAG25E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tQ4aNmYwQgAay/SdGInF3tAUrPfGPJ+gvXGMpxv1xtENu9qf
	VR02SZhWK1FO0F5avJhhHGlx2NqHJTo898wfC4gZvenaaCD2hvCC
X-Gm-Gg: ASbGnct5JWGCRoe3VZIPBwky2akTdA+uvK1NUNrKyRJbPCRhA4dlz3tqndh1dQIIikI
	Xzw5Hway+WHDNStrCQg6Fd8wkjC59n7u9cAQAewlAoIrwQDQ0Es6zps2jtx2QDuxHEmAVk+S+a/
	pQmkdxONjaqkaUW9+lBaVwUCikG0HK4fxdXXL9stR9/YZZgsEpGT9gvVGIe8NJfb/ljduRhKTjC
	JD6ZU1uwjGXqxJXRV9fDh/2N5muCNFa2kYrNhzFlfcPLheEkJAPYp+l2n9516Dh6nft0WuYj48P
	N1hzw7y64PelhNuzI7MF4D3/7p6GUpiIFgJ/etIG3G0xGixWNPF17vjlX03ifzYKK3F34evv
X-Google-Smtp-Source: AGHT+IFzbU3WoJeacDQdqibpo5DgjipppPJR8PTe9f3lGsTZ/tQbuHLEeyPY/scxBj5Gc9UqWtPEbg==
X-Received: by 2002:a05:6a21:9011:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-2010446ceb8mr238059637.4.1743699290513;
        Thu, 03 Apr 2025 09:54:50 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc31c00csm1453293a12.20.2025.04.03.09.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:54:49 -0700 (PDT)
Date: Fri, 4 Apr 2025 00:54:40 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>
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
Message-ID: <Z+69UOemf+H/EHvN@visitorckw-System-Product-Name>
References: <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
 <Z9CyuowYsZyez36c@thinkpad>
 <80771542-476C-493E-858A-D2AF6A355CC1@zytor.com>
 <Z9GtcNJie8TRKywZ@thinkpad>
 <Z9G2Tyypb3iLoBjn@visitorckw-System-Product-Name>
 <Z9KMKwnZXA2mkD2s@visitorckw-System-Product-Name>
 <Z+AlyB461xwMxMtG@visitorckw-System-Product-Name>
 <eec0dfd7-5e4f-4a08-928c-b7714dbc4a17@zytor.com>
 <Z+6dh1ZVIKWWOKaP@visitorckw-System-Product-Name>
 <Z-6zzP2O-Q7zvTLt@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-6zzP2O-Q7zvTLt@thinkpad>

On Thu, Apr 03, 2025 at 12:14:04PM -0400, Yury Norov wrote:
> On Thu, Apr 03, 2025 at 10:39:03PM +0800, Kuan-Wei Chiu wrote:
> > On Tue, Mar 25, 2025 at 12:43:25PM -0700, H. Peter Anvin wrote:
> > > On 3/23/25 08:16, Kuan-Wei Chiu wrote:
> > > > 
> > > > Interface 3: Multiple Functions
> > > > Description: bool parity_odd8/16/32/64()
> > > > Pros: No need for explicit casting; easy to integrate
> > > >        architecture-specific optimizations; except for parity8(), all
> > > >        functions are one-liners with no significant code duplication
> > > > Cons: More functions may increase maintenance burden
> > > > Opinions: Only I support this approach
> > > > 
> > > 
> > > OK, so I responded to this but I can't find my reply or any of the
> > > followups, so let me go again:
> > > 
> > > I prefer this option, because:
> > > 
> > > a. Virtually all uses of parity is done in contexts where the sizes of the
> > > items for which parity is to be taken are well-defined, but it is *really*
> > > easy for integer promotion to cause a value to be extended to 32 bits
> > > unnecessarily (sign or zero extend, although for parity it doesn't make any
> > > difference -- if the compiler realizes it.)
> > > 
> > > b. It makes it easier to add arch-specific implementations, notably using
> > > __builtin_parity on architectures where that is known to generate good code.
> > > 
> > > c. For architectures where only *some* parity implementations are
> > > fast/practical, the generic fallbacks will either naturally synthesize them
> > > from components via shift-xor, or they can be defined to use a larger
> > > version; the function prototype acts like a cast.
> > > 
> > > d. If there is a reason in the future to add a generic version, it is really
> > > easy to do using the size-specific functions as components; this is
> > > something we do literally all over the place, using a pattern so common that
> > > it, itself, probably should be macroized:
> > > 
> > > #define parity(x) 				\
> > > ({						\
> > > 	typeof(x) __x = (x);			\
> > > 	bool __y;				\
> > > 	switch (sizeof(__x)) {			\
> > > 		case 1:				\
> > > 			__y = parity8(__x);	\
> > > 			break;			\
> > > 		case 2:				\
> > > 			__y = parity16(__x);	\
> > > 			break;			\
> > > 		case 4:				\
> > > 			__y = parity32(__x);	\
> > > 			break;			\
> > > 		case 8:				\
> > > 			__y = parity64(__x);	\
> > > 			break;			\
> > > 		default:			\
> > > 			BUILD_BUG();		\
> > > 			break;			\
> > > 	}					\
> > > 	__y;					\
> > > })
> > >
> > Thank you for your detailed response and for explaining the rationale
> > behind your preference. The points you outlined in (a)–(d) all seem
> > quite reasonable to me.
> > 
> > Yury,
> > do you have any feedback on this?
> > Thank you.
> 
> My feedback to you:
> 
> I asked you to share any numbers about each approach. Asm listings,
> performance tests, bloat-o-meter. But you did nothing or very little
> in that department. You move this series, and it means you should be
> very well aware of alternative solutions, their pros and cons.
>
I'm willing to run micro-benchmarks, but even with performance data, I
lack the domain knowledge to determine which users care about parity
efficiency. No one in Cc has clarified this either.

> Instead, you started a poll to pick the best solution. This is not
> what I expected, and this is not how the best solution can be found.
> 
> To H. Peter and everyone:
> 
> Thank you for sharing your opinion on this fixed parity(). Your
> arguments may or may not be important, depending on what existing
> users actually need. Unfortunately, Kuan-Wei didn't collect
> performance numbers and opinions from those proposed users.
> 
> I already told that, and I will say again: with the lack of any
> evidence that performance and/or code generation is important here,
> the best solution is one that minimizes maintainers' (my!) burden.
> 
> In other words, bool parity(unsigned long long). I'm OK to maintain
> a macro, as well. I understand that more complicated solutions may be
> more effective. I will take them only if they will be well advocated.
> 
Before Peter suggested an arch-specific implementation, I planned to go
with approach #1, as it minimizes maintenance overhead in the absence
of clear user requirements.

Peter,
Have you identified any users who care about parity efficiency?
If not, do we still need to introduce an arch-specific implementation?

Regards,
Kuan-Wei

> I hope this will help us to stop moving this discussion back and forth
> and save our time, guys.
> 
> Thanks,
> Yury

