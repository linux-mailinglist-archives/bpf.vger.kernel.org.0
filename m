Return-Path: <bpf+bounces-64481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D4B135AE
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C083AAD0E
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E3B235057;
	Mon, 28 Jul 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6JoGfJy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FEA221FD8;
	Mon, 28 Jul 2025 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687611; cv=none; b=UXKEskkXQhTaZffycD7t9FdvrLcg89DIxtkB6PdaYSWOahTBgEhNILV4GBMpkFoxPHAc62LcivKGER2FMVn2pHgSu5Zv2FdM7CEeDxQK5siurNhjB+WvI7IJVuOzCIgpWtSMJ8zBu9BcGEScGnjxMH4p06NBsaeq4I6Z5psMtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687611; c=relaxed/simple;
	bh=ekuqREdaljovJkJ2URqY0Sdhcj5S+sr8PGptexyekFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVEoCfcrzg4H2lnF+nHWvVXOgYBV7EpcQ+xR+7E6gNFbqym1v/iU+eXvSk8zFe5YZE0CEMzVL6Izm45U9HwQ/ajXd787at5D/8qq1vA1k5xrUGLFTfvTOAnDzT7+XqM0gDJFWGSlO8Yf9pDPEknDQm6MFdXFQw8T31UI7/sQgOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6JoGfJy; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so3412574a12.1;
        Mon, 28 Jul 2025 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753687607; x=1754292407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTwS2XVV2QUv/jukIeHPjcoQMfq7jhIqTve5aBCFmoo=;
        b=l6JoGfJy7qvrweGks7Xm3LzDY8iETwEnhOEFBNNnERN8s/Sl+z1ZMXdCSEf8eOhmze
         rCsipyPdE2vEKaUPVUXrfiwMcs1CSBNpjx1xWTfS7cmpmCaC3sKxc+OL6UQdB33kK/Bk
         +I4F7LDuXuxsl7sNzqZhHhyPG3QV5DhWhAd7v5pdA0YRZa5zJnu6Dnjg3gkk+qVD7kQg
         Gzd1Rmnhm7/TlMXyRJ6GnKgp11XagnCN1xYYtoxNuAskYbl7xXU52582g0X129Ww4HXz
         XUoMcbihyMVRQ2ciM17txnVi3/io/4zgukQyvbTBGAFuow/ZPFDsscqkwwNuj+MjxmSb
         ZM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753687607; x=1754292407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTwS2XVV2QUv/jukIeHPjcoQMfq7jhIqTve5aBCFmoo=;
        b=ZcGdkq7reNdTeFdbq25LcA47I1Aet6+ZAdZoU6MbdkCfS3ZhwphftVxzKkO5Nc6nvX
         yoOhZjw81ZUJgAGWNi1bm/+8mWT8p7DK9EJkq1cyJRrrxIrlvR5BnJ0PpHkfp3NTfIly
         Ch55rlj3ITbwpGU89QXhfrkIVODvN+hY+H+YQQfQgATmkG+FxqHeg5DYuC9Z1Ow4dUOq
         Fbj9fCixUezT944dtUMxjkO3lHGCeHVkh+YZ4NHxyU3NzEzc4i2dUH8Uw4AY++ZtWFnG
         Lcby5gz/VCAJlkYV4qg2P2js8r9oFF8/hYnUNd22djWiJWbg72WDuF/K4i/bVuXqZq/T
         2qAg==
X-Forwarded-Encrypted: i=1; AJvYcCVidLlMRX2ISWM+/zf4bfF8JY1jOCNiDIg0A8f8OO0AP9kpHC4wAVLjv0K6td6MIk8W0LUnbqgopFEmzy10@vger.kernel.org, AJvYcCW3amOoPChXGcQH59cHW0M4na39noYFi9ft1PqltefhyBiz7Sl1arPspo43y+W12+CMyZbyDtwMa0QgJTVkWQhAMkIR@vger.kernel.org, AJvYcCWxQihMBGkVWIu47qOGGL6SnmnEoOpSotOxZmidqvHXJr9QcIDnzNNVevjpExjIlXbsjkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZB0Wjo+/9ixTidh9yk0IBXNEnW1XAIkWE10kdxnsDIXHT9am
	VUH7QW7lug1SsGrbgk66qoz7Sf8CDFyv51GPc1wV7JkKjwuHXphseiw0
X-Gm-Gg: ASbGncuRIIqi+RTW3R2/mDK+MnkZ+abKmSFVzOx6TuIB/qZVmX13JZ74K9AOTDT1sp3
	C/g88H1gLmX/rDmM1rJLOodHrEKRFYVSj8w4MTnUVLGBrFcyVdsRFy2J8gj8h/JydChPfu3gzV5
	hAr7PzamLSAtkZ1TKHJxqALWFSo5KMkp0NUPjoT/ICDYmlzWWZ0u5jlkrJvFL+XjEtGsVw+dWQ5
	r/63XGlpRsOJr5GRHnMmVWnS3uOvJqxZJzKZwAUckjPvVqkOeZl7aOuBuLg3ejoKxjFZjODiHtS
	meapjG22v0xoKJZMT5nVuhuvTkWX0MFj5MlFAuWA3aXSFKnTbDz7kkcgFosw1lxPba3uu3dPi04
	jDsOZfBnaZuD1JNdBLGprTX0Hj/HC5w==
X-Google-Smtp-Source: AGHT+IFZujQLig+JmW84tuanI9EFgMvyXmvThN4UpuMiNqiHxxf2qAqZjtlTbYr0HsgIWS1xzHr4qA==
X-Received: by 2002:a17:90b:4a81:b0:31e:f30f:6d3b with SMTP id 98e67ed59e1d1-31ef30f715bmr3835718a91.2.1753687607351;
        Mon, 28 Jul 2025 00:26:47 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e949bbf7asm4459599a91.9.2025.07.28.00.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:26:47 -0700 (PDT)
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
Subject: [PATCH RFC bpf-next v2 1/4] fprobe: use rhltable for fprobe_ip_table
Date: Mon, 28 Jul 2025 15:22:50 +0800
Message-ID: <20250728072637.1035818-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
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

Therefore, replace the hash table with rhltable to reduce the overhead.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/fprobe.h |   2 +-
 kernel/trace/fprobe.c  | 141 +++++++++++++++++++++++------------------
 2 files changed, 79 insertions(+), 64 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 702099f08929..e56a25a50eb5 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -26,7 +26,7 @@ typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
  * @fp: The fprobe which owns this.
  */
 struct fprobe_hlist_node {
-	struct hlist_node	hlist;
+	struct rhlist_head	hlist;
 	unsigned long		addr;
 	struct fprobe		*fp;
 };
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ba7ff14f5339..640a0c47fc76 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/rhashtable.h>
 
 #include <asm/fprobe.h>
 
@@ -41,47 +42,46 @@
  *  - RCU hlist traversal under disabling preempt
  */
 static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
-static struct hlist_head fprobe_ip_table[FPROBE_IP_TABLE_SIZE];
+static struct rhltable fprobe_ip_table;
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
+	rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
 }
 
 /* Return true if there are synonims */
@@ -92,9 +92,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 	/* Avoid double deleting */
 	if (READ_ONCE(node->fp) != NULL) {
 		WRITE_ONCE(node->fp, NULL);
-		hlist_del_rcu(&node->hlist);
+		rhltable_remove(&fprobe_ip_table, &node->hlist,
+				fprobe_rht_params);
 	}
-	return !!find_first_fprobe_node(node->addr);
+	return !!rhltable_lookup(&fprobe_ip_table, &node->addr,
+				 fprobe_rht_params);
 }
 
 /* Check existence of the fprobe */
@@ -249,9 +251,10 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 			struct ftrace_regs *fregs)
 {
-	struct fprobe_hlist_node *node, *first;
+	struct fprobe_hlist_node *node;
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
+	struct rhlist_head *head, *pos;
 	unsigned long ret_ip;
 	int reserved_words;
 	struct fprobe *fp;
@@ -260,14 +263,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	if (WARN_ON_ONCE(!fregs))
 		return 0;
 
-	first = node = find_first_fprobe_node(func);
-	if (unlikely(!first))
-		return 0;
-
+	rcu_read_lock();
+	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
 	reserved_words = 0;
-	hlist_for_each_entry_from_rcu(node, hlist) {
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
 		if (node->addr != func)
-			break;
+			continue;
 		fp = READ_ONCE(node->fp);
 		if (!fp || !fp->exit_handler)
 			continue;
@@ -278,17 +279,19 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		reserved_words +=
 			FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->entry_data_size);
 	}
-	node = first;
+	rcu_read_unlock();
 	if (reserved_words) {
 		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
 		if (unlikely(!fgraph_data)) {
-			hlist_for_each_entry_from_rcu(node, hlist) {
+			rcu_read_lock();
+			rhl_for_each_entry_rcu(node, pos, head, hlist) {
 				if (node->addr != func)
-					break;
+					continue;
 				fp = READ_ONCE(node->fp);
 				if (fp && !fprobe_disabled(fp))
 					fp->nmissed++;
 			}
+			rcu_read_unlock();
 			return 0;
 		}
 	}
@@ -299,12 +302,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	 */
 	ret_ip = ftrace_regs_get_return_address(fregs);
 	used = 0;
-	hlist_for_each_entry_from_rcu(node, hlist) {
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
 		int data_size;
 		void *data;
 
 		if (node->addr != func)
-			break;
+			continue;
 		fp = READ_ONCE(node->fp);
 		if (!fp || fprobe_disabled(fp))
 			continue;
@@ -448,25 +451,21 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
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
@@ -474,8 +473,9 @@ static int fprobe_module_callback(struct notifier_block *nb,
 				  unsigned long val, void *data)
 {
 	struct fprobe_addr_list alist = {.size = FPROBE_IPS_BATCH_INIT};
+	struct fprobe_hlist_node *node;
+	struct rhashtable_iter iter;
 	struct module *mod = data;
-	int i;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
@@ -486,8 +486,16 @@ static int fprobe_module_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	mutex_lock(&fprobe_mutex);
-	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
-		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
+	rhashtable_walk_enter(&fprobe_ip_table.ht, &iter);
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
@@ -819,3 +827,10 @@ int unregister_fprobe(struct fprobe *fp)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(unregister_fprobe);
+
+static int __init fprobe_initcall(void)
+{
+	rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
+	return 0;
+}
+late_initcall(fprobe_initcall);
-- 
2.50.1


