Return-Path: <bpf+bounces-29530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E048C2A8F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE331282253
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FFC5337D;
	Fri, 10 May 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiAMt1HV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E20502BE;
	Fri, 10 May 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369063; cv=none; b=XeSDm4vvaz/OAQAKkxfgoTen5LYhlH0Q1RS2WvyK3ZSl6YA79qibrhbya0FHpJWCul8BfkOGt+eeWS24BVXn8sfAgh9f8zVgfE2VQ5AS9MaM5mR5LrYNFl7mozt8qzKc5bpEB8g5AwyUbs7W7ACyqoi59JQfpLH0WKslEW/Dl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369063; c=relaxed/simple;
	bh=syUcB07gwNwRkuB9GJehuYow/O4JgHWo2jWcVtjNxWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ConkxZmJfLz52CZhD3C97q5fIMXQQC3kmQXj+EJQ9j8WzHgZ8z1/FKfiyaY+xJ282j3/k6tCCzNE5kqf4hdbn5LKicWqNsw4H7V0jJqd9Dhoeem/4qeFJZVTKnHFFFa6VU23OuxCguF30iQ5kY63mWrAwEIoLqIU4Go0C4uJBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiAMt1HV; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43df751b5b8so12917881cf.0;
        Fri, 10 May 2024 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369060; x=1715973860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOGBkGpSFFT7zPNyeKaVqbqpwZiJlX+/nC4CsYgkmE4=;
        b=ZiAMt1HV+ucwUmsmp7H6sL1tRBq0bqGJoD+nl8khhVtqbA5fqTqk8GnSmk/gkq6z/Q
         p+FN4kNfyG6omE/vbFSMcfkfpj5FT75d0RAiy04M53mhlaI7u2vAqhomLz7fVuuhTl58
         6OL0i2wcxbplMcNkGDeYj/fsyfmGMb+fD2PMcw1cLEh/CIq2krjT3KpPk0uduDG7fsbv
         0Vrj8Mx3WDnSbJL5SjRJBkKaB+ep7A6ayT1xexNCZS4HX4tn44q327vDuz+Uz47lBbQX
         e3Es4XafJhVhnFM45WiXt3xvaKSq53Us6uaXik5y207ERFEz9jRYSrcnIpznyWPEkYEq
         EbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369060; x=1715973860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOGBkGpSFFT7zPNyeKaVqbqpwZiJlX+/nC4CsYgkmE4=;
        b=ibCNecxYdQSxrvutg3+ty41Vxf/H01avO8qsvuUT5wiFNelKLtuf52nRQRVw3wmEqb
         Vk+bGUjMfVGNgRckKvN8vsjeMX1tpRoLkFUDNGxJPzqsKNu4f+kvKT1xaBUFjV+ioEfd
         s5oaV+sHmXqo9Fh/nrYNH3lA6WmbJ3q6b/QaVQZ2bgCggcLBWBwwITUTrjcQK2wlvQGA
         nZVNOuaDJEAljztYqyMxoOGRpumtpeTqhMtGcRP/Hvdh1Ch3UUvS03bYT9a5DZROrtot
         wfuOJRhnd4TlQOEgQbh4Cuy7hSMqD3Jbsai6NIE5sfPzTtneVSzxQlT3LounHeXf5UGq
         bA+Q==
X-Gm-Message-State: AOJu0YwTUQD5IIC6zuTTIr3Pol34ulT0+tnJd0qQHNjrUxQ86Uhlaa61
	cjwHYvbGQV0HqTul8kZsIq+6DHAEUWJIApg6qpF/s1uaiH2Dyha6fdwU4w==
X-Google-Smtp-Source: AGHT+IFguX6k1ox/pzV81Z8RD4aKDN4Y+RxugjPD6K7jwC46EpNwtGH4tH9WkGaHmOJTgxGioagEVQ==
X-Received: by 2002:a05:622a:1496:b0:437:bedb:3ff with SMTP id d75a77b69052e-43dec297648mr107218271cf.27.1715369060389;
        Fri, 10 May 2024 12:24:20 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 11/20] bpf: Allow adding exclusive nodes to bpf list and rbtree
Date: Fri, 10 May 2024 19:24:03 +0000
Message-Id: <20240510192412.3297104-12-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch first teaches verifier to accept exclusive nodes
(bpf_list_excl_node and bpf_rb_excl_node) as valid graph nodes.

Graph kfuncs can now skip ownership tracking and checks for graphs
containing exclusive nodes since we already make sure that a exclusive
node cannot be owned by more than one collection at the same time.

Graph kfuncs will use struct_meta to tell whether a node is exclusive or
not. Therefore we pass struct_meta as an additional argument to graph
remove kfuncs and let verifier fixup the instruction.

The first user of exclusive-ownership nodes is sk_buff. In bpf qdisc, an
sk_buff will be able to be enqueued into either a bpf_list or a
bpf_rbtree. This significantly simplify how users write the code and
improve qdisc performance as we no longer need to allocate local objects
to store skb kptrs.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/skbuff.h                        |   2 +
 kernel/bpf/btf.c                              |   1 +
 kernel/bpf/helpers.c                          |  63 +++++++----
 kernel/bpf/verifier.c                         | 101 ++++++++++++++----
 .../testing/selftests/bpf/bpf_experimental.h  |  58 +++++++++-
 5 files changed, 180 insertions(+), 45 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 03ea36a82cdd..fefc82542a3c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -871,6 +871,8 @@ struct sk_buff {
 		struct rb_node		rbnode; /* used in netem, ip4 defrag, and tcp stack */
 		struct list_head	list;
 		struct llist_node	ll_node;
+		struct bpf_list_excl_node	bpf_list;
+		struct bpf_rb_excl_node		bpf_rbnode;
 	};
 
 	struct sock		*sk;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a641c716e0fa..6a9c1671c8f4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5495,6 +5495,7 @@ static const char *alloc_obj_fields[] = {
 /* kernel structures with special BTF fields*/
 static const char *kstructs_with_special_btf[] = {
 	"unused",
+	"sk_buff",
 };
 
 static struct btf_struct_metas *
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 70655cec452c..7acdd8899304 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1988,6 +1988,9 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
 			  bool tail, struct btf_record *rec, u64 off)
 {
 	struct list_head *n = &node->list_head, *h = (void *)head;
+	bool exclusive;
+
+	exclusive = btf_record_has_field(rec, BPF_LIST_EXCL_NODE);
 
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
 	 * called on its fields, so init here
@@ -1998,14 +2001,15 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
 	/* node->owner != NULL implies !list_empty(n), no need to separately
 	 * check the latter
 	 */
-	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
+	if (!exclusive && cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
 		/* Only called from BPF prog, no need to migrate_disable */
 		__bpf_obj_drop_impl((void *)n - off, rec, false);
 		return -EINVAL;
 	}
 
 	tail ? list_add_tail(n, h) : list_add(n, h);
-	WRITE_ONCE(node->owner, head);
+	if (!exclusive)
+		WRITE_ONCE(node->owner, head);
 
 	return 0;
 }
@@ -2030,10 +2034,14 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
 }
 
-static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
+static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
+					    struct btf_record *rec, bool tail)
 {
 	struct list_head *n, *h = (void *)head;
 	struct bpf_list_node_kern *node;
+	bool exclusive;
+
+	exclusive = btf_record_has_field(rec, BPF_LIST_EXCL_NODE);
 
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
 	 * called on its fields, so init here
@@ -2045,40 +2053,55 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
 
 	n = tail ? h->prev : h->next;
 	node = container_of(n, struct bpf_list_node_kern, list_head);
-	if (WARN_ON_ONCE(READ_ONCE(node->owner) != head))
+	if (!exclusive && WARN_ON_ONCE(READ_ONCE(node->owner) != head))
 		return NULL;
 
 	list_del_init(n);
-	WRITE_ONCE(node->owner, NULL);
+	if (!exclusive)
+		WRITE_ONCE(node->owner, NULL);
 	return (struct bpf_list_node *)n;
 }
 
-__bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
+__bpf_kfunc struct bpf_list_node *bpf_list_pop_front_impl(struct bpf_list_head *head,
+							  void *meta__ign)
 {
-	return __bpf_list_del(head, false);
+	struct btf_struct_meta *meta = meta__ign;
+
+	return __bpf_list_del(head, meta ? meta->record : NULL, false);
 }
 
-__bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
+__bpf_kfunc struct bpf_list_node *bpf_list_pop_back_impl(struct bpf_list_head *head,
+							 void *meta__ign)
 {
-	return __bpf_list_del(head, true);
+	struct btf_struct_meta *meta = meta__ign;
+
+	return __bpf_list_del(head, meta ? meta->record : NULL, true);
 }
 
-__bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
-						  struct bpf_rb_node *node)
+__bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove_impl(struct bpf_rb_root *root,
+						       struct bpf_rb_node *node,
+						       void *meta__ign)
 {
 	struct bpf_rb_node_kern *node_internal = (struct bpf_rb_node_kern *)node;
 	struct rb_root_cached *r = (struct rb_root_cached *)root;
 	struct rb_node *n = &node_internal->rb_node;
+	struct btf_struct_meta *meta = meta__ign;
+	struct btf_record *rec;
+	bool exclusive;
+
+	rec = meta ? meta->record : NULL;
+	exclusive = btf_record_has_field(rec, BPF_RB_EXCL_NODE);
 
 	/* node_internal->owner != root implies either RB_EMPTY_NODE(n) or
 	 * n is owned by some other tree. No need to check RB_EMPTY_NODE(n)
 	 */
-	if (READ_ONCE(node_internal->owner) != root)
+	if (!exclusive && READ_ONCE(node_internal->owner) != root)
 		return NULL;
 
 	rb_erase_cached(n, r);
 	RB_CLEAR_NODE(n);
-	WRITE_ONCE(node_internal->owner, NULL);
+	if (!exclusive)
+		WRITE_ONCE(node_internal->owner, NULL);
 	return (struct bpf_rb_node *)n;
 }
 
@@ -2093,11 +2116,14 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
 	struct rb_node *parent = NULL, *n = &node->rb_node;
 	bpf_callback_t cb = (bpf_callback_t)less;
 	bool leftmost = true;
+	bool exclusive;
+
+	exclusive = btf_record_has_field(rec, BPF_RB_EXCL_NODE);
 
 	/* node->owner != NULL implies !RB_EMPTY_NODE(n), no need to separately
 	 * check the latter
 	 */
-	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
+	if (!exclusive && cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
 		/* Only called from BPF prog, no need to migrate_disable */
 		__bpf_obj_drop_impl((void *)n - off, rec, false);
 		return -EINVAL;
@@ -2115,7 +2141,8 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
 
 	rb_link_node(n, parent, link);
 	rb_insert_color_cached(n, (struct rb_root_cached *)root, leftmost);
-	WRITE_ONCE(node->owner, root);
+	if (!exclusive)
+		WRITE_ONCE(node->owner, root);
 	return 0;
 }
 
@@ -2562,11 +2589,11 @@ BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
 BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
-BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_pop_front_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_pop_back_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_remove_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f01d2b876a2e..ffab9b6048cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11005,13 +11005,13 @@ enum special_kfunc_type {
 	KF_bpf_refcount_acquire_impl,
 	KF_bpf_list_push_front_impl,
 	KF_bpf_list_push_back_impl,
-	KF_bpf_list_pop_front,
-	KF_bpf_list_pop_back,
+	KF_bpf_list_pop_front_impl,
+	KF_bpf_list_pop_back_impl,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
 	KF_bpf_rcu_read_unlock,
-	KF_bpf_rbtree_remove,
+	KF_bpf_rbtree_remove_impl,
 	KF_bpf_rbtree_add_impl,
 	KF_bpf_rbtree_first,
 	KF_bpf_dynptr_from_skb,
@@ -11031,11 +11031,11 @@ BTF_ID(func, bpf_obj_drop_impl)
 BTF_ID(func, bpf_refcount_acquire_impl)
 BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
-BTF_ID(func, bpf_list_pop_front)
-BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_pop_front_impl)
+BTF_ID(func, bpf_list_pop_back_impl)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
-BTF_ID(func, bpf_rbtree_remove)
+BTF_ID(func, bpf_rbtree_remove_impl)
 BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 BTF_ID(func, bpf_dynptr_from_skb)
@@ -11057,13 +11057,13 @@ BTF_ID(func, bpf_obj_drop_impl)
 BTF_ID(func, bpf_refcount_acquire_impl)
 BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
-BTF_ID(func, bpf_list_pop_front)
-BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_pop_front_impl)
+BTF_ID(func, bpf_list_pop_back_impl)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
 BTF_ID(func, bpf_rcu_read_unlock)
-BTF_ID(func, bpf_rbtree_remove)
+BTF_ID(func, bpf_rbtree_remove_impl)
 BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 BTF_ID(func, bpf_dynptr_from_skb)
@@ -11382,14 +11382,14 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_back];
+	       btf_id == special_kfunc_list[KF_bpf_list_pop_front_impl] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_pop_back_impl];
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
+	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_rbtree_first];
 }
 
@@ -11448,11 +11448,13 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
+	case BPF_LIST_EXCL_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl]);
 		break;
 	case BPF_RB_NODE:
-		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
+	case BPF_RB_EXCL_NODE:
+		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl]);
 		break;
 	default:
@@ -11515,6 +11517,9 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
 		return -EFAULT;
 	}
 	*head_field = field;
+	meta->arg_btf = field->graph_root.btf;
+	meta->arg_btf_id = field->graph_root.value_btf_id;
+
 	return 0;
 }
 
@@ -11603,18 +11608,30 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 					   struct bpf_reg_state *reg, u32 regno,
 					   struct bpf_kfunc_call_arg_meta *meta)
 {
-	return __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
-						  BPF_LIST_HEAD, BPF_LIST_NODE,
-						  &meta->arg_list_head.field);
+	int err;
+
+	err = __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
+						 BPF_LIST_HEAD, BPF_LIST_NODE,
+						 &meta->arg_list_head.field);
+
+	return err ? __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
+							BPF_LIST_HEAD, BPF_LIST_EXCL_NODE,
+							&meta->arg_list_head.field) : 0;
 }
 
 static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
 					     struct bpf_reg_state *reg, u32 regno,
 					     struct bpf_kfunc_call_arg_meta *meta)
 {
-	return __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
-						  BPF_RB_ROOT, BPF_RB_NODE,
-						  &meta->arg_rbtree_root.field);
+	int err;
+
+	err = __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
+						 BPF_RB_ROOT, BPF_RB_NODE,
+						 &meta->arg_rbtree_root.field);
+
+	return err ? __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
+							BPF_RB_ROOT, BPF_RB_EXCL_NODE,
+							&meta->arg_rbtree_root.field) : 0;
 }
 
 /*
@@ -11948,7 +11965,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_RB_NODE:
-			if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_remove]) {
+			if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_remove_impl]) {
 				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
 					verbose(env, "rbtree_remove node input must be non-owning ref\n");
 					return -EINVAL;
@@ -12255,6 +12272,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front_impl] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_list_pop_back_impl] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove_impl])
+		insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
+
 	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
 		if (!bpf_jit_supports_exceptions()) {
 			verbose(env, "JIT does not support calling kfunc %s#%d\n",
@@ -12386,12 +12408,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				insn_aux->kptr_struct_meta =
 					btf_find_struct_meta(meta.arg_btf,
 							     meta.arg_btf_id);
-			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front] ||
-				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
+			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front_impl] ||
+				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back_impl]) {
 				struct btf_field *field = meta.arg_list_head.field;
 
 				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
-			} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
+			} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove_impl] ||
 				   meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
 				struct btf_field *field = meta.arg_rbtree_root.field;
 
@@ -19526,6 +19548,21 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 	*cnt = 4;
 }
 
+static void __fixup_collection_remove_kfunc(struct bpf_insn_aux_data *insn_aux,
+					    u16 struct_meta_reg,
+					    struct bpf_insn *insn,
+					    struct bpf_insn *insn_buf,
+					    int *cnt)
+{
+	struct btf_struct_meta *kptr_struct_meta = insn_aux->kptr_struct_meta;
+	struct bpf_insn addr[2] = { BPF_LD_IMM64(struct_meta_reg, (long)kptr_struct_meta) };
+
+	insn_buf[0] = addr[0];
+	insn_buf[1] = addr[1];
+	insn_buf[2] = *insn;
+	*cnt = 3;
+}
+
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19614,6 +19651,24 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
 						node_offset_reg, insn, insn_buf, cnt);
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_pop_back_impl] ||
+		   desc->func_id == special_kfunc_list[KF_bpf_list_pop_front_impl] ||
+		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_remove_impl]) {
+		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
+		int struct_meta_reg = BPF_REG_2;
+
+		/* rbtree_remove has extra 'node' arg, so args-to-fixup are in diff regs */
+		if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_remove_impl])
+			struct_meta_reg = BPF_REG_3;
+
+		if (!kptr_struct_meta) {
+			verbose(env, "verifier internal error: kptr_struct_meta expected at insn_idx %d\n",
+				insn_idx);
+			return -EFAULT;
+		}
+
+		__fixup_collection_remove_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
+						insn, insn_buf, cnt);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index a4da75df819c..27f6d1fec793 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -91,22 +91,34 @@ extern int bpf_list_push_back_impl(struct bpf_list_head *head,
  * Returns
  *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
  */
-extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
+extern struct bpf_list_node *bpf_list_pop_front_impl(struct bpf_list_head *head,
+						     void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_list_pop_front_impl */
+#define bpf_list_pop_front(head) bpf_list_pop_front_impl(head, NULL)
 
 /* Description
  *	Remove the entry at the end of the BPF linked list.
  * Returns
  *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
  */
-extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
+extern struct bpf_list_node *bpf_list_pop_back_impl(struct bpf_list_head *head,
+					            void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_list_pop_back_impl */
+#define bpf_list_pop_back(head) bpf_list_pop_back_impl(head, NULL)
 
 /* Description
  *	Remove 'node' from rbtree with root 'root'
  * Returns
  * 	Pointer to the removed node, or NULL if 'root' didn't contain 'node'
  */
-extern struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
-					     struct bpf_rb_node *node) __ksym;
+extern struct bpf_rb_node *bpf_rbtree_remove_impl(struct bpf_rb_root *root,
+						  struct bpf_rb_node *node,
+						  void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_rbtree_remove_impl */
+#define bpf_rbtree_remove(head, node) bpf_rbtree_remove_impl(head, node, NULL)
 
 /* Description
  *	Add 'node' to rbtree with root 'root' using comparator 'less'
@@ -132,6 +144,44 @@ extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *nod
  */
 extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
 
+/* Convenience single-ownership graph functions */
+int bpf_list_excl_push_front(struct bpf_list_head *head, struct bpf_list_excl_node *node)
+{
+	return bpf_list_push_front(head, (struct bpf_list_node *)node);
+}
+
+int bpf_list_excl_push_back(struct bpf_list_head *head, struct bpf_list_excl_node *node)
+{
+	return bpf_list_push_back(head, (struct bpf_list_node *)node);
+}
+
+struct bpf_list_excl_node *bpf_list_excl_pop_front(struct bpf_list_head *head)
+{
+	return (struct bpf_list_excl_node *)bpf_list_pop_front(head);
+}
+
+struct bpf_list_excl_node *bpf_list_excl_pop_back(struct bpf_list_head *head)
+{
+	return (struct bpf_list_excl_node *)bpf_list_pop_back(head);
+}
+
+struct bpf_rb_excl_node *bpf_rbtree_excl_remove(struct bpf_rb_root *root,
+					    struct bpf_rb_excl_node *node)
+{
+	return (struct bpf_rb_excl_node *)bpf_rbtree_remove(root, (struct bpf_rb_node *)node);
+}
+
+int bpf_rbtree_excl_add(struct bpf_rb_root *root, struct bpf_rb_excl_node *node,
+		      bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
+{
+	return bpf_rbtree_add(root, (struct bpf_rb_node *)node, less);
+}
+
+struct bpf_rb_excl_node *bpf_rbtree_excl_first(struct bpf_rb_root *root)
+{
+	return (struct bpf_rb_excl_node *)bpf_rbtree_first(root);
+}
+
 /* Description
  *	Allocates a percpu object of the type represented by 'local_type_id' in
  *	program BTF. User may use the bpf_core_type_id_local macro to pass the
-- 
2.20.1


