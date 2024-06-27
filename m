Return-Path: <bpf+bounces-33252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F591A4B2
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD0A1F2352E
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D6D1459E4;
	Thu, 27 Jun 2024 11:12:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282F13C831
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486728; cv=none; b=h962I72P0t8oG3tstyuQdrIxZvspdm6bc+kDPnSeMCW8EG7jVyI+UAdi4J402H7Zo7gB0x+Kd5dqKARN2kM9lPw1OdOlyd1vQdkpX6WWAzJoipyaulO9xOwSkMKFJTl/4LIxbJSPnemNBFh77/zMJtWvNXRIz9E8kBSjdhxOABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486728; c=relaxed/simple;
	bh=NZWGPxDuY9NL791CEDFXKT6wV1pr8L3NhF6nzfSF4ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ighadb2/BHsnkIFdOFZiH/FK3cluZ2Fp6L/Zy3nwjASp7cxIX4BFBbgQW/FDCxc8OoN3ySoqvAx5qz+YRilzAtLZeTsi8TdE1Jn65FXzls76kd9Mv4Vv1jmCUfoPVsvzCd0V5k5B3ClsiR3xJhUQz47vZBzLOIRRyGz4p0Rl5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45RBAGdq081328;
	Thu, 27 Jun 2024 20:10:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Thu, 27 Jun 2024 20:10:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45RBAGP8081324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 27 Jun 2024 20:10:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b55e5f24-01ad-4a3d-94dc-e8a6bc15ac42@I-love.SAKURA.ne.jp>
Date: Thu, 27 Jun 2024 20:10:16 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] sched/core: defer printk() while rq lock is held
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de>
 <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de>
 <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
 <CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
 <7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
 <CAADnVQKoHk5FTN=jywBjgdTdLwv-c76nCzyH90Js-41WxPK_Tw@mail.gmail.com>
 <744c9c43-9e4f-4069-9773-067036237bff@I-love.SAKURA.ne.jp>
 <20240626122748.065a903b@rorschach.local.home>
 <f6c23073-dc0d-4b3f-b37d-1edb82737b5b@I-love.SAKURA.ne.jp>
 <20240626183311.05eaf091@rorschach.local.home>
 <6264da10-b6a0-40b8-ac26-c044b7f7529c@I-love.SAKURA.ne.jp>
 <20240626200906.37326e17@rorschach.local.home>
 <290aac9b-0664-404d-a457-292d69f9b22b@I-love.SAKURA.ne.jp>
 <20240626202926.4267df74@rorschach.local.home>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240626202926.4267df74@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting circular locking dependency inside __bpf_prog_run()
when trace_sched_switch() hook is called from __schedule(), for fault
injection calls printk() despite rq lock is already held.

Since any debugging functionality might call printk(), guard the whole
section between raw_spin_rq_{lock,lock_nested,trylock}() and
raw_spin_rq_unlock() using printk_deferred_{enter,exit}().

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc4-syzkaller-00874-g84562f9953ec #0 Not tainted
------------------------------------------------------
syz-executor.1/25480 is trying to acquire lock:
ffffffff8e328140 (console_owner){..-.}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:334 [inline]
ffffffff8e328140 (console_owner){..-.}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
ffffffff8e328140 (console_owner){..-.}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:286 [inline]
ffffffff8e328140 (console_owner){..-.}-{0:0}, at: console_flush_all+0x152/0xfd0 kernel/printk/printk.c:2986

but task is already holding lock:
ffff8880b943e798 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559

which lock already depends on the new lock.

(...snipped...)

Chain exists of:
  console_owner --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(console_owner);

 *** DEADLOCK ***

6 locks held by syz-executor.1/25480:
 #0: ffffffff8f5e6f48 (rtnl_mutex){+.+.}-{3:3}, at: dev_ioctl+0x706/0x1340 net/core/dev_ioctl.c:785
 #1: ffffffff8f67dd68 (flowtable_lock){+.+.}-{3:3}, at: nf_flow_table_cleanup+0x23/0xb0 net/netfilter/nf_flow_table_core.c:593
 #2: ffff8880b943e798 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2402 [inline]
 #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x244/0x590 kernel/trace/bpf_trace.c:2446
 #4: ffffffff8e20fa60 (console_lock){+.+.}-{0:0}, at: _printk+0xd5/0x120 kernel/printk/printk.c:2370
 #5: ffffffff8e20f690 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:334 [inline]
 #5: ffffffff8e20f690 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
 #5: ffffffff8e20f690 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:286 [inline]
 #5: ffffffff8e20f690 (console_srcu){....}-{0:0}, at: console_flush_all+0x152/0xfd0 kernel/printk/printk.c:2986

stack backtrace:
CPU: 0 PID: 25480 Comm: syz-executor.1 Not tainted 6.10.0-rc4-syzkaller-00874-g84562f9953ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 console_lock_spinning_enable kernel/printk/printk.c:1870 [inline]
 console_emit_next_record kernel/printk/printk.c:2922 [inline]
 console_flush_all+0x810/0xfd0 kernel/printk/printk.c:2994
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
 _printk+0xd5/0x120 kernel/printk/printk.c:2370
 fail_dump lib/fault-inject.c:45 [inline]
 should_fail_ex+0x391/0x4e0 lib/fault-inject.c:153
 __copy_to_user_inatomic include/linux/uaccess.h:123 [inline]
 copy_to_user_nofault+0x86/0x140 mm/maccess.c:149
 bpf_prog_b0a3dac844962ed2+0x47/0x4d
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
 bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2446
 __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2587/0x4a20 kernel/sched/core.c:6742
 preempt_schedule_notrace+0x100/0x140 kernel/sched/core.c:7017
 preempt_schedule_notrace_thunk+0x1a/0x30 arch/x86/entry/thunk.S:13
 rcu_is_watching+0x7e/0xb0 kernel/rcu/tree.c:725
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xe3/0x550 kernel/locking/lockdep.c:5725
 rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 rcu_read_lock include/linux/rcupdate.h:781 [inline]
 start_flush_work kernel/workqueue.c:4122 [inline]
 __flush_work+0x107/0xd00 kernel/workqueue.c:4181
 flush_work kernel/workqueue.c:4232 [inline]
 flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4254
 nf_flow_table_gc_cleanup net/netfilter/nf_flow_table_core.c:585 [inline]
 nf_flow_table_cleanup+0x62/0xb0 net/netfilter/nf_flow_table_core.c:595
 flow_offload_netdev_event+0x51/0x70 net/netfilter/nft_flow_offload.c:492
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 __dev_notify_flags+0x207/0x400
 dev_change_flags+0xf0/0x1a0 net/core/dev.c:8858
 dev_ifsioc+0x7c8/0xe70 net/core/dev_ioctl.c:529
 dev_ioctl+0x719/0x1340 net/core/dev_ioctl.c:786
 sock_do_ioctl+0x240/0x460 net/socket.c:1236
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..134f5196b9c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -559,6 +559,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 		raw_spin_lock_nested(&rq->__lock, subclass);
 		/* preempt_count *MUST* be > 1 */
 		preempt_enable_no_resched();
+		printk_deferred_enter();
 		return;
 	}
 
@@ -568,6 +569,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 		if (likely(lock == __rq_lockp(rq))) {
 			/* preempt_count *MUST* be > 1 */
 			preempt_enable_no_resched();
+			printk_deferred_enter();
 			return;
 		}
 		raw_spin_unlock(lock);
@@ -584,6 +586,8 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	if (sched_core_disabled()) {
 		ret = raw_spin_trylock(&rq->__lock);
 		preempt_enable();
+		if (ret)
+			printk_deferred_enter();
 		return ret;
 	}
 
@@ -592,6 +596,8 @@ bool raw_spin_rq_trylock(struct rq *rq)
 		ret = raw_spin_trylock(lock);
 		if (!ret || (likely(lock == __rq_lockp(rq)))) {
 			preempt_enable();
+			if (ret)
+				printk_deferred_enter();
 			return ret;
 		}
 		raw_spin_unlock(lock);
@@ -600,6 +606,7 @@ bool raw_spin_rq_trylock(struct rq *rq)
 
 void raw_spin_rq_unlock(struct rq *rq)
 {
+	printk_deferred_exit();
 	raw_spin_unlock(rq_lockp(rq));
 }
 
-- 
2.43.0


