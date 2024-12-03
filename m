Return-Path: <bpf+bounces-45978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6416B9E0F9A
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2161228237F
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7D6136E;
	Tue,  3 Dec 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrRlgEmt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548351370
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185364; cv=none; b=MqCKsCtNhmINuavJ7jyHE0bnBytGQqwU+PN7jdGzOSdSTn7pmreFYfsBwgAwqEF2U5tRVYzPNMyZDDv9blIZWsH23obQI9mwuUIHCluvKrlBS6SzldC0EH3qETWbCqwobCcUIgQ1KT8ENLIfGICWokEuGn7zbH9g1Qc6JSFAGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185364; c=relaxed/simple;
	bh=DB9ikxZGqd+wbFV5p7TJPIscmUmUMfHT7pUHz7fvqr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs/iKLYOsRDtS0CNneT14gVrqkGrhhO4a8Revh6h033My8yUZ079Q8awW+CvB2dl0L4UMENraslZ9bIh3ByeE44qcrwBRTPbJuLMkZMdcaWp7NStjTFijPu6+U3/GmVKaBMkfmrM19+SBgKNs9CO62fdHA0kRSujOhICWP7cmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrRlgEmt; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-385e06af753so1951562f8f.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733185360; x=1733790160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZfWvulXb2dotYF1KFOKvexGThBwVYRk8gZ1OUTry4k=;
        b=MrRlgEmtDQuhEqI3+ewV/muQUE449F+WG2xb1Vo4BHVAzLc85XsE9kGBBmlCYAxdHj
         PP5blNplVYHsuapzK4AckzG6DeY0LHLfU/OL3fZY3b6D9pxYYKwmElEVfVA6WF9gyw9r
         ZCCsNegFC5suf5LUMSGQqXBE6MhZlYrXv/jI0mzKudpyySwcKlEqNI2dDhfgVFtv5nJv
         YYcQ5u+l7CHxDhcNhmtv9BvWxAPl1f51bEMCCHLVqDkLTb3OXE5hPPAqlnKUKwFEPNmt
         2ie0BKAtuF4guoesJIxjkYWhR+qqEvJoA06XhaEY1hWS7aXuA9ZuM4gYJTA/I45mu2p/
         JsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185360; x=1733790160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZfWvulXb2dotYF1KFOKvexGThBwVYRk8gZ1OUTry4k=;
        b=pV6GCLSPK6W4iDmFzbQTnbeiDS6uznivSBVDAEYxBwZTVQLiJCDSGC3akMbxNqIZWB
         AonEed5EeLcUquqt8Gq+UNRqO9EOcolXdP4f5oGAG/rf3OkgkeAALYTVzq1aoquQ4Pv+
         Y/T5J1SnIEyX+hgxbKnybz5GmHL6KqcsiLozctSAlvUmvYiwgOUvtpbiKVIHX5RawoyD
         S43OVQqOj8BDDhhNen+ZnFVdxAaR7NrCOvuP6VD8DQQL8L74XJNCoSiSWiR8xgqd/mfJ
         lSlOGSLesbJGfaAeRdo9Guy/acOP+B+alRTzxTGZ7tvutxlfH/Jc5c6F4zUriVpzorql
         GHfw==
X-Gm-Message-State: AOJu0Yx/2p9d63xGnNod4tif5S94sUAGvF3zu34ye5xuMnPiVdZCdbQE
	HRTd94iBq/t3o0fd8PZAuUHk9JHqa8icjR+FbQ40UHHE8vdbUJpOyEMj1IWV/ds=
X-Gm-Gg: ASbGnctjLfPN+qYKV88DnbyMmKlDw1dxtFE1rRuboQ4EuaJb5cdAaheKAt0XYspAowY
	MYR4aUYOB8AM3LKpNIq72aZKEEPxemr2V6O5ZqNKURHFDPREdCPS96qaHpxZGJHFruIF7IZo2AX
	gPeD+QvDd/WEIPTgonFAkzX3nGh6kh7m/hu8uZbsnvRTfiSws6lt83vDFri0f3pK7rPMqyEG+4p
	nOEN7xwXWWiaCOWxRyy+VrQn9C0R818tvVk/DPwZc412oJb5fnjNELf+n9aKcO+vHclkYeUydw8
X-Google-Smtp-Source: AGHT+IFW7N2lMGW7vSv1RSl3zkYLVjKzNJrNyqQ6mKPk6vLxbZrjEuQdw19HWwKgOvJay2j7vHhxaQ==
X-Received: by 2002:a5d:6d8a:0:b0:385:e43a:4dd8 with SMTP id ffacd0b85a97d-385fd3c59bdmr306599f8f.4.1733185359996;
        Mon, 02 Dec 2024 16:22:39 -0800 (PST)
Received: from localhost (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ddb364e3sm11548610f8f.27.2024.12.02.16.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:22:39 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2] bpf: Zero index arg error string for dynptr and iter
Date: Mon,  2 Dec 2024 16:22:35 -0800
Message-ID: <20241203002235.3776418-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrii spotted that process_dynptr_func's rejection of incorrect
argument register type will print an error string where argument numbers
are not zero-indexed, unlike elsewhere in the verifier.  Fix this by
subtracting 1 from regno. The same scenario exists for iterator
messages. Fix selftest error strings that match on the exact argument
number while we're at it to ensure clean bisection.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v1 -> v2:
v1: https://lore.kernel.org/bpf/20241127212026.3580542-1-memxor@gmail.com
---
 kernel/bpf/verifier.c                         | 12 +++++-----
 .../testing/selftests/bpf/progs/dynptr_fail.c | 22 +++++++++----------
 .../selftests/bpf/progs/iters_state_safety.c  | 14 ++++++------
 .../selftests/bpf/progs/iters_testmod_seq.c   |  4 ++--
 .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
 .../selftests/bpf/progs/verifier_bits_iter.c  |  4 ++--
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..32c016d305af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8071,7 +8071,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
 		verbose(env,
 			"arg#%d expected pointer to stack or const struct bpf_dynptr\n",
-			regno);
+			regno - 1);
 		return -EINVAL;
 	}

@@ -8125,7 +8125,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 		if (!is_dynptr_reg_valid_init(env, reg)) {
 			verbose(env,
 				"Expected an initialized dynptr as arg #%d\n",
-				regno);
+				regno - 1);
 			return -EINVAL;
 		}

@@ -8133,7 +8133,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 		if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RDONLY)) {
 			verbose(env,
 				"Expected a dynptr of type %s as arg #%d\n",
-				dynptr_type_str(arg_to_dynptr_type(arg_type)), regno);
+				dynptr_type_str(arg_to_dynptr_type(arg_type)), regno - 1);
 			return -EINVAL;
 		}

@@ -8197,7 +8197,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 	 */
 	btf_id = btf_check_iter_arg(meta->btf, meta->func_proto, regno - 1);
 	if (btf_id < 0) {
-		verbose(env, "expected valid iter pointer as arg #%d\n", regno);
+		verbose(env, "expected valid iter pointer as arg #%d\n", regno - 1);
 		return -EINVAL;
 	}
 	t = btf_type_by_id(meta->btf, btf_id);
@@ -8207,7 +8207,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as arg #%d\n",
-				iter_type_str(meta->btf, btf_id), regno);
+				iter_type_str(meta->btf, btf_id), regno - 1);
 			return -EINVAL;
 		}

@@ -8231,7 +8231,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 			break;
 		case -EINVAL:
 			verbose(env, "expected an initialized iter_%s as arg #%d\n",
-				iter_type_str(meta->btf, btf_id), regno);
+				iter_type_str(meta->btf, btf_id), regno - 1);
 			return err;
 		case -EPROTO:
 			verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 8f36c9de7591..dfd817d0348c 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -149,7 +149,7 @@ int ringbuf_release_uninit_dynptr(void *ctx)

 /* A dynptr can't be used after it has been invalidated */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #3")
+__failure __msg("Expected an initialized dynptr as arg #2")
 int use_after_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -428,7 +428,7 @@ int invalid_helper2(void *ctx)

 /* A bpf_dynptr is invalidated if it's been written into */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #1")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int invalid_write1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -1407,7 +1407,7 @@ int invalid_slice_rdwr_rdonly(struct __sk_buff *skb)

 /* bpf_dynptr_adjust can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #1")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int dynptr_adjust_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr = {};
@@ -1420,7 +1420,7 @@ int dynptr_adjust_invalid(void *ctx)

 /* bpf_dynptr_is_null can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #1")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int dynptr_is_null_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr = {};
@@ -1433,7 +1433,7 @@ int dynptr_is_null_invalid(void *ctx)

 /* bpf_dynptr_is_rdonly can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #1")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int dynptr_is_rdonly_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr = {};
@@ -1446,7 +1446,7 @@ int dynptr_is_rdonly_invalid(void *ctx)

 /* bpf_dynptr_size can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #1")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int dynptr_size_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr = {};
@@ -1459,7 +1459,7 @@ int dynptr_size_invalid(void *ctx)

 /* Only initialized dynptrs can be cloned */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #1")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int clone_invalid1(void *ctx)
 {
 	struct bpf_dynptr ptr1 = {};
@@ -1493,7 +1493,7 @@ int clone_invalid2(struct xdp_md *xdp)

 /* Invalidating a dynptr should invalidate its clones */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #3")
+__failure __msg("Expected an initialized dynptr as arg #2")
 int clone_invalidate1(void *ctx)
 {
 	struct bpf_dynptr clone;
@@ -1514,7 +1514,7 @@ int clone_invalidate1(void *ctx)

 /* Invalidating a dynptr should invalidate its parent */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #3")
+__failure __msg("Expected an initialized dynptr as arg #2")
 int clone_invalidate2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -1535,7 +1535,7 @@ int clone_invalidate2(void *ctx)

 /* Invalidating a dynptr should invalidate its siblings */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #3")
+__failure __msg("Expected an initialized dynptr as arg #2")
 int clone_invalidate3(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -1723,7 +1723,7 @@ __noinline long global_call_bpf_dynptr(const struct bpf_dynptr *dynptr)
 }

 SEC("?raw_tp")
-__failure __msg("arg#1 expected pointer to stack or const struct bpf_dynptr")
+__failure __msg("arg#0 expected pointer to stack or const struct bpf_dynptr")
 int test_dynptr_reg_type(void *ctx)
 {
 	struct task_struct *current = NULL;
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index d47e59aba6de..f41257eadbb2 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -73,7 +73,7 @@ int create_and_forget_to_destroy_fail(void *ctx)
 }

 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #1")
+__failure __msg("expected an initialized iter_num as arg #0")
 int destroy_without_creating_fail(void *ctx)
 {
 	/* init with zeros to stop verifier complaining about uninit stack */
@@ -91,7 +91,7 @@ int destroy_without_creating_fail(void *ctx)
 }

 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #1")
+__failure __msg("expected an initialized iter_num as arg #0")
 int compromise_iter_w_direct_write_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -143,7 +143,7 @@ int compromise_iter_w_direct_write_and_skip_destroy_fail(void *ctx)
 }

 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #1")
+__failure __msg("expected an initialized iter_num as arg #0")
 int compromise_iter_w_helper_write_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -230,7 +230,7 @@ int valid_stack_reuse(void *ctx)
 }

 SEC("?raw_tp")
-__failure __msg("expected uninitialized iter_num as arg #1")
+__failure __msg("expected uninitialized iter_num as arg #0")
 int double_create_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -258,7 +258,7 @@ int double_create_fail(void *ctx)
 }

 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #1")
+__failure __msg("expected an initialized iter_num as arg #0")
 int double_destroy_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -284,7 +284,7 @@ int double_destroy_fail(void *ctx)
 }

 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #1")
+__failure __msg("expected an initialized iter_num as arg #0")
 int next_without_new_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -305,7 +305,7 @@ int next_without_new_fail(void *ctx)
 }

 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #1")
+__failure __msg("expected an initialized iter_num as arg #0")
 int next_after_destroy_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
index 4a176e6aede8..6543d5b6e0a9 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -79,7 +79,7 @@ int testmod_seq_truncated(const void *ctx)

 SEC("?raw_tp")
 __failure
-__msg("expected an initialized iter_testmod_seq as arg #2")
+__msg("expected an initialized iter_testmod_seq as arg #1")
 int testmod_seq_getter_before_bad(const void *ctx)
 {
 	struct bpf_iter_testmod_seq it;
@@ -89,7 +89,7 @@ int testmod_seq_getter_before_bad(const void *ctx)

 SEC("?raw_tp")
 __failure
-__msg("expected an initialized iter_testmod_seq as arg #2")
+__msg("expected an initialized iter_testmod_seq as arg #1")
 int testmod_seq_getter_after_bad(const void *ctx)
 {
 	struct bpf_iter_testmod_seq it;
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index e68667aec6a6..cd4d752bd089 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -45,7 +45,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
 }

 SEC("?lsm.s/bpf")
-__failure __msg("arg#1 expected pointer to stack or const struct bpf_dynptr")
+__failure __msg("arg#0 expected pointer to stack or const struct bpf_dynptr")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
 {
 	unsigned long val = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
index 7c881bca9af5..497febf5c578 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -32,7 +32,7 @@ int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp)

 SEC("iter/cgroup")
 __description("uninitialized iter in ->next()")
-__failure __msg("expected an initialized iter_bits as arg #1")
+__failure __msg("expected an initialized iter_bits as arg #0")
 int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 {
 	struct bpf_iter_bits *it = NULL;
@@ -43,7 +43,7 @@ int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)

 SEC("iter/cgroup")
 __description("uninitialized iter in ->destroy()")
-__failure __msg("expected an initialized iter_bits as arg #1")
+__failure __msg("expected an initialized iter_bits as arg #0")
 int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 {
 	struct bpf_iter_bits it = {};
--
2.43.5


