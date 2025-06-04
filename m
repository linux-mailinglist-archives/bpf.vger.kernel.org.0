Return-Path: <bpf+bounces-59588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38650ACD266
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 03:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077573A29E8
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4204B1E00A0;
	Wed,  4 Jun 2025 00:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSGatwo/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF512B73;
	Wed,  4 Jun 2025 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998659; cv=none; b=nsGmyRdN2MLUdRYctLPvCzloKtwQVe3JmHG+XGIan3gvWvt19FFsN4IHUp7c1bVx0QLZqhsyAd0uLL48q6Y0QGRazd0yVLlF7pVKzx/Vl2rzaGqPiSqFHpNua/p3zA8s11jiZB832pctxo9TWGcNHl7G9VIp+tJ4ydu5B41TVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998659; c=relaxed/simple;
	bh=97t6qTOFW+7pNzdQWb4ZrF0I8kLOeI8bMaxrThwxrNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ak5MurkMT8zH0faVbu5VMjA3yFJ67OVyTC1eUkdPLKTdISjqBr2OpitQT5RNfQAj38+CuLpJTOP62GBrJMMV8MFHlt3B8ksGy8LvtUJFVjFf4JPT93n0kBIGt65GQ6u54VoaEZd8sKUdIjIzpmRUk6X4vECv+bKLuyjTw1CVuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSGatwo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96900C4CEEF;
	Wed,  4 Jun 2025 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998659;
	bh=97t6qTOFW+7pNzdQWb4ZrF0I8kLOeI8bMaxrThwxrNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSGatwo/keWr8IUJGSq2HDZVl769ym2/8rirfYo9kAxF6vKM5h5MoswS+j3JUZJj7
	 vvzY78D0F56EXrXyQHw9fi4PBj5Wu7WShRr3AWh8PJTR8bI0jAUtfiexI32gFHqxWa
	 D8cBjs27I9W2bowX0urJCEvd8tuhRpwTBbMvI3PXn2lZ3awzmyKCI+nuRcHVDFRkVg
	 oCHOxw+Irr5KUtMVjuUsfnL95MIm03ORdolqVhNDhrxOMIQCTOGaTXEaSDWr/6UEd2
	 F2u6aN1ZxxRm5MPh/1E3fm/PZHX5JaNiDdne/+AKPv6X7Cu0MgezPS3yU6CLNYyFC4
	 wPSAYNxg83Evw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 061/108] bpf: Add bpf_rbtree_{root,left,right} kfunc
Date: Tue,  3 Jun 2025 20:54:44 -0400
Message-Id: <20250604005531.4178547-61-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit 9e3e66c553f705de51707c7ddc7f35ce159a8ef1 ]

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
Link: https://lore.kernel.org/r/20250506015857.817950-4-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

NO This commit should not be backported to stable kernel trees. Here's
my extensive analysis: ## Primary Reason: New Feature Addition This
commit adds three new kfunc functions (`bpf_rbtree_root`,
`bpf_rbtree_left`, `bpf_rbtree_right`) to the BPF rbtree API. These are
entirely new capabilities that enable rbtree traversal functionality
that did not exist before. ## Specific Code Analysis ### 1. New Function
Implementations ```c __bpf_kfunc struct bpf_rb_node
*bpf_rbtree_root(struct bpf_rb_root *root) { struct rb_root_cached *r =
(struct rb_root_cached *)root; return (struct bpf_rb_node
*)r->rb_root.rb_node; } __bpf_kfunc struct bpf_rb_node
*bpf_rbtree_left(struct bpf_rb_root *root, struct bpf_rb_node *node) {
struct bpf_rb_node_kern *node_internal = (struct bpf_rb_node_kern
*)node; if (READ_ONCE(node_internal->owner) != root) return NULL; return
(struct bpf_rb_node *)node_internal->rb_node.rb_left; } __bpf_kfunc
struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root, struct
bpf_rb_node *node) { struct bpf_rb_node_kern *node_internal = (struct
bpf_rb_node_kern *)node; if (READ_ONCE(node_internal->owner) != root)
return NULL; return (struct bpf_rb_node
*)node_internal->rb_node.rb_right; } ``` These are completely new
functions that extend the BPF API surface, which is characteristic of
feature additions rather than bug fixes. ### 2. Verifier Infrastructure
Expansion The commit adds these new functions to multiple verifier
tables: ```c enum special_kfunc_type { // ... existing entries ...
KF_bpf_rbtree_root, KF_bpf_rbtree_left, KF_bpf_rbtree_right, // ... }
BTF_SET_START(special_kfunc_set) // ... existing entries ...
BTF_ID(func, bpf_rbtree_root) BTF_ID(func, bpf_rbtree_left) BTF_ID(func,
bpf_rbtree_right) BTF_SET_END(special_kfunc_set) ``` This systematic
addition to verifier infrastructure demonstrates this is an API
expansion, not a fix. ### 3. Enhanced Function Classification Logic ```c
static bool is_bpf_rbtree_api_kfunc(u32 btf_id) { return btf_id ==
special_kfunc_list[KF_bpf_rbtree_add_impl] || btf_id ==
special_kfunc_list[KF_bpf_rbtree_remove] || btf_id ==
special_kfunc_list[KF_bpf_rbtree_first] || + btf_id ==
special_kfunc_list[KF_bpf_rbtree_root] || + btf_id ==
special_kfunc_list[KF_bpf_rbtree_left] || + btf_id ==
special_kfunc_list[KF_bpf_rbtree_right]; } ``` The functions are being
added to existing classification systems, expanding the API scope. ###
4. New Argument Validation Logic ```c static bool
check_kfunc_is_graph_node_api(struct bpf_verifier_env *env, enum
btf_field_type node_field_type, u32 kfunc_btf_id) { // ... existing
logic ... case BPF_RB_NODE: ret = (kfunc_btf_id ==
special_kfunc_list[KF_bpf_rbtree_remove] || kfunc_btf_id ==
special_kfunc_list[KF_bpf_rbtree_add_impl] || + kfunc_btf_id ==
special_kfunc_list[KF_bpf_rbtree_left] || + kfunc_btf_id ==
special_kfunc_list[KF_bpf_rbtree_right]); break; } ``` This adds new
argument validation paths for the new functions. ## Comparison with
Similar Commits Looking at the historical examples: - **Similar Commit
#1 (YES)**: Added basic rbtree kfuncs - this was part of the
foundational rbtree infrastructure - **Similar Commit #2 (YES)**: Added
argument support for rbtree types - essential for the basic
functionality - **Similar Commit #3 (NO)**: Added function declarations
to test headers - clearly test infrastructure - **Similar Commit #4
(NO)**: Added special verifier handling - complex new feature logic -
**Similar Commit #5 (YES)**: Added basic BTF support for rbtree types -
foundational infrastructure ## Use Case Analysis The commit message
describes a complex use case for implementing a Fair Queuing (FQ)
algorithm that requires traversal capabilities. This is clearly an
advanced feature for specialized networking applications, not a bug fix
for existing functionality. ## Risk Assessment Adding new kfuncs carries
several risks: 1. **API Stability**: New functions become part of the
stable ABI 2. **Complexity**: Introduces new code paths in verifier
logic 3. **Testing**: New functionality may not have complete test
coverage in stable kernels 4. **Dependencies**: May rely on other recent
changes not present in stable trees ## Conclusion This commit represents
a clear feature addition that extends the BPF rbtree API with new
traversal capabilities. It does not fix any existing bugs or address
critical issues. The functionality is designed for advanced use cases
and represents an expansion of the BPF programming model rather than
maintenance of existing capabilities. Following stable tree guidelines,
this should remain in mainline development kernels and not be backported
to stable releases.

 kernel/bpf/helpers.c  | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 22 ++++++++++++++++++----
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5e5e945a86b9b..ca3d866e9a2de 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2354,6 +2354,33 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
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
@@ -3103,6 +3130,9 @@ BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
 
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1841467c4f2e5..5c24f36ce36b2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11778,6 +11778,9 @@ enum special_kfunc_type {
 	KF_bpf_rbtree_remove,
 	KF_bpf_rbtree_add_impl,
 	KF_bpf_rbtree_first,
+	KF_bpf_rbtree_root,
+	KF_bpf_rbtree_left,
+	KF_bpf_rbtree_right,
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
@@ -11812,6 +11815,9 @@ BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rbtree_remove)
 BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
+BTF_ID(func, bpf_rbtree_root)
+BTF_ID(func, bpf_rbtree_left)
+BTF_ID(func, bpf_rbtree_right)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
@@ -11843,6 +11849,9 @@ BTF_ID(func, bpf_rcu_read_unlock)
 BTF_ID(func, bpf_rbtree_remove)
 BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
+BTF_ID(func, bpf_rbtree_root)
+BTF_ID(func, bpf_rbtree_left)
+BTF_ID(func, bpf_rbtree_right)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
@@ -12258,7 +12267,10 @@ static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
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
@@ -12349,7 +12361,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
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
@@ -12864,11 +12878,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_RB_NODE:
 			if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_remove]) {
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
 			} else {
-- 
2.39.5


