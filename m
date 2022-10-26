Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8A760DAC8
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiJZF4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 01:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiJZF4h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 01:56:37 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7153B92588
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 22:56:36 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b79so12497034iof.5
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 22:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZQZ17ckLj/61+68masRoNZ+U51AdX6lGsh5Vvhw4YA=;
        b=F3T2CCMNkJ7NhfN3QxFjGBDY56+zrS8HgsDL3zcutdHGyWagAfAKS/ntxBlJdW747j
         FyJQmpDKObT4QQau+fr6slstjS6Dy7dthPbPRBNokeMRxPaSTGuGMIM8qq8yEgSoyP42
         F98lzqU5toF/h0RYv/h/ZwPExV8XLsUiPc/KRyeprwdyKTshPOZeK0x8LesmzAqB4uR/
         SVdjhEE2eH+uWfaTy6J2Y438QY6jY0VuO3KaAcDfX24aGyGMhdLVrvQwOjWkWOxOwb0w
         lsLTpLFXaY1JGKBgHI5Hc+UXxoXwSa5Uqzi2Ml43RW9BX8/gtk/CxAAi7MoFquSG1jvD
         hH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZQZ17ckLj/61+68masRoNZ+U51AdX6lGsh5Vvhw4YA=;
        b=u4Of/ZYBGc0S42la6fnq5IHCcuBxEl3VeUrHedrMBlWNFfnLKsRj48xzCtOomuzuE0
         lPFhBFJN3xr86yJGAqEZ8BcB4rcCgcZkyYS/AKnr697lPRAMklcasaK7uTzyca81+nT4
         f+j1vTOdHAv/Q9cRi7WW3zaRY19D1KWJA0IU7s3t10QjIgkur9i3mRHkRvIJRaD3bK1S
         14Xnr1R+mWd8c49rk/WGncW17Pphplz5U8D6Cx4AtKBxfg00d3PG0f7fRGSlBVnrmfzs
         bsJncbnrg5cY6nqY1h1wbT1FymTarydrCGevul306du1F7X6KoIGBrrZ/hejNXA8O7dF
         nOHw==
X-Gm-Message-State: ACrzQf357FEwlmREcxyhZPOv9NdWjtFuE4wkscctL4uNTgzZRW8HGAvV
        hLgEdVGBBHUdcroyCcyqKgtgDffw2s0XssXkf+ML1M2Koi4=
X-Google-Smtp-Source: AMsMyM48k/m8bXqrPKt7qYb+nwNRy+JRaDDxFXmJEB3mQ2XRW0lCh2bnvclHVL2t9AbRg9NmJXxZNbQ2EmfsCMSlcvo=
X-Received: by 2002:a6b:c308:0:b0:6bc:8a23:c7aa with SMTP id
 t8-20020a6bc308000000b006bc8a23c7aamr24554940iof.0.1666763795376; Tue, 25 Oct
 2022 22:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221025215352.4184578-1-yhs@fb.com> <20221025215408.4185261-1-yhs@fb.com>
 <CAJD7tkZCrmnof7Lq3YhFDAfdKXodhK=6_8kD1Utt-xPX_jJ7TQ@mail.gmail.com> <c2f1a054-dd0e-1150-d1c1-d3a6b10c9c40@meta.com>
In-Reply-To: <c2f1a054-dd0e-1150-d1c1-d3a6b10c9c40@meta.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Oct 2022 22:55:59 -0700
Message-ID: <CAJD7tkbcqWQpmu2OZqHugmN4WPuhbdm6vDZDGwyS2EamaAQdXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
To:     Yonghong Song <yhs@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 25, 2022 at 9:11 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 10/25/22 3:29 PM, Yosry Ahmed wrote:
> > On Tue, Oct 25, 2022 at 2:54 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Similar to sk/inode/task storage, implement similar cgroup local storage.
> >>
> >> There already exists a local storage implementation for cgroup-attached
> >> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
> >> bpf_get_local_storage(). But there are use cases such that non-cgroup
> >> attached bpf progs wants to access cgroup local storage data. For example,
> >> tc egress prog has access to sk and cgroup. It is possible to use
> >> sk local storage to emulate cgroup local storage by storing data in socket.
> >> But this is a waste as it could be lots of sockets belonging to a particular
> >> cgroup. Alternatively, a separate map can be created with cgroup id as the key.
> >> But this will introduce additional overhead to manipulate the new map.
> >> A cgroup local storage, similar to existing sk/inode/task storage,
> >> should help for this use case.
> >>
> >> The life-cycle of storage is managed with the life-cycle of the
> >> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
> >> with a call to bpf_cgrp_storage_free() when cgroup itself
> >> is deleted.
> >>
> >> The userspace map operations can be done by using a cgroup fd as a key
> >> passed to the lookup, update and delete operations.
> >>
> >> Typically, the following code is used to get the current cgroup:
> >>      struct task_struct *task = bpf_get_current_task_btf();
> >>      ... task->cgroups->dfl_cgrp ...
> >> and in structure task_struct definition:
> >>      struct task_struct {
> >>          ....
> >>          struct css_set __rcu            *cgroups;
> >>          ....
> >>      }
> >> With sleepable program, accessing task->cgroups is not protected by rcu_read_lock.
> >> So the current implementation only supports non-sleepable program and supporting
> >> sleepable program will be the next step together with adding rcu_read_lock
> >> protection for rcu tagged structures.
> >>
> >> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup local
> >> storage support, the new map name BPF_MAP_TYPE_CGRP_STORAGE is used
> >> for cgroup storage available to non-cgroup-attached bpf programs. The old
> >> cgroup storage supports bpf_get_local_storage() helper to get the cgroup data.
> >> The new cgroup storage helper bpf_cgrp_storage_get() can provide similar
> >> functionality. While old cgroup storage pre-allocates storage memory, the new
> >> mechanism can also pre-allocate with a user space bpf_map_update_elem() call
> >> to avoid potential run-time memory allocation failure.
> >> Therefore, the new cgroup storage can provide all functionality w.r.t.
> >> the old one. So in uapi bpf.h, the old BPF_MAP_TYPE_CGROUP_STORAGE is alias to
> >> BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED to indicate the old cgroup storage can
> >> be deprecated since the new one can provide the same functionality.
> >>
> >> Acked-by: David Vernet <void@manifault.com>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   include/linux/bpf.h            |   7 +
> >>   include/linux/bpf_types.h      |   1 +
> >>   include/linux/cgroup-defs.h    |   4 +
> >>   include/uapi/linux/bpf.h       |  50 ++++++-
> >>   kernel/bpf/Makefile            |   2 +-
> >>   kernel/bpf/bpf_cgrp_storage.c  | 247 +++++++++++++++++++++++++++++++++
> >>   kernel/bpf/helpers.c           |   6 +
> >>   kernel/bpf/syscall.c           |   3 +-
> >>   kernel/bpf/verifier.c          |  13 +-
> >>   kernel/cgroup/cgroup.c         |   1 +
> >>   kernel/trace/bpf_trace.c       |   4 +
> >>   scripts/bpf_doc.py             |   2 +
> >>   tools/include/uapi/linux/bpf.h |  50 ++++++-
> >>   13 files changed, 385 insertions(+), 5 deletions(-)
> >>   create mode 100644 kernel/bpf/bpf_cgrp_storage.c
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 9e7d46d16032..0fa3b4f6e777 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -2045,6 +2045,7 @@ struct bpf_link *bpf_link_by_id(u32 id);
> >>
> >>   const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
> >>   void bpf_task_storage_free(struct task_struct *task);
> >> +void bpf_cgrp_storage_free(struct cgroup *cgroup);
> >>   bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
> >>   const struct btf_func_model *
> >>   bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
> >> @@ -2299,6 +2300,10 @@ static inline bool has_current_bpf_ctx(void)
> >>   static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
> >>   {
> >>   }
> >> +
> >> +static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
> >> +{
> >> +}
> >>   #endif /* CONFIG_BPF_SYSCALL */
> >>
> >>   void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
> >> @@ -2537,6 +2542,8 @@ extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
> >>   extern const struct bpf_func_proto bpf_set_retval_proto;
> >>   extern const struct bpf_func_proto bpf_get_retval_proto;
> >>   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
> >> +extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
> >> +extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
> >>
> >>   const struct bpf_func_proto *tracing_prog_func_proto(
> >>     enum bpf_func_id func_id, const struct bpf_prog *prog);
> >> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> >> index 2c6a4f2562a7..d4ee3ccd3753 100644
> >> --- a/include/linux/bpf_types.h
> >> +++ b/include/linux/bpf_types.h
> >> @@ -86,6 +86,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_PROG_ARRAY, prog_array_map_ops)
> >>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERF_EVENT_ARRAY, perf_event_array_map_ops)
> >>   #ifdef CONFIG_CGROUPS
> >>   BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
> >> +BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops)
> >>   #endif
> >>   #ifdef CONFIG_CGROUP_BPF
> >>   BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
> >> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> >> index 8f481d1b159a..c466fdc3a32a 100644
> >> --- a/include/linux/cgroup-defs.h
> >> +++ b/include/linux/cgroup-defs.h
> >> @@ -504,6 +504,10 @@ struct cgroup {
> >>          /* Used to store internal freezer state */
> >>          struct cgroup_freezer_state freezer;
> >>
> >> +#ifdef CONFIG_BPF_SYSCALL
> >> +       struct bpf_local_storage __rcu  *bpf_cgrp_storage;
> >> +#endif
> >> +
> >>          /* All ancestors including self */
> >>          struct cgroup *ancestors[];
> >>   };
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 17f61338f8f8..94659f6b3395 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -922,7 +922,14 @@ enum bpf_map_type {
> >>          BPF_MAP_TYPE_CPUMAP,
> >>          BPF_MAP_TYPE_XSKMAP,
> >>          BPF_MAP_TYPE_SOCKHASH,
> >> -       BPF_MAP_TYPE_CGROUP_STORAGE,
> >> +       BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
> >> +       /* BPF_MAP_TYPE_CGROUP_STORAGE is available to bpf programs attaching
> >> +        * to a cgroup. The newer BPF_MAP_TYPE_CGRP_STORAGE is available to
> >> +        * both cgroup-attached and other progs and supports all functionality
> >> +        * provided by BPF_MAP_TYPE_CGROUP_STORAGE. So mark
> >> +        * BPF_MAP_TYPE_CGROUP_STORAGE deprecated.
> >> +        */
> >> +       BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
> >>          BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> >>          BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> >>          BPF_MAP_TYPE_QUEUE,
> >> @@ -935,6 +942,7 @@ enum bpf_map_type {
> >>          BPF_MAP_TYPE_TASK_STORAGE,
> >>          BPF_MAP_TYPE_BLOOM_FILTER,
> >>          BPF_MAP_TYPE_USER_RINGBUF,
> >> +       BPF_MAP_TYPE_CGRP_STORAGE,
> >>   };
> >>
> >>   /* Note that tracing related programs such as
> >> @@ -5435,6 +5443,44 @@ union bpf_attr {
> >>    *             **-E2BIG** if user-space has tried to publish a sample which is
> >>    *             larger than the size of the ring buffer, or which cannot fit
> >>    *             within a struct bpf_dynptr.
> >> + *
> >> + * void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)
> >> + *     Description
> >> + *             Get a bpf_local_storage from the *cgroup*.
> >> + *
> >> + *             Logically, it could be thought of as getting the value from
> >> + *             a *map* with *cgroup* as the **key**.  From this
> >> + *             perspective,  the usage is not much different from
> >> + *             **bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
> >> + *             helper enforces the key must be a cgroup struct and the map must also
> >> + *             be a **BPF_MAP_TYPE_CGRP_STORAGE**.
> >> + *
> >> + *             In reality, the local-storage value is embedded directly inside of the
> >> + *             *cgroup* object itself, rather than being located in the
> >> + *             **BPF_MAP_TYPE_CGRP_STORAGE** map. When the local-storage value is
> >> + *             queried for some *map* on a *cgroup* object, the kernel will perform an
> >> + *             O(n) iteration over all of the live local-storage values for that
> >> + *             *cgroup* object until the local-storage value for the *map* is found.
> >> + *
> >> + *             An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
> >> + *             used such that a new bpf_local_storage will be
> >> + *             created if one does not exist.  *value* can be used
> >> + *             together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
> >> + *             the initial value of a bpf_local_storage.  If *value* is
> >> + *             **NULL**, the new bpf_local_storage will be zero initialized.
> >> + *     Return
> >> + *             A bpf_local_storage pointer is returned on success.
> >> + *
> >> + *             **NULL** if not found or there was an error in adding
> >> + *             a new bpf_local_storage.
> >> + *
> >> + * long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgroup *cgroup)
> >> + *     Description
> >> + *             Delete a bpf_local_storage from a *cgroup*.
> >> + *     Return
> >> + *             0 on success.
> >> + *
> >> + *             **-ENOENT** if the bpf_local_storage cannot be found.
> >>    */
> >>   #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
> >>          FN(unspec, 0, ##ctx)                            \
> >> @@ -5647,6 +5693,8 @@ union bpf_attr {
> >>          FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)    \
> >>          FN(ktime_get_tai_ns, 208, ##ctx)                \
> >>          FN(user_ringbuf_drain, 209, ##ctx)              \
> >> +       FN(cgrp_storage_get, 210, ##ctx)                \
> >> +       FN(cgrp_storage_delete, 211, ##ctx)             \
> >>          /* */
> >>
> >>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> >> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> >> index 341c94f208f4..3a12e6b400a2 100644
> >> --- a/kernel/bpf/Makefile
> >> +++ b/kernel/bpf/Makefile
> >> @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
> >>   obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
> >>   endif
> >>   ifeq ($(CONFIG_CGROUPS),y)
> >> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
> >> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgrp_storage.o
> >>   endif
> >>   obj-$(CONFIG_CGROUP_BPF) += cgroup.o
> >>   ifeq ($(CONFIG_INET),y)
> >> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> >> new file mode 100644
> >> index 000000000000..309403800f82
> >> --- /dev/null
> >> +++ b/kernel/bpf/bpf_cgrp_storage.c
> >> @@ -0,0 +1,247 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
> >> + */
> >> +
> >> +#include <linux/types.h>
> >> +#include <linux/bpf.h>
> >> +#include <linux/bpf_local_storage.h>
> >> +#include <uapi/linux/btf.h>
> >> +#include <linux/btf_ids.h>
> >> +
> >> +DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
> >> +
> >> +static DEFINE_PER_CPU(int, bpf_cgrp_storage_busy);
> >> +
> >> +static void bpf_cgrp_storage_lock(void)
> >> +{
> >> +       migrate_disable();
> >> +       this_cpu_inc(bpf_cgrp_storage_busy);
> >> +}
> >> +
> >> +static void bpf_cgrp_storage_unlock(void)
> >> +{
> >> +       this_cpu_dec(bpf_cgrp_storage_busy);
> >> +       migrate_enable();
> >> +}
> >> +
> >> +static bool bpf_cgrp_storage_trylock(void)
> >> +{
> >> +       migrate_disable();
> >> +       if (unlikely(this_cpu_inc_return(bpf_cgrp_storage_busy) != 1)) {
> >> +               this_cpu_dec(bpf_cgrp_storage_busy);
> >> +               migrate_enable();
> >> +               return false;
> >> +       }
> >> +       return true;
> >> +}
> >> +
> >> +static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
> >> +{
> >> +       struct cgroup *cg = owner;
> >> +
> >> +       return &cg->bpf_cgrp_storage;
> >> +}
> >> +
> >> +void bpf_cgrp_storage_free(struct cgroup *cgroup)
> >> +{
> >> +       struct bpf_local_storage *local_storage;
> >> +       bool free_cgroup_storage = false;
> >> +       unsigned long flags;
> >> +
> >> +       rcu_read_lock();
> >> +       local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
> >> +       if (!local_storage) {
> >> +               rcu_read_unlock();
> >> +               return;
> >> +       }
> >> +
> >> +       bpf_cgrp_storage_lock();
> >> +       raw_spin_lock_irqsave(&local_storage->lock, flags);
> >> +       free_cgroup_storage = bpf_local_storage_unlink_nolock(local_storage);
> >> +       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> >> +       bpf_cgrp_storage_unlock();
> >> +       rcu_read_unlock();
> >> +
> >> +       if (free_cgroup_storage)
> >> +               kfree_rcu(local_storage, rcu);
> >> +}
> >> +
> >> +static struct bpf_local_storage_data *
> >> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
> >> +{
> >> +       struct bpf_local_storage *cgroup_storage;
> >> +       struct bpf_local_storage_map *smap;
> >> +
> >> +       cgroup_storage = rcu_dereference_check(cgroup->bpf_cgrp_storage,
> >> +                                              bpf_rcu_lock_held());
> >> +       if (!cgroup_storage)
> >> +               return NULL;
> >> +
> >> +       smap = (struct bpf_local_storage_map *)map;
> >> +       return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
> >> +}
> >> +
> >> +static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
> >> +{
> >> +       struct bpf_local_storage_data *sdata;
> >> +       struct cgroup *cgroup;
> >> +       int fd;
> >> +
> >> +       fd = *(int *)key;
> >> +       cgroup = cgroup_get_from_fd(fd);
> >
> > Sorry I didn't notice this before, but is there a reason why only
> > cgroup v2 is supported here?
> >
> > Can we also support cgroup v1 by using cgroup_v1v2_get_from_fd()
> > instead, similar to cgroup_iter? or is there something else in the
> > implementation that is cgroup v2 specific?
>
> I can do that but cgroup_v1v2_get_from_fd() is not in bpf-next now.
> I guess we can either wait for it if it can be merged into bpf-next
> soon or we can do it as a followup.

It's in Linus's tree, I honestly don't know how often Linus's tree
gets merged into bpf-next.

>
> >
> >> +       if (IS_ERR(cgroup))
> >> +               return ERR_CAST(cgroup);
> >> +
> >> +       bpf_cgrp_storage_lock();
> >> +       sdata = cgroup_storage_lookup(cgroup, map, true);
> >> +       bpf_cgrp_storage_unlock();
> >> +       cgroup_put(cgroup);
> >> +       return sdata ? sdata->data : NULL;
> >> +}
> >> +
