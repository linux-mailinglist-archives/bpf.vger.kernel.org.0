Return-Path: <bpf+bounces-56261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A62A93FF7
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C2B44821E
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7E0253F10;
	Fri, 18 Apr 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RVAnd1Vt"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A5253B55
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016437; cv=none; b=EJ4SqmVz9rn5rDh0ZrFGTYn/+WMWUTUjrbUIitKpB7qLcgfEjW4mG2xBUfZOnQDrNTgVM1ga87wQQQg+ohrLYL6bFbkBXdLrEylltbgQhKrXbHoXyDsGpry6jqgVihkz/ug6iw7MzlpPseMN/9s588UtAq9FZTnfvYPf5jEvTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016437; c=relaxed/simple;
	bh=hZNL8FaX5nbwJ3VvS2791LPVX33JvOa5GXZ5uWh8o/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLhlj/rX0Ddye0fuutDvkO8MilgbVRd1piCOLpKd0siJ/bHtFTFrh5rDXBpYWV1fNDIFgOrzPbivLCWDWWSU23nZ3za30pQ3tVCnTfuJIJAfhDuAviev0mBHJuy7s8V1o/YgO56jJ/mRUyVMbzqHsRqAe3tsKOl61B806JUywa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RVAnd1Vt; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddWB+m84a0iJbxYqZiaRkEN7iNLdkmkc0rCeihP24f4=;
	b=RVAnd1Vt6+7RgZLdJBfszKkXaag25S1Rhgc+FCxfzL6WpptF4c5xtfsNBdJ7g4oYjrL6lv
	3CDkDRSos3LX1oPQOKiaUJcOG/dc4Q4nK/kcgWdYqEN+SavU19by2Ah0hMMPFvSvtXDTcW
	k2H39fgAGrlAmF+BULqG2Dcw5t0Iheo=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 02/12] bpf: Simplify reg0 marking for the rbtree kfuncs that return a bpf_rb_node pointer
Date: Fri, 18 Apr 2025 15:46:40 -0700
Message-ID: <20250418224652.105998-3-martin.lau@linux.dev>
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


