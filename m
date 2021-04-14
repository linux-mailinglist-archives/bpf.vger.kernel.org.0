Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791FF35FA1C
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 19:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351204AbhDNRxH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 13:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346877AbhDNRxH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 13:53:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 870EB611F0;
        Wed, 14 Apr 2021 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618422765;
        bh=3IVc4wXIQsj7hVTsYsAQNod3SbVrea1MT3/PXRHaXFQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sxiG96CSEAQ8jD980syW0vsATPjPH34N9RGeCEcz+CCw1wkYieXV7wzxDhx6YgypX
         UdWvuxGKxzjPqnvVxkRjqGrSf6l3jCKBgQrrhAcBtQtVWDxg8GxyUk2jUsZVXOQ00/
         yDBiS9m4RUKntL+yi4Y1n6h4NM4aQhwVyk9WJSSweXzSVeRFoGKD+a2c0mo3O5Abuw
         W56PyMIuAuVfS6/PjM0k0d2pu+EEOfq742wFVnvGu3PaI8fmnaKkMPDFQmS83tRXe/
         Q4py306Ks4fYD+rjqSfHbBvkiO8RLqWOQJ02QGkXhvSsgkFiiVrH4KO9K58atk7txG
         rM1J6N/wtH0uQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 481645C034B; Wed, 14 Apr 2021 10:52:45 -0700 (PDT)
Date:   Wed, 14 Apr 2021 10:52:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
Message-ID: <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87blaozi20.fsf@toke.dk>
 <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk>
 <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 08:54:03AM -0700, Alexei Starovoitov wrote:
> On Tue, Apr 13, 2021 at 11:58 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Apr 13, 2021 at 1:50 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > >
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> > >
> > > > On Thu, Apr 8, 2021 at 12:34 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > > >>
> > > >> Hi Andrii
> > > >>
> > > >> I'm getting some selftest failures that all seem to have something to do
> > > >> with kern_sync_rcu() not being enough to trigger the kernel events that
> > > >> the selftest expects:
> > > >>
> > > >> $ ./test_progs | grep FAIL
> > > >> test_lookup_update:FAIL:map1_leak inner_map1 leaked!
> > > >> #15/1 lookup_update:FAIL
> > > >> #15 btf_map_in_map:FAIL
> > > >> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual 0 == expected 0

You lost me on this one.  If actual equals expected, why the failure?
Or is this a case where the test need to capture the value so as to
compare and print the same thing?

> > > >> #123/2 exit_creds:FAIL
> > > >> #123 task_local_storage:FAIL
> > > >> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual 0 == expected 0

Same for this one.

> > > >> #123/2 exit_creds:FAIL
> > > >> #123 task_local_storage:FAIL
> > > >>
> > > >> They are all fixed by adding a sleep(1) after the call(s) to
> > > >> kern_sync_rcu(), so I'm guessing it's some kind of
> > > >> timing/synchronisation problem. Is there a particular kernel config
> > > >> that's needed for the membarrier syscall trick to work? I've tried with
> > > >> various settings of PREEMPT and that doesn't really seem to make any
> > > >> difference...
> > > >>
> > > >
> > > > If you check kern_sync_rcu(), it relies on membarrier() syscall
> > > > (passing cmd = MEMBARRIER_CMD_SHARED == MEMBARRIER_CMD_GLOBAL).
> > > > Now, looking at kernel sources:
> > > >   - CONFIG_MEMBARRIER should be enabled for that syscall;
> > > >   - it has some extra conditions:
> > > >
> > > >            case MEMBARRIER_CMD_GLOBAL:
> > > >                 /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full. */
> > > >                 if (tick_nohz_full_enabled())
> > > >                         return -EINVAL;

This one has effect only in kernels built with CONFIG_NO_HZ_FULL=y.

The reason for this check is that RCU sees nohz_full userspace execution
the same as it sees idle, so a synchronize_rcu() is not (repeat, not)
guaranteed to provide order across any of the nohz_full userspace threads.
This lack of guarantee applies to all CONFIG_NO_HZ_FULL=y kernel builds
and to all userspace threads running on nohz_full CPUs.

So if you build your kernel with CONFIG_NO_HZ_FULL=y, and boot with
nohz_full=2-7, then the membarrier() system call has no way of providing
ordering to userspace threads running on CPUs 2, 3, 4, 5, 6, and 7.

Hence the -EINVAL.

In theory, we could use SRCU or similar, but there is much about the
interaction of membarrier() and the entry/exit code that I have long
since forgotten, so in practice, who knows?

Also in practice, in a CONFIG_PREEMPT=y kernel, synchronize_rcu() will
impose some delay, and that delay might well be sufficient to trick the
tests into passing, despite the fact that there is no guarantee.

> > > >                 if (num_online_cpus() > 1)
> > > >                         synchronize_rcu();

In CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y kernels, this
synchronize_rcu() will be a no-op anyway due to there only being the
one CPU.  Or are these failures all happening in CONFIG_PREEMPT=y kernels,
and in tests where preemption could result in the observed failures?

Could you please send your .config file, or at least the relevant portions
of it?

> > > >                 return 0;
> > > >
> > > > Could it be that one of those conditions is not satisfied?
> > >
> > > Aha, bingo! Found the membarrier syscall stuff, but for some reason
> > > didn't think to actually read the code of it; and I was running this in
> > > a VM with a single CPU, adding another fixed this. Thanks! :)
> > >
> > > Do you think we could detect this in the tests? I suppose the
> > > tick_nohz_full_enabled() check should already result in a visible
> > > failure since that makes the syscall fail; but the CPU thing is silent,
> > > so it would be nice with a hint. Could kern_sync_rcu() check the CPU
> > > count and print a warning or fail if it is 1? Or maybe just straight up
> > > fall back to sleep()'ing?

Given that you have but one CPU, things are pretty well ordered.
Of course, userspace code can be preempted even in CONFIG_PREEMPT_NONE=y
kernels, but in that case synchronize_rcu() won't add any delays.

At this point, I am a bit confused about what is going on here.

> > If membarrier() is unreliable, I guess we can just go back to the
> > previous way of triggering synchronize_rcu() (create and update
> > map-in-map element)? See 635599bace25 ("selftests/bpf: Sync RCU before
> > unloading bpf_testmod") that removed that in favor of membarrier()
> > syscall.
> 
> maybe create+free socket_local_storage map ? Few syscalls less.
> I guess map_in_map is fine too.
> 
> Paul,
> What do you suggest to trigger synchronize_rcu() from user space?

My first suggestion is to make sure that we understand the problem.
Maybe it is only me who is confused, but in that case please unconfuse me.

							Thanx, Paul
