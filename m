Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996C060C158
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 03:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiJYBqn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 21:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiJYBqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 21:46:17 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D145FC748
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 18:36:16 -0700 (PDT)
Message-ID: <f136c13e-5386-ea21-69af-d48127c75752@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666661774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lg8YDGU3TCaN61a5wt+p+smOnSoigX/7i0zLKzo4Zmw=;
        b=lHYTfOYw552JvfUdqMjEMal+MQh7GQh1KLzpSm8CgAa/oWacbLNaqzK33yjwXBTTipkNiN
        mfjK1BnFM1NXO4A0vlthWhxI3s5dRzr3Jh2VS0+x5IsA+20E4IP+EbQmD3TTKQN/yBYRn/
        y09T42ut0iSjmgFdhDG1KEyuTzvqezQ=
Date:   Mon, 24 Oct 2022 18:36:10 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180530.2860453-1-yhs@fb.com>
 <dba4c448-ae08-f665-8723-c83c4d2fb98f@linux.dev>
 <CAJD7tkafC5BPqUxUWc3UUrphe0wKaRe=HfLvkyPk09+EV8ndCw@mail.gmail.com>
 <5dd7b50f-3179-75c2-4125-ee872f225129@linux.dev>
 <CAJD7tkY_HgX_Lr9j-OfPRWkg0hSGooATLCs589k5UiX9t5k97Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAJD7tkY_HgX_Lr9j-OfPRWkg0hSGooATLCs589k5UiX9t5k97Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/24/22 5:48 PM, Yosry Ahmed wrote:
> On Mon, Oct 24, 2022 at 5:32 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 10/24/22 5:21 PM, Yosry Ahmed wrote:
>>> On Mon, Oct 24, 2022 at 2:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 10/23/22 11:05 AM, Yonghong Song wrote:
>>>>> +void bpf_cgrp_storage_free(struct cgroup *cgroup)
>>>>> +{
>>>>> +     struct bpf_local_storage *local_storage;
>>>>> +     struct bpf_local_storage_elem *selem;
>>>>> +     bool free_cgroup_storage = false;
>>>>> +     struct hlist_node *n;
>>>>> +     unsigned long flags;
>>>>> +
>>>>> +     rcu_read_lock();
>>>>> +     local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>>>>> +     if (!local_storage) {
>>>>> +             rcu_read_unlock();
>>>>> +             return;
>>>>> +     }
>>>>> +
>>>>> +     /* Neither the bpf_prog nor the bpf_map's syscall
>>>>> +      * could be modifying the local_storage->list now.
>>>>> +      * Thus, no elem can be added to or deleted from the
>>>>> +      * local_storage->list by the bpf_prog or by the bpf_map's syscall.
>>>>> +      *
>>>>> +      * It is racing with __bpf_local_storage_map_free() alone
>>>>> +      * when unlinking elem from the local_storage->list and
>>>>> +      * the map's bucket->list.
>>>>> +      */
>>>>> +     bpf_cgrp_storage_lock();
>>>>> +     raw_spin_lock_irqsave(&local_storage->lock, flags);
>>>>> +     hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>>>>> +             bpf_selem_unlink_map(selem);
>>>>> +             /* If local_storage list has only one element, the
>>>>> +              * bpf_selem_unlink_storage_nolock() will return true.
>>>>> +              * Otherwise, it will return false. The current loop iteration
>>>>> +              * intends to remove all local storage. So the last iteration
>>>>> +              * of the loop will set the free_cgroup_storage to true.
>>>>> +              */
>>>>> +             free_cgroup_storage =
>>>>> +                     bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
>>>>> +     }
>>>>> +     raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>>>>> +     bpf_cgrp_storage_unlock();
>>>>> +     rcu_read_unlock();
>>>>> +
>>>>> +     if (free_cgroup_storage)
>>>>> +             kfree_rcu(local_storage, rcu);
>>>>> +}
>>>>
>>>> [ ... ]
>>>>
>>>>> +/* *gfp_flags* is a hidden argument provided by the verifier */
>>>>> +BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
>>>>> +        void *, value, u64, flags, gfp_t, gfp_flags)
>>>>> +{
>>>>> +     struct bpf_local_storage_data *sdata;
>>>>> +
>>>>> +     WARN_ON_ONCE(!bpf_rcu_lock_held());
>>>>> +     if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
>>>>> +             return (unsigned long)NULL;
>>>>> +
>>>>> +     if (!cgroup)
>>>>> +             return (unsigned long)NULL;
>>>>> +
>>>>> +     if (!bpf_cgrp_storage_trylock())
>>>>> +             return (unsigned long)NULL;
>>>>> +
>>>>> +     sdata = cgroup_storage_lookup(cgroup, map, true);
>>>>> +     if (sdata)
>>>>> +             goto unlock;
>>>>> +
>>>>> +     /* only allocate new storage, when the cgroup is refcounted */
>>>>> +     if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
>>>>> +         (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
>>>>> +             sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
>>>>> +                                              value, BPF_NOEXIST, gfp_flags);
>>>>> +
>>>>> +unlock:
>>>>> +     bpf_cgrp_storage_unlock();
>>>>> +     return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
>>>>> +}
>>>>
>>>> [ ... ]
>>>>
>>>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>>>> index 764bdd5fd8d1..32145d066a09 100644
>>>>> --- a/kernel/cgroup/cgroup.c
>>>>> +++ b/kernel/cgroup/cgroup.c
>>>>> @@ -5227,6 +5227,10 @@ static void css_free_rwork_fn(struct work_struct *work)
>>>>>         struct cgroup_subsys *ss = css->ss;
>>>>>         struct cgroup *cgrp = css->cgroup;
>>>>>
>>>>> +#ifdef CONFIG_BPF_SYSCALL
>>>>> +     bpf_cgrp_storage_free(cgrp);
>>>>> +#endif
>>>>
>>>>
>>>> After revisiting comment 4bfc0bb2c60e, some of the commit message came to my mind:
>>>>
>>>> " ...... it blocks a possibility to implement
>>>>      the memcg-based memory accounting for bpf objects, because a circular
>>>>      reference dependency will occur. Charged memory pages are pinning the
>>>>      corresponding memory cgroup, and if the memory cgroup is pinning
>>>>      the attached bpf program, nothing will be ever released."
>>>>
>>>> Considering the bpf_map_kzalloc() is used in bpf_local_storage_map.c and it can
>>>> charge the memcg, I wonder if the cgrp_local_storage will have similar refcnt
>>>> loop issue here.
>>>>
>>>> If here is the right place to free the cgrp_local_storage() and enough to break
>>>> this refcnt loop, it will be useful to add some explanation and its
>>>> consideration in the commit message.
>>>>
>>>
>>> I think a similar refcount loop issue can happen here as well. IIUC,
>>> this function will only be run when the css is released after all
>>> references are dropped. So if memcg charging is enabled the cgroup
>>> will never be removed. This one might be trickier to handle though..
>>
>> How about removing all storage from cgrp->bpf_cgrp_storage in
>> cgroup_destroy_locked()?
> 
> The problem here is that you lose information for cgroups that went
> offline but still exist in the kernel (i.e offline cgroups). The
> commit log 4bfc0bb2c60e mentions that such cgroups can have live
> sockets attached, so this might be a problem?

Keeping the cgrp_storage around is useful for the cgroup-bpf prog that will be 
called upon some sk events (eg ingress/egress).  The cgrp_storage cleanup could 
be done in cgroup_bpf_release_fn() also such that it will wait till all sk is done.

> From a memory perspective, offline memcgs can still undergo memory operations like
> reclaim. If we are using BPF to collect cgroup statistics for memory
> reclaim, we can't do so for offline memcgs, which is not the end of
> the world, but the cgroup storages become slightly less powerful. We
> might also lose some data that we have already stored for such offline
> memcgs. Also BPF programs now need to handle the case where they have
> a valid cgroup pointer but they cannot retrieve a cgroup storage for
> it because it went offline.

iiuc, the use case is to be able to use the cgrp_storage at some earlier stage 
of the cgroup destruction.  A noob question, I wonder if there is a cgroup that 
it will never go away, the root cgrp?  Then the cgrp_storage cleanup could be 
more selective and avoid cleaning up the cgrp storage charged to the root cgroup.

> We ideally want to be able to charge the memory to the cgroup without
> holding a ref to it, which is against the cgroup memory charging
> model.

