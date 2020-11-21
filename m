Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22702BBBB1
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 02:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgKUBzQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 20:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgKUBzQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 20:55:16 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF801C0613CF
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 17:55:15 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 143so9503969qkg.20
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 17:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HgLaALO2LfKwuo/95eztoHPz5vcZScKg8Khd3QE2de8=;
        b=c1VvGFjkEIg9HFK9s2W+CkNI6uUnE+mrwb56Or5gyeSEkjAeXlz+mRtxKqOp0UX/Y+
         cA+OxWmfehUJBkT/TLH0asncWM4zGX1qxaU0N4eUx5Ug2ezkeZJVP1Gnp9GCg8W28iil
         rjWdogxdQGZ/w59RNm3cObmeL8LsjakYrdPBh2ZuDw/wQyejvcauHE5zSXL2Q1QRO/bH
         tZVGth4MsbbEi0Fua0PjnKKV0h3bytVMFb0LWrR3ZO9dOMO1xNhTlEt27PPhHrTdWJtg
         6uaZGBBp8AaNkW2U0jZclPMVvuiJSmbv/V1lwd5v/+QbuRri6O+JyB06uYywxqpez2Pl
         6X+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HgLaALO2LfKwuo/95eztoHPz5vcZScKg8Khd3QE2de8=;
        b=AcacKWgqmiDH/7HX5sSPJytODOycaWned978Vyl0SjqfWClzaGe6+hVKVmvkmYk3Gx
         Fl/mZZV/QRIGiSqoVvL21e+QVRM94lqgV5L/YQWmkyqhju7yDRMhIMyjg6B+ZHuWrpUN
         y0fnRjgHjGRE2jM1cvZyBMfhG/DZIBke13y+6RbH/w9BrP6K5iXfuR3PArmQ3cZg7GbQ
         V9TZLmehuX9XU3NaGKtQ3wlHLcY5vqjl82gmiK4dKl7FaDt4lxwbMSlYoOEPT7yzJaR/
         FqNn+2FZPUvCB+RMao9y/rkh8i6p8s5z08iwI7To/Rj7YmliT3sIvE9+v4rd7+qfJSIX
         2RJw==
X-Gm-Message-State: AOAM532wCxhAtKV41xcR064tWsbja3+vglvcqKi2bva8rQTYXaoeBcmF
        HZNwphZ+zK8rKWH4cPd5cd/rwZfcQf1LnIfLHQINMuRRnvwGbMRYShaurNdCs6Yz5LQKyQXI3Go
        2261pURWSLb8psB/PWpLb+dycGRs7+SqwYbRkSiSkkdK2vsUpsJ2g1/oTGVDPAg==
X-Google-Smtp-Source: ABdhPJxMO5kMjZTYoQIY2xfMIPrWK3/w55mHXRJHCMEz6l0xIxmYkdIfycME5mSOCQuzAR9/E/wvYgF0A6b60w==
Sender: "wedsonaf via sendgmr" <wedsonaf@wedsonaf2.lon.corp.google.com>
X-Received: from wedsonaf2.lon.corp.google.com ([2a00:79e0:d:209:f693:9fff:fef4:38d])
 (user=wedsonaf job=sendgmr) by 2002:a0c:fc52:: with SMTP id
 w18mr19768943qvp.48.1605923714960; Fri, 20 Nov 2020 17:55:14 -0800 (PST)
Date:   Sat, 21 Nov 2020 01:55:09 +0000
Message-Id: <20201121015509.3594191-1-wedsonaf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v2] bpf: Refactor check_cfg to use a structured loop.
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     bpf@vger.kernel.org, daniel@iogearbox.net
Cc:     ast@kernel.org, Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current implementation uses a number of gotos to implement a loop
and different paths within the loop, which makes the code less readable
than it would be with an explicit while-loop. This patch also replaces a
chain of if/if-elses keyed on the same expression with a switch
statement.

No change in behaviour is intended.

Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
---
 kernel/bpf/verifier.c | 179 ++++++++++++++++++++++--------------------
 1 file changed, 95 insertions(+), 84 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb2943ea715d..e333ce43f281 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8047,6 +8047,11 @@ static void init_explored_state(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].prune_point = true;
 }
 
+enum {
+	DONE_EXPLORING = 0,
+	KEEP_EXPLORING = 1,
+};
+
 /* t, w, e - match pseudo-code above:
  * t - index of current instruction
  * w - next instruction
@@ -8059,10 +8064,10 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
 	int *insn_state = env->cfg.insn_state;
 
 	if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
-		return 0;
+		return DONE_EXPLORING;
 
 	if (e == BRANCH && insn_state[t] >= (DISCOVERED | BRANCH))
-		return 0;
+		return DONE_EXPLORING;
 
 	if (w < 0 || w >= env->prog->len) {
 		verbose_linfo(env, t, "%d: ", t);
@@ -8081,10 +8086,10 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
 		if (env->cfg.cur_stack >= env->prog->len)
 			return -E2BIG;
 		insn_stack[env->cfg.cur_stack++] = w;
-		return 1;
+		return KEEP_EXPLORING;
 	} else if ((insn_state[w] & 0xF0) == DISCOVERED) {
 		if (loop_ok && env->bpf_capable)
-			return 0;
+			return DONE_EXPLORING;
 		verbose_linfo(env, t, "%d: ", t);
 		verbose_linfo(env, w, "%d: ", w);
 		verbose(env, "back-edge from insn %d to %d\n", t, w);
@@ -8096,7 +8101,74 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
 		verbose(env, "insn state internal bug\n");
 		return -EFAULT;
 	}
-	return 0;
+	return DONE_EXPLORING;
+}
+
+/* Visits the instruction at index t and returns one of the following:
+ *  < 0 - an error occurred
+ *  DONE_EXPLORING - the instruction was fully explored
+ *  KEEP_EXPLORING - there is still work to be done before it is fully explored
+ */
+static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insns = env->prog->insnsi;
+	int ret;
+
+	/* All non-branch instructions have a single fall-through edge. */
+	if (BPF_CLASS(insns[t].code) != BPF_JMP &&
+	    BPF_CLASS(insns[t].code) != BPF_JMP32)
+		return push_insn(t, t + 1, FALLTHROUGH, env, false);
+
+	switch (BPF_OP(insns[t].code)) {
+	case BPF_EXIT:
+		return DONE_EXPLORING;
+
+	case BPF_CALL:
+		ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
+		if (ret)
+			return ret;
+
+		if (t + 1 < insn_cnt)
+			init_explored_state(env, t + 1);
+		if (insns[t].src_reg == BPF_PSEUDO_CALL) {
+			init_explored_state(env, t);
+			ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
+					env, false);
+		}
+		return ret;
+
+	case BPF_JA:
+		if (BPF_SRC(insns[t].code) != BPF_K)
+			return -EINVAL;
+
+		/* unconditional jump with single edge */
+		ret = push_insn(t, t + insns[t].off + 1, FALLTHROUGH, env,
+				true);
+		if (ret)
+			return ret;
+
+		/* unconditional jmp is not a good pruning point,
+		 * but it's marked, since backtracking needs
+		 * to record jmp history in is_state_visited().
+		 */
+		init_explored_state(env, t + insns[t].off + 1);
+		/* tell verifier to check for equivalent states
+		 * after every call and jump
+		 */
+		if (t + 1 < insn_cnt)
+			init_explored_state(env, t + 1);
+
+		return ret;
+
+	default:
+		/* conditional jump with two edges */
+		init_explored_state(env, t);
+		ret = push_insn(t, t + 1, FALLTHROUGH, env, true);
+		if (ret)
+			return ret;
+
+		return push_insn(t, t + insns[t].off + 1, BRANCH, env, true);
+	}
 }
 
 /* non-recursive depth-first-search to detect loops in BPF program
@@ -8104,11 +8176,10 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
  */
 static int check_cfg(struct bpf_verifier_env *env)
 {
-	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	int *insn_stack, *insn_state;
 	int ret = 0;
-	int i, t;
+	int i;
 
 	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_state)
@@ -8124,92 +8195,32 @@ static int check_cfg(struct bpf_verifier_env *env)
 	insn_stack[0] = 0; /* 0 is the first instruction */
 	env->cfg.cur_stack = 1;
 
-peek_stack:
-	if (env->cfg.cur_stack == 0)
-		goto check_state;
-	t = insn_stack[env->cfg.cur_stack - 1];
-
-	if (BPF_CLASS(insns[t].code) == BPF_JMP ||
-	    BPF_CLASS(insns[t].code) == BPF_JMP32) {
-		u8 opcode = BPF_OP(insns[t].code);
-
-		if (opcode == BPF_EXIT) {
-			goto mark_explored;
-		} else if (opcode == BPF_CALL) {
-			ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
-			if (ret == 1)
-				goto peek_stack;
-			else if (ret < 0)
-				goto err_free;
-			if (t + 1 < insn_cnt)
-				init_explored_state(env, t + 1);
-			if (insns[t].src_reg == BPF_PSEUDO_CALL) {
-				init_explored_state(env, t);
-				ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
-						env, false);
-				if (ret == 1)
-					goto peek_stack;
-				else if (ret < 0)
-					goto err_free;
-			}
-		} else if (opcode == BPF_JA) {
-			if (BPF_SRC(insns[t].code) != BPF_K) {
-				ret = -EINVAL;
-				goto err_free;
-			}
-			/* unconditional jump with single edge */
-			ret = push_insn(t, t + insns[t].off + 1,
-					FALLTHROUGH, env, true);
-			if (ret == 1)
-				goto peek_stack;
-			else if (ret < 0)
-				goto err_free;
-			/* unconditional jmp is not a good pruning point,
-			 * but it's marked, since backtracking needs
-			 * to record jmp history in is_state_visited().
-			 */
-			init_explored_state(env, t + insns[t].off + 1);
-			/* tell verifier to check for equivalent states
-			 * after every call and jump
-			 */
-			if (t + 1 < insn_cnt)
-				init_explored_state(env, t + 1);
-		} else {
-			/* conditional jump with two edges */
-			init_explored_state(env, t);
-			ret = push_insn(t, t + 1, FALLTHROUGH, env, true);
-			if (ret == 1)
-				goto peek_stack;
-			else if (ret < 0)
-				goto err_free;
+	while (env->cfg.cur_stack > 0) {
+		int t = insn_stack[env->cfg.cur_stack - 1];
 
-			ret = push_insn(t, t + insns[t].off + 1, BRANCH, env, true);
-			if (ret == 1)
-				goto peek_stack;
-			else if (ret < 0)
-				goto err_free;
-		}
-	} else {
-		/* all other non-branch instructions with single
-		 * fall-through edge
-		 */
-		ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
-		if (ret == 1)
-			goto peek_stack;
-		else if (ret < 0)
+		ret = visit_insn(t, insn_cnt, env);
+		switch (ret) {
+		case DONE_EXPLORING:
+			insn_state[t] = EXPLORED;
+			env->cfg.cur_stack--;
+			break;
+		case KEEP_EXPLORING:
+			break;
+		default:
+			if (ret > 0) {
+				verbose(env, "visit_insn internal bug\n");
+				ret = -EFAULT;
+			}
 			goto err_free;
+		}
 	}
 
-mark_explored:
-	insn_state[t] = EXPLORED;
-	if (env->cfg.cur_stack-- <= 0) {
+	if (env->cfg.cur_stack < 0) {
 		verbose(env, "pop stack internal bug\n");
 		ret = -EFAULT;
 		goto err_free;
 	}
-	goto peek_stack;
 
-check_state:
 	for (i = 0; i < insn_cnt; i++) {
 		if (insn_state[i] != EXPLORED) {
 			verbose(env, "unreachable insn %d\n", i);
-- 
2.29.2.454.gaff20da3a2-goog

