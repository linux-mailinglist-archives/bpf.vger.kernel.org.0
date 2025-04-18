Return-Path: <bpf+bounces-56267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3760A94004
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52801B6718A
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569C255E23;
	Fri, 18 Apr 2025 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QjXW4eSu"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92E7255249;
	Fri, 18 Apr 2025 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016453; cv=none; b=F8vnCrGeGuZ4LJYoYDsKwDKs2xwh3tx6Dc5Z/NCmplEF2S/tITXhCXnMmOPU+3UK9LYyaGvQwtpXmiURSjO/h6FSG9GcfjMHM9UOM/tOP5I9AKnhf/kvF54FD6vQE3xGmIJY6GMFz6EwRnlUOXPXoEbUT1ttY7bsZiq7O7ChYz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016453; c=relaxed/simple;
	bh=AjZX+0BmaPlLrmnhq9iMLJny5oO0O6XaLptsGcVV0HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsqUNaoVBSnOUJKrobEiqrqkqsaPf3o0oiwSlx/bIlQCDq3WUQtkbSVm8t+547ScSlVHxwvyof7qsEIeUroR1T8relh++C1cJusDaQgMpufok5Ru9XrswNKjnUAcXSokjOmreVG9qQqIfBwKd4M6rBj+zmU9sKl0Hg4mRkx3uoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QjXW4eSu; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOfDyRHkI+uye2d2x32p/JPSDtOGltyZSaojxSO1pfo=;
	b=QjXW4eSulhCJgpaoQtjf/2kfDHtdWOzRDrFWi13q2mwQhFtE/J7Y2hEUJzSaq52Dwu6jvE
	FT64PSeL7MsNeMWoheFb5HT5+ihqhRjMZNziy6XPUik2KBrxLLx7mJPd0KjG8RNOo1XYsd
	ayUOBUGLLWG/UTx2hT4oE7iFOq5oTSE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 08/12] bpf: Simplify reg0 marking for the list kfuncs that return a bpf_list_node pointer
Date: Fri, 18 Apr 2025 15:46:46 -0700
Message-ID: <20250418224652.105998-9-martin.lau@linux.dev>
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

The next patch will add bpf_list_{front,back} kfuncs to peek the head
and tail of a list. Both of them will return a 'struct bpf_list_node *'.

Follow the earlier change for rbtree, this patch checks the
return btf type is a 'struct bpf_list_node' pointer instead
of checking each kfuncs individually to decide if
mark_reg_graph_node should be called. This will make
the bpf_list_{front,back} kfunc addition easier in
the later patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3b905331ca0e..aacde0274e0f 100644
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
@@ -13763,8 +13768,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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


