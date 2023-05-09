Return-Path: <bpf+bounces-242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC54E6FC7CC
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 15:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A231C20B74
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857CB182CB;
	Tue,  9 May 2023 13:24:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4266116
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 13:24:38 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28F10FE
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 06:24:36 -0700 (PDT)
Date: Tue, 9 May 2023 15:24:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1683638674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4l5RF2KTaMfWIVGhqgB7Cv1ag9F7+Hw6e7FBaJ4AUMw=;
	b=Ke9PXjEYWHoYzXEyrX7Cr12JUmrRf/Jbgeu0zNJUrvcD3KP/0iYkBSni6Cli63wXOuUfyF
	6OBePzmPkZ6q+zqf1OtMsm+2vOsPK60hGOHecEYGe3uu0hv3ruq4r9LFOlrD8c5zik8ZeE
	G/2TSYJ7ymP98WguiBg+ofUbYeZz77+a6LwBVQC2bz8jqMIX424IaLKc6L0xrqWKw9ewjf
	zGcspZ80D+qlbat/C/ODUJoiCGY0uHmDtZ8bRo1cWsYbhOZ4F681Hvdbkjby19uAdqqWWg
	BUpq4YOWiCg0CUwrD16Poew1P8F78vBv8B69gFje7GUp/KN6LbEplsLdA0biDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1683638674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4l5RF2KTaMfWIVGhqgB7Cv1ag9F7+Hw6e7FBaJ4AUMw=;
	b=kozWE0eLC7AJVrpE33NJ+mUseZIalDXPd1kBo6COMiY1/FmIuH60AwMvqzGXUeZOeuk2P1
	D0G8iDHwMUHMeWBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <20230509132433.2FSY_6t7@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
invoked within softirq context. By setting rcutree.use_softirq=0 boot
option the RCU callbacks will be invoked in a per-CPU kthread with
bottom halves disabled which implies a RCU read section.

On PREEMPT_RT the context remains fully preemptible. The RCU read
section however does not allow schedule() invocation. The latter happens
in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
from bpf_link_put().

Remove the context checks and use the workqueue unconditionally.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
The warning can be observed as:
| BUG: sleeping function called from invalid context at kernel/locking/rtmutex_api.c:510
| in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 47, name: rcuc/3
| preempt_count: 0, expected: 0
| RCU nest depth: 2, expected: 0
| CPU: 3 PID: 47 Comm: rcuc/3 Tainted: G            E      v6.3-rt12 #1
| Hardware name: Supermicro X9SCL/X9SCM/X9SCL/X9SCM, BIOS 2.3a 01/06/2021
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0x43/0x60
|  __might_resched+0x137/0x190
|  mutex_lock+0x1a/0x50
|  bpf_trampoline_unlink_prog+0x1b/0x100
|  bpf_tracing_link_release+0x12/0x40
|  bpf_link_free+0x70/0x90
|  bpf_free_inode+0x3e/0x80
|  rcu_core+0x4ff/0x7c0
|  rcu_cpu_kthread+0xa9/0x2f0
|  smpboot_thread_fn+0x141/0x2c0
|  kthread+0x110/0x130
|  ret_from_fork+0x2c/0x50
|  </TASK>

 kernel/bpf/syscall.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14f39c1e573ee..0adaa1bfbb0d2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2785,12 +2785,8 @@ void bpf_link_put(struct bpf_link *link)
 	if (!atomic64_dec_and_test(&link->refcnt))
 		return;
 
-	if (in_atomic()) {
-		INIT_WORK(&link->work, bpf_link_put_deferred);
-		schedule_work(&link->work);
-	} else {
-		bpf_link_free(link);
-	}
+	INIT_WORK(&link->work, bpf_link_put_deferred);
+	schedule_work(&link->work);
 }
 EXPORT_SYMBOL(bpf_link_put);
 
-- 
2.40.1


