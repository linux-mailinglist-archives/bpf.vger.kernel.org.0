Return-Path: <bpf+bounces-44106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093609BDEC9
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 07:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B21C20CC9
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 06:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A376192580;
	Wed,  6 Nov 2024 06:23:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D61190676
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874218; cv=none; b=Oimm/lLgW9MnvbUPGdWBKCIitacJ2jLU0Bea8q5AG4uceazwGCSJyPHlf4NMpKmMbHunhuJTX/Xq4U2etrMmhpAkTUjJuz1G7I8d1mMVHtUurGWSBmH77XvffStRynMmUCRc3SIo4Bed6a5mKOMa58o4f6twD2t/DIzVoTO9yEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874218; c=relaxed/simple;
	bh=2rkILyCxyJWj/sfT71vL80UBmdX0sEyYGhkEC6HX2J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tIxU7gpbIuBVOm4+a9xJqI4FddkDK6YZrBSC4SBzZbclmGb+K2y1YpVg79aYm5TjU6OLeR4o7BdEe8WEHrqlW1Zxd3YaCtRyTUuNaKCkby4UJbSoS6BP/JY+WWvfNpo9lW9YEvhTvu76CwqvkQVeSisvlaFFsktpwYeKDVQ43uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XjwBH4Y0Bz4f3kp0
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 14:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7DE7A1A0568
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 14:23:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCngYVhCytn_SX4Aw--.24568S5;
	Wed, 06 Nov 2024 14:23:32 +0800 (CST)
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
Subject: [PATCH bpf-next 1/3] bpf: Call free_htab_elem() after htab_unlock_bucket()
Date: Wed,  6 Nov 2024 14:35:40 +0800
Message-Id: <20241106063542.357743-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241106063542.357743-1-houtao@huaweicloud.com>
References: <20241106063542.357743-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYVhCytn_SX4Aw--.24568S5
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWxWF13WFyrurWxWr48WFg_yoWfGrWfpF
	WSgr47Kw1kZryqvw45ta10grW5Zrn5J34UCFWkGryrZrn8ur92gw4xAFZ29ryrCr97AFs5
	ZrZFqw1rKa1UCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

For htab of maps, when the map is removed from the htab, it may hold the
last reference of the map. bpf_map_fd_put_ptr() will invoke
bpf_map_free_id() to free the id of the removed map element. However,
bpf_map_fd_put_ptr() is invoked while holding a bucket lock
(raw_spin_lock_t), and bpf_map_free_id() attempts to acquire map_idr_lock
(spinlock_t), triggering the following lockdep warning:

  =============================
  [ BUG: Invalid wait context ]
  6.11.0-rc4+ #49 Not tainted
  -----------------------------
  test_maps/4881 is trying to lock:
  ffffffff84884578 (map_idr_lock){+...}-{3:3}, at: bpf_map_free_id.part.0+0x21/0x70
  other info that might help us debug this:
  context-{5:5}
  2 locks held by test_maps/4881:
   #0: ffffffff846caf60 (rcu_read_lock){....}-{1:3}, at: bpf_fd_htab_map_update_elem+0xf9/0x270
   #1: ffff888149ced148 (&htab->lockdep_key#2){....}-{2:2}, at: htab_map_update_elem+0x178/0xa80
  stack backtrace:
  CPU: 0 UID: 0 PID: 4881 Comm: test_maps Not tainted 6.11.0-rc4+ #49
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
  Call Trace:
   <TASK>
   dump_stack_lvl+0x6e/0xb0
   dump_stack+0x10/0x20
   __lock_acquire+0x73e/0x36c0
   lock_acquire+0x182/0x450
   _raw_spin_lock_irqsave+0x43/0x70
   bpf_map_free_id.part.0+0x21/0x70
   bpf_map_put+0xcf/0x110
   bpf_map_fd_put_ptr+0x9a/0xb0
   free_htab_elem+0x69/0xe0
   htab_map_update_elem+0x50f/0xa80
   bpf_fd_htab_map_update_elem+0x131/0x270
   htab_map_update_elem+0x50f/0xa80
   bpf_fd_htab_map_update_elem+0x131/0x270
   bpf_map_update_value+0x266/0x380
   __sys_bpf+0x21bb/0x36b0
   __x64_sys_bpf+0x45/0x60
   x64_sys_call+0x1b2a/0x20d0
   do_syscall_64+0x5d/0x100
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

One way to fix the lockdep warning is using raw_spinlock_t for
map_idr_lock as well. However, bpf_map_alloc_id() invokes
idr_alloc_cyclic() after acquiring map_idr_lock, it will trigger a
similar lockdep warning because the slab's lock (s->cpu_slab->lock) is
still a spinlock.

Instead of changing map_idr_lock's type, fix the issue by invoking
htab_put_fd_value() after htab_unlock_bucket(). However, only deferring
the invocation of htab_put_fd_value() is not enough, because the old map
pointers in htab of maps can not be saved during batched deletion.
Therefore, also defer the invocation of free_htab_elem(), so these
to-be-freed elements could be linked together similar to lru map.

There are four callers for ->map_fd_put_ptr:

(1) alloc_htab_elem() (through htab_put_fd_value())
It invokes ->map_fd_put_ptr() under a raw_spinlock_t. The invocation of
htab_put_fd_value() can not simply move after htab_unlock_bucket(),
because the old element has already been stashed in htab->extra_elems.
It may be reused immediately after htab_unlock_bucket() and the
invocation of htab_put_fd_value() after htab_unlock_bucket() may release
the newly-added element incorrectly. Therefore, saving the map pointer
of the old element for htab of maps before unlocking the bucket and
releasing the map_ptr after unlock. Beside the map pointer in the old
element, should do the same thing for the special fields in the old
element as well.

(2) free_htab_elem() (through htab_put_fd_value())
Its caller includes __htab_map_lookup_and_delete_elem(),
htab_map_delete_elem() and __htab_map_lookup_and_delete_batch().

For htab_map_delete_elem(), simply invoke free_htab_elem() after
htab_unlock_bucket(). For __htab_map_lookup_and_delete_batch(), just
like lru map, linking the to-be-freed element into node_to_free list
and invoking free_htab_elem() for these element after unlock. It is safe
to reuse batch_flink as the link for node_to_free, because these
elements have been removed from the hash llist.

Because htab of maps doesn't support lookup_and_delete operation,
__htab_map_lookup_and_delete_elem() doesn't have the problem, so kept
it as is.

(3) fd_htab_map_free()
It invokes ->map_fd_put_ptr without raw_spinlock_t.

(4) bpf_fd_htab_map_update_elem()
It invokes ->map_fd_put_ptr without raw_spinlock_t.

After moving free_htab_elem() outside htab bucket lock scope, using
pcpu_freelist_push() instead of __pcpu_freelist_push() to disable
the irq before freeing elements, and protecting the invocations of
bpf_mem_cache_free() with migrate_{disable|enable} pair.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 56 ++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b14b87463ee0..3ec941a0ea41 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -896,9 +896,12 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
 	check_and_free_fields(htab, l);
+
+	migrate_disable();
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
 	bpf_mem_cache_free(&htab->ma, l);
+	migrate_enable();
 }
 
 static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
@@ -948,7 +951,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab_is_prealloc(htab)) {
 		bpf_map_dec_elem_count(&htab->map);
 		check_and_free_fields(htab, l);
-		__pcpu_freelist_push(&htab->freelist, &l->fnode);
+		pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		dec_elem_count(htab);
 		htab_elem_free(htab, l);
@@ -1018,7 +1021,6 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			 */
 			pl_new = this_cpu_ptr(htab->extra_elems);
 			l_new = *pl_new;
-			htab_put_fd_value(htab, old_elem);
 			*pl_new = old_elem;
 		} else {
 			struct pcpu_freelist_node *l;
@@ -1105,6 +1107,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	struct htab_elem *l_new = NULL, *l_old;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
+	void *old_map_ptr;
 	struct bucket *b;
 	u32 key_size, hash;
 	int ret;
@@ -1183,12 +1186,27 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
 	if (l_old) {
 		hlist_nulls_del_rcu(&l_old->hash_node);
+
+		/* l_old has already been stashed in htab->extra_elems, free
+		 * its special fields before it is available for reuse. Also
+		 * save the old map pointer in htab of maps before unlock
+		 * and release it after unlock.
+		 */
+		old_map_ptr = NULL;
+		if (htab_is_prealloc(htab)) {
+			if (map->ops->map_fd_put_ptr)
+				old_map_ptr = fd_htab_map_get_ptr(map, l_old);
+			check_and_free_fields(htab, l_old);
+		}
+	}
+	htab_unlock_bucket(htab, b, hash, flags);
+	if (l_old) {
+		if (old_map_ptr)
+			map->ops->map_fd_put_ptr(map, old_map_ptr, true);
 		if (!htab_is_prealloc(htab))
 			free_htab_elem(htab, l_old);
-		else
-			check_and_free_fields(htab, l_old);
 	}
-	ret = 0;
+	return 0;
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
 	return ret;
@@ -1432,15 +1450,15 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 		return ret;
 
 	l = lookup_elem_raw(head, hash, key, key_size);
-
-	if (l) {
+	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
-		free_htab_elem(htab, l);
-	} else {
+	else
 		ret = -ENOENT;
-	}
 
 	htab_unlock_bucket(htab, b, hash, flags);
+
+	if (l)
+		free_htab_elem(htab, l);
 	return ret;
 }
 
@@ -1853,13 +1871,14 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			 * may cause deadlock. See comments in function
 			 * prealloc_lru_pop(). Let us do bpf_lru_push_free()
 			 * after releasing the bucket lock.
+			 *
+			 * For htab of maps, htab_put_fd_value() in
+			 * free_htab_elem() may acquire a spinlock with bucket
+			 * lock being held and it violates the lock rule, so
+			 * invoke free_htab_elem() after unlock as well.
 			 */
-			if (is_lru_map) {
-				l->batch_flink = node_to_free;
-				node_to_free = l;
-			} else {
-				free_htab_elem(htab, l);
-			}
+			l->batch_flink = node_to_free;
+			node_to_free = l;
 		}
 		dst_key += key_size;
 		dst_val += value_size;
@@ -1871,7 +1890,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	while (node_to_free) {
 		l = node_to_free;
 		node_to_free = node_to_free->batch_flink;
-		htab_lru_push_free(htab, l);
+		if (is_lru_map)
+			htab_lru_push_free(htab, l);
+		else
+			free_htab_elem(htab, l);
 	}
 
 next_batch:
-- 
2.29.2


