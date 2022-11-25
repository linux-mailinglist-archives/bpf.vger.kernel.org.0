Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCA163840F
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 07:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKYGhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 01:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKYGg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 01:36:58 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8362D2A94D;
        Thu, 24 Nov 2022 22:36:54 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q1so3167316pgl.11;
        Thu, 24 Nov 2022 22:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgKC00kdEHyZ2BMxISGOkS8d2W0npo/wh8nj7cf1w34=;
        b=a12nDl9D1CbPueV4YzaLMBHFl44tEKfpy19bep699O5HacSnAmWdbesFzgbz5gCiIq
         KlreKoUI/BMhrGlKscdidLDnfAh75owtsIWG5OeZCiJzJWJMiwQJBZBt9Ef1uxjvGWSm
         xhkmfJJZ9cH0XF1xbY9PPO89MtY+Uaj8NwaUAhbYU5g5BcAy1oySr1Syj7lGefy8jnmj
         5wzbkYpDO16NyKbydsuw84VaQKCfl+DnTJTI6arNvhPVc6ZVHB86ecqAtD6EBdud61iw
         i8Unw39nlRcvhwrUfSZiW2zomgs7DF+C//JqdKhTDbYslAnLrq/4Iy61qXpKUU8tgAKh
         nDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgKC00kdEHyZ2BMxISGOkS8d2W0npo/wh8nj7cf1w34=;
        b=uAprJR9/x2no7FYQL6iYPtNQKLVJxZtdUPPeMg+kBWGXUHTl/95PW599hcILbqvRuH
         fiVYG/FEe23U4nT8H8Fa7WTuVjg6bD6tFXgC3kLefUuDhz5O4XtTXAXxQ0TOG5xsRN80
         bw5ViY170Me9nXIQS20OhsERjig89PXmwmXUwFm889r5JYo6TQBsLMzZyg9dW2q8uh+x
         QoMMPSTn2sLA8g7PxShp4DUGapI/j3jMPTMhMfl+1ZXMs5/CBoxf0kHY4othbk8GaNnb
         UYlqan8jilZCk1oqh/XV3rTtvSesGnTfUpWhoOW2sKWwPWTcTZyEs109UpD/COit3EZx
         0IFA==
X-Gm-Message-State: ANoB5plm8iZYRhfNc3JtO17P/ljyEgxQrKJeuLRGJQ3HZZOd5ibUf+eG
        GtBi/wrvMC6m5o0KWk9UrFRDUJ9sOjtp
X-Google-Smtp-Source: AA0mqf4Yh+x4Z1hZHW72wP736tEQrYj9qiy4J5F3yh1U8pb8AzF8GFYOliRHfrX+0Sv02pjuiZR9UA==
X-Received: by 2002:a63:711e:0:b0:477:5654:c37e with SMTP id m30-20020a63711e000000b004775654c37emr23222471pgc.206.1669358213619;
        Thu, 24 Nov 2022 22:36:53 -0800 (PST)
Received: from pc.localdomain ([166.111.83.15])
        by smtp.gmail.com with ESMTPSA id nm18-20020a17090b19d200b001fd6066284dsm2214891pjb.6.2022.11.24.22.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 22:36:52 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for LDX/STX/ST sanitize
Date:   Fri, 25 Nov 2022 14:36:30 +0800
Message-Id: <20221125063630.536657-4-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125063630.536657-1-sunhao.th@gmail.com>
References: <20221125063630.536657-1-sunhao.th@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests for LDX/STX/ST instrumentation in each possible case.
Four cases for STX/ST, include dst_reg equals to R0, R1, R10,
other regs, respectively, ten cases for LDX. All new/existing
selftests can pass.

A slab-out-of-bounds read report is also availble, which is
achieved by exploiting CVE-2022-23222 and can be reproduced
in Linux v5.10: https://pastebin.com/raw/Ee1Cw492.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 .../selftests/bpf/verifier/sanitize_st_ldx.c  | 362 ++++++++++++++++++
 1 file changed, 362 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c

diff --git a/tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c b/tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c
new file mode 100644
index 000000000000..1db0d1794f29
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c
@@ -0,0 +1,362 @@
+#ifdef CONFIG_BPF_PROG_KASAN
+
+#define __BACKUP_REG(n) \
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_##n, INSN_OFF_MASK)
+#define BACKUP_SCRATCH_REGS                                                 \
+	__BACKUP_REG(1), __BACKUP_REG(2), __BACKUP_REG(3), __BACKUP_REG(4), \
+		__BACKUP_REG(5)
+
+#define __RESTORE_REG(n) \
+	BPF_LDX_MEM(BPF_DW, BPF_REG_##n, BPF_REG_10, INSN_OFF_MASK)
+#define RESTORE_SCRATCH_REGS                                  \
+	__RESTORE_REG(1), __RESTORE_REG(2), __RESTORE_REG(3), \
+		__RESTORE_REG(4), __RESTORE_REG(5)
+
+{
+	"sanitize stx: dst is R1",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, -8, 1),
+	},
+},
+{
+	"sanitize stx: dst is R0",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, MAX_BPF_REG),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, -8, 1),
+	},
+},
+{
+	"sanitize stx: dst is R10",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.unexpected_insns = {
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	},
+},
+{
+	"sanitize stx: dst is other regs",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, MAX_BPF_REG),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 1),
+	},
+},
+{
+	"sanitize ldx: src is R1, dst is R0",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
+	},
+},
+{
+	"sanitize ldx: src is R1, dst is R1",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, -8),
+	},
+},
+{
+	"sanitize ldx: src is R1, dst is other regs",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -8),
+	},
+},
+{
+	"sanitize ldx: src is R0, dst is R1",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, -8),
+	},
+},
+{
+	"sanitize ldx: src is R0, dst is R0",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, -8),
+	},
+},
+{
+	"sanitize ldx: src is R0, dst is other regs",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, -8),
+	},
+},
+{
+	"sanitize ldx: src is other regs, dst is R0",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_1, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, -8),
+	},
+},
+{
+	"sanitize ldx: src is other regs, dst is R1",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -8),
+	},
+},
+{
+	"sanitize ldx: src is other regs, dst is self",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, -8),
+	},
+},
+{
+	"sanitize ldx: src is other regs, dst is other regs",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_2, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
+	BPF_MOV64_REG(BPF_REG_1, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_2, -8),
+	},
+},
+#endif /* CONFIG_BPF_PROG_KASAN */
-- 
2.38.1

