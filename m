Return-Path: <bpf+bounces-19792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B48311D5
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 04:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D031C21A62
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 03:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AFE6120;
	Thu, 18 Jan 2024 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSSeSLYq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7486FBC
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705548716; cv=none; b=oyPM6uwMGDHkRP2XWt1HQW7+W9xI44qIVgl9oRNbFvKt6FXkJrG6Woi2w8yQ7ORj0aQQY7Pn4VjZV8etq4vx6AY5oKjMy4uEQ7EUfBG+1WuqMBvaAsbduIaqAPwqGTO7jXumwt30U95cDf92WqFmlh2F++fqvprIScwqYnrCEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705548716; c=relaxed/simple;
	bh=Xzmi2CjSg8UA6eWmEFRIr/rMVqLUpIugr1M2WiWbxyI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=JQCq+Up/uigpic+DhqWFE/6D8JUXar+RB5zW84pIY3oQfkDdTPhSazQs7oMVwhnsrC0RD7b83Yy1D4/pnTYtWewgtPq7wLQ651L7Ks2U/xjjitolPMorLAIPTgMybM2/hM1iEzRK09NHr5OhEw6ZQCG/iuRKVRr+0i+J9raPvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSSeSLYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A9AC43390;
	Thu, 18 Jan 2024 03:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705548715;
	bh=Xzmi2CjSg8UA6eWmEFRIr/rMVqLUpIugr1M2WiWbxyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSSeSLYqiJMLMswe3uR1y8ssYOPVxqX8uy4p0YCDFpelqoXQD0nDZkd2jGVIZywHU
	 Xq+WdYQdPG3GnEIMaiL+tqV/8/4QjCF4H4PD7ZXwe/DQnnvFafM4RDDu66Zp8zI5dD
	 3/WktlQUPQgtqVIYT48o5T4U58bNkbO1bas5U0K2RNQTNHdq840zgbgxOeEBHGUHEJ
	 ySaJEg/7VgEMG5IsydKqCVlxtwoSQCPJ80cIfwGCkSsC5guKADZIqSXda2SM1nzWIg
	 98iRgEJAxTnDM6JXWmO5pP8p5Rn8gwkOB6LHCrs2f5aINZ+LScl9SBO3+Yvn6PGuJ2
	 L9XYFboCQaH7Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 bpf 3/5] bpf: enforce types for __arg_ctx-tagged arguments in global subprogs
Date: Wed, 17 Jan 2024 19:31:41 -0800
Message-Id: <20240118033143.3384355-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118033143.3384355-1-andrii@kernel.org>
References: <20240118033143.3384355-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enforcement of expected types for context arguments tagged with
arg:ctx (__arg_ctx) tag.

First, any program type will accept generic `void *` context type when
combined with __arg_ctx tag.

Besides accepting "canonical" struct names and `void *`, for a bunch of
program types for which program context is actually a named struct, we
allows a bunch of pragmatic exceptions to match real-world and expected
usage:

  - for both kprobes and perf_event we allow `bpf_user_pt_regs_t *` as
    canonical context argument type, where `bpf_user_pt_regs_t` is a
    *typedef*, not a struct;
  - for kprobes, we also always accept `struct pt_regs *`, as that's what
    actually is passed as a context to any kprobe program;
  - for perf_event, we resolve typedefs (unless it's `bpf_user_pt_regs_t`)
    down to actual struct type and accept `struct pt_regs *`, or
    `struct user_pt_regs *`, or `struct user_regs_struct *`, depending
    on the actual struct type kernel architecture points `bpf_user_pt_regs_t`
    typedef to; otherwise, canonical `struct bpf_perf_event_data *` is
    expected;
  - for raw_tp/raw_tp.w programs, `u64/long *` are accepted, as that's
    what's expected with BPF_PROG() usage; otherwise, canonical
    `struct bpf_raw_tracepoint_args *` is expected;
  - tp_btf supports both `struct bpf_raw_tracepoint_args *` and `u64 *`
    formats, both are coded as expections as tp_btf is actually a TRACING
    program type, which has no canonical context type;
  - iterator programs accept `struct bpf_iter__xxx *` structs, currently
    with no further iterator-type specific enforcement;
  - fentry/fexit/fmod_ret/lsm/struct_ops all accept `u64 *`;
  - classic tracepoint programs, as well as syscall and freplace
    programs allow any user-provided type.

In all other cases kernel will enforce exact match of struct name to
expected canonical type. And if user-provided type doesn't match that
expectation, verifier will emit helpful message with expected type name.

Note a bit unnatural way the check is done after processing all the
arguments. This is done to avoid conflict between bpf and bpf-next
trees. Once trees converge, a small follow up patch will place a simple
btf_validate_prog_ctx_type() check into a proper ARG_PTR_TO_CTX branch
(which bpf-next tree patch refactored already), removing duplicated
arg:ctx detection logic.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 10ac9efc662d..596471189176 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5709,6 +5709,149 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 	return ctx_type;
 }
 
+/* forward declarations for arch-specific underlying types of
+ * bpf_user_pt_regs_t; this avoids the need for arch-specific #ifdef
+ * compilation guards below for BPF_PROG_TYPE_PERF_EVENT checks, but still
+ * works correctly with __builtin_types_compatible_p() on respective
+ * architectures
+ */
+struct user_regs_struct;
+struct user_pt_regs;
+
+static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
+				      const struct btf_type *t, int arg,
+				      enum bpf_prog_type prog_type,
+				      enum bpf_attach_type attach_type)
+{
+	const struct btf_type *ctx_type;
+	const char *tname, *ctx_tname;
+
+	if (!btf_is_ptr(t)) {
+		bpf_log(log, "arg#%d type isn't a pointer\n", arg);
+		return -EINVAL;
+	}
+	t = btf_type_by_id(btf, t->type);
+
+	/* KPROBE and PERF_EVENT programs allow bpf_user_pt_regs_t typedef */
+	if (prog_type == BPF_PROG_TYPE_KPROBE || prog_type == BPF_PROG_TYPE_PERF_EVENT) {
+		while (btf_type_is_modifier(t) && !btf_type_is_typedef(t))
+			t = btf_type_by_id(btf, t->type);
+
+		if (btf_type_is_typedef(t)) {
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (tname && strcmp(tname, "bpf_user_pt_regs_t") == 0)
+				return 0;
+		}
+	}
+
+	/* all other program types don't use typedefs for context type */
+	while (btf_type_is_modifier(t))
+		t = btf_type_by_id(btf, t->type);
+
+	/* `void *ctx __arg_ctx` is always valid */
+	if (btf_type_is_void(t))
+		return 0;
+
+	tname = btf_name_by_offset(btf, t->name_off);
+	if (str_is_empty(tname)) {
+		bpf_log(log, "arg#%d type doesn't have a name\n", arg);
+		return -EINVAL;
+	}
+
+	/* special cases */
+	switch (prog_type) {
+	case BPF_PROG_TYPE_KPROBE:
+		if (__btf_type_is_struct(t) && strcmp(tname, "pt_regs") == 0)
+			return 0;
+		break;
+	case BPF_PROG_TYPE_PERF_EVENT:
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct pt_regs) &&
+		    __btf_type_is_struct(t) && strcmp(tname, "pt_regs") == 0)
+			return 0;
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_pt_regs) &&
+		    __btf_type_is_struct(t) && strcmp(tname, "user_pt_regs") == 0)
+			return 0;
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_regs_struct) &&
+		    __btf_type_is_struct(t) && strcmp(tname, "user_regs_struct") == 0)
+			return 0;
+		break;
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
+		/* allow u64* as ctx */
+		if (btf_is_int(t) && t->size == 8)
+			return 0;
+		break;
+	case BPF_PROG_TYPE_TRACING:
+		switch (attach_type) {
+		case BPF_TRACE_RAW_TP:
+			/* tp_btf program is TRACING, so need special case here */
+			if (__btf_type_is_struct(t) &&
+			    strcmp(tname, "bpf_raw_tracepoint_args") == 0)
+				return 0;
+			/* allow u64* as ctx */
+			if (btf_is_int(t) && t->size == 8)
+				return 0;
+			break;
+		case BPF_TRACE_ITER:
+			/* allow struct bpf_iter__xxx types only */
+			if (__btf_type_is_struct(t) &&
+			    strncmp(tname, "bpf_iter__", sizeof("bpf_iter__") - 1) == 0)
+				return 0;
+			break;
+		case BPF_TRACE_FENTRY:
+		case BPF_TRACE_FEXIT:
+		case BPF_MODIFY_RETURN:
+			/* allow u64* as ctx */
+			if (btf_is_int(t) && t->size == 8)
+				return 0;
+			break;
+		default:
+			break;
+		}
+		break;
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		/* allow u64* as ctx */
+		if (btf_is_int(t) && t->size == 8)
+			return 0;
+		break;
+	case BPF_PROG_TYPE_TRACEPOINT:
+	case BPF_PROG_TYPE_SYSCALL:
+	case BPF_PROG_TYPE_EXT:
+		return 0; /* anything goes */
+	default:
+		break;
+	}
+
+	ctx_type = find_canonical_prog_ctx_type(prog_type);
+	if (!ctx_type) {
+		/* should not happen */
+		bpf_log(log, "btf_vmlinux is malformed\n");
+		return -EINVAL;
+	}
+
+	/* resolve typedefs and check that underlying structs are matching as well */
+	while (btf_type_is_modifier(ctx_type))
+		ctx_type = btf_type_by_id(btf_vmlinux, ctx_type->type);
+
+	/* if program type doesn't have distinctly named struct type for
+	 * context, then __arg_ctx argument can only be `void *`, which we
+	 * already checked above
+	 */
+	if (!__btf_type_is_struct(ctx_type)) {
+		bpf_log(log, "arg#%d should be void pointer\n", arg);
+		return -EINVAL;
+	}
+
+	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_type->name_off);
+	if (!__btf_type_is_struct(t) || strcmp(ctx_tname, tname) != 0) {
+		bpf_log(log, "arg#%d should be `struct %s *`\n", arg, ctx_tname);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
 				     struct btf *btf,
 				     const struct btf_type *t,
@@ -6953,6 +7096,23 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		return -EINVAL;
 	}
 
+	for (i = 0; i < nargs; i++) {
+		const char *tag;
+
+		if (sub->args[i].arg_type != ARG_PTR_TO_CTX)
+			continue;
+
+		/* check if arg has "arg:ctx" tag */
+		t = btf_type_by_id(btf, args[i].type);
+		tag = btf_find_decl_tag_value(btf, fn_t, i, "arg:");
+		if (IS_ERR_OR_NULL(tag) || strcmp(tag, "ctx") != 0)
+			continue;
+
+		if (btf_validate_prog_ctx_type(log, btf, t, i, prog_type,
+					       prog->expected_attach_type))
+			return -EINVAL;
+	}
+
 	sub->arg_cnt = nargs;
 	sub->args_cached = true;
 
-- 
2.34.1


