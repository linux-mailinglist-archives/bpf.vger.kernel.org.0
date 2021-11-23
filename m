Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1313B45A9BB
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 18:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbhKWROf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 12:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238234AbhKWROe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 12:14:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7310A60F90
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637687486;
        bh=xsJScN1jm6Ya6FpvQ2CbavJ5tOBUIZ6K536mrQfFk2k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GGxzILhnKiNAzfvwlnnihLAAJLCV2E2oQOk7v1NSh1aTMMuLoHh5dkexZW0NoZBhw
         o2dISd64o/4Z/MfbCOd7cJ9fINGrN6kZikqiB5y+vy+0HKN4l3YGAHT8UVQtKMXce6
         kMNTqcMbJyN1459bkZdX3YFT3lb16nPWyx39puaCVwIzpzF9frdkdF9Zwa9xN+R/C1
         mWUehjnoH+8ZBOcsWQhlG8cXK7hq9WluxoSCigb6IM5O9e2L7UOj6cX/pD1ORipald
         cnlsy2UCmJ5cdFnvTj81T0nnt+12JU3pZPjuYiS2cKv7Kd2HP1o1jwmfkOGMB+uX0m
         SJYiWvVsky8yw==
Received: by mail-ed1-f47.google.com with SMTP id r25so58164486edq.7
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 09:11:26 -0800 (PST)
X-Gm-Message-State: AOAM5321FKujFpf7h7L2AtJA0UC5DmRqnIVu6SMX7u1VAYi7N61wgEkm
        /SfMaz0pSNlScv+qblAmE+HAnSD/ju44L1E/Es7deQ==
X-Google-Smtp-Source: ABdhPJyKKWv0vLB7oZ44c7hlxAyy8Fop0fC+ADq267Ie1L6VAzHZRKbwXPGIquemRn8KysW+k4Sv/51MflKKwe8hmu8=
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr9633629ejc.493.1637687484773;
 Tue, 23 Nov 2021 09:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20210826235127.303505-1-kpsingh@kernel.org> <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp> <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
 <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1> <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 23 Nov 2021 18:11:14 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
Message-ID: <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 2, 2021 at 6:45 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Sep 01, 2021 at 01:26:05PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 31, 2021 at 11:32:17PM -0700, Martin KaFai Lau wrote:
> > > On Tue, Aug 31, 2021 at 09:38:01PM +0200, KP Singh wrote:
> > > [ ... ]
> > >
> > > > > > > > > > @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_noloc=
k(struct bpf_local_storage *local_storage,
> > > > > > > > > >           SDATA(selem))
> > > > > > > > > >               RCU_INIT_POINTER(local_storage->cache[sma=
p->cache_idx], NULL);
> > > > > > > > > >
> > > > > > > > > > -     kfree_rcu(selem, rcu);
> > > > > > > > > > +     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_=
rcu);
> > > > > > > > > Although the common use case is usually storage_get() muc=
h more often
> > > > > > > > > than storage_delete(), do you aware any performance impac=
t for
> > > > > > > > > the bpf prog that does a lot of storage_delete()?
> > > > > > > >
> > > > > > > > I have not really measured the impact on deletes, My unders=
tanding is
> > > > > > > > that it should
> > > > > > > > not impact the BPF program, but yes, if there are some crit=
ical
> > > > > > > > sections that are prolonged
> > > > > > > > due to a sleepable program "sleeping" too long, then it wou=
ld pile up
> > > > > > > > the callbacks.
> > > > > > > >
> > > > > > > > But this is not something new, as we have a similar thing i=
n BPF
> > > > > > > > trampolines. If this really
> > > > > > > > becomes an issue, we could add a flag BPF_F_SLEEPABLE_STORA=
GE and only maps
> > > > > > > > with this flag would be allowed in sleepable progs.
> > > > > > > Agree that is similar to trampoline updates but not sure it i=
s comparable
> > > > > > > in terms of the frequency of elems being deleted here.  e.g. =
many
> > > > > > > short lived tcp connections created by external traffic.
> > > > > > >
> > > > > > > Adding a BPF_F_SLEEPABLE_STORAGE later won't work.  It will b=
reak
> > > > > > > existing sleepable bpf prog.
> > > > > > >
> > > > > > > I don't know enough on call_rcu_tasks_trace() here, so the
> > > > > > > earlier question on perf/callback-pile-up implications in ord=
er to
> > > > > > > decide if extra logic or knob is needed here or not.
> > > > > >
> > > > > > I will defer to the others, maybe Alexei and Paul,
> > > > >
> > > > > > we could also just
> > > > > > add the flag to not affect existing performance characteristics=
?
> > > > > I would see if it is really necessary first.  Other sleepable
> > > > > supported maps do not need a flag.  Adding one here for local
> > > > > storage will be confusing especially if it turns out to be
> > > > > unnecessary.
> > > > >
> > > > > Could you run some tests first which can guide the decision?
> > > >
> > > > I think the performance impact would happen only in the worst case =
which
> > > > needs some work to simulate. What do you think about:
> > > >
> > > > A bprm_committed_creds program that processes a large argv
> > > > and also gets a storage on the inode.
> > > >
> > > > A file_open program that tries to delete the local storage on the i=
node.
> > > >
> > > > Trigger this code in parallel. i.e. lots of programs that execute w=
ith a very
> > > > large argv and then in parallel the executable being opened to trig=
ger the
> > > > delete.
> > > >
> > > > Do you have any other ideas? Is there something we could re-use fro=
m
> > > > the selftests?
> > >
> > > There is a bench framework in tools/testing/selftests/bpf/benchs/
> > > that has a parallel thread setup which could be useful.
> > >
> > > Don't know how to simulate the "sleeping" too long which
> > > then pile-up callbacks.  This is not bpf specific.
> > > Paul, I wonder if you have similar test to trigger this to
> > > compare between call_rcu_tasks_trace() and call_rcu()?
> >
> > It is definitely the case that call_rcu() is way more scalable than
> > is call_rcu_tasks_trace().  Something about call_rcu_tasks_trace()
> > acquiring a global lock. ;-)
> >
> > So actually testing it makes a lot of sense.
> >
> > I do have an rcuscale module, but it is set up more for synchronous gra=
ce
> > periods such as synchronize_rcu() and synchronize_rcu_tasks_trace().  I=
t
> > has the beginnings of support for call_rcu() and call_rcu_tasks_trace()=
,
> > but I would not yet trust them.
> >
> > But I also have a test for global locking:
> >
> > $ tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --al=
lcpus --duration 5 --configs "NOPREEMPT" --kconfig "CONFIG_NR_CPUS=3D16" --=
bootargs "refscale.scale_type=3Dlock refscale.loops=3D10000 refscale.holdof=
f=3D20 torture.disable_onoff_at_boot" --trust-make
> >
> > This gives a median lock overhead of 960ns.  Running a single CPU rathe=
r
> > than 16 of them:
> >
> > $ tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --al=
lcpus --duration 5 --configs "NOPREEMPT" --kconfig "CONFIG_NR_CPUS=3D16" --=
bootargs "refscale.scale_type=3Dlock refscale.loops=3D10000 refscale.holdof=
f=3D20 torture.disable_onoff_at_boot" --trust-make
> >
> > This gives a median lock overhead of 4.1ns, which is way faster.
> > And the greater the number of CPUs, the greater the lock overhead.
> Thanks for the explanation and numbers!
>
> I think the global lock will be an issue for the current non-sleepable
> netdev bpf-prog which could be triggered by external traffic,  so a flag
> is needed here to provide a fast path.  I suspect other non-prealloc map
> may need it in the future, so probably
> s/BPF_F_SLEEPABLE_STORAGE/BPF_F_SLEEPABLE/ instead.

I was re-working the patches and had a couple of questions.

There are two data structures that get freed under RCU here:

struct bpf_local_storage
struct bpf_local_storage_selem

We can choose to free the bpf_local_storage_selem under
call_rcu_tasks_trace based on
whether the map it belongs to is sleepable with something like:

if (selem->sdata.smap->map.map_flags & BPF_F_SLEEPABLE_STORAGE)
    call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
else
    kfree_rcu(selem, rcu);

Questions:

* Can we free bpf_local_storage under kfree_rcu by ensuring it's
always accessed in a
  classical RCU critical section? Or maybe I am missing something and
this also needs to be freed
  under trace RCU if any of the selems are from a sleepable map.

* There is an issue with nested raw spinlocks, e.g. in
bpf_inode_storage.c:bpf_inode_storage_free

  hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
  /* Always unlink from map before unlinking from
  * local_storage.
  */
  bpf_selem_unlink_map(selem);
  free_inode_storage =3D bpf_selem_unlink_storage_nolock(
                 local_storage, selem, false);
  }
  raw_spin_unlock_bh(&local_storage->lock);

in bpf_selem_unlink_storage_nolock (if we add the above logic with the
flag in place of kfree_rcu)
call_rcu_tasks_trace grabs a spinlock and these cannot be nested in a
raw spin lock.

I am moving the freeing code out of the spinlock, saving the selems on
a local list and then
doing the free RCU (trace or normal) callbacks at the end. WDYT?



- KP

>
> [ ... ]
>
> > > [  143.376587] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [  143.377068] WARNING: suspicious RCU usage
> > > [  143.377541] 5.14.0-rc5-01271-g68e5bda2b18e #4966 Tainted: G       =
    O
> > > [  143.378378] -----------------------------
> > > [  143.378857] kernel/bpf/bpf_local_storage.c:114 suspicious rcu_dere=
ference_check() usage!
> > > [  143.379914]
> > > [  143.379914] other info that might help us debug this:
> > > [  143.379914]
> > > [  143.380838]
> > > [  143.380838] rcu_scheduler_active =3D 2, debug_locks =3D 1
> > > [  143.381602] 4 locks held by mv/1781:
> > > [  143.382025]  #0: ffff888121e7c438 (sb_writers#6){.+.+}-{0:0}, at: =
do_renameat2+0x2f5/0xa80
> > > [  143.383009]  #1: ffff88812ce68760 (&type->i_mutex_dir_key#5/1){+.+=
.}-{3:3}, at: lock_rename+0x1f4/0x250
> > > [  143.384144]  #2: ffffffff843fbc60 (rcu_read_lock_trace){....}-{0:0=
}, at: __bpf_prog_enter_sleepable+0x45/0x160
> > > [  143.385326]  #3: ffff88811d8348b8 (&storage->lock){..-.}-{2:2}, at=
: __bpf_selem_unlink_storage+0x7d/0x170
> > > [  143.386459]
> > > [  143.386459] stack backtrace:
> > > [  143.386983] CPU: 2 PID: 1781 Comm: mv Tainted: G           O      =
5.14.0-rc5-01271-g68e5bda2b18e #4966
> > > [  143.388071] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.9.3-1.el7.centos 04/01/2014
> > > [  143.389146] Call Trace:
> > > [  143.389446]  dump_stack_lvl+0x5b/0x82
> > > [  143.389901]  dump_stack+0x10/0x12
> > > [  143.390302]  lockdep_rcu_suspicious+0x15c/0x167
> > > [  143.390854]  bpf_selem_unlink_storage_nolock+0x2e1/0x6d0
> > > [  143.391501]  __bpf_selem_unlink_storage+0xb7/0x170
> > > [  143.392085]  bpf_selem_unlink+0x1b/0x30
> > > [  143.392554]  bpf_inode_storage_delete+0x57/0xa0
> > > [  143.393112]  bpf_prog_31e277fe2c132665_inode_rename+0x9c/0x268
> > > [  143.393814]  bpf_trampoline_6442476301_0+0x4e/0x1000
> > > [  143.394413]  bpf_lsm_inode_rename+0x5/0x10
> >
> > I am not sure what line 114 is (it is a blank line in bpf-next), but
> > you might be missing a rcu_read_lock_trace_held() in the second argumen=
t
> > of rcu_dereference_check().
> Right, this path is only under rcu_read_lock_trace().
