Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6F62636B1
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIITjD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 15:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIITjC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 15:39:02 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085EE21D7A;
        Wed,  9 Sep 2020 19:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599680341;
        bh=wJppbXY6KK6k5dN2NGncINqEUHGU336hdw1JOjBIvxY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dET4/DUil88nxqLoRZ9krwRMWF+nSBpts94holdJ5oiLpk/7WKRx2mndm+vKHF+8e
         Trw6PGuQ7oemID8emPKytIeHucwa9yuZzrHDgBE1HRYWrKU5TmPcJbhYjrq7nd6Pyt
         lT5TVky8pDISIp//mmclWCsXkXTAh9ahbjmYc8+g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C58B43522602; Wed,  9 Sep 2020 12:39:00 -0700 (PDT)
Date:   Wed, 9 Sep 2020 12:39:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200909193900.GK29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
 <20200909173512.GI29330@paulmck-ThinkPad-P72>
 <20200909180418.hlivoaekhkchlidw@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909180418.hlivoaekhkchlidw@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 11:04:18AM -0700, Alexei Starovoitov wrote:
> On Wed, Sep 09, 2020 at 10:35:12AM -0700, Paul E. McKenney wrote:
> > On Wed, Sep 09, 2020 at 10:12:28AM -0700, Alexei Starovoitov wrote:
> > > On Wed, Sep 09, 2020 at 04:38:58AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Sep 08, 2020 at 07:34:20PM -0700, Alexei Starovoitov wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > Looks like sync rcu_tasks_trace got slower or we simply didn't notice
> > > > > it earlier.
> > > > > 
> > > > > In selftests/bpf try:
> > > > > time ./test_progs -t trampoline_count
> > > > > #101 trampoline_count:OK
> > > > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > > > 
> > > > > real    1m17.082s
> > > > > user    0m0.145s
> > > > > sys    0m1.369s
> > > > > 
> > > > > so it's really something going on with sync rcu_tasks_trace.
> > > > > Could you please take a look?
> > > > 
> > > > I am guessing that your .config has CONFIG_TASKS_TRACE_RCU_READ_MB=n.
> > > > If I am wrong, please try CONFIG_TASKS_TRACE_RCU_READ_MB=y.
> > > 
> > > I've added
> > > CONFIG_RCU_EXPERT=y
> > > CONFIG_TASKS_TRACE_RCU_READ_MB=y
> > > 
> > > and it helped:
> > > 
> > > time ./test_progs -t trampoline_count
> > > #101 trampoline_count:OK
> > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > 
> > > real	0m8.924s
> > > user	0m0.138s
> > > sys	0m1.408s
> > > 
> > > But this is still bad. It's 4 times slower vs rcu_tasks
> > > and isn't really usable for bpf, since it adds memory barriers exactly
> > > where we need them removed.
> > > 
> > > In the default configuration rcu_tasks_trace is 40! times slower than rcu_tasks.
> > > This huge difference in sync times concerns me a lot.
> > > If bpf has to use memory barriers in rcu_read_lock_trace
> > > and still be 4 times slower than rcu_tasks in the best case
> > > then there is no much point in rcu_tasks_trace.
> > > Converting everything to srcu would be better, but I really hope
> > > you can find a solution to this tasks_trace issue.
> > > 
> > > > Otherwise (or alternatively), could you please try booting with
> > > > rcupdate.rcu_task_ipi_delay=50?  The default value is 500, or half a
> > > > second on a HZ=1000 system, which on a busy system could easily result
> > > > in the grace-period delays that you are seeing.  The value of this
> > > > kernel boot parameter does interact with the tasklist-scan backoffs,
> > > > so its effect will not likely be linear.
> > > 
> > > The tests were run on freshly booted VM with 4 cpus. The VM is idle.
> > > The host is idle too.
> > > 
> > > Adding rcupdate.rcu_task_ipi_delay=50 boot param sort-of helped:
> > > time ./test_progs -t trampoline_count
> > > #101 trampoline_count:OK
> > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > 
> > > real	0m25.890s
> > > user	0m0.124s
> > > sys	0m1.507s
> > > It is still awful.
> > > 
> > > >From "perf report" there is little time spend in the kernel. The kernel is
> > > waiting on something. I thought in theory the rcu_tasks_trace should have been
> > > faster on update side vs rcu_tasks ? Could it be a bug somewhere and some
> > > missing wakeup? It doesn't feel that it works as intended. Whatever it is
> > > please try to reproduce it to remove me as a middle man.
> > 
> > On it.
> > 
> > To be fair, I was designing for a nominal one-second grace period,
> > which was also the rough goal for rcu_tasks.
> > 
> > When do you need this by?
> > 
> > Left to myself, I will aim for the merge window after the upcoming one,
> > and then backport to the prior -stable versions having RCU tasks trace.
> 
> That would be too late.
> We would have to disable sleepable bpf progs or convert them to srcu.
> bcc/bpftrace have a limit of 1000 probes for regexes to make sure
> these tools don't add too many kprobes to the kernel at once.
> Right now fentry/fexit/freplace are using trampoline which does
> synchronize_rcu_tasks(). My measurements show that it's roughly
> equal to synchronize_rcu() on idle box and perfectly capable to
> be a replacement for kprobe based attaching.
> It's not uncommon to attach a hundred kprobes or fentry probes at
> a start time. So bpf trampoline has to be able to do 1000 in a second.
> And it was the case before sleepable got added to the trampoline.
> Now it's doing:
> synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> and it's causing this massive slowdown which makes bpf trampoline
> pretty much unusable and everything that builds on top suffers.
> I can add a counter of sleepable progs to trampoline and do
> either sync rcu_tasks or sync_mult(tasks, tasks_trace),
> but we've discussed exactly that idea few months back and concluded that
> rcu_tasks is likely to be heavier than rcu_tasks_trace, so I didn't
> bother with the counter. I can still add it, but slow rcu_tasks_trace
> means that sleepable progs are not usable due to slow startup time,
> so have to do something with sleepable anyway.
> So "when do you need this by?" the answer is asap.
> I'm considering such changes to be a bugfix, not a feture.

Got it.

With the patch below, I am able to reproduce this issue, as expected.

My plan is to try the following:

1.	Parameterize the backoff sequence so that RCU Tasks Trace
	uses faster rechecking than does RCU Tasks.  Experiment as
	needed to arrive at a good backoff value.

2.	If the tasks-list scan turns out to be a tighter bottleneck 
	than the backoff waits, look into parallelizing this scan.
	(This seems unlikely, but the fact remains that RCU Tasks
	Trace must do a bit more work per task than RCU Tasks.)

3.	If these two approaches, still don't get the update-side
	latency where it needs to be, improvise.

The exact path into mainline will of course depend on how far down this
list I must go, but first to get a solution.

							Thanx, Paul

------------------------------------------------------------------------

commit 1b5b6a341cc17b5f236bceca3d1cfb23e39176b5
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Sep 9 12:27:03 2020 -0700

    rcuscale: Add RCU Tasks Trace
    
    This commit adds the ability to test performance and scalability of RCU
    Tasks Trace updaters.
    
    Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 2819b95..c42f240 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -38,6 +38,7 @@
 #include <asm/byteorder.h>
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
+#include <linux/rcupdate_trace.h>
 
 #include "rcu.h"
 
@@ -294,6 +295,35 @@ static struct rcu_scale_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+/*
+ * Definitions for RCU-tasks-trace scalability testing.
+ */
+
+static int tasks_trace_scale_read_lock(void)
+{
+	rcu_read_lock_trace();
+	return 0;
+}
+
+static void tasks_trace_scale_read_unlock(int idx)
+{
+	rcu_read_unlock_trace();
+}
+
+static struct rcu_scale_ops tasks_tracing_ops = {
+	.ptype		= RCU_TASKS_FLAVOR,
+	.init		= rcu_sync_scale_init,
+	.readlock	= tasks_trace_scale_read_lock,
+	.readunlock	= tasks_trace_scale_read_unlock,
+	.get_gp_seq	= rcu_no_completed,
+	.gp_diff	= rcu_seq_diff,
+	.async		= call_rcu_tasks_trace,
+	.gp_barrier	= rcu_barrier_tasks_trace,
+	.sync		= synchronize_rcu_tasks_trace,
+	.exp_sync	= synchronize_rcu_tasks_trace,
+	.name		= "tasks-tracing"
+};
+
 static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -754,7 +784,7 @@ rcu_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
+		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops, &tasks_tracing_ops
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
index 87caa0e..90942bb 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
@@ -1,2 +1,5 @@
 CONFIG_RCU_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
+CONFIG_TASKS_RCU_GENERIC=y
+CONFIG_TASKS_RCU=y
+CONFIG_TASKS_TRACE_RCU=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
new file mode 100644
index 0000000..4255490
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot
new file mode 100644
index 0000000..af0aff1
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot
@@ -0,0 +1 @@
+rcuscale.scale_type=tasks-tracing
