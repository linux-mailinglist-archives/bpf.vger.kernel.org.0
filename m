Return-Path: <bpf+bounces-47368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A559B9F87B6
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 23:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840D3188E811
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591211FD795;
	Thu, 19 Dec 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f12iwa4z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107101D014E;
	Thu, 19 Dec 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734646520; cv=none; b=GcUEvF9njXtyByCoiz6KKtkPmQmDi6RllT6QKodyK3U6H9RzGB8nsn47cxZk0WBL8EI7hZx3bQaWTi/K9brK2xc919BsnAGtCorcBYkfUriGcpsMVFLDNrmk158SGEzOhbnA+3wB6yzAM+gQGmBi942J71CHHm57dEKv/SeYf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734646520; c=relaxed/simple;
	bh=0X9kUtsvLKkTifAc//9RFrImSq3U8YKJ4Fg+rCv1zno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExuWNdhyfFP6X2uOS0raOmtBa5GARCJfA58vwlOvKmemNKByY1lGUpe+suCWhhm805u/nWdfs5C3tLlp2lDEZdJBXWJAcSZcjzQXkwoSo8/lYchbfqkCUvHl69Y6lw+pkRQNCVqo6llwaX1KtqF914HFqyHCNzHXU8NEct0SC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f12iwa4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B3BC4CECE;
	Thu, 19 Dec 2024 22:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734646519;
	bh=0X9kUtsvLKkTifAc//9RFrImSq3U8YKJ4Fg+rCv1zno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f12iwa4zck7k6pmC4mxljKdrp7EOUyosSBR3ffOhd4pH5y2gx/x/9w0iKXqPkxypI
	 NWVJ0KKl3482393i2YoGrKMZ5x//2LrguupkTZFLElVwQzX35h+hbiuAkXLWXUeW9c
	 Eblh55/cDQsap1NEIwi0CjI4APWoxUexFMoYlc/zUTNkebBW38Q/Ne1zNkB+d4h/bR
	 1qzqXl9+EUsm70hzdf/3XPllfC6Knt7bYW5J0IDhxXGFDIg+rhuryg/v+7l9Fi2TQy
	 B9pKjXPf7s/HWSlH3LOQA8AH/Klzaoxe5wiyjeEjFav19/ub3MRZ93HbsljIdks1Cq
	 TSNv+i3n5xwFQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	memxor@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v7 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
Date: Thu, 19 Dec 2024 14:14:37 -0800
Message-ID: <20241219221439.2455664-6-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241219221439.2455664-1-song@kernel.org>
References: <20241219221439.2455664-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_kfunc_id_set.remap can pick proper version of a kfunc for the calling
context. Use this logic to select bpf_dynptr_from_skb or
bpf_dynptr_from_skb_rdonly. This will make the verifier simpler.

Unfortunately, btf_kfunc_id_set.remap cannot cover the DYNPTR_TYPE_SKB
logic in check_kfunc_args(). This can be addressed later.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/verifier.c | 28 ++++++++-----------------
 net/core/filter.c     | 49 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ac45c1f2837c..e841ba22a6c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11677,6 +11677,7 @@ enum special_kfunc_type {
 	KF_bpf_rbtree_add_impl,
 	KF_bpf_rbtree_first,
 	KF_bpf_dynptr_from_skb,
+	KF_bpf_dynptr_from_skb_rdonly,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
@@ -11709,6 +11710,7 @@ BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
+BTF_ID(func, bpf_dynptr_from_skb_rdonly)
 BTF_ID(func, bpf_dynptr_from_xdp)
 #endif
 BTF_ID(func, bpf_dynptr_slice)
@@ -11740,7 +11742,12 @@ BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
+BTF_ID(func, bpf_dynptr_from_skb_rdonly)
 BTF_ID(func, bpf_dynptr_from_xdp)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
@@ -12647,7 +12654,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
+			    meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_rdonly]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
@@ -20808,9 +20816,7 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 			     u32 func_id, u16 offset, unsigned long *addr)
 {
 	struct bpf_prog *prog = env->prog;
-	bool seen_direct_write;
 	void *xdp_kfunc;
-	bool is_rdonly;
 
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
@@ -20820,22 +20826,6 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 		}
 		/* fallback to default kfunc when not supported by netdev */
 	}
-
-	if (offset)
-		return;
-
-	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
-		seen_direct_write = env->seen_direct_write;
-		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
-
-		if (is_rdonly)
-			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
-
-		/* restore env->seen_direct_write to its original value, since
-		 * may_access_direct_pkt_data mutates it
-		 */
-		env->seen_direct_write = seen_direct_write;
-	}
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
diff --git a/net/core/filter.c b/net/core/filter.c
index 21131ec25f24..f12bcc1b21d1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12047,10 +12047,8 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
-__bpf_kfunc_end_defs();
-
-int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
-			       struct bpf_dynptr *ptr__uninit)
+__bpf_kfunc int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
+					   struct bpf_dynptr *ptr__uninit)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
 	int err;
@@ -12064,10 +12062,16 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 	return 0;
 }
 
+__bpf_kfunc_end_defs();
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
+BTF_HIDDEN_KFUNCS_START(bpf_kfunc_check_hidden_set_skb)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_rdonly, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_hidden_set_skb)
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
@@ -12080,9 +12084,46 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
+BTF_ID_LIST(bpf_dynptr_from_skb_list)
+BTF_ID(func, bpf_dynptr_from_skb)
+BTF_ID(func, bpf_dynptr_from_skb_rdonly)
+
+static u32 bpf_kfunc_set_skb_remap(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (kfunc_id != bpf_dynptr_from_skb_list[0])
+		return 0;
+
+	switch (resolve_prog_type(prog)) {
+	/* Program types only with direct read access go here! */
+	case BPF_PROG_TYPE_LWT_IN:
+	case BPF_PROG_TYPE_LWT_OUT:
+	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
+	case BPF_PROG_TYPE_SK_REUSEPORT:
+	case BPF_PROG_TYPE_FLOW_DISSECTOR:
+	case BPF_PROG_TYPE_CGROUP_SKB:
+		return bpf_dynptr_from_skb_list[1];
+
+	/* Program types with direct read + write access go here! */
+	case BPF_PROG_TYPE_SCHED_CLS:
+	case BPF_PROG_TYPE_SCHED_ACT:
+	case BPF_PROG_TYPE_XDP:
+	case BPF_PROG_TYPE_LWT_XMIT:
+	case BPF_PROG_TYPE_SK_SKB:
+	case BPF_PROG_TYPE_SK_MSG:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		return kfunc_id;
+
+	default:
+		break;
+	}
+	return bpf_dynptr_from_skb_list[1];
+}
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
+	.hidden_set = &bpf_kfunc_check_hidden_set_skb,
+	.remap = &bpf_kfunc_set_skb_remap,
 };
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
-- 
2.43.5


