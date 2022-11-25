Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691606389C6
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKYM3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 07:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKYM3h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 07:29:37 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903CE4A5B0;
        Fri, 25 Nov 2022 04:29:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w23so3854634ply.12;
        Fri, 25 Nov 2022 04:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xh9LbtZzqm4dkobqZjAtGb2NHj8Qkn7BN/d8Dnlu+8=;
        b=BogLWBOfmrcP4qPaqILrhcroXBtG0tR+l9DpJGue32XeB3EKciXk/QuakkdtV33589
         91HOrREnWQDErMiWy20/isCohmyRDBbXjfMvV0XDy7vv3b5z9DWtjRSCL1f0JMsY+MHD
         qWxSooxQPPCIp6L11tAlikcy+MfieG6QIymf15GDz/aSdxhfdtZZ8ewQYlwKMi1q7IaC
         IUT0/0rnSChMlFy0h9TwOZRy45IdNGXemXCKvzRolR038Fq83C6OY2OiGLvsY4vkJvfl
         3hWkVCkTJvYaDjra+MaF1/++zgS1RmRNbgmYVh2Hh7r4EROmGuKxL9Url+Jj1nGGbeQO
         hhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xh9LbtZzqm4dkobqZjAtGb2NHj8Qkn7BN/d8Dnlu+8=;
        b=j0k/zuorYMSGYeAofE9dKxuhu1IJD7IN4VLcYuMoHgJrvLCNi0sl0MMZF78m/sxXBY
         E/ciep0AxYmyidmIqGy7blPsIymxicBn2CyiBkKwbYE6mwrucekqTTBq0C7leBsbkXSB
         /we5PhuFokHk/lTONviSJllLjp1iA84C+PZGsYzW/71+0lSDrLNz3FODkYXpIkUXiDGa
         /m1tUhLBA2l6rG3LICCwUaTw7Pp+SGTd6cG2rILnoWVsMexUEUltArNbcGCvX9FgHx6N
         y3yQ9kxIFw7HmqN7ZBsLtgmq5HGbQ1GXF5Q9XCGidzOoKI2ude/sZWOED5SKvcTrDNvm
         Jktw==
X-Gm-Message-State: ANoB5pm5I7osrGg+iYC9dyF1VzPGqo8lTLt1tc1xHLhWCiSVR2omMRjR
        L5ImG/Nnr6sLJsW2nWr7zGTLbNFoUenQ
X-Google-Smtp-Source: AA0mqf6HCT7Hp6y2mnKkyvWCRquS9hGVIlKeWmYQlQkdhYseADgJDjmFIZJzGzpsEYZnO5kytOBBtA==
X-Received: by 2002:a17:90b:3c42:b0:218:8186:ef9b with SMTP id pm2-20020a17090b3c4200b002188186ef9bmr37685657pjb.10.1669379375701;
        Fri, 25 Nov 2022 04:29:35 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b0018912c37c8fsm117009pla.129.2022.11.25.04.29.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Nov 2022 04:29:35 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for LDX/STX/ST sanitize
Date:   Fri, 25 Nov 2022 20:29:12 +0800
Message-Id: <20221125122912.54709-4-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221125122912.54709-1-sunhao.th@gmail.com>
References: <20221125122912.54709-1-sunhao.th@gmail.com>
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
Five cases for STX/ST, nice cases for LDX. All new/existing
selftests can pass.

A slab-out-of-bounds read report is also availble, which is
achieved by exploiting CVE-2022-23222 and can be reproduced
in Linux v5.10: https://pastebin.com/raw/Ee1Cw492

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 .../selftests/bpf/verifier/sanitize_st_ldx.c  | 317 ++++++++++++++++++
 1 file changed, 317 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c

diff --git a/tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c b/tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c
new file mode 100644
index 000000000000..dfd53f97eb95
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c
@@ -0,0 +1,317 @@
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
+	"sanitize stx: dst is R1, off is zero",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 1),
+	},
+},
+{
+	"sanitize stx: dst is R1",
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
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, -8, 1),
+	},
+},
+{
+	"sanitize stx: dst is other regs, off is zero",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 1),
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
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, -8, 1),
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
+	"sanitize ldx: src is R1, dst is R0, off is zero",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BACKUP_SCRATCH_REGS,
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
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
+	BACKUP_SCRATCH_REGS,
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8),
+	},
+},
+{
+	"sanitize ldx: src is R1, dst is others, off is zero",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
+	},
+},
+{
+	"sanitize ldx: src is R1, dst is others",
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
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, -8),
+	},
+},
+{
+	"sanitize ldx: src is others, dst is R0, off is zero",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0),
+	},
+},
+{
+	"sanitize ldx: src is others, dst is R0",
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
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, -8),
+	},
+},
+{
+	"sanitize ldx: src is others, dst is others, off is zero",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+	.expected_insns = {
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, 0),
+	},
+},
+{
+	"sanitize ldx: src is others, dst is others",
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
+	BACKUP_SCRATCH_REGS,
+	BPF_MOV64_REG(MAX_BPF_REG, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	RESTORE_SCRATCH_REGS,
+	BPF_MOV64_REG(BPF_REG_0, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -8),
+	},
+},
+{
+	"sanitize LDX: SRC is R10",
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
+#endif /* CONFIG_BPF_PROG_KASAN */
-- 
2.38.1

