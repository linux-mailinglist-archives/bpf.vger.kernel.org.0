Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB753660201
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 15:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAFOWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 09:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAFOWc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 09:22:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD2A7BDDA
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 06:22:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jo4so3766266ejb.7
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgrfc5my/seI8n0BiWaC75Jyi2OeaS7puLTxUL3n+1c=;
        b=qpEbR8TmzjOPaiNnyW4ZesBvfTejlRJkAXYg2agd/e+xpZbiLMnobMBlZxvuZYxiJH
         bWKz8IfUHE2UZYDEThGoKAYy1m7XyjUbgnUCSlPebujGgkZUNpScAp9lG+L5W94WD1HQ
         Hwe+Vw1IPh0BJtSFsOQ2a5JVfLLVDvaTOuuO/9hHeqhzm2EQhc0qecXhlf2yH4nahvaG
         HZM7+wUKq51kU+ihz3X4da6Swdc3WDjJakojXWJzH7t/THn1hT1o8YesOaxA56MgCFCc
         n+TwMEHCGznl91/I/YHSQVecNAiLt5Td5Sbm+sJaoHo22tcNMOufHqjHbQQ+oa8GRKJD
         xOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qgrfc5my/seI8n0BiWaC75Jyi2OeaS7puLTxUL3n+1c=;
        b=eEYAP4SQPJvQe014DJZz80FaPoufF+DEJK0PhW7mlLlHJZ3sq7lsTNe6B8mcpzDL+4
         T4906FDJLbOCFapK8yK9jsiqagbNzG7hdjLDRwm7dPIZTM1Fq20eUgPYeCscyLTv3xPH
         XMETHMagYqZpho9bJZZspuSYyE3ltneORLKQzVCx6v2/8UozLaEqpCi6UuA4njRQU7tK
         HiqAmtTTwDjzWdl5kUO2q40VYBsPTBbt/QZIdQrGN52bB9Wz+4H2RwuANZ3H6EhIH19L
         cIvs+e6j4sCMeofk2iFWu8o7nbnDtu8dqZybn2nH/aPiRu3Bbm1P+GGdXfWGGHfdv257
         gDkA==
X-Gm-Message-State: AFqh2kp/0pwi5FIp6C9iZ7/nzhtATWdzzChI9p+y9xRiNzhaaF0HFf2f
        DRwfARWuJ8/5KYV91kejMT3u1SLMo/U=
X-Google-Smtp-Source: AMrXdXvNlxKnfNU0Q22vSR2f41fYaBuoOWwyqNjiREghiBRq9SLdvKo3BgAz7VsVLTh8QfqNDhIN7A==
X-Received: by 2002:a17:906:8492:b0:7c0:f118:7e51 with SMTP id m18-20020a170906849200b007c0f1187e51mr41574707ejx.38.1673014949920;
        Fri, 06 Jan 2023 06:22:29 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b007bdc2de90e6sm446730ejc.42.2023.01.06.06.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 06:22:29 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Fix to preserve reg parent/live fields when copying range info
Date:   Fri,  6 Jan 2023 16:22:13 +0200
Message-Id: <20230106142214.1040390-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106142214.1040390-1-eddyz87@gmail.com>
References: <20230106142214.1040390-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Register range information is copied in several places. The intent is
to transfer range/id information from one register/stack spill to
another. Currently this is done using direct register assignment, e.g.:

static void find_equal_scalars(..., struct bpf_reg_state *known_reg)
{
	...
	struct bpf_reg_state *reg;
	...
			*reg = *known_reg;
	...
}

However, such assignments also copy the following bpf_reg_state fields:

struct bpf_reg_state {
	...
	struct bpf_reg_state *parent;
	...
	enum bpf_reg_liveness live;
	...
};

Copying of these fields is accidental and incorrect, as could be
demonstrated by the following example:

     0: call ktime_get_ns()
     1: r6 = r0
     2: call ktime_get_ns()
     3: r7 = r0
     4: if r0 > r6 goto +1             ; r0 & r6 are unbound thus generated
                                       ; branch states are identical
     5: *(u64 *)(r10 - 8) = 0xdeadbeef ; 64-bit write to fp[-8]
    --- checkpoint ---
     6: r1 = 42                        ; r1 marked as written
     7: *(u8 *)(r10 - 8) = r1          ; 8-bit write, fp[-8] parent & live
                                       ; overwritten
     8: r2 = *(u64 *)(r10 - 8)
     9: r0 = 0
    10: exit

This example is unsafe because 64-bit write to fp[-8] at (5) is
conditional, thus not all bytes of fp[-8] are guaranteed to be set
when it is read at (8). However, currently the example passes
verification.

First, the execution path 1-10 is examined by verifier.
Suppose that a new checkpoint is created by is_state_visited() at (6).
After checkpoint creation:
- r1.parent points to checkpoint.r1,
- fp[-8].parent points to checkpoint.fp[-8].
At (6) the r1.live is set to REG_LIVE_WRITTEN.
At (7) the fp[-8].parent is set to r1.parent and fp[-8].live is set to
REG_LIVE_WRITTEN, because of the following code called in
check_stack_write_fixed_off():

static void save_register_state(struct bpf_func_state *state,
				int spi, struct bpf_reg_state *reg,
				int size)
{
	...
	state->stack[spi].spilled_ptr = *reg;  // <--- parent & live copied
	if (size == BPF_REG_SIZE)
		state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
	...
}

Note the intent to mark stack spill as written only if 8 bytes are
spilled to a slot, however this intent is spoiled by a 'live' field copy.
At (8) the checkpoint.fp[-8] should be marked as REG_LIVE_READ but
this does not happen:
- fp[-8] in a current state is already marked as REG_LIVE_WRITTEN;
- fp[-8].parent points to checkpoint.r1, parentage chain is used by
  mark_reg_read() to mark checkpoint states.
At (10) the verification is finished for path 1-10 and jump 4-6 is
examined. The checkpoint.fp[-8] never gets REG_LIVE_READ mark and this
spill is pruned from the cached states by clean_live_states(). Hence
verifier state obtained via path 1-4,6 is deemed identical to one
obtained via path 1-6 and program marked as safe.

Note: the example should be executed with BPF_F_TEST_STATE_FREQ flag
set to force creation of intermediate verifier states.

This commit revisits the locations where bpf_reg_state instances are
copied and replaces the direct copies with a call to a function
copy_register_state(dst, src) that preserves 'parent' and 'live'
fields of the 'dst'.

Fixes: 679c782de14b ("bpf/verifier: per-register parent pointers")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa4c911603e9..949bac28e9fa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3241,13 +3241,24 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	return reg->type != SCALAR_VALUE;
 }
 
+/* Copy src state preserving dst->parent and dst->live fields */
+static void copy_register_state(struct bpf_reg_state *dst, const struct bpf_reg_state *src)
+{
+	struct bpf_reg_state *parent = dst->parent;
+	enum bpf_reg_liveness live = dst->live;
+
+	*dst = *src;
+	dst->parent = parent;
+	dst->live = live;
+}
+
 static void save_register_state(struct bpf_func_state *state,
 				int spi, struct bpf_reg_state *reg,
 				int size)
 {
 	int i;
 
-	state->stack[spi].spilled_ptr = *reg;
+	copy_register_state(&state->stack[spi].spilled_ptr, reg);
 	if (size == BPF_REG_SIZE)
 		state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 
@@ -3573,7 +3584,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				 */
 				s32 subreg_def = state->regs[dst_regno].subreg_def;
 
-				state->regs[dst_regno] = *reg;
+				copy_register_state(&state->regs[dst_regno], reg);
 				state->regs[dst_regno].subreg_def = subreg_def;
 			} else {
 				for (i = 0; i < size; i++) {
@@ -3594,7 +3605,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 		if (dst_regno >= 0) {
 			/* restore register state from stack */
-			state->regs[dst_regno] = *reg;
+			copy_register_state(&state->regs[dst_regno], reg);
 			/* mark reg as written since spilled pointer state likely
 			 * has its liveness marks cleared by is_state_visited()
 			 * which resets stack/reg liveness for state transitions
@@ -9590,7 +9601,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	 */
 	if (!ptr_is_dst_reg) {
 		tmp = *dst_reg;
-		*dst_reg = *ptr_reg;
+		copy_register_state(dst_reg, ptr_reg);
 	}
 	ret = sanitize_speculative_path(env, NULL, env->insn_idx + 1,
 					env->insn_idx);
@@ -10843,7 +10854,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					 * to propagate min/max range.
 					 */
 					src_reg->id = ++env->id_gen;
-				*dst_reg = *src_reg;
+				copy_register_state(dst_reg, src_reg);
 				dst_reg->live |= REG_LIVE_WRITTEN;
 				dst_reg->subreg_def = DEF_NOT_SUBREG;
 			} else {
@@ -10854,7 +10865,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						insn->src_reg);
 					return -EACCES;
 				} else if (src_reg->type == SCALAR_VALUE) {
-					*dst_reg = *src_reg;
+					copy_register_state(dst_reg, src_reg);
 					/* Make sure ID is cleared otherwise
 					 * dst_reg min/max could be incorrectly
 					 * propagated into src_reg by find_equal_scalars()
@@ -11653,7 +11664,7 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
-			*reg = *known_reg;
+			copy_register_state(reg, known_reg);
 	}));
 }
 
-- 
2.39.0

