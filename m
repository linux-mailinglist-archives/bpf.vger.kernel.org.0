Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB86543CD5
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiFHT1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 15:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiFHT1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 15:27:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF33015C8BF
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 12:27:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 25so28149543edw.8
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+24tkYwWJgfFalW5Huhkg+2fHTCWy4e1MbdchSU04T8=;
        b=JhP35WWa/qaly1ajTPy5nQKh6vKetan0yHJ58N4YtpU+OuAAGx2iSEb0TmrZf0sFC3
         +Jgorj7FZODuFxXYj1Yk68NnadrBXeahhKTQ3C617cHR5r/yMC7F+K3btll16mVbMNzC
         pAIQXksAJJD74MfMZx4bbjoA+YQHjxyZrewM/h/XqSzPK5DbyJ/9QsV7Gmd26RD0AOxO
         jUqvPjj9BKoqxdqWlE8RqxpCnobLNfm67hdmgaSA3DCQbWC4GNlAI19wpavxQWRD0xSa
         RsGHMsMemMCtdiZHLQeT8p5TfNRSFqReYbkF58L8khbwC7CG4s1/KHABhSpvct7Bp1yd
         43Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+24tkYwWJgfFalW5Huhkg+2fHTCWy4e1MbdchSU04T8=;
        b=WRhrcbOsdI1WHds7TDql7tZ5L+kumUOso5OX7LeY1KYmXJEvaZdlN1MJrbK6OCUKNh
         usvwtz52YVrm3g7jP0y9ZJmrpz+bfNeOe1FJ14Ufg6p1e7CnG4BNrG6N1JB5srkjBugT
         oMzO2f3nBEQK5RSnwgoFYBBy89eOj/QDcC6bQzN5/GLOkNamRExJ0tYujDPJyi/xzYLN
         ivWGIvedPGIDrmyMXZd25aZjI55vRAB7FUxaDqnl+rMNj8PeAFwIxkyQxc/j0kcegsr0
         IQqIw1g+APr+PZV/yyzoHzJph33JtM9FdAaSM7cCJosjSiFe8UCRxjspFZC7J5b9dPRh
         ObJQ==
X-Gm-Message-State: AOAM532Bv1NAtzX7EA39MuZ2M9rHtJGKR+w4mZyDZm3Ib2QYun2+QY2z
        AaDEnMAQUkPD0OIdZiJFolg5e6vmliKkVg==
X-Google-Smtp-Source: ABdhPJyQcvtvQTuwHZNS7XU5t4kLk9JL67LgUyORYmyu4LPi6/omYpOpdzHJXly/tojYQBtMeIo2aA==
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id b14-20020a056402350e00b0042fb2c19393mr30663214edd.11.1654716461990;
        Wed, 08 Jun 2022 12:27:41 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906600900b006fec8e5b8a9sm9596730ejj.152.2022.06.08.12.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 12:27:41 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v4 4/5] selftests/bpf: BPF test_verifier selftests for bpf_loop inlining
Date:   Wed,  8 Jun 2022 22:26:29 +0300
Message-Id: <20220608192630.3710333-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608192630.3710333-1-eddyz87@gmail.com>
References: <20220608192630.3710333-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A number of test cases for BPF selftests test_verifier to check how
bpf_loop inline transformation rewrites the BPF program. The following
cases are covered:
 - happy path
 - no-rewrite when flags is non-zero
 - no-rewrite when callback is non-constant
 - subprogno in insn_aux is updated correctly when dead sub-programs
   are removed
 - check that correct stack offsets are assigned for spilling of R6-R8
   registers

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 244 ++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c

diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
new file mode 100644
index 000000000000..d1fbcfef69f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
@@ -0,0 +1,244 @@
+#define BTF_TYPES \
+	.btf_strings = "\0int\0i\0ctx\0callback\0main\0", \
+	.btf_types = { \
+	/* 1: int   */ BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4), \
+	/* 2: int*  */ BTF_PTR_ENC(1), \
+	/* 3: void* */ BTF_PTR_ENC(0), \
+	/* 4: int __(void*) */ BTF_FUNC_PROTO_ENC(1, 1), \
+		BTF_FUNC_PROTO_ARG_ENC(7, 3), \
+	/* 5: int __(int, int*) */ BTF_FUNC_PROTO_ENC(1, 2), \
+		BTF_FUNC_PROTO_ARG_ENC(5, 1), \
+		BTF_FUNC_PROTO_ARG_ENC(7, 2), \
+	/* 6: main      */ BTF_FUNC_ENC(20, 4), \
+	/* 7: callback  */ BTF_FUNC_ENC(11, 5), \
+	BTF_END_RAW \
+	}
+
+#define MAIN_TYPE	6
+#define CALLBACK_TYPE	7
+
+/* can't use BPF_CALL_REL, jit_subprogs adjusts IMM & OFF
+ * fields for pseudo calls
+ */
+#define PSEUDO_CALL_INSN() \
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, \
+		     INSN_OFF_MASK, INSN_IMM_MASK)
+
+/* can't use BPF_FUNC_loop constant,
+ * do_mix_fixups adjusts the IMM field
+ */
+#define HELPER_CALL_INSN() \
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, INSN_OFF_MASK, INSN_IMM_MASK)
+
+{
+	"inline simple bpf_loop call",
+	.insns = {
+	/* main */
+	/* force verifier state branching to verify logic on first and
+	 * subsequent bpf_loop insn processing steps
+	 */
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 2),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
+
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = { PSEUDO_CALL_INSN() },
+	.unexpected_insns = { HELPER_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.runs = 0,
+	.func_info = { { 0, MAIN_TYPE }, { 12, CALLBACK_TYPE } },
+	.func_info_cnt = 2,
+	BTF_TYPES
+},
+{
+	"don't inline bpf_loop call, flags non-zero",
+	.insns = {
+	/* main */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 1),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = { HELPER_CALL_INSN() },
+	.unexpected_insns = { PSEUDO_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.runs = 0,
+	.func_info = { { 0, MAIN_TYPE }, { 8, CALLBACK_TYPE } },
+	.func_info_cnt = 2,
+	BTF_TYPES
+},
+{
+	"don't inline bpf_loop call, callback non-constant",
+	.insns = {
+	/* main */
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 4), /* pick a random callback */
+
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 10),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 8),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* callback #2 */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = { HELPER_CALL_INSN() },
+	.unexpected_insns = { PSEUDO_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.runs = 0,
+	.func_info = {
+		{ 0, MAIN_TYPE },
+		{ 14, CALLBACK_TYPE },
+		{ 16, CALLBACK_TYPE }
+	},
+	.func_info_cnt = 3,
+	BTF_TYPES
+},
+{
+	"bpf_loop_inline and a dead func",
+	.insns = {
+	/* main */
+
+	/* A reference to callback #1 to make verifier count it as a func.
+	 * This reference is overwritten below and callback #1 is dead.
+	 */
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 9),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 8),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* callback #2 */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = { PSEUDO_CALL_INSN() },
+	.unexpected_insns = { HELPER_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.runs = 0,
+	.func_info = {
+		{ 0, MAIN_TYPE },
+		{ 10, CALLBACK_TYPE },
+		{ 12, CALLBACK_TYPE }
+	},
+	.func_info_cnt = 3,
+	BTF_TYPES
+},
+{
+	"bpf_loop_inline stack locations for loop vars",
+	.insns = {
+	/* main */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0x77),
+	/* bpf_loop call #1 */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 22),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	/* bpf_loop call #2 */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 16),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	/* call func and exit */
+	BPF_CALL_REL(2),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* func */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -32, 0x55),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0x77),
+	SKIP_INSNS(),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -40),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, -32),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, -24),
+	SKIP_INSNS(),
+	/* offsets are the same as in the first call */
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -40),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, -32),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, -24),
+	SKIP_INSNS(),
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -32, 0x55),
+	SKIP_INSNS(),
+	/* offsets differ from main because of different offset
+	 * in BPF_ST_MEM instruction
+	 */
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -56),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, -48),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, -40),
+	},
+	.unexpected_insns = { HELPER_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.func_info = {
+		{ 0, MAIN_TYPE },
+		{ 16, MAIN_TYPE },
+		{ 25, CALLBACK_TYPE },
+	},
+	.func_info_cnt = 3,
+	BTF_TYPES
+},
+
+#undef HELPER_CALL_INSN
+#undef PSEUDO_CALL_INSN
+#undef CALLBACK_TYPE
+#undef MAIN_TYPE
+#undef BTF_TYPES
-- 
2.25.1

