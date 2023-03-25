Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFA6C8A61
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCYC4H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjCYC4E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4E19120
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso4164370wms.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+qlMg6nMDgQ5w3LNjGLpejLpSAaE0s93TgOZIMVmFg=;
        b=kpeQ6QcTCfrelKZGlOLZplOiybC8EtAsK4pooP70ROw42xLi7UOYGxQUSvWF/Q2JwH
         DlfE8SYtg6I/llsBVifz5zomTRzh9FCnqyKo/oa1Xun6taxxLvvkADlDenARwMcShx33
         R8WnywM8ePDhD7bi7KLeXKx417fB/8TYAKOenKadQBOk9lye0Z7QvE318OuYauZ58GnY
         sYVEZP8jkfIZTWlKabBGe5G95ErpwHputNPwsTRas+pzoRRRoom3NxXxkbbCtNlm0xf1
         N4iZ/TL9QP2BoyhSSkNFUHrQSCZGPXL/QQiNWVodyJa7e8EX+T26vPhT5SZD/72mPE58
         SaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+qlMg6nMDgQ5w3LNjGLpejLpSAaE0s93TgOZIMVmFg=;
        b=tE3kUM/voNwM02EW/F7w8N5iJecJdfApHfjVEZ2+YCnYEeVbfZ/jgjCKiuQpgy2XQx
         3Cc1DWXRX5RZUolVmG9xqPJ+80OIPwBs8FoHD9tgjCnOCWGsnXEFUnEa8UclTgrDlCDf
         pTUODch3GuqiQ3xVLYsbUoxW3pXFSIE/aS1uNfGVWzyr/+eoqyzcyUlFcAvmmp+SwLes
         2b+Rwhas7e06cdL8jymqJqnbtZ+XG43jhPFAnm0ZoyO6sTWXpKGYc76HJTgu5hJG8Vw1
         l/2mDf53Skgo5cmzLuQoM0H6t5zFTxssXMXULHJlpE85kM6HyOxM7HrCWY8/GSaZmhSP
         dHUA==
X-Gm-Message-State: AO0yUKXRqwlYOopFKb8LnQGUKvYmsU18cF9qw/RNe5yyX1qtsaa2pLuX
        lvkG1xbB4Ji2xc0VJX6GNdf+FAGCE/A=
X-Google-Smtp-Source: AK7set+tzJOJsNvUXGuChMDwi717Ri4bTj6eXGYFJM7MXISiuOaz9+yXWZTmUonDOYKM3oTkA7APuA==
X-Received: by 2002:a05:600c:ad0:b0:3ed:abb9:7515 with SMTP id c16-20020a05600c0ad000b003edabb97515mr3920370wmr.11.1679712961004;
        Fri, 24 Mar 2023 19:56:01 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:00 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 06/43] selftests/bpf: verifier/and.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:47 +0200
Message-Id: <20230325025524.144043-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/and.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   3 +
 .../selftests/bpf/progs/verifier_and.c        | 107 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/and.c    |  68 -----------
 3 files changed, 110 insertions(+), 68 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_and.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/and.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index aa63f5d84d97..34526f6d5ab1 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "cap_helpers.h"
+#include "verifier_and.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -27,3 +28,5 @@ static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_fac
 }
 
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes)
+
+void test_verifier_and(void)                  { RUN(verifier_and); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_and.c b/tools/testing/selftests/bpf/progs/verifier_and.c
new file mode 100644
index 000000000000..e97e518516b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_and.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/and.c */
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
+__description("invalid and of negative number")
+__failure __msg("R0 max value is outside of the allowed memory range")
+__failure_unpriv
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void invalid_and_of_negative_number(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u8*)(r0 + 0);				\
+	r1 &= -4;					\
+	r1 <<= 2;					\
+	r0 += r1;					\
+l0_%=:	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid range check")
+__failure __msg("R0 max value is outside of the allowed memory range")
+__failure_unpriv
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void invalid_range_check(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	r9 = 1;						\
+	w1 %%= 2;					\
+	w1 += 1;					\
+	w9 &= w1;					\
+	w9 += 1;					\
+	w9 >>= 1;					\
+	w3 = 1;						\
+	w3 -= w9;					\
+	w3 *= 0x10000000;				\
+	r0 += r3;					\
+	*(u32*)(r0 + 0) = r3;				\
+l0_%=:	r0 = r0;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check known subreg with unknown reg")
+__success __failure_unpriv __msg_unpriv("R1 !read_ok")
+__retval(0)
+__naked void known_subreg_with_unknown_reg(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 <<= 32;					\
+	r0 += 1;					\
+	r0 &= 0xFFFF1234;				\
+	/* Upper bits are unknown but AND above masks out 1 zero'ing lower bits */\
+	if w0 < 1 goto l0_%=;				\
+	r1 = *(u32*)(r1 + 512);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/and.c b/tools/testing/selftests/bpf/verifier/and.c
deleted file mode 100644
index 7d7ebee5cc7a..000000000000
--- a/tools/testing/selftests/bpf/verifier/and.c
+++ /dev/null
@@ -1,68 +0,0 @@
-{
-	"invalid and of negative number",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, -4),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R0 max value is outside of the allowed memory range",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"invalid range check",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 12),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_9, 1),
-	BPF_ALU32_IMM(BPF_MOD, BPF_REG_1, 2),
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_ALU32_REG(BPF_AND, BPF_REG_9, BPF_REG_1),
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_9, 1),
-	BPF_ALU32_IMM(BPF_RSH, BPF_REG_9, 1),
-	BPF_MOV32_IMM(BPF_REG_3, 1),
-	BPF_ALU32_REG(BPF_SUB, BPF_REG_3, BPF_REG_9),
-	BPF_ALU32_IMM(BPF_MUL, BPF_REG_3, 0x10000000),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_3),
-	BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_3, 0),
-	BPF_MOV64_REG(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R0 max value is outside of the allowed memory range",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"check known subreg with unknown reg",
-	.insns = {
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 32),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFFFF1234),
-	/* Upper bits are unknown but AND above masks out 1 zero'ing lower bits */
-	BPF_JMP32_IMM(BPF_JLT, BPF_REG_0, 1, 1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1, 512),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 !read_ok",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.retval = 0
-},
-- 
2.40.0

