Return-Path: <bpf+bounces-52366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06827A42654
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 16:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394953A936E
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941152192E7;
	Mon, 24 Feb 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+3Hp/Tn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1F1DC998;
	Mon, 24 Feb 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410838; cv=none; b=ICCLgVQz+WNPxxOTX97mAb6sj4InZUJFFQNN6RrQv4b1c1WNN1ynP1+q365l48aIav98+SNIRBGzbzNdRM9oLDayK+qeNyNEkG2p5DEC80Q3vjwbfvJZH4+Ag1PNjFgc6LQhqTm2Va7M9Mrbxfvo6G7gy/qifRsW9D1yYpBQsx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410838; c=relaxed/simple;
	bh=rhmDr4HJgDLSEVXyelVTEjpXOHwjjqq78Ihle3V/xZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2D+ODWhP5lNdxHa8iD/Qic2EcG1xiPOsB6AnqikBgenSZxeSJXrcslXmERLCY49+nW4xTWAwP0IgcSYwvzT6sm01KJct7WjV0I5SWcXYf/bVhVdpeIMpkMsiUG9IEChtBtQTRN5L62ckX1POK6DR2IHAwNAAV6SwI1L2GdSCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+3Hp/Tn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c665ef4cso78434685ad.3;
        Mon, 24 Feb 2025 07:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410836; x=1741015636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVMni6CCCY2us6Xo8mKZ2xt3KdSK/Spp1dIxAZpVn4s=;
        b=T+3Hp/TnVcXMMguVhvfXZg8Cq+yBW91eosEjUnxOGMHghb4fjftMeUdVHv7Z4Hd/3L
         WeEGAt1zapTkYM5jt7WGPd9cqabJdJSudG730OZENCKm14YfEwQdAfxpeiK5oBBOJTuj
         aiJwoA1AuaphBCxmHPCHDTwpbMG59IJV4sLBjax0uTn8hbxyHaxCWeqrIFUcYwfmKSBv
         fmtDLPmDfrU2nktkS9xPuhHQ6LpkCaYfcZDNw5YO7IuK/MmZQE5VeEjjrirkrEHm7gcD
         ZGxFtCR4U26GckMXkNPEOcrQoHvnJ709Tv1Ug2frkx3tP09+nFp1fdX25I4roUwCFBY7
         yaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410836; x=1741015636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVMni6CCCY2us6Xo8mKZ2xt3KdSK/Spp1dIxAZpVn4s=;
        b=eNrFgmgrD6+EoKLZYpgOuIwN26dfiLe3vZ946mxdXGEvPrLfn4KFuFG7OB1wiO3OZj
         7bm2TgDcsH2UZZgS7ERO3y9PanlEFSnRtBn3ZgY+cf2DZQQ5BUiItKbl/s9p9gIRKxA1
         mDOuyN0n8auqSnjz2fHLkCRp4PZp9sbHo1NBC2Sx23cmVpPTAci1l+4we2z0tkw1EKDE
         akmy685HV7e4iEA41608O9+WZzSHIByNtstRwZLIVIdEg8GRCDA6rLv5jzKp9XnFR1eZ
         WSFqbYfn0aOo2BkzH68pWSdXh0Z4RmqKAIGA8Y/lcWZNVgUkN1UdX1pf1DgJBz1UmnZt
         Vrxg==
X-Forwarded-Encrypted: i=1; AJvYcCUpV1vgHxuKl9I/zewx0LSG5/cn57JgneIZ4is5rUn40iMrflS3fjsNEFNBkKeY7QEB+kb5X6oLjBzxr0c=@vger.kernel.org, AJvYcCVFXG8VVgSlcphL0ww8A2rSue5WCq0kuGf6x54vdoIbGXiDjJqmmSX1uMycR4xMiyUoFKo0EsiEMWq7cUQTcAM=@vger.kernel.org, AJvYcCVQTb/YlOv6ERcWqv8zgElOcRhfUTHkiPzBdEOFU0NhdfEJawCcuBG9MJo0JnWO9nG8xiqBXKun@vger.kernel.org, AJvYcCVnWpGs9ZvDK/OvaH6AdfUD74hqu8ojan8szZfbUN6LRXtHifU68clHxNuksAFVs23cEMSXUSdWJEFSQzs=@vger.kernel.org, AJvYcCWbbf14bV+UcSAjtNd1KDDqKqa+2dT/QfTz7FOgGKSxKe2T8WXasxWR6IvtDEt0w5/RZdKv/G9mEbG1f7+N@vger.kernel.org, AJvYcCWf4tIiVuCKLJgZjCNeoXemIAb7Frfzn7mnuTvEa9i3+PEqONh4XRh0Fjn1h1SB0JH4wGE=@vger.kernel.org, AJvYcCWuBoqxQM0PrGJx/KTHikviz868Xs3ty3WTZhUy5cznQypV7UNFOUCwxtab9f0KkdT7VHH3MRVsW8GUmze+@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgFvFYzk+4RUhxCK1/JbJ/iY8sj42d+IwLcNsdjwr7N7Ks8Tm
	u5OnQyYAr8dZ+M5bODp+Dmeobup1WDLiAjx09t+4PsValQl5no0f
X-Gm-Gg: ASbGncvsLG3uA8Lch5q0eomY+zTvXzASLlW898iM5ZEGXsYBcgQ16ClYkiK8pBAGAP7
	h1Hm0ztMllyDxcLaG+A14Y1SYB3YJkFop4X13iDbDrUX6iz/zH3DXacB+OjukoDha4OVJvNOtBx
	ykslQCQxLnchI1Y6RB3Fn4KpJ5z7Gouv9JRNkCiHDPpDv6mmjPmC9xtlOgi8WDIg8JY+osjbrVC
	oYNeCQFpdAFWevhqg+4zmwdL+6HXQ8c/gdPB598iyOkZXonv5rH+T0NQwQAuwEbkJ2de99IRVIN
	OtclIJP89P3IB0z0FbTBpwkMBtEK
X-Google-Smtp-Source: AGHT+IFl+fmLe2Snker6fx4GB6SiAhwknYLzw9iuDcRtyo7AdhlkRr95Yy6wYLAjG0rHC6oLfbqCGA==
X-Received: by 2002:a05:6a00:cce:b0:732:6214:35f5 with SMTP id d2e1a72fcca58-73426c8d21fmr17154986b3a.1.1740410835401;
        Mon, 24 Feb 2025 07:27:15 -0800 (PST)
Received: from eleanor-wkdl ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7346d9b1af1sm1359758b3a.71.2025.02.24.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:27:14 -0800 (PST)
Date: Mon, 24 Feb 2025 23:27:01 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
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
	jirislaby@kernel.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, hpa@zytor.com, alistair@popple.id.au,
	linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 00/17] Introduce and use generic parity32/64 helper
Message-ID: <Z7yPxdiLLXlsWSQN@eleanor-wkdl>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <602e03fd-ce4b-feef-5053-e95834ab35d7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602e03fd-ce4b-feef-5053-e95834ab35d7@gmail.com>

On Sun, Feb 23, 2025 at 09:25:42PM +0100, Uros Bizjak wrote:
> 
> Please note that GCC (and clang) provide __builtin_parity{,l,ll}() family of
> builtin functions. Recently, I have tried to use this builtin in a couple of
> places [1], [2], but I had to retract the patches, because __builtin
> functions aren't strictly required to be inlined and can generate a library
> call [3].
> 
> As explained in [2], the compilers are able to emit optimized
> target-dependent code (also automatically using popcnt insn when avaialble),
> so ideally the generic parity64() and parity32() would be implemented using
> __builtin_parity(), where the generic library would provide a fallback
> __paritydi2() and __paritysi2() functions, otherwise provided by the
> compiler support library.
> 
> For x86, we would like to exercise the hardware parity calculation or
> optimized code sequences involving HW parity calculation, as shown in [1]
> and [2].
> 
> [1] https://lore.kernel.org/lkml/20250129205746.10963-1-ubizjak@gmail.com/
> 
> [2] https://lore.kernel.org/lkml/20250129154920.6773-2-ubizjak@gmail.com/
> 
> [3] https://lore.kernel.org/linux-mm/CAKbZUD0N7bkuw_Le3Pr9o1V2BjjcY_YiLm8a8DPceubTdZ00GQ@mail.gmail.com/

Hi Uros,
Thanks for your information.

We originally planned to implement hardware optimizations after this
patch series. However, for V2, We will incorporate __builtin_parity(),
while keeping our current implementation as the fallback function.

Best regards,
Yu-Chun Lin

