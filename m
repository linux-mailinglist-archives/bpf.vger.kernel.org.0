Return-Path: <bpf+bounces-45128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F079F9D1CB4
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 01:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9351F2214E
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 00:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068917557;
	Tue, 19 Nov 2024 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAVFtL8V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2A4D599
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976873; cv=none; b=Xy7MnfTBXP++JRoNmuy4e74JsHrJglokWRVNvwTTsqZhdrLTc8iYHq2pFssIC0lm2j7GNVMxDm6eV3e5Zqzcsfqw7EMJ/DvUBqUODCrsEFEhO6tY1wjiUE2uzhOxvJg9o+S00WK7ZTcuk9JGtBF5e+iWkvMvSCIFxeQVTZS3f4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976873; c=relaxed/simple;
	bh=tLo4BNfk8KXgJ9X3th7yRgnRsXdsZkQzRkUq8Aore/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxNMcRrZXIE22s5uTXVGagfe23aPFVoWIO3EattRWkqI2LIoStyIvrZj+9ccIpr/69znF9AkjztI6+iOTSKIfMZzl8iT/eE/hwsvc5/PTfXXBzcnl4ZmF89WbjKZ0hgo92rpI6Rm+JSuUnftCGPmjGtS1yF722mVRj671BNiVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAVFtL8V; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38232c6311fso1879435f8f.3
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 16:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731976870; x=1732581670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9aKsodd18Jv3X+/nQmaJ45CV7SM0r8uAFAY+sGz9Ss=;
        b=CAVFtL8VmHGvXmUOyV1JTDnx2SbZ3db+jm9i+e4LTxNOjofPygXkijvyjdTFBaDtJ8
         YfmHfxHUQsnm8xnEPkV3Lndq65aOUkctnjeBcYywe9vVpSy01wSWuSLXUsLvfYgUIgZ4
         V86FB6ZWsaKhrV51uYM0WGSax7SJTxNURNdK0s4vVhCujR4PAx8PyCbu15y7FZtYXfud
         bjVS+F27me3f+U4gyAFIp4p56fAftakWC1+E5/bM8EJSJe2WHgnL3SY0z+B3VjfZ1GBh
         wwzdHuYuAaf8djd3eHvHY9rkuXzEIR7pN0hN79eA6zAgPEoPEPJ03EOAY19vcYLsgEFb
         /SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731976870; x=1732581670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9aKsodd18Jv3X+/nQmaJ45CV7SM0r8uAFAY+sGz9Ss=;
        b=GVKJxWjTJqT7aTGfynpyfbfSJiiEHpg/PoRW/ajEn3HWfqgZRlw1vbP3DI4MV38Dk1
         wEUChWRK3BBdGZBLXM718qQ8LiMg9pfYRAqgwUakRgD2L1G7pxgNI6OYG6UfEMWacuTu
         V+oUi3o3uecSqjI23WfGhHE/abaJO7FgyTJH4RGS1kJEH37Gb5N+5ex3+D4p3igkpiDf
         YifDI6k7IRY7WDlSbezAqREQaIsi4HIkFn0wQReHAqrhyCnOHmg7o21g2uxhDqZDfaYr
         QQeRZspkSFWT+KHSI1/5beuc8KlR6R3nxkhqTWnyz/l9+4Clh6vJEcgWb8XobGuJvDbs
         aBbw==
X-Gm-Message-State: AOJu0Yx1l/ugvDtmF4DymuCHH3fzMUmz9RbReSq77BAW0tRDCG1R3lN3
	rrPCHEIB4yVnOObkEbDQtBzGSu/sWye5y+HN2SRnaEHnJff31VP5dZBE6e0cLUKO/WN9gXn/vKM
	xtinQouIfYI3LfeqEFjxYZef0jxKgBe6g
X-Google-Smtp-Source: AGHT+IGpENaHI1Q0srqVr7/11kmWhvyVVybwPsgu0XhsnNR/MzLfaSIGZPp9e1gQ3dWY+UaTA1Ez9/viPLZQp0CQARo=
X-Received: by 2002:a5d:64c8:0:b0:381:f604:3d55 with SMTP id
 ffacd0b85a97d-38225aaf59cmr11333939f8f.52.1731976869660; Mon, 18 Nov 2024
 16:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116014854.55141-1-alexei.starovoitov@gmail.com> <8fce9510-a690-4b7a-91fb-62f6facfe0b5@suse.cz>
In-Reply-To: <8fce9510-a690-4b7a-91fb-62f6facfe0b5@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Nov 2024 16:40:58 -0800
Message-ID: <CAADnVQJ9=iqN8Vo_pjV3PjQEddNnckyZgip=JSxK0To8Erhh=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 2:54=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/16/24 02:48, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Tracing BPF programs execute from tracepoints and kprobes where running
> > context is unknown, but they need to request additional memory.
> > The prior workarounds were using pre-allocated memory and BPF specific
> > freelists to satisfy such allocation requests. Instead, introduce
> > __GFP_TRYLOCK flag that makes page allocator accessible from any contex=
t.
> > It relies on percpu free list of pages that rmqueue_pcplist() should be
> > able to pop the page from. If it fails (due to IRQ re-entrancy or list
> > being empty) then try_alloc_page() attempts to spin_trylock zone->lock
> > and refill percpu freelist as normal.
> > BPF program may execute with IRQs disabled and zone->lock is sleeping i=
n RT,
> > so trylock is the only option.
> > In theory we can introduce percpu reentrance counter and increment it
> > every time spin_lock_irqsave(&zone->lock, flags) is used,
> > but we cannot rely on it. Even if this cpu is not in page_alloc path
> > the spin_lock_irqsave() is not safe, since BPF prog might be called
> > from tracepoint where preemption is disabled. So trylock only.
> >
> > There is no attempt to make free_page() to be accessible from any
> > context (yet). BPF infrastructure will asynchronously free pages from
> > such contexts.
> > memcg is also not charged in try_alloc_page() path. It has to be
> > done asynchronously to avoid sleeping on
> > local_lock_irqsave(&memcg_stock.stock_lock, flags).
> >
> > This is a first step towards supporting BPF requirements in SLUB
> > and getting rid of bpf_mem_alloc.
> > That goal was discussed at LSFMM: https://lwn.net/Articles/974138/
>
> Thanks for looking into this. I agree that something like __GFP_TRYLOCK
> would be necessary to distinguish those allocation contexts. But I'm
> wondering if the page allocator is the best place to start (or even
> necessary in the end)

It's necessary. More below.

> if the goal is to replace the kmalloc-sized
> allocations in bpf and not page sized?

bpf_ma has support for page sized alloc, but freelist of one page
isn't practical. bpf side needs to be able to request many
pages one page at a time. There is no need for order >=3D 1 allocs
and never going to be. One page at a time only.

> SLUB could have preallocated slab
> pages to not call into the page allocator in such situations?

prealloc cannot be sized. In the early days of bpf we preallocated
everything. When bpf map is created it has 'max_entries' limit.
So we know how much to preallocate, but since maps got big
(in networking use cases there are multiple muti-gigabytes maps)
the full prealloc is a waste of memory. Hence bpf_ma was added to
allocate when necessary. So far it's working ok for
small allocations and free list watermark logic seems to be enough.
But it doesn't work for page sized allocs.
So for bpf arena we require sleepable context to populate pages
and users are already complaining that we merely shifted a problem
on to them. Now bpf progs have to preallocate in sleepable context,
stash memory somewhere and use it later.
And program author cannot know beforehand how much to preallocate.
How many flows will the network load balancer see?

> I've posted the first SLUB sheaves RFC this week [1]. The immediate
> motivation was different, but I did mention there this could perhaps beco=
me
> a basis for the bpf_mem_alloc replacement too. I'd imagine something like=
 a
> set of kmem_buckets with sheaves enabled and either a flag like
> __GFP_TRYLOCK or a different variant of kmalloc() to only try using the
> sheaves. Didn't Cc you/bpf as if seemed too vague yet, but guess I should=
 have.
>
> [1]
> https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-0-ddc0bdc27e05=
@suse.cz/#t

Thanks for the link.
I see why you think this cache array may help maple_tree
(though I'm sceptical without seeing performance numbers),
but I don't see how it helps bpf.
bpf_ma is not about performance. We tried to make it fast,
but it wasn't a goal. The main objective is to have a reasonable
chance of getting memory in any context.
afaict sheaves don't help bpf_ma.
In the patch
[PATCH RFC 5/6] mm, slub: cheaper locking for percpu sheaves
you're calling it cpu_sheaves_trylock(),
but then you do:
local_lock(&ptr->member.llock);
how is this a try lock?

This lock breaks slab re-entrancy and lockdep will complain
if it sees local_lock() and raw spinlock is already held.
So the way sheaves are coded they're no go for bpf use cases.

In this GFP_TRYLOOCK patch see this comment:
+  * Do not specify __GFP_ACCOUNT to avoid local_lock.

That's an important part. No locks including local_locks
should be attempted to be taken with GFP_TRYLOCK.

The plan to replace bpf_ma has this rough steps:
1. try_alloc_page_noprof() that uses try lock only. This patch.
2. kmalloc() support for GFP_TRYLOCK that does its
double cmpxchg and when new_slab() is needed it's called with
TRYLOCK too.
So all slub and page allocs are not blocking.
The __free_pages() part is a bit tricky, since it needs
to add a page to the free list, but it has to use trylock and
there are no gfp flags. I'm thinking to use llist when trylock
fails and truly add the page to the freelist on the next
call to free_pages that doesn't have TRYLOCK flag.

