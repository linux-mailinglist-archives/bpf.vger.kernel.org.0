Return-Path: <bpf+bounces-46264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3D99E6CA5
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 11:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B958B188446F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A11FC107;
	Fri,  6 Dec 2024 10:54:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52DD1FA260
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482471; cv=none; b=sJhP5w3CF6wMBmUgupmG5u/Wj386hZRs4i3usE8C1kEyhu+2NxOewUA9ukARc8Ux12hw8bVBTQK2fXq4VSxVNfRKsRzClE8rY0LM2QIbY8LFqXnrXXrkeWj7Q3GGJBjL9h0DbRMM8OYql3aloR/w3ACKZNho/2ijmFa2iDa3I60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482471; c=relaxed/simple;
	bh=Ko+ZHoCaRJdjcIkFzUQc21DVMIfB13AbbaugCB/WDBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0zr2ZqHGCC+6DL4khdXJjqAbSqxHdORgI8Y+6o+sRcONf0i4AGy9xFt95YnKY0JfsOv7ikgi81LvzlK9Ax1YKR/YbNHqnUobM34Injeb2qyn9qHhdcd2q77yL+A7SPQdTyterOAATb3BicDSPzrdus855Qm8udahnDpDvh/Q2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y4Smm4XXTz4f3jdR
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:54:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B1EA11A058E
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:54:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4fS11JnmMhIDw--.40874S10;
	Fri, 06 Dec 2024 18:54:18 +0800 (CST)
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v3 6/9] bpf: Switch to bpf mem allocator for LPM trie
Date: Fri,  6 Dec 2024 19:06:19 +0800
Message-Id: <20241206110622.1161752-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241206110622.1161752-1-houtao@huaweicloud.com>
References: <20241206110622.1161752-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4fS11JnmMhIDw--.40874S10
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4kCrWfCw1kZF47urWxWFg_yoWfKw45pF
	Wag34fAr4DXr45Wr4vqrs8Zr98Zw48Kw4UGas5WayrZF90vr93JF18ZF40vFy5CFWxCF43
	tF1UtrWvvw4DCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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

Multiple syzbot warnings have been reported. These warnings are mainly
about the lock order between trie->lock and kmalloc()'s internal lock.
See report [1] as an example:

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc7-syzkaller-00003-g4376e966ecb7 #0 Not tainted
------------------------------------------------------
syz.3.2069/15008 is trying to acquire lock:
ffff88801544e6d8 (&n->list_lock){-.-.}-{2:2}, at: get_partial_node ...

but task is already holding lock:
ffff88802dcc89f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem ...

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&trie->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave
       _raw_spin_lock_irqsave+0x3a/0x60
       trie_delete_elem+0xb0/0x820
       ___bpf_prog_run+0x3e51/0xabd0
       __bpf_prog_run32+0xc1/0x100
       bpf_dispatcher_nop_func
       ......
       bpf_trace_run2+0x231/0x590
       __bpf_trace_contention_end+0xca/0x110
       trace_contention_end.constprop.0+0xea/0x170
       __pv_queued_spin_lock_slowpath+0x28e/0xcc0
       pv_queued_spin_lock_slowpath
       queued_spin_lock_slowpath
       queued_spin_lock
       do_raw_spin_lock+0x210/0x2c0
       __raw_spin_lock_irqsave
       _raw_spin_lock_irqsave+0x42/0x60
       __put_partials+0xc3/0x170
       qlink_free
       qlist_free_all+0x4e/0x140
       kasan_quarantine_reduce+0x192/0x1e0
       __kasan_slab_alloc+0x69/0x90
       kasan_slab_alloc
       slab_post_alloc_hook
       slab_alloc_node
       kmem_cache_alloc_node_noprof+0x153/0x310
       __alloc_skb+0x2b1/0x380
       ......

-> #0 (&n->list_lock){-.-.}-{2:2}:
       check_prev_add
       check_prevs_add
       validate_chain
       __lock_acquire+0x2478/0x3b30
       lock_acquire
       lock_acquire+0x1b1/0x560
       __raw_spin_lock_irqsave
       _raw_spin_lock_irqsave+0x3a/0x60
       get_partial_node.part.0+0x20/0x350
       get_partial_node
       get_partial
       ___slab_alloc+0x65b/0x1870
       __slab_alloc.constprop.0+0x56/0xb0
       __slab_alloc_node
       slab_alloc_node
       __do_kmalloc_node
       __kmalloc_node_noprof+0x35c/0x440
       kmalloc_node_noprof
       bpf_map_kmalloc_node+0x98/0x4a0
       lpm_trie_node_alloc
       trie_update_elem+0x1ef/0xe00
       bpf_map_update_value+0x2c1/0x6c0
       map_update_elem+0x623/0x910
       __sys_bpf+0x90c/0x49a0
       ...

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(&n->list_lock);
                               lock(&trie->lock);
  lock(&n->list_lock);

 *** DEADLOCK ***

[1]: https://syzkaller.appspot.com/bug?extid=9045c0a3d5a7f1b119f7

A bpf program attached to trace_contention_end() triggers after
acquiring &n->list_lock. The program invokes trie_delete_elem(), which
then acquires trie->lock. However, it is possible that another
process is invoking trie_update_elem(). trie_update_elem() will acquire
trie->lock first, then invoke kmalloc_node(). kmalloc_node() may invoke
get_partial_node() and try to acquire &n->list_lock (not necessarily the
same lock object). Therefore, lockdep warns about the circular locking
dependency.

Invoking kmalloc() before acquiring trie->lock could fix the warning.
However, since BPF programs call be invoked from any context (e.g.,
through kprobe/tracepoint/fentry), there may still be lock ordering
problems for internal locks in kmalloc() or trie->lock itself.

To eliminate these potential lock ordering problems with kmalloc()'s
internal locks, replacing kmalloc()/kfree()/kfree_rcu() with equivalent
BPF memory allocator APIs that can be invoked in any context. The lock
ordering problems with trie->lock (e.g., reentrance) will be handled
separately.

Three aspects of this change require explanation:

1. Intermediate and leaf nodes are allocated from the same allocator.
Since the value size of LPM trie is usually small, using a single
alocator reduces the memory overhead of the BPF memory allocator.

2. Leaf nodes are allocated before disabling IRQs. This handles cases
where leaf_size is large (e.g., > 4KB - 8) and updates require
intermediate node allocation. If leaf nodes were allocated in
IRQ-disabled region, the free objects in BPF memory allocator would not
be refilled timely and the intermediate node allocation may fail.

3. Paired migrate_{disable|enable}() calls for node alloc and free. The
BPF memory allocator uses per-CPU struct internally, these paired calls
are necessary to guarantee correctness.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/lpm_trie.c | 71 +++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 9ba6ae145239..f850360e75ce 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -15,6 +15,7 @@
 #include <net/ipv6.h>
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_mem_alloc.h>
 
 /* Intermediate node */
 #define LPM_TREE_NODE_FLAG_IM BIT(0)
@@ -22,7 +23,6 @@
 struct lpm_trie_node;
 
 struct lpm_trie_node {
-	struct rcu_head rcu;
 	struct lpm_trie_node __rcu	*child[2];
 	u32				prefixlen;
 	u32				flags;
@@ -32,6 +32,7 @@ struct lpm_trie_node {
 struct lpm_trie {
 	struct bpf_map			map;
 	struct lpm_trie_node __rcu	*root;
+	struct bpf_mem_alloc		ma;
 	size_t				n_entries;
 	size_t				max_prefixlen;
 	size_t				data_size;
@@ -287,17 +288,18 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 	return found->data + trie->data_size;
 }
 
-static struct lpm_trie_node *lpm_trie_node_alloc(const struct lpm_trie *trie,
-						 const void *value)
+static struct lpm_trie_node *lpm_trie_node_alloc(struct lpm_trie *trie,
+						 const void *value,
+						 bool disable_migration)
 {
 	struct lpm_trie_node *node;
-	size_t size = sizeof(struct lpm_trie_node) + trie->data_size;
 
-	if (value)
-		size += trie->map.value_size;
+	if (disable_migration)
+		migrate_disable();
+	node = bpf_mem_cache_alloc(&trie->ma);
+	if (disable_migration)
+		migrate_enable();
 
-	node = bpf_map_kmalloc_node(&trie->map, size, GFP_NOWAIT | __GFP_NOWARN,
-				    trie->map.numa_node);
 	if (!node)
 		return NULL;
 
@@ -325,7 +327,7 @@ static long trie_update_elem(struct bpf_map *map,
 			     void *_key, void *value, u64 flags)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
-	struct lpm_trie_node *node, *im_node, *new_node = NULL;
+	struct lpm_trie_node *node, *im_node, *new_node;
 	struct lpm_trie_node *free_node = NULL;
 	struct lpm_trie_node __rcu **slot;
 	struct bpf_lpm_trie_key_u8 *key = _key;
@@ -340,14 +342,14 @@ static long trie_update_elem(struct bpf_map *map,
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	spin_lock_irqsave(&trie->lock, irq_flags);
+	/* Allocate and fill a new node. Need to disable migration before
+	 * invoking bpf_mem_cache_alloc().
+	 */
+	new_node = lpm_trie_node_alloc(trie, value, true);
+	if (!new_node)
+		return -ENOMEM;
 
-	/* Allocate and fill a new node */
-	new_node = lpm_trie_node_alloc(trie, value);
-	if (!new_node) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	spin_lock_irqsave(&trie->lock, irq_flags);
 
 	new_node->prefixlen = key->prefixlen;
 	RCU_INIT_POINTER(new_node->child[0], NULL);
@@ -423,7 +425,8 @@ static long trie_update_elem(struct bpf_map *map,
 		goto out;
 	}
 
-	im_node = lpm_trie_node_alloc(trie, NULL);
+	/* migration is disabled within the locked scope */
+	im_node = lpm_trie_node_alloc(trie, NULL, false);
 	if (!im_node) {
 		trie->n_entries--;
 		ret = -ENOMEM;
@@ -447,10 +450,13 @@ static long trie_update_elem(struct bpf_map *map,
 	rcu_assign_pointer(*slot, im_node);
 
 out:
-	if (ret)
-		kfree(new_node);
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
-	kfree_rcu(free_node, rcu);
+
+	migrate_disable();
+	if (ret)
+		bpf_mem_cache_free(&trie->ma, new_node);
+	bpf_mem_cache_free_rcu(&trie->ma, free_node);
+	migrate_enable();
 
 	return ret;
 }
@@ -548,8 +554,11 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 
 out:
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
-	kfree_rcu(free_parent, rcu);
-	kfree_rcu(free_node, rcu);
+
+	migrate_disable();
+	bpf_mem_cache_free_rcu(&trie->ma, free_parent);
+	bpf_mem_cache_free_rcu(&trie->ma, free_node);
+	migrate_enable();
 
 	return ret;
 }
@@ -571,6 +580,8 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 static struct bpf_map *trie_alloc(union bpf_attr *attr)
 {
 	struct lpm_trie *trie;
+	size_t leaf_size;
+	int err;
 
 	/* check sanity of attributes */
 	if (attr->max_entries == 0 ||
@@ -595,7 +606,17 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 
 	spin_lock_init(&trie->lock);
 
+	/* Allocate intermediate and leaf nodes from the same allocator */
+	leaf_size = sizeof(struct lpm_trie_node) + trie->data_size +
+		    trie->map.value_size;
+	err = bpf_mem_alloc_init(&trie->ma, leaf_size, false);
+	if (err)
+		goto free_out;
 	return &trie->map;
+
+free_out:
+	bpf_map_area_free(trie);
+	return ERR_PTR(err);
 }
 
 static void trie_free(struct bpf_map *map)
@@ -627,13 +648,17 @@ static void trie_free(struct bpf_map *map)
 				continue;
 			}
 
-			kfree(node);
+			/* No bpf program may access the map, so freeing the
+			 * node without waiting for the extra RCU GP.
+			 */
+			bpf_mem_cache_raw_free(node);
 			RCU_INIT_POINTER(*slot, NULL);
 			break;
 		}
 	}
 
 out:
+	bpf_mem_alloc_destroy(&trie->ma);
 	bpf_map_area_free(trie);
 }
 
-- 
2.29.2


