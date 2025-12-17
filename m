Return-Path: <bpf+bounces-76913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C75CC9746
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 21:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5019A301A72C
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 20:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFFF27F016;
	Wed, 17 Dec 2025 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKCVjNYt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DB155CB3
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001819; cv=none; b=J0IIE04tLnAgf/dMDawemBoNoymm8eZ6b0Xw4MtUsmkedsIBWwFJiqNKxEwcOsR8ON6Ak9fsZeKHr2U6rj6HeBqIBAzlNf3dc0pOWAh+uFAu60dRzQeSWv+gBv+yUgYfziWi4EIK32BOFWLC3GWMGoRoKPNekOMknVKxM5R7ftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001819; c=relaxed/simple;
	bh=dY8qyjg4TQifIq2ACkxv5aAbxyc9t4IFkzp7WSL1fUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBjWBzg4lJ0i0hnjVk2O0a0bAIlUYefUFajPn4QTAYhN/Csbu6xT8x9rBYQKT2y4rEj3o6TgkE24vizf4VjE2keSp0leykVSUDdr/eU8cXbr2rIDvdwpOGXdBqgeYDtF2kz5GOQbTI8ifFf/uCIpQTAJSdZoGt7kHWPSp0n6FdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKCVjNYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCB3C4CEF5
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766001819;
	bh=dY8qyjg4TQifIq2ACkxv5aAbxyc9t4IFkzp7WSL1fUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RKCVjNYtDEwB/L0S9dHfCmWbGwAGHxtfNUCfp5nrYlhX+lP5A6MmaOi9OQ6x/tEcs
	 VbQMYhYwZItxThos6VLTvtCm3FEL+LSkOfWbR9QGIy/gMjEfrZtR0+KmZHdfIP/zF1
	 CSioQpLnHWwBoUxz5T0LwUQIfqHtOUUNKqvjk2AU02UOo1ggfQ9a+CH+LsyLWPKLfh
	 5dbv/KdIe3nayCTUwU2UZQbZzvu12gP3C6s3GIrpxCwDa7H5Aah78E1nY41SHG2aUR
	 wyV7H6A0T34X9PlyatQ65HdiqbX3sac/Z6kIMUJDTmemeqNhHm4bAHYY8kM32n+w1t
	 RIqp5hkNKoYaQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6495e5265c9so9190614a12.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 12:03:39 -0800 (PST)
X-Gm-Message-State: AOJu0YyZZjKPQ8sxyoxyDhjAHMt8EbES8tt2/ato8vu2EPNDnqkMFP/r
	+VZXWrmipsjMpywJ70fhexUJaq9Tz12CnZ12/iM2GNtieXUPNb0ngbUZB3+CSMK1TEywawqAmcr
	a0lQUbYgWWusDevJsfBdyA367gGrKT6U=
X-Google-Smtp-Source: AGHT+IHTDWsATT0Zf3b7P0pI2QHwVru3Fm9E44JD0/AfMLU8bYfyABZzqMcSAAdyK5y7IvEg16NK9kn4nXBR5wpQuAQ=
X-Received: by 2002:a05:6402:26d1:b0:649:8c4a:25db with SMTP id
 4fb4d7f45d1cf-6499b30fe19mr16658492a12.24.1766001817551; Wed, 17 Dec 2025
 12:03:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217184438.3557859-2-puranjay@kernel.org> <3a85d544551fcd6d0b770c1824dcce7e39caff71380a36fb77e33397fd2457bc@mail.kernel.org>
In-Reply-To: <3a85d544551fcd6d0b770c1824dcce7e39caff71380a36fb77e33397fd2457bc@mail.kernel.org>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 17 Dec 2025 20:03:23 +0000
X-Gmail-Original-Message-ID: <CANk7y0jOOrMOKEL9AGebuFrc8AGYWLABoUdfGBtdDCQaE-484A@mail.gmail.com>
X-Gm-Features: AQt7F2rd69wqu5VZ_sIJvOyr0p0-yjy-6ZkSV4wSUh0xfxRMi1ckb52TiIz4s_Y
Message-ID: <CANk7y0jOOrMOKEL9AGebuFrc8AGYWLABoUdfGBtdDCQaE-484A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: arena: populate vm_area without
 allocating memory
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 7:06=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 872dc0e41c65..039f25fc074b 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/btf_ids.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/pagemap.h>
> > +#include <asm/tlbflush.h>
> >  #include "range_tree.h"
> >
> >  /*
> > @@ -92,6 +93,63 @@ static long compute_pgoff(struct bpf_arena *arena, l=
ong uaddr)
> >       return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
> >  }
> >
> > +struct apply_range_data {
> > +     struct page **pages;
> > +     int i;
> > +};
> > +
> > +static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *da=
ta)
> > +{
> > +     struct apply_range_data *d =3D data;
> > +     struct page *page;
> > +
> > +     if (!data)
> > +             return 0;
> > +     /* sanity check */
> > +     if (unlikely(!pte_none(ptep_get(pte))))
> > +             return -EBUSY;
> > +
> > +     page =3D d->pages[d->i];
> > +     /* paranoia, similar to vmap_pages_pte_range() */
> > +     if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
> > +             return -EINVAL;
> > +
> > +     set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
> > +     d->i++;
> > +     return 0;
> > +}
>
> The old code path used vm_area_map_pages() which calls vmap_pages_range()=
,
> and vmap_pages_range() calls flush_cache_vmap() after setting up the
> mappings. This new callback sets PTEs but doesn't flush the cache.
>
> Several architectures (arc, nios2, sh, xtensa) have non-trivial
> flush_cache_vmap() implementations that flush the entire cache or
> specific ranges. Is the cache flush intentionally omitted here, or could
> this cause stale cache data on those architectures?

I did not know about this quirk of these architectures, I will fix it
in the next version.

>
> [ ... ]
>
> > @@ -428,7 +493,8 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt)
> >       /* user_vm_end/start are fixed before bpf prog runs */
> >       long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_start)=
 >> PAGE_SHIFT;
> >       u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> > -     struct page **pages;
> > +     struct page **pages =3D NULL;
> > +     long mapped =3D 0;
> >       long pgoff =3D 0;
> >       u32 uaddr32;
> >       int ret, i;
>
> [ ... ]
>
> >
> > +     struct apply_range_data data =3D { .pages =3D pages, .i =3D 0 };
> >       ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages=
);
> >       if (ret)
> >               goto out;
> > @@ -477,17 +544,20 @@ static long arena_alloc_pages(struct bpf_arena *a=
rena, long uaddr, long page_cnt)
> >        * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflo=
w
> >        * lower 32-bit and it's ok.
> >        */
> > -     ret =3D vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32=
,
> > -                             kern_vm_start + uaddr32 + page_cnt * PAGE=
_SIZE, pages);
> > +     ret =3D apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> > +                               page_cnt << PAGE_SHIFT, apply_range_set=
_cb, &data);
> >       if (ret) {
> > -             for (i =3D 0; i < page_cnt; i++)
> > +             mapped =3D data.i;
> > +             for (i =3D mapped; i < page_cnt; i++)
> >                       __free_page(pages[i]);
> >               goto out;
> >       }
> >       kvfree(pages);
> >       return clear_lo32(arena->user_vm_start) + uaddr32;
> >  out:
> > -     range_tree_set(&arena->rt, pgoff, page_cnt);
> > +     range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> > +     if (mapped)
> > +             arena_free_pages(arena, uaddr32, mapped);
> >  out_free_pages:
>
> The new error handling calls arena_free_pages() when apply_to_page_range(=
)
> partially succeeds. However, arena_alloc_pages() takes arena->lock via
> guard(mutex) at the start of the function, and arena_free_pages() also
> tries to take arena->lock via guard(mutex).
>
> Doesn't this create a deadlock? The call path would be:
>
>   arena_alloc_pages() takes lock ->
>   apply_to_page_range() fails after mapping some pages ->
>   arena_free_pages() tries to take the same lock ->
>   deadlock
>
> The old code didn't have this issue because vm_area_map_pages() would
> either succeed completely or fail before any pages were mapped, so the
> error path only freed page structures, not kernel mappings.

Yes, it is fixed in the 3rd patch but you are right, I will fix this too in=
 the
next version by not using guard and dropping the mutex before calling
arena_free_pages().

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/203138=
34837

