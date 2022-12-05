Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFADD642102
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 02:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiLEBSU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 20:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiLEBST (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 20:18:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18098658A
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 17:18:17 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v8so13785006edi.3
        for <bpf@vger.kernel.org>; Sun, 04 Dec 2022 17:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIWLwpn2/phOMzqkZBMjrFVSwOXC5bqccqkTPxuHzmY=;
        b=jrlCTKK5qGU+fAMmHF7M8uYdAS4E0+Y1JvPtxMs6sdq6WUsJrNdv1CYpNRhMR6kcwk
         Ksbp/KdMpvIaevPjQj2XSpTjj6UILGCzDXjbG99KAvadOFHPr/Dw1eE8Uh9Gh7tFWhXy
         BhWfooD8elNGBrwauPgl/GSJowUoNSYpmKKGB/r7Ny0jyrHLV/US+bfc3JpGxb+WYwrO
         I58Bo2/GhpP/2VzeyzY1DloVsXaHWbZrDCQAyAcJ5F8SKDcjAaxh+7sbUMtFso/ItMGp
         KHDQC8HtekxXwXWydiFd1XammOYmvV47ARJe1vrNVxn8GgECELpMryjj1NyUY8tryQrz
         9Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIWLwpn2/phOMzqkZBMjrFVSwOXC5bqccqkTPxuHzmY=;
        b=koQxgIsJEEtXXy0U8G05ixe5ZqWNnG1MujDdyLSc4MFpB3F/QieI/ZDOj6JoO/Yvj1
         B0xVn5BCDImam8xgmZhHkmp9edOwGr/lL6IpGkrMNd7VwtvXqKOQGmmJ3Ia3yhgu6s4Y
         JS2YuB0Ff5RWJ1+XnNz0FksKNQCIuoASXQndq0JykDlMsdlitE0vmJV7sSs5/6TW4yw5
         E8YwM04rbVXFHjPKl5MFiw4rUVhzjjVdKvhEufKK/QihRoelAdgfvEF+Qb3bSP8oIHvC
         kK9L1FSTC7MuFu1XOZbcD1B4B1Sf+VunB6bdMRiOcGOfV9m/dneQSu3GlsYpTbu8A4B4
         Ta5g==
X-Gm-Message-State: ANoB5pntbrH4BMFB7P4vuWGwbcSjcuT1aWCTjWkbNzAehY/IxjqWuEgV
        dnKCYzTANW2O1SYzRxV1VFZsO2uyq10=
X-Google-Smtp-Source: AA0mqf7iz8a80Zd/+iIOPrs+Ya9b6Rp95L470p1NBhaNhTLlxznONM2F/5gJZpgFfQm3aG70mekEcw==
X-Received: by 2002:a05:6402:3644:b0:45f:c7f2:297d with SMTP id em4-20020a056402364400b0045fc7f2297dmr73343534edb.266.1670203095337;
        Sun, 04 Dec 2022 17:18:15 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906315200b007b935641971sm5686334eje.5.2022.12.04.17.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:18:15 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix to preserve reg parent/live fields when copying range info
Date:   Mon,  5 Dec 2022 03:17:53 +0200
Message-Id: <20221205011754.310580-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205011754.310580-1-eddyz87@gmail.com>
References: <20221205011754.310580-1-eddyz87@gmail.com>
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
index b0db9c10567b..8b0a03aad85e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3181,13 +3181,24 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
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
 
@@ -3513,7 +3524,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				 */
 				s32 subreg_def = state->regs[dst_regno].subreg_def;
 
-				state->regs[dst_regno] = *reg;
+				copy_register_state(&state->regs[dst_regno], reg);
 				state->regs[dst_regno].subreg_def = subreg_def;
 			} else {
 				for (i = 0; i < size; i++) {
@@ -3534,7 +3545,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 		if (dst_regno >= 0) {
 			/* restore register state from stack */
-			state->regs[dst_regno] = *reg;
+			copy_register_state(&state->regs[dst_regno], reg);
 			/* mark reg as written since spilled pointer state likely
 			 * has its liveness marks cleared by is_state_visited()
 			 * which resets stack/reg liveness for state transitions
@@ -9407,7 +9418,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	 */
 	if (!ptr_is_dst_reg) {
 		tmp = *dst_reg;
-		*dst_reg = *ptr_reg;
+		copy_register_state(dst_reg, ptr_reg);
 	}
 	ret = sanitize_speculative_path(env, NULL, env->insn_idx + 1,
 					env->insn_idx);
@@ -10660,7 +10671,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					 * to propagate min/max range.
 					 */
 					src_reg->id = ++env->id_gen;
-				*dst_reg = *src_reg;
+				copy_register_state(dst_reg, src_reg);
 				dst_reg->live |= REG_LIVE_WRITTEN;
 				dst_reg->subreg_def = DEF_NOT_SUBREG;
 			} else {
@@ -10671,7 +10682,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						insn->src_reg);
 					return -EACCES;
 				} else if (src_reg->type == SCALAR_VALUE) {
-					*dst_reg = *src_reg;
+					copy_register_state(dst_reg, src_reg);
 					/* Make sure ID is cleared otherwise
 					 * dst_reg min/max could be incorrectly
 					 * propagated into src_reg by find_equal_scalars()
@@ -11470,7 +11481,7 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
-			*reg = *known_reg;
+			copy_register_state(reg, known_reg);
 	}));
 }
 
-- 
2.34.1

