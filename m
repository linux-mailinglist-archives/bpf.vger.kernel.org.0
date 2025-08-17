Return-Path: <bpf+bounces-65835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6E4B2912B
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 04:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B540A1966D35
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 02:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A51FCF41;
	Sun, 17 Aug 2025 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/jJdrjm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02721F30A9;
	Sun, 17 Aug 2025 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755398778; cv=none; b=tX/NtiEM8gnLvb1uN+/AIIrf42iLMxlHlQ74w2yhJHUusHt6y/XJng954kpVt0Xi/3l/PYNZu4G/deUUAifzPDBef8ZsDaYd47rWLoPIm1MgwOX317JeXzJRSNCWA9eMx9X1O4gGNUt/2f+nTWSQoL5hbRqxvgh4RiykJ2AfXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755398778; c=relaxed/simple;
	bh=6g9LFPG0T+2M/2d7VqVE8XCa9YnZ8bVA8q66opMq9NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMfVNnORhG29dqZeUxOX19YoutfJ3C3FnwbBHS2u5UwupgVeBXjXES0QQV6+Lv/GQSojC97m+Df37tzdkdIDYNnSDjVaBaiSTZpJoTXLThLsARX1Ps1G4Z4NzOuRXG7EjKygNyk2FYtinjdg6eEt45KjBfG9SygEsx7ik42R62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/jJdrjm; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-244581caca6so22951345ad.2;
        Sat, 16 Aug 2025 19:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755398776; x=1756003576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvCCSuj2jpL8ZxmmwPT7njDNi0pO19k28p12mFCypBU=;
        b=V/jJdrjmKwZ0na58DLxiaYglind5C47cZLwlG70f/MsNQMu3/I9ao0T++YuepbHaFb
         zQ9rBK8JXlIzRHhdj4x6TTXcxDPiDtwM9L+TRIojUOMyvi5BrA1SL+vRNSD4N08W6roR
         7pdHWLae18bOF6cWe3LQRe4Iw+N1BiA9O3WTovCx8cEHpKihAZvas+vqS7YdtO0K+xVU
         gphR6XacoHiUlfdBL9Pld6BRsf54Hu8F9/8/88bHDCSd8kmST7EoXrhVESHgPUSpG8p0
         4W9ibyhpaX/++VFLm2ZudwJzB62Ytp4sY2d5m6f1/EDNtJlxH/DPiGLHHOPPuivHTmEl
         w7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755398776; x=1756003576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvCCSuj2jpL8ZxmmwPT7njDNi0pO19k28p12mFCypBU=;
        b=HWEHHMZ+LfyGBtq+rs8Yl545JgzGdRaRYk4ty+Bs6HB1xY5iKer0IYLYaHU1QRFbNj
         1cJ+YqIDnrOx/9mtum3QW0NPzAaosUvJwLwl13v/VunWmd1mVMtrvxGSnj4vgKsf2Fwx
         UGIFz6OH4b6KOxeqade3moeE55dcD8PEpHukPaKa2jAC6LP9WruZTj4J7F5AI/6BnPOp
         p9I2yS0Sv7RzSCE9snrdlBgg9lspGbFu4i2Ymj/PPkWa3/yQ66JT9cIIGah8+qfV1HtQ
         v+0VT9W2usQPPeSQR4SZKlzQLvhU4Nk9soseBKSkcmdqfk5OK93Zqa9pdQTsgwd/qk8m
         iYZg==
X-Forwarded-Encrypted: i=1; AJvYcCWCDv0y7vwnZtmKyWS/m4zV8v03TrR39naVQ8G96SABqwuTymKGrE2hY5p/a+rn/uCUU3Y=@vger.kernel.org, AJvYcCWEdTyVzIFvCqNy/54VgThjAYTSZ0gNiUOx5+DwnpIEVF+EmwneUmnfxTkbz4CZ1ywwQR03PM+K11u22xCJ@vger.kernel.org, AJvYcCWe2wtBQBIzonYQUZK8L+9AUbTrXkhoFq+8y7SHJtcAnwZHZNzuXHMKSZ2ENz6G2eJQKFoAmC5HdYnCjOhwzP9xP2Nz@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxJwI/qjU1WGpfLkoCKQS8g9OEluy8EFoXAvITxUCTFWajPdF
	plGFw9cdGdR7cjgLH8i9Qcy19LarEcU9Sa83rPUaUC02I5DKAkqq4hwi
X-Gm-Gg: ASbGncvqophMPhiv17CKP/3nJVh48BtQnLnDn7+K+uS79gRjqx1DlUFtIjKvlQSck/o
	xD7/z9Agl9w8O5EkKH1SxPnmBOy1lzt+O3M1hv4z8kFBbXLpOBtpjupNBJwwyS5ixQYFuI7nEDM
	7jHmwS6wpheD66+ChI2hpIfPNbG/ev3oCWuox1jL6IMPd+D0w/msmQvJUP9LWd07CnNyuCkzR39
	/oeDRn5ra3Tr7IwG9xLCYAioyDuMiaEREDR1O7q0sTNMU8gJXbzPmpbzfBUmNVfKklbziXFjflk
	vBmf1R64K38jnAQIgEyl/zcgFZKgaa7GnmR9tv3CBu4KA4ThpSHiRA43R1FV4Q/egA57TchiLh4
	Alr2xEgAGYC7bA9jaJm91lT5r7jwacg==
X-Google-Smtp-Source: AGHT+IHDrKI17xNC7saiM6dHxqXmCxP7CQQJCENVnv4kiNqaTGCEjZeh3H7kvXfWxj9dzCC4M0WgaA==
X-Received: by 2002:a17:903:1aae:b0:240:3909:5359 with SMTP id d9443c01a7336-2446d8dcccamr103792425ad.40.1755398775761;
        Sat, 16 Aug 2025 19:46:15 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f382sm45009845ad.79.2025.08.16.19.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 19:46:15 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v5 1/4] fprobe: use rhltable for fprobe_ip_table
Date: Sun, 17 Aug 2025 10:46:02 +0800
Message-ID: <20250817024607.296117-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250817024607.296117-1-dongml2@chinatelecom.cn>
References: <20250817024607.296117-1-dongml2@chinatelecom.cn>
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
v5:
- remove unnecessary rcu_read_lock in fprobe_entry

v4:
- replace rhashtable_walk_enter with rhltable_walk_enter

v3:
- some format optimization
- handle the error that returned from rhltable_insert in
  insert_fprobe_node
---
 include/linux/fprobe.h |   3 +-
 kernel/trace/fprobe.c  | 151 +++++++++++++++++++++++------------------
 2 files changed, 87 insertions(+), 67 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 7964db96e41a..0a3bcd1718f3 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -7,6 +7,7 @@
 #include <linux/ftrace.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
+#include <linux/rhashtable.h>
 #include <linux/slab.h>
 
 struct fprobe;
@@ -26,7 +27,7 @@ typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
  * @fp: The fprobe which owns this.
  */
 struct fprobe_hlist_node {
-	struct hlist_node	hlist;
+	struct rhlist_head	hlist;
 	unsigned long		addr;
 	struct fprobe		*fp;
 };
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index c8034dfc1070..e09b034b3cf8 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -10,6 +10,7 @@
 #include <linux/kprobes.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/rhashtable.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 
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
 }
-NOKPROBE_SYMBOL(find_first_fprobe_node);
 
-/* Node insertion and deletion requires the fprobe_mutex */
-static void insert_fprobe_node(struct fprobe_hlist_node *node)
+static u32 fprobe_node_obj_hashfn(const void *data, u32 len, u32 seed)
 {
-	unsigned long ip = node->addr;
-	struct fprobe_hlist_node *next;
-	struct hlist_head *head;
+	const struct fprobe_hlist_node *n = data;
+
+	return hash_ptr((void *)n->addr, 32);
+}
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
 
+/* Node insertion and deletion requires the fprobe_mutex */
+static int insert_fprobe_node(struct fprobe_hlist_node *node)
+{
 	lockdep_assert_held(&fprobe_mutex);
 
-	next = find_first_fprobe_node(ip);
-	if (next) {
-		hlist_add_before_rcu(&node->hlist, &next->hlist);
-		return;
-	}
-	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
-	hlist_add_head_rcu(&node->hlist, head);
+	return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
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
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
+	struct fprobe_hlist_node *node;
+	struct rhlist_head *head, *pos;
 	unsigned long ret_ip;
 	int reserved_words;
 	struct fprobe *fp;
@@ -260,14 +263,11 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	if (WARN_ON_ONCE(!fregs))
 		return 0;
 
-	first = node = find_first_fprobe_node(func);
-	if (unlikely(!first))
-		return 0;
-
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
@@ -278,13 +278,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		reserved_words +=
 			FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->entry_data_size);
 	}
-	node = first;
 	if (reserved_words) {
 		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
 		if (unlikely(!fgraph_data)) {
-			hlist_for_each_entry_from_rcu(node, hlist) {
+			rhl_for_each_entry_rcu(node, pos, head, hlist) {
 				if (node->addr != func)
-					break;
+					continue;
 				fp = READ_ONCE(node->fp);
 				if (fp && !fprobe_disabled(fp))
 					fp->nmissed++;
@@ -299,12 +298,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
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
@@ -448,25 +447,21 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
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
@@ -474,8 +469,9 @@ static int fprobe_module_callback(struct notifier_block *nb,
 				  unsigned long val, void *data)
 {
 	struct fprobe_addr_list alist = {.size = FPROBE_IPS_BATCH_INIT};
+	struct fprobe_hlist_node *node;
+	struct rhashtable_iter iter;
 	struct module *mod = data;
-	int i;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
@@ -486,8 +482,16 @@ static int fprobe_module_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	mutex_lock(&fprobe_mutex);
-	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
-		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
+	rhltable_walk_enter(&fprobe_ip_table, &iter);
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
@@ -727,8 +731,16 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	ret = fprobe_graph_add_ips(addrs, num);
 	if (!ret) {
 		add_fprobe_hash(fp);
-		for (i = 0; i < hlist_array->size; i++)
-			insert_fprobe_node(&hlist_array->array[i]);
+		for (i = 0; i < hlist_array->size; i++) {
+			ret = insert_fprobe_node(&hlist_array->array[i]);
+			if (ret)
+				break;
+		}
+		/* fallback on insert error */
+		if (ret) {
+			for (i--; i >= 0; i--)
+				delete_fprobe_node(&hlist_array->array[i]);
+		}
 	}
 	mutex_unlock(&fprobe_mutex);
 
@@ -824,3 +836,10 @@ int unregister_fprobe(struct fprobe *fp)
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


