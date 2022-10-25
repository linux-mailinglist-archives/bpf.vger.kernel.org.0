Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41460C371
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 07:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiJYFpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 01:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJYFp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 01:45:29 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA3D722AB
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 22:45:26 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d142so9494229iof.7
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 22:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cA71I2FsszXQy7KiW3cp/NIz/xmbXVSxXsYfSu3HTTs=;
        b=HtSF0rBCm+kBxSJ6eLge94qzELANOKSFQvC5SDwMGrSyAVhyi4Or0y8Ik86NnQYbGn
         zATqSTCSewKfrqYNjTEerBAcbNMVDblr+OxInLPB0aBPsyJsrd+/LNnNvwTwlvq0BW9s
         l3ZiecKZ+lBRiSgd9sIr2YrIWN8cRUBeUZVdpry6xjTT37U3LTf4/P0vSyolEUc9oRzt
         M3ONUQxOgsns4C+PcKI4BumgW1cB6sIYbfbZRBzE/FpLQKgMDB5meJukDuaxr/qlLjHY
         GD8AbCukcySY9SyK1ha6WglNH0FHHrfoMtt6DjHF3Te3yuUpHIy5uB0wFCmaRzTU5Ihq
         3+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cA71I2FsszXQy7KiW3cp/NIz/xmbXVSxXsYfSu3HTTs=;
        b=x+rzdzRZ+/d2lY0H3o+ulXZrgU5511GDTecr2sOLd0vJKmY37HXugDyscNiXwztkqE
         wTgFbiYlUIGTQaYzHd20XWUIAdOmTs0MnF+8d/Hbrh25askPeTIne2s4tF0eiL1iDgbb
         OUtUbixVfNqyFQwGH+V6EfUygoIzQTp4iXt52/xkCdtISEoWOTBBxW3/ka+RPu6ieRsv
         D+p19gWoYsbtCrWT2xduqm6YNAmAK3OzjSLXwfHn0j2tX1Aj/HwsDESdP91g/CgWH+tV
         ZSw/6vWD2iZ7O5B48TdVdWtO1mqZDOquyi1Rh83HZuWGmEUbXInS6iR3QnQZn8cTlDHt
         8GHg==
X-Gm-Message-State: ACrzQf2b93SySRKNV57iWQENmdgFT4FABlokf7Y4KxnXdEazXnxDUmHW
        TWo+sxmbGAJg2emUzNrqhq7Xixtf1niN7sWtmk+U7A==
X-Google-Smtp-Source: AMsMyM75MWBXpdg6aWYdb79zUgzySjucGkOmcZ/v8da7hoaCMUycqtAPe5SHTcHPuyNNZT8ZbpQvprcFVufnXFhlr/U=
X-Received: by 2002:a05:6638:d93:b0:364:5a1:f48f with SMTP id
 l19-20020a0566380d9300b0036405a1f48fmr25066221jaj.149.1666676725575; Mon, 24
 Oct 2022 22:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221023180514.2857498-1-yhs@fb.com> <20221023180530.2860453-1-yhs@fb.com>
 <dba4c448-ae08-f665-8723-c83c4d2fb98f@linux.dev> <CAJD7tkafC5BPqUxUWc3UUrphe0wKaRe=HfLvkyPk09+EV8ndCw@mail.gmail.com>
 <5dd7b50f-3179-75c2-4125-ee872f225129@linux.dev> <CAJD7tkY_HgX_Lr9j-OfPRWkg0hSGooATLCs589k5UiX9t5k97Q@mail.gmail.com>
 <f136c13e-5386-ea21-69af-d48127c75752@linux.dev>
In-Reply-To: <f136c13e-5386-ea21-69af-d48127c75752@linux.dev>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 24 Oct 2022 22:44:49 -0700
Message-ID: <CAJD7tkb-tvLbJm2-Zq4YKFZ37ZW==sbHTHOxtdeSzQpDcTcTtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
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

On Mon, Oct 24, 2022 at 6:36 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/24/22 5:48 PM, Yosry Ahmed wrote:
> > On Mon, Oct 24, 2022 at 5:32 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>
> >> On 10/24/22 5:21 PM, Yosry Ahmed wrote:
> >>> On Mon, Oct 24, 2022 at 2:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>>>
> >>>> On 10/23/22 11:05 AM, Yonghong Song wrote:
> >>>>> +void bpf_cgrp_storage_free(struct cgroup *cgroup)
> >>>>> +{
> >>>>> +     struct bpf_local_storage *local_storage;
> >>>>> +     struct bpf_local_storage_elem *selem;
> >>>>> +     bool free_cgroup_storage = false;
> >>>>> +     struct hlist_node *n;
> >>>>> +     unsigned long flags;
> >>>>> +
> >>>>> +     rcu_read_lock();
> >>>>> +     local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
> >>>>> +     if (!local_storage) {
> >>>>> +             rcu_read_unlock();
> >>>>> +             return;
> >>>>> +     }
> >>>>> +
> >>>>> +     /* Neither the bpf_prog nor the bpf_map's syscall
> >>>>> +      * could be modifying the local_storage->list now.
> >>>>> +      * Thus, no elem can be added to or deleted from the
> >>>>> +      * local_storage->list by the bpf_prog or by the bpf_map's syscall.
> >>>>> +      *
> >>>>> +      * It is racing with __bpf_local_storage_map_free() alone
> >>>>> +      * when unlinking elem from the local_storage->list and
> >>>>> +      * the map's bucket->list.
> >>>>> +      */
> >>>>> +     bpf_cgrp_storage_lock();
> >>>>> +     raw_spin_lock_irqsave(&local_storage->lock, flags);
> >>>>> +     hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> >>>>> +             bpf_selem_unlink_map(selem);
> >>>>> +             /* If local_storage list has only one element, the
> >>>>> +              * bpf_selem_unlink_storage_nolock() will return true.
> >>>>> +              * Otherwise, it will return false. The current loop iteration
> >>>>> +              * intends to remove all local storage. So the last iteration
> >>>>> +              * of the loop will set the free_cgroup_storage to true.
> >>>>> +              */
> >>>>> +             free_cgroup_storage =
> >>>>> +                     bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> >>>>> +     }
> >>>>> +     raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> >>>>> +     bpf_cgrp_storage_unlock();
> >>>>> +     rcu_read_unlock();
> >>>>> +
> >>>>> +     if (free_cgroup_storage)
> >>>>> +             kfree_rcu(local_storage, rcu);
> >>>>> +}
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>> +/* *gfp_flags* is a hidden argument provided by the verifier */
> >>>>> +BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
> >>>>> +        void *, value, u64, flags, gfp_t, gfp_flags)
> >>>>> +{
> >>>>> +     struct bpf_local_storage_data *sdata;
> >>>>> +
> >>>>> +     WARN_ON_ONCE(!bpf_rcu_lock_held());
> >>>>> +     if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
> >>>>> +             return (unsigned long)NULL;
> >>>>> +
> >>>>> +     if (!cgroup)
> >>>>> +             return (unsigned long)NULL;
> >>>>> +
> >>>>> +     if (!bpf_cgrp_storage_trylock())
> >>>>> +             return (unsigned long)NULL;
> >>>>> +
> >>>>> +     sdata = cgroup_storage_lookup(cgroup, map, true);
> >>>>> +     if (sdata)
> >>>>> +             goto unlock;
> >>>>> +
> >>>>> +     /* only allocate new storage, when the cgroup is refcounted */
> >>>>> +     if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
> >>>>> +         (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
> >>>>> +             sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
> >>>>> +                                              value, BPF_NOEXIST, gfp_flags);
> >>>>> +
> >>>>> +unlock:
> >>>>> +     bpf_cgrp_storage_unlock();
> >>>>> +     return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
> >>>>> +}
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> >>>>> index 764bdd5fd8d1..32145d066a09 100644
> >>>>> --- a/kernel/cgroup/cgroup.c
> >>>>> +++ b/kernel/cgroup/cgroup.c
> >>>>> @@ -5227,6 +5227,10 @@ static void css_free_rwork_fn(struct work_struct *work)
> >>>>>         struct cgroup_subsys *ss = css->ss;
> >>>>>         struct cgroup *cgrp = css->cgroup;
> >>>>>
> >>>>> +#ifdef CONFIG_BPF_SYSCALL
> >>>>> +     bpf_cgrp_storage_free(cgrp);
> >>>>> +#endif
> >>>>
> >>>>
> >>>> After revisiting comment 4bfc0bb2c60e, some of the commit message came to my mind:
> >>>>
> >>>> " ...... it blocks a possibility to implement
> >>>>      the memcg-based memory accounting for bpf objects, because a circular
> >>>>      reference dependency will occur. Charged memory pages are pinning the
> >>>>      corresponding memory cgroup, and if the memory cgroup is pinning
> >>>>      the attached bpf program, nothing will be ever released."
> >>>>
> >>>> Considering the bpf_map_kzalloc() is used in bpf_local_storage_map.c and it can
> >>>> charge the memcg, I wonder if the cgrp_local_storage will have similar refcnt
> >>>> loop issue here.
> >>>>
> >>>> If here is the right place to free the cgrp_local_storage() and enough to break
> >>>> this refcnt loop, it will be useful to add some explanation and its
> >>>> consideration in the commit message.
> >>>>
> >>>
> >>> I think a similar refcount loop issue can happen here as well. IIUC,
> >>> this function will only be run when the css is released after all
> >>> references are dropped. So if memcg charging is enabled the cgroup
> >>> will never be removed. This one might be trickier to handle though..
> >>
> >> How about removing all storage from cgrp->bpf_cgrp_storage in
> >> cgroup_destroy_locked()?
> >
> > The problem here is that you lose information for cgroups that went
> > offline but still exist in the kernel (i.e offline cgroups). The
> > commit log 4bfc0bb2c60e mentions that such cgroups can have live
> > sockets attached, so this might be a problem?
>
> Keeping the cgrp_storage around is useful for the cgroup-bpf prog that will be
> called upon some sk events (eg ingress/egress).  The cgrp_storage cleanup could
> be done in cgroup_bpf_release_fn() also such that it will wait till all sk is done.
>
> > From a memory perspective, offline memcgs can still undergo memory operations like
> > reclaim. If we are using BPF to collect cgroup statistics for memory
> > reclaim, we can't do so for offline memcgs, which is not the end of
> > the world, but the cgroup storages become slightly less powerful. We
> > might also lose some data that we have already stored for such offline
> > memcgs. Also BPF programs now need to handle the case where they have
> > a valid cgroup pointer but they cannot retrieve a cgroup storage for
> > it because it went offline.
>
> iiuc, the use case is to be able to use the cgrp_storage at some earlier stage
> of the cgroup destruction.

Yes, exactly. The cgroup gets "offlined" when the user removes the
directory, but is not actually freed until all references are dropped.
An offline memcg can still undergo some operations.

> A noob question, I wonder if there is a cgroup that
> it will never go away, the root cgrp?  Then the cgrp_storage cleanup could be
> more selective and avoid cleaning up the cgrp storage charged to the root cgroup.

Yes, root cgrp doesn't go away, but I am not sure I understand how
this fixes the problem.

In all cases, Roman confirmed my theory. BPF maps charges are now
charged through objcg, not directly to memcgs, which means that when
the cgroup is offline, those charges are moved to the parent. IIUC,
this means there should not be a refcount loop. When the cgroup
directory is removed and the cgroup is offlined, the memory charges of
the cgrp_storage will move to the parent. The cgrp_storage will remain
accessible until all refs to it are dropped and it is actually freed
by css_free_rwork_fn(), at that point the cgrp_storage will be freed.

I just realized, I *think* the call to bpf_cgrp_storage_free(cgrp) is
actually misplaced within css_free_rwork_fn(). Reading the code, it
seems like css_free_rwork_fn() can be called in two cases:
(a) We are freeing a css (cgroup_subsys_state), but not the cgroup
itself (e.g. we are disabling a subsystem controller on a cgroup).
(b) We are freeing the cgroup itself.

I think we want to free the cgrp_storage only in (b), which would
correspond to the else statement (but before the nested if).
Basically, something like this *I think*:

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2319946715e0..f1e6058089f5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5349,6 +5349,7 @@ static void css_free_rwork_fn(struct work_struct *work)
                atomic_dec(&cgrp->root->nr_cgrps);
                cgroup1_pidlist_destroy_all(cgrp);
                cancel_work_sync(&cgrp->release_agent_work);
+               bpf_cgrp_storage_free(cgrp);

                if (cgroup_parent(cgrp)) {
                        /*

Tejun would know better, so please correct me if I am wrong.

(FWIW I think it would be nicer if we have an empty stub for
bpf_cgrp_storage_free() when !CONFIG_BPF_SYSCALL instead of the
#ifdef, similar to cgroup_bpf_offline()).

>
> > We ideally want to be able to charge the memory to the cgroup without
> > holding a ref to it, which is against the cgroup memory charging
> > model.
>
