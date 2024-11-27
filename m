Return-Path: <bpf+bounces-45772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C4B9DAFA3
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 00:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9CB2235D
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AA7204093;
	Wed, 27 Nov 2024 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je0GFxlY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DD0149C41
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748516; cv=none; b=sFn5/7Tw+iAYhceeE0WnsEXfjhFtCwwO4UVDCXeTiNOLa31dOmWA6HWr6beXZErGVXYU2srcw94NKTQlhFjIQqobWVKgg4XdLiqwFdarjGYcMV0zOt3ubVbmeTMWEKFSVjzzQsHSkuHMVmSWVJtH7QWlXV6W1NYrUyqho03nS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748516; c=relaxed/simple;
	bh=V/qQEMPJOllmTueSgpQfOClvWtgZYmDIbkPXQStDW7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmljhZGLV8jio4YT4cX2KHx01gKAo8946cKv6O97hB7+l5/xIHRfWggcrRXYn6K9Ihjn4ZxV/p93dWscJO4FylgAA+c0TD5FIu1if7J3V382fVtdVzD/q3rUqpatx1XPH3N6AQtBJX0A1lIUudf+FZheOTLlEng7Ec+b7XEfS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je0GFxlY; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a10588f3so1028345e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732748512; x=1733353312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvWuP91qSOe/FPKlNZODqp3JthUakYT/Hb6MLTu+Txs=;
        b=je0GFxlYnIDijIX1UbKgCH79Xrpba1DEKBWCLIokNyHCTEokNOrAxahjDTeRZo5sVy
         ZmgQ/BjdIKXstuLq/TEpNYAI+OSfmYR0qhSxA1w8gK1EWZlx2/4sjdcNJG/MzJDwGnG1
         DNngIKyIuNeWKStRr5QuhIG8xR1kARcN7O9SiKu06ck7ACoDe2FjCP1fAp1UZnARdc6B
         TT6o8Y/BfShh+1uNtyjb7wRFG4HFInCW8Rfn5tiROcL1HI1eN3r9jPvo9rrCG6jt+pT3
         Oe8shoJ5q+ul7+0+LO03S74IVHZt8zaN5W7bSsmMHcGTlv/yqI+aPZTTm5TRDaTwKexY
         hYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732748512; x=1733353312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvWuP91qSOe/FPKlNZODqp3JthUakYT/Hb6MLTu+Txs=;
        b=QRo/qWxULN2nhE1xQeAXS7MQ8CK36R7/KzfAULWw0Teq9/aPu9KCnRVyGnDlY6IpQH
         0yuHLB77tk07QfXHov9WWbsNSzgtyp+ThUy4xnjPvJvOGrS+uzim3Hyp2DRkoaetuxrY
         f/wDfxt0JhXJVfF8z+xYz8vxul57PmWHxLmDw5amV5s/AEee/fZ4IwdmrjddNqo88zz+
         F1uam890KYN8wXzT6WTvaGvbY2nQYJzMS4ZvR/iH9zJ9YmMSHVrB6uc1JnUtpDLsuH22
         bwF+FP6zLDdWyZvb0dwHmg8u6g7Bpo++1RYlyfqYDu+lH4FKwFlAEABlk11AjbPkR/WJ
         4IWw==
X-Gm-Message-State: AOJu0YyRb6lhmEEQ8+aRn/8dp+9tcOfQr3vpI9JsXQ7IH5waMT11J67Q
	ic1icvrQkUWDjFQolYGNY3yr/Zti4oiZdNom2diiAHU8Vgv56Sq6b5LpZVzi9+Y=
X-Gm-Gg: ASbGncuXyYu1bo1DQGDmOGxtSUz+aXVC749FKfrQI05n710oTFmTDuGgq01nrg2EsNV
	8G5nG9bBiIT7Rl0H0JyOzxvdJI4zXWfZAqcLjGIzYAG99HiFVVkPc1KJCi42cPy4R5LIEgmA0i1
	/2kr8GYSpef5BJv70YpM2fecfUJXne/I5WvEE/7azO5a0bJbKHhWWzzWCDMb5Xuxa7OKQd4IGcL
	jfvjgosKfLZ0O68gTjIX9JGIBwRO9OXQU2g3N4lyPfuESkKmsHQRoqR8mvPlBBLy6Ds9rwrmE/d
	Tg==
X-Google-Smtp-Source: AGHT+IGk98grNxMoB+JoHU/VOb2ubnp5Sfd0zARU0LsKjLk9dFlWAp3lq2013wahaT4SUFFDEvhGIg==
X-Received: by 2002:a05:600c:3aca:b0:431:5632:4497 with SMTP id 5b1f17b1804b1-434a9df27c2mr40863865e9.26.1732748511823;
        Wed, 27 Nov 2024 15:01:51 -0800 (PST)
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a5d56da3sm44138295e9.0.2024.11.27.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:01:50 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v1 2/3] bpf: Zero index arg error string for dynptr and iter
Date: Wed, 27 Nov 2024 15:01:46 -0800
Message-ID: <20241127230147.4158201-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127230147.4158201-1-memxor@gmail.com>
References: <20241127230147.4158201-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12478; h=from:subject; bh=V/qQEMPJOllmTueSgpQfOClvWtgZYmDIbkPXQStDW7s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR6TVuaB3gxnKgkOKXZjArN42rlbHdGPgQm8KcmhT i1X60nGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0ek1QAKCRBM4MiGSL8RytfwEA C20VsV1HFeK3L599Xn4n+OWVZZ5MBAYwt5tZPpQMERtwg+O5Rz0SHhrk467mV+HgTNi237MY0PqVKL z+VexQLhfdxkgNAeenv5Khj7pORtGnRSoQ0z6u+XXlbRNV1PHAggn/HsA3Wmvuwl5BULmf0sMSv//R r1icPNMCLw+F35b3WHto5Y3bzduyoENIejC02Iyrn7MmVeLUxq2jW7evo3WFW+4VpG2gpR1kdgrB5V y3IWC2wNPFOAKCAhoXl7EFowoXb2BoMGoxbeFYSeqXgkyphBjlx+F2/8YocrbsMJYv2/8qf6+83GaV CXkeVZ4KcQGQkFGyuBaafPLTbriWW0Hy4hgzO5EYGAI13pCgiLIc7ZwQijRTt9L05pu6+oPchvxct6 tzywYzhCUSnBESFDN4PsAVQpMcxYGp7315OFVPdnDis2vIzABO8cY9bfDuPmBWP/MCFv9sBbno9PhH 9CPHM0+KM44vEdzH3q57fCEzZe2m5Q1Ktudco1NZrlop6jnYhLLaxiAsRi1/G7zpUZHfLZAlLG3xor p5BX4Dkoe7IwmdyTOYTsIgngghuZJEyNDfF3iw0QZC5rwoqoV9YPA71ECRkPIKmxDCRBhN6UQKbu0b wI6w29e+3D3Y0yKn7JRaW1ESbv27egM9NW07brnEUHJWXzHOOVbkMKsM2Mnw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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
 kernel/bpf/verifier.c                         | 12 +++++-----
 .../testing/selftests/bpf/progs/dynptr_fail.c | 22 +++++++++----------
 .../selftests/bpf/progs/iters_state_safety.c  | 14 ++++++------
 .../selftests/bpf/progs/iters_testmod_seq.c   |  4 ++--
 .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
 .../selftests/bpf/progs/verifier_bits_iter.c  |  4 ++--
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 358a3566bb60..2fd35465d650 100644
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
 
@@ -8202,7 +8202,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 	 */
 	btf_id = btf_check_iter_arg(meta->btf, meta->func_proto, regno - 1);
 	if (btf_id < 0) {
-		verbose(env, "expected valid iter pointer as arg #%d\n", regno);
+		verbose(env, "expected valid iter pointer as arg #%d\n", regno - 1);
 		return -EINVAL;
 	}
 	t = btf_type_by_id(meta->btf, btf_id);
@@ -8212,7 +8212,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as arg #%d\n",
-				iter_type_str(meta->btf, btf_id), regno);
+				iter_type_str(meta->btf, btf_id), regno - 1);
 			return -EINVAL;
 		}
 
@@ -8236,7 +8236,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
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
index a7a6ae6c162f..8bcddadfc4da 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -32,7 +32,7 @@ int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 
 SEC("iter/cgroup")
 __description("uninitialized iter in ->next()")
-__failure __msg("expected an initialized iter_bits as arg #1")
+__failure __msg("expected an initialized iter_bits as arg #0")
 int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 {
 	struct bpf_iter_bits it = {};
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


