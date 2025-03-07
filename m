Return-Path: <bpf+bounces-53590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A031A56CAD
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38F6189533B
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901A9220699;
	Fri,  7 Mar 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoNSryUg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833121D58C;
	Fri,  7 Mar 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362917; cv=none; b=An26vNhBwEy2zQMHYU8LUN6HBAjjseR9B7zyIni82wCflsoy4K1p7/C752MlCfA9zpV8//PVv2Qj4wh7Ae9Z0rNub5q85+pNvHs9NmgdSnBSqGIpw3UeuogJohzhd1hPrmxOpl+8+D3yriq+uMtQpvRFIKTinjS7w4r/euEu+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362917; c=relaxed/simple;
	bh=tzrS+lI9W7w2w8k6AVE6C+sBU6gvdTLX5BacFbhKkPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFS0s25W/Kegb1/hJwypJrcXJNHcTxSBVBoCwOnZZPeLt3UG8F53m0sf23YMlcoVNGBrKXlcE/AXdXHkoZJnIykVvEMh17Iz12rlBqoXap4Xf9p2jTvCpIbCWiuVEzYTRnraziKtlmNOqKUM9UgpqTUK4GQvYdU3tMREvs9uTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoNSryUg; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e549be93d5eso1809081276.1;
        Fri, 07 Mar 2025 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741362914; x=1741967714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IySwQu8sBAq2SiiOusmnVT2gVfPlf25OMd3Kg55m+0M=;
        b=MoNSryUgYwzQerG+wqBnZ3LwaxBw5rKz1lrFhtPwodTPOWzrJaFLUkB16VDIZ3Osn3
         IEbbIk0qiamuy5RPiTk/F9+OTn9vVa0s/LJpiJALEeyfnB4GGPyJeuOgqEXFWbYnmGzr
         RKrmSsmpKryN2PmE8OIJ3ZqsjgIA+tMOwGzdP/rbySqiHj0n+uWKb4JFl4w/+d9ByAZt
         xDwODih1iWvqoGe+00JY9odyDslhqflV7z6madXRtpagTVq4F9TDnaNi43PiEB7eHzCe
         DLtF/9aEjdwpX9scT05HRKfRYZF9QRDf3MtXs6PrFJOMGkqPUVpL53Q+1VmrNaDIu75b
         Hhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362914; x=1741967714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IySwQu8sBAq2SiiOusmnVT2gVfPlf25OMd3Kg55m+0M=;
        b=Sa5P45M01YrxIk2iUH8FYbd5ZuzI4NfbNW9JEw5TLnG76V1qVuEAJBkR/HATHM8DUW
         J6BRQ481ZQK7ISjHkrC+cIrkmeUvnAgbKApE8tGuPa/AH1T8end/4rPtdtZLXe+N7XK/
         kHp4TGw94jVWOThwnXPic9atW7IC3vqiRmG+MEvVUToFedIe4FggCZGvpyTlBz3yJmUA
         W1YnAddg3aRabApA6wm4BgO2dhod16yAgLfKuJhZJo0lRhxVt0h2it81fXmzHbSu/fDT
         6CQQrcUYboSqps+g9f8yCmTFTuBRohHo6j47fHa57Ye6IJIWHpn337lwTC/1Awr/zXKw
         Tc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhuWYJxV5fBa8kyCJMhqbB1L3XcqMLwdtoQ+byuLKEX6WTiJsLYn8aY7KjoFuIOos1n9s5kmS7@vger.kernel.org, AJvYcCUq393gUss7rzw4GRMC2SmkmcEBNHEbVnl8/4+7eRNF7gQMKcNV5uSoYqlngqq2MJfc932kKzAjlEUJ+Vp4@vger.kernel.org, AJvYcCVo+cd6/iOdkubleklrMUpyYU6cUxrIQoTZ7Ip8bZeL73dIZdrXAv49D/LLqRmtWID4mI1NORYHlfRytPeOCKI=@vger.kernel.org, AJvYcCW7c+uKZUDGiWXG/Ngvx72IhE814vfXzSJiMylH91JsJ9iPigLBClzE3WSkd+wScVSILnxpgMQK6oGSapeq@vger.kernel.org, AJvYcCWGO86lryyZPaLQRm9Lyk9QNfYYkzNfFO9k4mc9BZBrCXcouzJD842GI+rD36B+nhm78xc=@vger.kernel.org, AJvYcCX0j+97TcVPh+Co5rVgE71IinFPEx7UF3GT70qjFFrll+qRSoOf79Iu4nEWFegXrAT0POzxqCSmmF23lPc=@vger.kernel.org, AJvYcCXU1uvyht2x1BjqtB2Z8N8lNyl+bk0xueIjZGqZJuQ/r/6qJW+POeTERqBHKj2PlOnxnWPsj+zpP1qDMe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpUb3lo34ZsMPgOZjI6dSQqdILNXqbzmnKMyVkfypdeViQbMg
	kqS3UleZcuNIjz57AOYqmlE9JK5T3o15wJd9Svr2V9Kk6pb/PuBW
X-Gm-Gg: ASbGncuheKUa6QfnJC/P9wknbtwLVyRiRiTBO96kNw6dvJcv6U7NL4r/6pgMw3vGIzy
	mxlRSwfJ/sIg5S4ilj3aBRQ/tiWB3g7eJ2PjeKioC/qLqE/FWs10GdIN8Jj7z/aKDI4x2ipASou
	ygz83pbH1Q39PPMmgBTcEHg76FxTP2ujDCatDkOzHQ0am1SeDrNxPkHmTfogDKp6RjctJKukyRM
	5BfhvWOTm51Qwt1Xij3oeMSFKUHadk9S3Ktgg50c04kvr442YQdPUJrvPPtdvwzEo78EIEghSwB
	oVFPXZ78ZVHdUbmCjvD0A84KhG2mwQo702B8eqas87gX6yzX//ZSSZgV48NEqJlZ6bgZdxrtBJ2
	57cqS
X-Google-Smtp-Source: AGHT+IGXsVm03RpeRs7naE92Mk1v2+BdYsqkQh0ckjckzDu/bnevFLrinU7kQnO5Z9/M1SdGBh4guA==
X-Received: by 2002:a05:6902:2292:b0:e60:c79f:6f6c with SMTP id 3f1490d57ef6-e635c0f80admr4791285276.8.1741362914172;
        Fri, 07 Mar 2025 07:55:14 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e635e4c8f69sm386658276.42.2025.03.07.07.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:55:13 -0800 (PST)
Date: Fri, 7 Mar 2025 10:55:13 -0500
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
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Message-ID: <Z8sW4c5LxV-ITdCi@thinkpad>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
 <3dfc81eb-caa1-42fe-8fd6-61101de0ef13@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dfc81eb-caa1-42fe-8fd6-61101de0ef13@kernel.org>

On Fri, Mar 07, 2025 at 07:57:48AM +0100, Jiri Slaby wrote:
> On 06. 03. 25, 17:25, Kuan-Wei Chiu wrote:
> > Several parts of the kernel contain redundant implementations of parity
> > calculations for 16/32/64-bit values. Introduces generic
> > parity16/32/64() helpers in bitops.h, providing a standardized
> > and optimized implementation.
> > 
> > Subsequent patches refactor various kernel components to replace
> > open-coded parity calculations with the new helpers, reducing code
> > duplication and improving maintainability.
> > 
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > In v3, I use parityXX() instead of the parity() macro since the
> > parity() macro may generate suboptimal code and requires special hacks
> > to make GCC happy. If anyone still prefers a single parity() macro,
> > please let me know.
> 
> What is suboptimal and where exactly it matters? Have you actually measured
> it?

I asked exactly this question at least 3 times, and have never
received perf tests or asm listings - nothing. I've never received
any comments from driver maintainers about how performance of the
parity() is important for them, as well.

With the absence of _any_ feedback, I'm not going to take this series,
of course, for the reason: overengineering.

With that said, the simplest way would be replacing parity8(u8) with
parity(u64) 'one size fits all' thing. I even made a one extra step,
suggesting a macro that would generate a better code for smaller types
with almost no extra maintenance burden. This is another acceptable
option to me.

Thanks,
Yury

