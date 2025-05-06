Return-Path: <bpf+bounces-57471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353B5AAB90F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EFD507789
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947428AB09;
	Tue,  6 May 2025 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LS8nU96p"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D672F70D2
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496756; cv=none; b=V900ZpSVl20p21WPREPnCLuqsvGbR/fw+bOU4+xdLuaghSHVgcJu6FyeoFPfHLav1hsktoVvU6HhsYckQeuOb2CiEU0SSaNJJ3ZtVHRm34OA7nFO6l2eGKF0JO8wZ6dmHQFUv9ZiFQvn8FmPtiklcxpzJfmBf+T13dYI3rm7E54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496756; c=relaxed/simple;
	bh=e9YQoGHsPv9Pr5rrKlkB55ELjAs7cLYgaTDkrs6kpyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAd6Uoe7v+PNlmotBE0Y6BnDpxZ0MM4wcmK9HiqILDQ2o7jVz7sANNPxELjRYDnPngLIqMguI80cj3z81QSH3b0F1/9VSQr9vSiaWhYp57NUpFj4Pxci4z5m7npplIg8Q+EtJL0Wb3OFCSwrcn1gubxh5PsQj8VNE9Q8GWaNXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LS8nU96p; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746496750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCqE//7IGy5V+pCIAhzsgPWNPRwg/vSnXXRrGIfsfDU=;
	b=LS8nU96p5gtemp+gO+ZJj3I7XCDif6IuTH0gXHVCHr4WJBYjNtdium0Sz0EO0M1fnPFplj
	QT1gYoqv19nH+BvHVTKwMXwOC6j3pNmqJVTvkv7Nd5rvEk3wp2UjvQ2V5ZECEnfC/atu5n
	U0bBlIB17pFo+pEzBAKr4Wh3f49b8uk=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Kumar Kartikeya Dwivedi ' <memxor@gmail.com>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/8] bpf: Simplify reg0 marking for the rbtree kfuncs that return a bpf_rb_node pointer
Date: Mon,  5 May 2025 18:58:49 -0700
Message-ID: <20250506015857.817950-3-martin.lau@linux.dev>
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

The current rbtree kfunc, bpf_rbtree_{first, remove}, returns the
bpf_rb_node pointer. The check_kfunc_call currently checks the
kfunc btf_id instead of its return pointer type to decide
if it needs to do mark_reg_graph_node(reg0) and ref_set_non_owning(reg0).

The later patch will add bpf_rbtree_{root,left,right} that will also
return a bpf_rb_node pointer. Instead of adding more kfunc btf_id
checks to the "if" case, this patch changes the test to check the
kfunc's return type. is_rbtree_node_type() function is added to
test if a pointer type is a bpf_rb_node. The callers have already
skipped the modifiers of the pointer type.

A note on the ref_set_non_owning(), although bpf_rbtree_remove()
also returns a bpf_rb_node pointer, the bpf_rbtree_remove()
has the KF_ACQUIRE flag. Thus, its reg0 will not become non-owning.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2e1ce7debc16..bf14da00f09a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11987,6 +11987,11 @@ static bool is_kfunc_arg_res_spin_lock(const struct btf *btf, const struct btf_p
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RES_SPIN_LOCK_ID);
 }
 
+static bool is_rbtree_node_type(const struct btf_type *t)
+{
+	return t == btf_type_by_id(btf_vmlinux, kf_arg_btf_ids[KF_ARG_RB_NODE_ID]);
+}
+
 static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
 				  const struct btf_param *arg)
 {
@@ -13750,8 +13755,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				struct btf_field *field = meta.arg_list_head.field;
 
 				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
-			} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-				   meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
+			} else if (is_rbtree_node_type(ptr_type)) {
 				struct btf_field *field = meta.arg_rbtree_root.field;
 
 				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
@@ -13881,7 +13885,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			if (is_kfunc_ret_null(&meta))
 				regs[BPF_REG_0].id = id;
 			regs[BPF_REG_0].ref_obj_id = id;
-		} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
+		} else if (is_rbtree_node_type(ptr_type)) {
 			ref_set_non_owning(env, &regs[BPF_REG_0]);
 		}
 
-- 
2.47.1


