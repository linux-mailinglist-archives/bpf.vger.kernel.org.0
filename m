Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0D35FDC6
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 00:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhDNW2D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 18:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhDNW2B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 18:28:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08A196109E;
        Wed, 14 Apr 2021 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618439260;
        bh=caSHuvV0GB6uHNpKGaWObpI+uG87KsIQsQHPNdSbm3I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vq3pFcHNUBlnTFZKbIbLX3rb+khHKm+oVOuR6jKOzc0Sswm3AkH2ql5a0e5Qq+7sm
         AzGWgWZuFmiFK66nlmkE+jZmKvONyH3vG8DR5dZt9YsONCCzqU6rmZnPgHYW0hwx/8
         u05esKGQSzcUXWtHn80aSn9tc4PQjjRMpauN3fl4XYqs299Sd756mBLZQJ17iS7wfG
         WIA3xtQeVcKDvUVYaoup0O7/VtypKnuGtmtOxk3EQxu22+6ztGDc0Ra5uUllqb374i
         dYJedBBZ0cNTdWE87yflL9xhTXJ66zfTiWO9+HWoAAetnNsnKn/3hPd8UIG4ygVpab
         /aRHk1Gy7UWuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BFE465C2738; Wed, 14 Apr 2021 15:27:39 -0700 (PDT)
Date:   Wed, 14 Apr 2021 15:27:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
Message-ID: <20210414222739.GY4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
 <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
 <20210414181934.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <87czuwlnhz.fsf@toke.dk>
 <20210414184133.GW4510@paulmck-ThinkPad-P17-Gen-1>
 <87a6q0llou.fsf@toke.dk>
 <20210414212502.GX4510@paulmck-ThinkPad-P17-Gen-1>
 <CAEf4BzZ=oFbTaS2DPOry8jbunb2Qtu4omF3VsYMNJ5_8VNHoQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ=oFbTaS2DPOry8jbunb2Qtu4omF3VsYMNJ5_8VNHoQw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 03:13:38PM -0700, Andrii Nakryiko wrote:
> On Wed, Apr 14, 2021 at 2:25 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Apr 14, 2021 at 09:18:09PM +0200, Toke Høiland-Jørgensen wrote:
> > > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > >
> > > > On Wed, Apr 14, 2021 at 08:39:04PM +0200, Toke Høiland-Jørgensen wrote:
> > > >> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > > >>
> > > >> > On Wed, Apr 14, 2021 at 10:59:23AM -0700, Alexei Starovoitov wrote:
> > > >> >> On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >> >> >
> > > >> >> > > > > >                 if (num_online_cpus() > 1)
> > > >> >> > > > > >                         synchronize_rcu();
> > > >> >> >
> > > >> >> > In CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y kernels, this
> > > >> >> > synchronize_rcu() will be a no-op anyway due to there only being the
> > > >> >> > one CPU.  Or are these failures all happening in CONFIG_PREEMPT=y kernels,
> > > >> >> > and in tests where preemption could result in the observed failures?
> > > >> >> >
> > > >> >> > Could you please send your .config file, or at least the relevant portions
> > > >> >> > of it?
> > > >> >>
> > > >> >> That's my understanding as well. I assumed Toke has preempt=y.
> > > >> >> Otherwise the whole thing needs to be root caused properly.
> > > >> >
> > > >> > Given that there is only a single CPU, I am still confused about what
> > > >> > the tests are expecting the membarrier() system call to do for them.
> > > >>
> > > >> It's basically a proxy for waiting until the objects are freed on the
> > > >> kernel side, as far as I understand...
> > > >
> > > > There are in-kernel objects that are freed via call_rcu(), and the idea
> > > > is to wait until these objects really are freed?  Or am I still missing
> > > > out on what is going on?
> > >
> > > Something like that? Although I'm not actually sure these are using
> > > call_rcu()? One of them needs __put_task_struct() to run, and the other
> > > waits for map freeing, with this comment:
> > >
> > >
> > >       /* we need to either wait for or force synchronize_rcu(), before
> > >        * checking for "still exists" condition, otherwise map could still be
> > >        * resolvable by ID, causing false positives.
> > >        *
> > >        * Older kernels (5.8 and earlier) freed map only after two
> > >        * synchronize_rcu()s, so trigger two, to be entirely sure.
> > >        */
> > >       CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
> > >       CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
> >
> > OK, so the issue is that the membarrier() system call is designed to force
> > ordering only within a user process, and you need it in the kernel.
> >
> > Give or take my being puzzled as to why the membarrier() system call
> > doesn't do it for you on a CONFIG_PREEMPT_NONE=y system, this brings
> > us back to the question Alexei asked me in the first place, what is the
> > best way to invoke an in-kernel synchronize_rcu() from userspace?
> >
> > You guys gave some reasonable examples.  Here are a few others:
> >
> > o       Bring a CPU online, then force it offline, or vice versa.
> >         But in this case, sys_membarrier() would do what you need
> >         given more than one CPU.
> >
> > o       Use the membarrier() system call, but require that the tests
> >         run on systems with at least two CPUs.
> >
> > o       Create a kernel module whose init function does a
> >         synchronize_rcu() and then returns failure.  This will
> >         avoid the overhead of removing that kernel module.
> >
> > o       Create a sysfs or debugfs interface that does a
> >         synchronize_rcu().
> >
> > But I am still concerned that you are needing more than synchronize_rcu()
> > can do.  Otherwise, the membarrier() system call would work just fine
> > on a single CPU on your CONFIG_PREEMPT_VOLUNTARY=y kernel.
> 
> Selftests know internals of kernel implementation and wait for some
> objects to be freed with call_rcu(). So I think at this point the best
> way is just to go back to map-in-map or socket local storage.
> Map-in-map will probably work on older kernels, so I'd stick with that
> (plus all the code is there in the referenced commit). The performance
> and number of syscalls performed doesn't matter, really.

Ah!  If they need to wait for objects to be freed with call_rcu(), then
they need to make the kernel execute an rcu_barrier().  One way to make
this happen is to unmount an ext4 filesystem.  This would explain why
the membarrier() system call wasn't doing the job on single-CPU systems
even in kernels built with CONFIG_PREEMPT_VOLUNTARY=y.

But if you have a more direct way to wait the required period of time,
so much the better!

							Thanx, Paul
