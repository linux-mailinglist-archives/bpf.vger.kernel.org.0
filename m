Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C73260C377
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 07:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJYFrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 01:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJYFrF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 01:47:05 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389F89AE6
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 22:47:04 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e19so3649992ili.4
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 22:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gdYFGWEkEMaT/tTh+UvIr14wfRrvUpQSV16uN4kXxsA=;
        b=lTX70Ue7gtgjX3RkPu+3D6efFJmg5LAfkS+eLpBRBZWovPbLlAVfG+tWkD2hEt6FjH
         L9CzaUttpZ5gCb82H6nIRLuZJAGkvLbrxzxfjSryiD6fwl7e6+xx1o5+fCN7vD4LRcwg
         70UIF5myy4jkfw/yArh2imWO4iENl64y0eje2BWqs8JCJeMjiYcYEqqid+Nh4ZNkGzew
         5DynWBLvJWapqgaxhqb9cAS0Q66/yz/jGi96bukhU5ROwzEo2Pq1EwHIjoMwWNThOTyM
         EpA3NMoYEd99zNHoxA1qgZahwvRLezyTr+3gRN+mZYxHCLRM/bAaObqKL5qW/yw264TE
         iVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdYFGWEkEMaT/tTh+UvIr14wfRrvUpQSV16uN4kXxsA=;
        b=BCXWJifqpOMn7rVTiAb48XYlhKvPTVELiGt/CAqHmNB7dKgkTqNZF4HfSWq/ydK0VU
         BIx5Hxx+t8+JyaiNUL15Dyt2wiM1XlqpZoMV0ok4EqzzyXXF9QkNM00KIKK3+3CQ2vhB
         SOthJopA9TWLLEiRtlSBf6x7mE4U3Wbt6Ddq9z5AL3LkcwVt3PVraty9PlWngLNgYVly
         oO+bilpc5gijWC8h++x3Wumc9VJUKEjFR+3RH9YVkkmAv9q/+Wzp+5voVTE6jOP8d2NH
         8y2FR3RJkf7YitorEXJAIYmAC5E7XQcstpTabglg9Qagr1yEpY6Epb33lPXd9G91Hcu7
         MZbA==
X-Gm-Message-State: ACrzQf2W8VdYcBXpzCTHA2fjPSTE2Av7xzwwRLvZY3htiefAZJJrI3mw
        2Rfg3cV/RNZanfTwlx3zDyon06iRY8z/y+yXreQjZQ==
X-Google-Smtp-Source: AMsMyM7eCIOVi4eDb45WMl9iMQmIs1xG3x/kW3AjsWH/WQgwqeJyUIazYha03q6yxrO1wsR9bg7nsMLLe9meLXjfYC8=
X-Received: by 2002:a05:6e02:bef:b0:2f9:889b:6db6 with SMTP id
 d15-20020a056e020bef00b002f9889b6db6mr23225855ilu.281.1666676823977; Mon, 24
 Oct 2022 22:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221023180514.2857498-1-yhs@fb.com> <20221023180530.2860453-1-yhs@fb.com>
 <dba4c448-ae08-f665-8723-c83c4d2fb98f@linux.dev> <CAJD7tkafC5BPqUxUWc3UUrphe0wKaRe=HfLvkyPk09+EV8ndCw@mail.gmail.com>
 <5dd7b50f-3179-75c2-4125-ee872f225129@linux.dev> <CAJD7tkY_HgX_Lr9j-OfPRWkg0hSGooATLCs589k5UiX9t5k97Q@mail.gmail.com>
 <CAJD7tkaOH-yUA0txW9A7jTOThpMYe3pHO-H6eDZabz8oRpaNsg@mail.gmail.com> <Y1dMLH5ehGt220LA@P9FQF9L96D>
In-Reply-To: <Y1dMLH5ehGt220LA@P9FQF9L96D>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 24 Oct 2022 22:46:27 -0700
Message-ID: <CAJD7tkaq=_XtndbJH2Y6UfPp_L3zRj4216eg=UYui_2doNvpLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org
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

On Mon, Oct 24, 2022 at 7:38 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Mon, Oct 24, 2022 at 05:55:17PM -0700, Yosry Ahmed wrote:
> > On Mon, Oct 24, 2022 at 5:48 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Mon, Oct 24, 2022 at 5:32 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> > > >
> > > > On 10/24/22 5:21 PM, Yosry Ahmed wrote:
> > > > > On Mon, Oct 24, 2022 at 2:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> > > > >>
> > > > >> On 10/23/22 11:05 AM, Yonghong Song wrote:
> > > > >>> +void bpf_cgrp_storage_free(struct cgroup *cgroup)
> > > > >>> +{
> > > > >>> +     struct bpf_local_storage *local_storage;
> > > > >>> +     struct bpf_local_storage_elem *selem;
> > > > >>> +     bool free_cgroup_storage = false;
> > > > >>> +     struct hlist_node *n;
> > > > >>> +     unsigned long flags;
> > > > >>> +
> > > > >>> +     rcu_read_lock();
> > > > >>> +     local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
> > > > >>> +     if (!local_storage) {
> > > > >>> +             rcu_read_unlock();
> > > > >>> +             return;
> > > > >>> +     }
> > > > >>> +
> > > > >>> +     /* Neither the bpf_prog nor the bpf_map's syscall
> > > > >>> +      * could be modifying the local_storage->list now.
> > > > >>> +      * Thus, no elem can be added to or deleted from the
> > > > >>> +      * local_storage->list by the bpf_prog or by the bpf_map's syscall.
> > > > >>> +      *
> > > > >>> +      * It is racing with __bpf_local_storage_map_free() alone
> > > > >>> +      * when unlinking elem from the local_storage->list and
> > > > >>> +      * the map's bucket->list.
> > > > >>> +      */
> > > > >>> +     bpf_cgrp_storage_lock();
> > > > >>> +     raw_spin_lock_irqsave(&local_storage->lock, flags);
> > > > >>> +     hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> > > > >>> +             bpf_selem_unlink_map(selem);
> > > > >>> +             /* If local_storage list has only one element, the
> > > > >>> +              * bpf_selem_unlink_storage_nolock() will return true.
> > > > >>> +              * Otherwise, it will return false. The current loop iteration
> > > > >>> +              * intends to remove all local storage. So the last iteration
> > > > >>> +              * of the loop will set the free_cgroup_storage to true.
> > > > >>> +              */
> > > > >>> +             free_cgroup_storage =
> > > > >>> +                     bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> > > > >>> +     }
> > > > >>> +     raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > > >>> +     bpf_cgrp_storage_unlock();
> > > > >>> +     rcu_read_unlock();
> > > > >>> +
> > > > >>> +     if (free_cgroup_storage)
> > > > >>> +             kfree_rcu(local_storage, rcu);
> > > > >>> +}
> > > > >>
> > > > >> [ ... ]
> > > > >>
> > > > >>> +/* *gfp_flags* is a hidden argument provided by the verifier */
> > > > >>> +BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
> > > > >>> +        void *, value, u64, flags, gfp_t, gfp_flags)
> > > > >>> +{
> > > > >>> +     struct bpf_local_storage_data *sdata;
> > > > >>> +
> > > > >>> +     WARN_ON_ONCE(!bpf_rcu_lock_held());
> > > > >>> +     if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
> > > > >>> +             return (unsigned long)NULL;
> > > > >>> +
> > > > >>> +     if (!cgroup)
> > > > >>> +             return (unsigned long)NULL;
> > > > >>> +
> > > > >>> +     if (!bpf_cgrp_storage_trylock())
> > > > >>> +             return (unsigned long)NULL;
> > > > >>> +
> > > > >>> +     sdata = cgroup_storage_lookup(cgroup, map, true);
> > > > >>> +     if (sdata)
> > > > >>> +             goto unlock;
> > > > >>> +
> > > > >>> +     /* only allocate new storage, when the cgroup is refcounted */
> > > > >>> +     if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
> > > > >>> +         (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
> > > > >>> +             sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
> > > > >>> +                                              value, BPF_NOEXIST, gfp_flags);
> > > > >>> +
> > > > >>> +unlock:
> > > > >>> +     bpf_cgrp_storage_unlock();
> > > > >>> +     return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
> > > > >>> +}
> > > > >>
> > > > >> [ ... ]
> > > > >>
> > > > >>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > > >>> index 764bdd5fd8d1..32145d066a09 100644
> > > > >>> --- a/kernel/cgroup/cgroup.c
> > > > >>> +++ b/kernel/cgroup/cgroup.c
> > > > >>> @@ -5227,6 +5227,10 @@ static void css_free_rwork_fn(struct work_struct *work)
> > > > >>>        struct cgroup_subsys *ss = css->ss;
> > > > >>>        struct cgroup *cgrp = css->cgroup;
> > > > >>>
> > > > >>> +#ifdef CONFIG_BPF_SYSCALL
> > > > >>> +     bpf_cgrp_storage_free(cgrp);
> > > > >>> +#endif
> > > > >>
> > > > >>
> > > > >> After revisiting comment 4bfc0bb2c60e, some of the commit message came to my mind:
> > > > >>
> > > > >> " ...... it blocks a possibility to implement
> > > > >>     the memcg-based memory accounting for bpf objects, because a circular
> > > > >>     reference dependency will occur. Charged memory pages are pinning the
> > > > >>     corresponding memory cgroup, and if the memory cgroup is pinning
> > > > >>     the attached bpf program, nothing will be ever released."
> > > > >>
> > > > >> Considering the bpf_map_kzalloc() is used in bpf_local_storage_map.c and it can
> > > > >> charge the memcg, I wonder if the cgrp_local_storage will have similar refcnt
> > > > >> loop issue here.
> > > > >>
> > > > >> If here is the right place to free the cgrp_local_storage() and enough to break
> > > > >> this refcnt loop, it will be useful to add some explanation and its
> > > > >> consideration in the commit message.
> > > > >>
> > > > >
> > > > > I think a similar refcount loop issue can happen here as well. IIUC,
> > > > > this function will only be run when the css is released after all
> > > > > references are dropped. So if memcg charging is enabled the cgroup
> > > > > will never be removed. This one might be trickier to handle though..
> > > >
> > > > How about removing all storage from cgrp->bpf_cgrp_storage in
> > > > cgroup_destroy_locked()?
> > >
> > > The problem here is that you lose information for cgroups that went
> > > offline but still exist in the kernel (i.e offline cgroups). The
> > > commit log 4bfc0bb2c60e mentions that such cgroups can have live
> > > sockets attached, so this might be a problem? From a memory
> > > perspective, offline memcgs can still undergo memory operations like
> > > reclaim. If we are using BPF to collect cgroup statistics for memory
> > > reclaim, we can't do so for offline memcgs, which is not the end of
> > > the world, but the cgroup storages become slightly less powerful. We
> > > might also lose some data that we have already stored for such offline
> > > memcgs. Also BPF programs now need to handle the case where they have
> > > a valid cgroup pointer but they cannot retrieve a cgroup storage for
> > > it because it went offline.
> > >
> > > We ideally want to be able to charge the memory to the cgroup without
> > > holding a ref to it, which is against the cgroup memory charging
> > > model.
> >
> > +Roman Gushchin
> >
> > Wait a second. I think Roman implemented reparenting of BPF map memcg
> > charges when a memcg is offlined. In this case, when a cgroup goes
> > offline (aka rmdir()'d), the charges will actually move to the parent,
> > and the local storage will no longer be holding any refs to the
> > cgroup. In that case, the current freeing location should be fine and
> > the cgroup local storage can continue to work with offlined cgroups.
> >
> > Roman, could you please confirm or deny my thesis?
>
> Yes, it shouldn't be a problem anymore since we've implemented the recharging
> of all main kernel memory types (slabs, large kmallocs, percpu).

Thanks for the confirmation and the fast response :)

>
> Thanks!
