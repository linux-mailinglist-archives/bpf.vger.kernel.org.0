Return-Path: <bpf+bounces-64475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F51CB1338F
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 06:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1231894262
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 04:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F62219A71;
	Mon, 28 Jul 2025 04:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwAic8/I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5EE217716;
	Mon, 28 Jul 2025 04:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753675985; cv=none; b=QmfVANw9pxJEZYt/qXmaY7AclQHPhAY63bM64SeE3HFPb4tp0f78MgE61dlm7fsfLE0ZiivYQi4asGdx10sCAuy1jFuu7musVtbnwY8/mhupPvCfiyUOnUa/68+kOacp0CzBGxs2JIzoGJDhXmQcyc7osQ+Kor3KUVGJf35cIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753675985; c=relaxed/simple;
	bh=/Xj3sOaOCNeqUFX5P0Wp28TH0ulruXkgsD0ebXMyvfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Frgj+n46SiRnzjNjZ5LlP9Ff2oef8r6sqedvRpDGvNwyRt6FXxeJ6JCA7GpTrezG/9jsVM2Qdpqnd1l7KFYIguKs/9H2KFbGrQKtprlhSaICFPHmSh0p047Nb5esCJJFtkgHdH47K0WuPyk9S9PlnOGX/0EqzeyFLWoeQlWnG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwAic8/I; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-23636167afeso33922125ad.3;
        Sun, 27 Jul 2025 21:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753675983; x=1754280783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dDuLpi2XdML7z9q3X9SSRyeitTIxFEVOUJtDB7FRXM=;
        b=NwAic8/I645j9PJw6OAAvOHA19DCwloI38xMt5YyiqBcJfJbSxoyiCZfr1XMnt+S6Z
         L/qT8ZTrC032UaoAk+f6u8K7M7sW41fnkL2rkS2wuuUSuKqfqFz3HMIvmv+ZEeHi+eoD
         izaAddtrYVPjApKY9CNb0BpyQo7CAuQq/uOnni39Mw7tFk5IVfuXpYZxS09SQ+RcRe/p
         JCSApWH3Hy+9ALbUzyes/yXpVVjJAVNXwi0e13rIFhCTR8Fal2SabRroIhyR3DwfgY4y
         W9xxunPKbfHVFZHhIqKwu/HOT/+tSfNK5rZakxcaGaooVFDexRxHTpvZFWXWQcEsUcne
         J2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753675983; x=1754280783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dDuLpi2XdML7z9q3X9SSRyeitTIxFEVOUJtDB7FRXM=;
        b=EfDl2lP9Q+/89V8IXlwMZU9eWeYDkAyIn4EYMubGFFGov8uJrtyCv8qUyz2x/XYPse
         iU7QjMRcRA+Wa4kJVUc2luHBKw3TN+SOcNihk9+BIIK0egxAmwMkaS3m8Wxrg0VDyEpA
         54Mr06w6g5Lf5BLQ/6oEQwYYR8S1gGwfLlBZWgaRIpY5hr0KD9sqSnI0iL22uGXE3XeC
         acezXm16q+zL2aUogkTZKnMsuxBcpkOpQgH2X2Iqw8jQjk7fSD1iy9nbY2YMg0H9viZn
         zNgkZSqybnbkJR7F2vLxAE7C+N9eOXTMmohv7/RlQA/orhryeD7SZjlVL3XwsBKFo3g2
         qHrA==
X-Forwarded-Encrypted: i=1; AJvYcCVM2D1Ff7xfv8qegH12RBqE7nw39TkfwElgmLNx+yI90zGw0oU0vC5i5t2FGiG4il3NaQA=@vger.kernel.org, AJvYcCVQFRus1Osfnn82fuKorUR3nqo7V8bRRZkgBfOXeyEYd0402d+Sp1TiQSs088UAfJ2KxNlnAvGLc3xKQsWo@vger.kernel.org, AJvYcCXpJt79mkKKMbCEPQ/Z5HZ7YAoNkM/7yOqQhTyqBZBE5JET3tfp4qgc1HVeQV9+dv9xslW7K7CU4+Q8x1nefOqrk7NU@vger.kernel.org
X-Gm-Message-State: AOJu0YxT7YZg/yIswTyAVCK4m3Ry/fnSUutTwLk31m6uA5E9BUKe24rg
	xysTK8qwZuHoK+M/4ZMfS0nLbnfyZdhhXqOTFx7/ukJeyN73kmLJpud6
X-Gm-Gg: ASbGncuUMlhA3haKPxy8zHDMptXGbEa/ky/xCs2C9MMm4XHAugpi13rYCNjRJzQbZme
	ybGeS+SitbEOiyU3WH19WfoijKgRkg8nco6wCP9CQHUIC+g82EbKZTKVSzhRy+ulXdiJ3LzVtYO
	vfFqsEQ7qbNkgDmqYlOkYgkNKf+YHF7Gf/0ANyU6d/IaE2/41hjmmqX/B1IPI59Lw/X0TXILsI6
	TeC8EisPphRb5BPTWIaoHRmuFo/EI9inu2DQCBqNEs7+1vSsWnJ1+oAHrcvMTtcJv9/jNMGYNi/
	10yUXAKneh79Bocw/uDoemecauAcdOl7KhLnTzjkReGyKNlfmaQir6dEHgr4FMxNhLg+aqizBx2
	aU2NO398xd1MLWP9eMdI=
X-Google-Smtp-Source: AGHT+IGX01LFBZYPPzjW+WAT4Mc3ZMKmNo/fMqJ2YCdk7j9r8w1TpTyxdQeiS3f8wUgLHP7lKowHXw==
X-Received: by 2002:a17:903:1c2:b0:234:ef42:5d69 with SMTP id d9443c01a7336-23fb30995c3mr161420655ad.13.1753675983055;
        Sun, 27 Jul 2025 21:13:03 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24008efc073sm20599175ad.58.2025.07.27.21.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 21:13:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/4] fprobe: use rhashtable
Date: Mon, 28 Jul 2025 12:12:48 +0800
Message-ID: <20250728041252.441040-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728041252.441040-1-dongml2@chinatelecom.cn>
References: <20250728041252.441040-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, all the kernel functions who are hooked by the fprobe will be
added to the hash table "fprobe_ip_table". The key of it is the function
address, and the value of it is "struct fprobe_hlist_node".

The budget of the hash table is FPROBE_IP_TABLE_SIZE, which is 256. And
this means the overhead of the hash table lookup will grow linearly if
the count of the functions in the fprobe more than 256. When we try to
hook all the kernel functions, the overhead will be huge.

Therefore, replace the hash table with rhashtable to reduce the overhead.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/fprobe.h |   2 +-
 kernel/trace/fprobe.c  | 144 +++++++++++++++++++++++------------------
 2 files changed, 82 insertions(+), 64 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 702099f08929..0c9b239f5485 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -26,7 +26,7 @@ typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
  * @fp: The fprobe which owns this.
  */
 struct fprobe_hlist_node {
-	struct hlist_node	hlist;
+	struct rhash_head	hlist;
 	unsigned long		addr;
 	struct fprobe		*fp;
 };
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ba7ff14f5339..b3e16303fc6a 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/rhashtable.h>
 
 #include <asm/fprobe.h>
 
@@ -41,47 +42,47 @@
  *  - RCU hlist traversal under disabling preempt
  */
 static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
-static struct hlist_head fprobe_ip_table[FPROBE_IP_TABLE_SIZE];
+static struct rhashtable fprobe_ip_table;
 static DEFINE_MUTEX(fprobe_mutex);
 
-/*
- * Find first fprobe in the hlist. It will be iterated twice in the entry
- * probe, once for correcting the total required size, the second time is
- * calling back the user handlers.
- * Thus the hlist in the fprobe_table must be sorted and new probe needs to
- * be added *before* the first fprobe.
- */
-static struct fprobe_hlist_node *find_first_fprobe_node(unsigned long ip)
+static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
 {
-	struct fprobe_hlist_node *node;
-	struct hlist_head *head;
+	return hash_ptr(*(unsigned long **)data, 32);
+}
 
-	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
-	hlist_for_each_entry_rcu(node, head, hlist,
-				 lockdep_is_held(&fprobe_mutex)) {
-		if (node->addr == ip)
-			return node;
-	}
-	return NULL;
+static int fprobe_node_cmp(struct rhashtable_compare_arg *arg,
+			   const void *ptr)
+{
+	unsigned long key = *(unsigned long *)arg->key;
+	const struct fprobe_hlist_node *n = ptr;
+
+	return n->addr != key;
+}
+
+static u32 fprobe_node_obj_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct fprobe_hlist_node *n = data;
+
+	return hash_ptr((void *)n->addr, 32);
 }
-NOKPROBE_SYMBOL(find_first_fprobe_node);
+
+static const struct rhashtable_params fprobe_rht_params = {
+	.head_offset		= offsetof(struct fprobe_hlist_node, hlist),
+	.key_offset		= offsetof(struct fprobe_hlist_node, addr),
+	.key_len		= sizeof_field(struct fprobe_hlist_node, addr),
+	.hashfn			= fprobe_node_hashfn,
+	.obj_hashfn		= fprobe_node_obj_hashfn,
+	.obj_cmpfn		= fprobe_node_cmp,
+	.automatic_shrinking	= true,
+};
 
 /* Node insertion and deletion requires the fprobe_mutex */
 static void insert_fprobe_node(struct fprobe_hlist_node *node)
 {
-	unsigned long ip = node->addr;
-	struct fprobe_hlist_node *next;
-	struct hlist_head *head;
-
 	lockdep_assert_held(&fprobe_mutex);
 
-	next = find_first_fprobe_node(ip);
-	if (next) {
-		hlist_add_before_rcu(&node->hlist, &next->hlist);
-		return;
-	}
-	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
-	hlist_add_head_rcu(&node->hlist, head);
+	rhashtable_insert_fast(&fprobe_ip_table, &node->hlist,
+			       fprobe_rht_params);
 }
 
 /* Return true if there are synonims */
@@ -92,9 +93,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 	/* Avoid double deleting */
 	if (READ_ONCE(node->fp) != NULL) {
 		WRITE_ONCE(node->fp, NULL);
-		hlist_del_rcu(&node->hlist);
+		rhashtable_remove_fast(&fprobe_ip_table, &node->hlist,
+				       fprobe_rht_params);
 	}
-	return !!find_first_fprobe_node(node->addr);
+	return !!rhashtable_lookup_fast(&fprobe_ip_table, &node->addr,
+					fprobe_rht_params);
 }
 
 /* Check existence of the fprobe */
@@ -249,25 +252,28 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 			struct ftrace_regs *fregs)
 {
-	struct fprobe_hlist_node *node, *first;
+	struct rhash_lock_head __rcu *const *bkt;
+	struct fprobe_hlist_node *node;
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
+	struct bucket_table *tbl;
+	struct rhash_head *head;
 	unsigned long ret_ip;
 	int reserved_words;
 	struct fprobe *fp;
+	unsigned int key;
 	int used, ret;
 
 	if (WARN_ON_ONCE(!fregs))
 		return 0;
 
-	first = node = find_first_fprobe_node(func);
-	if (unlikely(!first))
-		return 0;
-
+	tbl = rht_dereference_rcu(fprobe_ip_table.tbl, &fprobe_ip_table);
+	key = rht_key_hashfn(&fprobe_ip_table, tbl, &func, fprobe_rht_params);
+	bkt = rht_bucket(tbl, key);
 	reserved_words = 0;
-	hlist_for_each_entry_from_rcu(node, hlist) {
+	rht_for_each_entry_rcu_from(node, head, rht_ptr_rcu(bkt), tbl, key, hlist) {
 		if (node->addr != func)
-			break;
+			continue;
 		fp = READ_ONCE(node->fp);
 		if (!fp || !fp->exit_handler)
 			continue;
@@ -278,13 +284,13 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		reserved_words +=
 			FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->entry_data_size);
 	}
-	node = first;
 	if (reserved_words) {
 		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
 		if (unlikely(!fgraph_data)) {
-			hlist_for_each_entry_from_rcu(node, hlist) {
+			rht_for_each_entry_rcu_from(node, head, rht_ptr_rcu(bkt),
+						    tbl, key, hlist) {
 				if (node->addr != func)
-					break;
+					continue;
 				fp = READ_ONCE(node->fp);
 				if (fp && !fprobe_disabled(fp))
 					fp->nmissed++;
@@ -299,12 +305,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	 */
 	ret_ip = ftrace_regs_get_return_address(fregs);
 	used = 0;
-	hlist_for_each_entry_from_rcu(node, hlist) {
+	rht_for_each_entry_rcu_from(node, head, rht_ptr_rcu(bkt), tbl, key, hlist) {
 		int data_size;
 		void *data;
 
 		if (node->addr != func)
-			break;
+			continue;
 		fp = READ_ONCE(node->fp);
 		if (!fp || fprobe_disabled(fp))
 			continue;
@@ -448,25 +454,21 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
 	return 0;
 }
 
-static void fprobe_remove_node_in_module(struct module *mod, struct hlist_head *head,
-					struct fprobe_addr_list *alist)
+static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
+					 struct fprobe_addr_list *alist)
 {
-	struct fprobe_hlist_node *node;
 	int ret = 0;
 
-	hlist_for_each_entry_rcu(node, head, hlist,
-				 lockdep_is_held(&fprobe_mutex)) {
-		if (!within_module(node->addr, mod))
-			continue;
-		if (delete_fprobe_node(node))
-			continue;
-		/*
-		 * If failed to update alist, just continue to update hlist.
-		 * Therefore, at list user handler will not hit anymore.
-		 */
-		if (!ret)
-			ret = fprobe_addr_list_add(alist, node->addr);
-	}
+	if (!within_module(node->addr, mod))
+		return;
+	if (delete_fprobe_node(node))
+		return;
+	/*
+	 * If failed to update alist, just continue to update hlist.
+	 * Therefore, at list user handler will not hit anymore.
+	 */
+	if (!ret)
+		ret = fprobe_addr_list_add(alist, node->addr);
 }
 
 /* Handle module unloading to manage fprobe_ip_table. */
@@ -474,8 +476,9 @@ static int fprobe_module_callback(struct notifier_block *nb,
 				  unsigned long val, void *data)
 {
 	struct fprobe_addr_list alist = {.size = FPROBE_IPS_BATCH_INIT};
+	struct fprobe_hlist_node *node;
+	struct rhashtable_iter iter;
 	struct module *mod = data;
-	int i;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
@@ -486,8 +489,16 @@ static int fprobe_module_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	mutex_lock(&fprobe_mutex);
-	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
-		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
+	rhashtable_walk_enter(&fprobe_ip_table, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
+			fprobe_remove_node_in_module(mod, node, &alist);
+
+		rhashtable_walk_stop(&iter);
+	} while (node == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&iter);
 
 	if (alist.index < alist.size && alist.index > 0)
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
@@ -819,3 +830,10 @@ int unregister_fprobe(struct fprobe *fp)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
+
+static int __init fprobe_initcall(void)
+{
+	rhashtable_init(&fprobe_ip_table, &fprobe_rht_params);
+	return 0;
+}
+late_initcall(fprobe_initcall);
-- 
2.50.1


