Return-Path: <bpf+bounces-20343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DED83CDDA
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98501F26277
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 20:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E51386D6;
	Thu, 25 Jan 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpO2Nekp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B060135A5E
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216116; cv=none; b=jUTvrzjxxwLM1sTqkgIEc5I4KeqOTcUuB8vbtRbFF/uguVfefsm+y3TM9Xf7fxRTo1rTlXFECXcu8yCaoo3PUQDLTRQk4V60qx+I7bT5R/7stGi5RAL4NkY+aLOJSfrSmbV5Fu1iPAU6LmaGUq0CC8rOjhu6HbAqejWCqIMbXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216116; c=relaxed/simple;
	bh=t8egRvNQMtGvvUdqsUaX5nX+5U/I1HG6pgzrbBUkcw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snxN9HFYF4Zk0FWqEvssgTRV0Qhp0XnD19f/AiVDU4QN1/toerxwEi9aDN3hqou11aYPOYOZX/2Lr+Ey057kDNClFybwQXBfIJgQgw5fV0Kzn7+igNx7eC/rdSkEcwNUg8Rrw57+ipPPaD6Ty10/iHP+FPIYlS+uDjJx6BrGauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpO2Nekp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D21C433C7;
	Thu, 25 Jan 2024 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706216115;
	bh=t8egRvNQMtGvvUdqsUaX5nX+5U/I1HG6pgzrbBUkcw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpO2Nekp8oqS2WGijC+lOvbJHsCqfJE+T1WCfFBOmWDEvJX8L8nqpCRMwa1G1OE0t
	 f4gMrZ7PQzb0ukaoLfIkCpJX9EDvCdZe8d2D1GU0cyk3wh2YQcOU4utcWUz6Ukv2PP
	 iQvgsi97mx5mDsKEorXAjeDnbdl06cPxcymT2qqxNAYl6MMAKO5mB4mzmkmWdiBzOd
	 7AFp7g5TlaXNGrchgzlRHDxuv2GEbGZG5H1GhAQfTYIGx9kKRNK7tpI1hYG8RXgqWn
	 VV5pce615knaKfu80Fu+Hqh0Qqll9gyEmxRL78eR6QYppN07JgZjQh+st9q7OImzj5
	 KrA5t4demfYNg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/7] libbpf: integrate __arg_ctx feature detector into kernel_supports()
Date: Thu, 25 Jan 2024 12:55:04 -0800
Message-Id: <20240125205510.3642094-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125205510.3642094-1-andrii@kernel.org>
References: <20240125205510.3642094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that feature detection code is in bpf-next tree, integrate __arg_ctx
kernel-side support into kernel_supports() framework.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/features.c        | 58 +++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 65 +--------------------------------
 tools/lib/bpf/libbpf_internal.h |  2 +
 3 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 5a5c766bf615..6b0738ad7063 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -407,6 +407,61 @@ static int probe_kern_btf_enum64(int token_fd)
 					     strs, sizeof(strs), token_fd));
 }
 
+static int probe_kern_arg_ctx_tag(int token_fd)
+{
+	static const char strs[] = "\0a\0b\0arg:ctx\0";
+	const __u32 types[] = {
+		/* [1] INT */
+		BTF_TYPE_INT_ENC(1 /* "a" */, BTF_INT_SIGNED, 0, 32, 4),
+		/* [2] PTR -> VOID */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 0),
+		/* [3] FUNC_PROTO `int(void *a)` */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 1), 1),
+		BTF_PARAM_ENC(1 /* "a" */, 2),
+		/* [4] FUNC 'a' -> FUNC_PROTO (main prog) */
+		BTF_TYPE_ENC(1 /* "a" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 3),
+		/* [5] FUNC_PROTO `int(void *b __arg_ctx)` */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 1), 1),
+		BTF_PARAM_ENC(3 /* "b" */, 2),
+		/* [6] FUNC 'b' -> FUNC_PROTO (subprog) */
+		BTF_TYPE_ENC(3 /* "b" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 5),
+		/* [7] DECL_TAG 'arg:ctx' -> func 'b' arg 'b' */
+		BTF_TYPE_DECL_TAG_ENC(5 /* "arg:ctx" */, 6, 0),
+	};
+	const struct bpf_insn insns[] = {
+		/* main prog */
+		BPF_CALL_REL(+1),
+		BPF_EXIT_INSN(),
+		/* global subprog */
+		BPF_EMIT_CALL(BPF_FUNC_get_func_ip), /* needs PTR_TO_CTX */
+		BPF_EXIT_INSN(),
+	};
+	const struct bpf_func_info_min func_infos[] = {
+		{ 0, 4 }, /* main prog -> FUNC 'a' */
+		{ 2, 6 }, /* subprog -> FUNC 'b' */
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	int prog_fd, btf_fd, insn_cnt = ARRAY_SIZE(insns);
+
+	btf_fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs), token_fd);
+	if (btf_fd < 0)
+		return 0;
+
+	opts.prog_btf_fd = btf_fd;
+	opts.func_info = &func_infos;
+	opts.func_info_cnt = ARRAY_SIZE(func_infos);
+	opts.func_info_rec_size = sizeof(func_infos[0]);
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, "det_arg_ctx",
+				"GPL", insns, insn_cnt, &opts);
+	close(btf_fd);
+
+	return probe_fd(prog_fd);
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -476,6 +531,9 @@ static struct kern_feature_desc {
 	[FEAT_UPROBE_MULTI_LINK] = {
 		"BPF multi-uprobe link support", probe_uprobe_multi_link,
 	},
+	[FEAT_ARG_CTX_TAG] = {
+		"kernel-side __arg_ctx tag", probe_kern_arg_ctx_tag,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fa7094ff3e66..41ab7a21f868 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6462,69 +6462,6 @@ static int clone_func_btf_info(struct btf *btf, int orig_fn_id, struct bpf_progr
 	return fn_id;
 }
 
-static int probe_kern_arg_ctx_tag(void)
-{
-	/* To minimize merge conflicts with BPF token series that refactors
-	 * feature detection code a lot, we don't integrate
-	 * probe_kern_arg_ctx_tag() into kernel_supports() feature-detection
-	 * framework yet, doing our own caching internally.
-	 * This will be cleaned up a bit later when bpf/bpf-next trees settle.
-	 */
-	static int cached_result = -1;
-	static const char strs[] = "\0a\0b\0arg:ctx\0";
-	const __u32 types[] = {
-		/* [1] INT */
-		BTF_TYPE_INT_ENC(1 /* "a" */, BTF_INT_SIGNED, 0, 32, 4),
-		/* [2] PTR -> VOID */
-		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 0),
-		/* [3] FUNC_PROTO `int(void *a)` */
-		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 1), 1),
-		BTF_PARAM_ENC(1 /* "a" */, 2),
-		/* [4] FUNC 'a' -> FUNC_PROTO (main prog) */
-		BTF_TYPE_ENC(1 /* "a" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 3),
-		/* [5] FUNC_PROTO `int(void *b __arg_ctx)` */
-		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 1), 1),
-		BTF_PARAM_ENC(3 /* "b" */, 2),
-		/* [6] FUNC 'b' -> FUNC_PROTO (subprog) */
-		BTF_TYPE_ENC(3 /* "b" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 5),
-		/* [7] DECL_TAG 'arg:ctx' -> func 'b' arg 'b' */
-		BTF_TYPE_DECL_TAG_ENC(5 /* "arg:ctx" */, 6, 0),
-	};
-	const struct bpf_insn insns[] = {
-		/* main prog */
-		BPF_CALL_REL(+1),
-		BPF_EXIT_INSN(),
-		/* global subprog */
-		BPF_EMIT_CALL(BPF_FUNC_get_func_ip), /* needs PTR_TO_CTX */
-		BPF_EXIT_INSN(),
-	};
-	const struct bpf_func_info_min func_infos[] = {
-		{ 0, 4 }, /* main prog -> FUNC 'a' */
-		{ 2, 6 }, /* subprog -> FUNC 'b' */
-	};
-	LIBBPF_OPTS(bpf_prog_load_opts, opts);
-	int prog_fd, btf_fd, insn_cnt = ARRAY_SIZE(insns);
-
-	if (cached_result >= 0)
-		return cached_result;
-
-	btf_fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs), 0);
-	if (btf_fd < 0)
-		return 0;
-
-	opts.prog_btf_fd = btf_fd;
-	opts.func_info = &func_infos;
-	opts.func_info_cnt = ARRAY_SIZE(func_infos);
-	opts.func_info_rec_size = sizeof(func_infos[0]);
-
-	prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, "det_arg_ctx",
-				"GPL", insns, insn_cnt, &opts);
-	close(btf_fd);
-
-	cached_result = probe_fd(prog_fd);
-	return cached_result;
-}
-
 /* Check if main program or global subprog's function prototype has `arg:ctx`
  * argument tags, and, if necessary, substitute correct type to match what BPF
  * verifier would expect, taking into account specific program type. This
@@ -6549,7 +6486,7 @@ static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bpf_progra
 		return 0;
 
 	/* don't do any fix ups if kernel natively supports __arg_ctx */
-	if (probe_kern_arg_ctx_tag() > 0)
+	if (kernel_supports(obj, FEAT_ARG_CTX_TAG))
 		return 0;
 
 	/* some BPF program types just don't have named context structs, so
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 930cc9616527..757dde832d8c 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -358,6 +358,8 @@ enum kern_feature_id {
 	FEAT_SYSCALL_WRAPPER,
 	/* BPF multi-uprobe link support */
 	FEAT_UPROBE_MULTI_LINK,
+	/* Kernel supports arg:ctx tag (__arg_ctx) for global subprogs natively */
+	FEAT_ARG_CTX_TAG,
 	__FEAT_CNT,
 };
 
-- 
2.34.1


