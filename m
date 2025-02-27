Return-Path: <bpf+bounces-52811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F18A48AF0
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 22:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A333E188D331
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 21:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7012271830;
	Thu, 27 Feb 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToEsXxGf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D4227B8E;
	Thu, 27 Feb 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693468; cv=none; b=nFDuoNtECG/5sgI6JCOw3esOZhvFPKiAEjv5qChh0VJLREQvkfjxnHKrdzv989jDoZ9GgqWNdOcY27xCX+zsDYOOpEAbJnXcIdTXqEiCtKtFBhhROr+v03sCV4Fn3F7oBotgWt3ChG5z/cms78nHLXm76bSozEZH+CZWu9OiOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693468; c=relaxed/simple;
	bh=KRFx2VPv0/SkpIJsIryj+VgjCDlLd6MvWLHprVAY+pE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IETrppeE5j5A/vm2ID4MH8lPSC6nm+Wr5KpHGaEq5Mbz+d8J98QS511gtJzFZM13k4Xxollwh/wVyWIZh724m476nY7AVcUVqUoeQw/umJprH2kVcNQqiMGtP6iGcaG+dGTeogwUpO63W/ChWJBLXcKQfQrgBrMl5E5GRw3LztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToEsXxGf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43998deed24so14228255e9.2;
        Thu, 27 Feb 2025 13:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740693465; x=1741298265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMuX81k7SiNTHz2+bDlgy5RWfBuIrQmuJh6Y3XOI5k0=;
        b=ToEsXxGfke+y6Hq/oOz1RYCu15/2WWOkF5RJbdy8dwuC3s/lfsgCeOfIzAp6MZX7Y6
         lwlSvvy/+4Lu99wB20NLPAdKr450ji4lDezm+9BjLdQmXoBiC7n52Q3x0raX/VHceWUa
         PAh0l12jljs4UshLtvf8qtFm/Q6v08Bv50PwyWRTC/BIft0l7rt2yuJ8t0UyKJ0vb3HX
         03yW1/jwdG8Sd6fIdRbJOhmd0Ir+hzB7or8mmnIbzrysVcwwME7J9HoT+jmzI6lJLlLS
         KG37noP74COukptatoxiaPYRQhmvQb1mn2KsevjVC/uyHNF5iA3J2/2YpExnzBAzhdXO
         dbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693465; x=1741298265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMuX81k7SiNTHz2+bDlgy5RWfBuIrQmuJh6Y3XOI5k0=;
        b=YXhgLZTR3RmdGr59jOTBs32lE1Xoxn83vvnTUAr5H/qsJ3YDws+XdUXkskXTZVQ83E
         yC+91jxcCnLVnUV0dHTYMj0FdorgTpkdakyzYWn2Vk+a338VexqroFS5GcyDkqyVCEg+
         g39cma4VhO6XkrF0SdSbTC1R3T38+zmnjllfRVGowkyQsJY1I1ux2PuaLxJIiF3EfSSq
         bIxtbGzbfipJrQY3odDd+nXsiZoHA9OaXsSeFb8TX7PXuMYCfI8rchFMU10k+wxwKBHH
         kkydfmlvhAWxan6yVSJ6h2LkCPmeRaBh0QMR9o+Y4xK9edhMhTMZg4DL6qOhUD3iZyDY
         s5/g==
X-Forwarded-Encrypted: i=1; AJvYcCUdEW5yTpG/e+24LgmsbUTjOUBKdkH9p5REJoHWqQA+RssP0qwwf/7rHsQ6IbC/FOk+EXxxd4y74Y/nWUE+@vger.kernel.org, AJvYcCUwNbF521BK830oD3GxhxnLjcNF65UUDOJLppcag2/pWCH3L0qACiyRewfceW096I5ELpo=@vger.kernel.org, AJvYcCV7QEoYPKNz+D1Cn2lgn/p//XeHvdddrd2zH1LeP5KcxJBZWgTB3pDy9LbGeP8C8r0Jpvh4KgiP@vger.kernel.org, AJvYcCVS9ptc+dH4lUmelDv95d/mvOHqdpNjMPm3OtvBGKNrVCBhWam0XvwgrLccxc7jaIPRUrj8A6v5g2tZ0GLB9e8=@vger.kernel.org, AJvYcCWxBudOva1ksIu4FT7POmrdKaVZ6DXB+XZ6nhkLQcTn4l1vZu0nSVHuTWs9FxLshrSKUQmp+sNvBJzEhCz9@vger.kernel.org, AJvYcCXnsegOL/9kmLMVujOu99B/+5YJNiLoXOrMhulVp0RDFFdL8D4KyDGOG1Pg8rna7NvWxw4NZOGT9zHSPY0=@vger.kernel.org, AJvYcCXouRFZZf4fxqEjcjv0Xg6lcGdkAIeSCbt1R+ABrtDs2JyBavVQ8pbII6AAUn0efwsdigIgRZ2wj+ugfAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hJ65avONXpKJjigjXmufkhuNPeW/Zq3DE7qZ4RbFVLauYTZx
	CoLTW1VpJWjoR0G2Ibtw81JG+pQM6G0O8LhntKM2CEqd43lOPzhj
X-Gm-Gg: ASbGncs8bSZynR3d04PBfZd1zDtTHWf9GUlXzJ+FtIT/iMq1l4qm7I+sbMwtAxUirHP
	3+Utsyj7PAs8wZzcwnMNdGRLz9RZheS1fXOMkfarJoIzFaEiQoGktr62I0oR/f/LgYfMkxcrZiQ
	3lcZMvpWH+ciE6p0sJGONgxMno/FQTIlA/oWE/NYwVBfSPPmbLZW0uMf8KdhY/Z9q7Hkpuqg8Sg
	JhG3yKsmqgoptEK4JH3cXDMI9L58/mKTqfqphbGOanrqhBWQNP0xL0XJxz/1RsZBznGAcZZHM/J
	vmefVdXAm4VBlV3/WPgYF2kf0WWI1kDp55nREqCixrJzrtUbN3EWnJw4LZjNP3cT
X-Google-Smtp-Source: AGHT+IEhn6JpdK4VbGGBYqWA0Kpl3+orzugSC/uMKlJ9X/pPv2vI6Oa6V51Yx+DCCez80jfd4SeOMA==
X-Received: by 2002:a05:600c:1912:b0:439:a1b8:a246 with SMTP id 5b1f17b1804b1-43ba66f9643mr7425895e9.8.1740693464406;
        Thu, 27 Feb 2025 13:57:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7370372dsm35525085e9.11.2025.02.27.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:57:43 -0800 (PST)
Date: Thu, 27 Feb 2025 21:57:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dmitry.torokhov@gmail.com,
 mchehab@kernel.org, awalls@md.metrocast.net, hverkuil@xs4all.nl,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 louis.peens@corigine.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
 johannes@sipsolutions.net, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
 alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
Message-ID: <20250227215741.1c2e382f@pumpkin>
In-Reply-To: <Z8CpaaHv0ahHFVuK@thinkpad>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
	<20250223164217.2139331-3-visitorckw@gmail.com>
	<Z7zIBwH4aUA7G9MY@thinkpad>
	<20250226222911.22cb0c18@pumpkin>
	<Z8CpaaHv0ahHFVuK@thinkpad>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 13:05:29 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> On Wed, Feb 26, 2025 at 10:29:11PM +0000, David Laight wrote:
> > On Mon, 24 Feb 2025 14:27:03 -0500
> > Yury Norov <yury.norov@gmail.com> wrote:
> > ....  
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
> > 
> > You really don't want to do that!
> > gcc makes a right hash of it for x86 (32bit).
> > See https://www.godbolt.org/z/jG8dv3cvs  
> 
> GCC fails to even understand this. Of course, the __v should be an
> __auto_type. But that way GCC fails to understand that case 64 is
> a dead code for all smaller type and throws a false-positive 
> Wshift-count-overflow. This is a known issue, unfixed for 25 years!

Just do __v ^= __v >> 16 >> 16

> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=4210
>  
> > You do better using a __v32 after the 64bit xor.  
> 
> It should be an __auto_type. I already mentioned. So because of that,
> we can either do something like this:
> 
>   #define parity(val)					\
>   ({							\
>   #ifdef CLANG                                          \
>   	__auto_type __v = (val);			\
>   #else /* GCC; because of this and that */             \
>   	u64 __v = (val);			        \
>   #endif                                                \
>   	int __ret;					\
> 
> Or simply disable Wshift-count-overflow for GCC.

For 64bit values on 32bit it is probably better to do:
int p32(unsigned long long x)
{
    unsigned int lo = x;
    lo ^= x >> 32;
    lo ^= lo >> 16;
    lo ^= lo >> 8;
    lo ^= lo >> 4;
    return (0x6996 >> (lo & 0xf)) & 1;
}
That stops the compiler doing 64bit shifts (ok on x86, but probably not elsewhere).
It is likely to be reasonably optimal for most 64bit cpu as well.
(For x86-64 it probably removes a load of REX prefix.)
(It adds an extra instruction to arm because if its barrel shifter.)


> 
> > Even the 64bit version is probably sub-optimal (both gcc and clang).
> > The whole lot ends up being a bit single register dependency chain.
> > You want to do:  
> 
> No, I don't. I want to have a sane compiler that does it for me.
> 
> > 	mov %eax, %edx
> > 	shrl $n, %eax
> > 	xor %edx, %eax
> > so that the 'mov' and 'shrl' can happen in the same clock
> > (without relying on the register-register move being optimised out).
> > 
> > I dropped in the arm64 for an example of where the magic shift of 6996
> > just adds an extra instruction.  
> 
> It's still unclear to me that this parity thing is used in hot paths.
> If that holds, it's unclear that your hand-made version is better than
> what's generated by GCC.

I wasn't seriously considering doing that optimisation.
Perhaps just hoping is might make a compiler person think :-)

	David

> 
> Do you have any perf test?
> 
> Thanks,
> Yury


