Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83A6971B8
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjBNXVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBNXVA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:21:00 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5114923105
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:20:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so252009wmb.5
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgR2u1ypKMg8oEEjeaWVB4G1SOPpVHzWsaoDsQQbk0E=;
        b=flVqxxONYsTU7PftaEax/UExDmAPeMdrFmPwcG/uRthHSq3wwj5SNhmH8IP/ZGFvIy
         uxFXwkLtv8aRcvJ01CD9QayBgbUY7Ymxh3xIWBBlXiukI3c41MBrutA6tBi07OdhyLY+
         cKTfMvJKtU+HTjFFZMomiYKRGjEO6oqnciA6sptmyT5xDCg/4RF+C1hRQM/Je+W9YxfG
         rj5oUJnFk9kAxNPljQQP8fkoFrjX8WMnoEd7CLD3dpUhiY22upQbI9Ng4zFwCw+qWcGd
         W8sMTaf9zMXjyRWQC0fqOT0UL/CyMzgyZS2Kypce7jIF7MZQBfcq4xdeRwcu9UclaNZD
         P3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgR2u1ypKMg8oEEjeaWVB4G1SOPpVHzWsaoDsQQbk0E=;
        b=cMqKGcLDhxuxJvRUZwkWJlI/rRKJBTFS5X857fFokeGEHy1t7UAP3jrTOiKgHYgAuM
         iuSfjeMeVEZl5PcPh8YHGMGny5MH0IxEashXLY0N73iaASch8lxCSHOMMekHNuLCD47b
         4Kv84ZKsFJEfSjyflK6OtL6JQW6PbNM1lrTnaam+WhEBS3OlfIEmFHtUN/zf/wWuTEMA
         /1NZvK+Bg9l5QE3TDf0jyPr4+30DtrrQvKyCfNItefKJXYHWDGg8Qlud8OMD9Sr6kWrS
         2EGyTUNGsERQDTuMksFfb++wTJdMnUsM8uvcLUHhLxfDtpw+3Ws3nKXjDx7iQ25etMo6
         PTcw==
X-Gm-Message-State: AO0yUKU2VNeOfAHhNc2JRXHEbCcnWRswtu8nlhcvBPYE6v29FzpDRJW3
        s4lo9VfMuwa8Yt8HrfMv7QzQvUfdlx6BFQ==
X-Google-Smtp-Source: AK7set+YoOSB8YPV+A8SwQ1rGb+Qz2jtt9LyZIKh+ikEBiZWPliExKssZkCNim70qgWTniBgT7vFKg==
X-Received: by 2002:a05:600c:4d92:b0:3e1:577:80f4 with SMTP id v18-20020a05600c4d9200b003e1057780f4mr417473wmp.18.1676416856562;
        Tue, 14 Feb 2023 15:20:56 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003b47b80cec3sm168515wmb.42.2023.02.14.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:20:56 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, jose.marchesi@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/4] bpf: track immediate values written to stack by BPF_ST instruction
Date:   Wed, 15 Feb 2023 01:20:27 +0200
Message-Id: <20230214232030.1502829-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214232030.1502829-1-eddyz87@gmail.com>
References: <20230214232030.1502829-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
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
 kernel/bpf/verifier.c                         |  18 ++-
 .../bpf/verifier/bounds_mix_sign_unsign.c     | 110 ++++++++++--------
 2 files changed, 80 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21e08c111702..c28afae60874 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3473,6 +3473,11 @@ static void save_register_state(struct bpf_func_state *state,
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
@@ -3484,8 +3489,9 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur; /* state of the current function */
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
-	u32 dst_reg = env->prog->insnsi[insn_idx].dst_reg;
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg = NULL;
+	u32 dst_reg = insn->dst_reg;
 
 	err = grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
 	if (err)
@@ -3538,6 +3544,13 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 				return err;
 		}
 		save_register_state(state, spi, reg, size);
+	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
+		   insn->imm != 0 && env->bpf_capable) {
+		struct bpf_reg_state fake_reg = {};
+
+		__mark_reg_known(&fake_reg, (u32)insn->imm);
+		fake_reg.type = SCALAR_VALUE;
+		save_register_state(state, spi, &fake_reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
@@ -3572,7 +3585,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 
 		/* when we zero initialize stack slots mark them as such */
-		if (reg && register_is_null(reg)) {
+		if ((reg && register_is_null(reg)) ||
+		    (!reg && is_bpf_st_mem(insn) && insn->imm == 0)) {
 			/* backtracking doesn't work for STACK_ZERO yet. */
 			err = mark_chain_precision(env, value_regno);
 			if (err)
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
2.39.1

