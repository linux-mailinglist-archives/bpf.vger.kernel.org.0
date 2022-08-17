Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C1F597A5F
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 01:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiHQXwT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 19:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHQXwT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 19:52:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5E190C41
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 16:52:17 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p184so11210iod.6
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 16:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TXUx2Th/aPq5ZDu8FSqxOFF2HGxFNDrSYWc/Xs2J3A8=;
        b=L+wI5O5SwgFzAnVwWpVqXdr91TWtO7RmCzTITMQDI4lNVLxZ+V9E4ubtpWGbkKziMz
         ro7FLxQPZgI/62i9O3MqX0UZDGisV1AqJP+AdOSJh+nJsUfGMT/GibTQhezvBKq3CKaC
         o7FTlzWIKfJBPwNpf5f+2N7UZ46gRldMPcIuWflwhAOOuaa8Z7KmNk3MS9eGkZCniHvy
         KMekjwyiJNQgR5Fla/ktOBSPwWHJ56rD46CkQcxg73jKWI6wx7xGHNR4+mIw0jW5dHUa
         duEGYIn6c7HGbOojJTxwYUWEqRPfWQg0BWf1Mqqv+6HSQn86D8Zd0OF13t4KPCwas/gF
         ki+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TXUx2Th/aPq5ZDu8FSqxOFF2HGxFNDrSYWc/Xs2J3A8=;
        b=hvv6ZXQ0RmLZNQim+VbQgX3QiKlcP3lVGNUiO1+9QY6EdtT9HIqjUqw03xTplbgUHm
         4rLVbe/R66A8Tglm5CtOdp4aISbKL4mEvm3nc9LQIaL65C0an09PhTVpPQ00vfJrtp3+
         X9Nd2losMwvxphWqqbS5kIT6/UHURX/x+INL6ROzL0cZ4JmbwvH2earbD3mNc7DiSVuy
         IfHBB3uFM7nJHBN5LtsW4apGUIGxEtLyTuGcZ7O17E6PHY9L6X5RuKcNHep6iBF4kICC
         Ch6ghDYBdueIDEFNfUjIkAYi81vQriw5TNXqb7T4jK3ipnu+SlP1MZHkmQXU9NAFwVDy
         syrA==
X-Gm-Message-State: ACgBeo3oTn/lFiav9neemMqMb1uG/Wz9LO8r0oSOZt2VlAwqVXb8sWtF
        P/MfOUWe3rYFu6R63tV5DMtw4WWwvq3OUhhylOc=
X-Google-Smtp-Source: AA6agR5DOTd4aWjjRBrE91dHY+mMH79PW7AXsc3FjqrVIHGGaLme+tt0GglgZFPB9qj+fKyIX98bRf5btTvvaVF/sbw=
X-Received: by 2002:a05:6638:2381:b0:346:c583:9fa0 with SMTP id
 q1-20020a056638238100b00346c5839fa0mr285290jat.93.1660780336403; Wed, 17 Aug
 2022 16:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com> <20220817210419.95560-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20220817210419.95560-2-alexei.starovoitov@gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 18 Aug 2022 01:51:39 +0200
Message-ID: <CAP01T77L6e=B6OtLcM4bToM5n4+j3S6+p+ieTPtDGUgQUZ3o1Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/12] bpf: Introduce any context BPF specific
 memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 17 Aug 2022 at 23:04, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Tracing BPF programs can attach to kprobe and fentry. Hence they
> run in unknown context where calling plain kmalloc() might not be safe.
>
> Front-end kmalloc() with minimal per-cpu cache of free elements.
> Refill this cache asynchronously from irq_work.
>
> BPF programs always run with migration disabled.
> It's safe to allocate from cache of the current cpu with irqs disabled.
> Free-ing is always done into bucket of the current cpu as well.
> irq_work trims extra free elements from buckets with kfree
> and refills them with kmalloc, so global kmalloc logic takes care
> of freeing objects allocated by one cpu and freed on another.
>
> struct bpf_mem_alloc supports two modes:
> - When size != 0 create kmem_cache and bpf_mem_cache for each cpu.
>   This is typical bpf hash map use case when all elements have equal size.
> - When size == 0 allocate 11 bpf_mem_cache-s for each cpu, then rely on
>   kmalloc/kfree. Max allocation size is 4096 in this case.
>   This is bpf_dynptr and bpf_kptr use case.
>
> bpf_mem_alloc/bpf_mem_free are bpf specific 'wrappers' of kmalloc/kfree.
> bpf_mem_cache_alloc/bpf_mem_cache_free are 'wrappers' of kmem_cache_alloc/kmem_cache_free.
>
> The allocators are NMI-safe from bpf programs only. They are not NMI-safe in general.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf_mem_alloc.h |  26 ++
>  kernel/bpf/Makefile           |   2 +-
>  kernel/bpf/memalloc.c         | 526 ++++++++++++++++++++++++++++++++++
>  3 files changed, 553 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/bpf_mem_alloc.h
>  create mode 100644 kernel/bpf/memalloc.c
>
> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
> new file mode 100644
> index 000000000000..804733070f8d
> --- /dev/null
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#ifndef _BPF_MEM_ALLOC_H
> +#define _BPF_MEM_ALLOC_H
> +#include <linux/compiler_types.h>
> +
> +struct bpf_mem_cache;
> +struct bpf_mem_caches;
> +
> +struct bpf_mem_alloc {
> +       struct bpf_mem_caches __percpu *caches;
> +       struct bpf_mem_cache __percpu *cache;
> +};
> +
> +int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size);
> +void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
> +
> +/* kmalloc/kfree equivalent: */
> +void *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size);
> +void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
> +
> +/* kmem_cache_alloc/free equivalent: */
> +void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
> +void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
> +
> +#endif /* _BPF_MEM_ALLOC_H */
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 057ba8e01e70..11fb9220909b 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>  obj-${CONFIG_BPF_LSM}    += bpf_inode_storage.o
>  obj-$(CONFIG_BPF_SYSCALL) += disasm.o
>  obj-$(CONFIG_BPF_JIT) += trampoline.o
> -obj-$(CONFIG_BPF_SYSCALL) += btf.o
> +obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
>  obj-$(CONFIG_BPF_JIT) += dispatcher.o
>  ifeq ($(CONFIG_NET),y)
>  obj-$(CONFIG_BPF_SYSCALL) += devmap.o
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> new file mode 100644
> index 000000000000..8de268922380
> --- /dev/null
> +++ b/kernel/bpf/memalloc.c
> @@ -0,0 +1,526 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#include <linux/mm.h>
> +#include <linux/llist.h>
> +#include <linux/bpf.h>
> +#include <linux/irq_work.h>
> +#include <linux/bpf_mem_alloc.h>
> +#include <linux/memcontrol.h>
> +
> +/* Any context (including NMI) BPF specific memory allocator.
> + *
> + * Tracing BPF programs can attach to kprobe and fentry. Hence they
> + * run in unknown context where calling plain kmalloc() might not be safe.
> + *
> + * Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> + * Refill this cache asynchronously from irq_work.
> + *
> + * CPU_0 buckets
> + * 16 32 64 96 128 196 256 512 1024 2048 4096
> + * ...
> + * CPU_N buckets
> + * 16 32 64 96 128 196 256 512 1024 2048 4096
> + *
> + * The buckets are prefilled at the start.
> + * BPF programs always run with migration disabled.
> + * It's safe to allocate from cache of the current cpu with irqs disabled.
> + * Free-ing is always done into bucket of the current cpu as well.
> + * irq_work trims extra free elements from buckets with kfree
> + * and refills them with kmalloc, so global kmalloc logic takes care
> + * of freeing objects allocated by one cpu and freed on another.
> + *
> + * Every allocated objected is padded with extra 8 bytes that contains
> + * struct llist_node.
> + */
> +#define LLIST_NODE_SZ sizeof(struct llist_node)
> +
> +/* similar to kmalloc, but sizeof == 8 bucket is gone */
> +static u8 size_index[24] __ro_after_init = {
> +       3,      /* 8 */
> +       3,      /* 16 */
> +       4,      /* 24 */
> +       4,      /* 32 */
> +       5,      /* 40 */
> +       5,      /* 48 */
> +       5,      /* 56 */
> +       5,      /* 64 */
> +       1,      /* 72 */
> +       1,      /* 80 */
> +       1,      /* 88 */
> +       1,      /* 96 */
> +       6,      /* 104 */
> +       6,      /* 112 */
> +       6,      /* 120 */
> +       6,      /* 128 */
> +       2,      /* 136 */
> +       2,      /* 144 */
> +       2,      /* 152 */
> +       2,      /* 160 */
> +       2,      /* 168 */
> +       2,      /* 176 */
> +       2,      /* 184 */
> +       2       /* 192 */
> +};
> +
> +static int bpf_mem_cache_idx(size_t size)
> +{
> +       if (!size || size > 4096)
> +               return -1;
> +
> +       if (size <= 192)
> +               return size_index[(size - 1) / 8] - 1;
> +
> +       return fls(size - 1) - 1;
> +}
> +
> +#define NUM_CACHES 11
> +
> +struct bpf_mem_cache {
> +       /* per-cpu list of free objects of size 'unit_size'.
> +        * All accesses are done with preemption disabled
> +        * with __llist_add() and __llist_del_first().
> +        */
> +       struct llist_head free_llist;
> +
> +       /* NMI only free list.
> +        * All accesses are NMI-safe llist_add() and llist_del_first().
> +        *
> +        * Each allocated object is either on free_llist or on free_llist_nmi.
> +        * One cpu can allocate it from NMI by doing llist_del_first() from
> +        * free_llist_nmi, while another might free it back from non-NMI by
> +        * doing llist_add() into free_llist.
> +        */
> +       struct llist_head free_llist_nmi;
> +
> +       /* kmem_cache != NULL when bpf_mem_alloc was created for specific
> +        * element size.
> +        */
> +       struct kmem_cache *kmem_cache;
> +       struct irq_work refill_work;
> +       struct obj_cgroup *objcg;
> +       int unit_size;
> +       /* count of objects in free_llist */
> +       int free_cnt;
> +       /* count of objects in free_llist_nmi */
> +       atomic_t free_cnt_nmi;
> +       /* flag to refill nmi list too */
> +       bool refill_nmi_list;
> +};
> +
> +struct bpf_mem_caches {
> +       struct bpf_mem_cache cache[NUM_CACHES];
> +};
> +
> +static struct llist_node notrace *__llist_del_first(struct llist_head *head)
> +{
> +       struct llist_node *entry, *next;
> +
> +       entry = head->first;
> +       if (!entry)
> +               return NULL;
> +       next = entry->next;
> +       head->first = next;
> +       return entry;
> +}
> +
> +#define BATCH 48
> +#define LOW_WATERMARK 32
> +#define HIGH_WATERMARK 96
> +/* Assuming the average number of elements per bucket is 64, when all buckets
> + * are used the total memory will be: 64*16*32 + 64*32*32 + 64*64*32 + ... +
> + * 64*4096*32 ~ 20Mbyte
> + */
> +
> +/* extra macro useful for testing by randomizing in_nmi condition */
> +#define bpf_in_nmi() in_nmi()
> +
> +static void *__alloc(struct bpf_mem_cache *c, int node)
> +{
> +       /* Allocate, but don't deplete atomic reserves that typical
> +        * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
> +        * will allocate from the current numa node which is what we
> +        * want here.
> +        */
> +       gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
> +
> +       if (c->kmem_cache)
> +               return kmem_cache_alloc_node(c->kmem_cache, flags, node);
> +
> +       return kmalloc_node(c->unit_size, flags, node);
> +}
> +
> +static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
> +{
> +#ifdef CONFIG_MEMCG_KMEM
> +       if (c->objcg)
> +               return get_mem_cgroup_from_objcg(c->objcg);
> +#endif
> +
> +#ifdef CONFIG_MEMCG
> +       return root_mem_cgroup;
> +#else
> +       return NULL;
> +#endif
> +}
> +
> +/* Mostly runs from irq_work except __init phase. */
> +static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
> +{
> +       struct mem_cgroup *memcg = NULL, *old_memcg;
> +       unsigned long flags;
> +       void *obj;
> +       int i;
> +
> +       memcg = get_memcg(c);
> +       old_memcg = set_active_memcg(memcg);
> +       for (i = 0; i < cnt; i++) {
> +               obj = __alloc(c, node);
> +               if (!obj)
> +                       break;
> +               if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       /* In RT irq_work runs in per-cpu kthread, so we have
> +                        * to disable interrupts to avoid race with
> +                        * bpf_mem_alloc/free. Note the read of free_cnt in
> +                        * bpf_mem_refill is racy in RT. It's ok to do.
> +                        */
> +                       local_irq_save(flags);
> +               __llist_add(obj, &c->free_llist);
> +               c->free_cnt++;
> +               if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       local_irq_restore(flags);
> +       }
> +       set_active_memcg(old_memcg);
> +       mem_cgroup_put(memcg);
> +}
> +
> +/* Refill NMI specific llist. Mostly runs from irq_work except __init phase. */
> +static void alloc_bulk_nmi(struct bpf_mem_cache *c, int cnt, int node)
> +{
> +       struct mem_cgroup *memcg = NULL, *old_memcg;
> +       void *obj;
> +       int i;
> +
> +       memcg = get_memcg(c);
> +       old_memcg = set_active_memcg(memcg);
> +       for (i = 0; i < cnt; i++) {
> +               obj = __alloc(c, node);
> +               if (!obj)
> +                       break;
> +               llist_add(obj, &c->free_llist_nmi);
> +               atomic_inc(&c->free_cnt_nmi);
> +       }
> +       set_active_memcg(old_memcg);
> +       mem_cgroup_put(memcg);
> +}
> +
> +static void free_one(struct bpf_mem_cache *c, void *obj)
> +{
> +       if (c->kmem_cache)
> +               kmem_cache_free(c->kmem_cache, obj);
> +       else
> +               kfree(obj);
> +}
> +
> +static void free_bulk(struct bpf_mem_cache *c)
> +{
> +       struct llist_node *llnode;
> +       unsigned long flags;
> +       int cnt;
> +
> +       do {
> +               if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       local_irq_save(flags);
> +               llnode = __llist_del_first(&c->free_llist);
> +               if (llnode)
> +                       cnt = --c->free_cnt;
> +               else
> +                       cnt = 0;
> +               if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       local_irq_restore(flags);
> +               free_one(c, llnode);
> +       } while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
> +}
> +
> +static void free_bulk_nmi(struct bpf_mem_cache *c)
> +{
> +       struct llist_node *llnode;
> +       int cnt;
> +
> +       do {
> +               llnode = llist_del_first(&c->free_llist_nmi);
> +               if (llnode)
> +                       cnt = atomic_dec_return(&c->free_cnt_nmi);
> +               else
> +                       cnt = 0;
> +               free_one(c, llnode);
> +       } while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
> +}
> +
> +static void bpf_mem_refill(struct irq_work *work)
> +{
> +       struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
> +       int cnt;
> +
> +       cnt = c->free_cnt;
> +       if (cnt < LOW_WATERMARK)
> +               /* irq_work runs on this cpu and kmalloc will allocate
> +                * from the current numa node which is what we want here.
> +                */
> +               alloc_bulk(c, BATCH, NUMA_NO_NODE);
> +       else if (cnt > HIGH_WATERMARK)
> +               free_bulk(c);
> +
> +       if (!c->refill_nmi_list)
> +               /* don't refill NMI specific freelist
> +                * until alloc/free from NMI.
> +                */
> +               return;
> +       cnt = atomic_read(&c->free_cnt_nmi);
> +       if (cnt < LOW_WATERMARK)
> +               alloc_bulk_nmi(c, BATCH, NUMA_NO_NODE);
> +       else if (cnt > HIGH_WATERMARK)
> +               free_bulk_nmi(c);
> +       c->refill_nmi_list = false;
> +}
> +
> +static void notrace irq_work_raise(struct bpf_mem_cache *c, bool in_nmi)
> +{
> +       if (in_nmi)
> +               /* Raise the flag only if in_nmi. Cannot assign it
> +                * unconditionally since subsequent non-nmi irq_work_raise
> +                * might clear it.
> +                */
> +               c->refill_nmi_list = in_nmi;
> +       irq_work_queue(&c->refill_work);
> +}
> +
> +static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
> +{
> +       init_irq_work(&c->refill_work, bpf_mem_refill);
> +       /* To avoid consuming memory assume that 1st run of bpf
> +        * prog won't be doing more than 4 map_update_elem from
> +        * irq disabled region
> +        */
> +       alloc_bulk(c, c->unit_size < 256 ? 4 : 1, cpu_to_node(cpu));
> +
> +       /* NMI progs are rare. Assume they have one map_update
> +        * per prog at the very beginning.
> +        */
> +       alloc_bulk_nmi(c, 1, cpu_to_node(cpu));
> +}
> +
> +/* When size != 0 create kmem_cache and bpf_mem_cache for each cpu.
> + * This is typical bpf hash map use case when all elements have equal size.
> + *
> + * When size == 0 allocate 11 bpf_mem_cache-s for each cpu, then rely on
> + * kmalloc/kfree. Max allocation size is 4096 in this case.
> + * This is bpf_dynptr and bpf_kptr use case.
> + */
> +int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
> +{
> +       static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
> +       struct bpf_mem_caches *cc, __percpu *pcc;
> +       struct bpf_mem_cache *c, __percpu *pc;
> +       struct kmem_cache *kmem_cache;
> +       struct obj_cgroup *objcg = NULL;
> +       char buf[32];
> +       int cpu, i;
> +
> +       if (size) {
> +               pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
> +               if (!pc)
> +                       return -ENOMEM;
> +               size += LLIST_NODE_SZ; /* room for llist_node */
> +               snprintf(buf, sizeof(buf), "bpf-%u", size);
> +               kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
> +               if (!kmem_cache) {
> +                       free_percpu(pc);
> +                       return -ENOMEM;
> +               }
> +#ifdef CONFIG_MEMCG_KMEM
> +               objcg = get_obj_cgroup_from_current();
> +#endif
> +               for_each_possible_cpu(cpu) {
> +                       c = per_cpu_ptr(pc, cpu);
> +                       c->kmem_cache = kmem_cache;
> +                       c->unit_size = size;
> +                       c->objcg = objcg;
> +                       prefill_mem_cache(c, cpu);
> +               }
> +               ma->cache = pc;
> +               return 0;
> +       }
> +
> +       pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
> +       if (!pcc)
> +               return -ENOMEM;
> +#ifdef CONFIG_MEMCG_KMEM
> +       objcg = get_obj_cgroup_from_current();
> +#endif
> +       for_each_possible_cpu(cpu) {
> +               cc = per_cpu_ptr(pcc, cpu);
> +               for (i = 0; i < NUM_CACHES; i++) {
> +                       c = &cc->cache[i];
> +                       c->unit_size = sizes[i];
> +                       c->objcg = objcg;
> +                       prefill_mem_cache(c, cpu);
> +               }
> +       }
> +       ma->caches = pcc;
> +       return 0;
> +}
> +
> +static void drain_mem_cache(struct bpf_mem_cache *c)
> +{
> +       struct llist_node *llnode;
> +
> +       while ((llnode = llist_del_first(&c->free_llist_nmi)))
> +               free_one(c, llnode);
> +       while ((llnode = __llist_del_first(&c->free_llist)))
> +               free_one(c, llnode);
> +}
> +
> +void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
> +{
> +       struct bpf_mem_caches *cc;
> +       struct bpf_mem_cache *c;
> +       int cpu, i;
> +
> +       if (ma->cache) {
> +               for_each_possible_cpu(cpu) {
> +                       c = per_cpu_ptr(ma->cache, cpu);
> +                       drain_mem_cache(c);
> +               }
> +               /* kmem_cache and memcg are the same across cpus */
> +               kmem_cache_destroy(c->kmem_cache);
> +               if (c->objcg)
> +                       obj_cgroup_put(c->objcg);
> +               free_percpu(ma->cache);
> +               ma->cache = NULL;
> +       }
> +       if (ma->caches) {
> +               for_each_possible_cpu(cpu) {
> +                       cc = per_cpu_ptr(ma->caches, cpu);
> +                       for (i = 0; i < NUM_CACHES; i++) {
> +                               c = &cc->cache[i];
> +                               drain_mem_cache(c);
> +                       }
> +               }
> +               if (c->objcg)
> +                       obj_cgroup_put(c->objcg);
> +               free_percpu(ma->caches);
> +               ma->caches = NULL;
> +       }
> +}
> +
> +/* notrace is necessary here and in other functions to make sure
> + * bpf programs cannot attach to them and cause llist corruptions.
> + */
> +static void notrace *unit_alloc(struct bpf_mem_cache *c)
> +{
> +       bool in_nmi = bpf_in_nmi();
> +       struct llist_node *llnode;
> +       unsigned long flags;
> +       int cnt = 0;
> +
> +       if (unlikely(in_nmi)) {
> +               llnode = llist_del_first(&c->free_llist_nmi);
> +               if (llnode)
> +                       cnt = atomic_dec_return(&c->free_cnt_nmi);

I am trying to understand which case this
atomic_dec_return/atomic_inc_return protects against in the
unit_alloc/unit_free for in_nmi branch. Is it protecting nested NMI
BPF prog interrupting NMI prog?

In case of perf it seems we use bpf_prog_active, so nested NMI prog
won't be invoked while we are interrupted inside a BPF program in NMI
context. Which are the other cases that might cause reentrancy in this
branch such that we need atomics instead of c->free_cnt_nmi--? Or are
you anticipating you might allow this in the future even if it is
disallowed for now?

If programs are allowed to stack like this, and we try to reason about
the safety of llist_del_first operation, the code is:

struct llist_node *llist_del_first(struct llist_head *head)
{
     struct llist_node *entry, *old_entry, *next;

     entry = smp_load_acquire(&head->first);
     for (;;) {
         if (entry == NULL)
             return NULL;
         old_entry = entry;
         next = READ_ONCE(entry->next);
>>>>>>>> Suppose nested NMI comes at this point and BPF prog is invoked.
         entry = cmpxchg(&head->first, old_entry, next);
         if (entry == old_entry)
             break;
     }
     return entry;
}

Assume the current nmi free llist is HEAD -> A -> B -> C -> D -> ...
For our cmpxchg, parameters are going to be cmpxchg(&head->first, A, B);

Now, nested NMI prog does unit_alloc thrice. this does llist_del_first thrice
This makes nmi free llist HEAD -> D -> ...
A, B, C are allocated in prog.
Now it does unit_free of all three, but in order of B, C, A.
unit_free does llist_add, nmi free llist becomes HEAD -> A -> C -> B -> D -> ...

Nested NMI prog exits.
We continue with our cmpxchg(&head->first, A, B); It succeeds, A is
returned, but C will be leaked.

> +       } else {
> +               /* Disable irqs to prevent the following race:
> +                * bpf_prog_A
> +                *   bpf_mem_alloc
> +                *      preemption or irq -> bpf_prog_B
> +                *        bpf_mem_alloc
> +                */
> +               local_irq_save(flags);
> +               llnode = __llist_del_first(&c->free_llist);
> +               if (llnode)
> +                       cnt = --c->free_cnt;
> +               local_irq_restore(flags);
> +       }
> +       WARN_ON(cnt < 0);
> +
> +       if (cnt < LOW_WATERMARK)
> +               irq_work_raise(c, in_nmi);
> +       return llnode;
> +}
> +
> +/* Though 'ptr' object could have been allocated on a different cpu
> + * add it to the free_llist of the current cpu.
> + * Let kfree() logic deal with it when it's later called from irq_work.
> + */
> +static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
> +{
> +       struct llist_node *llnode = ptr - LLIST_NODE_SZ;
> +       bool in_nmi = bpf_in_nmi();
> +       unsigned long flags;
> +       int cnt;
> +
> +       BUILD_BUG_ON(LLIST_NODE_SZ > 8);
> +
> +       if (unlikely(in_nmi)) {
> +               llist_add(llnode, &c->free_llist_nmi);
> +               cnt = atomic_inc_return(&c->free_cnt_nmi);
> +       } else {
> +               local_irq_save(flags);
> +               __llist_add(llnode, &c->free_llist);
> +               cnt = ++c->free_cnt;
> +               local_irq_restore(flags);
> +       }
> +       WARN_ON(cnt <= 0);
> +
> +       if (cnt > HIGH_WATERMARK)
> +               /* free few objects from current cpu into global kmalloc pool */
> +               irq_work_raise(c, in_nmi);
> +}
> +
> +/* Called from BPF program or from sys_bpf syscall.
> + * In both cases migration is disabled.
> + */
> +void notrace *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size)
> +{
> +       int idx;
> +       void *ret;
> +
> +       if (!size)
> +               return ZERO_SIZE_PTR;
> +
> +       idx = bpf_mem_cache_idx(size + LLIST_NODE_SZ);
> +       if (idx < 0)
> +               return NULL;
> +
> +       ret = unit_alloc(this_cpu_ptr(ma->caches)->cache + idx);
> +       return !ret ? NULL : ret + LLIST_NODE_SZ;
> +}
> +
> +void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
> +{
> +       int idx;
> +
> +       if (!ptr)
> +               return;
> +
> +       idx = bpf_mem_cache_idx(__ksize(ptr - LLIST_NODE_SZ));
> +       if (idx < 0)
> +               return;
> +
> +       unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
> +}
> +
> +void notrace *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma)
> +{
> +       void *ret;
> +
> +       ret = unit_alloc(this_cpu_ptr(ma->cache));
> +       return !ret ? NULL : ret + LLIST_NODE_SZ;
> +}
> +
> +void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
> +{
> +       if (!ptr)
> +               return;
> +
> +       unit_free(this_cpu_ptr(ma->cache), ptr);
> +}
> --
> 2.30.2
>
