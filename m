Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C26C8A62
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCYC4I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjCYC4G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E818AA1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n19so2117093wms.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6voLyh/1WOWDoGxG0u2NfiXTJk2EMxPgq4UkcA6jpE=;
        b=WFI1eVQxDvp6I9llpzigE1QGHJUgmHQWyvejoOdwtpjqelnW++JUan5PtqtQZZajw+
         arupbE6btPFdCG0A9Uj96ooObS8SbvK0ZuY5xt6dypCFmZ5GNhsoHmdLsTqNfNkm5EeS
         QTeVdijDrcHtBXDWf+042sralo55+QfPBVV3AWPw+UQtXdBGtvTIlTdjS2YDoqdrbL76
         bW2Qj3iQ2olWx6fFjZpE5UopoHTwwK80xWQt4OGIk42ci61Ud2Raw47x1Z1Uuj7FoUHh
         zDDmeZ1MyUtzGz6sOpSvOL7YzgILfQjBdqM48W0z8HBUpXIapnjWEXzN8H7utJBARoKC
         MmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6voLyh/1WOWDoGxG0u2NfiXTJk2EMxPgq4UkcA6jpE=;
        b=BDCoLi/ZqS2orG2GJlhDAEVpldPbtOe9o6zmq0C5n4VtmkDKd3W2rrs7mBp9w9CIgl
         Au0dCRPJ9c2LDRKwRv2C/huKRHmewfCg2bZFjRQ6FFyMG3W0d+ZXiByRWBkYW4WgzW1A
         0kgcb6VWnG6e5WTs/Q30DgELTlmQG1uBD0IPImmFW1AK17JCot2cdcJAhpZ8TV/jyDnn
         Gq8bo0gl3de7MOAVa5qb3fr3nwczHXMqwA8nSnOQUzCl1ExYVpR3sxNZX6L6cf26iob0
         EyLJ9CW0p5IRdHC3G621+FHmGwKy/NFjbItH/sCzni5biDKEQuob01orUx7AbQKzndzQ
         YX7w==
X-Gm-Message-State: AO0yUKW/IO8yaukSe2OtcAYarjisjDiX8NKxhrCkttmAfz322VPFv8m5
        QVL5X2Sf9wamveJQNWlRmdrES/D1lIs=
X-Google-Smtp-Source: AK7set+17vrr/WGYBDRXa8UKWi1kiDmymcYTnDhhvWoWsVDpZvrNOIHDWHmIvrOpj7TbPmxYKznPJg==
X-Received: by 2002:a05:600c:3655:b0:3eb:2da4:f304 with SMTP id y21-20020a05600c365500b003eb2da4f304mr3700368wmq.17.1679712964375;
        Fri, 24 Mar 2023 19:56:04 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:03 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 08/43] selftests/bpf: verifier/basic_stack.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:49 +0200
Message-Id: <20230325025524.144043-9-eddyz87@gmail.com>
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

Test verifier/basic_stack.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_basic_stack.c          | 100 ++++++++++++++++++
 .../selftests/bpf/verifier/basic_stack.c      |  64 -----------
 3 files changed, 102 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_basic_stack.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/basic_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 60eb0f38ed92..95a3151db052 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -5,6 +5,7 @@
 #include "cap_helpers.h"
 #include "verifier_and.skel.h"
 #include "verifier_array_access.skel.h"
+#include "verifier_basic_stack.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -32,3 +33,4 @@ static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_fac
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_array_access(void)         { RUN(verifier_array_access); }
+void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
new file mode 100644
index 000000000000..359df865a8f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/basic_stack.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+SEC("socket")
+__description("stack out of bounds")
+__failure __msg("invalid write to stack")
+__failure_unpriv
+__naked void stack_out_of_bounds(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 + 8) = r1;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("uninitialized stack1")
+__failure __msg("invalid indirect read from stack")
+__failure_unpriv
+__naked void uninitialized_stack1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("uninitialized stack2")
+__failure __msg("invalid read from stack")
+__failure_unpriv
+__naked void uninitialized_stack2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r0 = *(u64*)(r2 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid fp arithmetic")
+__failure __msg("R1 subtraction from stack pointer")
+__failure_unpriv
+__naked void invalid_fp_arithmetic(void)
+{
+	/* If this gets ever changed, make sure JITs can deal with it. */
+	asm volatile ("					\
+	r0 = 0;						\
+	r1 = r10;					\
+	r1 -= 8;					\
+	*(u64*)(r1 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("non-invalid fp arithmetic")
+__success __success_unpriv __retval(0)
+__naked void non_invalid_fp_arithmetic(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r10 - 8) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("misaligned read from stack")
+__failure __msg("misaligned stack access")
+__failure_unpriv
+__naked void misaligned_read_from_stack(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r0 = *(u64*)(r2 - 4);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/basic_stack.c b/tools/testing/selftests/bpf/verifier/basic_stack.c
deleted file mode 100644
index f995777dddb3..000000000000
--- a/tools/testing/selftests/bpf/verifier/basic_stack.c
+++ /dev/null
@@ -1,64 +0,0 @@
-{
-	"stack out of bounds",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, 8, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid write to stack",
-	.result = REJECT,
-},
-{
-	"uninitialized stack1",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 2 },
-	.errstr = "invalid indirect read from stack",
-	.result = REJECT,
-},
-{
-	"uninitialized stack2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, -8),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid read from stack",
-	.result = REJECT,
-},
-{
-	"invalid fp arithmetic",
-	/* If this gets ever changed, make sure JITs can deal with it. */
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R1 subtraction from stack pointer",
-	.result = REJECT,
-},
-{
-	"non-invalid fp arithmetic",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-},
-{
-	"misaligned read from stack",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, -4),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "misaligned stack access",
-	.result = REJECT,
-},
-- 
2.40.0

