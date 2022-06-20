Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4BA55286C
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 01:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245097AbiFTXyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 19:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiFTXyt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 19:54:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F813D39
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:54:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id es26so15433952edb.4
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUNlDq4gqclg6ilFHgssD0hNdQf9GAvVjVxet0bXss8=;
        b=XZ/5JqP6kIBTJ94NXEDP5ZmStL0L0jqpUUcBbFlj5q8zpDrnSNk2BsYBHMfGCHM0pU
         Z0EN3ntEDaalJMkZRL8g3RgmrshBZKiAwOZC7Ly/j9qnlpq1DwQvNSUDyIcYWgxTGueO
         BXEaPx5gGs1jftbVGHzoZ8iCfsFKsGNVoVWVtaGdZuejnghubhKXwgj7dV99kHiQp4Pj
         la5HnsskKi0LNx6rAc11RddFCyPLfB/bRijWvT/gk1likw/2xfxPlPGKs/bLOBsfwECu
         UARComszD79sEIfA9u4zhte7+cpPMgwKhMVBqUxHkYAmuQXLO+sc73OR+vVR4LTwU8cI
         FI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUNlDq4gqclg6ilFHgssD0hNdQf9GAvVjVxet0bXss8=;
        b=KP9leRv6suD/8R/oVZOSg60XTgctIY/K7M02JuEjoIrAPQjjPgkqNRbvz6Rih+nl7B
         MVni7Hfwc+lOAfq9Ez4dOJLtI7Av6t4iDaE5IK+/7XdVIQOI6DFS1yODoQTHxdCFqPWV
         P64uR/WB8iTQX+Z53pP6xQaRRq71NbmtzkmD0UehmblZYLI0ADXwNjyrYpigeQ9kCwSw
         Fzg6MecHeia00NWiRkbnqkgxwPF0k1+eK2LXwHf7c8VIGbRJBMjdq5BZoAep9C5jJj65
         UIFqGPbwKUe7q4VSQbxA8xSW6sIYoN70xSgEo4ybJd9pVqO3qoJ0omU9BJRKI9N9Sf7g
         5oKQ==
X-Gm-Message-State: AJIora9grUD68wyPE2zd1G5jMnIH8XRfrWr5i3AhyoRShRTOH1zO5Tyo
        Bb20wMkTYEw1xk87iLiyZCme/25dJlalvEFD
X-Google-Smtp-Source: AGRyM1uMqV+5AwuLa4GM7uKyhG7i1LhXtkvtbOwcn87z+Ad2gc85vgwG2CL3azGW+53Xmn3DEaf11w==
X-Received: by 2002:a05:6402:3988:b0:434:e2a8:8459 with SMTP id fk8-20020a056402398800b00434e2a88459mr32208561edb.253.1655769286256;
        Mon, 20 Jun 2022 16:54:46 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e21-20020a056402105500b004356d08bbbasm7078560edu.40.2022.06.20.16.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 16:54:43 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v8 4/5] selftests/bpf: BPF test_verifier selftests for bpf_loop inlining
Date:   Tue, 21 Jun 2022 02:53:43 +0300
Message-Id: <20220620235344.569325-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620235344.569325-1-eddyz87@gmail.com>
References: <20220620235344.569325-1-eddyz87@gmail.com>
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
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 252 ++++++++++++++++++
 1 file changed, 252 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c

diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
new file mode 100644
index 000000000000..232da07c93b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
@@ -0,0 +1,252 @@
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
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 9),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 7),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 1),
+	BPF_JMP_IMM(BPF_JA, 0, 0, -10),
+	/* callback */
+	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.expected_insns = { HELPER_CALL_INSN() },
+	.unexpected_insns = { PSEUDO_CALL_INSN() },
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.result = ACCEPT,
+	.runs = 0,
+	.func_info = { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
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
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -12, 0x77),
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
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -12, 0x77),
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

