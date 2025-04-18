Return-Path: <bpf+bounces-56265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7680A94000
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C931B673A7
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA562550C2;
	Fri, 18 Apr 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qm+ln21L"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E91254B1D
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016448; cv=none; b=kcgNpQInS3N4MLYIx2MZxnWBGU/wrqOU/xyJDw8QaJTLlyyw8phkh+kj16o91HxUBofaz/tlhJdmG8rLDhN/H3yqzQM7nHeN6St1gDzxo23T17dN1IVLQQ2x+aBo5nYgr84Whl33FvrSa1hAZAySvOe85BRSmhxXiMx3aqyUTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016448; c=relaxed/simple;
	bh=HZ8T7J57P/bxP1ziEyHwnHBXTuztbDu/PQoKHAuFkWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZuz6D4/Ysj2R5IvGvSgr+raVQK6XqURtvPtD5JAh3Ur/ynYeBWXlfiM56rOwbcB5bNEQsz779tiosEgkR5qm5jGi6/B72V2qkX4qGlKE761gYbMOKLIH764sCFxmK/nO0LLrGXAO4hmWwqrNq/tatyhaHvjvOoGQmYSJnlRJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qm+ln21L; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOV4NH4C8SzaFUvxJ45cIX3wrZfNDYoZ1kAm/yKhHn4=;
	b=qm+ln21LlCwOA4pUndpfwEq7fbW7Eh0gHs07WRelGmh3ILBgMj6QnW2JmVaaD4henU14Sj
	8eGD5Lxdm1KOAwiAI8tKYgfB2gKRwgG5+MKK0ukklQW4CDb7VKIKcNdnNyhX1i4Rv7IfNa
	oIiBDTpbCxtYgb4EC7XMJqM8i3oWmnA=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 06/12] selftests/bpf: Adjust test that does not allow refcounted node in rbtree_remove
Date: Fri, 18 Apr 2025 15:46:44 -0700
Message-ID: <20250418224652.105998-7-martin.lau@linux.dev>
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

rbtree_remove now allows refcounted node now. The
rbtree_api_remove_unadded_node test needs to be adjusted.

First change, it does not expect a verifier's error now.

Second change, the test now expects bpf_rbtree_remove(&groot, &m->node)
to return NULL. The test uses __retval(0) to ensure this NULL
return value.

Some of the "only take non-owning..." failure messages are changed also.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../testing/selftests/bpf/progs/rbtree_fail.c | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 528122320471..b2e24f018a3f 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -69,11 +69,11 @@ long rbtree_api_nolock_first(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_rbtree_remove can only take non-owning bpf_rb_node pointer")
+__retval(0)
 long rbtree_api_remove_unadded_node(void *ctx)
 {
 	struct node_data *n, *m;
-	struct bpf_rb_node *res;
+	struct bpf_rb_node *res_n, *res_m;
 
 	n = bpf_obj_new(typeof(*n));
 	if (!n)
@@ -89,18 +89,20 @@ long rbtree_api_remove_unadded_node(void *ctx)
 	bpf_rbtree_add(&groot, &n->node, less);
 
 	/* This remove should pass verifier */
-	res = bpf_rbtree_remove(&groot, &n->node);
-	n = container_of(res, struct node_data, node);
+	res_n = bpf_rbtree_remove(&groot, &n->node);
 
 	/* This remove shouldn't, m isn't in an rbtree */
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
+		return 2;
+	}
+
 	return 0;
 }
 
@@ -178,7 +180,7 @@ long rbtree_api_use_unchecked_remove_retval(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_rbtree_remove can only take non-owning bpf_rb_node pointer")
+__failure __msg("bpf_rbtree_remove can only take non-owning or refcounted bpf_rb_node pointer")
 long rbtree_api_add_release_unlock_escape(void *ctx)
 {
 	struct node_data *n;
@@ -202,7 +204,7 @@ long rbtree_api_add_release_unlock_escape(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_rbtree_remove can only take non-owning bpf_rb_node pointer")
+__failure __msg("bpf_rbtree_remove can only take non-owning or refcounted bpf_rb_node pointer")
 long rbtree_api_first_release_unlock_escape(void *ctx)
 {
 	struct bpf_rb_node *res;
-- 
2.47.1


