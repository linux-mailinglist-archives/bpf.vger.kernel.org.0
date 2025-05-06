Return-Path: <bpf+bounces-57474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B49AAB8F9
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA9D7BC51A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3EA28E5E5;
	Tue,  6 May 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q9cdxjuc"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF992DD783
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496760; cv=none; b=Nw2qSrQ+41RSlBEAda/kuqyTZnDwGZsvoC9tdaW1Ig9vqvQPUp1MrnsSDWvcnlLM7AqER+0sxKSTVwzhZC7dQim+A5scVC8sZYIn9a18QSjRszKKRgHplVY8DGj4q4gLgreNlqNMsBJY9LDWQfyu6HOe3WnpyW6+jFMssQAlsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496760; c=relaxed/simple;
	bh=PtUVnOB5q6JFqdHiN0cW5krLKdFfu1RGeUg2Mtbd7qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEwC0d5Aik004HWAjn8HXuoU/0oMeYkueaeNMLfnW/v5F1kArykvHkfH3eyVxF9O4maDtvW0CpaUCcFUZTDG8DNe0E4xk0BhYL/VPjRsgxEEHYSsnSanDVmC0EeUpeDEi3pMCu9r4UzZfvZtKYh/4+tjYXIy63gdz91ELQH8EIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q9cdxjuc; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746496755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJGD1avinBgywaR2ZwStYQSNCOH7SnE4tXoeb8pImL8=;
	b=Q9cdxjucdiyBpyRaqDE/+kernmAum7EIuMOxr9moLk7CH/KX1FVeNNn7rrWjsS+FouclsR
	vhHx5HtVt/PghE7wswsB/9CabnUC78xtUpb/wU3n1bPklb+Q/9I+f0vb3tO5iOYReoKmpQ
	V1k1FR4C3nsTcMDDA9MZQNicNnQwpLU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Kumar Kartikeya Dwivedi ' <memxor@gmail.com>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 4/8] bpf: Allow refcounted bpf_rb_node used in bpf_rbtree_{remove,left,right}
Date: Mon,  5 May 2025 18:58:51 -0700
Message-ID: <20250506015857.817950-5-martin.lau@linux.dev>
In-Reply-To: <20250506015857.817950-1-martin.lau@linux.dev>
References: <20250506015857.817950-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The bpf_rbtree_{remove,left,right} requires the root's lock to be held.
They also check the node_internal->owner is still owned by that root
before proceeding, so it is safe to allow refcounted bpf_rb_node
pointer to be used in these kfuncs.

In a bpf fq implementation which is much closer to the kernel fq,
https://lore.kernel.org/bpf/20250418224652.105998-13-martin.lau@linux.dev/,
a networking flow (allocated by bpf_obj_new) can be added to two different
rbtrees. There are cases that the flow is searched from one rbtree,
held the refcount of the flow, and then removed from another rbtree:

struct fq_flow {
	struct bpf_rb_node	fq_node;
	struct bpf_rb_node	rate_node;
	struct bpf_refcount	refcount;
	unsigned long		sk_long;
};

int bpf_fq_enqueue(...)
{
	/* ... */

	bpf_spin_lock(&root->lock);
	while (can_loop) {
		/* ... */
		if (!p)
			break;
		gc_f = bpf_rb_entry(p, struct fq_flow, fq_node);
		if (gc_f->sk_long == sk_long) {
			f = bpf_refcount_acquire(gc_f);
			break;
		}
		/* ... */
	}
	bpf_spin_unlock(&root->lock);

	if (f) {
		bpf_spin_lock(&q->lock);
		bpf_rbtree_remove(&q->delayed, &f->rate_node);
		bpf_spin_unlock(&q->lock);
	}
}

bpf_rbtree_{left,right} do not need this change but are relaxed together
with bpf_rbtree_remove instead of adding extra verifier logic
to exclude these kfuncs.

To avoid bi-sect failure, this patch also changes the selftests together.

The "rbtree_api_remove_unadded_node" is not expecting verifier's error.
The test now expects bpf_rbtree_remove(&groot, &m->node) to return NULL.
The test uses __retval(0) to ensure this NULL return value.

Some of the "only take non-owning..." failure messages are changed also.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c                         |  4 +--
 .../testing/selftests/bpf/progs/rbtree_fail.c | 29 ++++++++++---------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 51a17e64a0a9..9093a351b0b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13229,8 +13229,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			} else {
-				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
-					verbose(env, "%s node input must be non-owning ref\n", func_name);
+				if (!type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
+					verbose(env, "%s can only take non-owning or refcounted bpf_rb_node pointer\n", func_name);
 					return -EINVAL;
 				}
 				if (in_rbtree_lock_required_cb(env)) {
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index dbd5eee8e25e..4acb6af2dfe3 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -69,11 +69,11 @@ long rbtree_api_nolock_first(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("rbtree_remove node input must be non-owning ref")
+__retval(0)
 long rbtree_api_remove_unadded_node(void *ctx)
 {
 	struct node_data *n, *m;
-	struct bpf_rb_node *res;
+	struct bpf_rb_node *res_n, *res_m;
 
 	n = bpf_obj_new(typeof(*n));
 	if (!n)
@@ -88,19 +88,20 @@ long rbtree_api_remove_unadded_node(void *ctx)
 	bpf_spin_lock(&glock);
 	bpf_rbtree_add(&groot, &n->node, less);
 
-	/* This remove should pass verifier */
-	res = bpf_rbtree_remove(&groot, &n->node);
-	n = container_of(res, struct node_data, node);
+	res_n = bpf_rbtree_remove(&groot, &n->node);
 
-	/* This remove shouldn't, m isn't in an rbtree */
-	res = bpf_rbtree_remove(&groot, &m->node);
-	m = container_of(res, struct node_data, node);
+	res_m = bpf_rbtree_remove(&groot, &m->node);
 	bpf_spin_unlock(&glock);
 
-	if (n)
-		bpf_obj_drop(n);
-	if (m)
-		bpf_obj_drop(m);
+	bpf_obj_drop(m);
+	if (res_n)
+		bpf_obj_drop(container_of(res_n, struct node_data, node));
+	if (res_m) {
+		bpf_obj_drop(container_of(res_m, struct node_data, node));
+		/* m was not added to the rbtree */
+		return 2;
+	}
+
 	return 0;
 }
 
@@ -178,7 +179,7 @@ long rbtree_api_use_unchecked_remove_retval(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("rbtree_remove node input must be non-owning ref")
+__failure __msg("bpf_rbtree_remove can only take non-owning or refcounted bpf_rb_node pointer")
 long rbtree_api_add_release_unlock_escape(void *ctx)
 {
 	struct node_data *n;
@@ -202,7 +203,7 @@ long rbtree_api_add_release_unlock_escape(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("rbtree_remove node input must be non-owning ref")
+__failure __msg("bpf_rbtree_remove can only take non-owning or refcounted bpf_rb_node pointer")
 long rbtree_api_first_release_unlock_escape(void *ctx)
 {
 	struct bpf_rb_node *res;
-- 
2.47.1


