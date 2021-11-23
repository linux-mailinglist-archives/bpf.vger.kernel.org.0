Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2A045AB36
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhKWSZN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhKWSZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 13:25:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4A3660D42;
        Tue, 23 Nov 2021 18:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637691724;
        bh=nM7fgaxkRFS5mGaZ25hbUUi44HaYsNWb3yhK4dfsOWI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tUTcOMMXdRslm9H8Du9hlh8NkWy2jAWYBohAWMnitUkEz3fnd9k1PThwzP56pJbAI
         eQjM33v+t2kA0eN1T8ki2OT0t5AgaEE93qbXLl4yCjWUpuUCpPQfpOphulv4lSdHum
         ChaURSMm92Q6VjCt+qdrkSTpehK/RuToWbOFU3k7hsdhtq/j0KQOM8Q5hC8jFim5nf
         Rw9uoZZQiKOGM9iCYDTpYxxdyWTITCuPk8P2U8qPgbdHX1Jgq69ns6pxy5tHeI3//+
         kIQDMHXNtmEP/ZfNOpmD4OxcyGJWKcgtBvKwK8n0LiHYYLlb7XF/KVVIrkRCcMx0XJ
         T3ObWt/3dO9sA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 640365C0E4E; Tue, 23 Nov 2021 10:22:04 -0800 (PST)
Date:   Tue, 23 Nov 2021 10:22:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20211123182204.GN641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
 <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
 <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1>
 <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 06:11:14PM +0100, KP Singh wrote:
> On Thu, Sep 2, 2021 at 6:45 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Wed, Sep 01, 2021 at 01:26:05PM -0700, Paul E. McKenney wrote:
> > > On Tue, Aug 31, 2021 at 11:32:17PM -0700, Martin KaFai Lau wrote:
> > > > On Tue, Aug 31, 2021 at 09:38:01PM +0200, KP Singh wrote:
> > > > [ ... ]
> > > >
> > > > > > > > > > > @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > > > > > > > > > >           SDATA(selem))
> > > > > > > > > > >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> > > > > > > > > > >
> > > > > > > > > > > -     kfree_rcu(selem, rcu);
> > > > > > > > > > > +     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > > > > > > > > Although the common use case is usually storage_get() much more often
> > > > > > > > > > than storage_delete(), do you aware any performance impact for
> > > > > > > > > > the bpf prog that does a lot of storage_delete()?
> > > > > > > > >
> > > > > > > > > I have not really measured the impact on deletes, My understanding is
> > > > > > > > > that it should
> > > > > > > > > not impact the BPF program, but yes, if there are some critical
> > > > > > > > > sections that are prolonged
> > > > > > > > > due to a sleepable program "sleeping" too long, then it would pile up
> > > > > > > > > the callbacks.
> > > > > > > > >
> > > > > > > > > But this is not something new, as we have a similar thing in BPF
> > > > > > > > > trampolines. If this really
> > > > > > > > > becomes an issue, we could add a flag BPF_F_SLEEPABLE_STORAGE and only maps
> > > > > > > > > with this flag would be allowed in sleepable progs.
> > > > > > > > Agree that is similar to trampoline updates but not sure it is comparable
> > > > > > > > in terms of the frequency of elems being deleted here.  e.g. many
> > > > > > > > short lived tcp connections created by external traffic.
> > > > > > > >
> > > > > > > > Adding a BPF_F_SLEEPABLE_STORAGE later won't work.  It will break
> > > > > > > > existing sleepable bpf prog.
> > > > > > > >
> > > > > > > > I don't know enough on call_rcu_tasks_trace() here, so the
> > > > > > > > earlier question on perf/callback-pile-up implications in order to
> > > > > > > > decide if extra logic or knob is needed here or not.
> > > > > > >
> > > > > > > I will defer to the others, maybe Alexei and Paul,
> > > > > >
> > > > > > > we could also just
> > > > > > > add the flag to not affect existing performance characteristics?
> > > > > > I would see if it is really necessary first.  Other sleepable
> > > > > > supported maps do not need a flag.  Adding one here for local
> > > > > > storage will be confusing especially if it turns out to be
> > > > > > unnecessary.
> > > > > >
> > > > > > Could you run some tests first which can guide the decision?
> > > > >
> > > > > I think the performance impact would happen only in the worst case which
> > > > > needs some work to simulate. What do you think about:
> > > > >
> > > > > A bprm_committed_creds program that processes a large argv
> > > > > and also gets a storage on the inode.
> > > > >
> > > > > A file_open program that tries to delete the local storage on the inode.
> > > > >
> > > > > Trigger this code in parallel. i.e. lots of programs that execute with a very
> > > > > large argv and then in parallel the executable being opened to trigger the
> > > > > delete.
> > > > >
> > > > > Do you have any other ideas? Is there something we could re-use from
> > > > > the selftests?
> > > >
> > > > There is a bench framework in tools/testing/selftests/bpf/benchs/
> > > > that has a parallel thread setup which could be useful.
> > > >
> > > > Don't know how to simulate the "sleeping" too long which
> > > > then pile-up callbacks.  This is not bpf specific.
> > > > Paul, I wonder if you have similar test to trigger this to
> > > > compare between call_rcu_tasks_trace() and call_rcu()?
> > >
> > > It is definitely the case that call_rcu() is way more scalable than
> > > is call_rcu_tasks_trace().  Something about call_rcu_tasks_trace()
> > > acquiring a global lock. ;-)
> > >
> > > So actually testing it makes a lot of sense.
> > >
> > > I do have an rcuscale module, but it is set up more for synchronous grace
> > > periods such as synchronize_rcu() and synchronize_rcu_tasks_trace().  It
> > > has the beginnings of support for call_rcu() and call_rcu_tasks_trace(),
> > > but I would not yet trust them.
> > >
> > > But I also have a test for global locking:
> > >
> > > $ tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs "NOPREEMPT" --kconfig "CONFIG_NR_CPUS=16" --bootargs "refscale.scale_type=lock refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make
> > >
> > > This gives a median lock overhead of 960ns.  Running a single CPU rather
> > > than 16 of them:
> > >
> > > $ tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs "NOPREEMPT" --kconfig "CONFIG_NR_CPUS=16" --bootargs "refscale.scale_type=lock refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make
> > >
> > > This gives a median lock overhead of 4.1ns, which is way faster.
> > > And the greater the number of CPUs, the greater the lock overhead.
> > Thanks for the explanation and numbers!
> >
> > I think the global lock will be an issue for the current non-sleepable
> > netdev bpf-prog which could be triggered by external traffic,  so a flag
> > is needed here to provide a fast path.  I suspect other non-prealloc map
> > may need it in the future, so probably
> > s/BPF_F_SLEEPABLE_STORAGE/BPF_F_SLEEPABLE/ instead.
> 
> I was re-working the patches and had a couple of questions.
> 
> There are two data structures that get freed under RCU here:
> 
> struct bpf_local_storage
> struct bpf_local_storage_selem
> 
> We can choose to free the bpf_local_storage_selem under
> call_rcu_tasks_trace based on
> whether the map it belongs to is sleepable with something like:
> 
> if (selem->sdata.smap->map.map_flags & BPF_F_SLEEPABLE_STORAGE)
>     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> else
>     kfree_rcu(selem, rcu);
> 
> Questions:
> 
> * Can we free bpf_local_storage under kfree_rcu by ensuring it's
> always accessed in a
>   classical RCU critical section? Or maybe I am missing something and
> this also needs to be freed
>   under trace RCU if any of the selems are from a sleepable map.
> 
> * There is an issue with nested raw spinlocks, e.g. in
> bpf_inode_storage.c:bpf_inode_storage_free
> 
>   hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>   /* Always unlink from map before unlinking from
>   * local_storage.
>   */
>   bpf_selem_unlink_map(selem);
>   free_inode_storage = bpf_selem_unlink_storage_nolock(
>                  local_storage, selem, false);
>   }
>   raw_spin_unlock_bh(&local_storage->lock);
> 
> in bpf_selem_unlink_storage_nolock (if we add the above logic with the
> flag in place of kfree_rcu)
> call_rcu_tasks_trace grabs a spinlock and these cannot be nested in a
> raw spin lock.
> 
> I am moving the freeing code out of the spinlock, saving the selems on
> a local list and then
> doing the free RCU (trace or normal) callbacks at the end. WDYT?

Depending on the urgency, another approach is to rely on my ongoing work
removing the call_rcu_tasks_trace() bottleneck.  This commit on branch
"dev" in the -rcu tree allows boot-time setting of per-CPU callback
queues for call_rcu_tasks_trace(), along with the other RCU-tasks flavors:

0b886cc4b10f ("rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set initial queueing")

Preceding commits actually set up the queues.  With these commits, you
could boot with rcupdate.rcu_task_enqueue_lim=N, where N greater than
or equal to the number of CPUs on your system, to get per-CPU queuing.
These commits probably still have a bug or three, but on the other hand,
they have survived a couple of weeks worth of rcutorture runs.

This week's work will allow automatic transition between single-queue
and per-CPU-queue operation based on lock contention and the number of
callbacks queued.

My current plan is to get this into the next merge window (v5.17).

Thoughts?

							Thanx, Paul

> - KP
> 
> >
> > [ ... ]
> >
> > > > [  143.376587] =============================
> > > > [  143.377068] WARNING: suspicious RCU usage
> > > > [  143.377541] 5.14.0-rc5-01271-g68e5bda2b18e #4966 Tainted: G           O
> > > > [  143.378378] -----------------------------
> > > > [  143.378857] kernel/bpf/bpf_local_storage.c:114 suspicious rcu_dereference_check() usage!
> > > > [  143.379914]
> > > > [  143.379914] other info that might help us debug this:
> > > > [  143.379914]
> > > > [  143.380838]
> > > > [  143.380838] rcu_scheduler_active = 2, debug_locks = 1
> > > > [  143.381602] 4 locks held by mv/1781:
> > > > [  143.382025]  #0: ffff888121e7c438 (sb_writers#6){.+.+}-{0:0}, at: do_renameat2+0x2f5/0xa80
> > > > [  143.383009]  #1: ffff88812ce68760 (&type->i_mutex_dir_key#5/1){+.+.}-{3:3}, at: lock_rename+0x1f4/0x250
> > > > [  143.384144]  #2: ffffffff843fbc60 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x45/0x160
> > > > [  143.385326]  #3: ffff88811d8348b8 (&storage->lock){..-.}-{2:2}, at: __bpf_selem_unlink_storage+0x7d/0x170
> > > > [  143.386459]
> > > > [  143.386459] stack backtrace:
> > > > [  143.386983] CPU: 2 PID: 1781 Comm: mv Tainted: G           O      5.14.0-rc5-01271-g68e5bda2b18e #4966
> > > > [  143.388071] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.el7.centos 04/01/2014
> > > > [  143.389146] Call Trace:
> > > > [  143.389446]  dump_stack_lvl+0x5b/0x82
> > > > [  143.389901]  dump_stack+0x10/0x12
> > > > [  143.390302]  lockdep_rcu_suspicious+0x15c/0x167
> > > > [  143.390854]  bpf_selem_unlink_storage_nolock+0x2e1/0x6d0
> > > > [  143.391501]  __bpf_selem_unlink_storage+0xb7/0x170
> > > > [  143.392085]  bpf_selem_unlink+0x1b/0x30
> > > > [  143.392554]  bpf_inode_storage_delete+0x57/0xa0
> > > > [  143.393112]  bpf_prog_31e277fe2c132665_inode_rename+0x9c/0x268
> > > > [  143.393814]  bpf_trampoline_6442476301_0+0x4e/0x1000
> > > > [  143.394413]  bpf_lsm_inode_rename+0x5/0x10
> > >
> > > I am not sure what line 114 is (it is a blank line in bpf-next), but
> > > you might be missing a rcu_read_lock_trace_held() in the second argument
> > > of rcu_dereference_check().
> > Right, this path is only under rcu_read_lock_trace().
