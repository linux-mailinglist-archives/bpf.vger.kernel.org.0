Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E811346708
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhCWR5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 13:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhCWR5R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 13:57:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9342A619AE;
        Tue, 23 Mar 2021 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616522236;
        bh=6qr9liF8XDzb0zCTqB6ZubSAXzS8AezMkMJCER8nTMQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VvI1adkA5Vsg5VpY0BUml8ezk0uIefqc2J4RAV/uswS2UlmaJJBAQcX5jEQ6E8uQs
         1q5xXYCLeZhlxOS7mAslpc5LLmdpw2AUzN47BT+8zGTlf1B7EW8clWshb8PgUBFjoA
         QG7OoOddHuuD4ZqT+qJsgSqdqc0R9F90cGIvAfOsCNEYmfDVt2Nwup9kRIK/47aDlk
         iEtRbqrpCtyTqYc0r9o1t4QdTJqx9ahfbgBQbLObUy33038USUM1HUDxgM89Vx/SIm
         47az2Pmwgb2EPphW3TCUtKNl5odQNsoy4lZccTSIbaWQNWROCGs/kCPC5mluqQ0Eq/
         0pUBjy1gu0JDg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4BA83352261C; Tue, 23 Mar 2021 10:57:16 -0700 (PDT)
Date:   Tue, 23 Mar 2021 10:57:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in synchronize_rcu_tasks()
 on PREEMPT kernels
Message-ID: <20210323175716.GB2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <877dly6ooz.fsf@toke.dk>
 <20210323164315.GY2696@paulmck-ThinkPad-P72>
 <871rc57p8g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rc57p8g.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 23, 2021 at 06:29:35PM +0100, Toke Høiland-Jørgensen wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke Høiland-Jørgensen wrote:
> >> Hi Paul
> >> 
> >> Magnus and I have been debugging an issue where close() on a bpf_link
> >> file descriptor would hang indefinitely when the system was under load
> >> on a kernel compiled with CONFIG_PREEMPT=y, and it seems to be related
> >> to synchronize_rcu_tasks(), so I'm hoping you can help us with it.
> >> 
> >> The issue is triggered reliably by loading up a system with network
> >> traffic (causing 100% softirq CPU load on one or more cores), and then
> >> attaching an freplace bpf_link and closing it again. The close() will
> >> hang until the network traffic load is lowered.
> >> 
> >> Digging further, it appears that the hang happens in
> >> synchronize_rcu_tasks(), as seen by running a bpftrace script like:
> >> 
> >> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start = nsecs; printf("enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit after %d ms\n", (nsecs - @start) / 1000000); }'
> >> Attaching 2 probes...
> >> enter
> >> exit after 54 ms
> >> enter
> >> exit after 3249 ms
> >> 
> >> (the two enter/exit pairs are, respectively, from an unloaded system,
> >> and from a loaded system where I stopped the network traffic after a
> >> couple of seconds).
> >> 
> >> The call to synchronize_rcu_tasks() happens in bpf_trampoline_put():
> >> 
> >> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/trampoline.c#L376
> >> 
> >> And because it does this while holding trampoline_mutex, even deferring
> >> the put to a worker (as a previously applied-then-reverted patch did[0])
> >> doesn't help: that'll fix the initial hang on close(), but any
> >> subsequent use of BPF trampolines will then be blocked because of the
> >> mutex.
> >> 
> >> Also, if I just keep the network traffic running I will eventually get a
> >> kernel panic with:
> >> 
> >> kernel:[44348.426312] Kernel panic - not syncing: hung_task: blocked tasks
> >> 
> >> I've created a reproducer for the issue here:
> >> https://github.com/xdp-project/bpf-examples/tree/master/bpf-link-hang
> >> 
> >> To compile simply do this (needs a recent llvm/clang for compiling the BPF program):
> >> 
> >> $ git clone --recurse-submodules https://github.com/xdp-project/bpf-examples
> >> $ cd bpf-examples/bpf-link-hang
> >> $ make
> >> $ ./sudo bpf-link-hang
> >> 
> >> you'll need to load up the system to trigger the hang; I'm using pktgen
> >> from a separate machine to do this.
> >> 
> >> My question is, of course, as ever, What Is To Be Done? Is it expected
> >> that synchronize_rcu_tasks() can hang indefinitely on a PREEMPT system,
> >> or can this be fixed? And if it is expected, how can the BPF code be
> >> fixed so it doesn't deadlock because of this?
> >> 
> >> Hoping you can help us with this - many thanks in advance! :)
> >
> > Let me start with the usual question...  Is the network traffic intense
> > enough that one of the CPUs might remain in a loop handling softirqs
> > indefinitely?
> 
> Yup, I'm pegging all CPUs in softirq:
> 
> $ mpstat -P ALL 1
> [...]
> 18:26:52     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 18:26:53     all    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> 18:26:53       0    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> 18:26:53       1    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> 18:26:53       2    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> 18:26:53       3    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> 18:26:53       4    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> 18:26:53       5    0.00    0.00    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00
> 
> > If so, does the (untested, probably does not build) patch below help?
> 
> Doesn't appear to, no. It builds fine, but I still get:
> 
> Attaching 2 probes...
> enter
> exit after 8480 ms
> 
> (that was me interrupting the network traffic again)

Is your kernel properly shifting from back-of-interrupt softirq processing
to ksoftirqd under heavy load?  If not, my patch will not have any effect.

							Thanx, Paul
