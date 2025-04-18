Return-Path: <bpf+bounces-56262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473E2A93FFA
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B600044815E
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3967253324;
	Fri, 18 Apr 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FcM/eetA"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A4253B75
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016441; cv=none; b=Gufh3XUfiVCTngveHK1cJ8hao49ckvZcDGkwy6/2VIrpD6oMM0acAJU5kGcdXz3OTxtyjKo+bS0lljYbCCt3/v3PztVQK9AD5NYYrKtPJZYez0VLcNF+dnPqXnb2TM6esGrWt432zu3Y8Fl+wJhvpxHXrHqH5gvVVbt6wVbwTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016441; c=relaxed/simple;
	bh=9PJBt/4tvHniINIAyNyoTYfl71UQ9akMAzCxOXNwK+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCRllGXXzR8o/TCgWw54Pbxt/28rXsSyk+kX6Qkng+fwSAWtNaXeQ7A/yu4sggd950OpesJuexjWs6YYdtKPb9ChnDu1fuWyJ8uHkTetUNQsNu1D8lkPkUXtKyTGfFOoCYgw77BZJP4QnQI0XILMVko18BY2S72/52dGJNZ+hqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FcM/eetA; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4+Fgc7EEB97NPIdx5N+inrw28wsUjm9qufyeomFPuM=;
	b=FcM/eetAfjHcZA3iq5u68Hlc0m+YzMaaqCjpCJhEtw4yq0wmwwN427BOuQlkvRfPn+WGFt
	KgvZkMOgyJNqosw9Gvm5m9Ap+RNfArEAKFLwcFs1XfzzK3CUxxG1JEudmDP1BUnLr7Ynxe
	dpimkLb+XeXjdgQqBhJH8Ykr1mmMvts=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 03/12] bpf: Add bpf_rbtree_{root,left,right} kfunc
Date: Fri, 18 Apr 2025 15:46:41 -0700
Message-ID: <20250418224652.105998-4-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-1-martin.lau@linux.dev>
References: <20250418224652.105998-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

In the kernel fq qdisc implementation, it requires to traverse a rbtree
stored with the networking "flows".

In the later bpf selftests prog, the much simplified logic that uses
the bpf_rbtree_{root,left,right} to traverse the tree is like:

struct fq_flow {
	struct bpf_rb_node	fq_node;
	struct bpf_rb_node	rate_node;
	struct bpf_refcount	refcount;
	unsigned long		sk_long;
};

struct fq_flow_root {
	struct bpf_spin_lock lock;
	struct bpf_rb_root root __contains(fq_flow, fq_node);
};

struct fq_flow *fq_classify(...)
{
	struct bpf_rb_node *tofree[FQ_GC_MAX];
	struct fq_flow_root *root;
	struct fq_flow *gc_f, *f;
	struct bpf_rb_node *p;
	int i, fcnt = 0;

	/* ... */

	f = NULL;
	bpf_spin_lock(&root->lock);
	p = bpf_rbtree_root(&root->root);
	while (can_loop) {
		if (!p)
			break;

		gc_f = bpf_rb_entry(p, struct fq_flow, fq_node);
		if (gc_f->sk_long == sk_long) {
			f = bpf_refcount_acquire(gc_f);
			break;
		}

		/* To be removed from the rbtree */
		if (fcnt < FQ_GC_MAX && fq_gc_candidate(gc_f, jiffies_now))
			tofree[fcnt++] = p;

		if (gc_f->sk_long > sk_long)
			p = bpf_rbtree_left(&root->root, p);
		else
			p = bpf_rbtree_right(&root->root, p);
	}

	/* remove from the rbtree */
	for (i = 0; i < fcnt; i++) {
		p = tofree[i];
		tofree[i] = bpf_rbtree_remove(&root->root, p);
	}

	bpf_spin_unlock(&root->lock);

	/* bpf_obj_drop the fq_flow(s) that have just been removed
	 * from the rbtree.
	 */
	for (i = 0; i < fcnt; i++) {
		p = tofree[i];
		if (p) {
			gc_f = bpf_rb_entry(p, struct fq_flow, fq_node);
			bpf_obj_drop(gc_f);
		}
	}

	return f;

}

The above simplified code needs to traverse the rbtree for two purposes,
1) find the flow with the desired sk_long value
2) while searching for the sk_long, collect flows that are
   the fq_gc_candidate. They will be removed from the rbtree.

This patch adds the bpf_rbtree_{root,left,right} kfunc to enable
the rbtree traversal. The returned bpf_rb_node pointer will be a
non-owning reference which is the same as the returned pointer
of the exisiting bpf_rbtree_first kfunc.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/helpers.c  | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 23 ++++++++++++++++++-----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..36150d340c16 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2366,6 +2366,33 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
 	return (struct bpf_rb_node *)rb_first_cached(r);
 }
 
+__bpf_kfunc struct bpf_rb_node *bpf_rbtree_root(struct bpf_rb_root *root)
+{
+	struct rb_root_cached *r = (struct rb_root_cached *)root;
+
+	return (struct bpf_rb_node *)r->rb_root.rb_node;
+}
+
+__bpf_kfunc struct bpf_rb_node *bpf_rbtree_left(struct bpf_rb_root *root, struct bpf_rb_node *node)
+{
+	struct bpf_rb_node_kern *node_internal = (struct bpf_rb_node_kern *)node;
+
+	if (READ_ONCE(node_internal->owner) != root)
+		return NULL;
+
+	return (struct bpf_rb_node *)node_internal->rb_node.rb_left;
+}
+
+__bpf_kfunc struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root, struct bpf_rb_node *node)
+{
+	struct bpf_rb_node_kern *node_internal = (struct bpf_rb_node_kern *)node;
+
+	if (READ_ONCE(node_internal->owner) != root)
+		return NULL;
+
+	return (struct bpf_rb_node *)node_internal->rb_node.rb_right;
+}
+
 /**
  * bpf_task_acquire - Acquire a reference to a task. A task acquired by this
  * kfunc which is not stored in a map as a kptr, must be released by calling
@@ -3214,6 +3241,9 @@ BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
 
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf14da00f09a..3624de1c6925 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12081,6 +12081,9 @@ enum special_kfunc_type {
 	KF_bpf_rbtree_remove,
 	KF_bpf_rbtree_add_impl,
 	KF_bpf_rbtree_first,
+	KF_bpf_rbtree_root,
+	KF_bpf_rbtree_left,
+	KF_bpf_rbtree_right,
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
@@ -12121,6 +12124,9 @@ BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rbtree_remove)
 BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
+BTF_ID(func, bpf_rbtree_root)
+BTF_ID(func, bpf_rbtree_left)
+BTF_ID(func, bpf_rbtree_right)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
@@ -12156,6 +12162,9 @@ BTF_ID(func, bpf_rcu_read_unlock)
 BTF_ID(func, bpf_rbtree_remove)
 BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
+BTF_ID(func, bpf_rbtree_root)
+BTF_ID(func, bpf_rbtree_left)
+BTF_ID(func, bpf_rbtree_right)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
@@ -12591,7 +12600,10 @@ static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_first];
+	       btf_id == special_kfunc_list[KF_bpf_rbtree_first] ||
+	       btf_id == special_kfunc_list[KF_bpf_rbtree_root] ||
+	       btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
+	       btf_id == special_kfunc_list[KF_bpf_rbtree_right];
 }
 
 static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
@@ -12691,7 +12703,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 		break;
 	case BPF_RB_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl]);
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_right]);
 		break;
 	default:
 		verbose(env, "verifier internal error: unexpected graph node argument type %s\n",
@@ -13216,15 +13230,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 			} else {
 				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
-					verbose(env, "rbtree_remove node input must be non-owning ref\n");
+					verbose(env, "%s can only take non-owning bpf_rb_node pointer\n", func_name);
 					return -EINVAL;
 				}
 				if (in_rbtree_lock_required_cb(env)) {
-					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
+					verbose(env, "%s not allowed in rbtree cb\n", func_name);
 					return -EINVAL;
 				}
 			}
-
 			ret = process_kf_arg_ptr_to_rbtree_node(env, reg, regno, meta);
 			if (ret < 0)
 				return ret;
-- 
2.47.1


