Return-Path: <bpf+bounces-47378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F319F8905
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 01:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BADD188F323
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A12594A8;
	Fri, 20 Dec 2024 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk5xk8do"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BBC1CAA4
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734655198; cv=none; b=cZnnfg721cp3GRWQgs+uR/C4xJLD29EN6Pb/6Kk743HbOYfhRQsrY17y98Pj+a6YiHlJmVnVeH4j+owxwwcBGlKofgpYJpX2KHEfIkzuwZN03MbLuvM19zeOqlcGQaNvxV29Se0V2c4WbArb1rTsbfifThkzIdguTX23nxFf1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734655198; c=relaxed/simple;
	bh=rnqGl7X3esX6zT9fLvXAZ2pTe86bX6I23CyIodwOCo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLDCljTtcJiRmfDycKL5X5889JmUyjuPdvQ3MN+Rc7KUzFCbGR8wrV1tS086wQoVxNuTopP0Lr6krK0ai8FvNXSqAy+ybos71KJogddUXb4xgCPUdSS+AK7Kx2iLllLIjpaRMTtRT5psy6K9EcQSAaiqsZoN9cPlUCi9GSwYw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk5xk8do; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38632b8ae71so1045484f8f.0
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 16:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734655195; x=1735259995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04DMK2CBlaYgVmHyWh5D3Gtkvb9UdRG0+YSphVQgFvw=;
        b=Dk5xk8dorkhGKFVwMAHgPL70E0BKdzMJ4tTD/f9MBb943kXbDUkXl2z9GDuLhSbRny
         NcT2w5ouYS1p2BKG+bpuFVwXATX/Ib51FUdNHl1fO21+uTM2LzfxyTKrccTHeXH6hhRc
         2Xgkv4+o51ngBQKWIQl7YTKScs09z0fuHknEpmsgS1JQ+PAM+zgTw1/iqHnuXkdm8OHC
         Vlt1WukR7SOliFHUbmEgrpqAH1gw6fkGK4ij6Nzb2NWpf1ztwM9Y2tOCLZR6OXyVsvO1
         sD2sZqHK4oj2L2LlHMNfY/ab3C7dMUQeJOzmYkXiQ9WzE+CgJMtrMjzKrNBQPOhabt9I
         OAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734655195; x=1735259995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04DMK2CBlaYgVmHyWh5D3Gtkvb9UdRG0+YSphVQgFvw=;
        b=WbIWW4RT72vLU0IFa1wAr49uA6WwRPK3jNP+BuZnRXGEYCS3PzdqM7Q2QpmXBhDrc1
         5a7oJXjqHgUq4TdwaELPVEp8EJYDUNLB2ECvMvpkUQ47oz7jMt1yhKI93Ti+tf+JEm/X
         r/tMfMzPhwzpGczjzKOEJITK16VHbdf359RKAdDepFRmy403j96p7Q0NrieYJtblD3OI
         AEKYbJLmU5ccK/s7WXJ14WqwurRCFLDr/2aJRxcgsvItiGRWj7FL5Pz7VBJ4/edCSegL
         eUx2XsnGGhysHhMmlFPCLvMfHo/FJ0fAIB8Ler0UimfMzRx0jdTA6vtLLCkPO5d0hp+E
         5ccw==
X-Gm-Message-State: AOJu0YwtYBeyv8nMymZDPobmjFFV+8vcPdhtidGWCOyYaEdmNcu8P9On
	xMr63qLTSnwUoOl6r2A91RDTf3R8hfj+0XT5QlE4KgaYr2U5hWEhFjnY1tBd83EgGX0OIzi869n
	NVYht3vnIC8dRzknPgBY560ACtqc=
X-Gm-Gg: ASbGncs0/rTRMeO6lwdZtMhyFlLQ0/e0f+ON8I5qMzoD+USSWH6+Uu7AgZ1dsAQcoLK
	YEYGFc2yCsoT67nxLD6iPMbjdV7/3PfvN/r8VUQ==
X-Google-Smtp-Source: AGHT+IFDryDjaUKXZCODMa0NSyOxFIrLFC1sf5j4TOLkzW4dPJsrH5UZoPI/WEYgmMzo2wmrfC0Ri/2Yxfd+h7Ydi3U=
X-Received: by 2002:a5d:6d09:0:b0:385:e43a:4ded with SMTP id
 ffacd0b85a97d-38a223ff460mr742092f8f.57.1734655195080; Thu, 19 Dec 2024
 16:39:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-5-alexei.starovoitov@gmail.com> <Z2Ky2idzyPn08JE-@tiehlicka>
 <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>
 <Z2PGetahl-7EcoIi@tiehlicka> <Z2PKyU3hJY5e0DUE@tiehlicka> <Z2PQv8dVNBopIiYN@tiehlicka>
In-Reply-To: <Z2PQv8dVNBopIiYN@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Dec 2024 16:39:43 -0800
Message-ID: <CAADnVQLm=gSAh2u3iF4HoGmLEqa-AV0FAEnDqcoFYDgZ06d+gQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg stock_lock.
To: Michal Hocko <mhocko@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 11:52=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 19-12-24 08:27:06, Michal Hocko wrote:
> > On Thu 19-12-24 08:08:44, Michal Hocko wrote:
> > > All that being said, the message I wanted to get through is that atom=
ic
> > > (NOWAIT) charges could be trully reentrant if the stock local lock us=
es
> > > trylock. We do not need a dedicated gfp flag for that now.
> >
> > And I want to add. Not only we can achieve that, I also think this is
> > desirable because for !RT this will be no functional change and for RT
> > it makes more sense to simply do deterministic (albeit more costly
> > page_counter update) than spin over a lock to use the batch (or learn
> > the batch cannot be used).
>
> So effectively this on top of yours
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f168d223375f..29a831f6109c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1768,7 +1768,7 @@ static bool consume_stock(struct mem_cgroup *memcg,=
 unsigned int nr_pages,
>                 return ret;
>
>         if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> -               if (gfp_mask & __GFP_TRYLOCK)
> +               if (!gfpflags_allow_blockingk(gfp_mask))
>                         return ret;
>                 local_lock_irqsave(&memcg_stock.stock_lock, flags);

I don't quite understand such a strong desire to avoid the new GFP flag
especially when it's in mm/internal.h. There are lots of bits left.
It's not like PF_* flags that are limited, but fine
let's try to avoid GFP_TRYLOCK_BIT.

You're correct that in !RT the above will work, but in RT
spin_trylock vs spin_lock might cause spurious direct page_counter
charge instead of batching. It's still correct and unlikely to
cause performance issues, so probably fine, but in other
places like slub.c gfpflags_allow_blocking() is too coarse.
All of GFP_NOWAIT will fall into such 'trylock' category,
more slub bits will be trylock-ing and potentially returning ENOMEM
for existing GPF_NOWAIT users which is not great.

I think we can do better, though it's a bit odd to indicate
trylock gfp mode by _absence_ of flags instead of presence
of __GFP_TRYLOCK bit.

How about the following:

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ff9060af6295..f06131d5234f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,6 +39,17 @@ static inline bool gfpflags_allow_blocking(const
gfp_t gfp_flags)
        return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
 }

+static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
+{
+       /*
+        * !__GFP_DIRECT_RECLAIM -> direct claim is not allowed.
+        * !__GFP_KSWAPD_RECLAIM -> it's not safe to wake up kswapd.
+        * All GFP_* flags including GFP_NOWAIT use one or both flags.
+        * try_alloc_pages() is the only API that doesn't specify either fl=
ag.
+        */
+       return !(gfp_flags & __GFP_RECLAIM);
+}
+
 #ifdef CONFIG_HIGHMEM
 #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f168d223375f..545d345c22de 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1768,7 +1768,7 @@ static bool consume_stock(struct mem_cgroup
*memcg, unsigned int nr_pages,
                return ret;

        if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
-               if (gfp_mask & __GFP_TRYLOCK)
+               if (!gfpflags_allow_spinning(gfp_mask))
                        return ret;
                local_lock_irqsave(&memcg_stock.stock_lock, flags);
        }

If that's acceptable then such an approach will work for
my slub.c reentrance changes too.
GPF_NOWAIT users will not be affected.
The slub's trylock mode will be only for my upcoming try_kmalloc()
that won't use either gfp_*_reclaim flag.

