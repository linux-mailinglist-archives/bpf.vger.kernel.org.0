Return-Path: <bpf+bounces-57472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF96AAB908
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FDD50755E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6128B405;
	Tue,  6 May 2025 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KJO/WXDt"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547D2F9273
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496757; cv=none; b=tNmMzyBQaj3RVA6fWFKA3GYZ6HMQY9gs4wX7WJIiv1wTTVXtIkdmUHGetFOX/f2Ag48b94Ig2Mz/tjflE4PdEOIYNSnEaZGIkjFoufzVAAeApupZtaQ6vY262S8uAAa1OPeZ4OMo8EPHR4ZBcBEoXxqB+lAf/dOXNPZhE9qrIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496757; c=relaxed/simple;
	bh=DNYx17iPXP2H8MdZx/0OjxH8ZaEJtUwj+fnlUTRrWOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI3A3IqZBW9PIM9gD+AR7K10uSbcss8sAKwt6up9P3mie9SuH7QWfvIvOCb46WXbJ1bDk85zg2cm2YBc0dqwb2sbTTFDh5V+GEX88rdkrnCu5tRWN7MMiPdM+rw6u4dTNT2VKOR1h9o0NbUw7avGvDpW9QV3vSPeUN2nZdb4uAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KJO/WXDt; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746496753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcixz8loJMoZWFxO9bfnR+hPfWw7XNDZp1NmxOykE9c=;
	b=KJO/WXDt7g9lJxGytA+brsAdR+izsXqEbHILHt+Mkzvs8CXV6HQeLYAE7Dz8umrBpUsQVx
	JP/JsipfBAhNAz8vTtZ26gvOBWx8ba2joMuZ+Ebo+bYEHYXN9fbiMenCThJgPkNrYSPr8E
	ouNZxXlLVhqBWNSQ7EMjME8Tw1psfxs=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Kumar Kartikeya Dwivedi ' <memxor@gmail.com>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/8] bpf: Add bpf_rbtree_{root,left,right} kfunc
Date: Mon,  5 May 2025 18:58:50 -0700
Message-ID: <20250506015857.817950-4-martin.lau@linux.dev>
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

In a bpf fq implementation that is much closer to the kernel fq,
it will need to traverse the rbtree:
https://lore.kernel.org/bpf/20250418224652.105998-13-martin.lau@linux.dev/

The much simplified logic that uses the bpf_rbtree_{root,left,right}
to traverse the rbtree is like:

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

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/helpers.c  | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 22 ++++++++++++++++++----
 2 files changed, 48 insertions(+), 4 deletions(-)

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
index bf14da00f09a..51a17e64a0a9 100644
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
@@ -13216,11 +13230,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 			} else {
 				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
-					verbose(env, "rbtree_remove node input must be non-owning ref\n");
+					verbose(env, "%s node input must be non-owning ref\n", func_name);
 					return -EINVAL;
 				}
 				if (in_rbtree_lock_required_cb(env)) {
-					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
+					verbose(env, "%s not allowed in rbtree cb\n", func_name);
 					return -EINVAL;
 				}
 			}
-- 
2.47.1


