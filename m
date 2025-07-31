Return-Path: <bpf+bounces-64786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80264B16E89
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E352E567B34
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F92BDC35;
	Thu, 31 Jul 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVNV+t4E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995E2BDC1D;
	Thu, 31 Jul 2025 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953886; cv=none; b=Q/guKvcBkc/UTqtX3WrkMXlC38DWoGI2mq4r1AlExNtfKDpwzJYbMxai1lTbzCA4nCaAwkDFM52JKsMsWAfWvYyiDGW6Nv76xDK2518T6AxfdOZ5F/Eh8xtQ9B9Nl+8/ouoqvQOo02zzhXPGxVxsqqSDWJuX6C3Nedo6ka2nLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953886; c=relaxed/simple;
	bh=/tgD51DEMY/99i9Q6tGBTqJ1Jrsh0iL1bQAqAHmMO0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkJJGPYrdhq5YZfUeyURa05gfrzvlfJrQM94r9NrEsXZyKLIu6lNgTJB0Tw68nJCQe70/vRq22I232xDCS9IzwnjihUqWMT5hs5FvPrIdei31S9+ncUOiNn/XgKH2B/FCh3ge8vJZk9YEmYAXcSMTh4kP+BN3fXvnXxyV+O/5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVNV+t4E; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76b0724d64bso645578b3a.1;
        Thu, 31 Jul 2025 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753953883; x=1754558683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U5gNA8e+vROYthJvOv16nHX/WnYabMsA44r8KL57Dk=;
        b=AVNV+t4Ewt84wNvC/yC37v8khrlY2LXU2nKlIm/OFnwByAe1hLADc0JrPoNTiApsD6
         gVYWqDWnTjWkepI5G4q5d0Kzkv1ODCBbBNeBrCt0YEJr/czemIAk45A5DAaxtpDfz3Cz
         pvaAU4h07vZeFCHOMhKGpN1IJX2K6nKtpF7nTg8lsWgx38sE0iNmuiD4tez4/ecoY0MR
         CyzyyLfaX2TsUAkbXRPwqEL5SE/zh3c0JNLfPsYcnAjOI3WMi0X5Tgonks8KicoyovWW
         ALGvxVmAVojYKIiRMfYaEWkbZ1cCgHrD8L194A7aeTtFxIcuhE1h8ukUSzL/SBp35JVH
         gciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953883; x=1754558683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6U5gNA8e+vROYthJvOv16nHX/WnYabMsA44r8KL57Dk=;
        b=ablBTLGHl0ZgFErl6AS7xiLRoZNxubucnyvFTqHgKWg4yrcxaRkwYxp2uGi7aZ4Vhi
         OEmvhE0s8i/Eb8kCd61nH9fbglFPuAJyv1KRGAyKEpcYmGb+PxiHUCoOs+aMJTCNCypP
         1WYfwIItHSgxFaZYjszLG3RaUhUcpmddMlQN42GMQG3MJHtR6BdGP31+wunhUuld7b3x
         aRQ/0hNqXhWLD3AzvUhTpBaWTlaB0M3bE/41WcZXztY88oMYfkPtoWgKrE0dy7lWoCl+
         DC1bBUF2lGx0ZP4jxbb7IfkOcm5QKGB4Onaz0HYUcTO5eyau4hwVKruAT0+Aq+5Vm8AG
         6geA==
X-Forwarded-Encrypted: i=1; AJvYcCU/wM9DpisK/ZwOAZyy4N/yOfcar/mlxwNu76DyjKiXzkaDKBZKrsnGVhfYqAygg5uLj6xRfPHD6JT8kzYTHgxd3R2U@vger.kernel.org, AJvYcCURinOdyoEzl4JrNWFBJp/rdoNxH/wgrRy1C4LOkml72aKiCR4M4PfA5psPhP6RwBDh2Ig=@vger.kernel.org, AJvYcCWKQol28I9iZGDJuXq87AmCY0Ys7vDgAJSv5KhXPG51cBJFJUPT0ieehr5wJrpVW5QuOf6tkE8xrde56Qn/@vger.kernel.org
X-Gm-Message-State: AOJu0YxEe33vxWqv7ml9C+diguCtAabTLEmV1W+mNVTxvlcMIQOKRvAv
	om9H2K77YImonWT9lz5QNl0G3WIKeE2ZqYgPuh6ZMsXNUsIno3/zwBpx
X-Gm-Gg: ASbGncv38Z2DFPZGDn/xcfA/7LLp0w1RdZzKEbYEdkT+2B4tSoi/6DkKZ3MIJ4SGcOz
	EKzGgCWUeHNW1tFy5Nu/wsSqE81ec/sSh93/p/BXXGF7qVGK9tfaAT7rbyPmPaGxK2l6Da2ZtQI
	dYBO2xAdqUxL33VnjcnBJRM8/JhZ2p2/RDsqJclpBLxb7y11dTVNNodBtMHVATd7x/98LY+88i/
	vkfvYOvID3Hen9lJQ0L6yJGW0tQBvShmKy0OeZRTnFk4VNPMPrUvCUlCIGKZPd2yRalJ/oU9wWd
	hoDOWb+DGHUzJmmWVixjkdVrYlxbNcIhb65v0DXLFHrH96LI0HzKM1DRjwvNyy+kGAepwpavFSX
	gFbsDH2ItY+QE/Qtn7W0=
X-Google-Smtp-Source: AGHT+IH52k6ooqrIzYDpa3HfSnK3ao3abrWD+aDjQHMdpsdsc3JRM2ZaGRlvfdFYm8f0AE6KNOBC2A==
X-Received: by 2002:a05:6a00:1897:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-76ab0827e7dmr10346584b3a.4.1753953883311;
        Thu, 31 Jul 2025 02:24:43 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd1a7sm1108143b3a.73.2025.07.31.02.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:24:42 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org,
	olsajiri@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/4] fprobe: use rhltable for fprobe_ip_table
Date: Thu, 31 Jul 2025 17:24:24 +0800
Message-ID: <20250731092433.49367-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731092433.49367-1-dongml2@chinatelecom.cn>
References: <20250731092433.49367-1-dongml2@chinatelecom.cn>
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
v3:
- some format optimization
- handle the error that returned from rhltable_insert in
  insert_fprobe_node
---
 include/linux/fprobe.h |   3 +-
 kernel/trace/fprobe.c  | 154 +++++++++++++++++++++++------------------
 2 files changed, 90 insertions(+), 67 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 702099f08929..f5d8982392b9 100644
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
index ba7ff14f5339..2f1683a26c10 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -41,47 +41,46 @@
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
@@ -92,9 +91,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
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
@@ -249,9 +250,10 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
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
@@ -260,14 +262,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
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
@@ -278,17 +278,19 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
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
@@ -299,12 +301,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
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
@@ -448,25 +450,21 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
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
@@ -474,8 +472,9 @@ static int fprobe_module_callback(struct notifier_block *nb,
 				  unsigned long val, void *data)
 {
 	struct fprobe_addr_list alist = {.size = FPROBE_IPS_BATCH_INIT};
+	struct fprobe_hlist_node *node;
+	struct rhashtable_iter iter;
 	struct module *mod = data;
-	int i;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
@@ -486,8 +485,16 @@ static int fprobe_module_callback(struct notifier_block *nb,
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
@@ -722,8 +729,16 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
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
 
@@ -819,3 +834,10 @@ int unregister_fprobe(struct fprobe *fp)
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


