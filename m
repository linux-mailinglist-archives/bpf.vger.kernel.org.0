Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48614636150
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 15:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiKWORV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 09:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbiKWORN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 09:17:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4162F666;
        Wed, 23 Nov 2022 06:17:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j10-20020a17090aeb0a00b00218dfce36e5so1819789pjz.1;
        Wed, 23 Nov 2022 06:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K2KGPW2mhLmlk+Ll0wyye+i0QvljWWm30P6WzuM3no=;
        b=N4UAbhkQiB0OA8KFPB9vX0y9rfEbsoZVCgvK7W3096l38caZKMdxW/7NHrGYGG4zcr
         ZTNl4GXeMsJ9AzE24RhlR2l4uypbHFeigf384eQQAoK1jWHtLRJUf/5aqNwE/E5zEfFp
         61AoKXLNkiuGrc4+YW8k9PcZd0r0/i0W+xdM667fWOcNwkVdzy7Vu61KiMHw0xcHIbEc
         h4mQsDJUP2kVVDuEVTpSI7HTB6VhUTedMPqSVrGLjZUQvJAnHY0GKNUgmOjFMt21WYfG
         UP7vy4L8A+0qZSap+1jTsGPW6zv5xKWyhE2u3idhDZ1Dl3JDupG55EvljpUOl9Jav2VA
         sGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K2KGPW2mhLmlk+Ll0wyye+i0QvljWWm30P6WzuM3no=;
        b=ujqF/OMpy3UGLXMKncZfVeemgiXB8+iejgxqT7VtZ2pwBz5HulNQgZcJplJHZMBhn7
         vlC9ZgjSah0ysNsL/VKJszxaPnKCPoTgo8r0aV1SKklPweRs4y+uOiXSPLedsQDWfvu/
         LgJAeaj76TRXvZVwnIsqpiykbGplAJ8PzypkWAq8qi+085KO/JWdH6zG6neGjcmkxUnJ
         2SKSt1x2u+5S/1zEU0BdzH3Qx4PW5OAaB/Pqt2lrylF3TRqwWVTGbPEpUpm1Yu7cCDtq
         Vy6y6emdoHG9fQp53s4/h4EkE1FoxNzomXlOsq42/cOfxn+nYKYQ2Gqwi5XUD1BB8MwH
         53sg==
X-Gm-Message-State: ANoB5pkp61w+URFjeWw10zBk++3VMpQUScRJ7skTyq+8IAN2x0OqhzIy
        g8r52GsYsuWMUp+cnd7jA1e2Na57D9mo
X-Google-Smtp-Source: AA0mqf7NlOL7rsXpzY0dhBNYM1nlm50BQNxxVZEBVF3zZVDmQM6HLkzOim/2WFqalsSeLxZbOjj+xQ==
X-Received: by 2002:a17:902:db86:b0:189:4bde:53b9 with SMTP id m6-20020a170902db8600b001894bde53b9mr1838704pld.11.1669213031664;
        Wed, 23 Nov 2022 06:17:11 -0800 (PST)
Received: from pc.localdomain ([166.111.83.15])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001868ed86a95sm14371878plg.174.2022.11.23.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:17:11 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add tests for LDX/STX/ST sanitize
Date:   Wed, 23 Nov 2022 22:15:46 +0800
Message-Id: <20221123141546.238297-4-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123141546.238297-1-sunhao.th@gmail.com>
References: <20221123141546.238297-1-sunhao.th@gmail.com>
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
 .../selftests/bpf/verifier/sanitize_st_ldx.c  | 323 ++++++++++++++++++
 1 file changed, 323 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c

diff --git a/tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c b/tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c
new file mode 100644
index 000000000000..3fd571abc5cc
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c
@@ -0,0 +1,323 @@
+#ifdef CONFIG_BPF_PROG_KASAN
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
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
+	BPF_EMIT_CALL(INSN_IMM_MASK),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
+	BPF_MOV64_REG(BPF_REG_1, MAX_BPF_REG),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_2, -8),
+	},
+},
+#endif /* CONFIG_BPF_PROG_KASAN */
-- 
2.38.1

