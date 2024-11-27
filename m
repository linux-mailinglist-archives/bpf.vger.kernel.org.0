Return-Path: <bpf+bounces-45670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5399DA007
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 01:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2DA284BA1
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD4B8F49;
	Wed, 27 Nov 2024 00:34:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC12581
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732667686; cv=none; b=ADQtERikqzC84r2dnCasO6Cu/Fw05PTPTA/OFWrFJuv4LsWe89tdVrbT6ueFHzMxkB5LodQhOfDyYgGMp2NBMYUE61hiMUe41adf5scNQ0s25T7zxjDmD+BUf3fBa0d1UDnNGOzYbY3h6sHKsLVcSqVq37XZp87I/7lNZNkE0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732667686; c=relaxed/simple;
	bh=99Yhd187pRH50R+6Z1qc0DAzDeX5oNDoOD++KskOg9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kY5WwFqwS9UUST0rg5388fHTG+8H2cxFsa5G1RCQ1hMRDXNCilffsUJezCV49BSBIa5MTMKaMCQjXew5x48YNCUhvxrPvA+zhPT1muncuUs7v+wtcPDNhINgyDA888Vf6Cy5DnGm3iG8c1ueoafe8V6GRLE/wEWzaVSgpOT8d/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XygRx20xpz4f3jXg
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:34:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0C90F1A0568
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:34:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4cVaUZn5pO9Cw--.38194S10;
	Wed, 27 Nov 2024 08:34:37 +0800 (CST)
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
Subject: [PATCH bpf v2 6/9] bpf: Switch to bpf mem allocator for LPM trie
Date: Wed, 27 Nov 2024 08:46:38 +0800
Message-Id: <20241127004641.1118269-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241127004641.1118269-1-houtao@huaweicloud.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4cVaUZn5pO9Cw--.38194S10
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4kCrWfCw1kZF47urWxWFg_yoW3XFy5pF
	ZIg34fAr4DXr4Uur4vqr4DZryUAw48Kw4UGas5WayrZF90vr9rJF18ZF40vFyYkFZ7Crs8
	tF1UtrW0vw4DC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Two aspects of this change require explanation:

1. Intermediate and leaf nodes are allocated from the same allocator.
The value size of LPM trie is usually small and only use one allocator
reduces the memory overhead of BPF memory allocator.

2. nodes are freed before invoking spin_unlock_irqrestore(). Therefore,
there is no need to add paired migrate_{disable|enable}() calls for
these free operations.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/lpm_trie.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index a1d72d2ec22f..4a3d837e9c9a 100644
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
@@ -287,17 +288,12 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 	return found->data + trie->data_size;
 }
 
-static struct lpm_trie_node *lpm_trie_node_alloc(const struct lpm_trie *trie,
+static struct lpm_trie_node *lpm_trie_node_alloc(struct lpm_trie *trie,
 						 const void *value)
 {
 	struct lpm_trie_node *node;
-	size_t size = sizeof(struct lpm_trie_node) + trie->data_size;
 
-	if (value)
-		size += trie->map.value_size;
-
-	node = bpf_map_kmalloc_node(&trie->map, size, GFP_NOWAIT | __GFP_NOWARN,
-				    trie->map.numa_node);
+	node = bpf_mem_cache_alloc(&trie->ma);
 	if (!node)
 		return NULL;
 
@@ -448,9 +444,9 @@ static long trie_update_elem(struct bpf_map *map,
 
 out:
 	if (ret)
-		kfree(new_node);
+		bpf_mem_cache_free(&trie->ma, new_node);
+	bpf_mem_cache_free_rcu(&trie->ma, free_node);
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
-	kfree_rcu(free_node, rcu);
 
 	return ret;
 }
@@ -547,9 +543,9 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	free_node = node;
 
 out:
+	bpf_mem_cache_free_rcu(&trie->ma, free_parent);
+	bpf_mem_cache_free_rcu(&trie->ma, free_node);
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
-	kfree_rcu(free_parent, rcu);
-	kfree_rcu(free_node, rcu);
 
 	return ret;
 }
@@ -571,6 +567,8 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 static struct bpf_map *trie_alloc(union bpf_attr *attr)
 {
 	struct lpm_trie *trie;
+	size_t leaf_size;
+	int err;
 
 	/* check sanity of attributes */
 	if (attr->max_entries == 0 ||
@@ -595,7 +593,17 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 
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
@@ -627,13 +635,17 @@ static void trie_free(struct bpf_map *map)
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


