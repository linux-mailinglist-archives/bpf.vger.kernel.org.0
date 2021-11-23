Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5709C45AFEE
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 00:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhKWXRu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 18:17:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233425AbhKWXRu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 18:17:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 866F960FD8
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 23:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637709281;
        bh=jE6WpKXuksZ6IQMRtvuYW70N3PAtc3DsQmXn+wImq2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CNfD0Xxd1S4tcp04KBiD+zP/an/lI6Fs5HOaD4L0pPJGrkda/JkFO6JQ98tnLthai
         YDojQhGSHyolQGaTXi8DB06tLbIUnNnw7SmhDJ7A7jOIgSYhr9YX1oOUc3qfHHshC8
         W+QKE/padOwie3EvXbyMDBK36N6MZItKDB/yWwKYwVXsVF1beRlpR7D+IRelbthojJ
         jhKY2zPvybH5OFy/jgxXbFSC1BKRflxfa1X5yrtIIAgh+iZWNFIPOX6FHMa+KEEq2E
         g+U3RYdwr6xd2FSuynPoIMZ4CB0O02J1ExDH7fgRf1jcRFR0/qiBoFt3Jb5t6d0+gT
         h4L7KksOIlXSg==
Received: by mail-ed1-f49.google.com with SMTP id x6so1782276edr.5
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 15:14:41 -0800 (PST)
X-Gm-Message-State: AOAM530hheB4xMna3wvQZ3YNrEb854Q0O/9/8PC4qf6kF7OgRS68GoT3
        T/uGtMJQJmm+qGdQNzRN8L8/M3oBjH/PfFg5xN55lQ==
X-Google-Smtp-Source: ABdhPJwNJHCjHsbFAr9VT1/VLim9gRg9Dz+gvxZVaMXGxxpCFRwJKTnisCutYdlxJMt/y2NKzFwDldwWLIWUKSjHEZQ=
X-Received: by 2002:aa7:dc14:: with SMTP id b20mr15790151edu.133.1637709279919;
 Tue, 23 Nov 2021 15:14:39 -0800 (PST)
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
Date:   Wed, 24 Nov 2021 00:14:29 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6TP19iV3hstamRge42R-7uKynbMQKcMHVLzCyTVEzVKw@mail.gmail.com>
Message-ID: <CACYkzJ6TP19iV3hstamRge42R-7uKynbMQKcMHVLzCyTVEzVKw@mail.gmail.com>
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

I was planning on adding a classical RCU read side critical section
whenever we called the lookup functions.

Would that have worked? (for the sake of learning).

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
>
> I think the splat is from CONFIG_PROVE_RAW_LOCK_NESTING=y.
>
> Just happened to bump into Paul briefly offline, his work probably can
> also avoid the spin_lock in call_rcu_tasks_trace().
>
> I would ignore this splat for now which should go away when it is
> merged with Paul's work in the 5.17 merge cycle.

Agreed.

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

+1 :)
