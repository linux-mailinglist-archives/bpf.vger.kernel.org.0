Return-Path: <bpf+bounces-68690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4DDB815F5
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32AE67B4775
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC1D3002A8;
	Wed, 17 Sep 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mer9APQ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13B308F15
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134463; cv=none; b=Zpdz25mgK7o2GmLNBAludnuJbbRlZnJHZc/4XLiyRFeGIqWwDVoYFgdRe8GtaGrnDTW2QZMmazM6UzLlEwDRw7KRxHuKqiesgifVAZO2PQiaYxrTOd5QpSw4DCGArzIwsCn43qIM/3CaC04MNs7fr4kDs9IUYHRXEvBmDvSbsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134463; c=relaxed/simple;
	bh=w4m40o9ZPKTMCwPCfIJV5wUzBbdpAJYBIhwgx5ZOVek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cp1wAIzgR4dp9wC/uMp4zQ0FF0dFRppOWcfoL7lXskcWTCy9Fifv8SlH1f15nSxA3ohOPadInTFTMXEyLUUtalqaDkorPQ94FHFD3O33rlnA7ZBAIOuBM3gOg+rRkfTISh3Vd0+IOjdcI/Pl5KKIl12h4iBekw7Wu/oHxXt/YoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mer9APQ+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so959585e9.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758134461; x=1758739261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4m40o9ZPKTMCwPCfIJV5wUzBbdpAJYBIhwgx5ZOVek=;
        b=mer9APQ+cuKk7+QjMZgTwp794u+x4BOIUOIyD2gSrHI/Ghg4fFezvIvURZE7UetVB6
         pVeRKo6EuJVZ99FQw+b6k3rtkmaCLIUmkopdmyh5FlMG685ob0rTdwut2APuSAAf9ssZ
         TryKttP89sB0e0H5yP9M53SGC22MC/8YdoDOgsVpg1dzV9qyDA6pHCuTGmhMiqFIApWm
         uBJw+7bijbvBwwMdZ7shSCACD46QPTjdXG1MogMrSfVyCj4ePld9/n409oUxWZ6KbdAb
         pZ5hrsjB7DMYIQJilIpsoFEchI6iauAQprOnbau1Uih1GCixsKEpXoJcxdtp+Tl2AjJh
         Nvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758134461; x=1758739261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4m40o9ZPKTMCwPCfIJV5wUzBbdpAJYBIhwgx5ZOVek=;
        b=cK+ixdkKQFL1s6NpINAV9dtgqyI22IWy0zhTjf5JlRTnQILqJuQeQSmYa5sz835XKH
         5cs4P/smW9ZemlEs7SD7JNVO2HZPn5+xS5CA9kZcvMBGXe9oU7dBq0HGtsMqbwn7d661
         IQB3g9bIwIFBNm/VNzR6rX+QJH4f9/UQrLLVCkUxoutAW4O8zLv1gBoZWKMOMjoQ0GQJ
         5o19C8wj1ROroWnbIHn7mmKqE7ee10dZ0BG8cA2kVaqb+77qvn/+fJoJeeN64DWXXiRD
         VBemTM0bX9wgqjxopKSEN7uDCAQDFV20jaE3RRoVP+A/6DGKr/nEx5FtFzu1LQtoO0jz
         sAnA==
X-Forwarded-Encrypted: i=1; AJvYcCUGcirmPal+juvAEEjLxUHVQPM0dMtrmofe0j4OXExwfbPMrkJFqVOqbSpOis5XIcUd6Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqSnfefBlrclvHLpxBOzcAK+VSnVlG+RsMe2BhvFZrL1GiGdo
	hYCmKjWbXuyxKIPHiO8BlKLhm0d6ypGc2oDgAzgqfyQOfMr0v+CdvUomVTgOVqGqSfEpf8xFz0u
	Jca01o/5fGrjdI0Z5cCBD8EJBMswSAl+trw==
X-Gm-Gg: ASbGncu5IpO25VOzOLQWTRnLH/BydN8OCznPEwGl9Sr83eeLr4hRwsE0SAIJYbYGGQU
	3bzVWga8ig7UwuGkRwycijr3Mxq8+jEOey7/eDCsBBJp4BrxjKNUZjFWyeWTiSE5gNHoHd/Q2Iy
	tHMTpITFVuPDkcj2pzc2HhzR37P8SNSNXYZD1kEpFvAklgo9mpwsgTvMAIG1SYJEqUOLNjBRreI
	YUQ487qyHijmfK1CAvJP450H5uZVExcEGls
X-Google-Smtp-Source: AGHT+IEr/Zm4Pxly+Efbv6sNYcUut7LfEU4UTikXIVrxYEdaISjLHguHk43hV30oxPl4SaJojIG0lHAi9h0Ph0jNBHQ=
X-Received: by 2002:a05:600c:450f:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-46206a2b929mr28099785e9.27.1758134460571; Wed, 17 Sep 2025
 11:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
 <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz> <aMlZ8Au2MBikJgta@hyeyoo>
 <e7d1c20c-7164-4319-ac7e-9df0072a12ad@suse.cz> <CAADnVQLNm+0ZwX2MN_JK3ookGxpOGxEdwaaroQk+rGB401E8Jg@mail.gmail.com>
 <0beac436-1905-4542-aebe-92074aaea54f@suse.cz> <CAADnVQJbj3OqS9x6MOmnmHa=69ACVEKa=QX-KVAncyocjCn1AQ@mail.gmail.com>
 <c370486e-cb8f-4201-b70e-2bdddab9e642@suse.cz> <CAADnVQL6xGz8=NTDs=3wPfaEqxUjfQE98h5Q2ex-iyRs4yemiw@mail.gmail.com>
 <aMpdAVKZBLltOElH@hyeyoo> <aMpeADsz1Znaz8AU@hyeyoo> <CAADnVQ+sKKV+-Ee61Bxma+=MN4unGLRypAnfqHuLOtHM6T=HEA@mail.gmail.com>
 <ade5442f-6257-498f-bffd-5fc4b1d5858f@suse.cz>
In-Reply-To: <ade5442f-6257-498f-bffd-5fc4b1d5858f@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Sep 2025 11:40:49 -0700
X-Gm-Features: AS18NWCKkOmsGuqHqNCm235rRDn6_iVaWC-ke90mDrNQHKL2y4zWb_MZh87_Ljw
Message-ID: <CAADnVQKfj23PocEfe1XMa6uMz0N-Z4O9YG+JqzY5E3_bLNA1Tg@mail.gmail.com>
Subject: Re: [PATCH slab] slab: Disallow kprobes in ___slab_alloc()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:34=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
>
> Ah right, I did add one based on your commit log and this conversation:
>
> +/*
> + * We disallow kprobes in ___slab_alloc() to prevent reentrance
> + *
> + * kmalloc() -> ___slab_alloc() -> local_lock_cpu_slab() protected part =
of
> + * ___slab_alloc() manipulating c->freelist -> kprobe -> bpf ->
> + * kmalloc_nolock() or kfree_nolock() -> __update_cpu_freelist_fast()
> + * manipulating c->freelist without lock.
> + *
> + * This does not prevent kprobe in functions called from ___slab_alloc()=
 such as
> + * local_lock_irqsave() itself, and that is fine, we only need to protec=
t the
> + * c->freelist manipulation in ___slab_alloc() itself.
> + */
> +NOKPROBE_SYMBOL(___slab_alloc);

Perfect. Short and to the point. Thanks!

