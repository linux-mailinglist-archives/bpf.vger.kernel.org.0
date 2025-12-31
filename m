Return-Path: <bpf+bounces-77614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C718CEC621
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E9EC3009FA4
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF13C2222C5;
	Wed, 31 Dec 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXWg0yTL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47413126F0A
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202267; cv=none; b=NXLH8wz6BRbdebAWbVHQMQauhSeP6srTT5igH38ylgLAvs+uQb40cjbCHmalSME1SyHfE6j5wIBvGKo3deiafvAvmDAsYzo+ZqR5+2QsPUXXxbyYc1RJ1oAbn+GML0tzUz5yQisdyOPOFfDNiSh2F3IYTHjKtUhta50tDWSN8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202267; c=relaxed/simple;
	bh=52dmIoWqtm3O1YL26lpVsHSW9Xb6hOy51n6N+QVHpQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekkKCEcenFqjG+u3vpNkmsU5aJJDvulWYTpLAJ++7mhNaWJX2SBfzAFi9tYbjrMlIm3iAZCh1jgVtypJs7kJpNMScVfv3hpeW8uluJVOwny8wyKMMNBMw3Dg5RFfY2SZcgCgzebjA1Cc+kab2/IJNPrCJOFxJNDgSr2dlTHGggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXWg0yTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B830EC19423
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767202266;
	bh=52dmIoWqtm3O1YL26lpVsHSW9Xb6hOy51n6N+QVHpQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kXWg0yTLZR3Vr3SrJy86wu0QwNtqyvsrhhbj358Zz16+lkLhbFQ/FUhjWmVWG3j+Z
	 AVAi86DXrg3CIo/C4OHOC4/gYOuCL2Rk8h9YEH1swuiRE8AnuKH2ecEKO5HBRomUk0
	 yyRmT6cEzbIH/VkoHP49zIEocn1BPQ3ArFdFdFYJnoS287tpXFdxTTie9+Xv/xtqqo
	 7YIYEF5IZeBnQRstb6tX4nC26QKcra/grjipfrcrJpxZPzj14p75l83wp5yGAba+4l
	 MKkEi7e5DKRD7eH+dGjWvFurMDVBUH/IXqBakQA58wRdhO8sZMWuaMIv434zQMR5yp
	 Ycu47fSR4FSNQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso18600976a12.0
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 09:31:06 -0800 (PST)
X-Gm-Message-State: AOJu0YziJvVDdp5QFUeYbYsMkByWoNlb3dVmjllXkjlyFBTRtoRfH6RK
	4K0/yov4hqe/FT8gd4jux32Oqg5mpFY3EqCG3njOxWTaFdzp9CfUM2rsfnh5zmfbu05SLUi9UK/
	CVu73LdW9RYgpDG4xEtMGE0M3aselMuU=
X-Google-Smtp-Source: AGHT+IE/3v5Ny7sGvasoQllNo89stkhC8aZLkW58dhVcz6OwZGVOjc4UmbsEeIL5ly7DT+Ne/BNemjIoGhpZ8cjhP4g=
X-Received: by 2002:a17:907:9606:b0:b80:3447:e0c0 with SMTP id
 a640c23a62f3a-b80371f8c3amr3648992966b.62.1767202265227; Wed, 31 Dec 2025
 09:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231141434.3416822-1-puranjay@kernel.org> <20251231141434.3416822-3-puranjay@kernel.org>
 <CAADnVQKYGiHZw2y79tumaua9UYMXEqvSjGT_XcvBsKyi4KXiLg@mail.gmail.com>
In-Reply-To: <CAADnVQKYGiHZw2y79tumaua9UYMXEqvSjGT_XcvBsKyi4KXiLg@mail.gmail.com>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 31 Dec 2025 17:30:54 +0000
X-Gmail-Original-Message-ID: <CANk7y0j6NXLRRhOB66oThbsn1f1odCPj_qTHACsXbgFwcniLaA@mail.gmail.com>
X-Gm-Features: AQt7F2rjyJl21LWxzc_cstFlM3iB9zX4cEhzkghxs5LvqQ56e4L-FJBAJONFeug
Message-ID: <CANk7y0j6NXLRRhOB66oThbsn1f1odCPj_qTHACsXbgFwcniLaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: arena: Reintroduce memcg accounting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 5:25=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 31, 2025 at 6:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > When arena allocations were converted from bpf_map_alloc_pages() to
> > kmalloc_nolock() to support non-sleepable contexts, memcg accounting wa=
s
> > inadvertently lost. This commit restores proper memory accounting for
> > all arena-related allocations.
> >
> > All arena related allocations are accounted into memcg of the process
> > that created bpf_arena.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/arena.c      | 44 ++++++++++++++++++++++++++++++++++++-----
> >  kernel/bpf/range_tree.c |  5 +++--
> >  2 files changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 456ac989269d..45b55961683f 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -360,6 +360,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
> >  {
> >         struct bpf_map *map =3D vmf->vma->vm_file->private_data;
> >         struct bpf_arena *arena =3D container_of(map, struct bpf_arena,=
 map);
> > +       struct mem_cgroup *new_memcg, *old_memcg;
> >         struct page *page;
> >         long kbase, kaddr;
> >         unsigned long flags;
> > @@ -377,6 +378,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
> >                 /* already have a page vmap-ed */
> >                 goto out;
> >
> > +       bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
> > +
> >         if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> >                 /* User space requested to segfault when page is not al=
located by bpf prog */
> >                 goto out_unlock_sigsegv;
> > @@ -400,12 +403,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault =
*vmf)
> >                 goto out_unlock_sigsegv;
> >         }
> >         flush_vmap_cache(kaddr, PAGE_SIZE);
> > +       bpf_map_memcg_exit(old_memcg, new_memcg);
> >  out:
> >         page_ref_add(page, 1);
> >         raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> >         vmf->page =3D page;
> >         return 0;
> >  out_unlock_sigsegv:
> > +       bpf_map_memcg_exit(old_memcg, new_memcg);
> >         raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> >         return VM_FAULT_SIGSEGV;
> >  }
> > @@ -557,7 +562,7 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
> >
> >         /* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nol=
ock() can succeed. */
> >         alloc_pages =3D min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(s=
truct page *));
> > -       pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), 0=
, NUMA_NO_NODE);
> > +       pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), _=
_GFP_ACCOUNT, NUMA_NO_NODE);
> >         if (!pages)
> >                 return 0;
> >         data.pages =3D pages;
> > @@ -713,7 +718,7 @@ static void arena_free_pages(struct bpf_arena *aren=
a, long uaddr, long page_cnt,
> >         return;
> >
> >  defer:
> > -       s =3D kmalloc_nolock(sizeof(struct arena_free_span), 0, -1);
> > +       s =3D kmalloc_nolock(sizeof(struct arena_free_span), __GFP_ACCO=
UNT, -1);
> >         if (!s)
> >                 /*
> >                  * If allocation fails in non-sleepable context, pages =
are intentionally left
> > @@ -766,6 +771,7 @@ static int arena_reserve_pages(struct bpf_arena *ar=
ena, long uaddr, u32 page_cnt
> >  static void arena_free_worker(struct work_struct *work)
> >  {
> >         struct bpf_arena *arena =3D container_of(work, struct bpf_arena=
, free_work);
> > +       struct mem_cgroup *new_memcg, *old_memcg;
> >         struct llist_node *list, *pos, *t;
> >         struct arena_free_span *s;
> >         u64 arena_vm_start, user_vm_start;
> > @@ -780,6 +786,8 @@ static void arena_free_worker(struct work_struct *w=
ork)
> >                 return;
> >         }
> >
> > +       bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> > +
> >         init_llist_head(&free_pages);
> >         arena_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> >         user_vm_start =3D bpf_arena_get_user_vm_start(arena);
> > @@ -820,6 +828,8 @@ static void arena_free_worker(struct work_struct *w=
ork)
> >                 page =3D llist_entry(pos, struct page, pcp_llist);
> >                 __free_page(page);
> >         }
> > +
> > +       bpf_map_memcg_exit(old_memcg, new_memcg);
> >  }
> >
> >  static void arena_free_irq(struct irq_work *iw)
> > @@ -834,49 +844,69 @@ __bpf_kfunc_start_defs();
> >  __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign,=
 u32 page_cnt,
> >                                         int node_id, u64 flags)
> >  {
> > +       void *ret;
> >         struct bpf_map *map =3D p__map;
> > +       struct mem_cgroup *new_memcg, *old_memcg;
> >         struct bpf_arena *arena =3D container_of(map, struct bpf_arena,=
 map);
> >
> >         if (map->map_type !=3D BPF_MAP_TYPE_ARENA || flags || !page_cnt=
)
> >                 return NULL;
> >
> > -       return (void *)arena_alloc_pages(arena, (long)addr__ign, page_c=
nt, node_id, true);
> > +       bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
> > +       ret =3D (void *)arena_alloc_pages(arena, (long)addr__ign, page_=
cnt, node_id, true);
> > +       bpf_map_memcg_exit(old_memcg, new_memcg);
>
> Should this be done inside arena_alloc_pages() ?
>
> and similar inside arena_free_pages() ?
> Doesn't look to me that the error path will get more complex.
> just memcg_enter/exit in a few places.
> That will avoid copy paste in sleepable/non_sleepable kfuncs.

I thought it will be more readable here as the
arena_alloc/free_pages() is already complicated.

> Also remove redundant memcg_enter/exit from bpf_map_alloc_pages().
> No point in doing it twice.
> and remove #ifdef in patch 1.

Yes, now I see that there is no other user of that function.

