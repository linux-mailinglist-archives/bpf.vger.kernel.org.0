Return-Path: <bpf+bounces-52957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C4EA4A835
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 04:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3963B1849
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 03:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C416D9C2;
	Sat,  1 Mar 2025 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQNxqjRV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7F1CA84
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 03:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740798135; cv=none; b=WJkvbY9e71kshYFnZlutJMjp7R53QUEl0Pmb6PIX2TSG3TnT93kISwh5tSNk3ssJx5zPyUNtXkjaMFsmm17eDftOV8ts1IKSB0bU6jxemPmGaWACVh1ITGBW7nf5Fq0Laohc938tFO3m08xc5d7yQeUyrrLfg9e0Fiu1gHVJk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740798135; c=relaxed/simple;
	bh=SJCowbVKLs1OnsqlOi39v/+vLx+o2dOZ+aMHiQT9mw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYsqscoAIAbrpdP4Sv34aEiAaknxTV8GbaacRwBsG+4/hYFkJeKXXtCo8Be+XWn3B4Rs38B7M5Q493NYO3DXUiLntamkshUIO45I/BjCSKOanaXqRNq7SGo+xQ3NMOT+nGdC7kRNyjCnThc301r4e9O1x7vgXhzmtGnUg8R+3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQNxqjRV; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso28602225e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740798132; x=1741402932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsuz84cgr5551RFT5Sw/c4oPp2dS8p6JRsRwMJHcwXU=;
        b=kQNxqjRVSNrdD+7RA0H+Mj3wXJB6kMmhG0tVSzheDrMqxxk3ouPWE3TP+VYCApXm99
         pB4tBBExE44uSK2fiCgODxdbnuMNQOWi2u6SkOYOadruKIqucxyTAlReUOTMbgL0Qt8H
         kiVKMl+H5yFbwTSlDR9qLRMsvh/sRiZ6o6IlZGFeBNMYU3JrBBfO3Bw1bMjR8tDIEXHH
         Z1EDcwmfU2bn8C2R9rNqfY9Nyy3INv/YuCgLSqvfZG74tTrb8tfjQvslDgV1mHt2UWsa
         YgE8ERdWOeQl9mk6fnh/FLBfyQaXGxjFNAk8jw+d7+wN8VktDkdtiWaRucUMruF1gDve
         gZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740798132; x=1741402932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsuz84cgr5551RFT5Sw/c4oPp2dS8p6JRsRwMJHcwXU=;
        b=LZ1LJTuo77nwG2mklHn/q5nzect2cHE0nrLLABtruxMospyr9XCvSNcOY3EdwQm8S7
         mXfunNPA0cbldoqdSAz0VwCWmH0PRZS3bKfQY5/Zf1zf6EsnUN2GMlrqndoA6KJHO0sa
         WE5iQXGqIjyfOTpun3UyH5lpf25dt75eLI5qrG49DiF2lCDu3QDZ2m4cPvf/BYrrwdot
         rItwUD0oTbMuB8DfhjH+Q8h6zKvkn16QonoXRdmYFL5N3nh3r8TPYbFxFHkS9dRYiwBj
         8Mnl/szFIuNvY5Tq1UhwJ2XhovcN6bBBU/W1cRaybOiripCakpnpLCW/rHXTd4gk+wLD
         LjZA==
X-Gm-Message-State: AOJu0Yx/8eyZqlDtbJOfka9Qg4h+njyfF0WqhTiP2Lu/IwsAMy99bqkp
	+5n8NBmFLtFxvcPOFdPe4NHOzrHwpzE92w2WcGkLmGCv1V4zPV0KOL8XsJbh644=
X-Gm-Gg: ASbGncubUG8cn1KLGxod5idgUeX6B5oPfEGsmnsi+oEmizxROtLNVcnM3uSuZZlX79P
	qUiL2b2ExoNFq5J0YymjcGzZHfTJDLL3NhsejBuwUSzuf6Q3tDN1VrBTCPjB6K9aU7Fo3amYhIO
	T+3G8sr7RaHuYe6durBzjoL7SBT46gBxoY3yc+F+gFJN4W51MLVu7uLn0/12WNc/Xk6ibYKeODi
	NajYyXH/kPtIUHAIilF18ogXNzQqtgMMevLoFZmQxgQpkjvw4RZetEWHVgUK2GRTW6ZHvsnfwRC
	YVyKiaaZ0VNiPc72Yc6diuyl5EXY+5ueQf4=
X-Google-Smtp-Source: AGHT+IGA0QioO1nfruzEz8FW6UWZsjhuWLX8sXvpcum0t5CQBPCky5RIAD0IlDUtg0tgPN/HychQhw==
X-Received: by 2002:a05:600c:4fd3:b0:439:a255:b2ed with SMTP id 5b1f17b1804b1-43ba66e5f09mr56694695e9.9.1740798131553;
        Fri, 28 Feb 2025 19:02:11 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba539450sm105814685e9.21.2025.02.28.19.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 19:02:10 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/3] bpf: Summarize sleepable global subprogs
Date: Fri, 28 Feb 2025 19:02:03 -0800
Message-ID: <20250301030205.1221223-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301030205.1221223-1-memxor@gmail.com>
References: <20250301030205.1221223-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8141; h=from:subject; bh=SJCowbVKLs1OnsqlOi39v/+vLx+o2dOZ+aMHiQT9mw0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwnU/Xj7wIa5MOt6EPLiW9JLHc4Ki2UMcZTAk5wdn 5RoiEICJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8J1PwAKCRBM4MiGSL8RyvPqEA Chdosn3uGh1ehpyrAeRJlsfK8w6dhxWcrIeuHXHRd53PewZnlSNFAQ3wNiMCZyxdl4uaIKkr/KP+En kMjrQYXZcf37bMOxcQUeoVXWCeQhbZypTihcJ8OsKSVYQnB5YlY0zRQR2wlslQ0p4YzeejHqoFto+E zd7Z61KJxDzq89l5brVME2Pt0nZLl60OWgNQEjYQ+FUxigm41XkXV2aVZ2aZq6bUvwv+kRC7i6ou6L OVLwkyYJHYV5JTuqO55VvqPcPucuLFmuf0Z3li13l/C4SgGh7a9d4GiX75zkABb7B/1HEV5uCayU2w wihwCSq6UG1u68JNYPmMooMm4Z/fNPnClyhp3QoJVBRrMolPMHyg5Pg99vEp/9Zr191TekVdzFJuz9 zhdCxMSkuc8bkAkQT5VFcd3HAG//NRGi12It0gh6SZLx/IcZPIIgfcvNweTN3HJuWEMDVW42hxWpG1 hpiZpDOKrr3mTQ7i5VCGMe0yzTm8uJ80T86xJ4u5eYTjUc7H1wHpVAjxR+Fnzpo63EYq6+VNqQlVMt 60VQvbkGumbW8qelAu50B05E62HTzOXI4ChGtaOLm4/KemtQ0DEf18kr1Q5WYP4zuIBCmoDhs3lpwz kat7M674N9Ju4gpAQ6qDl4S723TtSmSBEXXp0iNtO3yUOr591H2XmM7CsrHQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The verifier currently does not permit global subprog calls when a lock
is held, preemption is disabled, or when IRQs are disabled. This is
because we don't know whether the global subprog calls sleepable
functions or not.

In case of locks, there's an additional reason: functions called by the
global subprog may hold additional locks etc. The verifier won't know
while verifying the global subprog whether it was called in context
where a spin lock is already held by the program.

Perform summarization of the sleepable nature of a global subprog just
like changes_pkt_data and then allow calls to global subprogs for
non-sleepable ones from atomic context.

While making this change, I noticed that RCU read sections had no
protection against sleepable global subprog calls, include it in the
checks and fix this while we're at it.

Care needs to be taken to not allow global subprog calls when regular
bpf_spin_lock is held. When resilient spin locks is held, we want to
potentially have this check relaxed, but not for now.

Also make sure extensions freplacing global functions cannot do so
in case the target is non-sleepable, but the extension is. The other
combination is ok.

Tests are included in the next patch to handle all special conditions.

Fixes: 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 62 ++++++++++++++++++++++++++++--------
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aec102868b93..4c4028d865ee 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1531,6 +1531,7 @@ struct bpf_prog_aux {
 	bool jits_use_priv_stack;
 	bool priv_stack_requested;
 	bool changes_pkt_data;
+	bool might_sleep;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bbd013c38ff9..d338f2a96bba 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -667,6 +667,7 @@ struct bpf_subprog_info {
 	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
+	bool might_sleep: 1;
 
 	enum priv_stack_mode priv_stack_mode;
 	u8 arg_cnt;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dcd0da4e62fc..eb1624f6e743 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10317,23 +10317,18 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (subprog_is_global(env, subprog)) {
 		const char *sub_name = subprog_name(env, subprog);
 
-		/* Only global subprogs cannot be called with a lock held. */
 		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
 			return -EINVAL;
 		}
 
-		/* Only global subprogs cannot be called with preemption disabled. */
-		if (env->cur_state->active_preempt_locks) {
-			verbose(env, "global function calls are not allowed with preemption disabled,\n"
-				     "use static function instead\n");
-			return -EINVAL;
-		}
-
-		if (env->cur_state->active_irq_id) {
-			verbose(env, "global function calls are not allowed with IRQs disabled,\n"
-				     "use static function instead\n");
+		if (env->subprog_info[subprog].might_sleep &&
+		    (env->cur_state->active_rcu_lock || env->cur_state->active_preempt_locks ||
+		     env->cur_state->active_irq_id || !in_sleepable(env))) {
+			verbose(env, "global functions that may sleep are not allowed in non-sleepable context,\n"
+				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
+				     "a non-sleepable BPF program context\n");
 			return -EINVAL;
 		}
 
@@ -16703,6 +16698,14 @@ static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
 	subprog->changes_pkt_data = true;
 }
 
+static void mark_subprog_might_sleep(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *subprog;
+
+	subprog = find_containing_subprog(env, off);
+	subprog->might_sleep = true;
+}
+
 /* 't' is an index of a call-site.
  * 'w' is a callee entry point.
  * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
@@ -16716,6 +16719,7 @@ static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
 	caller = find_containing_subprog(env, t);
 	callee = find_containing_subprog(env, w);
 	caller->changes_pkt_data |= callee->changes_pkt_data;
+	caller->might_sleep |= callee->might_sleep;
 }
 
 /* non-recursive DFS pseudo code
@@ -17183,9 +17187,20 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			mark_prune_point(env, t);
 			mark_jmp_point(env, t);
 		}
-		if (bpf_helper_call(insn) && bpf_helper_changes_pkt_data(insn->imm))
-			mark_subprog_changes_pkt_data(env, t);
-		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+		if (bpf_helper_call(insn)) {
+			const struct bpf_func_proto *fp;
+
+			ret = get_helper_proto(env, insn->imm, &fp);
+			/* If called in a non-sleepable context program will be
+			 * rejected anyway, so we should end up with precise
+			 * sleepable marks on subprogs, except for dead code
+			 * elimination.
+			 */
+			if (ret == 0 && fp->might_sleep)
+				mark_subprog_might_sleep(env, t);
+			if (bpf_helper_changes_pkt_data(insn->imm))
+				mark_subprog_changes_pkt_data(env, t);
+		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
 			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
@@ -17204,6 +17219,13 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 				 */
 				mark_force_checkpoint(env, t);
 			}
+			/* Same as helpers, if called in a non-sleepable context
+			 * program will be rejected anyway, so we should end up
+			 * with precise sleepable marks on subprogs, except for
+			 * dead code elimination.
+			 */
+			if (ret == 0 && is_kfunc_sleepable(&meta))
+				mark_subprog_might_sleep(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
@@ -17320,6 +17342,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 	}
 	ret = 0; /* cfg looks good */
 	env->prog->aux->changes_pkt_data = env->subprog_info[0].changes_pkt_data;
+	env->prog->aux->might_sleep = env->subprog_info[0].might_sleep;
 
 err_free:
 	kvfree(insn_state);
@@ -20845,6 +20868,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
+		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
 		func[i] = bpf_int_jit_compile(func[i]);
@@ -22723,6 +22747,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	if (tgt_prog) {
 		struct bpf_prog_aux *aux = tgt_prog->aux;
 		bool tgt_changes_pkt_data;
+		bool tgt_might_sleep;
 
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
@@ -22765,6 +22790,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension program changes packet data, while original does not\n");
 				return -EINVAL;
 			}
+
+			tgt_might_sleep = aux->func
+					  ? aux->func[subprog]->aux->might_sleep
+					  : aux->might_sleep;
+			if (prog->aux->might_sleep && !tgt_might_sleep) {
+				bpf_log(log,
+					"Extension program may sleep, while original does not\n");
+				return -EINVAL;
+			}
 		}
 		if (!tgt_prog->jited) {
 			bpf_log(log, "Can attach to only JITed progs\n");
-- 
2.43.5


