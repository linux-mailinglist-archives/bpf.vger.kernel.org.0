Return-Path: <bpf+bounces-56268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBBEA94008
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3345A8A3946
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13792561A3;
	Fri, 18 Apr 2025 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xtKtOTMn"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BBA255E38
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016456; cv=none; b=WEUm8f5o5NrF6KHMbTeZ6jIJUrbvfFz2DYy0zyePUS9n6t13rT461HEj/HK0x4VB+fs9HqQ8JDOPdEsCbIAYCW1f61CEgukYemlN1J7s6KDZ+gdExYPEwdtItJ33pdce8ZsRn4hZawdDmUW1nN/dtiHKckmEmAivNJvAuMViB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016456; c=relaxed/simple;
	bh=Ya1zEAYNutolwv6KH1vqLiZ54drfZW43K2kgHG1e6dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elzkXZCKQHp0KjeRgmyR0xMNp8kUJIdR3BbXvJjX/ldUFXVszuY6c6hoXVCR+muuIHUYPNv1iRUBtSdicxNw3MfeJTuPtYBk3NlO76Z8Zc0WG5/GH8w23VoltlpnsHKqrnyYnMbUgBd26VbtKDTzF8GjZ6Yto8hwlKxGoatP1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xtKtOTMn; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0Jov62g6P3kuxMg3ohcNB00iUIpotsSk9z8qoAzQOE=;
	b=xtKtOTMnEtxdfp0clvr/p3wdzobNUVoQJCnBVa5mzBkNOMTfATSzbzbcHo/TYnUkfXxOmI
	qjL8q0hD4FMJDbZoybhXR0beVT/hZNcUSmxdbOuhhrK90QiGJxMzUC3BCm+sMNgF4DASin
	JCe2yFPjlWUseiFqn/pOIWM0d6O3N3w=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 09/12] bpf: Add bpf_list_{front,back} kfunc
Date: Fri, 18 Apr 2025 15:46:47 -0700
Message-ID: <20250418224652.105998-10-martin.lau@linux.dev>
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

In the kernel fq qdisc implementation, it only needs to look at
the fields of the first node in a list but does not always
need to remove it from the list. It is more convenient to have
a peek kfunc for the list. It works similar to the bpf_rbtree_first().

This patch adds bpf_list_{front,back} kfunc. The verifier is changed
such that the kfunc returning "struct bpf_list_node *" will be
marked as non-owning. The exception is the KF_ACQUIRE kfunc. The
net effect is only the new bpf_list_{front,back} kfuncs will
have its return pointer marked as non-owning.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/helpers.c  | 22 ++++++++++++++++++++++
 kernel/bpf/verifier.c | 12 ++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 36150d340c16..78cefb41266a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2293,6 +2293,26 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return __bpf_list_del(head, true);
 }
 
+__bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
+{
+	struct list_head *h = (struct list_head *)head;
+
+	if (list_empty(h) || unlikely(!h->next))
+		return NULL;
+
+	return (struct bpf_list_node *)h->next;
+}
+
+__bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
+{
+	struct list_head *h = (struct list_head *)head;
+
+	if (list_empty(h) || unlikely(!h->next))
+		return NULL;
+
+	return (struct bpf_list_node *)h->prev;
+}
+
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
@@ -3236,6 +3256,8 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aacde0274e0f..78a9b3d1cd29 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12079,6 +12079,8 @@ enum special_kfunc_type {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_front,
+	KF_bpf_list_back,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12124,6 +12126,8 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_front)
+BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rbtree_remove)
@@ -12160,6 +12164,8 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_front)
+BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -12598,7 +12604,9 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_back];
+	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_back];
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
@@ -13902,7 +13910,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			if (is_kfunc_ret_null(&meta))
 				regs[BPF_REG_0].id = id;
 			regs[BPF_REG_0].ref_obj_id = id;
-		} else if (is_rbtree_node_type(ptr_type)) {
+		} else if (is_rbtree_node_type(ptr_type) || is_list_node_type(ptr_type)) {
 			ref_set_non_owning(env, &regs[BPF_REG_0]);
 		}
 
-- 
2.47.1


