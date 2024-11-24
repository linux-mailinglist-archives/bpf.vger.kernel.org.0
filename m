Return-Path: <bpf+bounces-45538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47719D7548
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 16:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC201C01068
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E822E0BA;
	Sun, 24 Nov 2024 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTQzQUI3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8322E0AA;
	Sun, 24 Nov 2024 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456128; cv=none; b=F3FOW2hpMj2x9WIdiOZW1fX8NylFu/1bAElX38AZPWkcwgmr2q9ct9kDKejp3VPZA5poO4v00du3JgJLXgCXQqIR/W6pB1cObn4k+IadDrrKz6eK6BOVLTHTcpfZsyr9NJaRD1/SNndDs2isfj/tPc/VVb2rcrBlOYGr5Wg9cXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456128; c=relaxed/simple;
	bh=7e4SiUFM5r8YN94FPe7V7Eh9WtUZNj9G/gBgtpbL5Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRWM8GLxaOBaRjbX8sZ+bA+uDD6TcDVymRcDescjUyrUk4P0Y+mzBKnzQuchvFMWeCK1o5FSn6mP9Ald2FKcSJprF30dxBbKOrNzy/U1HkaqDhwwq7lJ4/Ofwp34EG/6OH4LWz3RCRlvJBNL0H8SRTZsQVa3tQaBpqo4pJYuTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTQzQUI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C70AC4CECC;
	Sun, 24 Nov 2024 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456127;
	bh=7e4SiUFM5r8YN94FPe7V7Eh9WtUZNj9G/gBgtpbL5Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTQzQUI3BRnqM+E7Jk+h1haFUQ+tEOvzN7prkmpgcU1L7125UboDZOpTLt/XcPt+M
	 1YTh2U8Sn8vGmi1tt7mED/1JjlPAhrmrVHUvpoMvXdt0IsJ2yPC7V9NRJgLs8ZpYVg
	 5BW1dCjltSXSoLrilt43U2rBxToLiX5HIYqc0TWlZm66gnDphKSA4oaK6bFMfYjWlS
	 oJ1DUscDbZ3zuIg34nRWbn35Fy8P+FFw9bB2wQ2WVu+6LaDunxqW1KOPEgfQK1Zuv3
	 cuDz6W3KzCtwidsbBTjMuI+tUz/RBd5jo1iCP4Kr4dIPs2OskEfbhb1WQGVmgxWQeH
	 zDGL+N9/zyNYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 51/61] bpf: Call free_htab_elem() after htab_unlock_bucket()
Date: Sun, 24 Nov 2024 08:45:26 -0500
Message-ID: <20241124134637.3346391-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit b9e9ed90b10c82a4e9d4d70a2890f06bfcdd3b78 ]

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
Link: https://lore.kernel.org/r/20241106063542.357743-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/hashtab.c | 56 ++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 7c64ad4f3732b..fc34f72702cc4 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -892,9 +892,12 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
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
@@ -944,7 +947,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab_is_prealloc(htab)) {
 		bpf_map_dec_elem_count(&htab->map);
 		check_and_free_fields(htab, l);
-		__pcpu_freelist_push(&htab->freelist, &l->fnode);
+		pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		dec_elem_count(htab);
 		htab_elem_free(htab, l);
@@ -1014,7 +1017,6 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			 */
 			pl_new = this_cpu_ptr(htab->extra_elems);
 			l_new = *pl_new;
-			htab_put_fd_value(htab, old_elem);
 			*pl_new = old_elem;
 		} else {
 			struct pcpu_freelist_node *l;
@@ -1100,6 +1102,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	struct htab_elem *l_new = NULL, *l_old;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
+	void *old_map_ptr;
 	struct bucket *b;
 	u32 key_size, hash;
 	int ret;
@@ -1178,12 +1181,27 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
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
@@ -1427,15 +1445,15 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
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
 
@@ -1842,13 +1860,14 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
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
@@ -1860,7 +1879,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
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
2.43.0


