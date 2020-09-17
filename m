Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADEF26E714
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 23:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIQVGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Sep 2020 17:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgIQVGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Sep 2020 17:06:53 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0044F208E4;
        Thu, 17 Sep 2020 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600376813;
        bh=wnOPfgDD7ID92jdZ56dwprdvFTRV3EVbC9ypZsfycMg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QT4/jqKXPcV61aUPTXkopvnqF5kR7iijgukjgu1Dfj8xtY30xDG933p4mGkYhDwCa
         pHgWA1isBxcJzvE2fcKKRoWHU+UngTaUN1B1iOPh9vchbjYXt24AIf6qX1JZVIrx79
         DVxtPmjKIo932TTLPMlsiW/G5xh1FoHs0htwS8ZQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C06773522887; Thu, 17 Sep 2020 14:06:52 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:06:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        jolsa@redhat.com, bpf@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Accelerate RCU Tasks Trace updates
Message-ID: <20200917210652.GA31242@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200910201956.GA24190@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910201956.GA24190@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!

This series accelerates RCU Tasks Trace updates, reducing the average
grace-period latencies from about a second to about 20 milliseconds on my
x86 laptop.  These are benchmark numbers, based on a previously posted
patch to rcuscale.c [1] running on my x86 laptop.  Additional patches
provide a compiler-warning cleanup and fix several race conditions that
were exposed by the faster grace periods.  The patches in this series
are as follows:

1.	Prevent complaints of unused show_rcu_tasks_classic_gp_kthread().
	This is not related to the problem at hand, but it is
	a pre-existing patch that provides a simple cleanup.
	The grace-period latency thus remains at 980 milliseconds.

2.	Mark variables static, noted during this effort but otherwise
	unconnected.  This change has no effect, so that the average
	grace-period latency remains at 980 milliseconds.

3.	Use more aggressive polling for RCU Tasks Trace.  This polling
	starts at five-millisecond intervals instead of the prior
	100-millisecond intervals.  As before, the polling interval
	increases in duration as the grace period ages, and again as
	before is capped at one second.  This change reduces the
	average grace-period latency to about 620 milliseconds.

4.	Selectively enable more RCU Tasks Trace IPIs.  This retains
	the old behavior of suppressing IPIs for grace periods that are
	younger than 500 milliseconds for CONFIG_TASKS_TRACE_RCU_READ_MB=y
	kernels, including CONFIG_PREEMPT_RT=y kernels, but allows IPIs
	immediately on other kernels.  It is quite possible that a more
	sophisticated decision procedure will be required, and changes
	to RCU's dyntick-idle code might also be needed.  This change
	(along with the earlier ones) reduces the average grace-period
	latency to about 120 milliseconds.

5.	Shorten per-grace-period sleep for RCU Tasks Trace.  The
	current code sleeps for 100 milliseconds after the end of
	each grace period, which by itself prevents a back-to-back
	string of grace-period waits from completing faster than
	ten per second.  This patch also retains this old behavior
	for CONFIG_TASKS_TRACE_RCU_READ_MB=y (and again thus also
	for CONFIG_PREEMPT_RT=y kernels).  For other kernels, this
	post-grace-period sleep is reduced to five milliseconds.
	This change (along with the earlier ones) reduced the average
	grace-period latency to about 18 milliseconds, for an overall
	factor-of-50 reduction in latency.

6.	Fix a deadlock-inducing race between rcu_read_unlock_trace()
	and trc_read_check_handler().  The race window was only a few
	instructions wide, but please see the commit log for the full
	sad story.  The grace-period speedup made this race 50 times
	more probable, and thus reduced the rcutorture runtime required
	to reproduce it from about five months to about four days.

7.	Fix a low-probability race between rcu_read_unlock_trace()
	and the RCU Tasks Trace CPU stall reporting loop in
	rcu_tasks_trace_postgp().  This race could result in leaking
	task_struct structures.

8.	Fix a low-probability race between the RCU Tasks Trace CPU
	stall reporting loop in rcu_tasks_trace_postgp() and task exit.
	This race could result in use-after-free errors.

Alexei Starovoitov benchmarked an earlier patch [2], producing results
that are roughly consistent with the above reduction in latency [3].

Changes since last week's RFC version:

o	Added patch #1, which cleans up a compiler warning.

o	Renumbered patches 1-4 to 2-5.

o	Add Ccs to patches 3, 4, and 5.

o	Add patches 6-8 to fix race conditions exposed by 50x faster
	grace periods.	These are either rare on the one hand or both
	rare and occurring only during an RCU Tasks Trace CPU stall
	warning -and- rare on the other.  Still, they need to be fixed.

o	This series maintains the sub-20-millisecond update-side
	grace-period delays of the RFC series.
	
o	Fixing the first of the race conditions required that a
	compiler barrier be added to rcu_read_lock_trace() and that
	another compiler barrier along with a WRITE_ONCE() be added to
	rcu_read_unlock_trace().  This fix therefore adds a fraction of
	a nanosecond to read-side overhead.  On my laptop, the increase
	is from about 2.6 nanoseconds to about 3 nanoseconds.  This
	small increase should not cause noticeable problems.

							Thanx, Paul

[1] https://lore.kernel.org/bpf/20200909193900.GK29330@paulmck-ThinkPad-P72/
[2] https://lore.kernel.org/bpf/20200910052727.GA4351@paulmck-ThinkPad-P72/
[3] https://lore.kernel.org/bpf/619554b2-4746-635e-22f3-7f0f09d97760@fb.com/

------------------------------------------------------------------------

 include/linux/rcupdate_trace.h |    4 +
 kernel/rcu/tasks.h             |   92 +++++++++++++++++++++++++++++++----------
 2 files changed, 75 insertions(+), 21 deletions(-)
