Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF96EB0EE
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjDURnu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjDURnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13576A25F
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f917585b26so1860763f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098992; x=1684690992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YnTInlSOEXnQAAqK7LhsEiKq5CksDofUuibkqgDDxE=;
        b=JMbvlBFvHzqcFARWinKw3en7EYa3VdlOu5/9IiHO41IfGuO/7QUCuMC3y9pgKXIh/X
         cp8MxXPKg3OnBbJ1jwpLMtjC55yk+si2z/1IKE2+9JEsuBPz6T6xfdjzk216R4l9LO83
         XErKj6784PtueINLgLyj8faIYIyF2JzKEFRfUDRp/gQfyCd81sk39E0g9h3bfQ3vneSD
         lOqvQ3t8qRHKgzamoy66YxORYHbf6l3FVRfaz8P0+E9lBZxr/AnKcI+Yg3/4uYxT6fJX
         D8xp8ocfAyz0RhqAN3ZKyL0pwzvXVu2j6yyF9+7D8G0gK46P9TDqWmj39e0cgYPTV9Hz
         kA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098992; x=1684690992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YnTInlSOEXnQAAqK7LhsEiKq5CksDofUuibkqgDDxE=;
        b=iQ4gRCJKBNYmKzjnOTuyGjMTBtWMEgW22v4pX5k4DgzBI9FxRFlZ9bGQ12lA8YhfFE
         Yjk6ZJmxI8Bk4YZ9tS1K2162oBkcSW4l7wHBuwuE4KAPtlE2AWrNP9pZjUpoQtESuZGC
         2G+hw7hPBjJCs7epvjQbGK2cDxe2XRoLqPKl6V+I8zvG/WdUgajgylnU1KGxKZnadpXt
         HcP6N7Ww+Wo01TV2qnmMeYg8eWa/e3LGE3p+Fcn1T2mWjGLWIerJaoKtozq5p/Xhlit+
         QIOoLs/AL0QKyXCJg3MpaDDGES4b3RGF7F/nPu2/wUuMnuJnh5AQJb8JjKtc9XsoCeGH
         7zQQ==
X-Gm-Message-State: AAQBX9dPRqQ7AsT3xFD7O+GLMW0NU/DTEB0ikEyCUeR+m9jSXVqMKCFH
        47VXI6+eRHrIkDGwRCpRRU6ZIv0umRt/9w==
X-Google-Smtp-Source: AKy350bdes4OUEMHQk9VVs36urKV4BdzlFZMaE4uYJGfEaIyOtQaKo0J7VlRgjVem20SrdHj+/DTvA==
X-Received: by 2002:a5d:52d2:0:b0:2cf:eeae:88c3 with SMTP id r18-20020a5d52d2000000b002cfeeae88c3mr4387092wrv.32.1682098992352;
        Fri, 21 Apr 2023 10:43:12 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:11 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 23/24] selftests/bpf: verifier/value_illegal_alu converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:33 +0300
Message-Id: <20230421174234.2391278-24-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/value_illegal_alu automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_value_illegal_alu.c    | 149 ++++++++++++++++++
 .../bpf/verifier/value_illegal_alu.c          |  95 -----------
 3 files changed, 151 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value_illegal_alu.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 94405bf00b47..56b9248a15c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -60,6 +60,7 @@
 #include "verifier_unpriv_perf.skel.h"
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
+#include "verifier_value_illegal_alu.skel.h"
 #include "verifier_value_or_null.skel.h"
 #include "verifier_var_off.skel.h"
 #include "verifier_xadd.skel.h"
@@ -156,6 +157,7 @@ void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
 void test_verifier_unpriv_perf(void)          { RUN(verifier_unpriv_perf); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
+void test_verifier_value_illegal_alu(void)    { RUN(verifier_value_illegal_alu); }
 void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
 void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
new file mode 100644
index 000000000000..71814a753216
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/value_illegal_alu.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define MAX_ENTRIES 11
+
+struct test_val {
+	unsigned int index;
+	int foo[MAX_ENTRIES];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+SEC("socket")
+__description("map element value illegal alu op, 1")
+__failure __msg("R0 bitwise operator &= on pointer")
+__failure_unpriv
+__naked void value_illegal_alu_op_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 &= 8;					\
+	r1 = 22;					\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map element value illegal alu op, 2")
+__failure __msg("R0 32-bit pointer arithmetic prohibited")
+__failure_unpriv
+__naked void value_illegal_alu_op_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	w0 += 0;					\
+	r1 = 22;					\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map element value illegal alu op, 3")
+__failure __msg("R0 pointer arithmetic with /= operator")
+__failure_unpriv
+__naked void value_illegal_alu_op_3(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 /= 42;					\
+	r1 = 22;					\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map element value illegal alu op, 4")
+__failure __msg("invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R0 pointer arithmetic prohibited")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void value_illegal_alu_op_4(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 = be64 r0;					\
+	r1 = 22;					\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map element value illegal alu op, 5")
+__failure __msg("R0 invalid mem access 'scalar'")
+__msg_unpriv("leaking pointer from stack off -8")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void value_illegal_alu_op_5(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r3 = 4096;					\
+	r2 = r10;					\
+	r2 += -8;					\
+	*(u64*)(r2 + 0) = r0;				\
+	lock *(u64 *)(r2 + 0) += r3;			\
+	r0 = *(u64*)(r2 + 0);				\
+	r1 = 22;					\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/value_illegal_alu.c b/tools/testing/selftests/bpf/verifier/value_illegal_alu.c
deleted file mode 100644
index d6f29eb4bd57..000000000000
--- a/tools/testing/selftests/bpf/verifier/value_illegal_alu.c
+++ /dev/null
@@ -1,95 +0,0 @@
-{
-	"map element value illegal alu op, 1",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R0 bitwise operator &= on pointer",
-	.result = REJECT,
-},
-{
-	"map element value illegal alu op, 2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R0 32-bit pointer arithmetic prohibited",
-	.result = REJECT,
-},
-{
-	"map element value illegal alu op, 3",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ALU64_IMM(BPF_DIV, BPF_REG_0, 42),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R0 pointer arithmetic with /= operator",
-	.result = REJECT,
-},
-{
-	"map element value illegal alu op, 4",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ENDIAN(BPF_FROM_BE, BPF_REG_0, 64),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 pointer arithmetic prohibited",
-	.errstr = "invalid mem access 'scalar'",
-	.result = REJECT,
-	.result_unpriv = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"map element value illegal alu op, 5",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_MOV64_IMM(BPF_REG_3, 4096),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_2, BPF_REG_3, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 22),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "leaking pointer from stack off -8",
-	.errstr = "R0 invalid mem access 'scalar'",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-- 
2.40.0

