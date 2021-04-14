Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A6835FD43
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 23:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhDNVZZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 17:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232559AbhDNVZY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 17:25:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C13AD61155;
        Wed, 14 Apr 2021 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618435502;
        bh=jZIX9LrM0id9K+Xt+PCBTE3R8mFcr0lcJUfT2FcH2CQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TsS+XDDpLesMAlkm153mt4faQ1RD1g/J/Ee2UKX9nqbG1dE6RdKECrhY5LU1sDJzt
         Qjr9ehiPC0jdqMXxY7i76yzlRUZ99pIOp5LbvETz6Ss8oTrQUeg04bUq+jJsJyQzuN
         c49WGJW4Nw/eC8NSkxpCAXGAOps+7gOXUHMNpTgH4ZYd/VqxVKuHYYqqRbNB4iNvKc
         mq3M7DdxNVk/yMWSzmtti1q6jWZEbtF59kgCKVQki/tnuNK7xUMU+HD5CEy085yPBW
         IOvdKJtDvpMkzigo5NvONM/sp+L5CxK0aqXawKC4EvlwjcjAAKIg3KwGl8xcDed3Bj
         dbGVctpfr6T4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 93FB85C26C5; Wed, 14 Apr 2021 14:25:02 -0700 (PDT)
Date:   Wed, 14 Apr 2021 14:25:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
Message-ID: <20210414212502.GX4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk>
 <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
 <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
 <20210414181934.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <87czuwlnhz.fsf@toke.dk>
 <20210414184133.GW4510@paulmck-ThinkPad-P17-Gen-1>
 <87a6q0llou.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6q0llou.fsf@toke.dk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 09:18:09PM +0200, Toke Høiland-Jørgensen wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Wed, Apr 14, 2021 at 08:39:04PM +0200, Toke Høiland-Jørgensen wrote:
> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
> >> 
> >> > On Wed, Apr 14, 2021 at 10:59:23AM -0700, Alexei Starovoitov wrote:
> >> >> On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >> >> >
> >> >> > > > > >                 if (num_online_cpus() > 1)
> >> >> > > > > >                         synchronize_rcu();
> >> >> >
> >> >> > In CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y kernels, this
> >> >> > synchronize_rcu() will be a no-op anyway due to there only being the
> >> >> > one CPU.  Or are these failures all happening in CONFIG_PREEMPT=y kernels,
> >> >> > and in tests where preemption could result in the observed failures?
> >> >> >
> >> >> > Could you please send your .config file, or at least the relevant portions
> >> >> > of it?
> >> >> 
> >> >> That's my understanding as well. I assumed Toke has preempt=y.
> >> >> Otherwise the whole thing needs to be root caused properly.
> >> >
> >> > Given that there is only a single CPU, I am still confused about what
> >> > the tests are expecting the membarrier() system call to do for them.
> >> 
> >> It's basically a proxy for waiting until the objects are freed on the
> >> kernel side, as far as I understand...
> >
> > There are in-kernel objects that are freed via call_rcu(), and the idea
> > is to wait until these objects really are freed?  Or am I still missing
> > out on what is going on?
> 
> Something like that? Although I'm not actually sure these are using
> call_rcu()? One of them needs __put_task_struct() to run, and the other
> waits for map freeing, with this comment:
> 
> 
> 	/* we need to either wait for or force synchronize_rcu(), before
> 	 * checking for "still exists" condition, otherwise map could still be
> 	 * resolvable by ID, causing false positives.
> 	 *
> 	 * Older kernels (5.8 and earlier) freed map only after two
> 	 * synchronize_rcu()s, so trigger two, to be entirely sure.
> 	 */
> 	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
> 	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");

OK, so the issue is that the membarrier() system call is designed to force
ordering only within a user process, and you need it in the kernel.

Give or take my being puzzled as to why the membarrier() system call
doesn't do it for you on a CONFIG_PREEMPT_NONE=y system, this brings
us back to the question Alexei asked me in the first place, what is the
best way to invoke an in-kernel synchronize_rcu() from userspace?

You guys gave some reasonable examples.  Here are a few others:

o	Bring a CPU online, then force it offline, or vice versa.
	But in this case, sys_membarrier() would do what you need
	given more than one CPU.

o	Use the membarrier() system call, but require that the tests
	run on systems with at least two CPUs.

o	Create a kernel module whose init function does a
	synchronize_rcu() and then returns failure.  This will
	avoid the overhead of removing that kernel module.

o	Create a sysfs or debugfs interface that does a
	synchronize_rcu().

But I am still concerned that you are needing more than synchronize_rcu()
can do.  Otherwise, the membarrier() system call would work just fine
on a single CPU on your CONFIG_PREEMPT_VOLUNTARY=y kernel.

							Thanx, Paul
