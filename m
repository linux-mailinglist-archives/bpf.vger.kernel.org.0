Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC202B947D
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 15:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgKSOTh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 09:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgKSOTh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 09:19:37 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A5C0613CF
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 06:19:36 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id n25so2387939edr.20
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 06:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=PpsLAou05C0SJ4KujnRj4DWC8fjxjgJczMpEsUhn3KY=;
        b=edgPCJunThPLS9IqYU5dxfo7kFlN/L5o6g5PS2FAGrnijLyXkOStX0dXXKIsulXgn1
         3whtjne3rhXm93DjS2Xe5PRS4UphOxO6goxqnxgEVMlT5VxKsEs4CChxsmxgJJ2v9iZu
         yDW19pnWMO5feJxyeyYHskbXhSMpzhQskRPE0emsyklDHvL0TDZGJNSboOJk3gym+sjD
         r/r6RocC91HOD8Q4Y8gVxCfccEw0f9xQiQabdroWZM7bS4VZrVKawlJ/EceOq8TAOL5M
         W8EP71vf1Pqt0AbzuaHzQ4oq4vLz4TrMUhxSnGZreZxRI0QLmlS5FXhwRL7v3YoM4GKx
         xx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=PpsLAou05C0SJ4KujnRj4DWC8fjxjgJczMpEsUhn3KY=;
        b=jxMOPYGguIoQu3nj3zdvBaMEloPAQevKTeUpCaRIg0gnBqB6A8OBCy/rJIA0EaOBSV
         UhljmxQKyxSsAIQPNIC1UQ53OTFdINkH6iNvtFSDTM+uEUp84ph8YzQ4aPYRtA3/Pq5g
         FAyPqQAH8rp84W8W+PmbDDo7ANPtZeaAh8Nl199+g/ydT9N83oH4nTTrcIIQnGVlRHRe
         KwCpmYx1MbpseX5mEdVQ42X5qpe4GB9hF2M2BCjP3QkAt1YOZzOovIXX6GEtTwt1bUDe
         dlFwPHwLoQ6Qb80qRhbABfJwhIJkQPGyX3xsCbrwdcyJ5mBkxF3UxWWV8bA+LaPya2kq
         5kkw==
X-Gm-Message-State: AOAM531QrQ/8iV7i4s1R+SfPVMI1aE0BXOEZwbMJ74lc9z/1TPvQmRce
        WLgEFWYZqWxjIp3h88vZUJLXhpnUg38jnB5UfcExPQ5xf/y8OzexbFurJaL4h4MFIgq8GfejLN/
        iMrzHavNVylQxT/8db9NF3JUZJ2s300tKuIS6VPshrJ/zJ2MR6YSUYVeLlRFN1Q==
X-Google-Smtp-Source: ABdhPJzBYQczo8TbVw3ZHckeSbEcV0vzTOkU18fSlw8gnmsnXLKYeXuM5ce7unlCyql54kEA8XT3gVEeuf1Ltg==
Sender: "wedsonaf via sendgmr" <wedsonaf@wedsonaf2.lon.corp.google.com>
X-Received: from wedsonaf2.lon.corp.google.com ([2a00:79e0:d:209:f693:9fff:fef4:38d])
 (user=wedsonaf job=sendgmr) by 2002:aa7:d356:: with SMTP id
 m22mr30753091edr.270.1605795574809; Thu, 19 Nov 2020 06:19:34 -0800 (PST)
Date:   Thu, 19 Nov 2020 14:19:01 +0000
Message-Id: <20201119141901.3176328-1-wedsonaf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH bpf-next] bpf: Refactor check_cfg to use a structured loop.
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     bpf@vger.kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@google.com>
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
 kernel/bpf/verifier.c | 157 +++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 79 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb2943ea715d..5dcdacce35e0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8099,16 +8099,82 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Visits instruction at index t and returns one of the following:
+ *  < 0 - an error occurred
+ *    0 - the instruction was fully explored
+ *  > 0 - there is still work to be done before it is fully explored
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
+		return 0;
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
+}
+
 /* non-recursive depth-first-search to detect loops in BPF program
  * loop == back-edge in directed graph
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
@@ -8124,92 +8190,25 @@ static int check_cfg(struct bpf_verifier_env *env)
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
+		if (ret < 0)
 			goto err_free;
+
+		if (!ret) {
+			insn_state[t] = EXPLORED;
+			env->cfg.cur_stack--;
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
2.29.2.299.gdc1121823c-goog

