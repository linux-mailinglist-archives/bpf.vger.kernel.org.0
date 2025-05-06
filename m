Return-Path: <bpf+bounces-57476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA46BAAB8FC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09997BC5D7
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE2328E5FE;
	Tue,  6 May 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YQPI7O/p"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B34307219;
	Tue,  6 May 2025 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496765; cv=none; b=Ma37iBvCDJF2CdntmpGAQiGsrULwsz89h2HO/KNoy/eoSEFq27L5/ZZFjlTVExdFjcAEw6lWwnNVXJHoNgPBJFwZywopRl4twim8Kd/x/I78LaesWER+glJKKD/kPcaoP3Uexi47G2KiUx6/dejYI1/XJE0Wnlsls1Tn4LLaDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496765; c=relaxed/simple;
	bh=w67WkSR6GBFb0297iPDQN/LQ40KIXTJ1WJ97gwRtOmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWhxtxCTKd1WT6Vql8CWKXqkXdwqn1kUWEosQn/8RScnZwzAKIyVIUqVn1rqLoGrMRHBhQuqsYHYyGt3znTebcHEBujHe2x3ZghWSFhZ/609Iy5QGPfvLej1wz/gaeEXonls0dYz/ArEzVN7GTh31m0D732nnmjiIaToGtuoOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YQPI7O/p; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746496760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXz84LoY63sFkcYTvfjl3+K7yK/CPdj2Wms2qb1xZx4=;
	b=YQPI7O/pssGD5wlAcmeiacL8WUWiPd84Aw9HQvaPTOgQ2vEw5HzvlW+Z2J8fOaa7P7C3xQ
	+aU0FJ91M5IU5XkvhZLAS9XAsuZ7O+1umTMhgLpOuVR00Wg5jFWFhjFHu0/Rog4hjnXx1X
	b00oo0z9o28AsHNvfhTy4lbay1MhvVM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Kumar Kartikeya Dwivedi ' <memxor@gmail.com>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 6/8] bpf: Simplify reg0 marking for the list kfuncs that return a bpf_list_node pointer
Date: Mon,  5 May 2025 18:58:53 -0700
Message-ID: <20250506015857.817950-7-martin.lau@linux.dev>
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

The next patch will add bpf_list_{front,back} kfuncs to peek the head
and tail of a list. Both of them will return a 'struct bpf_list_node *'.

Follow the earlier change for rbtree, this patch checks the
return btf type is a 'struct bpf_list_node' pointer instead
of checking each kfuncs individually to decide if
mark_reg_graph_node should be called. This will make
the bpf_list_{front,back} kfunc addition easier in
the later patch.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9093a351b0b3..acb2f44316cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11992,6 +11992,11 @@ static bool is_rbtree_node_type(const struct btf_type *t)
 	return t == btf_type_by_id(btf_vmlinux, kf_arg_btf_ids[KF_ARG_RB_NODE_ID]);
 }
 
+static bool is_list_node_type(const struct btf_type *t)
+{
+	return t == btf_type_by_id(btf_vmlinux, kf_arg_btf_ids[KF_ARG_LIST_NODE_ID]);
+}
+
 static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
 				  const struct btf_param *arg)
 {
@@ -13764,8 +13769,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				insn_aux->kptr_struct_meta =
 					btf_find_struct_meta(meta.arg_btf,
 							     meta.arg_btf_id);
-			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front] ||
-				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
+			} else if (is_list_node_type(ptr_type)) {
 				struct btf_field *field = meta.arg_list_head.field;
 
 				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
-- 
2.47.1


