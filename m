Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4347F16A949
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2020 16:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgBXPEm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Feb 2020 10:04:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgBXPDX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Feb 2020 10:03:23 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6FG2-00052k-6l; Mon, 24 Feb 2020 16:02:54 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7B6B7104092;
        Mon, 24 Feb 2020 16:02:44 +0100 (CET)
Message-Id: <20200224145644.420416916@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 15:01:50 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [patch V3 19/22] bpf: Factor out hashtab bucket lock operations
References: <20200224140131.461979697@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As a preparation for making the BPF locking RT friendly, factor out the
hash bucket lock operations into inline functions. This allows to do the
necessary RT modification in one place instead of sprinkling it all over
the place. No functional change.

The now unused htab argument of the lock/unlock functions will be used in
the next step which adds PREEMPT_RT support.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Adopt to the lock changes in __htab_map_lookup_and_delete_batch()
---
 kernel/bpf/hashtab.c |   69 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 23 deletions(-)

--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -88,6 +88,32 @@ struct htab_elem {
 	char key[0] __aligned(8);
 };
 
+static void htab_init_buckets(struct bpf_htab *htab)
+{
+	unsigned i;
+
+	for (i = 0; i < htab->n_buckets; i++) {
+		INIT_HLIST_NULLS_HEAD(&htab->buckets[i].head, i);
+		raw_spin_lock_init(&htab->buckets[i].lock);
+	}
+}
+
+static inline unsigned long htab_lock_bucket(const struct bpf_htab *htab,
+					     struct bucket *b)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&b->lock, flags);
+	return flags;
+}
+
+static inline void htab_unlock_bucket(const struct bpf_htab *htab,
+				      struct bucket *b,
+				      unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&b->lock, flags);
+}
+
 static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
 
 static bool htab_is_lru(const struct bpf_htab *htab)
@@ -348,8 +374,8 @@ static struct bpf_map *htab_map_alloc(un
 	bool percpu_lru = (attr->map_flags & BPF_F_NO_COMMON_LRU);
 	bool prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
 	struct bpf_htab *htab;
-	int err, i;
 	u64 cost;
+	int err;
 
 	htab = kzalloc(sizeof(*htab), GFP_USER);
 	if (!htab)
@@ -411,10 +437,7 @@ static struct bpf_map *htab_map_alloc(un
 	else
 		htab->hashrnd = get_random_int();
 
-	for (i = 0; i < htab->n_buckets; i++) {
-		INIT_HLIST_NULLS_HEAD(&htab->buckets[i].head, i);
-		raw_spin_lock_init(&htab->buckets[i].lock);
-	}
+	htab_init_buckets(htab);
 
 	if (prealloc) {
 		err = prealloc_init(htab);
@@ -622,7 +645,7 @@ static bool htab_lru_map_delete_node(voi
 	b = __select_bucket(htab, tgt_l->hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
 		if (l == tgt_l) {
@@ -630,7 +653,7 @@ static bool htab_lru_map_delete_node(voi
 			break;
 		}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 
 	return l == tgt_l;
 }
@@ -896,7 +919,7 @@ static int htab_map_update_elem(struct b
 		 */
 	}
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -937,7 +960,7 @@ static int htab_map_update_elem(struct b
 	}
 	ret = 0;
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	return ret;
 }
 
@@ -975,7 +998,7 @@ static int htab_lru_map_update_elem(stru
 		return -ENOMEM;
 	memcpy(l_new->key + round_up(map->key_size, 8), value, map->value_size);
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -994,7 +1017,7 @@ static int htab_lru_map_update_elem(stru
 	ret = 0;
 
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 
 	if (ret)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
@@ -1029,7 +1052,7 @@ static int __htab_percpu_map_update_elem
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1052,7 +1075,7 @@ static int __htab_percpu_map_update_elem
 	}
 	ret = 0;
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	return ret;
 }
 
@@ -1092,7 +1115,7 @@ static int __htab_lru_percpu_map_update_
 			return -ENOMEM;
 	}
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1114,7 +1137,7 @@ static int __htab_lru_percpu_map_update_
 	}
 	ret = 0;
 err:
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	if (l_new)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
 	return ret;
@@ -1152,7 +1175,7 @@ static int htab_map_delete_elem(struct b
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1162,7 +1185,7 @@ static int htab_map_delete_elem(struct b
 		ret = 0;
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	return ret;
 }
 
@@ -1184,7 +1207,7 @@ static int htab_lru_map_delete_elem(stru
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
+	flags = htab_lock_bucket(htab, b);
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1193,7 +1216,7 @@ static int htab_lru_map_delete_elem(stru
 		ret = 0;
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	if (l)
 		bpf_lru_push_free(&htab->lru, &l->lru_node);
 	return ret;
@@ -1342,7 +1365,7 @@ static int
 	head = &b->head;
 	/* do not grab the lock unless need it (bucket_cnt > 0). */
 	if (locked)
-		raw_spin_lock_irqsave(&b->lock, flags);
+		flags = htab_lock_bucket(htab, b);
 
 	bucket_cnt = 0;
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
@@ -1359,7 +1382,7 @@ static int
 		/* Note that since bucket_cnt > 0 here, it is implicit
 		 * that the locked was grabbed, so release it.
 		 */
-		raw_spin_unlock_irqrestore(&b->lock, flags);
+		htab_unlock_bucket(htab, b, flags);
 		rcu_read_unlock();
 		bpf_enable_instrumentation();
 		goto after_loop;
@@ -1370,7 +1393,7 @@ static int
 		/* Note that since bucket_cnt > 0 here, it is implicit
 		 * that the locked was grabbed, so release it.
 		 */
-		raw_spin_unlock_irqrestore(&b->lock, flags);
+		htab_unlock_bucket(htab, b, flags);
 		rcu_read_unlock();
 		bpf_enable_instrumentation();
 		kvfree(keys);
@@ -1423,7 +1446,7 @@ static int
 		dst_val += value_size;
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	htab_unlock_bucket(htab, b, flags);
 	locked = false;
 
 	while (node_to_free) {

