Return-Path: <bpf+bounces-70479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B7ABBFF9E
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 03:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5581B18988C7
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 01:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D381C6FF6;
	Tue,  7 Oct 2025 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjkDf/3L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE07464
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801397; cv=none; b=kTVW0MYdadIlJL5pZY93RjnsuxomVXYCpmzKJTe4CnTk0CdBczHKDzTrvDxcdW+nlkELUMXytIF2hpb0/m/1ADraDVG3QrMYDDa3tjXVJA9ejzslyVot1sHTXUF3h0DED3RQbgA3s0gJCRIfGcbsVvEc7woOofeYp3/94ECYrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801397; c=relaxed/simple;
	bh=p+fXn5xsyddvJswEy+aXeI2ZixiCgsxtU6TUJRbeQBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9NHTHJNBlqkzp1Z9WBdaIx3V3Xk+mQdKPnZpTswEx12zkXnZY1Ql5GcODKEFIACc9mB1t48dyQ3T2s4KPlLJOy2lxtJ/xJFCSVt8/Ui2wLq9EGtfL+LVh9pNyprxosIcp1VMwI59Fv/yhyWwfwDRysTR+MU6RmjsdflTUoNNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjkDf/3L; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b40f11a1027so1006269266b.2
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759801393; x=1760406193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1W9Bsu3OGql9J7/mHF02DsqrDepDTZcnozwSZKyb9g=;
        b=WjkDf/3LdZEa2n2QW4xSxhzrTM/TQarPrMtRWKgFNa2M0BCZBeITrieHmSc/jf01nv
         Nj+LbQNNoYs4ev85wJtONUvoQS60vfRU0dI90vGIzSH4shdsUR33YlSJiEO3ib5y8pWy
         2K8mI8CCFZkG8JPzu6BCCW3xvsqnfaNzX1ESjeSMgrCzdqmE/rGuY+AMknjgIDsoy0sT
         EBvUMLXxNQH+w35mMelTo/mCEF4orRCQ0YdGMyH5aqnGdbsISV2WcyETE5z0Jv+6zkdO
         xtp+Yo18OTGi9D690/7ANgQTp2+7FjdeRAZPdsOxZmmSZTP4UC6r/q8vG7VkEbQBAkHt
         23yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759801393; x=1760406193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1W9Bsu3OGql9J7/mHF02DsqrDepDTZcnozwSZKyb9g=;
        b=oSo7xiZnjqmqdy99B1CZPdSuXqjK0CtVYVbZVES9DXLrC1K4hmqdu8RYwFlpOWMNQn
         TNWfjr2v/zAl3gmjfrmEj3bS9y03uwfMYFJrEMMU9uQh0UY9AyLED+GHV7wobo4F+EHa
         uD01OUirNgYIaGtudyFQQSTlHNasP6si8LVL4Cq5JCqaA3KVsNp96pJoXCHsT6ZKqrz8
         +nTWeiC3QkRMFAsrDR/h6zev8G6Oluf9/QAEtPtss2fFXVbXZ0Q+fHR06ppLnhsDyJ4s
         cUdkHxRTiAa2Exmf9AR9LHbM6qTklb6Qf14FdMaiNm7kjuMD3Wferoo+McNd+CloAccu
         RfEQ==
X-Gm-Message-State: AOJu0Yy3HwMhdv/Su0dtec1UBO2L4bafRqroAca6bRNcRJmzYfQm/hDE
	24lK8x5wX3l5a6l12SLgIMTc4Py+KbjOr/K6aLzcKZiko4Ob8o8O6EVJKYOdG1uS
X-Gm-Gg: ASbGncttyKXuywLz+HwHt1i6skLeSxsqKRMXxxJkeI+iQwFQwilSwMmBP639ZDllrL4
	mrAGh7etOVEjpL26j2nEINbF0LuiuePZs8Md1QIuHHrhIEcbl7O+8yC4/3ULHTqe1B7HzEdzsAB
	QXvsOJDYMPqL/hNH+Daob3OAlzsWAI1zsdhfIlggUaBzV3EHCmKYBy+1STlWOXN/to+2CquRxTn
	1oVfYLLZgKHVOP9BHW5ecoOT7954fSCvC24DmEMsd4Hg/Kuz9tDOkEH2ZaQVy1E0nAybJQLawer
	o0D0K3sfWiBTQhhsrvHO1FCJ3aWYgkoCcFo2mv1vAB0OVOIHsPdizmq+AlxXbz06hxqqlJT8h86
	NJZb3Z62BLSBHU/7Vh7Cb0iN3Drwc6qKg6rEOPi6GU1Af41Yd4vPX4WM62zIz79iOt9rVD8keRr
	qgxmbVGn8j9GLz8rLwT5y4p7me
X-Google-Smtp-Source: AGHT+IF4jXsJEu0evE78SJEHIuzO5F0Bx8lWM7EAmnVWcZ7g5j8RB73bkaFUmJEMoaIqhph/siY+Gw==
X-Received: by 2002:a17:907:da0:b0:b45:b078:c534 with SMTP id a640c23a62f3a-b49c3f71c5amr1715014766b.45.1759801393139;
        Mon, 06 Oct 2025 18:43:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b486970a4bdsm1270236766b.49.2025.10.06.18.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 18:43:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] bpf: Fix sleepable context for async callbacks
Date: Tue,  7 Oct 2025 01:43:08 +0000
Message-ID: <20251007014310.2889183-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007014310.2889183-1-memxor@gmail.com>
References: <20251007014310.2889183-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5360; i=memxor@gmail.com; h=from:subject; bh=p+fXn5xsyddvJswEy+aXeI2ZixiCgsxtU6TUJRbeQBg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBo5HAYPY/MQWUIUQH77llaWwz8LPB7Z3IElh2dK G+adOjzSn6JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaORwGAAKCRBM4MiGSL8R yjfoEAC6/OJdaouXHXoPL5mbeNQzfJTCp8PpkJm0IXzTWfdIlpfA7lUnc2BPP/vCN92sYzAYyKc h2unK3Zudp+pErqKM+fp79Fclg/SyNv2mZwr7zu9hbaiq2rVV2Ki9sOXS4gBqglHoCN+M/3N6o7 ExbXx0cwSAHDGxUtIZPUExtqRAgknf39zFsaPd1Pn5gmVtvPyHGN+4SWyFC+FANHk/GXDLDTMk1 ZwG7WohvdqM3LN6ZiXCbZphatAvltttS0yCYHDv19VuCt8ERlRy9iTChhjnTQjnfrJNZECjmJFB 1KBUSC5Mg3LKsST+V2CBnEmG4mJTyzUeZ/1V9zxrG/WIMZwx+EiI0xtirN9HvBClM+4DMZwBa74 mho8vaGYTW7p2LAN9C5A/8UpcX93J2KisdlAQUiTeomZ3aC20K5bp6xyKx0jH5vwk1bv2YQf2rr 6x/Kpc0t1WwUtxfoR6DFJ3htKsbeZ+Crs3T5CpeYZB3ly7LG39Ruk2HTQXhd3IuzcJze408kZRU PeB+0D9iZbeamCdkuyfdVVYr/s1e3YiXUtzMza5Pm+4+Gs13QJ/RiFyyyt3Uls2+OGI/6wZl1z4 rY5+uqouwoZ7jo2AgG6AgwHSCceaoeRLwjqAM0PeJkQKsP3nV4GorO5P3DWEeYBmW0AZYpkg+Vq QfP/bBYf40Umo+g==
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
callback-related helpers.

Finally, update push_async_cb() to adjust to the new changes.

Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff40e5e65c43..eff81ad182c8 100644
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
@@ -22483,7 +22495,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		if (is_storage_get_function(insn->imm)) {
-			if (!in_sleepable(env) ||
+			if (!env->prog->sleepable ||
 			    env->insn_aux_data[i + delta].storage_get_func_atomic)
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 			else
@@ -23154,6 +23166,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
+	state->in_sleepable = env->prog->sleepable;
 	state->frame[0] = kzalloc(sizeof(struct bpf_func_state), GFP_KERNEL_ACCOUNT);
 	if (!state->frame[0]) {
 		kfree(state);
-- 
2.51.0


