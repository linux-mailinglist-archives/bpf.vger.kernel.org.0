Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152DD6EB0E2
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjDURna (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDURnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA9B2696
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so1301622f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098979; x=1684690979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRBL3rV1B0pyVlX06vjzxhZo31DWIZom/BS3dYyDGt8=;
        b=MgEE1L43JP9EDZyxUJmro1fpl5nhYxlCkD3TiTYVCa6kAq1iySymaP50xR3rO8euSc
         gMOtvbMOdV3mR5Emk1O/xbVBo/BqQt9dc/SUg+fEdyYPIJkdCiiNJCvtUTrnDyMTuF4v
         EdtcJRTPXW7/n5988U+ew420kHNXtqnmxMqyHT/+q6zfGen5dBl1Rj2bs2nLDhzPyH4I
         37sAlRfo3msDTME4QFgFGAFijMnxpQ0BP3+VSdwXSx5tRYe2E6A6IhzB39WJtmIprlmT
         AjxXw1mz0pHg2lN8DgLrWLbOlD+OkJA+FJILH1+AVCf8EbDAOME0VPMSxp6evLoQ1zJF
         gmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098979; x=1684690979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRBL3rV1B0pyVlX06vjzxhZo31DWIZom/BS3dYyDGt8=;
        b=jWKK8SFm+XMKUo9L5FNvQLHLik64KrlY8fiAbmsdja729BYdciqS/u/FTp4b959bNu
         V/e74ecBs+aofvTwQCzxpb2cM/bVLkRXpGVPRIrwZ6RhlwXpgfPVvEwoAj9J/NNrRRJU
         WAvhmbWJpLGHc62kHuKWTLHWMglH6/7ppKZyDoICsfymUOchzvsmoxPGDpqrmNQho37O
         t54g0bOo4Ql9w4qkpkNRnV0Xi3Myc3ZIMV9KN10biiuzoK1bVDkDlw7tFwKE+lt/ph3U
         /PEhBLxMkxYuhTMfP1fn39B9xPX9qFA5Y3jF1wGQW9xTYec/03jDTi1PnjNN2wxlqx8n
         X91w==
X-Gm-Message-State: AAQBX9esZm5vrsim3A4Pr6YUVsKEn4WXlg7LI59+d0jiyULoNnkAh3DB
        X4yLRURZ2luACUhW4hpazNKZ1Fv8FvPHlA==
X-Google-Smtp-Source: AKy350ZrtifyocN9Dok9rJxyqxA2kG3AVxd3JXPgQaDV8Dr4a4tl8FJcYSB57yBVh5mq67E2gcnkAw==
X-Received: by 2002:adf:e946:0:b0:2fe:d540:8c8e with SMTP id m6-20020adfe946000000b002fed5408c8emr4389389wrn.19.1682098979474;
        Fri, 21 Apr 2023 10:42:59 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:59 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 12/24] selftests/bpf: verifier/map_ptr_mixing converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:22 +0300
Message-Id: <20230421174234.2391278-13-eddyz87@gmail.com>
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

Test verifier/map_ptr_mixing automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_map_ptr_mixing.c       | 265 ++++++++++++++++++
 .../selftests/bpf/verifier/map_ptr_mixing.c   | 100 -------
 3 files changed, 267 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_ptr_mixing.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/map_ptr_mixing.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 95fc9cb231ad..261567230dd0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -36,6 +36,7 @@
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
 #include "verifier_map_ptr.skel.h"
+#include "verifier_map_ptr_mixing.skel.h"
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
 #include "verifier_meta_access.skel.h"
@@ -120,6 +121,7 @@ void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
 void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
+void test_verifier_map_ptr_mixing(void)       { RUN(verifier_map_ptr_mixing); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr_mixing.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr_mixing.c
new file mode 100644
index 000000000000..c5a7c1ddc562
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr_mixing.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/map_ptr_mixing.c */
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
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct test_val);
+} map_array_48b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_ARRAY);
+		__uint(max_entries, 1);
+		__type(key, int);
+		__type(value, int);
+	});
+} map_in_map SEC(".maps");
+
+void dummy_prog_42_socket(void);
+void dummy_prog_24_socket(void);
+void dummy_prog_loop1_socket(void);
+void dummy_prog_loop2_socket(void);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 4);
+	__uint(key_size, sizeof(int));
+	__array(values, void (void));
+} map_prog1_socket SEC(".maps") = {
+	.values = {
+		[0] = (void *)&dummy_prog_42_socket,
+		[1] = (void *)&dummy_prog_loop1_socket,
+		[2] = (void *)&dummy_prog_24_socket,
+	},
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 8);
+	__uint(key_size, sizeof(int));
+	__array(values, void (void));
+} map_prog2_socket SEC(".maps") = {
+	.values = {
+		[1] = (void *)&dummy_prog_loop2_socket,
+		[2] = (void *)&dummy_prog_24_socket,
+		[7] = (void *)&dummy_prog_42_socket,
+	},
+};
+
+SEC("socket")
+__auxiliary __auxiliary_unpriv
+__naked void dummy_prog_42_socket(void)
+{
+	asm volatile ("r0 = 42; exit;");
+}
+
+SEC("socket")
+__auxiliary __auxiliary_unpriv
+__naked void dummy_prog_24_socket(void)
+{
+	asm volatile ("r0 = 24; exit;");
+}
+
+SEC("socket")
+__auxiliary __auxiliary_unpriv
+__naked void dummy_prog_loop1_socket(void)
+{
+	asm volatile ("			\
+	r3 = 1;				\
+	r2 = %[map_prog1_socket] ll;	\
+	call %[bpf_tail_call];		\
+	r0 = 41;			\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__auxiliary __auxiliary_unpriv
+__naked void dummy_prog_loop2_socket(void)
+{
+	asm volatile ("			\
+	r3 = 1;				\
+	r2 = %[map_prog2_socket] ll;	\
+	call %[bpf_tail_call];		\
+	r0 = 41;			\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog2_socket)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("calls: two calls returning different map pointers for lookup (hash, array)")
+__success __retval(1)
+__naked void pointers_for_lookup_hash_array(void)
+{
+	asm volatile ("					\
+	/* main prog */					\
+	if r1 != 0 goto l0_%=;				\
+	call pointers_for_lookup_hash_array__1;		\
+	goto l1_%=;					\
+l0_%=:	call pointers_for_lookup_hash_array__2;		\
+l1_%=:	r1 = r0;					\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+	r0 = 1;						\
+l2_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void pointers_for_lookup_hash_array__1(void)
+{
+	asm volatile ("					\
+	r0 = %[map_hash_48b] ll;			\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void pointers_for_lookup_hash_array__2(void)
+{
+	asm volatile ("					\
+	r0 = %[map_array_48b] ll;			\
+	exit;						\
+"	:
+	: __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("calls: two calls returning different map pointers for lookup (hash, map in map)")
+__failure __msg("only read from bpf_array is supported")
+__naked void lookup_hash_map_in_map(void)
+{
+	asm volatile ("					\
+	/* main prog */					\
+	if r1 != 0 goto l0_%=;				\
+	call lookup_hash_map_in_map__1;			\
+	goto l1_%=;					\
+l0_%=:	call lookup_hash_map_in_map__2;			\
+l1_%=:	r1 = r0;					\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+	r0 = 1;						\
+l2_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void lookup_hash_map_in_map__1(void)
+{
+	asm volatile ("					\
+	r0 = %[map_array_48b] ll;			\
+	exit;						\
+"	:
+	: __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void lookup_hash_map_in_map__2(void)
+{
+	asm volatile ("					\
+	r0 = %[map_in_map] ll;				\
+	exit;						\
+"	:
+	: __imm_addr(map_in_map)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("cond: two branches returning different map pointers for lookup (tail, tail)")
+__success __failure_unpriv __msg_unpriv("tail_call abusing map_ptr")
+__retval(42)
+__naked void pointers_for_lookup_tail_tail_1(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	if r6 != 0 goto l0_%=;				\
+	r2 = %[map_prog2_socket] ll;			\
+	goto l1_%=;					\
+l0_%=:	r2 = %[map_prog1_socket] ll;			\
+l1_%=:	r3 = 7;						\
+	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket),
+	  __imm_addr(map_prog2_socket),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("cond: two branches returning same map pointers for lookup (tail, tail)")
+__success __success_unpriv __retval(42)
+__naked void pointers_for_lookup_tail_tail_2(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	if r6 == 0 goto l0_%=;				\
+	r2 = %[map_prog2_socket] ll;			\
+	goto l1_%=;					\
+l0_%=:	r2 = %[map_prog2_socket] ll;			\
+l1_%=:	r3 = 7;						\
+	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog2_socket),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c b/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
deleted file mode 100644
index 1f2b8c4cb26d..000000000000
--- a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
+++ /dev/null
@@ -1,100 +0,0 @@
-{
-	"calls: two calls returning different map pointers for lookup (hash, array)",
-	.insns = {
-	/* main prog */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_CALL_REL(11),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_CALL_REL(12),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	/* subprog 1 */
-	BPF_LD_MAP_FD(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	/* subprog 2 */
-	BPF_LD_MAP_FD(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.fixup_map_hash_48b = { 13 },
-	.fixup_map_array_48b = { 16 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"calls: two calls returning different map pointers for lookup (hash, map in map)",
-	.insns = {
-	/* main prog */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_CALL_REL(11),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_CALL_REL(12),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	/* subprog 1 */
-	BPF_LD_MAP_FD(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	/* subprog 2 */
-	BPF_LD_MAP_FD(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.fixup_map_in_map = { 16 },
-	.fixup_map_array_48b = { 13 },
-	.result = REJECT,
-	.errstr = "only read from bpf_array is supported",
-},
-{
-	"cond: two branches returning different map pointers for lookup (tail, tail)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 3),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 5 },
-	.fixup_prog2 = { 2 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "tail_call abusing map_ptr",
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"cond: two branches returning same map pointers for lookup (tail, tail)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 3),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 7),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog2 = { 2, 5 },
-	.result_unpriv = ACCEPT,
-	.result = ACCEPT,
-	.retval = 42,
-},
-- 
2.40.0

