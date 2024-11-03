Return-Path: <bpf+bounces-43854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D369BA96F
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 23:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95A9280FD9
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 22:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608818C93B;
	Sun,  3 Nov 2024 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRpeK69X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19718C341
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674789; cv=none; b=iogE+Jzi2sDqSqZ5aVFrR7+Rp1qmwtTWbskTpSKqLMv0VY+XtSemoUNq//Tibg+YFjZGbJJ1rY9q/eXYj8ZYPzkw7fpOwH0m7GOCwxSSeRVUTR6M6czv1taHf+1WcafDrTJ/B8bpI6/fTfneQxsyjtkoLMzgpYfxKNfPKYUanLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674789; c=relaxed/simple;
	bh=T8lHgUfABeZYik4WO7wihDPAjeVYcvUSwtnaBuwuvkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qrbr9W2o67HVdp2qH99WfTqJLco2uLV8EYgjyMqv4Zd9ReePzcBdOIx9WJKnntVdOWmOR158nd/UtjqHjKk84Q5vZ8RG9yQUHj5JfRxBO7960qLQcMgfVeIp0ZJyATKCtEZZOqiz+7kfwEZRM3mhg5ZptMCupL8B1SLqnM+ONm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRpeK69X; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so28063315e9.3
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 14:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730674785; x=1731279585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqcyiXpwMGVMBRAu6cGRQnZavo2Ny6Ei77oKORDGJWQ=;
        b=GRpeK69Xd05Rcbm0xMeQ22o3hRs5FTsvgXkxEAGnFuK0EtZA22HaB+UJB2dIhvUIOW
         1CDytPBBr/S6Ag57CLh2Uz3AHe4SCLWCZSHxAgVey2yI4pz+bN/M8l+5PjAEX4hSiA0p
         Ky+htxZ+ipRV45on3WkZ/w691Xf9cz4R0ve3oz3oT8ewXx2aOr1oOTNthLD24V97a98c
         2FaHZLgGRbm+rUXR0U/WDJxgKk86OPSbZl8nC1cCC4KWsuW0i1xOVfyDSE9SX7BjWy8k
         kZw1XunFkRTh/VOdT4LiX91/P1zErk1yvZNbDf5i5ZJ37Rl3mmjZs9OgxTzYxht1eeQj
         epvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730674785; x=1731279585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqcyiXpwMGVMBRAu6cGRQnZavo2Ny6Ei77oKORDGJWQ=;
        b=CNW8T0vxBOFpFPzqTrPlP6mjjSqa724LAAYfm00vNQXZ8pX8enkcqAzsFI/jrFRxei
         viU02ToBvbhefXSezbXg2HDWTHXhqzVtaU2GG4nYw+hD/7YAHYMVax71twhsDTxOVMOw
         swOCPAJldgUewNKaVvMtQeukdtkVwISD/LPIqpQFL0gqR07cGDwycCsFGjkRrzUvR0af
         jr1NZDW1xrOqJFPEelgyv0kAkhA+4tfUbTUIFoAl6duRXApeBQ0PaejAJFw3mBgmUYGF
         V62scEiwbz0gn6iPFXRLMXZlPEUTeJ8r78b87Joky8JF3g9sL+8x/hciFBMkAAemP96/
         86LA==
X-Gm-Message-State: AOJu0Yw8fvCNXi8SY6cMSYkzt3OhYaRdILrdW9xxQiTipp7KjJrqFvZb
	6yaEvu5a9ayYAuWpoJjP/bednjfE0NG8ljmkMOtOeyEbzWaKVavrJrmMRx+P/LMQpw==
X-Google-Smtp-Source: AGHT+IFsCUeKouQPRplnmvkX5GxamZi3MEwKUIPy/noGYFpqa4Hn/kfwA5nQaJBWU5bDaxu7OeD0iA==
X-Received: by 2002:adf:e705:0:b0:37c:ddab:a626 with SMTP id ffacd0b85a97d-381b70572bfmr12322448f8f.7.1730674784870;
        Sun, 03 Nov 2024 14:59:44 -0800 (PST)
Received: from localhost (fwdproxy-cln-024.fbsv.net. [2a03:2880:31ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947c26sm167536645e9.26.2024.11.03.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 14:59:44 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 2/3] bpf: Unify resource leak checks
Date: Sun,  3 Nov 2024 14:59:39 -0800
Message-ID: <20241103225940.1408302-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241103225940.1408302-1-memxor@gmail.com>
References: <20241103225940.1408302-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10344; h=from:subject; bh=T8lHgUfABeZYik4WO7wihDPAjeVYcvUSwtnaBuwuvkY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ//puIe+O95Dz5NKYSU+hhGCSY6GsyxRxp7J4ylz 92B07MyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyf/6QAKCRBM4MiGSL8RyoS7D/ 9OTnLKLDeeBvC9RwjPDCVOHSi3DRqnutK0NCmJgG5xUaiQQwtlo1LH/B0ewoFYZlJ159J+OtC3nNgk nCra49gmZUj2aE5pr2gkr3bpGWsIP5JJrIDmlOFgYNoovKbcaxz5S7CO/145h4I1NEkJK0iYiAdqFG yLqLaUUn4MnZY9wt6cdM0v+82eADTNtC/E3n3neJVKAd6qw59tEnKYjesIXIBvK9Hqmw4BHTNZaCZH t5W9jTg/9ABrrA2grB0Web4etvgz2TmgDnfnCdEKgeVw8GXf3xAFAC5pfuwnHBQB69oYVb/0CPNGsO sPSfIig3ByRoNVz+6T0NOA9npznaDtC5m+sT9KBIJ+JzTEsTDuEUE8qVQX9JIQHjiZ8Ay5DCglpp2E tvFTRRyBMgkyUC3Gpt8pdDiH+aWUQxuLfPZ0X9R5+HUSUe4ZIOa/84jl/vLBQo9lu0on8ffWhrOer3 AYBfcLpHfHwpb8GIfX4/KWt8B4YLzY8SYQnpx0+wlsgDImBdtOrAcntH6Md7i/Q2JXCBo8CiSW8vzh Fk6I3Ix85Bg/zVENXytfyBqKt9VdX3ZmtOBiVMpABNJgef+n94VjfLPZsBX55Hwk3PEg0PgeUrQD6P 1MqYGeSDBjk3vn9yoYXXNwplB7PV2MrM4jC2Z7g5bT1wWqSrtUtyqEQcGWzQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

There are similar checks for covering locks, references, RCU read
sections and preempt_disable sections in 3 places in the verifer, i.e.
for tail calls, bpf_ld_[abs, ind], and exit path (for BPF_EXIT and
bpf_throw). Unify all of these into a common check_resource_leak
function to avoid code duplication.

Also update the error strings in selftests to the new ones in the same
change to ensure clean bisection.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 90 +++++++------------
 .../selftests/bpf/progs/exceptions_fail.c     |  4 +-
 .../selftests/bpf/progs/preempt_lock.c        | 14 +--
 .../bpf/progs/verifier_ref_tracking.c         |  4 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |  2 +-
 5 files changed, 46 insertions(+), 68 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0844b4383ff3..ba800c7611e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10352,6 +10352,34 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 	return refs_lingering ? -EINVAL : 0;
 }
 
+static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit, bool check_lock, const char *prefix)
+{
+	int err;
+
+	if (check_lock && env->cur_state->active_lock.ptr) {
+		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
+		return -EINVAL;
+	}
+
+	err = check_reference_leak(env, exception_exit);
+	if (err) {
+		verbose(env, "%s would lead to reference leak\n", prefix);
+		return err;
+	}
+
+	if (check_lock && env->cur_state->active_rcu_lock) {
+		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
+		return -EINVAL;
+	}
+
+	if (check_lock && env->cur_state->active_preempt_lock) {
+		verbose(env, "%s cannot be used inside bpf_preempt_disable-ed region\n", prefix);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs)
 {
@@ -10620,26 +10648,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
-		if (env->cur_state->active_lock.ptr) {
-			verbose(env, "tail_call cannot be used inside bpf_spin_lock-ed region\n");
-			return -EINVAL;
-		}
-
-		err = check_reference_leak(env, false);
-		if (err) {
-			verbose(env, "tail_call would lead to reference leak\n");
+		err = check_resource_leak(env, false, true, "tail_call");
+		if (err)
 			return err;
-		}
-
-		if (env->cur_state->active_rcu_lock) {
-			verbose(env, "tail_call cannot be used inside bpf_rcu_read_lock-ed region\n");
-			return -EINVAL;
-		}
-
-		if (env->cur_state->active_preempt_lock) {
-			verbose(env, "tail_call cannot be used inside bpf_preempt_disable-ed region\n");
-			return -EINVAL;
-		}
 		break;
 	case BPF_FUNC_get_local_storage:
 		/* check that flags argument in get_local_storage(map, flags) is 0,
@@ -15801,26 +15812,9 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * gen_ld_abs() may terminate the program at runtime, leading to
 	 * reference leak.
 	 */
-	err = check_reference_leak(env, false);
-	if (err) {
-		verbose(env, "BPF_LD_[ABS|IND] cannot be mixed with socket references\n");
+	err = check_resource_leak(env, false, true, "BPF_LD_[ABS|IND]");
+	if (err)
 		return err;
-	}
-
-	if (env->cur_state->active_lock.ptr) {
-		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
-		return -EINVAL;
-	}
-
-	if (env->cur_state->active_rcu_lock) {
-		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_rcu_read_lock-ed region\n");
-		return -EINVAL;
-	}
-
-	if (env->cur_state->active_preempt_lock) {
-		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_preempt_disable-ed region\n");
-		return -EINVAL;
-	}
 
 	if (regs[ctx_reg].type != PTR_TO_CTX) {
 		verbose(env,
@@ -18606,30 +18600,14 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 process_bpf_exit_full:
-				if (env->cur_state->active_lock.ptr && !env->cur_state->curframe) {
-					verbose(env, "bpf_spin_unlock is missing\n");
-					return -EINVAL;
-				}
-
-				if (env->cur_state->active_rcu_lock && !env->cur_state->curframe) {
-					verbose(env, "bpf_rcu_read_unlock is missing\n");
-					return -EINVAL;
-				}
-
-				if (env->cur_state->active_preempt_lock && !env->cur_state->curframe) {
-					verbose(env, "%d bpf_preempt_enable%s missing\n",
-						env->cur_state->active_preempt_lock,
-						env->cur_state->active_preempt_lock == 1 ? " is" : "(s) are");
-					return -EINVAL;
-				}
-
 				/* We must do check_reference_leak here before
 				 * prepare_func_exit to handle the case when
 				 * state->curframe > 0, it may be a callback
 				 * function, for which reference_state must
 				 * match caller reference state when it exits.
 				 */
-				err = check_reference_leak(env, exception_exit);
+				err = check_resource_leak(env, exception_exit, !env->cur_state->curframe,
+							  "BPF_EXIT instruction");
 				if (err)
 					return err;
 
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 9cceb6521143..fe0f3fa5aab6 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -131,7 +131,7 @@ int reject_subprog_with_lock(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_rcu_read_unlock is missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
@@ -147,7 +147,7 @@ __noinline static int throwing_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_rcu_read_unlock is missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_subprog_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 672fc368d9c4..885377e83607 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -6,7 +6,7 @@
 #include "bpf_experimental.h"
 
 SEC("?tc")
-__failure __msg("1 bpf_preempt_enable is missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_1(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -14,7 +14,7 @@ int preempt_lock_missing_1(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("2 bpf_preempt_enable(s) are missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -23,7 +23,7 @@ int preempt_lock_missing_2(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("3 bpf_preempt_enable(s) are missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_3(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -33,7 +33,7 @@ int preempt_lock_missing_3(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("1 bpf_preempt_enable is missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_3_minus_2(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -55,7 +55,7 @@ static __noinline void preempt_enable(void)
 }
 
 SEC("?tc")
-__failure __msg("1 bpf_preempt_enable is missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -63,7 +63,7 @@ int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("2 bpf_preempt_enable(s) are missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -72,7 +72,7 @@ int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("1 bpf_preempt_enable is missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2_minus_1_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
diff --git a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
index c4c6da21265e..683a882b3e6d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
@@ -791,7 +791,7 @@ l0_%=:	r0 = *(u8*)skb[0];				\
 
 SEC("tc")
 __description("reference tracking: forbid LD_ABS while holding reference")
-__failure __msg("BPF_LD_[ABS|IND] cannot be mixed with socket references")
+__failure __msg("BPF_LD_[ABS|IND] would lead to reference leak")
 __naked void ld_abs_while_holding_reference(void)
 {
 	asm volatile ("					\
@@ -836,7 +836,7 @@ l0_%=:	r7 = 1;						\
 
 SEC("tc")
 __description("reference tracking: forbid LD_IND while holding reference")
-__failure __msg("BPF_LD_[ABS|IND] cannot be mixed with socket references")
+__failure __msg("BPF_LD_[ABS|IND] would lead to reference leak")
 __naked void ld_ind_while_holding_reference(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
index fb316c080c84..3f679de73229 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
@@ -187,7 +187,7 @@ l0_%=:	r6 = r0;					\
 
 SEC("cgroup/skb")
 __description("spin_lock: test6 missing unlock")
-__failure __msg("unlock is missing")
+__failure __msg("BPF_EXIT instruction cannot be used inside bpf_spin_lock-ed region")
 __failure_unpriv __msg_unpriv("")
 __naked void spin_lock_test6_missing_unlock(void)
 {
-- 
2.43.5


