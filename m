Return-Path: <bpf+bounces-57470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE5AAB8FE
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664AC4C17B9
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7561928AAF9;
	Tue,  6 May 2025 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t/8oDd8E"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D082F926B
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496753; cv=none; b=rq2Db0I0+QZB6m+3WXokJ3GNh5pDvLIoqjQIYIXYxrpQdiD36rR4qWH9LTyu0u5YmsW1r1QivX4+AFck9U0CvdDVvGO0mxxyTPNBZAcgG/BYb3hBEf5k713UPTFovDS8RaBQRSWrGfLwCNDV2P+5o95sjvFlAjxOvJcFYaps6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496753; c=relaxed/simple;
	bh=YyfjL3+mVN3q6l2N201SONYSLaVPKTppqC50P9XgYrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiMCUwcQd4ZBEzGiSN6ThL0ul6o+OogKgtdc+8mTMD1hjRGsDJu3kGXkSDLLSWGksMnZfPSYFA8edI5bk1zVCSDusmJ4IF7M6dFWL0gIMlBjg4enaJ5X8mftS7vIwlPEMF4rc0o5rWKbbequEccX/Ib1o8nAWwI2jQrOMG2vM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t/8oDd8E; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746496748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DH6XXlfh/sI1Jt7lwMxbSNqnjshmd58+9UpGZWxMHmY=;
	b=t/8oDd8Ep3iwf7OHjoUWGVPSpg1gItv7czmV1/jI3ezgcUwdLdBQNaF1PzK7nRIhB34KyC
	zyfT/Tg1BO17bIpdJJwjS4hHV9XYSWzWQkOsEy40rwbdPpHTE13Sa2ifxLhZPPNrG9kZ2V
	o0TTHrRDQGDcDZRjPYmso2YytiYn7Xs=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Kumar Kartikeya Dwivedi ' <memxor@gmail.com>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/8] bpf: Check KF_bpf_rbtree_add_impl for the "case KF_ARG_PTR_TO_RB_NODE"
Date: Mon,  5 May 2025 18:58:48 -0700
Message-ID: <20250506015857.817950-2-martin.lau@linux.dev>
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

In a later patch, two new kfuncs will take the bpf_rb_node pointer arg.

struct bpf_rb_node *bpf_rbtree_left(struct bpf_rb_root *root,
				    struct bpf_rb_node *node);
struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root,
				     struct bpf_rb_node *node);

In the check_kfunc_call, there is a "case KF_ARG_PTR_TO_RB_NODE"
to check if the reg->type should be an allocated pointer or should be
a non_owning_ref.

The later patch will need to ensure that the bpf_rb_node pointer passing
to the new bpf_rbtree_{left,right} must be a non_owning_ref. This
should be the same requirement as the existing bpf_rbtree_remove.

This patch swaps the current "if else" statement. Instead of checking
the bpf_rbtree_remove, it checks the bpf_rbtree_add. Then the new
bpf_rbtree_{left,right} will fall into the "else" case to make
the later patch simpler. bpf_rbtree_add should be the only
one that needs an allocated pointer.

This should be a no-op change considering there are only two kfunc(s)
taking bpf_rb_node pointer arg, rbtree_add and rbtree_remove.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..2e1ce7debc16 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13200,22 +13200,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_RB_NODE:
-			if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_remove]) {
-				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
-					verbose(env, "rbtree_remove node input must be non-owning ref\n");
+			if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+					verbose(env, "arg#%d expected pointer to allocated object\n", i);
 					return -EINVAL;
 				}
-				if (in_rbtree_lock_required_cb(env)) {
-					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
+				if (!reg->ref_obj_id) {
+					verbose(env, "allocated object must be referenced\n");
 					return -EINVAL;
 				}
 			} else {
-				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
-					verbose(env, "arg#%d expected pointer to allocated object\n", i);
+				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
+					verbose(env, "rbtree_remove node input must be non-owning ref\n");
 					return -EINVAL;
 				}
-				if (!reg->ref_obj_id) {
-					verbose(env, "allocated object must be referenced\n");
+				if (in_rbtree_lock_required_cb(env)) {
+					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
 					return -EINVAL;
 				}
 			}
-- 
2.47.1


