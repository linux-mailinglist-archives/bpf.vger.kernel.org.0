Return-Path: <bpf+bounces-51898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00422A3AFB4
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 03:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752B27A4543
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DA187553;
	Wed, 19 Feb 2025 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBQwPexD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72096156228
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932719; cv=none; b=LXJUizi91MFOEorVAiujG5MKbfPzggdYlkrMFV7Ga9RLZQwjBs4hy1WWdJpL5s0x/B+Od5+cEwd3NRHgg86tepuFtvmiELWBCd1SutZlOC4X8p5cGjedxkrByXkykGGvsaKyQEH9CV7JndD0C0ESdIjt1zd/bJI1Ui7GWhPIlIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932719; c=relaxed/simple;
	bh=OwnaFjJvUh3JeciHpQQoCv9YVM3canW0zaWTHbV6r98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUtDzS4dcAD96VBIxIOzIK0seNy51vlhfvPCo9RhlhFwQ93kkEZT4C1Lq2JtbW8ZOYWsRTk1123sUG3pqElqhlnVcIVz7EuRpocP1iqvqFBz9ztGwUp4ZuppKuHXvWvmkjJ+BbEmXjnsyHfiXF88i2+9HDBKdPRe3UXrSBdqq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBQwPexD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f378498b0so2943071f8f.0
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 18:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739932716; x=1740537516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EgllTDpipZEfS9SM+0OuujBDZwwNbrL+Bh0aCSUA38=;
        b=SBQwPexD6AkN1mps0BwD0JWMNTKNzGnUUCKEdxMADjb2016aOiGES82Dm6wNlrYocD
         JSwq8rRkeJpUP/HHMbVwXkFxpApSpsh76tW1k1Lo69Bd0J5yTiXHMI6kKq05mR5fiB8K
         huXScPdRmufRhj3SO1cvoVSKQmtrIQe54S2oJYfPVxig0op8KG4EWekeB1lV2DWr8Wtu
         0pj6qVCM1aC26mIO3dQaiVpim5tYKRcIraQuD87/RzSNQ2qZzg+JXkyuBC2lgIO36phc
         JkCYZ7C8NNWruXqErBGqBugGEYjXRXeCUshSFvKQAgMkRwH0VXh+MbTM+wTpG9z5EHsv
         htTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932716; x=1740537516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EgllTDpipZEfS9SM+0OuujBDZwwNbrL+Bh0aCSUA38=;
        b=tKKBSJQ8kPqrB9q9nxdjgvkiqR7p/IOzkp0R0I1wZ4SNFCNPYBTsxRjIFoKsTnCPB5
         r8zDE51lNY90SSexmxxpO4T5wEyc+4bvQi3n/2kHdRYkxyJ7W6j6pi2KkXg12l2wRmIr
         905peXR4PmSxfMXWDTb2Kf9nJ5tfCFaCpT/+VHoavMEhJqqJwNv8sycO9rWApmD3gI/6
         ztCvUwgVFIvdPndACoTJ3HvmO6tGvK6rC2gWh6jKr55v1lOD0mvh9lrU7wpK/5MTxV8k
         9y4p1cj8WMIS6gpazae7f6wsJ6k1gSZhQUoE33xOnpfArmEfaToeOUaW1qTd8TuhRvJj
         z6hQ==
X-Gm-Message-State: AOJu0YxDwcgSMDcKokKVie9cSlJOdc4Ce/9uI0YisP/4ULLIX9mepOXM
	TG3/yw2p3tfVWmnmgM1pklx03vxpRjA72m3PG+/PnWmgaJk197f5plZQ20IULlmT7L2I257kWG6
	H2haCsWWYvQvKtA5vXQXL89IBJB0=
X-Gm-Gg: ASbGnctssapGTw5j4e4LY9x6tinQzuJgft1Moiw2MHMFmw6Ujy8uOO60HK+Htj1patZ
	q3T335G69Ei7m5cdx0AryPzmKlJjAWyY9ndUCtQcK0yi5j64MRvhLfKF+V5tSPAj5svXKdBkDAn
	0IxoFAtIj8FCW/ldoY37HtcOpUnYRl
X-Google-Smtp-Source: AGHT+IE1e3IGdpojVgRJx4aBseG+oKtfS10LKyB6mebmTq5Z373JrWCdck971nLXJR4iuBI39p/PuNFCAOFUCgX3J4Q=
X-Received: by 2002:adf:e692:0:b0:38d:d666:5448 with SMTP id
 ffacd0b85a97d-38f587ca60amr996017f8f.40.1739932715400; Tue, 18 Feb 2025
 18:38:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
 <20250213033556.9534-7-alexei.starovoitov@gmail.com> <fb983185-a577-405e-8fb4-b506d894cec5@suse.cz>
In-Reply-To: <fb983185-a577-405e-8fb4-b506d894cec5@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Feb 2025 18:38:24 -0800
X-Gm-Features: AWEUYZnIijcvPq3Fw__j_ohq7gvM8u2aZXwBnP20B_N_e5DeEnwpu3YfptKpazA
Message-ID: <CAADnVQ+tAWwfO5tv+aW0KUs-cz559vN8V6TCzhmtDMFxoEewRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 6/6] bpf: Use try_alloc_pages() to allocate
 pages for bpf needs.
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 7:36=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/13/25 04:35, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Use try_alloc_pages() and free_pages_nolock() for BPF needs
> > when context doesn't allow using normal alloc_pages.
> > This is a prerequisite for further work.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/bpf.h  |  2 +-
> >  kernel/bpf/arena.c   |  5 ++---
> >  kernel/bpf/syscall.c | 23 ++++++++++++++++++++---
> >  3 files changed, 23 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f3f50e29d639..e1838a341817 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2348,7 +2348,7 @@ int  generic_map_delete_batch(struct bpf_map *map=
,
> >  struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
> >  struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
> >
> > -int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
> > +int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
> >                       unsigned long nr_pages, struct page **page_array)=
;
> >  #ifdef CONFIG_MEMCG
> >  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp=
_t flags,
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 0975d7f22544..8ecc62e6b1a2 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -287,7 +287,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
> >               return VM_FAULT_SIGSEGV;
> >
> >       /* Account into memcg of the process that created bpf_arena */
> > -     ret =3D bpf_map_alloc_pages(map, GFP_KERNEL | __GFP_ZERO, NUMA_NO=
_NODE, 1, &page);
> > +     ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
> >       if (ret) {
> >               range_tree_set(&arena->rt, vmf->pgoff, 1);
> >               return VM_FAULT_SIGSEGV;
> > @@ -465,8 +465,7 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
> >       if (ret)
> >               goto out_free_pages;
> >
> > -     ret =3D bpf_map_alloc_pages(&arena->map, GFP_KERNEL | __GFP_ZERO,
> > -                               node_id, page_cnt, pages);
> > +     ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages=
);
> >       if (ret)
> >               goto out;
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c420edbfb7c8..a7af8d0185d0 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -569,7 +569,24 @@ static void bpf_map_release_memcg(struct bpf_map *=
map)
> >  }
> >  #endif
> >
> > -int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
> > +static bool can_alloc_pages(void)
> > +{
> > +     return preempt_count() =3D=3D 0 && !irqs_disabled() &&
> > +             !IS_ENABLED(CONFIG_PREEMPT_RT);
> > +}
> > +
>
> I see this is new since v6 and wasn't yet discussed (or I missed it?)

It was in v1:
https://lore.kernel.org/bpf/20241116014854.55141-1-alexei.starovoitov@gmail=
.com/
See Peter's comments.
In this version I open coded preemptible(), since it's more accurate
and disabled the detection on PREEMPT_RT.

> I wonder how reliable these preempt/irq_disabled checks are for correctne=
ss
> purposes, e.g. we don't have CONFIG_PREEMPT_COUNT enabled always?

I believe the above doesn't produce false positives.
It's not exhaustive and might change as we learn more and tune it.
Hence I moved it to be bpf specific to iterate quickly instead of
being in inux/gfp.h and also considering Sebastian's comment
that normal kernel code should better know the calling context.

> As longs
> as the callers of bpf_map_alloc_pages() know the context and pass gfp
> accordingly, can't we use i.e. gfpflags_allow_blocking() to determine if
> try_alloc_pages() should be used or not?

bpf infra has a very coarse knowledge of the context.
There are two categories: sleepable or not.
In sleepable GFP_KERNEL is allowed, but it's very narrow and
represents a tiny slice of use cases compared to
non-sleepable. The try_alloc_pages() is for the latter.
netconsole has a similar problem/challenge.
It doesn't know the context where it will be called.
Currently it's just doing GFP_ATOMIC and praying.
This is something to fix eventually when slab is taught about
gfpflags_allow_blocking.

