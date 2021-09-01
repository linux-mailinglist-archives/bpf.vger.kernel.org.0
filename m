Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE253FE3F6
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 22:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhIAU1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 16:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhIAU1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 16:27:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 372E560FDC;
        Wed,  1 Sep 2021 20:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630527966;
        bh=h/pTKdipLoGqkHogLtH2CPsnKI+TKRD795FcQjQYa0E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aunVUXLNnmjt5t7VN44umS9n32TAWorvljtv8XVQdJzd922dAoH6Ns9ywlCcTkXan
         wrIhSo6oswkR5kbXmzOP/xEkwM0OS2UAghlOomB333fBC3lH2yxhl899YFwMDR7F8+
         SsjefaH26avmBAnI9S2t4rs2KU0EZasxVph+RZGXBUIqzeYGAgLqZFsflDed+ooKTo
         sd2FFgyWFCEviZnm6w+JLDAQYMPUHtwA48/3wVgG1lJb5LwG8c4cfSss8N5uQTE2GM
         Ji9d5ke0pVok9j3GqYigvV2jeVoZ7wddyYhACQ+K2xxZN6WoBABAOTfl3gtRcottB6
         JqLm3XrnUrlIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EF3A25C0DDE; Wed,  1 Sep 2021 13:26:05 -0700 (PDT)
Date:   Wed, 1 Sep 2021 13:26:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210826235127.303505-1-kpsingh@kernel.org>
 <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
 <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 11:32:17PM -0700, Martin KaFai Lau wrote:
> On Tue, Aug 31, 2021 at 09:38:01PM +0200, KP Singh wrote:
> [ ... ]
> 
> > > > > > > > @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > > > > > > >           SDATA(selem))
> > > > > > > >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> > > > > > > >
> > > > > > > > -     kfree_rcu(selem, rcu);
> > > > > > > > +     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > > > > > Although the common use case is usually storage_get() much more often
> > > > > > > than storage_delete(), do you aware any performance impact for
> > > > > > > the bpf prog that does a lot of storage_delete()?
> > > > > >
> > > > > > I have not really measured the impact on deletes, My understanding is
> > > > > > that it should
> > > > > > not impact the BPF program, but yes, if there are some critical
> > > > > > sections that are prolonged
> > > > > > due to a sleepable program "sleeping" too long, then it would pile up
> > > > > > the callbacks.
> > > > > >
> > > > > > But this is not something new, as we have a similar thing in BPF
> > > > > > trampolines. If this really
> > > > > > becomes an issue, we could add a flag BPF_F_SLEEPABLE_STORAGE and only maps
> > > > > > with this flag would be allowed in sleepable progs.
> > > > > Agree that is similar to trampoline updates but not sure it is comparable
> > > > > in terms of the frequency of elems being deleted here.  e.g. many
> > > > > short lived tcp connections created by external traffic.
> > > > >
> > > > > Adding a BPF_F_SLEEPABLE_STORAGE later won't work.  It will break
> > > > > existing sleepable bpf prog.
> > > > >
> > > > > I don't know enough on call_rcu_tasks_trace() here, so the
> > > > > earlier question on perf/callback-pile-up implications in order to
> > > > > decide if extra logic or knob is needed here or not.
> > > >
> > > > I will defer to the others, maybe Alexei and Paul,
> > >
> > > > we could also just
> > > > add the flag to not affect existing performance characteristics?
> > > I would see if it is really necessary first.  Other sleepable
> > > supported maps do not need a flag.  Adding one here for local
> > > storage will be confusing especially if it turns out to be
> > > unnecessary.
> > >
> > > Could you run some tests first which can guide the decision?
> > 
> > I think the performance impact would happen only in the worst case which
> > needs some work to simulate. What do you think about:
> > 
> > A bprm_committed_creds program that processes a large argv
> > and also gets a storage on the inode.
> > 
> > A file_open program that tries to delete the local storage on the inode.
> > 
> > Trigger this code in parallel. i.e. lots of programs that execute with a very
> > large argv and then in parallel the executable being opened to trigger the
> > delete.
> > 
> > Do you have any other ideas? Is there something we could re-use from
> > the selftests?
> 
> There is a bench framework in tools/testing/selftests/bpf/benchs/
> that has a parallel thread setup which could be useful.
> 
> Don't know how to simulate the "sleeping" too long which
> then pile-up callbacks.  This is not bpf specific.
> Paul, I wonder if you have similar test to trigger this to
> compare between call_rcu_tasks_trace() and call_rcu()?

It is definitely the case that call_rcu() is way more scalable than
is call_rcu_tasks_trace().  Something about call_rcu_tasks_trace()
acquiring a global lock. ;-)

So actually testing it makes a lot of sense.

I do have an rcuscale module, but it is set up more for synchronous grace
periods such as synchronize_rcu() and synchronize_rcu_tasks_trace().  It
has the beginnings of support for call_rcu() and call_rcu_tasks_trace(),
but I would not yet trust them.

But I also have a test for global locking:

$ tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs "NOPREEMPT" --kconfig "CONFIG_NR_CPUS=16" --bootargs "refscale.scale_type=lock refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make

This gives a median lock overhead of 960ns.  Running a single CPU rather
than 16 of them:

$ tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs "NOPREEMPT" --kconfig "CONFIG_NR_CPUS=16" --bootargs "refscale.scale_type=lock refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make

This gives a median lock overhead of 4.1ns, which is way faster.
And the greater the number of CPUs, the greater the lock overhead.

On the other hand, if each call to call_rcu_tasks_trace() involves a
fork()/exec() pair, I would be rather surprised if that global lock was
your bottleneck.

Of course, if call_rcu_tasks_trace() does prove to be a bottleneck,
there are of course things that can be done.

> [ ... ]
> 
> > > > > > > > @@ -213,7 +232,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> > > > > > > >       struct bpf_local_storage_elem *selem;
> > > > > > > >
> > > > > > > >       /* Fast path (cache hit) */
> > > > > > > > -     sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
> > > > > > > > +     sdata = rcu_dereference_protected(local_storage->cache[smap->cache_idx],
> > > > > > > > +                                       bpf_local_storage_rcu_lock_held());
> > > > > > > There are other places using rcu_dereference() also.
> > > > > > > e.g. in bpf_local_storage_update().
> > > > > > > Should they be changed also?
> > > > > >
> > > > > > From what I saw, the other usage of rcu_derference is in a nested
> > > > > > (w.r.t to the RCU section that in bpf_prog_enter/exit) RCU
> > > > > > read side critical section/rcu_read_{lock, unlock} so it should not be required.
> > > > > hmm... not sure what nested or not has to do here.
> > > > > It is likely we are talking different things.
> > > > >
> > > > Yeah, we were looking at different things.
> > > >
> > > > e.g. bpf_selem_unlink does not need to be changed as it is in
> > > > a rcu_read_lock.
> > > No.  It is not always under rcu_read_lock().  From the patch 2 test,
> > > it should have a splat either from bpf_inode_storage_delete()
> > > or bpf_sk_storage_delete(), depending on which one runs first.
> > 
> > I missed this one, but I wonder why it did not trigger a warning. The test does
> > exercise the delete and rcu_dereference should have warned me that I am not
> > holding an rcu_read_lock();
> hmm... not sure either.  may be some kconfigs that disabled rcu_read_lock_held()?
> I would also take a look at RCU_LOCKDEP_WARN().
> 
> I just quickly tried the patches to check:
> 
> [  143.376587] =============================
> [  143.377068] WARNING: suspicious RCU usage
> [  143.377541] 5.14.0-rc5-01271-g68e5bda2b18e #4966 Tainted: G           O
> [  143.378378] -----------------------------
> [  143.378857] kernel/bpf/bpf_local_storage.c:114 suspicious rcu_dereference_check() usage!
> [  143.379914]
> [  143.379914] other info that might help us debug this:
> [  143.379914]
> [  143.380838]
> [  143.380838] rcu_scheduler_active = 2, debug_locks = 1
> [  143.381602] 4 locks held by mv/1781:
> [  143.382025]  #0: ffff888121e7c438 (sb_writers#6){.+.+}-{0:0}, at: do_renameat2+0x2f5/0xa80
> [  143.383009]  #1: ffff88812ce68760 (&type->i_mutex_dir_key#5/1){+.+.}-{3:3}, at: lock_rename+0x1f4/0x250
> [  143.384144]  #2: ffffffff843fbc60 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x45/0x160
> [  143.385326]  #3: ffff88811d8348b8 (&storage->lock){..-.}-{2:2}, at: __bpf_selem_unlink_storage+0x7d/0x170
> [  143.386459]
> [  143.386459] stack backtrace:
> [  143.386983] CPU: 2 PID: 1781 Comm: mv Tainted: G           O      5.14.0-rc5-01271-g68e5bda2b18e #4966
> [  143.388071] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.el7.centos 04/01/2014
> [  143.389146] Call Trace:
> [  143.389446]  dump_stack_lvl+0x5b/0x82
> [  143.389901]  dump_stack+0x10/0x12
> [  143.390302]  lockdep_rcu_suspicious+0x15c/0x167
> [  143.390854]  bpf_selem_unlink_storage_nolock+0x2e1/0x6d0
> [  143.391501]  __bpf_selem_unlink_storage+0xb7/0x170
> [  143.392085]  bpf_selem_unlink+0x1b/0x30
> [  143.392554]  bpf_inode_storage_delete+0x57/0xa0
> [  143.393112]  bpf_prog_31e277fe2c132665_inode_rename+0x9c/0x268
> [  143.393814]  bpf_trampoline_6442476301_0+0x4e/0x1000
> [  143.394413]  bpf_lsm_inode_rename+0x5/0x10

I am not sure what line 114 is (it is a blank line in bpf-next), but
you might be missing a rcu_read_lock_trace_held() in the second argument
of rcu_dereference_check().

							Thanx, Paul

> > > > > > > > --- a/net/core/bpf_sk_storage.c
> > > > > > > > +++ b/net/core/bpf_sk_storage.c
> > > > > > > > @@ -13,6 +13,7 @@
> > > > > > > >  #include <net/sock.h>
> > > > > > > >  #include <uapi/linux/sock_diag.h>
> > > > > > > >  #include <uapi/linux/btf.h>
> > > > > > > > +#include <linux/rcupdate_trace.h>
> > > > > > > >
> > > > > > > >  DEFINE_BPF_STORAGE_CACHE(sk_cache);
> > > > > > > >
> > > > > > > > @@ -22,7 +23,8 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
> > > > > > > >       struct bpf_local_storage *sk_storage;
> > > > > > > >       struct bpf_local_storage_map *smap;
> > > > > > > >
> > > > > > > > -     sk_storage = rcu_dereference(sk->sk_bpf_storage);
> > > > > > > > +     sk_storage = rcu_dereference_protected(sk->sk_bpf_storage,
> > > > > > > > +                                            bpf_local_storage_rcu_lock_held());
> > > > > > > >       if (!sk_storage)
> > > > > > > >               return NULL;
> > > > > > > >
> > > > > > > > @@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> > > > > > > >  {
> > > > > > > >       struct bpf_local_storage_data *sdata;
> > > > > > > >
> > > > > > > > +     WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
> > > > > > > >       if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
> > > > > > > sk is protected by rcu_read_lock here.
> > > > > > > Is it always safe to access it with the rcu_read_lock_trace alone ?
> > > > > >
> > > > > > We don't dereference sk with an rcu_dereference though, is it still the case for
> > > > > > tracing and LSM programs? Or is it somehow implicity protected even
> > > > > > though we don't use rcu_dereference since that's just a READ_ONCE + some checks?
> > > > > e.g. the bpf_prog (currently run under rcu_read_lock()) may read the sk from
> > > > > req_sk->sk which I don't think the verifier will optimize it out, so as good
> > > > > as READ_ONCE(), iiuc.
> > > > >
> > > > > The sk here is obtained from the bpf_lsm_socket_* hooks?  Those sk should have
> > > > > a refcnt, right?  If that is the case, it should be good enough for now.
> > > >
> > > > The one passed in the arguments yes, but if you notice the discussion in
> > > >
> > > > https://lore.kernel.org/bpf/20210826133913.627361-1-memxor@gmail.com/T/#me254212a125516a6c5d2fbf349b97c199e66dce0
> > > >
> > > > one may also get an sk in LSM and tracing progs by pointer walking.
> > > Right.  There is pointer walking case.
> > > e.g. "struct request_sock __rcu *fastopen_rsk" in tcp_sock.
> > > I don't think it is possible for lsm to get a hold on tcp_sock
> > > but agree that other similar cases could happen.
> > >
> > > May be for now, in sleepable program, only allow safe sk ptr
> > > to be used in helpers that take sk PTR_TO_BTF_ID argument.
> > > e.g. sock->sk is safe in the test in patch 2.  The same should go for other
> > > storages like inode.  This needs verifier change.
> > >
> > 
> > Sorry, I may be missing some context. Do you mean wait for Yonghong's work?
> I don't think we have to wait.  Just saying Yonghong's work could fit
> well in this use case in the future.
> 
> > Or is there another way to update the verifier to recognize safe sk and inode
> > pointers?
> I was thinking specifically for this pointer walking case.
> Take a look at btf_struct_access().  It walks the struct
> in the verifier and figures out reading sock->sk will get
> a "struct sock *".  It marks the reg to PTR_TO_BTF_ID.
> This will allow the bpf prog to directly read from sk (e.g. sk->sk_num)
> or pass the sk to helper that takes a "struct sock *" pointer.
> Reading from any sk pointer is fine since it is protected by BPF_PROBE_MEM
> read.  However, we only allow the sk from sock->sk to be passed to the
> helper here because we only know this one is refcnt-ed.
> 
> Take a look at check_ptr_to_btf_access().  An individual verifier_ops 
> can also have its own btf_struct_access.  One possibility is
> to introduce a (new) PTR_TO_RDONLY_BTF_ID to mean it can only
> do BPR_PROBE_MEM read but cannot be used in helper.
