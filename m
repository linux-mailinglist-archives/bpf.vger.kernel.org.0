Return-Path: <bpf+bounces-19760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7AE830F38
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 23:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DE51C21EE4
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296771E87C;
	Wed, 17 Jan 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVv9V4WF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA41E865
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530826; cv=none; b=XlBhryRluyjAhPpew19PZ+fUccKQjoSqK43mQQAAQ4ZkuNr4PcN5oXDK6FQDnA23WnTpHYZP5Jnwrw/AVhUq8nPMlXDImF5nGqqg1DPMkqyQShkkeoBkfCDL8XccBmJYf88Bmd1YeatVRpti0gZHghsOR/a99CfFLjomglqBwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530826; c=relaxed/simple;
	bh=BMz6Xlfjn8W0mPyVx/S5zH7KppTk0vFZ+ineoLzH2Ls=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=IrU7sYa/r6CzVLiEDfXMeG63oXuXVyAPeWtdobId/xe15DMkNIeiiSGJi3V7vWpryaVLVCWELRJfrVSbFQhnLHvJ1tUvlYyZDNvl4guaGyy/Fe30yAm2tV1LbE2YJKMzHoxRhFy20kAi/WoxeS0bDG8/cEBjyga3qXGg/ErwMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVv9V4WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08C0C43390;
	Wed, 17 Jan 2024 22:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705530826;
	bh=BMz6Xlfjn8W0mPyVx/S5zH7KppTk0vFZ+ineoLzH2Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVv9V4WFVSRy7dK2HLa36m2Vo4QzdvBzzA5htl5r+pU2ISLBuG21qtBOGsZUhIfA2
	 4+7ZWPfclBp4AKSq2S2pNtLNELXBQEmcSa76UDub6iFbyYOuB5k8ww52orMP0R6YgV
	 jHHyv2RM6xUFzi136/M7RWFmFC6B+YhrmEqbdWISj6cyGgOV11DzEEO/0PrJIODCJx
	 9QMXiVzW0wOwXRi2WNYRckQTU9IDX/KDLlSYLgVfpLBaACafebpsvG9dTTxXTOe7p5
	 ssWjus4Ieq6NvpnKOVpxI+jqCVTYfMW3E9dOawDwTw1n2iWUr0tpnpGSm3vkcf0MHz
	 YhVN+w0ot3LFg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 1/5] libbpf: feature-detect arg:ctx tag support in kernel
Date: Wed, 17 Jan 2024 14:33:36 -0800
Message-Id: <20240117223340.1733595-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117223340.1733595-1-andrii@kernel.org>
References: <20240117223340.1733595-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add feature detector of kernel-side arg:ctx (__arg_ctx) tag support. If
this is detected, libbpf will avoid doing any __arg_ctx-related BTF
rewriting and checks in favor of letting kernel handle this completely.

test_global_funcs/ctx_arg_rewrite subtest is adjusted to do the same
feature detection (albeit in much simpler, though round-about and
inefficient, way), and skip the tests. This is done to still be able to
execute this test on older kernels (like in libbpf CI).

Note, BPF token series ([0]) does a major refactor and code moving of
libbpf-internal feature detection "framework", so to avoid unnecessary
conflicts we keep newly added feature detection stand-alone with ad-hoc
result caching. Once things settle, there will be a small follow up to
re-integrate everything back and move code into its final place in
newly-added (by BPF token series) features.c file.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=814209&state=*

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c                        | 67 +++++++++++++++++++
 .../bpf/prog_tests/test_global_funcs.c        | 13 ++++
 2 files changed, 80 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c5a42ac309fd..61db92189517 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6757,6 +6757,69 @@ static int clone_func_btf_info(struct btf *btf, int orig_fn_id, struct bpf_progr
 	return fn_id;
 }
 
+static int probe_kern_arg_ctx_tag(void)
+{
+	/* To minimize merge conflicts with BPF token series that refactors
+	 * feature detection code a lot, we don't integrate
+	 * probe_kern_arg_ctx_tag() into kernel_supports() feature-detection
+	 * framework yet, doing our own caching internally.
+	 * This will be cleaned up a bit later when bpf/bpf-next trees settle.
+	 */
+	static int cached_result = -1;
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
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	int prog_fd, btf_fd, insn_cnt = ARRAY_SIZE(insns);
+
+	if (cached_result >= 0)
+		return cached_result;
+
+	btf_fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs));
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
+	cached_result = probe_fd(prog_fd);
+	return cached_result;
+}
+
 /* Check if main program or global subprog's function prototype has `arg:ctx`
  * argument tags, and, if necessary, substitute correct type to match what BPF
  * verifier would expect, taking into account specific program type. This
@@ -6780,6 +6843,10 @@ static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bpf_progra
 	if (!obj->btf_ext || !prog->func_info)
 		return 0;
 
+	/* don't do any fix ups if kernel natively supports __arg_ctx */
+	if (probe_kern_arg_ctx_tag() > 0)
+		return 0;
+
 	/* some BPF program types just don't have named context structs, so
 	 * this fallback mechanism doesn't work for them
 	 */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 67d4ef9e62b3..e905cbaf6b3d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -47,6 +47,19 @@ static void subtest_ctx_arg_rewrite(void)
 	struct btf *btf = NULL;
 	__u32 info_len = sizeof(info);
 	int err, fd, i;
+	struct btf *kern_btf = NULL;
+
+	kern_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(kern_btf, "kern_btf_load"))
+		return;
+
+	/* simple detection of kernel native arg:ctx tag support */
+	if (btf__find_by_name_kind(kern_btf, "bpf_subprog_arg_info", BTF_KIND_STRUCT) > 0) {
+		test__skip();
+		btf__free(kern_btf);
+		return;
+	}
+	btf__free(kern_btf);
 
 	skel = test_global_func_ctx_args__open();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
-- 
2.34.1


