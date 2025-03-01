Return-Path: <bpf+bounces-52983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EECBA4AC88
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 16:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569B716C254
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF67E1E25E8;
	Sat,  1 Mar 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJmQfeGC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4EF22F19
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740842333; cv=none; b=FGEp2G8ErbLgXw+xqt8jxGPpryxi5SpG6PIroDRTFO3Teq4JlR8XyqUaZjQodrqE66BM6FkKzS/8Fy+lw/ia/Bj6dRVTVoDRaXjXuERceh/Skrj2S/8zIzYW85UFO3tFGI7ohPyZZwNo5mIRUo6ydJaUiIQccmg1rP5Y+ap0gEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740842333; c=relaxed/simple;
	bh=SJCowbVKLs1OnsqlOi39v/+vLx+o2dOZ+aMHiQT9mw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hql2+ttMbDXd48zdhL84uztxBXGPk6n+Rr21MNCBwFxtfBbpkfLM+ktnqpyuqJubJ5Xnu0P0NXbMM3470RDc2dHtOCZ2lSNk/H6aDwyUPhC8GJKj1V1F4GKVZno3NSN7GPs1iDvFCnC87Xdr84H1gwf+M3oBz9jbxf9P4FJbqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJmQfeGC; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso21168425e9.1
        for <bpf@vger.kernel.org>; Sat, 01 Mar 2025 07:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740842329; x=1741447129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsuz84cgr5551RFT5Sw/c4oPp2dS8p6JRsRwMJHcwXU=;
        b=PJmQfeGCtnrFS/DvtLpD/LwvQua5bTq2wUYsfREdAFhS1abJL1UaLrT+qlHXVnoPWk
         HGgmpJZ/OJkL7RJzQu8LaRxoL1BOES2F3KNZwFFI6iZ7nKUAAFXD9thC8KytxTwGMF3q
         T4B1ASrPQo3ej715iXQpwuKYVVL6TlWlew7bSOdBuHG6krrQwOx0ITQUwT+ruDqqp6FB
         q7jIdnezdOWb3yqnz7Ixwnge7C3f1Kd2cCmf6GaBv5I122ewDgP2kYhKdjuUiMlNVWDH
         T/McXg8bnq6CYWKce6l12Az4jDo5z5eV/7NAzKzmlAuNHNtyYTupX/a6MGfgQytDzcMk
         9Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740842329; x=1741447129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsuz84cgr5551RFT5Sw/c4oPp2dS8p6JRsRwMJHcwXU=;
        b=IqunKbhmLOrSwNPWzTcgCQaYNw3kCcZUib3lKdZcsticAwhz07UR79pAyp2V9gGhcd
         7ae5BVKF0+3mW4ZRh23vpVpW0hZsoFnK5T1HQXS4zi6dbpBr484cABBoRh0sKscKrUZD
         +dKCCwj1srIO556OBGRYawTfb1uRCPvRfLpaNT4CJl5F5pl8MTo1wrfq94pV3WhBRizg
         U4sNU21QMQxCKDh6boDLcdbnLbFRFcIphcB2hRQRh00Y/jrNTAWI7Ax7CaR7NJIUgl94
         qsdgonK6JlAbPE6PYHV7XDtE1hQWFbygi7E/afC3Yupmr5wViMK32BlJnNH+Cw/s05q0
         tf9A==
X-Gm-Message-State: AOJu0YwD9UGnv53L0qPreFDfgG6wwHk8ndgzyK5FnQ/MkUCeQiTrMdl7
	aJ0oBwCycP0so42+ogeYaa11mZPfC2yzetsU2AjQ9UjXwmF5h6HOFs+e/1a0ZK4=
X-Gm-Gg: ASbGncuqWIti83ApUZp4OhZsfgyIuah5M0tHeVV7uJzu/+cjYL+Rwya3nLKDp2JUdL7
	0s31cPgFVMbbarLGUKQozmUopx23DXqTIfujc8tm/5E0bNKW1h4pMXf+8c8lv0afZK83qLJE7Zp
	3E8F9FTlHTUz7CLMtilw8vpmAMr5wiGzNvckRqAGg/0f6PDETO78P2Oob8L3usGpB9JxryQrEw0
	hObIJNZOs/mKYL2yfcoJP7FzuagAsQ72A9+yCI2QtSQtJFF9q3fcK77AHqJP4Vx5snjAqoJprkG
	oSB6oVR4fqUdP65irROEHHKjWUGbywXqbK8=
X-Google-Smtp-Source: AGHT+IE99PC109IuQZJWU+pcHZHcQOhEPdxUEaVBoVC4HBUAsTHiIHCSV//ibhWuncRqWbkuuSqJSw==
X-Received: by 2002:a05:6000:20c4:b0:385:f249:c336 with SMTP id ffacd0b85a97d-390eca26356mr4959972f8f.45.1740842329063;
        Sat, 01 Mar 2025 07:18:49 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a16sm8617545f8f.79.2025.03.01.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 07:18:48 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/3] bpf: Summarize sleepable global subprogs
Date: Sat,  1 Mar 2025 07:18:44 -0800
Message-ID: <20250301151846.1552362-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301151846.1552362-1-memxor@gmail.com>
References: <20250301151846.1552362-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8141; h=from:subject; bh=SJCowbVKLs1OnsqlOi39v/+vLx+o2dOZ+aMHiQT9mw0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwyScXj7wIa5MOt6EPLiW9JLHc4Ki2UMcZTAk5wdn 5RoiEICJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8MknAAKCRBM4MiGSL8RypydD/ 9d/0B8wEeRNbdCmxEc6CqbMIbryju2Wb1Qm1eTfkmd9JhJkU8Y3PcelHF+R4DMkpR6xvc3fSgGRCS1 mM0f+cYvOtkaSxhhUUC8DWTfjMrV2yRufHCFqXrG7OPvBmX9TWUJo28ajc3PKWDXf32vGkasZ4mWDO o3VGXIbYOh6yITgXgAi4IGaN4wPGNR+oBov6dftiJrKEM4QMiUVWxZUrmoGhIeayE9gf85tQQUEqa7 OThIBTwqxfuld4ijv1ddKjwuct1OuJWmpnlHHtUcePm3v55+1xk4t9bHsgDBMaltUSYdumDiH7tMeh opQMQC1VJLnxDbRbF2ad+YCOlb6guMFIZ9hTYCRvtcczjBO9MTF8jr9EXdiAmC7CuVp7MXoCxu4pXs 0dfScqNYUESIyXzX7PcjFxG5HoRmw/LuSgC7sz8M1EuhxZH7M3v1qI1XWBM1wwX0M83AeeucHL7cqf NGwiZEe7SMLl5AXDBIreLJubYJVTR5zOK++bPKrqXs3nq70qi8FJlkdvHDBce6AK/uCYJlzUZzU9ty 6XPfNbozY/8cV3ylZviAho6ylSPHvAebNfHOk93WYFBFtx9PeuhzFuHGtIr8PtErIQ/wceEmEJZcdk xF9OmWxzAlf9rk0eDXjd5IHhYdPsz2Vypy9anXYJJA1WhYw6UO/S9qUj/lIw==
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


