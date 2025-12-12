Return-Path: <bpf+bounces-76498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D7CB77B4
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 01:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21E53019BD2
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC9924337B;
	Fri, 12 Dec 2025 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuEpo4Ru"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67542459E1
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500617; cv=none; b=QW+/cfrQZusbLSvT/XCMsLAZUKXIOF+Sp7VwGqa8QKkSPO9+GdAWtBCcUt7GM5KN0T/D+G6Qb/9CW0WXUYacaYmU/Q9RKfxA3VxsUw+GnMjdTP1puH7fFuXIQqlRXZX07lJUqeqFGN2xFB5eQFeLHWxV0T1sm5s3cSjFYPGcvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500617; c=relaxed/simple;
	bh=abZ0SKNWuDYb7GN3LaApZER6dAkM+5IZOqIQjURhzhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITXXqmBP56902oZC8SBBXKSkx75l4mOk47UBNYHfWuhMcbJCeWHl3y95i+r8DMti2FSZNRXjGlZ0Y5uNYLMrwK4pSOiE+9cLm6/tQ6rWLuB2y3LWwdGW4FPvLfXUCBLNSKe73WODmSC2AXBa3//xp1JbnoroG8SDTE66LYWK8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuEpo4Ru; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so5980435e9.0
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 16:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765500610; x=1766105410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m49T9lNDlOe5CR87qV9psszxD67hgaV2MfyJSKsAoO4=;
        b=cuEpo4RuHOi0LSBJOOQ15ebtwvvwL8QVTE9vxgXlMBjwO1G0E5OA0Sse5Vxkw5aC1n
         wmFOi+0fNyc5196bR+dzh0BBszkIab9t9Z0X7A070KWFyzbccemYHE3XGziRwGETrcS3
         2h4setUdKKO5p8ouSI1V6yTnBCIy4WjxfGloiOB4mrHxcmLjcmuYt+ycUc7K5OSxPRbl
         RFm+Z4/cXYblDCdsHo0Vzd+RnVQuShTrNdweT/5YEPU13L8h8VnJOCOT/X//zMHCG7GI
         XUr2e3AuLR2FlPoBE0TYO9AFKQY6YoQRHVur8yQlf1c29wyImwyiuYyxFCLCcO0yHfq6
         HGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765500610; x=1766105410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m49T9lNDlOe5CR87qV9psszxD67hgaV2MfyJSKsAoO4=;
        b=dz88hR6ABgQgNxKoQuaNoFn1r0h31dwlgR9QjZvhdLETUHkuIe1J7aHWtE7z7+rgcl
         nt5TZJOgTkWfaUrIduQqHgASRDFgaMK5tQ/udhP1IdcF79WcYX+kb5n9emYiMXuSRb02
         3eX/yXwP5CZb+x57n18Yf2hMQ4ICet7OQc7e4NtuwUvvmE5UG0JvP3+3s7QmUY5r2qmO
         0KGFtm8OPOgtrjrDCF3wS7DAU5JK0DaxY7PmIip2wR+Zfd3CCn4AcgvvL4cdNO9Ybync
         slvDeR7hFl8nGEqrbC0dRdtRvxmLYXaRq+IwUpJ7vJ5LEFhsfWYkJcPaZPMGBpDH5eo2
         EI4A==
X-Gm-Message-State: AOJu0Yxpsa0zD7deowbpsgmonn5/06ekYmmizDcWEfaoiWz5wpOAYrdS
	x1P0mzTCp45ZSQq6CzVS2i2XcS8xZ9Av1lXJGHvlcAZE0J1naubJxFzZmiImWcIWWECg0QO1NJu
	xhKOrzulq9Bcw1xYZGttAi5CVsGrEHnY=
X-Gm-Gg: AY/fxX5R6Lhy+cQGKmvEXr+eKmErGMjOuPpKgonub/8PXWiYxzrpRzgfgQNNY71k6/P
	aByPIBGg77mWRQdMhN4EjX3OoWTdfuaxYTzFrlMsGMVk9L5NCppPA0pv4izmv7LI776W7VMKFFx
	/AuxOv8DpavlF85k9p/e3L9LTS0ngExS8t9RhjmcE8LuqJPeh9S8AgFxmMuHU9R7HhNBbLpNXLg
	qFPE2FgVPocSm2UlD2XBiKtIESr+SLKsX9rcOS9VvC/3tRO4wjmIDbLGdnnN9BFLLzmk+x9CQ==
X-Google-Smtp-Source: AGHT+IHA3YqHTFAYxpmEq9qlvzOvuMh4AocqYjKMYN6r6oZxT8luPjjo3rtFTruVLE6+/5CMN8vxYi8wph3UHRPmW4w=
X-Received: by 2002:a05:600c:470a:b0:477:7b9a:bb07 with SMTP id
 5b1f17b1804b1-47a8f9166aamr1543275e9.35.1765500610369; Thu, 11 Dec 2025
 16:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117160150.62183-1-puranjay@kernel.org> <20251117160617.4604-1-puranjay@kernel.org>
 <CAADnVQK47-08p8XATMmGdScs19y4Ju+yG0VH2hb-G+QvGi3pPA@mail.gmail.com> <CANk7y0h3_kyQVmDaSG19ZZ=hEscqACYd4Qi0+g_io0KuwCbN0Q@mail.gmail.com>
In-Reply-To: <CANk7y0h3_kyQVmDaSG19ZZ=hEscqACYd4Qi0+g_io0KuwCbN0Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Dec 2025 09:49:58 +0900
X-Gm-Features: AQt7F2q2nI-tX3yx4YZXYclSiwjJl5UtVtvEg0loLnVHfgV73Qdcw1k1OZt_1U8
Message-ID: <CAADnVQK6pA3ySm2_U0-7KDB1ZguuJQW91sSyfGM4_OjgXxZJsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: arena: use kmalloc_nolock() in place
 of kvcalloc()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 8:45=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> On Sat, Nov 22, 2025 at 6:15=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 17, 2025 at 8:06=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> > >
> > > To make arena_alloc_pages() safe to be called from any context, repla=
ce
> > > kvcalloc() with kmalloc_nolock() so as it doesn't sleep or take any
> > > locks. kmalloc_nolock() returns NULL for allocations larger than
> > > KMALLOC_MAX_CACHE_SIZE, which is (PAGE_SIZE * 2) =3D 8KB on systems w=
ith
> > > 4KB pages. So, round down the allocation done by kmalloc_nolock to 10=
24
> > > * 8 and reuse the array in a loop.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > ---
> > >  kernel/bpf/arena.c | 83 +++++++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 57 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > > index 214a4da54162..1d0b49a39ad0 100644
> > > --- a/kernel/bpf/arena.c
> > > +++ b/kernel/bpf/arena.c
> > > @@ -43,6 +43,8 @@
> > >  #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off)=
 * 8, PAGE_SIZE << 1)
> > >  #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
> > >
> > > +static void arena_free_pages(struct bpf_arena *arena, long uaddr, lo=
ng page_cnt);
> > > +
> > >  struct bpf_arena {
> > >         struct bpf_map map;
> > >         u64 user_vm_start;
> > > @@ -492,7 +494,10 @@ static long arena_alloc_pages(struct bpf_arena *=
arena, long uaddr, long page_cnt
> > >         /* user_vm_end/start are fixed before bpf prog runs */
> > >         long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_st=
art) >> PAGE_SHIFT;
> > >         u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> > > +       struct apply_range_data data;
> > >         struct page **pages =3D NULL;
> > > +       long remaining, mapped =3D 0;
> > > +       long alloc_pages;
> > >         long pgoff =3D 0;
> > >         u32 uaddr32;
> > >         int ret, i;
> > > @@ -509,17 +514,21 @@ static long arena_alloc_pages(struct bpf_arena =
*arena, long uaddr, long page_cnt
> > >                         return 0;
> > >         }
> > >
> > > -       /* zeroing is needed, since alloc_pages_bulk() only fills in =
non-zero entries */
> > > -       pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNE=
L);
> > > +       /*
> > > +        * Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_n=
olock() can succeed.
> > > +        */
> > > +       alloc_pages =3D min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof=
(struct page *));
> > > +       pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *),=
 0, NUMA_NO_NODE);
> > >         if (!pages)
> > >                 return 0;
> > > +       data.pages =3D pages;
> > >
> > > -       guard(mutex)(&arena->lock);
> > > +       mutex_lock(&arena->lock);
> > >
> > >         if (uaddr) {
> > >                 ret =3D is_range_tree_set(&arena->rt, pgoff, page_cnt=
);
> > >                 if (ret)
> > > -                       goto out_free_pages;
> > > +                       goto out_unlock_free_pages;
> > >                 ret =3D range_tree_clear(&arena->rt, pgoff, page_cnt)=
;
> > >         } else {
> > >                 ret =3D pgoff =3D range_tree_find(&arena->rt, page_cn=
t);
> > > @@ -527,34 +536,56 @@ static long arena_alloc_pages(struct bpf_arena =
*arena, long uaddr, long page_cnt
> > >                         ret =3D range_tree_clear(&arena->rt, pgoff, p=
age_cnt);
> > >         }
> > >         if (ret)
> > > -               goto out_free_pages;
> > > -
> > > -       struct apply_range_data data =3D { .pages =3D pages, .i =3D 0=
 };
> > > -       ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, p=
ages);
> > > -       if (ret)
> > > -               goto out;
> > > +               goto out_unlock_free_pages;
> > >
> > > +       remaining =3D page_cnt;
> > >         uaddr32 =3D (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
> > > -       /* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SI=
ZE - 1
> > > -        * will not overflow 32-bit. Lower 32-bit need to represent
> > > -        * contiguous user address range.
> > > -        * Map these pages at kern_vm_start base.
> > > -        * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can ove=
rflow
> > > -        * lower 32-bit and it's ok.
> > > -        */
> > > -       ret =3D apply_to_page_range(&init_mm, kern_vm_start + uaddr32=
,
> > > -                                 page_cnt << PAGE_SHIFT, apply_range=
_set_cb, &data);
> > > -       if (ret) {
> > > -               for (i =3D 0; i < page_cnt; i++)
> > > -                       __free_page(pages[i]);
> > > -               goto out;
> > > +
> > > +       while (remaining) {
> > > +               long this_batch =3D min(remaining, alloc_pages);
> > > +
> > > +               /* zeroing is needed, since alloc_pages_bulk() only f=
ills in non-zero entries */
> > > +               memset(pages, 0, this_batch * sizeof(struct page *));
> > > +               data.i =3D 0;
> >
> > Pls move data.i =3D 0 further down to be done right before
> > apply_to_page_range() since it's one logical operation.
> > Here it's done too early.
> >
> > > +
> > > +               ret =3D bpf_map_alloc_pages(&arena->map, node_id, thi=
s_batch, pages);
> > > +               if (ret)
> > > +                       goto out;
> > > +
> > > +               /* Earlier checks made sure that uaddr32 + page_cnt *=
 PAGE_SIZE - 1
> >
> > Pls reformat the comment as you move them as
> > /*
> >  * ...
> >  */
> >
> > > +                * will not overflow 32-bit. Lower 32-bit need to rep=
resent
> > > +                * contiguous user address range.
> > > +                * Map these pages at kern_vm_start base.
> > > +                * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1=
 can overflow
> > > +                * lower 32-bit and it's ok.
> > > +                */
> > > +               ret =3D apply_to_page_range(&init_mm,
> > > +                                         kern_vm_start + uaddr32 + (=
mapped << PAGE_SHIFT),
> > > +                                         this_batch << PAGE_SHIFT, a=
pply_range_set_cb, &data);
> > > +               if (ret) {
> > > +                       /* data.i pages were mapped, account them and=
 free the remaining */
> > > +                       mapped +=3D data.i;
> > > +                       for (i =3D data.i; i < this_batch; i++)
> > > +                               __free_page(pages[i]);
> > > +                       goto out;
> > > +               }
> > > +
> > > +               mapped +=3D this_batch;
> > > +               remaining -=3D this_batch;
> > >         }
> > > -       kvfree(pages);
> > > +       mutex_unlock(&arena->lock);
> > > +       kfree_nolock(pages);
> > >         return clear_lo32(arena->user_vm_start) + uaddr32;
> > >  out:
> > > -       range_tree_set(&arena->rt, pgoff, page_cnt);
> > > +       range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped)=
;
> > > +       mutex_unlock(&arena->lock);
> > > +       if (mapped)
> > > +               arena_free_pages(arena, clear_lo32(arena->user_vm_sta=
rt) + uaddr32, mapped);
> >
> > This doesn't look right.
> > The first thing arena_free_pages() does is:
> >         uaddr =3D (u32)uaddr;
> >         uaddr &=3D PAGE_MASK;
> >         full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;
>
> So, arena_free_pages() should be called with what arena_alloc_pages()
> returns, we return:
>
>     return clear_lo32(arena->user_vm_start) + uaddr32;
>
> from arena_alloc_pages(); few lines above.

yes, that's what this kfunc returns to bpf prog,
but we shouldn't do pointless math to call arena_free_pages().
Just arena_free_pages(..., uaddr32, ...) will do.

