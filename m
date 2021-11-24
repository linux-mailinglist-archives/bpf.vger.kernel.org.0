Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9212945CFFB
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 23:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbhKXWYD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 17:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245727AbhKXWYD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 17:24:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0C5761058
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 22:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637792453;
        bh=QuOKEd8wjRRmJ4cGqPjvltrZYL2dOTdPrZF2ytNqfYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lKuTfa4aB2hQgUDSX3cYorFDs5TIg6zERwH2RypIlhBS2G+ht2GmgblMRdgWA5Ptw
         92LWsHCT8jf8UEA077ST4vvaZzlvxIBxhH8wa44y5yDdjrMGO8dHpqnFOcoYb2+Y7J
         mbfd9A/qhdvSO/gbH8PRmfNInezQIuSQYoG/zw/tkU86KZFrBloQ4nKzESnTcHCCKh
         gLJeUx2MGxmZRP43zn6LqYeDI/OS/Hiw9sH6ZpApVmOoWJfwdFGq8LfrHaSaGwODBY
         aMPmhXr+KwFyYHpN08JGrFwCGWfZHamGkXimg2Zkk52sba3WGLKQ+PxR1pDwNkLUHb
         Y7ix8jZYl5EpQ==
Received: by mail-ed1-f52.google.com with SMTP id x6so16800650edr.5
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 14:20:52 -0800 (PST)
X-Gm-Message-State: AOAM533032LkMbPCcEwNyduTJvYaLUtkvzhDJK2eX5g+OxHE+GMhhReT
        IYtH9uJVebsUMY3NDQWc4Ykife44hZ/4xSFlfsVExQ==
X-Google-Smtp-Source: ABdhPJyJRCiPZZOd58+a8uleGo6lyKl5T+txuC+2vHBzshPgIzPGSC0LTUAyisykCYQNUke1G9t4V186uSu7pk1gu1Y=
X-Received: by 2002:a05:6402:4311:: with SMTP id m17mr30424754edc.103.1637792451360;
 Wed, 24 Nov 2021 14:20:51 -0800 (PST)
MIME-Version: 1.0
References: <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
 <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1> <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
 <20211123182204.GN641268@paulmck-ThinkPad-P17-Gen-1> <20211123222940.3x2hkrrgd4l2vuk7@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211123222940.3x2hkrrgd4l2vuk7@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 24 Nov 2021 23:20:40 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4VDMzp2ggtVL30xq+6Q2+2OqOLhuoi173=8mdyRbS+QQ@mail.gmail.com>
Message-ID: <CACYkzJ4VDMzp2ggtVL30xq+6Q2+2OqOLhuoi173=8mdyRbS+QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 11:30 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Nov 23, 2021 at 10:22:04AM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 23, 2021 at 06:11:14PM +0100, KP Singh wrote:
> > > On Thu, Sep 2, 2021 at 6:45 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > I think the global lock will be an issue for the current non-sleepable
> > > > netdev bpf-prog which could be triggered by external traffic,  so a flag
> > > > is needed here to provide a fast path.  I suspect other non-prealloc map
> > > > may need it in the future, so probably
> > > > s/BPF_F_SLEEPABLE_STORAGE/BPF_F_SLEEPABLE/ instead.
> > >
> > > I was re-working the patches and had a couple of questions.
> > >
> > > There are two data structures that get freed under RCU here:
> > >
> > > struct bpf_local_storage
> > > struct bpf_local_storage_selem
> > >
> > > We can choose to free the bpf_local_storage_selem under
> > > call_rcu_tasks_trace based on
> > > whether the map it belongs to is sleepable with something like:
> > >
> > > if (selem->sdata.smap->map.map_flags & BPF_F_SLEEPABLE_STORAGE)
> Paul's current work (mentioned by his previous email) will improve the
> performance of call_rcu_tasks_trace, so it probably can avoid the
> new BPF_F_SLEEPABLE flag and make it easier to use.
>
> > >     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > else
> > >     kfree_rcu(selem, rcu);
> > >
> > > Questions:
> > >
> > > * Can we free bpf_local_storage under kfree_rcu by ensuring it's
> > >   always accessed in a  classical RCU critical section?
> >>    Or maybe I am missing something and this also needs to be freed
> > >   under trace RCU if any of the selems are from a sleepable map.
> In the inode_storage_lookup() of this patch:
>
> +#define bpf_local_storage_rcu_lock_held()                      \
> +       (rcu_read_lock_held() || rcu_read_lock_trace_held() ||  \
> +        rcu_read_lock_bh_held())
>
> @@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
>         if (!bsb)
>                 return NULL;
>
> -       inode_storage = rcu_dereference(bsb->storage);
> +       inode_storage = rcu_dereference_protected(bsb->storage,
> +                                                 bpf_local_storage_rcu_lock_held());
>
> Thus, it is not always in classical RCU critical.
>
> > >
> > > * There is an issue with nested raw spinlocks, e.g. in
> > > bpf_inode_storage.c:bpf_inode_storage_free
> > >
> > >   hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> > >   /* Always unlink from map before unlinking from
> > >   * local_storage.
> > >   */
> > >   bpf_selem_unlink_map(selem);
> > >   free_inode_storage = bpf_selem_unlink_storage_nolock(
> > >                  local_storage, selem, false);
> > >   }
> > >   raw_spin_unlock_bh(&local_storage->lock);
> > >
> > > in bpf_selem_unlink_storage_nolock (if we add the above logic with the
> > > flag in place of kfree_rcu)
> > > call_rcu_tasks_trace grabs a spinlock and these cannot be nested in a
> > > raw spin lock.
> > >
> > > I am moving the freeing code out of the spinlock, saving the selems on
> > > a local list and then doing the free RCU (trace or normal) callbacks
> > > at the end. WDYT?
> There could be more than one selem to save.

Yes, that's why I was saving them on a local list and then calling
kfree_rcu or call_rcu_tasks_trace after unlocking the raw_spin_lock

INIT_HLIST_HEAD(&free_list);
raw_spin_lock_irqsave(&local_storage->lock, flags);
hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
    bpf_selem_unlink_map(selem);
    free_local_storage = bpf_selem_unlink_storage_nolock(
    local_storage, selem, false);
    hlist_add_head(&selem->snode, &free_list);
}
raw_spin_unlock_irqrestore(&local_storage->lock, flags);

/* The element needs to be freed outside the raw spinlock because spin
* locks cannot nest inside a raw spin locks and call_rcu_tasks_trace
* grabs a spinklock when the RCU code calls into the scheduler.
*
* free_local_storage should always be true as long as
* local_storage->list was non-empty.
*/
hlist_for_each_entry_safe(selem, n, &free_list, snode) {
    if (selem->sdata.smap->map.map_flags & BPF_F_SLEEPABLE_STORAGE)
        call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
    else
        kfree_rcu(selem, rcu);
}

But... we won't need this anymore.

>
> I think the splat is from CONFIG_PROVE_RAW_LOCK_NESTING=y.
>
> Just happened to bump into Paul briefly offline, his work probably can
> also avoid the spin_lock in call_rcu_tasks_trace().
>
> I would ignore this splat for now which should go away when it is
> merged with Paul's work in the 5.17 merge cycle.
>
> > Depending on the urgency, another approach is to rely on my ongoing work
> > removing the call_rcu_tasks_trace() bottleneck.  This commit on branch
> > "dev" in the -rcu tree allows boot-time setting of per-CPU callback
> > queues for call_rcu_tasks_trace(), along with the other RCU-tasks flavors:
> >
> > 0b886cc4b10f ("rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set initial queueing")
> >
> > Preceding commits actually set up the queues.  With these commits, you
> > could boot with rcupdate.rcu_task_enqueue_lim=N, where N greater than
> > or equal to the number of CPUs on your system, to get per-CPU queuing.
> > These commits probably still have a bug or three, but on the other hand,
> > they have survived a couple of weeks worth of rcutorture runs.
> >
> > This week's work will allow automatic transition between single-queue
> > and per-CPU-queue operation based on lock contention and the number of
> > callbacks queued.
> >
> > My current plan is to get this into the next merge window (v5.17).
> That would be great.
