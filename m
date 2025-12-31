Return-Path: <bpf+bounces-77613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50436CEC5FD
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BBD8300B839
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AF27FD48;
	Wed, 31 Dec 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA/1PG7L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5A1C84A2
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201943; cv=none; b=KRu/ZF8sb9A8+r/UrdNuVx4tF/BdlwxZvLqw0sujGz9Gkr3ENVT+e2mNbcJ+Y1gwQo1r7jC/6KFx1ln/bJBt6uqHi02l0nXkNV0p8eKjv9FuwEaoN8myyNJEjM/8BFfBj0uEoXGqJEzFAXmzq/8Tt2SL7V1k7Kz6i32wGW66nQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201943; c=relaxed/simple;
	bh=bA/6YRBT1PFhCbIwD7vdWo2+wsiA0lovfpM13L6zj3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajiE4iWy79Sf0cpDeU2xUBJC9fzHYz2h81UhrVb0e9B5vGBf2ccZ19voeTMu1Kat72tzHD+8IXckraO+gGAnL4kjRzw/zoVMgzeBpoCq4HFYoME+VVNbiVKRDI4IiPvcXSO6ggu7CCEVzNpvz8xHQZCnGmIFd/0yvWtUu7OETjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA/1PG7L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477770019e4so92439095e9.3
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767201940; x=1767806740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZebTRn8gxw8x0eE9zM1u3t4XVHZvGw0Ok67REoYbO8=;
        b=VA/1PG7LFTbUTA9xbSY4wcI3k8KFyuCpkG65UiGF9KRvpT4SOgaOWl0QRgsLlIvP3b
         HWL9dGbcQg/OUE3BvpAP/hWAWaMGE8GAmHH/AmpyxzN8dR86g3DPEnhp0noKlHa+bwWG
         uKWuWKL/rWxVN4wCmNMvbQXnkO2mvZYgxu9MKoW8aYly/CXT243we9zyKW0xUGnEzaoI
         GFHmIWG02wONhas66MXxZS9FE9GzQ/jMkOuH1MSzXRkRPPISQ3/qHM0/U+K7YUVcWHD6
         jTbcxfeTJVO3Z64em7bZvjP/wmG5ujQ71/gaLXRf7g+0O92bge2Wvxg0mVT/KN5/TlJX
         rmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767201940; x=1767806740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZebTRn8gxw8x0eE9zM1u3t4XVHZvGw0Ok67REoYbO8=;
        b=nEyrvEVzPn/hHQ5gkd7PJDKonwqVLXG7fy/PBDqSn10noy2udKh8Pfwea+Dhv5X3lF
         jBip/VzpXemTF9PbHzPPhuZDuM/DmQQbMTqUYjsT/Se6n+xx/hlvLDrOd3mf8YZ5vTwa
         TTsMQmmS8lSjH6zT2fjbGxP4M3G6KVwZWghB2Qnol6ICvHmijYGwSrWi39TlBKlH/rk4
         oO9lfYkgdRhoscofoPv9d/+N+Andgo5uxwy6wXmOUyi/rbZ/sFUDP1M//MKsqVBDqy7u
         gDN0AsEgrEuiDPjaUXAeB+7PdUMQEJwPieni5D+gS8wWTA9Qo3bkUmekDogDe5Im0EcH
         8qqQ==
X-Gm-Message-State: AOJu0Yw0o5oCEiY+IXjayRyEepLJFdjxbEJLwyOEXdOEIvU0reEScFOn
	rDb1Bff8xkNOJRcmerLh31NmFD6llJPgrq7ix1zHNU7cSupv4rZxlja1HufyBu5Xg+KjxS4ByvA
	4QugXugkVRcvbXtzlEy9N6DHWUEDrgOs=
X-Gm-Gg: AY/fxX6WYtzLuJvAob8RlqXuytQ/ejZsvX3WsRgYOcb5yBgZk2/QqdiHEl0DG3+WASW
	tkSAtCSkg2pciaImox+6noMVyzwUDJ+9M6E2AqvATieIvYfhBIJgKXsOT3pyrd1jhT1owVSQqNC
	It1bX2uKu7VIOV7FGV1qbizfRrl7GYKSMu9e7VcSqwIzbTGFFYoVjI/1hguMLQvJyBWyTm5H2zx
	XITaM7B7JacfcESd4napleZv4755bVV28Nj0006vHb7gPoNnBZc2gnaYI9Mok7iXVSpFpj52zut
	WLirB+N55xQQ/f16wsxG0FOS3M6d
X-Google-Smtp-Source: AGHT+IEWBDGGpoxqjN7VizA0dXyc1iSBjxEBw/1rqFN6w91asqN45triDviXH8M5wNqtsl9W1WYJeSNnkxFhIbAWuS0=
X-Received: by 2002:a05:6000:26d1:b0:430:f463:b6a7 with SMTP id
 ffacd0b85a97d-4324e50ec19mr50903867f8f.45.1767201939510; Wed, 31 Dec 2025
 09:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231141434.3416822-1-puranjay@kernel.org> <20251231141434.3416822-3-puranjay@kernel.org>
In-Reply-To: <20251231141434.3416822-3-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 09:25:28 -0800
X-Gm-Features: AQt7F2qrYWOKXv_p1p78c2InJdIjrVAK1vIaCQbWy9wmqXk4VRxuEccyZq-T-GI
Message-ID: <CAADnVQKYGiHZw2y79tumaua9UYMXEqvSjGT_XcvBsKyi4KXiLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: arena: Reintroduce memcg accounting
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 6:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> When arena allocations were converted from bpf_map_alloc_pages() to
> kmalloc_nolock() to support non-sleepable contexts, memcg accounting was
> inadvertently lost. This commit restores proper memory accounting for
> all arena-related allocations.
>
> All arena related allocations are accounted into memcg of the process
> that created bpf_arena.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/arena.c      | 44 ++++++++++++++++++++++++++++++++++++-----
>  kernel/bpf/range_tree.c |  5 +++--
>  2 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 456ac989269d..45b55961683f 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -360,6 +360,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf=
)
>  {
>         struct bpf_map *map =3D vmf->vma->vm_file->private_data;
>         struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> +       struct mem_cgroup *new_memcg, *old_memcg;
>         struct page *page;
>         long kbase, kaddr;
>         unsigned long flags;
> @@ -377,6 +378,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf=
)
>                 /* already have a page vmap-ed */
>                 goto out;
>
> +       bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
> +
>         if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
>                 /* User space requested to segfault when page is not allo=
cated by bpf prog */
>                 goto out_unlock_sigsegv;
> @@ -400,12 +403,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
>                 goto out_unlock_sigsegv;
>         }
>         flush_vmap_cache(kaddr, PAGE_SIZE);
> +       bpf_map_memcg_exit(old_memcg, new_memcg);
>  out:
>         page_ref_add(page, 1);
>         raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>         vmf->page =3D page;
>         return 0;
>  out_unlock_sigsegv:
> +       bpf_map_memcg_exit(old_memcg, new_memcg);
>         raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>         return VM_FAULT_SIGSEGV;
>  }
> @@ -557,7 +562,7 @@ static long arena_alloc_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt
>
>         /* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_noloc=
k() can succeed. */
>         alloc_pages =3D min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(str=
uct page *));
> -       pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), 0, =
NUMA_NO_NODE);
> +       pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), __G=
FP_ACCOUNT, NUMA_NO_NODE);
>         if (!pages)
>                 return 0;
>         data.pages =3D pages;
> @@ -713,7 +718,7 @@ static void arena_free_pages(struct bpf_arena *arena,=
 long uaddr, long page_cnt,
>         return;
>
>  defer:
> -       s =3D kmalloc_nolock(sizeof(struct arena_free_span), 0, -1);
> +       s =3D kmalloc_nolock(sizeof(struct arena_free_span), __GFP_ACCOUN=
T, -1);
>         if (!s)
>                 /*
>                  * If allocation fails in non-sleepable context, pages ar=
e intentionally left
> @@ -766,6 +771,7 @@ static int arena_reserve_pages(struct bpf_arena *aren=
a, long uaddr, u32 page_cnt
>  static void arena_free_worker(struct work_struct *work)
>  {
>         struct bpf_arena *arena =3D container_of(work, struct bpf_arena, =
free_work);
> +       struct mem_cgroup *new_memcg, *old_memcg;
>         struct llist_node *list, *pos, *t;
>         struct arena_free_span *s;
>         u64 arena_vm_start, user_vm_start;
> @@ -780,6 +786,8 @@ static void arena_free_worker(struct work_struct *wor=
k)
>                 return;
>         }
>
> +       bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +
>         init_llist_head(&free_pages);
>         arena_vm_start =3D bpf_arena_get_kern_vm_start(arena);
>         user_vm_start =3D bpf_arena_get_user_vm_start(arena);
> @@ -820,6 +828,8 @@ static void arena_free_worker(struct work_struct *wor=
k)
>                 page =3D llist_entry(pos, struct page, pcp_llist);
>                 __free_page(page);
>         }
> +
> +       bpf_map_memcg_exit(old_memcg, new_memcg);
>  }
>
>  static void arena_free_irq(struct irq_work *iw)
> @@ -834,49 +844,69 @@ __bpf_kfunc_start_defs();
>  __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u=
32 page_cnt,
>                                         int node_id, u64 flags)
>  {
> +       void *ret;
>         struct bpf_map *map =3D p__map;
> +       struct mem_cgroup *new_memcg, *old_memcg;
>         struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
>
>         if (map->map_type !=3D BPF_MAP_TYPE_ARENA || flags || !page_cnt)
>                 return NULL;
>
> -       return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt=
, node_id, true);
> +       bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
> +       ret =3D (void *)arena_alloc_pages(arena, (long)addr__ign, page_cn=
t, node_id, true);
> +       bpf_map_memcg_exit(old_memcg, new_memcg);

Should this be done inside arena_alloc_pages() ?

and similar inside arena_free_pages() ?
Doesn't look to me that the error path will get more complex.
just memcg_enter/exit in a few places.
That will avoid copy paste in sleepable/non_sleepable kfuncs.

Also remove redundant memcg_enter/exit from bpf_map_alloc_pages().
No point in doing it twice.
and remove #ifdef in patch 1.

pw-bot: cr

