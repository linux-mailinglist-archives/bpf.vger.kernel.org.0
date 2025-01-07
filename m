Return-Path: <bpf+bounces-48060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79734A03A03
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEFA1886D25
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5E1E3DDE;
	Tue,  7 Jan 2025 08:44:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F21DF977;
	Tue,  7 Jan 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239443; cv=none; b=LyVxJYwdQpjSKcaFJCzY899zq7J8fppkoYsCOpm+XKLsRe14h9toLlnS9GfSokaFtMHHQH+eK7a5JjnODV0mxD/8eh6hHbwDE+7qFJFz39dMuGxMfbXRHz+2yKsB4Wx6mjATOIaUVd8xB+qRD/Pmi45ByX4eOsY1avwl3TqbnGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239443; c=relaxed/simple;
	bh=5dkY9V6arO3B6Epj0oV1jzsP54PvWUIoWcGhJzf5Ygw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gG4rJ34QWqQVGYmoHwDoT/FwL+4CocHDwKiVoNxgPvLbCG91mOx1jwqBkzRfqfakxQmShN3VfwNzDP5ki4iZgrCeHS138HbJWaqr1C0SkJAJYCRbv3RgiR+M+rZWC+0pl7GQkZ8vC7kP1sRuBwA6q0Ts1YoTSNxHfjDYpWh0r+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YS4MX5Y1tz4f3jXP;
	Tue,  7 Jan 2025 16:43:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E0D881A15B6;
	Tue,  7 Jan 2025 16:43:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9E6XxnpFgeAQ--.43336S10;
	Tue, 07 Jan 2025 16:43:56 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
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
Subject: [PATCH bpf-next 6/7] bpf: Free element after unlock for pre-allocated htab
Date: Tue,  7 Jan 2025 16:55:58 +0800
Message-Id: <20250107085559.3081563-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250107085559.3081563-1-houtao@huaweicloud.com>
References: <20250107085559.3081563-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9E6XxnpFgeAQ--.43336S10
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW8Xw48Cw4kJr1xury3urg_yoW7AFWDpF
	WfWF17Kr4kCrsF9a1DtF1FgrW5Ars3WayUGFW8KryrKF15Wrnaqr48AF92gFy5Cr9xAF9a
	vrZFvwsxKws5ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
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

To fix the problem, the patch breaks the reuse and refill of per-cpu
extra_elems into two independent part: reuse the per-cpu extra_elems
with bucket lock being held and refill the old_element as per-cpu
extra_elems after the bucket lock is unlocked. After the break, it is
safe to free pre-allocated element after bucket lock is unlocked.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9211df2adda4..83c96c8941f0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1034,9 +1034,16 @@ static struct htab_elem *alloc_preallocated_htab_elem(struct bpf_htab *htab,
 		 * use per-cpu extra elems to avoid freelist_pop/push
 		 */
 		pl_new = this_cpu_ptr(htab->extra_elems);
-		l_new = *pl_new;
-		*pl_new = old_elem;
-		return l_new;
+		/* Paired with cmpxchg_release() in free_htab_elem() */
+		l_new = smp_load_acquire(pl_new);
+		/* extra_elems can be NULL if the current update operation
+		 * preempts another update operation that hasn't yet refilled
+		 * the per-cpu extra_elems.
+		 */
+		if (l_new) {
+			WRITE_ONCE(*pl_new, NULL);
+			return l_new;
+		}
 	}
 
 	l = __pcpu_freelist_pop(&htab->freelist);
@@ -1139,7 +1146,6 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	struct htab_elem *l_new = NULL, *l_old;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
-	void *old_map_ptr;
 	struct bucket *b;
 	u32 key_size, hash;
 	int ret;
@@ -1200,7 +1206,8 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		copy_map_value_locked(map,
 				      l_old->key + round_up(key_size, 8),
 				      value, false);
-		ret = 0;
+		/* don't free the reused old element */
+		l_old = NULL;
 		goto err;
 	}
 
@@ -1216,31 +1223,13 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	 * concurrent search will find it before old elem
 	 */
 	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
-	if (l_old) {
+	if (l_old)
 		hlist_nulls_del_rcu(&l_old->hash_node);
-
-		/* l_old has already been stashed in htab->extra_elems, free
-		 * its special fields before it is available for reuse. Also
-		 * save the old map pointer in htab of maps before unlock
-		 * and release it after unlock.
-		 */
-		old_map_ptr = NULL;
-		if (htab_is_prealloc(htab)) {
-			if (map->ops->map_fd_put_ptr)
-				old_map_ptr = fd_htab_map_get_ptr(map, l_old);
-			check_and_free_fields(htab, l_old);
-		}
-	}
-	htab_unlock_bucket(htab, b, hash, flags);
-	if (l_old) {
-		if (old_map_ptr)
-			map->ops->map_fd_put_ptr(map, old_map_ptr, true);
-		if (!htab_is_prealloc(htab))
-			free_htab_elem(htab, l_old, false);
-	}
-	return 0;
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
+	/* refill per-cpu extra_elems for preallocated htab */
+	if (!ret && l_old)
+		free_htab_elem(htab, l_old, true);
 	return ret;
 }
 
-- 
2.29.2


