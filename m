Return-Path: <bpf+bounces-76490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4CFCB76A0
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 00:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4502D30024AF
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932522D5948;
	Thu, 11 Dec 2025 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzwogxBq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC3284694
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765496755; cv=none; b=pFGGPDu7TZTwTMTeQyQqG/N+XGYDQq5Pie+Fu1EFYKJ7TU+/q1Fe8GTA3sMKXDPX1nPYdSVtrD7wDBE7KNs/d78hisN357GMUjjd8iA8c6EYNyI8GaBOpX12urtSKB9tusoW5Dl85JzohMEKvq7gBV7/7IOOMKZIt9o1dGVGUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765496755; c=relaxed/simple;
	bh=mYJsswVPUvIBoBmXkW5RinxjnS6v1j+zr2myifQOK14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzHWHEItZF6Oz8oPiCA7BqemjhKGRCJ0a1MW/R7/rvZVL94fKw4iyJs+nwtMcjm4c4y2BPSA/U9hkKsaMZ3eAh6S1K5rq9N2qSoHktvTZ5ofDIfZG8UsWo4p80XjFW1CsYfxabjYSPayFx6yR+rmMshrj6LnZ16NW95Ye6smujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzwogxBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86189C4AF09
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 23:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765496754;
	bh=mYJsswVPUvIBoBmXkW5RinxjnS6v1j+zr2myifQOK14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lzwogxBqYWIDMRgzeiVuSoLWnaWb0EtzP9UDm0e3gMWOCZc7Cfsxt+7C8JKcUhPv8
	 pru+8gYjivbhz6Mds15RlqzYDtjwZQnQGf066u2dkjvTb6RgXesA6+MIBYBBGTRK2i
	 OorSh2SvUb68qzjEUsjJinBDdSqrt43XEl8POJARNEruuvhQrYsu1704Tm/Xd7YoH1
	 Tw++GAwuC6ao3kqm5Pi+/kidBg4arLab0cEU8TJcpUN813yb7cYqLnGTecpotcJzMC
	 gf16FqKtJ3YxDdMq0eUnwIo09em5S1UrqLJFvddQLKlY/LpJwwd0zIiv4QX2u0CD5h
	 vXxi0yP/lPk1g==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-649728a2228so966667a12.3
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 15:45:54 -0800 (PST)
X-Gm-Message-State: AOJu0YxqfX4YkoOMV8zB6Vq/F3nErEPXP9Wz5H9nZmJEqb9v0fBiDGaU
	K9HV6+woNmJ+bWbHJH7uKXTGynSpdR8/1bwoi8zsx3I5dalEYYz5GIATMj7+cdo9bBLPdx2RvgR
	Sjese2jpHvAFsIJ6TCY0cvDpiMUSRl00=
X-Google-Smtp-Source: AGHT+IEajqa47XgKun3HTpIG9fCHvPC2wljNflx6kBg8kDGodzWt/wCW90HeQAeqUKac403GVmcRGQCn6Q1sx0EZKa4=
X-Received: by 2002:a17:906:c113:b0:b54:7778:c62d with SMTP id
 a640c23a62f3a-b7d2362aca3mr3969566b.15.1765496753110; Thu, 11 Dec 2025
 15:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117160150.62183-1-puranjay@kernel.org> <20251117160617.4604-1-puranjay@kernel.org>
 <CAADnVQK47-08p8XATMmGdScs19y4Ju+yG0VH2hb-G+QvGi3pPA@mail.gmail.com>
In-Reply-To: <CAADnVQK47-08p8XATMmGdScs19y4Ju+yG0VH2hb-G+QvGi3pPA@mail.gmail.com>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Fri, 12 Dec 2025 08:45:41 +0900
X-Gmail-Original-Message-ID: <CANk7y0h3_kyQVmDaSG19ZZ=hEscqACYd4Qi0+g_io0KuwCbN0Q@mail.gmail.com>
X-Gm-Features: AQt7F2qD2QG-qgpVm7LBG1sM6v4-3RVALhFLxxN27ZPBL8e-1h-iy5Ey8FsQBi4
Message-ID: <CANk7y0h3_kyQVmDaSG19ZZ=hEscqACYd4Qi0+g_io0KuwCbN0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: arena: use kmalloc_nolock() in place
 of kvcalloc()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 6:15=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 17, 2025 at 8:06=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > To make arena_alloc_pages() safe to be called from any context, replace
> > kvcalloc() with kmalloc_nolock() so as it doesn't sleep or take any
> > locks. kmalloc_nolock() returns NULL for allocations larger than
> > KMALLOC_MAX_CACHE_SIZE, which is (PAGE_SIZE * 2) =3D 8KB on systems wit=
h
> > 4KB pages. So, round down the allocation done by kmalloc_nolock to 1024
> > * 8 and reuse the array in a loop.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/arena.c | 83 +++++++++++++++++++++++++++++++---------------
> >  1 file changed, 57 insertions(+), 26 deletions(-)
> >
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 214a4da54162..1d0b49a39ad0 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -43,6 +43,8 @@
> >  #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) *=
 8, PAGE_SIZE << 1)
> >  #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
> >
> > +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long=
 page_cnt);
> > +
> >  struct bpf_arena {
> >         struct bpf_map map;
> >         u64 user_vm_start;
> > @@ -492,7 +494,10 @@ static long arena_alloc_pages(struct bpf_arena *ar=
ena, long uaddr, long page_cnt
> >         /* user_vm_end/start are fixed before bpf prog runs */
> >         long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_star=
t) >> PAGE_SHIFT;
> >         u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> > +       struct apply_range_data data;
> >         struct page **pages =3D NULL;
> > +       long remaining, mapped =3D 0;
> > +       long alloc_pages;
> >         long pgoff =3D 0;
> >         u32 uaddr32;
> >         int ret, i;
> > @@ -509,17 +514,21 @@ static long arena_alloc_pages(struct bpf_arena *a=
rena, long uaddr, long page_cnt
> >                         return 0;
> >         }
> >
> > -       /* zeroing is needed, since alloc_pages_bulk() only fills in no=
n-zero entries */
> > -       pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL)=
;
> > +       /*
> > +        * Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nol=
ock() can succeed.
> > +        */
> > +       alloc_pages =3D min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(s=
truct page *));
> > +       pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), 0=
, NUMA_NO_NODE);
> >         if (!pages)
> >                 return 0;
> > +       data.pages =3D pages;
> >
> > -       guard(mutex)(&arena->lock);
> > +       mutex_lock(&arena->lock);
> >
> >         if (uaddr) {
> >                 ret =3D is_range_tree_set(&arena->rt, pgoff, page_cnt);
> >                 if (ret)
> > -                       goto out_free_pages;
> > +                       goto out_unlock_free_pages;
> >                 ret =3D range_tree_clear(&arena->rt, pgoff, page_cnt);
> >         } else {
> >                 ret =3D pgoff =3D range_tree_find(&arena->rt, page_cnt)=
;
> > @@ -527,34 +536,56 @@ static long arena_alloc_pages(struct bpf_arena *a=
rena, long uaddr, long page_cnt
> >                         ret =3D range_tree_clear(&arena->rt, pgoff, pag=
e_cnt);
> >         }
> >         if (ret)
> > -               goto out_free_pages;
> > -
> > -       struct apply_range_data data =3D { .pages =3D pages, .i =3D 0 }=
;
> > -       ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pag=
es);
> > -       if (ret)
> > -               goto out;
> > +               goto out_unlock_free_pages;
> >
> > +       remaining =3D page_cnt;
> >         uaddr32 =3D (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
> > -       /* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE=
 - 1
> > -        * will not overflow 32-bit. Lower 32-bit need to represent
> > -        * contiguous user address range.
> > -        * Map these pages at kern_vm_start base.
> > -        * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overf=
low
> > -        * lower 32-bit and it's ok.
> > -        */
> > -       ret =3D apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> > -                                 page_cnt << PAGE_SHIFT, apply_range_s=
et_cb, &data);
> > -       if (ret) {
> > -               for (i =3D 0; i < page_cnt; i++)
> > -                       __free_page(pages[i]);
> > -               goto out;
> > +
> > +       while (remaining) {
> > +               long this_batch =3D min(remaining, alloc_pages);
> > +
> > +               /* zeroing is needed, since alloc_pages_bulk() only fil=
ls in non-zero entries */
> > +               memset(pages, 0, this_batch * sizeof(struct page *));
> > +               data.i =3D 0;
>
> Pls move data.i =3D 0 further down to be done right before
> apply_to_page_range() since it's one logical operation.
> Here it's done too early.
>
> > +
> > +               ret =3D bpf_map_alloc_pages(&arena->map, node_id, this_=
batch, pages);
> > +               if (ret)
> > +                       goto out;
> > +
> > +               /* Earlier checks made sure that uaddr32 + page_cnt * P=
AGE_SIZE - 1
>
> Pls reformat the comment as you move them as
> /*
>  * ...
>  */
>
> > +                * will not overflow 32-bit. Lower 32-bit need to repre=
sent
> > +                * contiguous user address range.
> > +                * Map these pages at kern_vm_start base.
> > +                * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 c=
an overflow
> > +                * lower 32-bit and it's ok.
> > +                */
> > +               ret =3D apply_to_page_range(&init_mm,
> > +                                         kern_vm_start + uaddr32 + (ma=
pped << PAGE_SHIFT),
> > +                                         this_batch << PAGE_SHIFT, app=
ly_range_set_cb, &data);
> > +               if (ret) {
> > +                       /* data.i pages were mapped, account them and f=
ree the remaining */
> > +                       mapped +=3D data.i;
> > +                       for (i =3D data.i; i < this_batch; i++)
> > +                               __free_page(pages[i]);
> > +                       goto out;
> > +               }
> > +
> > +               mapped +=3D this_batch;
> > +               remaining -=3D this_batch;
> >         }
> > -       kvfree(pages);
> > +       mutex_unlock(&arena->lock);
> > +       kfree_nolock(pages);
> >         return clear_lo32(arena->user_vm_start) + uaddr32;
> >  out:
> > -       range_tree_set(&arena->rt, pgoff, page_cnt);
> > +       range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> > +       mutex_unlock(&arena->lock);
> > +       if (mapped)
> > +               arena_free_pages(arena, clear_lo32(arena->user_vm_start=
) + uaddr32, mapped);
>
> This doesn't look right.
> The first thing arena_free_pages() does is:
>         uaddr =3D (u32)uaddr;
>         uaddr &=3D PAGE_MASK;
>         full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;

So, arena_free_pages() should be called with what arena_alloc_pages()
returns, we return:

    return clear_lo32(arena->user_vm_start) + uaddr32;

from arena_alloc_pages(); few lines above.

This usage looks correct to me.

Thanks,
Puranjay

