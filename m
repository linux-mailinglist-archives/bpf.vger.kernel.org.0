Return-Path: <bpf+bounces-48742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B35A1019A
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 09:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E55E1888434
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53923D3E9;
	Tue, 14 Jan 2025 08:01:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C01C3C15
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736841702; cv=none; b=APLdD2kC0qTx5mfshuLzd3ItvXVjMuFtqvWf325QKulymhbnQIL7LxRqlKGqYLKg2/F7xLFfO6GpraoAL1fqTFRwl8Cs3qkFMQyrcYENoI3NlmTukTk7dJhp5+EmcsYadFh8XotfZkll6rmQ9WkysVKYEK/A/qnf3z4+KZR17H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736841702; c=relaxed/simple;
	bh=nV5yDGQeqeTbxzYv/Mw7urPPyKfgEc7M8b8mysFQ0sk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hm6zzaQTorFVWXi0ORLISYIf/So7Gi8o7XBVuo8RRygAJ3m190cQQU6nsB4qPWw7s82lbmXJ1xkfuP6gxfayFPb/gB9NmnWglM785UYmvEouTfg4en63YoBFJGdwtXWfehzz5hSFOMhN41o+ZNncZ8D8Mx+JOgipU4VTGGPcruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YXM5Q4Rh9z4f3jsx
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 16:01:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C66021A15CA
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 16:01:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAni1_XGYZnLhitAw--.7364S4;
	Tue, 14 Jan 2025 16:01:29 +0800 (CST)
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
Subject: [PATCH bpf-next] bpf: Alloc bpf_async_cb by using bpf_global_ma under PREEMPT_RT
Date: Tue, 14 Jan 2025 16:13:38 +0800
Message-Id: <20250114081338.2375090-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni1_XGYZnLhitAw--.7364S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtr17WF17JF1rJr43tF17trb_yoW7Gw1kpF
	4fta4ayr4UZFsF9rs3Za1kCr95Cr1kWw17GrZ3Xw1FvrWagr1kKa18WF1rZF98urW8ArW7
	ZF4ktay5WF1xCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1aFAJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Under PREEMPT_RT, it is not safe to use GPF_ATOMIC kmalloc when
preemption or irq is disabled. The following warning is reported when
running test_progs under PREEMPT_RT:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 675, name: test_progs
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  2 locks held by test_progs/675:
   #0: ffffffff864b0240 (rcu_read_lock_trace){....}-{0:0}, at: bpf_prog_test_run_syscall+0x2c0/0x830
   #1: ffff8881f4ec40c8 ((&c->lock)){....}-{2:2}, at: ___slab_alloc+0xbc/0x1280
  Preemption disabled at:
  [<ffffffff8175ae2b>] __bpf_async_init+0xbb/0xb10
  CPU: 1 UID: 0 PID: 675 Comm: test_progs Tainted: G           O       6.12.0+ #11
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ...
  Call Trace:
   <TASK>
   dump_stack_lvl+0x57/0x70
   dump_stack+0x10/0x20
   __might_resched+0x337/0x4d0
   rt_spin_lock+0xd4/0x230
   ___slab_alloc+0xbc/0x1280
   __slab_alloc.isra.0+0x5d/0xa0
   __kmalloc_node_noprof+0xf7/0x4f0
   bpf_map_kmalloc_node+0xf5/0x6b0
   __bpf_async_init+0x20e/0xb10
   bpf_timer_init+0x30/0x40
   bpf_prog_c7e2dc9ff3d5ba62_start_cb+0x55/0x85
   bpf_prog_4eb421be69ae82fa_start_timer+0x5d/0x7e
   bpf_prog_test_run_syscall+0x322/0x830
   __sys_bpf+0x135d/0x3ca0
   __x64_sys_bpf+0x75/0xb0
   x64_sys_call+0x1b5/0xa10
   do_syscall_64+0x3b/0xc0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fix the problem by using bpf_global_ma to allocate bpf_async_cb when
PREEMPT_RT is enabled. The reason for still using kmalloc for
no-PREEMPT_RT case is that bpf_global_ma doesn't support accouting the
allocated memory to specific memcg. Also doing the memory allocation
before invoking __bpf_spin_lock_irqsave() to reduce the possibility of
-ENOMEM for bpf_global_ma.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 48 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bcda671feafd9..5041f22812936 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1109,12 +1109,14 @@ struct bpf_async_cb {
  * freeing the timers when inner map is replaced or deleted by user space.
  */
 struct bpf_hrtimer {
+	/* cb must be the first member */
 	struct bpf_async_cb cb;
 	struct hrtimer timer;
 	atomic_t cancelling;
 };
 
 struct bpf_work {
+	/* cb must be the first member */
 	struct bpf_async_cb cb;
 	struct work_struct work;
 	struct work_struct delete_work;
@@ -1141,6 +1143,34 @@ enum bpf_async_type {
 
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
+static void bpf_async_free(struct bpf_async_cb *cb)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		bpf_mem_free(&bpf_global_ma, cb);
+	else
+		kfree(cb);
+}
+
+static void bpf_async_free_rcu(struct bpf_async_cb *cb)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		bpf_mem_free_rcu(&bpf_global_ma, cb);
+	else
+		kfree_rcu(cb, rcu);
+}
+
+static struct bpf_async_cb *bpf_async_alloc(struct bpf_map *map, size_t size)
+{
+	struct bpf_async_cb *cb;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		cb = bpf_mem_alloc(&bpf_global_ma, size);
+	else
+		/* allocate hrtimer via map_kmalloc to use memcg accounting */
+		cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+	return cb;
+}
+
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
@@ -1221,7 +1251,7 @@ static void bpf_wq_delete_work(struct work_struct *work)
 
 	cancel_work_sync(&w->work);
 
-	kfree_rcu(w, cb.rcu);
+	bpf_async_free_rcu(&w->cb);
 }
 
 static void bpf_timer_delete_work(struct work_struct *work)
@@ -1236,7 +1266,7 @@ static void bpf_timer_delete_work(struct work_struct *work)
 	 * bpf_timer_cancel_and_free will have been cancelled.
 	 */
 	hrtimer_cancel(&t->timer);
-	kfree_rcu(t, cb.rcu);
+	bpf_async_free_rcu(&t->cb);
 }
 
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
@@ -1263,20 +1293,18 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		return -EINVAL;
 	}
 
+	cb = bpf_async_alloc(map, size);
+	if (!cb)
+		return -ENOMEM;
+
 	__bpf_spin_lock_irqsave(&async->lock);
 	t = async->timer;
 	if (t) {
+		bpf_async_free(cb);
 		ret = -EBUSY;
 		goto out;
 	}
 
-	/* allocate hrtimer via map_kmalloc to use memcg accounting */
-	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
-	if (!cb) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	switch (type) {
 	case BPF_ASYNC_TYPE_TIMER:
 		clockid = flags & (MAX_CLOCKS - 1);
@@ -1313,7 +1341,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		 * or pinned in bpffs.
 		 */
 		WRITE_ONCE(async->cb, NULL);
-		kfree(cb);
+		bpf_async_free(cb);
 		ret = -EPERM;
 	}
 out:
-- 
2.29.2


