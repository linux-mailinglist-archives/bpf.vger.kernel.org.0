Return-Path: <bpf+bounces-21511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253E584E46D
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A61C20E0B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268437C08A;
	Thu,  8 Feb 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrbMCBcc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB017B3E1
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407633; cv=none; b=kQsk6vT3ZMGYFe4OdkLdZKE/oLER7Hvyoww98IkYaPnUoZfb5u4JELguL7KOm8lPbPo5x+Bt0ZONiXEqP//TmMwuuq8Xwk3/v1rn0Agb3xKBzKbCJ19HSIQ0p9HLdvTdlI3nXMQmNOXPxYe35p8s+8tCmBZ/yhDmmc4QuJewGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407633; c=relaxed/simple;
	bh=otwl2nY7/BK1fmTT7+dYiHV++ob9uU/UCDXuzNCcNjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FF1YkYfKtqO5pUjgnWyWl+YN6wvSgtgdZcy5S97b39u01cIxUPpbWejVRyL0rxQyda+MOf2X8xa0nwjl+iVOYMnU2tkFKjE799GqilJESq8OphomU2M1fhNUFjZN/g024Cwf46zT6VwBctjDiTQsKHgdMnCtFjbV1ldqRuFpOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrbMCBcc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so2634387a12.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 07:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707407630; x=1708012430; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PvH+cXf2Op/ikRuL+kCCOwQ2FkLjUYBZyCECas4VmrY=;
        b=jrbMCBcc8D3MrpPKQPAfIXza0Uu+UX1Pbeak2kOoqwv2eizge10IjtRuE3nebXE3Dt
         c2vsaoNGkMZ7R/uGwTqZ4w2Rc+m7ccVX6UWR/fmpWuljfVUrdzuWOTwAZuz+SPt9DwM4
         +o2895V5q/HyMKBxeTstbPkyV3Ef+4NAhsN6409sDHz39yd8o5ZOiTFpK1Y2d+NjyMvg
         M7tN275sS/5LaRxQLKC3fhDuEXsWHK6m/TzlgZ/As/MQpXVNC0Hm4EvG4TBgmCVJF8Ew
         cBGFrMPdwPfoPeBuIihAoi2ttI9y6ZMNiBsba8L3qJrTDeLfs7KTbt/rdqa02qYo0AZu
         x8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407630; x=1708012430;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvH+cXf2Op/ikRuL+kCCOwQ2FkLjUYBZyCECas4VmrY=;
        b=by747+bG8s6h+9yRKo7VErquYziIKG6ZQTapHYsmwlPgVK4q/yldVgBVhVg8BnG5FV
         /cNuz7E+mnrLdJQXcViZAArFEHgIiGXbezv95lqdMxW2zc47AzsPTxGSM9cRMZB9Zwm8
         YEDqlW2SUYT7/SPgFKfPWGtEKcyxUyEzC8Ksz0tl2F1xWl7hbLism4mpB14O4dae5Uwu
         ipoPMJpA1I53E4b5e9V8pJ46oFyewU98GgmpeJDtgLcOzNfxMjz7IfLpdPzZuiMB528Q
         HnVx17TFqe2mF8GQxYd/GV3gJAo6VkyjA5FffacJG8jIBDFjj9oHfal0TQL5OF7M3St/
         HcHA==
X-Gm-Message-State: AOJu0YzzTd3SDYt8LPCRUTP7HEvH5u/tP8VK4qMkj7PxwqVgbROUmBii
	r8CuxcCUXXvhqfTB6g8KHgVAVK/OT0gf6DUGT9vMJ6gvs0GtAOI9
X-Google-Smtp-Source: AGHT+IGAJZm/kI8XTedlQFs9QbCQIvUR9V93VXdH2SdDU8zYZ8xCprKWooAvoIJ5zym/E0rHKs64BA==
X-Received: by 2002:aa7:c88f:0:b0:560:5078:3307 with SMTP id p15-20020aa7c88f000000b0056050783307mr6804222eds.13.1707407630069;
        Thu, 08 Feb 2024 07:53:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJW+mTWfQHv1LI6RBWwOXVIoZb7f1tqvREYOKmAng+acaQJ1Hz9qtxWEhkP3nQD21CVR+zr7tRUo47jDgInAN+eBo0xrJbFXiCtLk83PI4RJF6SAy3gfyUR52uKltsg/Dry14WKXB4CH+2jzdvyGvUXjQr665pRgMzIDX8/RTBihqmneYbx0KQEKM0DF4vn7o1ImWti/hnvs/UeVZydnj4y+IfQJI=
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ds10-20020a0564021cca00b00560e061a99dsm955054edb.6.2024.02.08.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:53:49 -0800 (PST)
Message-ID: <7d2b05bf2e7ae7c95807ac4b2a9664f203facbfe.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, Yonghong
 Song <yhs@meta.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 david.faust@oracle.com, cupertino.miranda@oracle.com
Date: Thu, 08 Feb 2024 17:53:48 +0200
In-Reply-To: <87il2zdl43.fsf@oracle.com>
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	 <c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	 <87h6ijfayj.fsf@oracle.com> <87wmrfdsk7.fsf@oracle.com>
	 <4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
	 <87o7crdmjn.fsf@oracle.com>
	 <eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
	 <87il2zdl43.fsf@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 16:35 +0100, Jose E. Marchesi wrote:
[...]

> If the compiler generates assembly code the same code for profile2.c for
> before and after, that means that the loop does _not_ get unrolled when
> profiler.inc.h is built with -O2 but without #pragma unroll.
>=20
> But what if #pragma unroll is used?  If it unrolls then, that would mean
> that the pragma does something more than -funroll-loops/-O2.
>=20
> Sorry if I am not making sense.  Stuff like this confuses me to no end
> ;)

Sorry, I messed up while switching branches :(
Here are the correct stats:

| File            | insn # | insn # |
|                 | before |  after |
|-----------------+--------+--------|
| profiler1.bpf.o |  16716 |   4813 |
| profiler2.bpf.o |   2088 |   2050 |
| profiler3.bpf.o |   4465 |   1690 |

