Return-Path: <bpf+bounces-19086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C3824C0B
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E52877C8
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58487626;
	Fri,  5 Jan 2024 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4vmdJNz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB555373
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444EDC433C8;
	Fri,  5 Jan 2024 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413361;
	bh=w0oVyUN/TDhRIPiUcWir17QHZrWVndHP47wjQtrAnsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4vmdJNzNfF15k/cESrQJ/7kpq8WLtgYbUzQ0puYj5DTfXa4iMSymLY0ChEr+ki1I
	 xd5HQ6i+Wx8m0gFl5YO9gga65LyW/AfLQ+KpyQrwsvQ3WIIYVtwWsAs0D3FgUm1K0h
	 lv5VF2cVIqZc4w+0R/6oWbmSUowMa/ijWPpbm3UZe+DuKqoBjqTLn/FKh61RM+cMxS
	 yybSNlHBqk+ycCFuIZrfIvAqygGQXmrN30Cz06/e/sg/zlyX10tzMC0LUdKwCzVMbo
	 hauG5bTF/ZS7PbXNQDktHrYwtXfze1vFNbYmcHduGT164Y042ySX3zasXq1vrvGjp4
	 m+mM5lsjoPMNA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next 3/8] bpf: prepare btf_prepare_func_args() for multiple tags per argument
Date: Thu,  4 Jan 2024 16:09:04 -0800
Message-Id: <20240105000909.2818934-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
References: <20240105000909.2818934-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add btf_arg_tag flags enum to be able to record multiple tags per
argument. Also streamline pointer argument processing some more.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c      | 53 ++++++++++++++++++++++++++++++-------------
 kernel/bpf/verifier.c |  1 -
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 47163cb28b83..ccaf57e755fc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6784,6 +6784,11 @@ static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
 	return false;
 }
 
+enum btf_arg_tag {
+	ARG_TAG_CTX = 0x1,
+	ARG_TAG_NONNULL = 0x2,
+};
+
 /* Process BTF of a function to produce high-level expectation of function
  * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This information
  * is cached in subprog info for reuse.
@@ -6865,10 +6870,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	 * Only PTR_TO_CTX and SCALAR are supported atm.
 	 */
 	for (i = 0; i < nargs; i++) {
-		bool is_nonnull = false;
 		const char *tag;
-
-		t = btf_type_by_id(btf, args[i].type);
+		u32 tags = 0;
 
 		tag = btf_find_decl_tag_value(btf, fn_t, i, "arg:");
 		if (IS_ERR(tag) && PTR_ERR(tag) == -ENOENT) {
@@ -6886,43 +6889,61 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				bpf_log(log, "arg#%d type tag is not supported in static functions\n", i);
 				return -EOPNOTSUPP;
 			}
+
 			if (strcmp(tag, "ctx") == 0) {
-				sub->args[i].arg_type = ARG_PTR_TO_CTX;
-				continue;
+				tags |= ARG_TAG_CTX;
+			} else if (strcmp(tag, "nonnull") == 0) {
+				tags |= ARG_TAG_NONNULL;
+			} else {
+				bpf_log(log, "arg#%d has unsupported set of tags\n", i);
+				return -EOPNOTSUPP;
 			}
-			if (strcmp(tag, "nonnull") == 0)
-				is_nonnull = true;
 		}
 
+		t = btf_type_by_id(btf, args[i].type);
 		while (btf_type_is_modifier(t))
 			t = btf_type_by_id(btf, t->type);
-		if (btf_type_is_ptr(t) && btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+		if (!btf_type_is_ptr(t))
+			goto skip_pointer;
+
+		if ((tags & ARG_TAG_CTX) || btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+			if (tags & ~ARG_TAG_CTX) {
+				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
+				return -EINVAL;
+			}
 			sub->args[i].arg_type = ARG_PTR_TO_CTX;
 			continue;
 		}
-		if (btf_type_is_ptr(t) && btf_is_dynptr_ptr(btf, t)) {
+		if (btf_is_dynptr_ptr(btf, t)) {
+			if (tags) {
+				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
+				return -EINVAL;
+			}
 			sub->args[i].arg_type = ARG_PTR_TO_DYNPTR | MEM_RDONLY;
 			continue;
 		}
-		if (is_global && btf_type_is_ptr(t)) {
+		if (is_global) { /* generic user data pointer */
 			u32 mem_size;
 
 			t = btf_type_skip_modifiers(btf, t->type, NULL);
 			ref_t = btf_resolve_size(btf, t, &mem_size);
 			if (IS_ERR(ref_t)) {
-				bpf_log(log,
-				    "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
-				    i, btf_type_str(t), btf_name_by_offset(btf, t->name_off),
+				bpf_log(log, "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
+					i, btf_type_str(t), btf_name_by_offset(btf, t->name_off),
 					PTR_ERR(ref_t));
 				return -EINVAL;
 			}
 
-			sub->args[i].arg_type = is_nonnull ? ARG_PTR_TO_MEM : ARG_PTR_TO_MEM_OR_NULL;
+			sub->args[i].arg_type = ARG_PTR_TO_MEM | PTR_MAYBE_NULL;
+			if (tags & ARG_TAG_NONNULL)
+				sub->args[i].arg_type &= ~PTR_MAYBE_NULL;
 			sub->args[i].mem_size = mem_size;
 			continue;
 		}
-		if (is_nonnull) {
-			bpf_log(log, "arg#%d marked as non-null, but is not a pointer type\n", i);
+
+skip_pointer:
+		if (tags) {
+			bpf_log(log, "arg#%d has pointer tag, but is not a pointer type\n", i);
 			return -EINVAL;
 		}
 		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5f4ff1eb235..271c82bf9697 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20037,7 +20037,6 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->first_insn_idx = env->subprog_info[subprog].start;
 	state->last_insn_idx = -1;
 
-
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
 		const char *sub_name = subprog_name(env, subprog);
-- 
2.34.1


