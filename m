Return-Path: <bpf+bounces-70545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C15BC2D01
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 00:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DAD3C616B
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B39C2580E1;
	Tue,  7 Oct 2025 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIIhJj5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220B254B03
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874635; cv=none; b=gydbOW92qXGl0ODKJF4lyvD4Dk/UVILjf/SSvx0y5TwMn/7mkcj17CNYDoA0RyKUCSNWCtXYPw5D7VGbXfv33HweXhBcTL/x84tcL9eQxPlxp8aRCeP+L3LR4zuZW8H4t+cyMPQRK+aAMyo2bEXJnXsCZqqss7EEz1Bp/Ktjryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874635; c=relaxed/simple;
	bh=JIIzHA3qVVrKuJxApdAFCnyzOYN8KosqlUrs5uNeZJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNKCz/iDeVdH0JqnNBHXECntnD3Q0CIFySHPCjZjopDzvambZ0yp0LVldaaHvSorRbL1BECm5iDdaEzAHeyxa1GHOFAMiB+kZqlrMiV3LxpW69M+qHp7IjtSiu00zGe4mc4U/ZmgqK+YEDl/zeRLsIKvVOAgfhHn2f/LCAXIKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIIhJj5E; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso54778215e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759874632; x=1760479432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ffHl83FSu1hVPkigQqksPYp4a8yftWqGxSznQX6dBo=;
        b=RIIhJj5ENw0htdR/9/ddfv97/PQzbBDcNeXYFBRqxB+dMHJAurL2cT5zFnLpMY0f9q
         AS0HkP2jJnWjKZoX1B2UzockpnqrjH9+ZXS8saOjpv3Hx6mn2TV22BIxfMLtANday5Zy
         7Uo9xViMWaax52AJXLtRRQRVYD5v3ud1U8wHMJunzm4ItlU235hsMtkoSSEkDO72lveP
         80fRNucwoA8WR384Gd97HkiuIj7bMamedFLYgFjfQByxv4b+Hbdhmqiu/ybOtzgDKgOX
         VUPtldZTu2+VzpETFvHyj2Tq8BSt2HzpIKkNlwjQS38gBfByoyY3SLbzpb5G/zwqi1Mj
         1foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759874632; x=1760479432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ffHl83FSu1hVPkigQqksPYp4a8yftWqGxSznQX6dBo=;
        b=L05zE9wqa2+4Kmv4WQSz9T0rZJcoH1Q1ZLFU7f67ZKtZqNMfbF78DqrNGQmUIzNwVy
         LY37lDs0AIKCGUWcsS4gJs0jFOoL/lcG2ckNHqZ/XocnulUSpLUDMDPklvqoWya2gyfN
         xuwXZH4o3aYnyhtbuoCBSFSp+16xvGsHmkGJj9g4Oxze8loTxpJ11ITT3X6EEp6SvC5w
         Fa21hyDEbOW3yb2vKNno7zckmtvYohVDRuRdyBCnqdmSb4yfRVUzUXErr4ARS6LyDuMx
         bm67Z6KBWp4nOMKyqqkYA2+HkeEvGkPUW4anFsbpUv7y+bCv0i09je8dfpFlXz4AscjG
         aOXA==
X-Gm-Message-State: AOJu0Yza4TuQgyIlNJEsJaGIYh5o+wQxZoplikcvtfDcsGdrbebFYVZF
	+2eCvBvT6Tcpb1JaL2PDCe18mIW0nr9kkU6NaNg/xHFjf0NwTjo50waPXq2YB3AD
X-Gm-Gg: ASbGncv6jRqZDt09B8OLfr3zmrFWtBhlEAQ+Hz9OWdIvBJiHGXT2EURtTF4K+UMUtCz
	pYCxnFe/cIcMx/ncs2l3sZhoUWeIwFVEwNnx/Nmcw2UYi1mAdZ8sUHGfZoRnAeSzvFWrmelhPWc
	M6u1wuQSIIcvKCtu/TomH+h0aPVU4nr2nczSaIufAU9IRTmEbyh8AU+D9/SotXvT0p+vrqaARRU
	yAITuHoEGGVOjcjBAWiHYBxIqDgxKQcwqACVK+bUG9SHpec0dzMFIAw1ExPlDB/ma3B9peSSEON
	AN4YobTEccxNSErTHjv/RmytuSEN94iTrh4Y12GKdEGtMdd6qU7r0wZxpQaszXAQO2jQQQUtTwv
	IjoYEwWUcJb7WCCCQKNuZ/3xlLALQBDRKwwNy7yytxTzz0ajdDRwrq8mIihK175Ecm2Phesx+wW
	jN88Tjm0mpUOIaqDGrWyK2Sb95
X-Google-Smtp-Source: AGHT+IHfsH+DkkCJ4ebFOwHE2odup3dZebwyIb7Ltq1xsTsHnSyZpOh8WSnFp6/83PxRVZNFxLVciA==
X-Received: by 2002:a05:600c:8b52:b0:46e:37d5:dbfe with SMTP id 5b1f17b1804b1-46fa9b106eemr7017165e9.32.1759874631648;
        Tue, 07 Oct 2025 15:03:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fa9c07cbasm10121525e9.7.2025.10.07.15.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:03:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/3] bpf: Fix sleepable context for async callbacks
Date: Tue,  7 Oct 2025 22:03:47 +0000
Message-ID: <20251007220349.3852807-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007220349.3852807-1-memxor@gmail.com>
References: <20251007220349.3852807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8113; i=memxor@gmail.com; h=from:subject; bh=JIIzHA3qVVrKuJxApdAFCnyzOYN8KosqlUrs5uNeZJk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBo5Ym4t9c+idNa0sjdv2mm+xW13nTu1RVTQHidK bgy2S7Nrh+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaOWJuAAKCRBM4MiGSL8R ysoLD/9IGmhHkBIQZfIh1q4dcJ+jDp2mj4o0Mb6WFZ9AUsg7HfujOCZsiHJEu6I+SbFc/kKnvhh Slw3ZVAlr3B91E7i02MUJbhsVA4tGOyOnzoEmGsxhlFauVDbiwrtha4g6BheBhT1qr8UCpzhp9W VT4nORJdvR1T6b6aIt7Z5xsmhfyZykr255EZRFFeoyAyjCqyDwJMYmajPInjQOsublTAD0IxIPl zcBPx1Bc+ZZCq9h5RT0sEJXJpn401nibAj+YrGzZgpKJdm+8TTHncrctdY6HnJF/7WBtWjeG1QT aqjlBUTvmPuKRTGKpiaegUzbwAbJ6dI4mK+7GhUeom+b6UZy46dnjHIEn2e0PQPXagvKLSnET0i 4ELHJMFj6yovXQtXgUyPJbYCDF+5xgJ/dZShhE/tgsYByvQ9UzUWhx4y/D6hP84KUQk3JLSKDFW SH77tku44ZBDOc4SVFCahyNHqJKT0vwPj2xD6oC2zKJlWsWFdb6iExC6NS2hspKlJ1J4oiGHujO 35KJVKsZOraamrGjwEMKqJAry52/akKQ0fvy2RcPSvWbABP40EmhtEnnRgjhQMcw7WgIkecsvMk wike10RJ7HP+HZOtm+tMeQo0WA4dFSxZrSWd9fSqKO5t6xo6Lxda+BPPnQwEuft78OJiKGsaOhN xJ/ei0NvJoFxT3w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Fix the BPF verifier to correctly determine the sleepable context of
async callbacks based on the async primitive type rather than the arming
program's context.

The bug is in in_sleepable() which uses OR logic to check if the current
execution context is sleepable. When a sleepable program arms a timer
callback, the callback's state correctly has in_sleepable=false, but
in_sleepable() would still return true due to env->prog->sleepable being
true. This incorrectly allows sleepable helpers like
bpf_copy_from_user() inside timer callbacks when armed from sleepable
programs, even though timer callbacks always execute in non-sleepable
context.

Fix in_sleepable() to rely solely on env->cur_state->in_sleepable, and
initialize state->in_sleepable to env->prog->sleepable in
do_check_common() for the main program entry. This ensures the sleepable
context is properly tracked per verification state rather than being
overridden by the program's sleepability.

The env->cur_state NULL check in in_sleepable() was only needed for
do_misc_fixups() which runs after verification when env->cur_state is
set to NULL. Update do_misc_fixups() to use env->prog->sleepable
directly for the storage_get_function check, and remove the redundant
NULL check from in_sleepable().

Introduce is_async_cb_sleepable() helper to explicitly determine async
callback sleepability based on the primitive type:
  - bpf_timer callbacks are never sleepable
  - bpf_wq and bpf_task_work callbacks are always sleepable

Add verifier_bug() check to catch unhandled async callback types,
ensuring future additions cannot be silently mishandled. Move the
is_task_work_add_kfunc() forward declaration to the top alongside other
callback-related helpers. We update push_async_cb() to adjust to the new
changes.

At the same time, while simplifying in_sleepable(), we notice a problem
in do_misc_fixups. Fix storage_get helpers to use GFP_ATOMIC when called
from non-sleepable contexts within sleepable programs, such as bpf_timer
callbacks.

Currently, the check in do_misc_fixups assumes that env->prog->sleepable,
previously in_sleepable(env) which only resolved to this check before
last commit, holds across the program's execution, but that is not true.
Instead, the func_atomic bit must be set whenever we see the function
being called in an atomic context. Previously, this is being done when
the helper is invoked in atomic contexts in sleepable programs, we can
simply just set the value to true without doing an in_sleepable() check.

We must also do a standalone in_sleepable() check to handle cases where
the async callback itself is armed from a sleepable program, but is
itself non-sleepable (e.g., timer callback) and invokes such a helper,
thus needing the func_atomic bit to be true for the said call.

Adjust do_misc_fixups() to drop any checks regarding sleepable nature of
the program, and just depend on the func_atomic bit to decide which GFP
flag to pass.

Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff40e5e65c43..32123c4b041a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -515,6 +515,7 @@ static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
 static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id);
+static bool is_task_work_add_kfunc(u32 func_id);
 
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 {
@@ -547,6 +548,21 @@ static bool is_async_callback_calling_insn(struct bpf_insn *insn)
 	       (bpf_pseudo_kfunc_call(insn) && is_async_callback_calling_kfunc(insn->imm));
 }
 
+static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	/* bpf_timer callbacks are never sleepable. */
+	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_timer_set_callback)
+		return false;
+
+	/* bpf_wq and bpf_task_work callbacks are always sleepable. */
+	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
+	    (is_bpf_wq_set_callback_impl_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
+		return true;
+
+	verifier_bug(env, "unhandled async callback in is_async_cb_sleepable");
+	return false;
+}
+
 static bool is_may_goto_insn(struct bpf_insn *insn)
 {
 	return insn->code == (BPF_JMP | BPF_JCOND) && insn->src_reg == BPF_MAY_GOTO;
@@ -5826,8 +5842,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 
 static bool in_sleepable(struct bpf_verifier_env *env)
 {
-	return env->prog->sleepable ||
-	       (env->cur_state && env->cur_state->in_sleepable);
+	return env->cur_state->in_sleepable;
 }
 
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
@@ -10366,8 +10381,6 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
-static bool is_task_work_add_kfunc(u32 func_id);
-
 static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
@@ -10586,8 +10599,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
-					 is_bpf_wq_set_callback_impl_kfunc(insn->imm) ||
-					 is_task_work_add_kfunc(insn->imm));
+					 is_async_cb_sleepable(env, insn));
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
@@ -11426,7 +11438,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 
-		if (in_sleepable(env) && is_storage_get_function(func_id))
+		if (is_storage_get_function(func_id))
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
@@ -11437,7 +11449,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 
-		if (in_sleepable(env) && is_storage_get_function(func_id))
+		if (is_storage_get_function(func_id))
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
@@ -11448,10 +11460,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 
-		if (in_sleepable(env) && is_storage_get_function(func_id))
+		if (is_storage_get_function(func_id))
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
+	/*
+	 * Non-sleepable contexts in sleepable programs (e.g., timer callbacks)
+	 * are atomic and must use GFP_ATOMIC for storage_get helpers.
+	 */
+	if (!in_sleepable(env) && is_storage_get_function(func_id))
+		env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
+
 	meta.func_id = func_id;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
@@ -22483,8 +22502,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		if (is_storage_get_function(insn->imm)) {
-			if (!in_sleepable(env) ||
-			    env->insn_aux_data[i + delta].storage_get_func_atomic)
+			if (env->insn_aux_data[i + delta].storage_get_func_atomic)
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 			else
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
@@ -23154,6 +23172,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
+	state->in_sleepable = env->prog->sleepable;
 	state->frame[0] = kzalloc(sizeof(struct bpf_func_state), GFP_KERNEL_ACCOUNT);
 	if (!state->frame[0]) {
 		kfree(state);
-- 
2.51.0


