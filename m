Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DDD601932
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiJQURC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 16:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiJQUQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 16:16:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60468209AC
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 13:15:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n73so10054582iod.13
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2KvbZrebwACxEmSdD2+pCOZd19lnejaaVK+e6SUhvVs=;
        b=JIWuZzSAOjfv5P1IidfqH3nml1wa9yYn5g5ibwhuGbmGI+S9NYhmjc2e244hvs3eTy
         7mUsDKGHkZwsM3VSeijQzMGihVLGgUPomWoAHbkCR54cV/CPqFdEL5wBjuTrdqSFAtNS
         BDvqx9LXQHa8HQ+Q/XrXI4bzw2JxwD9p6MyoxnVPNVN5WjOtBmpM4SI+gJrHJ6dnKvfb
         7xqby/ve8FYKYEJoRmQvLKc2ISi5lqvS6qSuIRfv1i4W3tCrIQ4VsXd1rHgJ7C2D7SKc
         n5KNxAwb7wLK3ZIvJ7gAudW1rtyW6tN7WFSIWxonI59Kx1STObDzCqbJ63TPtjJ6Kn1z
         Kk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KvbZrebwACxEmSdD2+pCOZd19lnejaaVK+e6SUhvVs=;
        b=L6CMYgGPaCQhcStj39rkoZ8cSrY9LR7hbxpM9g7a1AkeQ9Y93qEINbv2n6tJxN5O5y
         035ukagdNiIkcBJW1VTm2PrMLu9NZqJ3OlhMDRoPzmBL3QRqY96gmLEPY3w2xiUq5e50
         eS/1r+i0so65NbUJ2Rfrr5CIWiDU3p+kMOV5nlJEVgGV0H2lVUPc8so1BCmuUV3TSZmb
         3ac0be2eI2IftSYbQBj2RXXPdBODsIwEruKXJ/Th8WnLrlAyFrzxvVyrbdlqt0hO0/Ks
         jpSiKF+D09NfnG0nTAQ8RTn7uPaFqKDKnQA2eTiGl3cK6focNuvhDBdE6MejnNlrKnZP
         kZoQ==
X-Gm-Message-State: ACrzQf2x/lwKSjCVix5Xy5WiYXXCQJ+FVxXJ0bZXlGkngefCmfPTWTNE
        LuieZF29Emi3DvF9AaCLgjbdm1zoYNi/BKfw5Jbho6Qt9NE=
X-Google-Smtp-Source: AMsMyM4zMYI6JcoPY9aLHei1uPGBRhyvnYNsRjxij0809ffqeb/5SsJe/CSYGt24rp6qVH+RSAaLFhYALmCsarMzdGY=
X-Received: by 2002:a05:6638:d93:b0:364:5a1:f48f with SMTP id
 l19-20020a0566380d9300b0036405a1f48fmr6637923jaj.149.1666037729639; Mon, 17
 Oct 2022 13:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221014045619.3309899-1-yhs@fb.com> <20221014045630.3311951-1-yhs@fb.com>
 <Y02Yk8gUgVDuZR4Q@google.com> <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <09abf562-ac9a-f702-aec1-7e4eb9343882@meta.com>
In-Reply-To: <09abf562-ac9a-f702-aec1-7e4eb9343882@meta.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Oct 2022 13:14:53 -0700
Message-ID: <CAJD7tka=j7NcOf+oekEF3gN7vg8h=15qG6WrHbiGjpX0rJNN_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
To:     Yonghong Song <yhs@meta.com>
Cc:     sdf@google.com, Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
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

On Mon, Oct 17, 2022 at 1:10 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 10/17/22 11:25 AM, Yosry Ahmed wrote:
> > On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
> >>
> >> On 10/13, Yonghong Song wrote:
> >>> Similar to sk/inode/task storage, implement similar cgroup local storage.
> >>
> >>> There already exists a local storage implementation for cgroup-attached
> >>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
> >>> bpf_get_local_storage(). But there are use cases such that non-cgroup
> >>> attached bpf progs wants to access cgroup local storage data. For example,
> >>> tc egress prog has access to sk and cgroup. It is possible to use
> >>> sk local storage to emulate cgroup local storage by storing data in
> >>> socket.
> >>> But this is a waste as it could be lots of sockets belonging to a
> >>> particular
> >>> cgroup. Alternatively, a separate map can be created with cgroup id as
> >>> the key.
> >>> But this will introduce additional overhead to manipulate the new map.
> >>> A cgroup local storage, similar to existing sk/inode/task storage,
> >>> should help for this use case.
> >>
> >>> The life-cycle of storage is managed with the life-cycle of the
> >>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
> >>> with a callback to the bpf_cgroup_storage_free when cgroup itself
> >>> is deleted.
> >>
> >>> The userspace map operations can be done by using a cgroup fd as a key
> >>> passed to the lookup, update and delete operations.
> >>
> >>
> >> [..]
> >>
> >>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup
> >>> local
> >>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
> >>> used
> >>> for cgroup storage available to non-cgroup-attached bpf programs. The two
> >>> helpers are named as bpf_cgroup_local_storage_get() and
> >>> bpf_cgroup_local_storage_delete().
> >>
> >> Have you considered doing something similar to 7d9c3427894f ("bpf: Make
> >> cgroup storages shared between programs on the same cgroup") where
> >> the map changes its behavior depending on the key size (see key_size checks
> >> in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd still
> >> can be used so we can, in theory, reuse the name..
> >>
> >> Pros:
> >> - no need for a new map name
> >>
> >> Cons:
> >> - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; might be not a
> >>     good idea to add more stuff to it?
> >>
> >> But, for the very least, should we also extend
> >> Documentation/bpf/map_cgroup_storage.rst to cover the new map? We've
> >> tried to keep some of the important details in there..
> >
> > This might be a long shot, but is it possible to switch completely to
> > this new generic cgroup storage, and for programs that attach to
> > cgroups we can still do lookups/allocations during attachment like we
> > do today? IOW, maintain the current API for cgroup progs but switch it
> > to use this new map type instead.
>
> Right, cgroup attach/detach should not be impacted by this patch.
>
> >
> > It feels like this map type is more generic and can be a superset of
> > the existing cgroup storage, but I feel like I am missing something.
>
> One difference is old way cgroup local storage allocates the memory
> at map creation time, and the new way allocates the memory at runtime
> when get/update helper is called.
>

IIUC the old cgroup local storage allocates memory when a program is
attached. We can have the same behavior with the new map type, right?
When a program is attached to a cgroup, allocate the memory, otherwise
it is allocated at run time. Does this make sense?

> >
> >>
> >>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>> ---
> >>>    include/linux/bpf.h             |   3 +
> >>>    include/linux/bpf_types.h       |   1 +
> >>>    include/linux/cgroup-defs.h     |   4 +
> >>>    include/uapi/linux/bpf.h        |  39 +++++
> >>>    kernel/bpf/Makefile             |   2 +-
> >>>    kernel/bpf/bpf_cgroup_storage.c | 280 ++++++++++++++++++++++++++++++++
> >>>    kernel/bpf/helpers.c            |   6 +
> >>>    kernel/bpf/syscall.c            |   3 +-
> >>>    kernel/bpf/verifier.c           |  14 +-
> >>>    kernel/cgroup/cgroup.c          |   4 +
> >>>    kernel/trace/bpf_trace.c        |   4 +
> >>>    scripts/bpf_doc.py              |   2 +
> >>>    tools/include/uapi/linux/bpf.h  |  39 +++++
> >>>    13 files changed, 398 insertions(+), 3 deletions(-)
> >>>    create mode 100644 kernel/bpf/bpf_cgroup_storage.c
> >>
> [...]
> >>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> >>> index 341c94f208f4..b02693f51978 100644
> >>> --- a/kernel/bpf/Makefile
> >>> +++ b/kernel/bpf/Makefile
> >>> @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
> >>>    obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
> >>>    endif
> >>>    ifeq ($(CONFIG_CGROUPS),y)
> >>> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
> >>> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgroup_storage.o
> >>>    endif
> >>>    obj-$(CONFIG_CGROUP_BPF) += cgroup.o
> >>>    ifeq ($(CONFIG_INET),y)
> >>> diff --git a/kernel/bpf/bpf_cgroup_storage.c
> >>> b/kernel/bpf/bpf_cgroup_storage.c
> >>> new file mode 100644
> >>> index 000000000000..9974784822da
> >>> --- /dev/null
> >>> +++ b/kernel/bpf/bpf_cgroup_storage.c
> >>> @@ -0,0 +1,280 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
> >>> + */
> >>> +
> >>> +#include <linux/types.h>
> >>> +#include <linux/bpf.h>
> >>> +#include <linux/bpf_local_storage.h>
> >>> +#include <uapi/linux/btf.h>
> >>> +#include <linux/btf_ids.h>
> >>> +
> >>> +DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
> >>> +
> >>> +static DEFINE_PER_CPU(int, bpf_cgroup_storage_busy);
> >>> +
> >>> +static void bpf_cgroup_storage_lock(void)
> >>> +{
> >>> +     migrate_disable();
> >>> +     this_cpu_inc(bpf_cgroup_storage_busy);
> >>> +}
> >>> +
> >>> +static void bpf_cgroup_storage_unlock(void)
> >>> +{
> >>> +     this_cpu_dec(bpf_cgroup_storage_busy);
> >>> +     migrate_enable();
> >>> +}
> >>> +
> >>> +static bool bpf_cgroup_storage_trylock(void)
> >>> +{
> >>> +     migrate_disable();
> >>> +     if (unlikely(this_cpu_inc_return(bpf_cgroup_storage_busy) != 1)) {
> >>> +             this_cpu_dec(bpf_cgroup_storage_busy);
> >>> +             migrate_enable();
> >>> +             return false;
> >>> +     }
> >>> +     return true;
> >>> +}
> >>
> >> Task storage has lock/unlock/trylock; inode storage doesn't; why does
> >> cgroup need it as well?
>
> I think so. the new cgroup local storage might be used in fentry/fexit
> programs which could cause recursion.
>
> >>
> >>> +static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
> >>> +{
> >>> +     struct cgroup *cg = owner;
> >>> +
> >>> +     return &cg->bpf_cgroup_storage;
> >>> +}
> >>> +
> >>> +void bpf_local_cgroup_storage_free(struct cgroup *cgroup)
> >>> +{
> >>> +     struct bpf_local_storage *local_storage;
> >>> +     struct bpf_local_storage_elem *selem;
> >>> +     bool free_cgroup_storage = false;
> >>> +     struct hlist_node *n;
> >>> +     unsigned long flags;
> >>> +
> >>> +     rcu_read_lock();
> >>> +     local_storage = rcu_dereference(cgroup->bpf_cgroup_storage);
> >>> +     if (!local_storage) {
> >>> +             rcu_read_unlock();
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     /* Neither the bpf_prog nor the bpf-map's syscall
> >>> +      * could be modifying the local_storage->list now.
> >>> +      * Thus, no elem can be added-to or deleted-from the
> >>> +      * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> >>> +      *
> >>> +      * It is racing with bpf_local_storage_map_free() alone
> >>> +      * when unlinking elem from the local_storage->list and
> >>> +      * the map's bucket->list.
> >>> +      */
> >>> +     bpf_cgroup_storage_lock();
> >>> +     raw_spin_lock_irqsave(&local_storage->lock, flags);
> >>> +     hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> >>> +             bpf_selem_unlink_map(selem);
> >>> +             free_cgroup_storage =
> >>> +                     bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> >>> +     }
> >>> +     raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> >>> +     bpf_cgroup_storage_unlock();
> >>> +     rcu_read_unlock();
> >>> +
> >>> +     /* free_cgroup_storage should always be true as long as
> >>> +      * local_storage->list was non-empty.
> >>> +      */
> >>> +     if (free_cgroup_storage)
> >>> +             kfree_rcu(local_storage, rcu);
> >>> +}
> >>
> >>> +static struct bpf_local_storage_data *
> >>> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool
> >>> cacheit_lockit)
> >>> +{
> >>> +     struct bpf_local_storage *cgroup_storage;
> >>> +     struct bpf_local_storage_map *smap;
> >>> +
> >>> +     cgroup_storage = rcu_dereference_check(cgroup->bpf_cgroup_storage,
> >>> +                                            bpf_rcu_lock_held());
> >>> +     if (!cgroup_storage)
> >>> +             return NULL;
> >>> +
> >>> +     smap = (struct bpf_local_storage_map *)map;
> >>> +     return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
> >>> +}
> >>> +
> >>> +static void *bpf_cgroup_storage_lookup_elem(struct bpf_map *map, void
> >>> *key)
> >>> +{
> >>> +     struct bpf_local_storage_data *sdata;
> >>> +     struct cgroup *cgroup;
> >>> +     int fd;
> >>> +
> >>> +     fd = *(int *)key;
> >>> +     cgroup = cgroup_get_from_fd(fd);
> >>> +     if (IS_ERR(cgroup))
> >>> +             return ERR_CAST(cgroup);
> >>> +
> >>> +     bpf_cgroup_storage_lock();
> >>> +     sdata = cgroup_storage_lookup(cgroup, map, true);
> >>> +     bpf_cgroup_storage_unlock();
> >>> +     cgroup_put(cgroup);
> >>> +     return sdata ? sdata->data : NULL;
> >>> +}
> >>
> >> A lot of the above (free/lookup) seems to be copy-pasted from the task
> >> storage;
> >> any point in trying to generalize the common parts?
>
> That is true. Let me think about this.
>
> >>
> >>> +static int bpf_cgroup_storage_update_elem(struct bpf_map *map, void *key,
> >>> +                                       void *value, u64 map_flags)
> >>> +{
> >>> +     struct bpf_local_storage_data *sdata;
> >>> +     struct cgroup *cgroup;
> >>> +     int err, fd;
> >>> +
> >>> +     fd = *(int *)key;
> >>> +     cgroup = cgroup_get_from_fd(fd);
> >>> +     if (IS_ERR(cgroup))
> >>> +             return PTR_ERR(cgroup);
> >>> +
> >>> +     bpf_cgroup_storage_lock();
> >>> +     sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map
> >>> *)map,
> >>> +                                      value, map_flags, GFP_ATOMIC);
> >>> +     bpf_cgroup_storage_unlock();
> >>> +     err = PTR_ERR_OR_ZERO(sdata);
> >>> +     cgroup_put(cgroup);
> >>> +     return err;
> >>> +}
> >>> +
> [...]
> >>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> >>> index 8ad2c267ff47..2fa2c950c7fb 100644
> >>> --- a/kernel/cgroup/cgroup.c
> >>> +++ b/kernel/cgroup/cgroup.c
> >>> @@ -985,6 +985,10 @@ void put_css_set_locked(struct css_set *cset)
> >>>                put_css_set_locked(cset->dom_cset);
> >>>        }
> >>
> >>> +#ifdef CONFIG_BPF_SYSCALL
> >>> +     bpf_local_cgroup_storage_free(cset->dfl_cgrp);
> >>> +#endif
> >>> +
> >
> > I am confused about this freeing site. It seems like this path is for
> > freeing css_set's of task_structs, not for freeing the cgroup itself.
> > Wouldn't we want to free the local storage when we free the cgroup
> > itself? Somewhere like css_free_rwork_fn()? or did I completely miss
> > the point here?
>
> Thanks for suggestions here. To be honest, I am not sure whether this
> location is correct or not. I will look at css_free_rwork_fn() which
> might be a good place.
>
> >
> >>>        kfree_rcu(cset, rcu_head);
> >>>    }
> >>
> [...]
