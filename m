Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A933A346595
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 17:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhCWQn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 12:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233267AbhCWQnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 12:43:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BC3161993;
        Tue, 23 Mar 2021 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616517796;
        bh=jmAUvBk81ral0mGgYjLPmNzTObzrf93U3y6qs2IPbPY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Gg35vmLCvc7fbrYmvEKfelCC2cpG759YXCxiyyA7gfBdfUpwacEpTa7itS26Yys4/
         DNvKXPY6tyNVAe+8qbcX37cxuxAPhhSmsmYrN3sQaUqPY7G6hTCzDDhugMNfn64rWv
         Xvep6jtvbooviJcB4agWvJnpHmAmG+kxR0XRUT2LxO6S48gUIIFDf3mDBr1jw7lFg7
         UI6yRrVYeGmmG0E5/Rdu9Z0Wa7S6SyHyYuXyRJN/sbMmUOtGTz1YO2NT/Cx+H08x88
         Ztvpkv7IgCDSSQ+dhclmHGK4yzVujdJY+UUGmJwNK0MxXNnFVtq6rHrPcGjE+exaFR
         xU6G8dQ8X6HAg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C573D352261C; Tue, 23 Mar 2021 09:43:15 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:43:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in synchronize_rcu_tasks()
 on PREEMPT kernels
Message-ID: <20210323164315.GY2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <877dly6ooz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dly6ooz.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke Høiland-Jørgensen wrote:
> Hi Paul
> 
> Magnus and I have been debugging an issue where close() on a bpf_link
> file descriptor would hang indefinitely when the system was under load
> on a kernel compiled with CONFIG_PREEMPT=y, and it seems to be related
> to synchronize_rcu_tasks(), so I'm hoping you can help us with it.
> 
> The issue is triggered reliably by loading up a system with network
> traffic (causing 100% softirq CPU load on one or more cores), and then
> attaching an freplace bpf_link and closing it again. The close() will
> hang until the network traffic load is lowered.
> 
> Digging further, it appears that the hang happens in
> synchronize_rcu_tasks(), as seen by running a bpftrace script like:
> 
> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start = nsecs; printf("enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit after %d ms\n", (nsecs - @start) / 1000000); }'
> Attaching 2 probes...
> enter
> exit after 54 ms
> enter
> exit after 3249 ms
> 
> (the two enter/exit pairs are, respectively, from an unloaded system,
> and from a loaded system where I stopped the network traffic after a
> couple of seconds).
> 
> The call to synchronize_rcu_tasks() happens in bpf_trampoline_put():
> 
> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/trampoline.c#L376
> 
> And because it does this while holding trampoline_mutex, even deferring
> the put to a worker (as a previously applied-then-reverted patch did[0])
> doesn't help: that'll fix the initial hang on close(), but any
> subsequent use of BPF trampolines will then be blocked because of the
> mutex.
> 
> Also, if I just keep the network traffic running I will eventually get a
> kernel panic with:
> 
> kernel:[44348.426312] Kernel panic - not syncing: hung_task: blocked tasks
> 
> I've created a reproducer for the issue here:
> https://github.com/xdp-project/bpf-examples/tree/master/bpf-link-hang
> 
> To compile simply do this (needs a recent llvm/clang for compiling the BPF program):
> 
> $ git clone --recurse-submodules https://github.com/xdp-project/bpf-examples
> $ cd bpf-examples/bpf-link-hang
> $ make
> $ ./sudo bpf-link-hang
> 
> you'll need to load up the system to trigger the hang; I'm using pktgen
> from a separate machine to do this.
> 
> My question is, of course, as ever, What Is To Be Done? Is it expected
> that synchronize_rcu_tasks() can hang indefinitely on a PREEMPT system,
> or can this be fixed? And if it is expected, how can the BPF code be
> fixed so it doesn't deadlock because of this?
> 
> Hoping you can help us with this - many thanks in advance! :)

Let me start with the usual question...  Is the network traffic intense
enough that one of the CPUs might remain in a loop handling softirqs
indefinitely?

If so, does the (untested, probably does not build) patch below help?

Please note that this is only a diagnostic patch.  It has the serious
side effect of making __do_softirq() and anything that calls it implicitly
noinstr.  But it might at least be a decent starting point for a real fix.
Or might be part of the real fix, who knows?

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
+	rcu_tasks_qs(current, true);
 }
 
 /*
