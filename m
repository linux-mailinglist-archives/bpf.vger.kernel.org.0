Return-Path: <bpf+bounces-46565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44D99EBC08
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F10F169160
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62D2397B5;
	Tue, 10 Dec 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxP76mYa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6062397AE
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866940; cv=none; b=HQT8LHs8/cy7M6X9aRGDjtAZ7tOCEGgiELm+pnaIsJgYl9IIshrJGHugzYhJez5xk7oLZr59FCfGxGdzJtqQpTKTCc4fxXCQRsSxBv/Tear6R11HbNGV1fdO6REdgq0hRUrBqcdgBY/PTiXo7wU5DT9k/EPF3swURezVad47w0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866940; c=relaxed/simple;
	bh=itI5QQNO8xYKV9K/QwP+NypLaOTH+CZuCwmK9qZErUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uudHgdBslHKLv5GMStT//NRSUWeYmlsO+MQERIN0TyT0p8ZtFgqpVsHvdv12ZMC0mTUMbSIRWcserAZ2+REXomXn7iByEttD53ZlYNRYi3HRRD3WcrkUGmbIUSaCLI6g1UEWI3vOa6004FdXwS9KpHrOQueX3vu3EXo8I9LwQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxP76mYa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862a4b8ec2so2514971f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 13:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733866937; x=1734471737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5IyZr+Bqc3//eKJGXRw2aACPDfKvgH+OJy5cnCfcD0=;
        b=gxP76mYa2sf/gMA40Tlx6DUv9105D0mvMWgL+Kvs87qk2QQz6lCK7HVUarovHzfZIW
         GFpDV19Dh2TlNlSRo8gRzayi2uCUsWDYtKlZmqwk8MP1CroDneLNI4ByRK9XQksu/iFC
         x8vNSbfzSKAIu4A993LtxHJzutgEMAHAYF3qDKsNgm2QrH7ncFjVj+oQQEdixoVye8JH
         2EGBffQkQOm6HqH7JerLfdNNTN1neQD1s777qByTU6JkSSvY/vn7uezIFnUN7on8Pr3l
         u0NOyCOzRwFPBxY7EVwfpEKiT6JTVlwlcnkU1mLkm3gv9er+i+ps/zwnBNgWXmo4NuUm
         9JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866937; x=1734471737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5IyZr+Bqc3//eKJGXRw2aACPDfKvgH+OJy5cnCfcD0=;
        b=FBcIZ4hRXi/t099nVA15tCUoJYsQPG1WyMKizu9W9LOAlFA3ULbyVwukBV2feOb12S
         80IqVEULN6HWnTNnkXD6J7zNAmyhwnVsGlv1NuVm4+CJkrVOVsjFpu3WntlL4/dRFine
         LKMeGQaiaN30DY4AbCmCpNdsCwgH4XA2C7b95pGLTjX4maJeoG9JMUT91gj9Yx60aPvA
         3YP9kir57HJKXxssfO0FiOnwZryrjOPBnf4Gh50uaHs3FJo/90YYPLHplYyiBGvrrOZi
         8Aht8oUuMnT5+GABJEOxEVof5TwwSx3uR5cRM03rWh+n2VvjMRiHOZtCndjqGg0/YXDm
         /G8w==
X-Gm-Message-State: AOJu0Yy/qHoUhCyfUjZkF3Q2hthDdp+yNO+FnTEJXYNAk27eVOEN1Sre
	2VGUjLcq2kbec7lKm3Vo/b/lJdRKIDfWpgGPIJU8Z+2bOaANZBCnMQUDinYTi1mnzAj6krPKv1p
	Am+RTkpjkt7gif2owdcAYTVeD8G/+0Z/E
X-Gm-Gg: ASbGncsr9gfiAEuW3nmK9G8l6myeMxMPJEX70Mz+w3bAR/PoG7lP67sPe2EPwljHVV+
	WOEQNaPEO5l5grvZg4GV7O+Dmhsi3X7U66IAIrHATjLOM7CGiZNc=
X-Google-Smtp-Source: AGHT+IHRXMV1lFc2pyP86vUXtoVTDycn1vVBECYM/6TXKG1ySVASPzUJp/8TO1FjhGw5v5tOUav1fgaVwGILxAU6izY=
X-Received: by 2002:a05:6000:156f:b0:385:efc7:9348 with SMTP id
 ffacd0b85a97d-3864ce86411mr451921f8f.1.1733866936462; Tue, 10 Dec 2024
 13:42:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com> <Z1fSMhHdSTpurYCW@casper.infradead.org>
In-Reply-To: <Z1fSMhHdSTpurYCW@casper.infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 13:42:05 -0800
Message-ID: <CAADnVQK9Mxhmo+CKiedwJD3zffr5y+vzttMS47JNMKiG36Sp1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Matthew Wilcox <willy@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:31=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Dec 09, 2024 at 06:39:31PM -0800, Alexei Starovoitov wrote:
> > +     if (preemptible() && !rcu_preempt_depth())
> > +             return alloc_pages_node_noprof(nid,
> > +                                            GFP_NOWAIT | __GFP_ZERO,
> > +                                            order);
> > +     return alloc_pages_node_noprof(nid,
> > +                                    __GFP_TRYLOCK | __GFP_NOWARN | __G=
FP_ZERO,
> > +                                    order);
>
> [...]
>
> > @@ -4009,7 +4018,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int o=
rder)
> >        * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
> >        */
> >       alloc_flags |=3D (__force int)
> > -             (gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> > +             (gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TR=
YLOCK));
>
> It's not quite clear to me that we need __GFP_TRYLOCK to implement this.
> I was originally wondering if this wasn't a memalloc_nolock_save() /
> memalloc_nolock_restore() situation (akin to memalloc_nofs_save/restore),

Interesting idea. It could be useful to pass extra flags into free_page
path, since it doesn't have flags today and I'm adding free_pages_nolock()
in patch 2 just to pass fpi_t fpi_flags around.

memalloc_nofs_save()-like makes the most sense when there are
multiple allocations and code path attempts to be generic.
For bpf use case it's probably overkill.
I guess we might have both __GFP_TRYLOCK and
memalloc_nolock_save() that clear many flags.
Note it needs to clear __GFP_KSWAPD_RECLAIM which is not safe
when raw spin lock is held.

> but I wonder if we can simply do:
>
>         if (!preemptible() || rcu_preempt_depth())
>                 alloc_flags |=3D ALLOC_TRYLOCK;

I don't think we can do that.
It will penalize existing GFP_ATOMIC/NOWAIT users.
kmalloc from RCU CS with GFP_NOWAIT is fine today.

