Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18B346FAA
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 03:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhCXCmS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 22:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231262AbhCXClt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 22:41:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A253A61934;
        Wed, 24 Mar 2021 02:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616553708;
        bh=etCAh9rEROjUNBI30Yeq7rdsCZVdAN+B38f2I+ec2MQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SSYMrBKVIvJgML8TVPgY+XmClYA8gOgD89PjExc6N6ddY7e6Muan7blE4ne/1hsNs
         ze5rFPC9urng+U1R55pLNmQ3Rpr8F/aYr+JnjY9ao5I23m8YpnjY5HPnTOSWjDu0/t
         RyiqxGNrVRmC/++blY77GPaNRptIA6EAiAdpDt0wX6Fkzd2+I6auWrSgQfC5vZFJAy
         RyVmd/MfI0+/9CtkFf4MFfwyGSjo61GrWFD6Y7EoDRnjmAo0JgvQtkI7UUQ/bKMzuS
         jt+Mb8wMv4HajvU0KQPiUUJOgVLPKMP4gpKXjf6VQmpNhnBH5jGUXcA7erfEsoYlLq
         yfVKx+kTKDs4w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5A40535239D9; Tue, 23 Mar 2021 19:41:48 -0700 (PDT)
Date:   Tue, 23 Mar 2021 19:41:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in synchronize_rcu_tasks()
 on PREEMPT kernels
Message-ID: <20210324024148.GG2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <877dly6ooz.fsf@toke.dk>
 <20210323164315.GY2696@paulmck-ThinkPad-P72>
 <871rc57p8g.fsf@toke.dk>
 <20210323175716.GB2696@paulmck-ThinkPad-P72>
 <87y2ed645n.fsf@toke.dk>
 <CAEf4Bzap-8uTFS=dJjq7o+g=e=5PvyD3_1TpnhmmoVuP0SUjjQ@mail.gmail.com>
 <87r1k560p9.fsf@toke.dk>
 <20210323215247.GD2696@paulmck-ThinkPad-P72>
 <87lfad5xv7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfad5xv7.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 23, 2021 at 11:06:04PM +0100, Toke Høiland-Jørgensen wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Tue, Mar 23, 2021 at 10:04:50PM +0100, Toke Høiland-Jørgensen wrote:
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >> 
> >> > On Tue, Mar 23, 2021 at 12:52 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >> >>
> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
> >> >>
> >> >> > On Tue, Mar 23, 2021 at 06:29:35PM +0100, Toke Høiland-Jørgensen wrote:
> >> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
> >> >> >>
> >> >> >> > On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke Høiland-Jørgensen wrote:
> >> >> >> >> Hi Paul
> >> >> >> >>
> >> >> >> >> Magnus and I have been debugging an issue where close() on a bpf_link
> >> >> >> >> file descriptor would hang indefinitely when the system was under load
> >> >> >> >> on a kernel compiled with CONFIG_PREEMPT=y, and it seems to be related
> >> >> >> >> to synchronize_rcu_tasks(), so I'm hoping you can help us with it.
> >> >> >> >>
> >> >> >> >> The issue is triggered reliably by loading up a system with network
> >> >> >> >> traffic (causing 100% softirq CPU load on one or more cores), and then
> >> >> >> >> attaching an freplace bpf_link and closing it again. The close() will
> >> >> >> >> hang until the network traffic load is lowered.
> >> >> >> >>
> >> >> >> >> Digging further, it appears that the hang happens in
> >> >> >> >> synchronize_rcu_tasks(), as seen by running a bpftrace script like:
> >> >> >> >>
> >> >> >> >> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start = nsecs; printf("enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit after %d ms\n", (nsecs - @start) / 1000000); }'
> >> >> >> >> Attaching 2 probes...
> >> >> >> >> enter
> >> >> >> >> exit after 54 ms
> >> >> >> >> enter
> >> >> >> >> exit after 3249 ms
> >> >> >> >>
> >> >> >> >> (the two enter/exit pairs are, respectively, from an unloaded system,
> >> >> >> >> and from a loaded system where I stopped the network traffic after a
> >> >> >> >> couple of seconds).
> >> >> >> >>
> >> >> >> >> The call to synchronize_rcu_tasks() happens in bpf_trampoline_put():
> >> >> >> >>
> >> >> >> >> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/trampoline.c#L376
> >> >> >> >>
> >> >> >> >> And because it does this while holding trampoline_mutex, even deferring
> >> >> >> >> the put to a worker (as a previously applied-then-reverted patch did[0])
> >> >> >> >> doesn't help: that'll fix the initial hang on close(), but any
> >> >> >> >> subsequent use of BPF trampolines will then be blocked because of the
> >> >> >> >> mutex.
> >> >> >> >>
> >> >> >> >> Also, if I just keep the network traffic running I will eventually get a
> >> >> >> >> kernel panic with:
> >> >> >> >>
> >> >> >> >> kernel:[44348.426312] Kernel panic - not syncing: hung_task: blocked tasks
> >> >> >> >>
> >> >> >> >> I've created a reproducer for the issue here:
> >> >> >> >> https://github.com/xdp-project/bpf-examples/tree/master/bpf-link-hang
> >> >> >> >>
> >> >> >> >> To compile simply do this (needs a recent llvm/clang for compiling the BPF program):
> >> >> >> >>
> >> >> >> >> $ git clone --recurse-submodules https://github.com/xdp-project/bpf-examples
> >> >> >> >> $ cd bpf-examples/bpf-link-hang
> >> >> >> >> $ make
> >> >> >> >> $ ./sudo bpf-link-hang
> >> >> >> >>
> >> >> >> >> you'll need to load up the system to trigger the hang; I'm using pktgen
> >> >> >> >> from a separate machine to do this.
> >> >> >> >>
> >> >> >> >> My question is, of course, as ever, What Is To Be Done? Is it expected
> >> >> >> >> that synchronize_rcu_tasks() can hang indefinitely on a PREEMPT system,
> >> >> >> >> or can this be fixed? And if it is expected, how can the BPF code be
> >> >> >> >> fixed so it doesn't deadlock because of this?
> >> >> >> >>
> >> >> >> >> Hoping you can help us with this - many thanks in advance! :)
> >> >> >> >
> >> >> >> > Let me start with the usual question...  Is the network traffic intense
> >> >> >> > enough that one of the CPUs might remain in a loop handling softirqs
> >> >> >> > indefinitely?
> >> >> >>
> >> >> >> Yup, I'm pegging all CPUs in softirq:
> >> >> >>
> >> >> >> $ mpstat -P ALL 1
> >> >> >> [...]
> >> >> >> 18:26:52     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> >> >> >> 18:26:53     all    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> >> >> >> 18:26:53       0    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> >> >> >> 18:26:53       1    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> >> >> >> 18:26:53       2    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> >> >> >> 18:26:53       3    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> >> >> >> 18:26:53       4    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> >> >> >> 18:26:53       5    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> >> >> >>
> >> >> >> > If so, does the (untested, probably does not build) patch below help?
> >> >> >>
> >> >> >> Doesn't appear to, no. It builds fine, but I still get:
> >> >> >>
> >> >> >> Attaching 2 probes...
> >> >> >> enter
> >> >> >> exit after 8480 ms
> >> >> >>
> >> >> >> (that was me interrupting the network traffic again)
> >> >> >
> >> >> > Is your kernel properly shifting from back-of-interrupt softirq processing
> >> >> > to ksoftirqd under heavy load?  If not, my patch will not have any
> >> >> > effect.
> >> >>
> >> >> Seems to be - this is from top:
> >> >>
> >> >>      12 root      20   0       0      0      0 R  99.3   0.0   0:43.64 ksoftirqd/0
> >> >>      24 root      20   0       0      0      0 R  99.3   0.0   0:43.62 ksoftirqd/2
> >> >>      34 root      20   0       0      0      0 R  99.3   0.0   0:43.64 ksoftirqd/4
> >> >>      39 root      20   0       0      0      0 R  99.3   0.0   0:43.65 ksoftirqd/5
> >> >>      19 root      20   0       0      0      0 R  99.0   0.0   0:43.63 ksoftirqd/1
> >> >>      29 root      20   0       0      0      0 R  99.0   0.0   0:43.63 ksoftirqd/3
> >> >>
> >> >> Any other ideas? :)
> >> >
> >> > bpf_trampoline_put() got significantly changed by e21aa341785c ("bpf:
> >> > Fix fexit trampoline. "), it doesn't do synchronize_rcu_tasks()
> >> > anymore. Please give it a try. It's in bpf tree.
> >> 
> >> Ah! I had missed that patch, and only tested this on bpf-next. Yes, that
> >> indeed works better; awesome!
> >> 
> >> And sorry for bothering you with this, Paul; guess I should have looked
> >> harder for fixes first... :/
> >
> > Glad it is now working!
> >
> > And in any case, my patch needed an s/true/false/.  :-/
> >
> > Hey, I did say "untested"!  ;-)
> 
> Haha, right, well at least you run afoul of the 'truth in advertising'
> committee ;)

If you get a chance, could you please test the (hopefully) corrected
patch shown below?  This issue might affect other use cases.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0b06be5..e21e7b0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -242,6 +242,7 @@ void rcu_softirq_qs(void)
 {
 	rcu_qs();
 	rcu_preempt_deferred_qs(current);
+	rcu_tasks_qs(current, false);
 }
 
 /*
