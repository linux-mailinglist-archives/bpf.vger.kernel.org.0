Return-Path: <bpf+bounces-75256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D49C7BBDF
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 22:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5779F4E12D2
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F22F1FD0;
	Fri, 21 Nov 2025 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJZxlmGK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA8533D6
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763760364; cv=none; b=kyFfjviSDAIz2DsoLKX+jUZo5jcjy7A9O0KdOWCOHaZfraR0qCHv2VQcrjq9FqhVo9K0VttaPfBMQs9Q03TWKEbSp0Wf1/ee283Im0EFfe3mmFsAmqiRBbZ+EljImFDgAF5gxaXMCniUJHLyRMoRtNSGzj8OnGysiQ46rkFIDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763760364; c=relaxed/simple;
	bh=NcegTtXbKd7E638BlEjy5NrjQdEUtc/GIZkqnWTIHlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0rZtlx6EmbKPNLmnxp3sijLZnW/h1n7Er1w938fxbhH5lsabZZKDjr9YI7It38wv1pliqfiF3vT0bICohJzHpd6V8EFtrCuJRM5ZzBveQbrYAvX/04OuIkLETlxHYKdDMTccWybjFb+UAMZ3CK3CvXXuKz2JI90ofXR+wAKP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJZxlmGK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so22244585e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 13:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763760359; x=1764365159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hbHnIC0oSAQg7Go5hvwreg2waa3+1RH7hB/51B5ivI=;
        b=LJZxlmGKSjg/cMRlbYMKr7TepKq1IOvuF1kr2Dpl+y09ywIWdjj9sZUbkOlbjih6G1
         t/jIEuAtuGIDhPI2vavZdjuDbgVrHYDcmNJC4kfAyYelIMS4onlPQsPFf6Z0X2QjuR/X
         hKZ9stlbPDQNKPcJEGSxe+IoP4kIoTCvKUmS2pe4pP2S4YsD1Jgb8bxYEXWNs1tIUfNI
         ZEL0ZSQuagFg1q6Q2aMa55Pnhw+fQWgwfJaRQ9r77qMM1HhoAXbfy9PUfHOVJrz+03mY
         vniMEI8SEYzWrDD0+tEt+IZ9izCALd9vjDMYdHoG0s8equ5CwzG5v6bpKhpoxFOPSz9/
         2+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763760359; x=1764365159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hbHnIC0oSAQg7Go5hvwreg2waa3+1RH7hB/51B5ivI=;
        b=gmNnTCtRzLyNe3JOucrS8mOKMqp3o7LaeSOxhZtHUEI2c4MFcH0MkEJDB5b9+74zqe
         Z6hHwlw4/81FR6VklBr04LVIL8w4CWQmb275egFNyN7DSybUY+FR6cJfvHPSw5q75Uja
         6APHx1lmk/bnsl/Dxzu9Kl4AE38qxco7FrZlhrijRJz9jkeG9PqdrhQvgKZfP6tfDMqu
         LoxkEu3Qo1jnXDe9kSwZnkqnfruJdW0eUfk5YnlwRN4m0hYQvoYgy3oR8MYxAvc7svII
         VNcZV26FNzUAQ4ruGpIMSK2plKQKcMIVqn3NZdqSWDV1FWPXNNJXPTphQHr630fKVUGQ
         GrUA==
X-Gm-Message-State: AOJu0Yxte5DZweC/ok9vTEX0ag14cZ32HrSZwsDB5VY/jbjlZYkXOZCR
	M9QjHEB6iEB5oB6KUDPdfWBhm9mDQsiRZm1NiCojK76j6jElLp405Kc0ycAlyaIQ12ka2DhZCVQ
	OmYormoG6bq3x2FD/wVfqNAaEcTPv1z8=
X-Gm-Gg: ASbGncs1mFeHkb1uAcJuv/nLhfvus4lc8nRfBeEBETdZVxOI/IBv/MSZdfw9Yf8WGaS
	axpzdLo8HX3+RstHIdiBgX+5V6GGFsgeUeJf0wphz7WcgTjk1kXWmn7yCYCM4ewvKeEoA43jheS
	nFxrMKxrfYMZ5RIlK/ApvhSDTuhzCBB2qpGtHLbdUgaQu6vRR/rRQnJRDPpobA1D8nmHRrhFlW7
	AcAJ358h3is3lxyt0LfiC5h45AcN47wzCEiChq+oJuzoGglitUOL1Kr4lGKYPgbwT4vAl12KfXZ
	HYBoSOCUn0Mfo+iBQGPENe+/hXtI
X-Google-Smtp-Source: AGHT+IHHmxpkE4k/Pc+qVLmwLgakg2o/XeTiRfWmiRQoaFYPKQMwEajwXoyb0CeM5sJ7GOw09UVg0OeYNOZAW0PW8ns=
X-Received: by 2002:a05:600c:5491:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-477c016bc8bmr42327785e9.4.1763760359262; Fri, 21 Nov 2025
 13:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117160150.62183-1-puranjay@kernel.org> <20251117160617.4604-1-puranjay@kernel.org>
 <20251117160617.4604-2-puranjay@kernel.org>
In-Reply-To: <20251117160617.4604-2-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 13:25:48 -0800
X-Gm-Features: AWmQ_blpgDTztNsT3_kID2JP7HUP8nawIOof7EynbmQpNsLWFp5ZDMNVBQPLnII
Message-ID: <CAADnVQJB9kOUVP-W0RT7jHFQVhRjrdmNPn6yHtdQourWw9d7AA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: arena: make arena kfuncs any context safe
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
> Make arena related kfuncs any context safe by the following changes:
>
> bpf_arena_alloc_pages() and bpf_arena_reserve_pages():
> Replace the usage of the mutex with a rqspinlock for range tree and use
> kmalloc_nolock() wherever needed. Use free_pages_nolock() to free pages
> from any context.
> apply_range_set/clear_cb() with apply_to_page_range() has already made
> populating the vm_area in bpf_arena_alloc_pages() any context safe.
>
> bpf_arena_free_pages(): defer the main logic to a workqueue if it is
> called from a non-sleepable context.
>
> specialize_kfunc() is used to replace the sleepable arena_free_pages()
> with bpf_arena_free_pages_non_sleepable() when the verifier detects the
> call is from a non-sleepable context.
>
> In the non-sleepable case, arena_free_pages() queues the address and the
> page count to be freed to a lock-less list of struct arena_free_spans
> and raises an irq_work. The irq_work handler calls schedules_work() as
> it is safe to be called from irq context.  arena_free_worker() (the work
> queue handler) iterates these spans and clears ptes, flushes tlb, zaps
> pages, and calls __free_page().
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/bpf.h   |  15 +++
>  kernel/bpf/arena.c    | 249 +++++++++++++++++++++++++++++++++++-------
>  kernel/bpf/verifier.c |  10 ++
>  3 files changed, 233 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 09d5dc541d1c..8339b3bd8295 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -673,6 +673,21 @@ void bpf_map_free_internal_structs(struct bpf_map *m=
ap, void *obj);
>  int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
>                                    struct bpf_dynptr *ptr__uninit);
>
> +#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> +void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign,=
 u32 page_cnt, int node_id,
> +                                         u64 flags);
> +void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u3=
2 page_cnt);
> +#else
> +static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, vo=
id *addr__ign, u32 page_cnt,
> +                                                       int node_id, u64 =
flags)
> +{
> +}
> +
> +static inline void bpf_arena_free_pages_non_sleepable(void *p__map, void=
 *ptr__ign, u32 page_cnt)
> +{
> +}
> +#endif
> +
>  extern const struct bpf_map_ops bpf_map_offload_ops;
>
>  /* bpf_type_flag contains a set of flags that are applicable to the valu=
es of
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1d0b49a39ad0..8134d907b8e2 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -3,7 +3,9 @@
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
>  #include <linux/err.h>
> +#include <linux/irq_work.h>
>  #include "linux/filter.h"
> +#include <linux/llist.h>
>  #include <linux/btf_ids.h>
>  #include <linux/vmalloc.h>
>  #include <linux/pagemap.h>
> @@ -43,7 +45,7 @@
>  #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8=
, PAGE_SIZE << 1)
>  #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
>
> -static void arena_free_pages(struct bpf_arena *arena, long uaddr, long p=
age_cnt);
> +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long p=
age_cnt, bool sleepable);
>
>  struct bpf_arena {
>         struct bpf_map map;
> @@ -51,8 +53,23 @@ struct bpf_arena {
>         u64 user_vm_end;
>         struct vm_struct *kern_vm;
>         struct range_tree rt;
> +       /* protects rt */
> +       rqspinlock_t spinlock;
>         struct list_head vma_list;
> +       /* protects vma_list */
>         struct mutex lock;
> +       struct irq_work     free_irq;
> +       struct work_struct  free_work;
> +       struct llist_head   free_spans;
> +};
> +
> +static void arena_free_worker(struct work_struct *work);
> +static void arena_free_irq(struct irq_work *iw);
> +
> +struct arena_free_span {
> +       struct llist_node node;
> +       unsigned long uaddr;
> +       u32 page_cnt;
>  };
>
>  u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
> @@ -120,7 +137,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned lo=
ng addr, void *data)
>         return 0;
>  }
>
> -static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *da=
ta)
> +static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *fr=
ee_pages)
>  {
>         pte_t old_pte;
>         struct page *page;
> @@ -130,17 +147,16 @@ static int apply_range_clear_cb(pte_t *pte, unsigne=
d long addr, void *data)
>         if (pte_none(old_pte) || !pte_present(old_pte))
>                 return 0; /* nothing to do */
>
> -       /* get page and free it */
> +       /* get page and clear pte */

Just delete the comment. The code is obvious enough.

>         page =3D pte_page(old_pte);
>         if (WARN_ON_ONCE(!page))
>                 return -EINVAL;
>
>         pte_clear(&init_mm, addr, pte);
>
> -       /* ensure no stale TLB entries */
> -       flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -
> -       __free_page(page);
> +       /* Add page to the list so it is freed later */
> +       if (free_pages)
> +               __llist_add(&page->pcp_llist, free_pages);
>
>         return 0;
>  }
> @@ -195,6 +211,9 @@ static struct bpf_map *arena_map_alloc(union bpf_attr=
 *attr)
>                 arena->user_vm_end =3D arena->user_vm_start + vm_range;
>
>         INIT_LIST_HEAD(&arena->vma_list);
> +       init_llist_head(&arena->free_spans);
> +       init_irq_work(&arena->free_irq, arena_free_irq);
> +       INIT_WORK(&arena->free_work, arena_free_worker);
>         bpf_map_init_from_attr(&arena->map, attr);
>         range_tree_init(&arena->rt);
>         err =3D range_tree_set(&arena->rt, 0, attr->max_entries);
> @@ -203,6 +222,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr=
 *attr)
>                 goto err;
>         }
>         mutex_init(&arena->lock);
> +       raw_res_spin_lock_init(&arena->spinlock);
>         err =3D populate_pgtable_except_pte(arena);
>         if (err) {
>                 range_tree_destroy(&arena->rt);
> @@ -249,6 +269,10 @@ static void arena_map_free(struct bpf_map *map)
>         if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
>                 return;
>
> +       /* Ensure no pending deferred frees */
> +       irq_work_sync(&arena->free_irq);
> +       flush_work(&arena->free_work);
> +
>         /*
>          * free_vm_area() calls remove_vm_area() that calls free_unmap_vm=
ap_area().
>          * It unmaps everything from vmalloc area and clears pgtables.
> @@ -332,12 +356,19 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
>         struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
>         struct page *page;
>         long kbase, kaddr;
> +       unsigned long flags;
>         int ret;
>
>         kbase =3D bpf_arena_get_kern_vm_start(arena);
>         kaddr =3D kbase + (u32)(vmf->address);
>
> -       guard(mutex)(&arena->lock);
> +       if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +               /*
> +                * This is an impossible case and would only trigger if r=
es_spin_lock is buggy or
> +                * due to another kernel bug.
> +                */

Looking at this comment again I'm starting to feel that it
opens a can of worms, since what does it mean to retry when
there is a kernel bug or rqspinlock bug? Should it be BUG_ON? etc.

Let's just say
/* Make a reasonable effort to address impossible case */

> +               return VM_FAULT_RETRY;
> +
>         page =3D vmalloc_to_page((void *)kaddr);
>         if (page)
>                 /* already have a page vmap-ed */
> @@ -345,30 +376,34 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
>
>         if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
>                 /* User space requested to segfault when page is not allo=
cated by bpf prog */
> -               return VM_FAULT_SIGSEGV;
> +               goto out_unlock_sigsegv;
>
>         ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
>         if (ret)
> -               return VM_FAULT_SIGSEGV;
> +               goto out_unlock_sigsegv;
>
>         struct apply_range_data data =3D { .pages =3D &page, .i =3D 0 };
>         /* Account into memcg of the process that created bpf_arena */
>         ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>         if (ret) {
>                 range_tree_set(&arena->rt, vmf->pgoff, 1);
> -               return VM_FAULT_SIGSEGV;
> +               goto out_unlock_sigsegv;
>         }
>
>         ret =3D apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_ran=
ge_set_cb, &data);
>         if (ret) {
>                 range_tree_set(&arena->rt, vmf->pgoff, 1);
> -               __free_page(page);
> -               return VM_FAULT_SIGSEGV;
> +               free_pages_nolock(page, 0);
> +               goto out_unlock_sigsegv;
>         }
>  out:
>         page_ref_add(page, 1);
> +       raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>         vmf->page =3D page;
>         return 0;
> +out_unlock_sigsegv:
> +       raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +       return VM_FAULT_SIGSEGV;
>  }
>
>  static const struct vm_operations_struct arena_vm_ops =3D {
> @@ -489,7 +524,8 @@ static u64 clear_lo32(u64 val)
>   * Allocate pages and vmap them into kernel vmalloc area.
>   * Later the pages will be mmaped into user space vma.
>   */
> -static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long =
page_cnt, int node_id)
> +static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long =
page_cnt, int node_id,
> +                             bool sleepable)
>  {
>         /* user_vm_end/start are fixed before bpf prog runs */
>         long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_start)=
 >> PAGE_SHIFT;
> @@ -498,6 +534,7 @@ static long arena_alloc_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt
>         struct page **pages =3D NULL;
>         long remaining, mapped =3D 0;
>         long alloc_pages;
> +       unsigned long flags;
>         long pgoff =3D 0;
>         u32 uaddr32;
>         int ret, i;
> @@ -523,7 +560,8 @@ static long arena_alloc_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt
>                 return 0;
>         data.pages =3D pages;
>
> -       mutex_lock(&arena->lock);
> +       if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +               goto out_free_pages;
>
>         if (uaddr) {
>                 ret =3D is_range_tree_set(&arena->rt, pgoff, page_cnt);
> @@ -566,24 +604,25 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
>                         /* data.i pages were mapped, account them and fre=
e the remaining */
>                         mapped +=3D data.i;
>                         for (i =3D data.i; i < this_batch; i++)
> -                               __free_page(pages[i]);
> +                               free_pages_nolock(pages[i], 0);
>                         goto out;
>                 }
>
>                 mapped +=3D this_batch;
>                 remaining -=3D this_batch;
>         }
> -       mutex_unlock(&arena->lock);
> +       raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>         kfree_nolock(pages);
>         return clear_lo32(arena->user_vm_start) + uaddr32;
>  out:
>         range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> -       mutex_unlock(&arena->lock);
> +       raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>         if (mapped)
> -               arena_free_pages(arena, clear_lo32(arena->user_vm_start) =
+ uaddr32, mapped);
> +               arena_free_pages(arena, clear_lo32(arena->user_vm_start) =
+ uaddr32, mapped,
> +                                sleepable);
>         goto out_free_pages;
>  out_unlock_free_pages:
> -       mutex_unlock(&arena->lock);
> +       raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  out_free_pages:
>         kfree_nolock(pages);
>         return 0;
> @@ -598,42 +637,65 @@ static void zap_pages(struct bpf_arena *arena, long=
 uaddr, long page_cnt)
>  {
>         struct vma_list *vml;
>
> +       guard(mutex)(&arena->lock);
> +       /* iterate link list under lock */
>         list_for_each_entry(vml, &arena->vma_list, head)
>                 zap_page_range_single(vml->vma, uaddr,
>                                       PAGE_SIZE * page_cnt, NULL);
>  }
>
> -static void arena_free_pages(struct bpf_arena *arena, long uaddr, long p=
age_cnt)
> +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long p=
age_cnt, bool sleepable)
>  {
>         u64 full_uaddr, uaddr_end;
> -       long kaddr, pgoff, i;
> +       long kaddr, pgoff;
>         struct page *page;
> +       struct llist_head free_pages;
> +       struct llist_node *pos, *t;
> +       struct arena_free_span *s;
> +       unsigned long flags;
> +       int ret =3D 0;
>
>         /* only aligned lower 32-bit are relevant */
>         uaddr =3D (u32)uaddr;
>         uaddr &=3D PAGE_MASK;
> +       kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
>         full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;
>         uaddr_end =3D min(arena->user_vm_end, full_uaddr + (page_cnt << P=
AGE_SHIFT));
>         if (full_uaddr >=3D uaddr_end)
>                 return;
>
>         page_cnt =3D (uaddr_end - full_uaddr) >> PAGE_SHIFT;
> +       pgoff =3D compute_pgoff(arena, uaddr);
>
> -       guard(mutex)(&arena->lock);
> +       if (!sleepable)
> +               goto defer;
> +
> +       ret =3D raw_res_spin_lock_irqsave(&arena->spinlock, flags);
> +       /*
> +        * Can't proceed without holding the spinlock so defer the free
> +        */

This can be a single line comment like /* Can't proceed ... */

