Return-Path: <bpf+bounces-65726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E6B27961
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D838D583960
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC682C3768;
	Fri, 15 Aug 2025 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2PBTJWW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131102C0F95;
	Fri, 15 Aug 2025 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240446; cv=none; b=UdnhOSlpX5Fgm0waXopt/4T0AN5Cja7Qu6vd3sm7002q3Pirchc3LRG8TEomnHbWiWIEQLKLXNzlBO8TrbR2Mwkn0YoXchz7GaXWeF1rm/b9pXs0ekCix5OnBqA3F2FMO/76UrIyH6Xg/OhpgPrSap/Ne/mhztvUfyBeDDwqGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240446; c=relaxed/simple;
	bh=8c6XiGSsLg4WivlAdddTMBCijsqkBnwNMDeJWgspdAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzMYiGBH4bRtDmwpHiG1kNhkoAvnbq5yfXn8qLQVsCYpceOtoh9//Mxa1JD0zep3Rs44bKM4HwHl+2jRyuT4vKJZdUu2W0tDxjlzbcgMHQSTIEdg+4Cvv2nuT0mqX5K+7GcVdloZrLXZqqXzw3/+hFgsKaMdJDV9sYFzz54U86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2PBTJWW; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b4717ba0d5dso1083648a12.1;
        Thu, 14 Aug 2025 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755240444; x=1755845244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71t4n68hjAPevB6NpQf/YHIqzsx0jKOTw/PsbXVomRY=;
        b=Z2PBTJWWCK6wheiTAgdGwSEACTnEWG4g9DDiDZS4/iMp/Xo8BWH98qU6uZumf+Wz8W
         O8GOH+qDY9/eoj+mZkFhPoFbiEd132Sv8+FncO2pNulYvo9y/UZqmzIvA/sU3G1PJNQ/
         qW2urY1AHNkZIghGHLmDojpM+YR8tRUox0Q9Swfk3xOolQC0D7GUcocYQ2O2Gxi1vUNZ
         KSVvxENeSgfFOsuhRUO9bf3/QQBrxuHlJMfk9aglmljuvQpZEGbomoSgWqNByHYpTjfd
         0oleztCwiDt0jHjIlVM+ghU86a5/PpwJQ9qWZjJOK7oT5S1iPKGigyIAMJqutHziS2CG
         CD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755240444; x=1755845244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71t4n68hjAPevB6NpQf/YHIqzsx0jKOTw/PsbXVomRY=;
        b=E67vmsdImct5aFdR++hpfGJi4OlPI8sMk45eunApbMlmHqpL78Y5MGQspHciN6dNAS
         bH4tHIDRrIUyFKLhDXPOZBLYMvhltNQELyJYc1KczJFLDDTlMCes506lWR902WYDQDsW
         aCdFp+HD3lVPCd3YN/QmSD3z6fZhtd2hvlw6XoBaYuYvBF+pFO+KkAUYmZcXcEK/RZad
         VsV6u3GQWNeFSfIHSI2aJJrf+3o/0fySj5YKLR0U9IpeGJu1wVZG2JqB8WM5Hjnjm9I2
         GXgehqvwFVOMYEkGIczoxT6ccdFhQf7B8QySQ+0YEsyu1qYJXRi5HJJiT31MaAfyi3ZQ
         mTdg==
X-Forwarded-Encrypted: i=1; AJvYcCUUXOit5g/Bkd78BVvWcnXXwCNTbKc9rEEF+EE14zQcjECKhJ4/1SopwcRMSTkww+darR+otfMhYlyHbWdp@vger.kernel.org, AJvYcCWOGlu279V46hj3MO9aVb2g+JJiiwkR/iox1gjyJt47+4aqaQXYde5+ab34cYdgn2/VQjA=@vger.kernel.org, AJvYcCXnW5FxbM9n7Yw/fqECDoWqMxTA1yCLIiu49ol4PgEg1lJLaTwJraRrARtRGNt2z0DbvQx9WJv5XEUDr90XB0uJm3wb@vger.kernel.org
X-Gm-Message-State: AOJu0YyYwvCGQ4gUakAzbXqyUnH3EDNG4O120BljO9GFvfreW0C2Lgnb
	/0qiW2cxxbxUPNk6z6M2x3PE6m3/p+vSXslbrP2/59Hm4NOv02u2tIxs
X-Gm-Gg: ASbGnctyWtO+0Cc3smYBqak65I11cJtTdKvBbu3qV9kFyDMEEJi+MPfs9Zjl61NX06e
	zTVsMYwlTliNBX8yTDh5Cmlh7Gp0XjQIQCj8YX61rIi/4LKm6wldSZE/jJRcyuTYSej3IHXaikP
	L1vP8goR5x8m0O8jh3Dol9v9t1oYwgtWd9aNylCnXEp9Eh5J6bu3bUdtW3BB3umGJePZJk+mSaz
	OX15V/3W22MawX6J5pYUALo9O84cE5h4xg8Y5adseOljOdNzkXgN2OPVM06K+ICbcqhrWc+dFtQ
	aK7if2tWC2FV0E6Kp1m+2ORC+WlmStQLGI/D+fwhIFohWhR2l/+G7pdXLsaCIk9AdZOWTx6Aerx
	L2hY0yliIrk3TM6m9vMI=
X-Google-Smtp-Source: AGHT+IHSCHmXharrfpd9fnWcPFEmd1GfpgTTPbaS9txeExQv8HIlsXQ7gYoHdF8axfKonJ/0REeGGA==
X-Received: by 2002:a17:903:2d2:b0:23f:75d1:3691 with SMTP id d9443c01a7336-2446bdafa24mr20190085ad.15.1755240444214;
        Thu, 14 Aug 2025 23:47:24 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d539032sm7161665ad.109.2025.08.14.23.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:47:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/4] fprobe: use rhltable for fprobe_ip_table
Date: Fri, 15 Aug 2025 14:47:07 +0800
Message-ID: <20250815064712.771089-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815064712.771089-1-dongml2@chinatelecom.cn>
References: <20250815064712.771089-1-dongml2@chinatelecom.cn>
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
v4:
- replace rhashtable_walk_enter with rhltable_walk_enter

v3:
- some format optimization
- handle the error that returned from rhltable_insert in
  insert_fprobe_node
---
 include/linux/fprobe.h |   3 +-
 kernel/trace/fprobe.c  | 155 +++++++++++++++++++++++------------------
 2 files changed, 91 insertions(+), 67 deletions(-)

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
index c8034dfc1070..7aa21361227e 100644
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
@@ -727,8 +735,16 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
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
 
@@ -824,3 +840,10 @@ int unregister_fprobe(struct fprobe *fp)
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


