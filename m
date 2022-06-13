Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46607549BFF
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 20:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbiFMSo0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 14:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbiFMSne (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 14:43:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A39FEE
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:02:28 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e4so6533545ljl.1
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWC084HhhUPAF1fMfRJjXB2Y5AT9puI4sONMhM3mNGo=;
        b=hGd8Ylm6Ddp+LXEa9tkECXWIHaYA2sdb4FBRR5y3Vgwbhh4adky7Ndw/T8aiHc57ZP
         Fh6k4jy3pjdMc/mC3eQeTairuXNA1A34vAlAXArrzt8csZi3IU0d/dek2+h0t2ZuuRaI
         Qcke4ZYTs46udFq1tIEn9yG+G6nvD/vlQEOOmdbF+xBkWarnccyyxfNsqSp3nv1KUTuI
         IfO9DUlIiTetLqYMadrtPeTHJ5pmebZh+bvwvK1uln2j17eyWIF+BdF1kLQv5ItVUACp
         YBbuP2W2qQxKFn+67pqo1atyHiUd8vwZbask7NR3sc9EW6M4I+noa2PKs3M0ALAukL7t
         d5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWC084HhhUPAF1fMfRJjXB2Y5AT9puI4sONMhM3mNGo=;
        b=7ye4Yph4SLZQtvHZ+JwZCUtG07kWMkphD/IDSlPO9ZxEA9RkfQxjQYm4TxdKW5F3CL
         dDP+/OtddiOuVAMjce+ewg0nbthdZL63rqvtHTnjrTCOoBlP5bAoZ6LVuCxPikezpulC
         a2+PK7gQM+bOejXW4Dkh1AZQjFZd8m4X97j9HrrpHT4Es3MrDLZujFT/Iwm059XwD3rL
         z1j6f7EvHC6ByYcabk0w31hwCpcn4WPKQb9Zl72Pt+WTPlcsgOH9YUGJkDMTCM/EI5T4
         3yf/S8L4MggLtJrJ6bkL2qOuYIYg3gvyr/1cU5cIeGcvx51qQXyba8jW64+eJ1MdhYWX
         ITNQ==
X-Gm-Message-State: AJIora9m/Mbdkc7gnohrcgLXLVEcRULMP7Kgf99q0xiz4Uw7joca8qaO
        o+QFZuNZp7n/ChQrzfAizXXfWXaWOoLYhA==
X-Google-Smtp-Source: AGRyM1v355NiiQhtRsR46IS/c6lS47ED39vgpo7DworCRSG9r/lyWn/mGeEJCDhlDXVsgs0hM1XOzg==
X-Received: by 2002:a05:651c:1a22:b0:255:61fc:4645 with SMTP id by34-20020a05651c1a2200b0025561fc4645mr5701ljb.99.1655132546458;
        Mon, 13 Jun 2022 08:02:26 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id a9-20020ac25e69000000b0047910511c23sm1021362lfr.45.2022.06.13.08.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 08:02:25 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v6 4/5] selftests/bpf: BPF test_verifier selftests for bpf_loop inlining
Date:   Mon, 13 Jun 2022 18:01:40 +0300
Message-Id: <20220613150141.169619-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613150141.169619-1-eddyz87@gmail.com>
References: <20220613150141.169619-1-eddyz87@gmail.com>
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
Acked-by: Song Liu <songliubraving@fb.com>
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

