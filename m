Return-Path: <bpf+bounces-50298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B34A24D03
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50983168A75
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE071E7C13;
	Sun,  2 Feb 2025 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="dsumA9HK"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F721DC9B6
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482661; cv=none; b=KBOptyxR4HI1j4p5RturKrOx6flhniEsJpkW+/dU6BOr3eJ9xUGmpYnhXfNWX0qra2mR2lWVFv6r8le/jNBhTK8O4rR3QoM0FUSchAtiy5xO3iEwHIWOu4Jh5VoC0FzrzF2eYtQZu/0FWN84rwVTJmghy+UoyIBZsnNAes/TTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482661; c=relaxed/simple;
	bh=nrEUDb2yI4y1BzlEM575yaU6iQwiTJdDE458/YxHbuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsMWFgaioAsnkkMr4HpbxUZVznG8+Jk8caIer8W1deXVyM9xh460N8NajR95aKVgCNwieMHOt8FMtPTVJTVd/AQ35og8d4nEvsZgNX5Ce3oPZKgkKAZRuCNtNK0TzRTN6hSenvjLsSMY79oMsbX4XMCg+zayRtfduH+sXYhfgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=dsumA9HK; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 920B81C241E
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:57 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:to:from:from; s=dkim; t=1738482656; x=1739346657; bh=nr
	EUDb2yI4y1BzlEM575yaU6iQwiTJdDE458/YxHbuY=; b=dsumA9HKppcYTl0U0I
	3Qe1Ltk1VVEQ4iPE9T2CduWj4FmYtZBH4gkgHl08b4Yyl/aPfEtvXIkrtilIbzx+
	wsXscOcTkeSfiqsIFq5OOFKxxA4KIWUrU7SDSSAE7jclLvUrF+m1shGVYdpmEu4/
	VyHOH8GMzNKIAgup9a2V948j0=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qiY3URQ7PNye for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:56 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id E9D281C2424;
	Sun,  2 Feb 2025 10:50:26 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.1 16/16] bpf: Switch to bpf mem allocator for LPM trie
Date: Sun,  2 Feb 2025 07:46:53 +0000
Message-ID: <20250202074709.932174-17-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

commit 3d8dc43eb2a3d179809f5fc27c88c93a57ea123d upstream.

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
Link: https://lore.kernel.org/r/20241206110622.1161752-7-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/lpm_trie.c | 71 +++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 6c96241f49a4..12078b832132 100644
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
@@ -279,17 +280,18 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
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
 
@@ -317,7 +319,7 @@ static int trie_update_elem(struct bpf_map *map,
 			    void *_key, void *value, u64 flags)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
-	struct lpm_trie_node *node, *im_node, *new_node = NULL;
+	struct lpm_trie_node *node, *im_node, *new_node;
 	struct lpm_trie_node *free_node = NULL;
 	struct lpm_trie_node __rcu **slot;
 	struct bpf_lpm_trie_key_u8 *key = _key;
@@ -332,14 +334,14 @@ static int trie_update_elem(struct bpf_map *map,
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
@@ -415,7 +417,8 @@ static int trie_update_elem(struct bpf_map *map,
 		goto out;
 	}
 
-	im_node = lpm_trie_node_alloc(trie, NULL);
+	/* migration is disabled within the locked scope */
+	im_node = lpm_trie_node_alloc(trie, NULL, false);
 	if (!im_node) {
 		trie->n_entries--;
 		ret = -ENOMEM;
@@ -439,10 +442,13 @@ static int trie_update_elem(struct bpf_map *map,
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
@@ -540,8 +546,11 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 
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
@@ -563,6 +572,8 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 static struct bpf_map *trie_alloc(union bpf_attr *attr)
 {
 	struct lpm_trie *trie;
+	size_t leaf_size;
+	int err;
 
 	if (!bpf_capable())
 		return ERR_PTR(-EPERM);
@@ -590,7 +601,17 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 
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
@@ -622,13 +643,17 @@ static void trie_free(struct bpf_map *map)
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
2.43.0


