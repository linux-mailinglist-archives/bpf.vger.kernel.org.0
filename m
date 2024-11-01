Return-Path: <bpf+bounces-43681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E189B8776
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 01:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D71F226AD
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 00:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F331AC882;
	Fri,  1 Nov 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNXoInlf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21014AD3F
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419228; cv=none; b=qKvXxyNYG0jiThrWUkUaIUmDOARV5rsIKKJL57NFsfs74X20GpVKw5GuqChqWdVzQFfeezUX0rRzv8Tbrjk0z6BzRA5EQtGUngd4CG1rHa7qe7KTKslbUWaNZjGVEdB79q0rI6HXDMjDJt/4TJnmBO3iuspXUAF0s4IdvLt4hHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419228; c=relaxed/simple;
	bh=Yb3XyfWcLSxzT4qPz83sR747wwNpKGHeNFo9g0gG5pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJExfz6MyBAjCXcYr/H5ZJKQavWNqmCIuRD1UTXNucIRocpJWZ5XRwNh5SlZRN6pFn8PpAiNgqcKwZz+mBwOsCppGLOJokJJUsqOlGEbOe7IIDiC+bso62grBocr4Z2nS+OoTa1srY7wYv5pWCX1ElrtRxaagTVP5OIDtuC/WZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNXoInlf; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so860988f8f.3
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 17:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730419220; x=1731024020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwA6Rbje0YczcadEVBzEEh1+d/120/I70LrxPBIfMJY=;
        b=ZNXoInlfCiFFm/fbLB5r03PnxTnFv/ZDGT9XaHBdtVd7c4kkyfvw1w0/3sXFmS+ZoO
         gFqPLBO+M7C6atVzIDQ2FpMqH9xXE47iEmjVm1pH9zn2onwNLY1cCRqvolsiNXF74lHE
         nQmx5pA5TtJmhV3Lic98gU5FLC9qZ3wsKDA781LRUYE84i1xiMfFTNsRpLHveMRzmNiA
         80I0DodlEtCNYb1b4MxnedDIaKH11oV0xM+1ZN9UcuxiV95FiA7Lgp3cutMetjUHaq4H
         Kjzdj9F98kY0SbsgUlqOTFMRyoy7LaeOJMbCBnnkp1JuxSIGpASUTMzQwO9ZHEvOiMk+
         sPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419220; x=1731024020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwA6Rbje0YczcadEVBzEEh1+d/120/I70LrxPBIfMJY=;
        b=dVqB2fMyiFyHpL/6AWgnkhGlivXGn1LwlmJPL2voKluQUQ/4zW8eGJQA6bMtEtJAxU
         N1pvcllYnMtyGS6L+pFtX7u6NEucxxuOhK7dBm31PNUi9EGmkWTJ1rNjm4aq2RS/vo+R
         9FIwdtgF/ydk0zB3xjzfRYDG8NH9GcF3xhj4F2myuKYRoflpiL3CzhEQWQb4792hNYIn
         92wHI8evgP1BRQiTxfKwSIQSV8BgYeUagBRhvPvzFWZH8XzLtjpaA9lZxQNspLhtu6mj
         u2MDMpygkvyU2P4v5cTX4uGaybh3jQLbGkqxvitLYdJVscq/m3TKFFu3NcdYRVMLN8pv
         37Xw==
X-Gm-Message-State: AOJu0Yz/tU7ImwuocHLx77JARJsalxI9BeZfaylkhfCHFDQefEELEPbW
	JwF4pZIBB1TQQQO9uPHMpp/oFArAl+x/Ql/OHbU1qxDLHfKqpFe49vE/DZLY1q8=
X-Google-Smtp-Source: AGHT+IFzhLAIzHhFY7+1GpxlnTJo+lNe15jkBvo85UcsR8KEAM154tvD42zE54jvMOkZruBOUyzF9g==
X-Received: by 2002:a05:6000:e88:b0:374:c847:852 with SMTP id ffacd0b85a97d-3806115ac8fmr15852851f8f.29.1730419219758;
        Thu, 31 Oct 2024 17:00:19 -0700 (PDT)
Received: from localhost (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6983c2sm43093285e9.42.2024.10.31.17.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:00:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Juri Lelli <juri.lelli@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 1/2] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
Date: Thu, 31 Oct 2024 17:00:16 -0700
Message-ID: <20241101000017.3424165-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241101000017.3424165-1-memxor@gmail.com>
References: <20241101000017.3424165-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13630; h=from:subject; bh=Yb3XyfWcLSxzT4qPz83sR747wwNpKGHeNFo9g0gG5pA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJBnsqOyaNIhmOLpIzCLNvBBfqDVsCljBcZ/F9cgv koIc356JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyQZ7AAKCRBM4MiGSL8RytBTEA CRWvfplVVFkHRdMk7ya+G3vdzM0NqQYx9aE2l8NgQ9j+hYclUAkoIzJv2067w0wnGgFRBB/dE1czxS pEPeTqujCWv+hTMH3AJpB0jWnWFnRWv0OavwKLxQTw5IGKTKjxwYzRcuvlCrNm/yIY+140wJpsr+bP UXcmUjhL8iHrKELJpZw3FkNMw6ltUerZ9m1Sk+tCpBXac6Zf6fFwE+YjBXeJe6GDeqAEln9v9avAbc SESfWFJTsngkjAN8sN7CYl/YXbQoGz8hBQdt3ax/0EwQv2f32MixAF/BavLm7QS+ZKpxppnTSNeJoq pi4ykPSJOit3L5jWKKut5bfa/Mv0Q4ayRxSpjE9k7gvaE4AMVPhzTQgu4aIQP08EzRLt5JFFD/OEKS frHAvcKlIOF0UWWhvAY68iF3mXPZMLIHs5qewhx3Iskr8tPRyOXNaPnBIxzVN69f4M1JMUa/NbNRCD PAnXUn/NpLmm+A4Nb+709P+UVkASIQjLYW3DJzNR/HMWgaUFYtAJtTOG35xgmbIFE/eZg5iKTljYay ZgkydUbshTnP7yXr7MoBgaazBRnQbSV7ZlHBVU/AviCrlevwmqDi9TQiXKuUzpdSth8HRjIsxKclSG pcUCQAtsr7JGgaFnAO21lo/8BHj1DhAIe+UTIUl+SfN7U84iL3vnzOncuWeQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Arguments to a raw tracepoint are tagged as trusted, which carries the
semantics that the pointer will be non-NULL.  However, in certain cases,
a raw tracepoint argument may end up being NULL More context about this
issue is available in [0].

Thus, there is a discrepancy between the reality, that raw_tp arguments
can actually be NULL, and the verifier's knowledge, that they are never
NULL, causing explicit NULL checks to be deleted, and accesses to such
pointers potentially crashing the kernel.

To fix this, mark raw_tp arguments as PTR_MAYBE_NULL, and then special
case the dereference and pointer arithmetic to permit it, and allow
passing them into helpers/kfuncs; these exceptions are made for raw_tp
programs only. Ensure that we don't do this when ref_obj_id > 0, as in
that case this is an acquired object and doesn't need such adjustment.

The reason we do mask_raw_tp_trusted_reg logic is because other will
recheck in places whether the register is a trusted_reg, and then
consider our register as untrusted when detecting the presence of the
PTR_MAYBE_NULL flag.

To allow safe dereference, we enable PROBE_MEM marking when we see loads
into trusted pointers with PTR_MAYBE_NULL.

While trusted raw_tp arguments can also be passed into helpers or kfuncs
where such broken assumption may cause issues, a future patch set will
tackle their case separately, as PTR_TO_BTF_ID (without PTR_TRUSTED) can
already be passed into helpers and causes similar problems. Thus, they
are left alone for now.

It is possible that these checks also permit passing non-raw_tp args
that are trusted PTR_TO_BTF_ID with null marking. In such a case,
allowing dereference when pointer is NULL expands allowed behavior, so
won't regress existing programs, and the case of passing these into
helpers is the same as above and will be dealt with later.

Also update the failure case in tp_btf_nullable selftest to capture the
new behavior, as the verifier will no longer cause an error when
directly dereference a raw tracepoint argument marked as __nullable.

  [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb

Reported-by: Juri Lelli <juri.lelli@redhat.com>
Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  6 ++
 kernel/bpf/btf.c                              |  5 +-
 kernel/bpf/verifier.c                         | 75 +++++++++++++++++--
 .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
 4 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c3ba4d475174..1b84613b10ac 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3495,4 +3495,10 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+static inline bool bpf_prog_is_raw_tp(const struct bpf_prog *prog)
+{
+	return prog->type == BPF_PROG_TYPE_TRACING &&
+	       prog->expected_attach_type == BPF_TRACE_RAW_TP;
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ed3219da7181..e7a59e6462a9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6588,7 +6588,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (prog_args_trusted(prog))
 		info->reg_type |= PTR_TRUSTED;
 
-	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
+	/* Raw tracepoint arguments always get marked as maybe NULL */
+	if (bpf_prog_is_raw_tp(prog))
+		info->reg_type |= PTR_MAYBE_NULL;
+	else if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
 		info->reg_type |= PTR_MAYBE_NULL;
 
 	if (tgt_prog) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 797cf3ed32e0..36776624710f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -418,6 +418,21 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
 	return rec;
 }
 
+static bool mask_raw_tp_reg(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	if (reg->type != (PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL) ||
+	    !bpf_prog_is_raw_tp(env->prog) || reg->ref_obj_id)
+		return false;
+	reg->type &= ~PTR_MAYBE_NULL;
+	return true;
+}
+
+static void unmask_raw_tp_reg(struct bpf_reg_state *reg, bool result)
+{
+	if (result)
+		reg->type |= PTR_MAYBE_NULL;
+}
+
 static bool subprog_is_global(const struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_func_info_aux *aux = env->prog->aux->func_info_aux;
@@ -6622,6 +6637,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	const char *field_name = NULL;
 	enum bpf_type_flag flag = 0;
 	u32 btf_id = 0;
+	bool mask;
 	int ret;
 
 	if (!env->allow_ptr_leaks) {
@@ -6693,7 +6709,21 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 
 	if (ret < 0)
 		return ret;
-
+	/* For raw_tp progs, we allow dereference of PTR_MAYBE_NULL
+	 * trusted PTR_TO_BTF_ID, these are the ones that are possibly
+	 * arguments to the raw_tp. Since internal checks in for trusted
+	 * reg in check_ptr_to_btf_access would consider PTR_MAYBE_NULL
+	 * modifier as problematic, mask it out temporarily for the
+	 * check. Don't apply this to pointers with ref_obj_id > 0, as
+	 * those won't be raw_tp args.
+	 *
+	 * We may end up applying this relaxation to other trusted
+	 * PTR_TO_BTF_ID with maybe null flag, since we cannot
+	 * distinguish PTR_MAYBE_NULL tagged for arguments vs normal
+	 * tagging, but that should expand allowed behavior, and not
+	 * cause regression for existing behavior.
+	 */
+	mask = mask_raw_tp_reg(env, reg);
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
@@ -6754,8 +6784,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		clear_trusted_flags(&flag);
 	}
 
-	if (atype == BPF_READ && value_regno >= 0)
+	if (atype == BPF_READ && value_regno >= 0) {
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
+		/* We've assigned a new type to regno, so don't undo masking. */
+		if (regno == value_regno)
+			mask = false;
+	}
+	unmask_raw_tp_reg(reg, mask);
 
 	return 0;
 }
@@ -7140,7 +7175,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (base_type(reg->type) == PTR_TO_BTF_ID &&
-		   !type_may_be_null(reg->type)) {
+		   (bpf_prog_is_raw_tp(env->prog) || !type_may_be_null(reg->type))) {
 		err = check_ptr_to_btf_access(env, regs, regno, off, size, t,
 					      value_regno);
 	} else if (reg->type == CONST_PTR_TO_MAP) {
@@ -8833,6 +8868,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
 	int err = 0;
+	bool mask;
 
 	if (arg_type == ARG_DONTCARE)
 		return 0;
@@ -8873,11 +8909,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
+	mask = mask_raw_tp_reg(env, reg);
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
-	if (err)
-		return err;
 
-	err = check_func_arg_reg_off(env, reg, regno, arg_type);
+	err = err ?: check_func_arg_reg_off(env, reg, regno, arg_type);
+	unmask_raw_tp_reg(reg, mask);
 	if (err)
 		return err;
 
@@ -9672,14 +9708,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
 			struct bpf_call_arg_meta meta;
+			bool mask;
 			int err;
 
 			if (register_is_null(reg) && type_may_be_null(arg->arg_type))
 				continue;
 
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
+			mask = mask_raw_tp_reg(env, reg);
 			err = check_reg_type(env, regno, arg->arg_type, &arg->btf_id, &meta);
 			err = err ?: check_func_arg_reg_off(env, reg, regno, arg->arg_type);
+			unmask_raw_tp_reg(reg, mask);
 			if (err)
 				return err;
 		} else {
@@ -11981,6 +12020,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		enum bpf_arg_type arg_type = ARG_DONTCARE;
 		u32 regno = i + 1, ref_id, type_size;
 		bool is_ret_buf_sz = false;
+		bool mask = false;
 		int kf_arg_type;
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
@@ -12039,12 +12079,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
+		mask = mask_raw_tp_reg(env, reg);
 		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
 		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
 			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
+			unmask_raw_tp_reg(reg, mask);
 			return -EACCES;
 		}
+		unmask_raw_tp_reg(reg, mask);
 
 		if (reg->ref_obj_id) {
 			if (is_kfunc_release(meta) && meta->ref_obj_id) {
@@ -12102,16 +12145,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
 				break;
 
+			/* Allow passing maybe NULL raw_tp arguments to
+			 * kfuncs for compatibility. Don't apply this to
+			 * arguments with ref_obj_id > 0.
+			 */
+			mask = mask_raw_tp_reg(env, reg);
 			if (!is_trusted_reg(reg)) {
 				if (!is_kfunc_rcu(meta)) {
 					verbose(env, "R%d must be referenced or trusted\n", regno);
+					unmask_raw_tp_reg(reg, mask);
 					return -EINVAL;
 				}
 				if (!is_rcu_reg(reg)) {
 					verbose(env, "R%d must be a rcu pointer\n", regno);
+					unmask_raw_tp_reg(reg, mask);
 					return -EINVAL;
 				}
 			}
+			unmask_raw_tp_reg(reg, mask);
 			fallthrough;
 		case KF_ARG_PTR_TO_CTX:
 		case KF_ARG_PTR_TO_DYNPTR:
@@ -12134,7 +12185,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		if (is_kfunc_release(meta) && reg->ref_obj_id)
 			arg_type |= OBJ_RELEASE;
+		mask = mask_raw_tp_reg(env, reg);
 		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
+		unmask_raw_tp_reg(reg, mask);
 		if (ret < 0)
 			return ret;
 
@@ -12311,6 +12364,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 			fallthrough;
 		case KF_ARG_PTR_TO_BTF_ID:
+			mask = mask_raw_tp_reg(env, reg);
 			/* Only base_type is checked, further checks are done here */
 			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
 			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) &&
@@ -12319,9 +12373,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "expected %s or socket\n",
 					reg_type_str(env, base_type(reg->type) |
 							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
+				unmask_raw_tp_reg(reg, mask);
 				return -EINVAL;
 			}
 			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
+			unmask_raw_tp_reg(reg, mask);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13294,7 +13350,7 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
  */
 static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
-				   const struct bpf_reg_state *ptr_reg,
+				   struct bpf_reg_state *ptr_reg,
 				   const struct bpf_reg_state *off_reg)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
@@ -13308,6 +13364,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
+	bool mask;
 	int ret;
 
 	dst_reg = &regs[dst];
@@ -13334,11 +13391,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	mask = mask_raw_tp_reg(env, ptr_reg);
 	if (ptr_reg->type & PTR_MAYBE_NULL) {
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		unmask_raw_tp_reg(ptr_reg, mask);
 		return -EACCES;
 	}
+	unmask_raw_tp_reg(ptr_reg, mask);
 
 	switch (base_type(ptr_reg->type)) {
 	case PTR_TO_CTX:
@@ -19873,6 +19933,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		 * for this case.
 		 */
 		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
+		case PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL:
 			if (type == BPF_READ) {
 				if (BPF_MODE(insn->code) == BPF_MEM)
 					insn->code = BPF_LDX | BPF_PROBE_MEM |
diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
index bba3e37f749b..5aaf2b065f86 100644
--- a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
@@ -7,7 +7,11 @@
 #include "bpf_misc.h"
 
 SEC("tp_btf/bpf_testmod_test_nullable_bare")
-__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+/* This used to be a failure test, but raw_tp nullable arguments can now
+ * directly be dereferenced, whether they have nullable annotation or not,
+ * and don't need to be explicitly checked.
+ */
+__success
 int BPF_PROG(handle_tp_btf_nullable_bare1, struct bpf_testmod_test_read_ctx *nullable_ctx)
 {
 	return nullable_ctx->len;
-- 
2.43.5


