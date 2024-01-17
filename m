Return-Path: <bpf+bounces-19746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2310A830D7B
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 20:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA461F268EE
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3731124A0D;
	Wed, 17 Jan 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaFgZnWc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403524A05
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521143; cv=none; b=h/5xI7bjBVhoPVdb3Kec/mXQS/u2wpddWpARvFgf5Qo3dRgkgr2Hn7yOAOpSFpZ2micfbccuSOR6QYQCkLth6clJkVekxtmUYMGmFPGrgTxBAPPL5z+RovBUTu5NjPQvSQnXaIvdrhqFsadmunygTll3RCB2REUxRWYpljK68T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521143; c=relaxed/simple;
	bh=9IizER3OGylwJpaSp5Kp/riQ9+2RwHHPBmyluw0pLR4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=k950LYqe9p8nCFJnWb0veo6CGFNlWWWttAxz0hBeWk1bZfXUwry3Jkdro11RWe+LUO8tE2vxzk3PN8hsMJoPdzp8JfhbsmVGJg/pTHNzhz/uxqbs6YZ9Ma7DYvG4ZQEW0Kz0ito5Nwug9HTwydrcPSweOMJtsf+ANxXXpIobHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaFgZnWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05748C433C7;
	Wed, 17 Jan 2024 19:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521143;
	bh=9IizER3OGylwJpaSp5Kp/riQ9+2RwHHPBmyluw0pLR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaFgZnWcRdMn9mJMfJcU0VTk1CfCZ58DbFErtQZwNTgUA/AsVeBHWsi7BhGykLwMX
	 pD02+xfNRB3f8P+Pz24aaOauQNPBvt9D1D5l/zaU7cMQkitezFEL9AS24oBhYQTIos
	 t5UhxxTubesPHJLSbXtK3bsUU27aFSWyMyOSIkXxLKureWsz4WNF/K5extB+gG3s3V
	 R/6Jg1WSdlhb0YeiUj54vhGbsLZ7hBxUzgM8i2SloXd6iQQ6llzBt7GAheMZvoWjEG
	 Uk4mjf/OZeTazubnO3JAM0P9puiw0jyxMswIQAETpY2GJoanM7pUu2KdIy224Rh/Y5
	 RBAGcc4PdOZVw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 3/5] bpf: enforce types for __arg_ctx-tagged arguments in global subprogs
Date: Wed, 17 Jan 2024 11:52:08 -0800
Message-Id: <20240117195210.739597-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117195210.739597-1-andrii@kernel.org>
References: <20240117195210.739597-1-andrii@kernel.org>
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

  - for kprobes, we always accept `struct pt_regs *`, as that's what
    actually is passed as a context to any kprobe program;
  - for perf_event, we resolve typedefs down to actual struct type and
    accept `struct pt_regs *` if kernel's architecture actually defines
    `bpf_user_pt_regs_t` as an alias for `struct pt_regs`; otherwise,
    canonical `struct bpf_perf_event_data *` is expected and supported;
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
 kernel/bpf/btf.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 10ac9efc662d..e64e38df08e6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5709,6 +5709,118 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 	return ctx_type;
 }
 
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
@@ -6953,6 +7065,23 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
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


