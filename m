Return-Path: <bpf+bounces-75255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070FC7BBB4
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 22:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0003A7937
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4082BE05B;
	Fri, 21 Nov 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msYsYTEY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECA28507B
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763759758; cv=none; b=kfKKoBnMmNx85o9jsL+J9GGaOi9OBpNafjkLp6lsDIS99P0pX1ksxpaCV00YtATdetmjqKBTxBG0p04GJQHbTubWBf6FI2z4oBy8/AlsJYtKyMDjGmgS8hcEFlo5meHPFOIpB5UKgAhzSCxr7e93rNgSpMUxVQx/QtDiCqJ5ar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763759758; c=relaxed/simple;
	bh=rBKeLQ0KbrSY+k9nGdzGHj6TowwBQP2pBgZC3VceRrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ry3da0l7My1iT2JkEo7pVpF/U7YZXaFDvMKt1gbfb9jiOwz1ZJGohZFIJUEPsEx4ZKF4SNfDR/MTCDBbyz2uqQZlyh3iZBYGzpRyX1O6AXnoDdf8lllFVhWwqivpGS/fPMLlgcVoawmt3BtxY+8KE0+msRD/HVUmxx6sPapEq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msYsYTEY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632b0621so17245835e9.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763759755; x=1764364555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55IPXHhbIWxUK8sm0V91rHU5CgCkgythz0bZr48xzo4=;
        b=msYsYTEYRIF0AVwCTh7JNuhZM+RFNtQmLZmNKJWSUifUtYyok1HN6nUurSJpn4l4aq
         HkJbCGvj2HyjUOs+G57ZzDh+JWrB4L4blzxusiLwadZXj164Wge/jl7xmygHbakqPm7Q
         1gbzZ+TZybw4+3QgZqFXaIjm/ygN+6nY+kob6NuK6ZqGHo+xAJ0E0ntpXnQwziyJ2CAe
         9Lu2ux51PBLqr54fz+3PAqZG39GbUV0ZDpN5IMmK41FQbiqw8Ur/a+gaWXvK1xRyH38C
         F+BtMPe/5ZFA8HVPBeKp4I1mXa6uG4ely18kZ62wm3Vin7Oaulj1asDlMJImdIRoniC1
         bUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763759755; x=1764364555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55IPXHhbIWxUK8sm0V91rHU5CgCkgythz0bZr48xzo4=;
        b=CVqXALpTpI5NXP6ogd8bhNhJcdC+nM5MRLMLAtV1BIWz0pQIJR50OeaTMF0X1syGv1
         5Ev2rVRoJMVFdHsjfMC4qeMgKAsCkNt23qt50whn7X1DSqTFsmfe6ybbzqmgHb8k8xx2
         5IMOjGq21TJuQRKnoyDbjlIqJMkjOV3G4cV7quFQyU7vwKkdTsGW2gAg9xxTXE1qbR3a
         9is/Q/MlcE4iOWC4thd9F4ENxwErDqQ9i7Rr1PUtsrCG7ItpbQzi+htvMlpk2lFDmJlh
         Fqedpi7HWaRfsN2Nl0J2slvDGG4vLeOhw8b8NnV8F/o1HwUyaR2Dpc6z+rgWh6oagpCc
         I/lw==
X-Gm-Message-State: AOJu0YyqJWEG5jSpFdzoev5oaOi8KqK7z6qrzwy7y/BOzFmD3EWwQnCx
	9BPO/I9Qi3wyZXNlEc4HiQ14jgzk8jzQCjqxz9xHpU/g6nHSTIYZXEMJLaRPDnlw66MSFHbhr4V
	a8jWLtwL0SMQmBbA4IFdiD5jk+b54GKU=
X-Gm-Gg: ASbGncudD2Q/Eo64U+V6GyYkHyrs49ckj6tbSKf9qE1lJTG0mPbH30hC3kxL3nTCFYZ
	D2Sed8P8kLXO2O9DL9KanLrKHoqUkxXmEu2F2RBaD5YYNApyS+rkxpMpYuH3dgFCs/tpZzGqXzD
	h75ryMuy8qdDlGmMvFH6EhJt+pJpET2qM4A2z47UTWJh7q5wX7ZdMsGD8s8NOVV6EafcYhUnHwt
	ikqSKhfJP+1jT5y0vTfxQDypy9YrONiB6ec4sfttejqndZMnZXhWOvVH+/D417BBfDtCboZ9h84
	wX6i7K6chxYJZBgghMfU2MI9ya4W
X-Google-Smtp-Source: AGHT+IHMGI0IREQuA5IjVBj/TfP4IfVdlwlJ1rwVFe1ohd/WN2AvHHfJTk1U3HiW9rf0k2zwq7uLz8t2kTrfhVjtHVs=
X-Received: by 2002:a05:600c:8b35:b0:475:d8b3:a9d5 with SMTP id
 5b1f17b1804b1-477c10d6fdamr37459635e9.10.1763759754533; Fri, 21 Nov 2025
 13:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117160150.62183-1-puranjay@kernel.org> <20251117160617.4604-1-puranjay@kernel.org>
In-Reply-To: <20251117160617.4604-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 13:15:43 -0800
X-Gm-Features: AWmQ_blwYWlf8NV2HbTJYk9ASPHb8492JduoJrWy4IRLfxI7fMWESkMuAvQ4x3M
Message-ID: <CAADnVQK47-08p8XATMmGdScs19y4Ju+yG0VH2hb-G+QvGi3pPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: arena: use kmalloc_nolock() in place
 of kvcalloc()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 8:06=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> To make arena_alloc_pages() safe to be called from any context, replace
> kvcalloc() with kmalloc_nolock() so as it doesn't sleep or take any
> locks. kmalloc_nolock() returns NULL for allocations larger than
> KMALLOC_MAX_CACHE_SIZE, which is (PAGE_SIZE * 2) =3D 8KB on systems with
> 4KB pages. So, round down the allocation done by kmalloc_nolock to 1024
> * 8 and reuse the array in a loop.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/arena.c | 83 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 26 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 214a4da54162..1d0b49a39ad0 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -43,6 +43,8 @@
>  #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8=
, PAGE_SIZE << 1)
>  #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
>
> +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long p=
age_cnt);
> +
>  struct bpf_arena {
>         struct bpf_map map;
>         u64 user_vm_start;
> @@ -492,7 +494,10 @@ static long arena_alloc_pages(struct bpf_arena *aren=
a, long uaddr, long page_cnt
>         /* user_vm_end/start are fixed before bpf prog runs */
>         long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_start)=
 >> PAGE_SHIFT;
>         u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> +       struct apply_range_data data;
>         struct page **pages =3D NULL;
> +       long remaining, mapped =3D 0;
> +       long alloc_pages;
>         long pgoff =3D 0;
>         u32 uaddr32;
>         int ret, i;
> @@ -509,17 +514,21 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
>                         return 0;
>         }
>
> -       /* zeroing is needed, since alloc_pages_bulk() only fills in non-=
zero entries */
> -       pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
> +       /*
> +        * Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_noloc=
k() can succeed.
> +        */
> +       alloc_pages =3D min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(str=
uct page *));
> +       pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), 0, =
NUMA_NO_NODE);
>         if (!pages)
>                 return 0;
> +       data.pages =3D pages;
>
> -       guard(mutex)(&arena->lock);
> +       mutex_lock(&arena->lock);
>
>         if (uaddr) {
>                 ret =3D is_range_tree_set(&arena->rt, pgoff, page_cnt);
>                 if (ret)
> -                       goto out_free_pages;
> +                       goto out_unlock_free_pages;
>                 ret =3D range_tree_clear(&arena->rt, pgoff, page_cnt);
>         } else {
>                 ret =3D pgoff =3D range_tree_find(&arena->rt, page_cnt);
> @@ -527,34 +536,56 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
>                         ret =3D range_tree_clear(&arena->rt, pgoff, page_=
cnt);
>         }
>         if (ret)
> -               goto out_free_pages;
> -
> -       struct apply_range_data data =3D { .pages =3D pages, .i =3D 0 };
> -       ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages=
);
> -       if (ret)
> -               goto out;
> +               goto out_unlock_free_pages;
>
> +       remaining =3D page_cnt;
>         uaddr32 =3D (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
> -       /* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE -=
 1
> -        * will not overflow 32-bit. Lower 32-bit need to represent
> -        * contiguous user address range.
> -        * Map these pages at kern_vm_start base.
> -        * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflo=
w
> -        * lower 32-bit and it's ok.
> -        */
> -       ret =3D apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> -                                 page_cnt << PAGE_SHIFT, apply_range_set=
_cb, &data);
> -       if (ret) {
> -               for (i =3D 0; i < page_cnt; i++)
> -                       __free_page(pages[i]);
> -               goto out;
> +
> +       while (remaining) {
> +               long this_batch =3D min(remaining, alloc_pages);
> +
> +               /* zeroing is needed, since alloc_pages_bulk() only fills=
 in non-zero entries */
> +               memset(pages, 0, this_batch * sizeof(struct page *));
> +               data.i =3D 0;

Pls move data.i =3D 0 further down to be done right before
apply_to_page_range() since it's one logical operation.
Here it's done too early.

> +
> +               ret =3D bpf_map_alloc_pages(&arena->map, node_id, this_ba=
tch, pages);
> +               if (ret)
> +                       goto out;
> +
> +               /* Earlier checks made sure that uaddr32 + page_cnt * PAG=
E_SIZE - 1

Pls reformat the comment as you move them as
/*
 * ...
 */

> +                * will not overflow 32-bit. Lower 32-bit need to represe=
nt
> +                * contiguous user address range.
> +                * Map these pages at kern_vm_start base.
> +                * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can=
 overflow
> +                * lower 32-bit and it's ok.
> +                */
> +               ret =3D apply_to_page_range(&init_mm,
> +                                         kern_vm_start + uaddr32 + (mapp=
ed << PAGE_SHIFT),
> +                                         this_batch << PAGE_SHIFT, apply=
_range_set_cb, &data);
> +               if (ret) {
> +                       /* data.i pages were mapped, account them and fre=
e the remaining */
> +                       mapped +=3D data.i;
> +                       for (i =3D data.i; i < this_batch; i++)
> +                               __free_page(pages[i]);
> +                       goto out;
> +               }
> +
> +               mapped +=3D this_batch;
> +               remaining -=3D this_batch;
>         }
> -       kvfree(pages);
> +       mutex_unlock(&arena->lock);
> +       kfree_nolock(pages);
>         return clear_lo32(arena->user_vm_start) + uaddr32;
>  out:
> -       range_tree_set(&arena->rt, pgoff, page_cnt);
> +       range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> +       mutex_unlock(&arena->lock);
> +       if (mapped)
> +               arena_free_pages(arena, clear_lo32(arena->user_vm_start) =
+ uaddr32, mapped);

This doesn't look right.
The first thing arena_free_pages() does is:
        uaddr =3D (u32)uaddr;
        uaddr &=3D PAGE_MASK;
        full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;

pw-bot: cr

