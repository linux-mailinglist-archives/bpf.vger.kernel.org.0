Return-Path: <bpf+bounces-21799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E89852292
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A292D1F23963
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68034F895;
	Mon, 12 Feb 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suI74l96"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417623A8C2
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780754; cv=none; b=S+gd9G4BDTifwt/pyUfwvv5BORNbbKDmvq354kncMeuoIvKdEcbeYr1zrz59Rb1hIiZy5+cstW2E9fU9718CAJx3Y2x6fsd0LnmRk9uKEJ1Wg0W0hNaL+VgRRoBO1YsXFIlZkezV66zJ/3lan4xV3wHJkskySZlKGzxeCT7lBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780754; c=relaxed/simple;
	bh=XH/M62z74kSPVa6XW93VnqBVlGXo/YIsCmSRdiS5Dsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGP7lqDjOPYbZ2KmAWK+Pgqqj6U1pq5NTIzxudb6Fbt2tnt3FmkL890g89juO+xzQ2oOEVjCHj4QS1562oKi1/8dURy+ArJPX0emyPha1yykS6PSqSEUhlNFQxVTvY36pN6koiHA32+0DCXcuTgb64YQZy/wPM/pmHaSleGCguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suI74l96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DD3C433C7;
	Mon, 12 Feb 2024 23:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780753;
	bh=XH/M62z74kSPVa6XW93VnqBVlGXo/YIsCmSRdiS5Dsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suI74l96m6rryUZnUMZVq9399XlFfZWaea/PetjvZ9oGA3jPervLIljxcY9qCjJ4Q
	 O8q1d+l/1b4TjZViEVKRr4akHw+oQhfrZ9xeKCc3dVNYsd9tAghl1Rk+xPb+RG/v4Q
	 gWhnEkMkz+dL6h+syiVRFvs7usgMJ7tchkyNQu2hj406/jjG/JkZ5cyJGpwSPxmtju
	 8sdrGfonybTuW3LX09CtOYxYnNJWm8tCe1c5ZQOIXFBmZIyQw4tiF8qeIOYOFO1HZk
	 1MLtPnFexzUaeXNjCwLGRWoArFdjo1KJWC9EnWz+0NXkWhfw6ffKa+QxPPeA5Hs7Fz
	 mKzp2GT4PDZ+g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/4] bpf: don't infer PTR_TO_CTX for programs with unnamed context type
Date: Mon, 12 Feb 2024 15:32:20 -0800
Message-Id: <20240212233221.2575350-4-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240212233221.2575350-1-andrii@kernel.org>
References: <20240212233221.2575350-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For program types that don't have named context type name (e.g., BPF
iterator programs or tracepoint programs), ctx_tname will be a non-NULL
empty string. For such programs it shouldn't be possible to have
PTR_TO_CTX argument for global subprogs based on type name alone.
arg:ctx tag is the only way to have PTR_TO_CTX passed into global
subprog for such program types.

Fix this loophole, which currently would assume PTR_TO_CTX whenever
user uses a pointer to anonymous struct as an argument to their global
subprogs. This happens in practice with the following (quite common, in
practice) approach:

typedef struct { /* anonymous */
    int x;
} my_type_t;

int my_subprog(my_type_t *arg) { ... }

User's intent is to have PTR_TO_MEM argument for `arg`, but verifier
will complain about expecting PTR_TO_CTX.

This fix also closes unintended s390x-specific KPROBE handling of
PTR_TO_CTX case. Selftest change is necessary to accommodate this.

Fixes: 91cc1a99740e ("bpf: Annotate context types")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c                              |  3 +++
 .../bpf/progs/test_global_func_ctx_args.c     | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index da958092c969..13bd93efeed0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5739,6 +5739,9 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		bpf_log(log, "Please fix kernel include/linux/bpf_types.h\n");
 		return false;
 	}
+	/* program types without named context types work only with arg:ctx tag */
+	if (ctx_tname[0] == '\0')
+		return false;
 	/* only compare that prog's ctx type name is the same as
 	 * kernel expects. No need to compare field by field.
 	 * It's ok for bpf prog to do:
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
index 9a06e5eb1fbe..143c8a4852bf 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
@@ -26,6 +26,23 @@ int kprobe_typedef_ctx(void *ctx)
 	return kprobe_typedef_ctx_subprog(ctx);
 }
 
+/* s390x defines:
+ *
+ * typedef user_pt_regs bpf_user_pt_regs_t;
+ * typedef struct { ... } user_pt_regs;
+ *
+ * And so "canonical" underlying struct type is anonymous.
+ * So on s390x only valid ways to have PTR_TO_CTX argument in global subprogs
+ * are:
+ *   - bpf_user_pt_regs_t *ctx (typedef);
+ *   - struct bpf_user_pt_regs_t *ctx (backwards compatible struct hack);
+ *   - void *ctx __arg_ctx (arg:ctx tag)
+ *
+ * Other architectures also allow using underlying struct types (e.g.,
+ * `struct pt_regs *ctx` for x86-64)
+ */
+#ifndef bpf_target_s390
+
 #define pt_regs_struct_t typeof(*(__PT_REGS_CAST((struct pt_regs *)NULL)))
 
 __weak int kprobe_struct_ctx_subprog(pt_regs_struct_t *ctx)
@@ -40,6 +57,8 @@ int kprobe_resolved_ctx(void *ctx)
 	return kprobe_struct_ctx_subprog(ctx);
 }
 
+#endif
+
 /* this is current hack to make this work on old kernels */
 struct bpf_user_pt_regs_t {};
 
-- 
2.39.3


