Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C56C8A80
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjCYC47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjCYC46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFED515CBB
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso4187845wmb.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679713005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJTfhyLIwsFTo7F98hwtLDBIzb0RmTXsZYNqswPAitA=;
        b=fxrxKRxQjIlOF+O27COzDPimee0OglbRKVPqxjN/cY1c8hkU2axJz7MU5ON+HyXH/t
         +MaJyDdeJwwALA50GejOR3+ZbO7KRRgKFZgQV0aoTEXDxrNBadI6f3vnCwXLI9k8vgeF
         axOFIgegyPpIwCYos6YbSawdn0RyOKiKJJrZ6s38PPpDfMZrabW17kV7LsmPSNGlGS1r
         e3YrEgnCW2uGX/Oo556tdfFGum3n9oy/YvBmRK44Jse8EY1ZjMZxr7zdnJDo7uveWvYP
         PtXZBtsnUHPP7gnRgoG5P9YTwCOPl5lDcj9iCPKEhif4yISiV0l8vpfKxyHyzSlWSL5/
         KzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJTfhyLIwsFTo7F98hwtLDBIzb0RmTXsZYNqswPAitA=;
        b=clOw+YXgAj0/H2fnpwxng9s2cH43SCsRJbqOrFAwq5Imj1ri8P+oTERGN12lpaPnUd
         IafWfHf/GvAi68A3WOu0uDDbJabwOrx8d8r1O/rWCWyZ0e6KORQnCHDRMH5kBWhRNaXn
         UgS7LCiw2YaDRBL+EjXW2lAIujLebEkCNDQxnXkMPaeAuqVMnSybgyia3q6mya7cN1E/
         HlKe2iRgez0CIOD/ehzLB1ORL6RxJJ/3ZrOtbLt1wkUokeawCyWQGmSdgnWOT7iougRA
         JS4zNFvIMDpw+AFhATjPeHUsag2q+KOztO0RvbZFjVIEP3LGg4JDgKxVYn2MpF0DjIUP
         Fe+w==
X-Gm-Message-State: AO0yUKXkcuNt9esddA11HuMQTumDJXDbsSR7nwGU5qBDIhGEyGzw1aPQ
        KDrp76J13p91Edpsmi1UbmuQFJbgHmg=
X-Google-Smtp-Source: AK7set/veHBAp8JbYdEZrACw6GPw293U20t8cCwJPeGtjnr2mtuZ0f/vMBtSPLbXMTeZN7H+jM3j8w==
X-Received: by 2002:a1c:ed05:0:b0:3eb:395b:8b62 with SMTP id l5-20020a1ced05000000b003eb395b8b62mr3737634wmh.39.1679713005138;
        Fri, 24 Mar 2023 19:56:45 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:44 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 38/43] selftests/bpf: verifier/value.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:19 +0200
Message-Id: <20230325025524.144043-39-eddyz87@gmail.com>
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

Test verifier/value.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_value.c      | 158 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/value.c  | 104 ------------
 3 files changed, 160 insertions(+), 104 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 825c8583fecf..c77df746d650 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -35,6 +35,7 @@
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_value_adj_spill.skel.h"
+#include "verifier_value.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -92,3 +93,4 @@ void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
+void test_verifier_value(void)                { RUN(verifier_value); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_value.c b/tools/testing/selftests/bpf/progs/verifier_value.c
new file mode 100644
index 000000000000..b5af6b6f5acd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_value.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/value.c */
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
+__description("map element value store of cleared call register")
+__failure __msg("R1 !read_ok")
+__failure_unpriv __msg_unpriv("R1 !read_ok")
+__naked void store_of_cleared_call_register(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map element value with unaligned store")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void element_value_with_unaligned_store(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 += 3;					\
+	r1 = 42;					\
+	*(u64*)(r0 + 0) = r1;				\
+	r1 = 43;					\
+	*(u64*)(r0 + 2) = r1;				\
+	r1 = 44;					\
+	*(u64*)(r0 - 2) = r1;				\
+	r8 = r0;					\
+	r1 = 32;					\
+	*(u64*)(r8 + 0) = r1;				\
+	r1 = 33;					\
+	*(u64*)(r8 + 2) = r1;				\
+	r1 = 34;					\
+	*(u64*)(r8 - 2) = r1;				\
+	r8 += 5;					\
+	r1 = 22;					\
+	*(u64*)(r8 + 0) = r1;				\
+	r1 = 23;					\
+	*(u64*)(r8 + 4) = r1;				\
+	r1 = 24;					\
+	*(u64*)(r8 - 7) = r1;				\
+	r7 = r8;					\
+	r7 += 3;					\
+	r1 = 22;					\
+	*(u64*)(r7 + 0) = r1;				\
+	r1 = 23;					\
+	*(u64*)(r7 + 4) = r1;				\
+	r1 = 24;					\
+	*(u64*)(r7 - 4) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map element value with unaligned load")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void element_value_with_unaligned_load(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	if r1 >= %[max_entries] goto l0_%=;		\
+	r0 += 3;					\
+	r7 = *(u64*)(r0 + 0);				\
+	r7 = *(u64*)(r0 + 2);				\
+	r8 = r0;					\
+	r7 = *(u64*)(r8 + 0);				\
+	r7 = *(u64*)(r8 + 2);				\
+	r0 += 5;					\
+	r7 = *(u64*)(r0 + 0);				\
+	r7 = *(u64*)(r0 + 4);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(max_entries, MAX_ENTRIES)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map element value is preserved across register spilling")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void is_preserved_across_register_spilling(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 += %[test_val_foo];				\
+	r1 = 42;					\
+	*(u64*)(r0 + 0) = r1;				\
+	r1 = r10;					\
+	r1 += -184;					\
+	*(u64*)(r1 + 0) = r0;				\
+	r3 = *(u64*)(r1 + 0);				\
+	r1 = 42;					\
+	*(u64*)(r3 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/value.c b/tools/testing/selftests/bpf/verifier/value.c
deleted file mode 100644
index 0e42592b1218..000000000000
--- a/tools/testing/selftests/bpf/verifier/value.c
+++ /dev/null
@@ -1,104 +0,0 @@
-{
-	"map element value store of cleared call register",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R1 !read_ok",
-	.errstr = "R1 !read_ok",
-	.result = REJECT,
-	.result_unpriv = REJECT,
-},
-{
-	"map element value with unaligned store",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 17),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 3),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 2, 43),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, -2, 44),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_8, 0, 32),
-	BPF_ST_MEM(BPF_DW, BPF_REG_8, 2, 33),
-	BPF_ST_MEM(BPF_DW, BPF_REG_8, -2, 34),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_8, 5),
-	BPF_ST_MEM(BPF_DW, BPF_REG_8, 0, 22),
-	BPF_ST_MEM(BPF_DW, BPF_REG_8, 4, 23),
-	BPF_ST_MEM(BPF_DW, BPF_REG_8, -7, 24),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_8),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, 3),
-	BPF_ST_MEM(BPF_DW, BPF_REG_7, 0, 22),
-	BPF_ST_MEM(BPF_DW, BPF_REG_7, 4, 23),
-	BPF_ST_MEM(BPF_DW, BPF_REG_7, -4, 24),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"map element value with unaligned load",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES, 9),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 3),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 2),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_8, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_8, 2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 5),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 4),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"map element value is preserved across register spilling",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, offsetof(struct test_val, foo)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -184),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_3, 0, 42),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-- 
2.40.0

