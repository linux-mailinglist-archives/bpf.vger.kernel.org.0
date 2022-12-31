Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9370365A5BA
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 17:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiLaQcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 11:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiLaQb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 11:31:58 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674E36250
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bt23so19200643lfb.5
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcePLXV9DuoZADGEcY3cftNpktCb8llbIJlLxvDZUVk=;
        b=NKVRU1Y1+rp0cag+7ky6W1KXVqhA+HuL+sTXHkx2CUZtOmY67S2MZ+ib2Yhm28gmA7
         1hPRqiLDes6yY2XrXdYKjTU8MgVnhoJpVM4wSZXZ83f5IisPhMiwBafoyrqpXuApgVO3
         iCnjLZcLFFwk3XCNexajw+FnEqKkmEarRakAc1O0r96nB4ZstD+DDt/NDO7rN6rIBT7J
         eyk+WKlad+U9ppzXchSpv9POkVnH2D2SGGTLNjTYgYsOjbeWAKo7dhoXF2ukXBtTbsGi
         sgK/G8DeL1gY2ziv2HukrDyxWzHnyUGj1Q4D5T/g4SpBe+oogt2C+CHu0ImPjJ8ITUWc
         jWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcePLXV9DuoZADGEcY3cftNpktCb8llbIJlLxvDZUVk=;
        b=DQLLr3kriHxS1VhIpw3XGNYpsQDMdAlLOq+ZevoWs6YmLcq8TU7lsuiUjEIb2WI2pV
         gmekOX3bj+vKsPCJQYVWRgxmtbhwwYeihKCgL4C2vkWj0kQnWtoH8Tz7IM4VhaW3WQzQ
         jSsXrdOGRxo/6RjCJG1ZnCCWA5P7b1eMkCDQavu3RDn/TrEKzUMT6uCpt/A+zHEfXQip
         hy80pynhl3tKdV2ak/c+SdyeHIO4jdbScvd5Pb6RhmpFDTLwpXK2hGOSxHDpGi1gKohU
         gDRTWxvtcQrJDX0wc62rJiAeJYAc1aYYPnoIgrzkAt2v0B9Kw/egEzyndXCWm+S5Et4X
         WMUQ==
X-Gm-Message-State: AFqh2kpNWnoPX7QRZDcjvAoqxEQO3Kyf5oOmyLDQCHVNo8CbLnPoqzZu
        7SOjmLMEh8DwJDcFAVwVx1cu/mGBciA=
X-Google-Smtp-Source: AMrXdXtO4Nrt56/L4IGJDz+DlOimJJA4i1VMjjDE5eEiHP4G/pdQYq9HszWFk77tT0VVUl5hKGip9w==
X-Received: by 2002:a19:f011:0:b0:4a4:68b7:f895 with SMTP id p17-20020a19f011000000b004a468b7f895mr12553436lfc.57.1672504314406;
        Sat, 31 Dec 2022 08:31:54 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a19e34a000000b004b4930d53b5sm3876784lfk.134.2022.12.31.08.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:31:53 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 1/5] bpf: more precise stack write reasoning for BPF_ST instruction
Date:   Sat, 31 Dec 2022 18:31:18 +0200
Message-Id: <20221231163122.1360813-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231163122.1360813-1-eddyz87@gmail.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
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

For aligned stack writes using BPF_ST instruction track stored values
in a same way BPF_STX is handled, e.g. make sure that the following
commands produce similar verifier knowledge:

  fp[-8] = 42;             r1 = 42;
                       fp[-8] = r1;

This covers two cases:
 - non-null values written to stack are stored as spill of fake
   registers;
 - null values written to stack are stored as STACK_ZERO marks.

Previously both cases above used STACK_MISC marks instead.

Some verifier test cases relied on the old logic to obtain STACK_MISC
marks for some stack values. These test cases are updated in the same
commit to avoid failures during bisect.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                         |  23 +++-
 .../bpf/verifier/bounds_mix_sign_unsign.c     | 110 ++++++++++--------
 2 files changed, 84 insertions(+), 49 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4a25375ebb0d..585edea642e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3257,6 +3257,11 @@ static void save_register_state(struct bpf_func_state *state,
 		scrub_spilled_slot(&state->stack[spi].slot_type[i - 1]);
 }
 
+static bool is_bpf_st_mem(struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_ST && BPF_MODE(insn->code) == BPF_MEM;
+}
+
 /* check_stack_{read,write}_fixed_off functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
@@ -3268,8 +3273,9 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur; /* state of the current function */
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
-	u32 dst_reg = env->prog->insnsi[insn_idx].dst_reg;
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg = NULL;
+	u32 dst_reg = insn->dst_reg;
 
 	err = grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
 	if (err)
@@ -3316,6 +3322,14 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 				return err;
 		}
 		save_register_state(state, spi, reg, size);
+	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
+		   insn->imm != 0 && env->bpf_capable) {
+		struct bpf_reg_state fake_reg = {};
+
+		__mark_reg_known(&fake_reg, (u32)insn->imm);
+		fake_reg.type = SCALAR_VALUE;
+		fake_reg.parent = state->stack[spi].spilled_ptr.parent;
+		save_register_state(state, spi, &fake_reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
@@ -3350,7 +3364,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 
 		/* when we zero initialize stack slots mark them as such */
-		if (reg && register_is_null(reg)) {
+		if ((reg && register_is_null(reg)) ||
+		    (!reg && is_bpf_st_mem(insn) && insn->imm == 0)) {
 			/* backtracking doesn't work for STACK_ZERO yet. */
 			err = mark_chain_precision(env, value_regno);
 			if (err)
@@ -3395,6 +3410,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	int min_off, max_off;
 	int i, err;
 	struct bpf_reg_state *ptr_reg = NULL, *value_reg = NULL;
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	bool writing_zero = false;
 	/* set if the fact that we're writing a zero is used to let any
 	 * stack slots remain STACK_ZERO
@@ -3407,7 +3423,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	max_off = ptr_reg->smax_value + off + size;
 	if (value_regno >= 0)
 		value_reg = &cur->regs[value_regno];
-	if (value_reg && register_is_null(value_reg))
+	if ((value_reg && register_is_null(value_reg)) ||
+	    (!value_reg && is_bpf_st_mem(insn) && insn->imm == 0))
 		writing_zero = true;
 
 	err = grow_stack_state(state, round_up(-min_off, BPF_REG_SIZE));
diff --git a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
index c2aa6f26738b..bf82b923c5fe 100644
--- a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
+++ b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
@@ -1,13 +1,14 @@
 {
 	"bounds checks mixing signed and unsigned, positive bounds",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 2),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 3),
@@ -17,20 +18,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
@@ -40,20 +42,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 2",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
@@ -65,20 +68,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 3",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 4),
@@ -89,20 +93,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 4",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
@@ -112,19 +117,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.result = ACCEPT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 5",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
@@ -135,17 +141,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 6",
 	.insns = {
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -512),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_6, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_6, 5),
@@ -163,13 +172,14 @@
 {
 	"bounds checks mixing signed and unsigned, variant 7",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 1024 * 1024 * 1024),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
@@ -179,19 +189,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.result = ACCEPT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 8",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
@@ -203,20 +214,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 9",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_LD_IMM64(BPF_REG_2, -9223372036854775808ULL),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
@@ -228,19 +240,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.result = ACCEPT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 10",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
@@ -252,20 +265,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 11",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -278,20 +292,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 12",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -6),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -303,20 +318,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 13",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 2),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -331,7 +347,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
@@ -340,13 +356,14 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_MOV64_IMM(BPF_REG_8, 2),
@@ -360,20 +377,21 @@
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, -3),
 	BPF_JMP_IMM(BPF_JA, 0, 0, -7),
 	},
-	.fixup_map_hash_8b = { 4 },
+	.fixup_map_hash_8b = { 6 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 15",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -6),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -387,7 +405,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
-- 
2.39.0

