Return-Path: <bpf+bounces-67834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3EB49F3F
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 04:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987074E66CC
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 02:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126623D29F;
	Tue,  9 Sep 2025 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWtfU8v7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0CD1531F9
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385179; cv=none; b=LxcW5LMHJ7SQ3txLTELX+15jLwUm3jxflJbsrT5x9wKI2l9Cwvcqs1vbSdnQ8N6tqHa5Mukvz0X6FmL7sUBVoFoe/TNhjq+gp2AxX4JvkYPuax9tkhGMFfV8bZQrUTg11ICPtsHro4xsnFlrd6wZ1+Rk2186amMjXBGhnmNEREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385179; c=relaxed/simple;
	bh=2vRDdhyl1ihzMuIVKfbdb1qxx9MG6krIuX0TYLQzx1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmyx5o7Gl3z/ZP7eiboC8kBskcemVQUnqX1Zf5Efk+JcdIkK00pVA3Bcn5gNyZwnDOpA+3QZaW+s795U6IwlTf4Fdjt6kv0SyKayD0D9HxsL0Y3IMKd4WVXPzCs7sOPNjR9wFS/2AHP1XuZD2a6rx22SU3fgIsLquw/j+Lq8BAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWtfU8v7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso72245e9.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 19:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757385175; x=1757989975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqGZLA2OX1lVz766/XmCg7OsOS1a4ZDVYW0b4KhD9ps=;
        b=IWtfU8v7XzbQgV9XhPIPgdQK6bMWBWMWN1h9EnyVbn0KqBTBQe9m+0hAguVTez/S8C
         F2ImyQNDLu/N5LA4IkXrMx5PK/7s0Lhys47dthjRtosAVWuaIMdr1WIONpRZ4BsxAOp+
         oMDJJAh44KGKRJL1EuJ5x33ZOhc9CgerKfE1NE2D2iHPuvvtnpomxXirQm/PIZq2gH8b
         RoyREC2r3XbsFrI90030q5TjeO4ZjWliSBnbi2ki5EEPTB0MR7YaxGLlPTcnQtdlzQ0q
         FGKZJRzt2QkMP6B3iBwC2f5jOyUSLCMJX+9hOsiBy6Pax/cA69pyyvGpZ4d+YzrDizNP
         s4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757385175; x=1757989975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqGZLA2OX1lVz766/XmCg7OsOS1a4ZDVYW0b4KhD9ps=;
        b=PGP6HNRnTEDaFOzQq3xB6uCbm3Z63DLg4a06zw8hedNxnu7UXurkpkfBOO/zuNsJu4
         u6Rm0nY5CggVEyOHsSJCc3N2KgRrtpEkl4XX5R14GZCNZQ2+hrI4K/sPm4TXIvYmUh+W
         +e09kN89NinCZCZgubBfCNyGlzUBLL1p/ePU22++hxbzBHj1+q3ZzSnHFaE0KOYKYu5A
         fGCDXvdh9kbThYsnrnwP6FJPYWi04opsQDBU+KLlj5cBRRGV+BLs6Ki8BivWmTIK3ufn
         iMUtp34d2Syhgdrd7uce/Akz+FEC5tF55L2KFYWcLzD8q35RsAHZp5IBdHha5ia89TvN
         c+6A==
X-Gm-Message-State: AOJu0Yw3TWfNOWoJkfiH6BviznD0+0MCUeQB+jzdmZLWbw606urgbvq5
	j1pkZPvzbrYO7FEfnt9+VlqEWXnSyCbpyK8A2sJEV6SkSxyx9mQiNaAeabLLVAI8OVOoJPT+/4B
	4keLARPAO3VAffP0GaBCvPERikfEe34s=
X-Gm-Gg: ASbGncvshaO/Eo7qVzdETw3glJtahFdeQjcJxmVYNrSrsOxrd+HcuH/mp7orR/tXknB
	vUrwlfE9+Cx/3S3ZK+bGrVK2LRXnZh0hi5b1gBgoqDwyHYcMVl7cNSwUd70gBcWNd3bb4OaLkM+
	xbw4P6sQD8bJmgavpeFb0DewAXbkRZntMKLczFLZzLUrNKBqd/7acI+JaLf/8qYuo/0twHyrYqJ
	Zxos8dzSWnFpNZoiPPZ0ewoi+AtUW6x/hr8
X-Google-Smtp-Source: AGHT+IHyp/eLGeencmv3HRpkvDDMa5A9j/c/TphmUA+AbFrRCmfjZE4eqMeGKGIODZDGB4NvJj/IdnoieMNsDy+ELOY=
X-Received: by 2002:a05:6000:3101:b0:3e4:f194:2886 with SMTP id
 ffacd0b85a97d-3e642cadca2mr8416382f8f.19.1757385175131; Mon, 08 Sep 2025
 19:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
 <20250718021646.73353-7-alexei.starovoitov@gmail.com> <aH-ztTONTcgjU7xl@hyeyoo>
 <CAADnVQLrTJ7hu0Au-XzBu9=GUKHeobnvULsjZtYO3JHHd75MTA@mail.gmail.com>
 <aJtZrgcylnWgfR9r@hyeyoo> <aJt1FHnavjRv5CzI@hyeyoo> <CAADnVQ+aLojadnDgnOwJCTAE319can=rW7ELh2Xy5M-d2TWcHQ@mail.gmail.com>
 <aL-LX7JI6KLcB-dp@hyeyoo>
In-Reply-To: <aL-LX7JI6KLcB-dp@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 19:32:43 -0700
X-Gm-Features: AS18NWD2ijOkR7C_EFgiM3P_wPzb5yEZ3i8W9mhM8tIKd0KmklGpXA5KL5Y2Y3o
Message-ID: <CAADnVQKQLEEJ4hj4dd0Br7R6tCSvO7EuccxLTL7LjHW3pXC+mQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 7:05=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> On Mon, Sep 08, 2025 at 05:08:43PM -0700, Alexei Starovoitov wrote:
> > On Tue, Aug 12, 2025 at 10:08=E2=80=AFAM Harry Yoo <harry.yoo@oracle.co=
m> wrote:
> >
> > Sorry for the delay. I addressed all other comments
> > and will respin soon.
>
> No worries! Welcome back.
>
> > Only below question remains..
> >
> > > > > > >  {
> > > > > > > @@ -3732,9 +3808,13 @@ static void *___slab_alloc(struct kmem=
_cache *s, gfp_t gfpflags, int node,
> > > > > > >       if (unlikely(!node_match(slab, node))) {
> > > > > > >               /*
> > > > > > >                * same as above but node_match() being false a=
lready
> > > > > > > -              * implies node !=3D NUMA_NO_NODE
> > > > > > > +              * implies node !=3D NUMA_NO_NODE.
> > > > > > > +              * Reentrant slub cannot take locks necessary t=
o
> > > > > > > +              * deactivate_slab, hence ignore node preferenc=
e.
> > > > > >
> > > > > > Now that we have defer_deactivate_slab(), we need to either upd=
ate the
> > > > > > code or comment?
> > > > > >
> > > > > > 1. Deactivate slabs when node / pfmemalloc mismatches
> > > > > > or 2. Update comments to explain why it's still undesirable
> > > > >
> > > > > Well, defer_deactivate_slab() is a heavy hammer.
> > > > > In !SLUB_TINY it pretty much never happens.
> > > > >
> > > > > This bit:
> > > > >
> > > > > retry_load_slab:
> > > > >
> > > > >         local_lock_cpu_slab(s, flags);
> > > > >         if (unlikely(c->slab)) {
> > > > >
> > > > > is very rare. I couldn't trigger it at all in my stress test.
> > > > >
> > > > > But in this hunk the node mismatch is not rare, so ignoring node =
preference
> > > > > for kmalloc_nolock() is a much better trade off.
> > >
> > > But users would have requested that specific node instead of
> > > NUMA_NO_NODE because (at least) they think it's worth it.
> > > (e.g., allocating kernel data structures tied to specified node)
> > >
> > > I don't understand why kmalloc()/kmem_cache_alloc() try harder
> > > (by deactivating cpu slab) to respect the node parameter,
> > > but kmalloc_nolock() does not.
> >
> > Because kmalloc_nolock() tries to be as least intrusive as possible
> > to kmalloc slabs that the rest of the kernel is using.
> >
> > There won't be kmem_cache_alloc _nolock() version, because
> > the algorithm retries from a different bucket when the primary one
> > is locked. So it's only kmalloc_nolock() flavor and it takes
> > from generic kmalloc slab buckets with or without memcg.
> >
> > My understanding that c->slab is effectively a cache and in the long
> > run all c->slab-s should be stable.
>
> You're right and that's what makes it inefficient when users call
> kmalloc_node() or kmem_cache_alloc_node() every time with different
> node id because c->slab will be deactivated too often.

Exactly.

> > A given cpu should be kmalloc-ing the memory suitable for this local cp=
u.
> > In that sense deactivate_slab is a heavy hammer. kmalloc_nolock()
> > is for users who cannot control their running context. imo such
> > users shouldn't affect the cache property of c->slab hence ignoring
> > node preference for !allow_spin is not great, but imo it's a better
> > trade off than defer_deactivate_slab.
>
> The assumption here is that calling kmalloc_node() with a specific
> node other than the local node is a pretty niche case. And thus
> kmalloc_nolock() does not want to affect existing kmalloc() users.

yes.

> But given that assumption and your reasoning, even normal kmalloc_node()
> (perhaps even kmem_cache_alloc_node()) users shouldn't fill c->slab with
> a slab from a remote node then? Since most of users should be allocating
> memory from the local node anyway.

Hard to say. I think kmem_cache_alloc_node() users created
kmem_cache for their specific needs and node is more likely
an actual node id that comes all the way from user space.
At least this is how bpf maps are operating. node id is provided
at map creation time, then all map elements are preallocated
from that node, and in run-time elements are recycled through
the prealloc area. numa id is critical for performance for
some bpf map use cases like networking, but such strict numa
hurts tracing use cases where elements should be local to cpu.
So I'd keep deactivate_slab behavior for kmem_cache_alloc_node()
and try hard to allocate from specified numa id,
but I would do an audit of kmalloc_node() users (they aren't many)
and see whether "ignore node id when c->slab is different" approach
is a good thing. On a quick glance net/core/skbuff.c might prefer
to allocate from local cpu instead of deactivate and allocating
the whole new slab which might fail.

>
> > defer_deactivate_slab() is there for a rare race in retry_load_slab.
> > It can be done for !node_match(c->slab, node) too,
> > but it feels like a worse-r evil. Especially since kmalloc_nolock()
> > doesn't support __GFP_THISNODE.
>
> ...maybe it is fair to ignore node preference for kmalloc_node()
> in a sense that it isn't great to trylock n->list_lock and fail, then
> allocate new slabs (even when there are partial slabs available for the
> node).

Yep. Exactly my thinking. At least that's my preference for kmalloc_nolock(=
)
and it is arguably a better choice for generic kmalloc(),
but probably not for kmem_cache_alloc_node().
To make such a decision for kmalloc we'd need to collect a ton
of data. It's hard to optimize for all possible cases.
While for kmalloc_nolock() BPF will be the main user initially
and we have a better understanding of trade offs.
We can change all that in the future, of course, if intuition turns
out to be incorrect.

