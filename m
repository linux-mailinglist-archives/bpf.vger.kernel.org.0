Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E46C8A82
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjCYC5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjCYC5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:57:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411F41B2F8
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v1so3521390wrv.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679713006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEPmJZxbMgvJimhH3B29m+zfzKxMs81gcQPRFiIrsoA=;
        b=qEzw6m1cR5G3eQIofg+DLGS6yiXSwUCw3iLl34ZvL6cX1xBFNiWjmqOB6vlKj2HrgH
         CqCOz5dc03AAEMlVKkmaqXGjppL5XBOcB1PPc5XCsDAiEI2tYkz01ri3B0GxwV7cpAZ2
         xEJl6tIcXKdjM85GeZDTXl7/FNHndM2DEvoeAaHlDSyvILFvf0CDOdahwZRoYMZ3DoFG
         9ZunDogrBR/21SSot93j/P/lYmRsR8m+LRJ1EW/vhfG9A3RcbHP/cFeZVF/gmBJyA8pt
         wWJrFg66KmAh2ochSioxuZ1cM2KPhZtU9bvwrvghFAYGNw/fN6+bLA3vIhZXq69J8fxv
         5vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEPmJZxbMgvJimhH3B29m+zfzKxMs81gcQPRFiIrsoA=;
        b=atVnAeaZisJ+mNOSD71SzszbHJak4y0mQgW6ao8E7g25PJp/zzl+cqi2oJ4MIrIxum
         JMAHSK1h3FS/SpbOekHerseGHuCW4NClxnx5bVARX14o1ag8hdQeRMfBSq8GsLQIRI6y
         d++nzapw8mr6zdCdW3M8slv0QWjqkqsAHtuUmphow38Mep0cc8utIaDg1bsf8sdqaCQy
         CdxJ4ToOrru+61BHyw6aHTciZSYhf7S3fFEWIfIabCTHvtbAKO0c82cHLUEAwd83l6dR
         eWYwAq93kJWD6qUW+272Yno2ibsOjKoccYs6mzawsktfDWJfRZo4Ty0R6Eo96jpnaZax
         3bnw==
X-Gm-Message-State: AAQBX9dnYgyVM3OZzNP0GhsNPIscksjpQJ4r9hkcNaZtwyoSgjUTRV7c
        FmsW7rvj5xLaJ9IxeKlLhWAFLAOR3Zw=
X-Google-Smtp-Source: AKy350b64vIYqmmF5Ri1fMZo8JjIGEI/5rPzuIoyl5c0XoWEKgIUnY5+1zRHUithRWCYRKxEMSmqXg==
X-Received: by 2002:adf:fb88:0:b0:2d8:1022:f4c6 with SMTP id a8-20020adffb88000000b002d81022f4c6mr3524547wrr.0.1679713006379;
        Fri, 24 Mar 2023 19:56:46 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:45 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 39/43] selftests/bpf: verifier/value_or_null.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:20 +0200
Message-Id: <20230325025524.144043-40-eddyz87@gmail.com>
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

Test verifier/value_or_null.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_value_or_null.c        | 288 ++++++++++++++++++
 .../selftests/bpf/verifier/value_or_null.c    | 220 -------------
 3 files changed, 290 insertions(+), 220 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value_or_null.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value_or_null.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c77df746d650..54eb21ef9fad 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -36,6 +36,7 @@
 #include "verifier_uninit.skel.h"
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
+#include "verifier_value_or_null.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -94,3 +95,4 @@ void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
+void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_or_null.c b/tools/testing/selftests/bpf/progs/verifier_value_or_null.c
new file mode 100644
index 000000000000..8ff668a242eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_value_or_null.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/value_or_null.c */
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
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+SEC("tc")
+__description("multiple registers share map_lookup_elem result")
+__success __retval(0)
+__naked void share_map_lookup_elem_result(void)
+{
+	asm volatile ("					\
+	r1 = 10;					\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r4 = r0;					\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 0;						\
+	*(u64*)(r4 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("alu ops on ptr_to_map_value_or_null, 1")
+__failure __msg("R4 pointer arithmetic on map_value_or_null")
+__naked void map_value_or_null_1(void)
+{
+	asm volatile ("					\
+	r1 = 10;					\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r4 = r0;					\
+	r4 += -2;					\
+	r4 += 2;					\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 0;						\
+	*(u64*)(r4 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("alu ops on ptr_to_map_value_or_null, 2")
+__failure __msg("R4 pointer arithmetic on map_value_or_null")
+__naked void map_value_or_null_2(void)
+{
+	asm volatile ("					\
+	r1 = 10;					\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r4 = r0;					\
+	r4 &= -1;					\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 0;						\
+	*(u64*)(r4 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("alu ops on ptr_to_map_value_or_null, 3")
+__failure __msg("R4 pointer arithmetic on map_value_or_null")
+__naked void map_value_or_null_3(void)
+{
+	asm volatile ("					\
+	r1 = 10;					\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r4 = r0;					\
+	r4 <<= 1;					\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 0;						\
+	*(u64*)(r4 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("invalid memory access with multiple map_lookup_elem calls")
+__failure __msg("R4 !read_ok")
+__naked void multiple_map_lookup_elem_calls(void)
+{
+	asm volatile ("					\
+	r1 = 10;					\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	r8 = r1;					\
+	r7 = r2;					\
+	call %[bpf_map_lookup_elem];			\
+	r4 = r0;					\
+	r1 = r8;					\
+	r2 = r7;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 0;						\
+	*(u64*)(r4 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("valid indirect map_lookup_elem access with 2nd lookup in branch")
+__success __retval(0)
+__naked void with_2nd_lookup_in_branch(void)
+{
+	asm volatile ("					\
+	r1 = 10;					\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	r8 = r1;					\
+	r7 = r2;					\
+	call %[bpf_map_lookup_elem];			\
+	r2 = 10;					\
+	if r2 != 0 goto l0_%=;				\
+	r1 = r8;					\
+	r2 = r7;					\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	r4 = r0;					\
+	if r0 == 0 goto l1_%=;				\
+	r1 = 0;						\
+	*(u64*)(r4 + 0) = r1;				\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid map access from else condition")
+__failure __msg("R0 unbounded memory access")
+__failure_unpriv __msg_unpriv("R0 leaks addr")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void map_access_from_else_condition(void)
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
+	if r1 >= %[__imm_0] goto l1_%=;			\
+	r1 += 1;					\
+l1_%=:	r1 <<= 2;					\
+	r0 += r1;					\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, MAX_ENTRIES-1),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("map lookup and null branch prediction")
+__success __retval(0)
+__naked void lookup_and_null_branch_prediction(void)
+{
+	asm volatile ("					\
+	r1 = 10;					\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r6 = r0;					\
+	if r6 == 0 goto l0_%=;				\
+	if r6 != 0 goto l0_%=;				\
+	r10 += 10;					\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("MAP_VALUE_OR_NULL check_ids() in regsafe()")
+__failure __msg("R8 invalid mem access 'map_value_or_null'")
+__failure_unpriv __msg_unpriv("")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void null_check_ids_in_regsafe(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	/* r9 = map_lookup_elem(...) */			\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r9 = r0;					\
+	/* r8 = map_lookup_elem(...) */			\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r8 = r0;					\
+	/* r7 = ktime_get_ns() */			\
+	call %[bpf_ktime_get_ns];			\
+	r7 = r0;					\
+	/* r6 = ktime_get_ns() */			\
+	call %[bpf_ktime_get_ns];			\
+	r6 = r0;					\
+	/* if r6 > r7 goto +1    ; no new information about the state is derived from\
+	 *                       ; this check, thus produced verifier states differ\
+	 *                       ; only in 'insn_idx'	\
+	 * r9 = r8               ; optionally share ID between r9 and r8\
+	 */						\
+	if r6 > r7 goto l0_%=;				\
+	r9 = r8;					\
+l0_%=:	/* if r9 == 0 goto <exit> */			\
+	if r9 == 0 goto l1_%=;				\
+	/* read map value via r8, this is not always	\
+	 * safe because r8 might be not equal to r9.	\
+	 */						\
+	r0 = *(u64*)(r8 + 0);				\
+l1_%=:	/* exit 0 */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/value_or_null.c b/tools/testing/selftests/bpf/verifier/value_or_null.c
deleted file mode 100644
index 52a8bca14f03..000000000000
--- a/tools/testing/selftests/bpf/verifier/value_or_null.c
+++ /dev/null
@@ -1,220 +0,0 @@
-{
-	"multiple registers share map_lookup_elem result",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 10),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS
-},
-{
-	"alu ops on ptr_to_map_value_or_null, 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 10),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.errstr = "R4 pointer arithmetic on map_value_or_null",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS
-},
-{
-	"alu ops on ptr_to_map_value_or_null, 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 10),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_4, -1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.errstr = "R4 pointer arithmetic on map_value_or_null",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS
-},
-{
-	"alu ops on ptr_to_map_value_or_null, 3",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 10),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_4, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.errstr = "R4 pointer arithmetic on map_value_or_null",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS
-},
-{
-	"invalid memory access with multiple map_lookup_elem calls",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 10),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.result = REJECT,
-	.errstr = "R4 !read_ok",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS
-},
-{
-	"valid indirect map_lookup_elem access with 2nd lookup in branch",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 10),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_2, 10),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_4, 0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS
-},
-{
-	"invalid map access from else condition",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, MAX_ENTRIES-1, 1),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R0 unbounded memory access",
-	.result = REJECT,
-	.errstr_unpriv = "R0 leaks addr",
-	.result_unpriv = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"map lookup and null branch prediction",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 10),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 1),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_10, 10),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"MAP_VALUE_OR_NULL check_ids() in regsafe()",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* r9 = map_lookup_elem(...) */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
-	/* r8 = map_lookup_elem(...) */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	/* r7 = ktime_get_ns() */
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	/* r6 = ktime_get_ns() */
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* if r6 > r7 goto +1    ; no new information about the state is derived from
-	 *                       ; this check, thus produced verifier states differ
-	 *                       ; only in 'insn_idx'
-	 * r9 = r8               ; optionally share ID between r9 and r8
-	 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
-	/* if r9 == 0 goto <exit> */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
-	/* read map value via r8, this is not always
-	 * safe because r8 might be not equal to r9.
-	 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_8, 0),
-	/* exit 0 */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.flags = BPF_F_TEST_STATE_FREQ,
-	.fixup_map_hash_8b = { 3, 9 },
-	.result = REJECT,
-	.errstr = "R8 invalid mem access 'map_value_or_null'",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-- 
2.40.0

