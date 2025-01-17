Return-Path: <bpf+bounces-49173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33808A14D37
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 11:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBE13A7AE8
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BD81FE477;
	Fri, 17 Jan 2025 10:06:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01F1F8AFC
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108378; cv=none; b=BWB+o1NXGanLnnmwDaqXbMCqo1WVuXu+CpInTN3yeo4Ge2SB5Osdqg8u+0EcLXBzn3W13/A0XSkJpkCMacgs18iYOfRHiofCbu3+C8m/8Ut8QO8GdJIoHD9gVfmQvt0ils9TLIAQeJDhW7v9E27aEnWG36WYD1vDpxDK2lfGT/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108378; c=relaxed/simple;
	bh=L8EM14bzNkipgHdSogwv3aPXVBtQXBKJm3kf5JHer5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICx+ZnmR29BYv8MhoqH1xOiafp7LJwMVQDavFim4jdnbz1OXygVYLuo0YModQQF/uir8GScwpumS7xBiwz6EY/3ROV64ckqHqTvBOCXO6ZdixUeFtCBinvS22pMEKpq967wsPea0k7++azwJ7WGeLQdT1InWlwtQzs5a9WLB5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZFjp6z9lz4f3lDc
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:05:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ACB141A1A4A
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:06:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGCNK4pnQRDPBA--.48008S8;
	Fri, 17 Jan 2025 18:06:12 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v3 4/5] bpf: Cancel the running bpf_timer through kworker for PREEMPT_RT
Date: Fri, 17 Jan 2025 18:18:15 +0800
Message-Id: <20250117101816.2101857-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250117101816.2101857-1-houtao@huaweicloud.com>
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGCNK4pnQRDPBA--.48008S8
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW8Xw48Cw4kJr1xury3urg_yoW7WFWxpr
	WfKry2kr1kWr1qvrsFvF1kGa48Cws3Gw17Grs7Kr15ZF15W3ZYqFWI9F1SgFW5Cr93AFZa
	vr4qv39akwn8u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

During the update procedure, when overwrite element in a pre-allocated
htab, the freeing of old_element is protected by the bucket lock. The
reason why the bucket lock is necessary is that the old_element has
already been stashed in htab->extra_elems after alloc_htab_elem()
returns. If freeing the old_element after the bucket lock is unlocked,
the stashed element may be reused by concurrent update procedure and the
freeing of old_element will run concurrently with the reuse of the
old_element. However, the invocation of check_and_free_fields() may
acquire a spin-lock which violates the lockdep rule because its caller
has already held a raw-spin-lock (bucket lock). The following warning
will be reported when such race happens:

  BUG: scheduling while atomic: test_progs/676/0x00000003
  3 locks held by test_progs/676:
  #0: ffffffff864b0240 (rcu_read_lock_trace){....}-{0:0}, at: bpf_prog_test_run_syscall+0x2c0/0x830
  #1: ffff88810e961188 (&htab->lockdep_key){....}-{2:2}, at: htab_map_update_elem+0x306/0x1500
  #2: ffff8881f4eac1b8 (&base->softirq_expiry_lock){....}-{2:2}, at: hrtimer_cancel_wait_running+0xe9/0x1b0
  Modules linked in: bpf_testmod(O)
  Preemption disabled at:
  [<ffffffff817837a3>] htab_map_update_elem+0x293/0x1500
  CPU: 0 UID: 0 PID: 676 Comm: test_progs Tainted: G ... 6.12.0+ #11
  Tainted: [W]=WARN, [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)...
  Call Trace:
  <TASK>
  dump_stack_lvl+0x57/0x70
  dump_stack+0x10/0x20
  __schedule_bug+0x120/0x170
  __schedule+0x300c/0x4800
  schedule_rtlock+0x37/0x60
  rtlock_slowlock_locked+0x6d9/0x54c0
  rt_spin_lock+0x168/0x230
  hrtimer_cancel_wait_running+0xe9/0x1b0
  hrtimer_cancel+0x24/0x30
  bpf_timer_delete_work+0x1d/0x40
  bpf_timer_cancel_and_free+0x5e/0x80
  bpf_obj_free_fields+0x262/0x4a0
  check_and_free_fields+0x1d0/0x280
  htab_map_update_elem+0x7fc/0x1500
  bpf_prog_9f90bc20768e0cb9_overwrite_cb+0x3f/0x43
  bpf_prog_ea601c4649694dbd_overwrite_timer+0x5d/0x7e
  bpf_prog_test_run_syscall+0x322/0x830
  __sys_bpf+0x135d/0x3ca0
  __x64_sys_bpf+0x75/0xb0
  x64_sys_call+0x1b5/0xa10
  do_syscall_64+0x3b/0xc0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
  ...
  </TASK>

It seems feasible to break the reuse and refill of per-cpu extra_elems
into two independent parts: reuse the per-cpu extra_elems with bucket
lock being held and refill the old_element as per-cpu extra_elems after
the bucket lock is unlocked. However, it will make the concurrent
overwrite procedures on the same CPU return unexpected -E2BIG error when
the map is full.

Therefore, the patch fixes the lock problem by breaking the cancelling
of bpf_timer into two steps for PREEMPT_RT:
1) use hrtimer_try_to_cancel() and check its return value
2) if the timer is running, use hrtimer_cancel() through a kworker to
   cancel it again
Considering that the current implementation of hrtimer_cancel() will try
to acquire a being held softirq_expiry_lock when the current timer is
running, these steps above are reasonable. However, it also has
downside. When the timer is running, the cancelling of the timer is
delayed when releasing the last map uref. The delay is also fixable
(e.g., break the cancelling of bpf timer into two parts: one part in
locked scope, another one in unlocked scope), it can be revised later if
necessary.

It is a bit hard to decide the right fix tag. One reason is that the
problem depends on PREEMPT_RT which is enabled in v6.12. Considering the
softirq_expiry_lock lock exists since v5.4 and bpf_timer is introduced
in v5.15, the bpf_timer commit is used in the fixes tag and an extra
depends-on tag is added to state the dependency on PREEMPT_RT.

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Depends-on: v6.12+ with PREEMPT_RT enabled
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/bpf/20241106084527.4gPrMnHt@linutronix.de
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bcda671feafd9..f27ce162427ab 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1593,10 +1593,24 @@ void bpf_timer_cancel_and_free(void *val)
 	 * To avoid these issues, punt to workqueue context when we are in a
 	 * timer callback.
 	 */
-	if (this_cpu_read(hrtimer_running))
+	if (this_cpu_read(hrtimer_running)) {
 		queue_work(system_unbound_wq, &t->cb.delete_work);
-	else
+		return;
+	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/* If the timer is running on other CPU, also use a kworker to
+		 * wait for the completion of the timer instead of trying to
+		 * acquire a sleepable lock in hrtimer_cancel() to wait for its
+		 * completion.
+		 */
+		if (hrtimer_try_to_cancel(&t->timer) >= 0)
+			kfree_rcu(t, cb.rcu);
+		else
+			queue_work(system_unbound_wq, &t->cb.delete_work);
+	} else {
 		bpf_timer_delete_work(&t->cb.delete_work);
+	}
 }
 
 /* This function is called by map_delete/update_elem for individual element and
-- 
2.29.2


