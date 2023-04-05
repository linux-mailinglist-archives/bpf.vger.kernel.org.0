Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12FD6D718F
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjDEAmx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjDEAmv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:42:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B071C4C27
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v1so34546004wrv.1
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIB/I3GNbYx0JLF+VxiO1i4imSSVAVtp1ptB2Nb8FwI=;
        b=C5boSwF67cgMYmyELKNZVAAw/BSWGt7saDRL5pU7V2I7QwYueqlR2QqMuQUTYLXI57
         8i9/dI2HIKh+RRMGZg6UVCJrnTColuuhU49us3KdkRlUMzihDv69nLapkDL7tSmGdyki
         m8TuVOyyQD3VvxUBgDu9C9PVCSQVRJvQi8RaNAu4IFD3OWwmtIbuats+vFTzKf6nu5yq
         giKV35IQx57wEp9T3FCDO9a2puovbv4VFlxQ+pG5iP+d/CmBAjQVN3dLj0QJsL6QOQB1
         6ZhC5HncJXmX/FNG+imQsSWo6BLcFYDcZLUWAVjSoWauKwVdKBqNXwB+A2We1NEEMy+0
         lweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIB/I3GNbYx0JLF+VxiO1i4imSSVAVtp1ptB2Nb8FwI=;
        b=JQGndSgD6hE5F4acIwMb022qTdHWPcy3H90ZsatdgItqvyDIxL2e+An8UMLLt+/1jM
         1TCdy/JcFDZCrxPoUyLtFU0xQF6AJHbj6oDHLUq6P7nNq8VoJ6Or2ZuULn8s0cQKHhx7
         M6tpwq0D+5cMKdgadYzcOTIcSUQi829ujVjuVZvq6J5MJoslu8q6D52Cssr2RS11bYpX
         lhTLgnI04xH8F6FySbQ4wS2W2HTtINmAIrQSdeao0+HQcWXuCpig2mWP0Q65voCyEJtb
         1eRUNVYZunCacROnNyvjOPbXx6MOF2DodMXi44Lqe7ggcZao9qY4zxpIDrgF5FQoeRu+
         NjUQ==
X-Gm-Message-State: AAQBX9dWFJsH5du3GDWdYtD11xkOPGEct8nKA4uU63BYK7obh5BIUKLo
        YUGIaZcszK+ehCk1LwD89frIHmnAZtvjJg==
X-Google-Smtp-Source: AKy350Zr4oqPySWFBa0YgDsWSPgtS2c9iM1JebUCZVWBPUZeiSIOBkRD9xSSj4IDoWUkt4ANGKwlwg==
X-Received: by 2002:adf:f18d:0:b0:2d8:5df8:4566 with SMTP id h13-20020adff18d000000b002d85df84566mr2847204wro.8.1680655364362;
        Tue, 04 Apr 2023 17:42:44 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id k12-20020adfe8cc000000b002c7b229b1basm13493543wrn.15.2023.04.04.17.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:43 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 2/9] bpf: Refactor and generalize optimize_bpf_loop
Date:   Wed,  5 Apr 2023 02:42:32 +0200
Message-Id: <20230405004239.1375399-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405004239.1375399-1-memxor@gmail.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4433; i=memxor@gmail.com; h=from:subject; bh=o1zqDrct7u9UCLa1J6knNQC28LaF6jwE6l5uY8hzS4U=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPvDtsmbDZNupzG7kdgFuaPCJsFZ6ZMYusS5 6tArT0N9zOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD7wAKCRBM4MiGSL8R yghtEACm9U5zFQkoQhbzjokoqyXw1GRpVKPy9PrdApwMm+HLvv4EXcNkwlVS+H9XEPghVPspQ89 o/rmUUdmxk9TQZgnkUHlAHIwpscM2rx0gaZFCcZj4lRP+v841q1Ri7nYtbp9gRMLaAYtz12ZuO3 XkJpZ1M7O16Ifkp81Wsl81h1aWQQSzgv7qcoKkCnkyUkGV7CbIIMi3dJLn9QBiyFu7yGWD7LHKc SIYRSLznTGDUqajJIM0/+iHO3fl7EnQy4K0EJd1QjSIO+Nvz9Dm2vD3BTlfJ5wNnpm1n6ApO4a7 HxNupU314UYsgnqScFzUXmDiYLMuBS0py67LjT6PG9HQUcXfBOcHBsIV2wGqVtcLoX3hmLdinIh +mCMb6VVPkrPyuzW6wofBSdCbrltawaGkneiWI/uQWhbeQGv0WTHvY6LJ8ZCD3H1Q+V8mSteVDw jk02ia/g57QVplEnoAXURNf6CBkbldz8/CeS6Mn1whjNLwZbktdy8zpa0dVdzWBkgvZsBgTo5iH skybn0CozfmZK5vwtt5Vp4Wbe4irJ9elayHaPdZFQ2nsJpL9SzYbNCWGW2gAJQwswmGcjK3FWUD FRgVvE9rbB6P7TE8DsBGJ7rmXU4Jb6ETVqfMZabOg+RutlBWXJejPCKVU48vRSsIlQQ3i6wcWqm 9L2K/0ws0gU9ywQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The optimize_bpf_loop pass is currently used to transform calls to the
bpf_loop helper function into an inlined instruction sequence which
elides the helper call and does the looping directly and emits the call
to the loop callback.

The future patches for exception propagation for BPF programs will
require similar rewriting which needs access to extra stack space to
spill registers which may be clobbered in the emitted sequence.

We wish to reuse the logic of updating subprog stack depth by tracking
the extra stack depth needed across all rewrites in a subprog in
subseqeunt patches. Hence, refactor the code to make it amenable for
plugging extra rewrite passes over other instructions. Note that the
stack_depth_extra is now set by a max of existing and required extra
stack depth. This allows rewrites to reuse the extra stack depth among
themselves, by figuring the maximum depth needed for a subprog.

Note that we only do one rewrite in one loop iteration, and thus
new_prog is set only once. This can be used to pull out shared updates
of delta, env->prog, etc. into common code that occurs after all cases
of possible rewrites are examined, and if application, performed.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 693aeddc9fe2..8ecd5df73b07 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18024,23 +18024,26 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	return new_prog;
 }
 
-static bool is_bpf_loop_call(struct bpf_insn *insn)
+static bool is_inlineable_bpf_loop_call(struct bpf_insn *insn,
+					struct bpf_insn_aux_data *aux)
 {
 	return insn->code == (BPF_JMP | BPF_CALL) &&
 		insn->src_reg == 0 &&
-		insn->imm == BPF_FUNC_loop;
+		insn->imm == BPF_FUNC_loop &&
+		aux->loop_inline_state.fit_for_inline;
 }
 
 /* For all sub-programs in the program (including main) check
- * insn_aux_data to see if there are bpf_loop calls that require
- * inlining. If such calls are found the calls are replaced with a
+ * insn_aux_data to see if there are any instructions that need to be
+ * transformed into an instruction sequence. E.g. bpf_loop calls that
+ * require inlining. If such calls are found the calls are replaced with a
  * sequence of instructions produced by `inline_bpf_loop` function and
  * subprog stack_depth is increased by the size of 3 registers.
  * This stack space is used to spill values of the R6, R7, R8.  These
  * registers are used to store the loop bound, counter and context
  * variables.
  */
-static int optimize_bpf_loop(struct bpf_verifier_env *env)
+static int do_misc_rewrites(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	int i, cur_subprog = 0, cnt, delta = 0;
@@ -18051,13 +18054,14 @@ static int optimize_bpf_loop(struct bpf_verifier_env *env)
 	u16 stack_depth_extra = 0;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
-		struct bpf_loop_inline_state *inline_state =
-			&env->insn_aux_data[i + delta].loop_inline_state;
+		struct bpf_insn_aux_data *insn_aux = &env->insn_aux_data[i + delta];
+		struct bpf_prog *new_prog = NULL;
 
-		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) {
-			struct bpf_prog *new_prog;
+		if (is_inlineable_bpf_loop_call(insn, insn_aux)) {
+			struct bpf_loop_inline_state *inline_state = &insn_aux->loop_inline_state;
 
-			stack_depth_extra = BPF_REG_SIZE * 3 + stack_depth_roundup;
+			stack_depth_extra = max_t(u16, stack_depth_extra,
+						  BPF_REG_SIZE * 3 + stack_depth_roundup);
 			new_prog = inline_bpf_loop(env,
 						   i + delta,
 						   -(stack_depth + stack_depth_extra),
@@ -18065,7 +18069,9 @@ static int optimize_bpf_loop(struct bpf_verifier_env *env)
 						   &cnt);
 			if (!new_prog)
 				return -ENOMEM;
+		}
 
+		if (new_prog) {
 			delta     += cnt - 1;
 			env->prog  = new_prog;
 			insn       = new_prog->insnsi + i + delta;
@@ -18876,7 +18882,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 
 	/* instruction rewrites happen after this point */
 	if (ret == 0)
-		ret = optimize_bpf_loop(env);
+		ret = do_misc_rewrites(env);
 
 	if (is_priv) {
 		if (ret == 0)
-- 
2.40.0

