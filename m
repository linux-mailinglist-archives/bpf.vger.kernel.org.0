Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1066C8A74
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjCYC4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjCYC4h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2961B2C7
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so4161727wmq.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmE/6a9s2HqLu9SijUrvlHI1Cho+WM3XPSo2WaVp4iE=;
        b=TFOhxG7IHrsxmno94OGdNxkTLyiR2aJF52ogbAVsPQfgFyUZs/1Wz57gzequZOCpiU
         Z7HRKOtyBI8UTww2bWY9OHs9LIQ0uemSCoSz+8NSLhHpWvLYrVAzg5+6yW5s06lA/dll
         y8cWmsmYH6DnEC4i9MnqsIBSzqoV6YutYb7Yrcv4SmOlx/eiP4tQAAeIQyUmk0LS/IsI
         QKkImQ13YIgdAnarTEw3G1qirhB0FAaSc5mqwergn3cw/9BiSFEFt8D48dLtY2Jc65fz
         dKMPhbTZBUq28lKz1aXcAVQLbkhQWx1ZfUU711ZXrXka2Q+Uu0AwveUxcFrUiw7h45dJ
         kexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmE/6a9s2HqLu9SijUrvlHI1Cho+WM3XPSo2WaVp4iE=;
        b=eCoCVEbQ2iUUN/GoXf87mnZb/sjNax8ZifinrH/wDRIGNY470bdmZbpUZeabcOj980
         OaOWKkgCZqqNHKOjDNmUIhpoUQT2ToOUWpMMoRMaoPfKpgPI/27WN16skgF7GCqSgLkK
         tFqfriAY96m/XNS7hblHuIlIdi7XPNjz+xo+e8QyfQWfTA1w1dYaCI9grTr+oyt/8GBI
         j/GSKtzVT/NV+Eoxin7U77/PjzfY+5xc1YOQ+FXYjARHLnVwEIXHSk6DnZ2BY1p6EG1l
         H+edAN8PjJ72eYPMF2B/+1d9a/eqrlqn6VvIgvPGwP9v/vY5CPTdsg9k7yn/QLc+RQDg
         ZIVw==
X-Gm-Message-State: AO0yUKViPAQUDVLNjJBKtTRZF5BZ5rd+OdHKndLT+w2x+AiDeNc81GNK
        7e0I+f3lRkm+0EBaLXoZXm3yTJL7+OI=
X-Google-Smtp-Source: AK7set+jN1Yr4T1JNCtKKNwyAJedF/eFNMcdYMPdJJ+Zb3tTU4OStqAqPZgGPqjeTzLFqPivqN518w==
X-Received: by 2002:a05:600c:21c1:b0:3ed:8c60:c512 with SMTP id x1-20020a05600c21c100b003ed8c60c512mr4169202wmj.17.1679712987008;
        Fri, 24 Mar 2023 19:56:27 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:26 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 24/43] selftests/bpf: verifier/int_ptr.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:05 +0200
Message-Id: <20230325025524.144043-25-eddyz87@gmail.com>
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

Test verifier/int_ptr.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_int_ptr.c    | 157 +++++++++++++++++
 .../testing/selftests/bpf/verifier/int_ptr.c  | 161 ------------------
 3 files changed, 159 insertions(+), 161 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_int_ptr.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/int_ptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 2c3745a1fdcb..d9180da30f1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -21,6 +21,7 @@
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
+#include "verifier_int_ptr.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -64,3 +65,4 @@ void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
+void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
new file mode 100644
index 000000000000..b054f9c48143
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/int_ptr.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("cgroup/sysctl")
+__description("ARG_PTR_TO_LONG uninitialized")
+__failure __msg("invalid indirect read from stack R4 off -16+0 size 8")
+__naked void arg_ptr_to_long_uninitialized(void)
+{
+	asm volatile ("					\
+	/* bpf_strtoul arg1 (buf) */			\
+	r7 = r10;					\
+	r7 += -8;					\
+	r0 = 0x00303036;				\
+	*(u64*)(r7 + 0) = r0;				\
+	r1 = r7;					\
+	/* bpf_strtoul arg2 (buf_len) */		\
+	r2 = 4;						\
+	/* bpf_strtoul arg3 (flags) */			\
+	r3 = 0;						\
+	/* bpf_strtoul arg4 (res) */			\
+	r7 += -8;					\
+	r4 = r7;					\
+	/* bpf_strtoul() */				\
+	call %[bpf_strtoul];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_strtoul)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ARG_PTR_TO_LONG half-uninitialized")
+/* in privileged mode reads from uninitialized stack locations are permitted */
+__success __failure_unpriv
+__msg_unpriv("invalid indirect read from stack R4 off -16+4 size 8")
+__retval(0)
+__naked void ptr_to_long_half_uninitialized(void)
+{
+	asm volatile ("					\
+	/* bpf_strtoul arg1 (buf) */			\
+	r7 = r10;					\
+	r7 += -8;					\
+	r0 = 0x00303036;				\
+	*(u64*)(r7 + 0) = r0;				\
+	r1 = r7;					\
+	/* bpf_strtoul arg2 (buf_len) */		\
+	r2 = 4;						\
+	/* bpf_strtoul arg3 (flags) */			\
+	r3 = 0;						\
+	/* bpf_strtoul arg4 (res) */			\
+	r7 += -8;					\
+	*(u32*)(r7 + 0) = r0;				\
+	r4 = r7;					\
+	/* bpf_strtoul() */				\
+	call %[bpf_strtoul];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_strtoul)
+	: __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__description("ARG_PTR_TO_LONG misaligned")
+__failure __msg("misaligned stack access off (0x0; 0x0)+-20+0 size 8")
+__naked void arg_ptr_to_long_misaligned(void)
+{
+	asm volatile ("					\
+	/* bpf_strtoul arg1 (buf) */			\
+	r7 = r10;					\
+	r7 += -8;					\
+	r0 = 0x00303036;				\
+	*(u64*)(r7 + 0) = r0;				\
+	r1 = r7;					\
+	/* bpf_strtoul arg2 (buf_len) */		\
+	r2 = 4;						\
+	/* bpf_strtoul arg3 (flags) */			\
+	r3 = 0;						\
+	/* bpf_strtoul arg4 (res) */			\
+	r7 += -12;					\
+	r0 = 0;						\
+	*(u32*)(r7 + 0) = r0;				\
+	*(u64*)(r7 + 4) = r0;				\
+	r4 = r7;					\
+	/* bpf_strtoul() */				\
+	call %[bpf_strtoul];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_strtoul)
+	: __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__description("ARG_PTR_TO_LONG size < sizeof(long)")
+__failure __msg("invalid indirect access to stack R4 off=-4 size=8")
+__naked void to_long_size_sizeof_long(void)
+{
+	asm volatile ("					\
+	/* bpf_strtoul arg1 (buf) */			\
+	r7 = r10;					\
+	r7 += -16;					\
+	r0 = 0x00303036;				\
+	*(u64*)(r7 + 0) = r0;				\
+	r1 = r7;					\
+	/* bpf_strtoul arg2 (buf_len) */		\
+	r2 = 4;						\
+	/* bpf_strtoul arg3 (flags) */			\
+	r3 = 0;						\
+	/* bpf_strtoul arg4 (res) */			\
+	r7 += 12;					\
+	*(u32*)(r7 + 0) = r0;				\
+	r4 = r7;					\
+	/* bpf_strtoul() */				\
+	call %[bpf_strtoul];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_strtoul)
+	: __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__description("ARG_PTR_TO_LONG initialized")
+__success
+__naked void arg_ptr_to_long_initialized(void)
+{
+	asm volatile ("					\
+	/* bpf_strtoul arg1 (buf) */			\
+	r7 = r10;					\
+	r7 += -8;					\
+	r0 = 0x00303036;				\
+	*(u64*)(r7 + 0) = r0;				\
+	r1 = r7;					\
+	/* bpf_strtoul arg2 (buf_len) */		\
+	r2 = 4;						\
+	/* bpf_strtoul arg3 (flags) */			\
+	r3 = 0;						\
+	/* bpf_strtoul arg4 (res) */			\
+	r7 += -8;					\
+	*(u64*)(r7 + 0) = r0;				\
+	r4 = r7;					\
+	/* bpf_strtoul() */				\
+	call %[bpf_strtoul];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_strtoul)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/int_ptr.c b/tools/testing/selftests/bpf/verifier/int_ptr.c
deleted file mode 100644
index 02d9e004260b..000000000000
--- a/tools/testing/selftests/bpf/verifier/int_ptr.c
+++ /dev/null
@@ -1,161 +0,0 @@
-{
-	"ARG_PTR_TO_LONG uninitialized",
-	.insns = {
-		/* bpf_strtoul arg1 (buf) */
-		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
-		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-
-		/* bpf_strtoul arg2 (buf_len) */
-		BPF_MOV64_IMM(BPF_REG_2, 4),
-
-		/* bpf_strtoul arg3 (flags) */
-		BPF_MOV64_IMM(BPF_REG_3, 0),
-
-		/* bpf_strtoul arg4 (res) */
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
-
-		/* bpf_strtoul() */
-		BPF_EMIT_CALL(BPF_FUNC_strtoul),
-
-		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid indirect read from stack R4 off -16+0 size 8",
-},
-{
-	"ARG_PTR_TO_LONG half-uninitialized",
-	.insns = {
-		/* bpf_strtoul arg1 (buf) */
-		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
-		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-
-		/* bpf_strtoul arg2 (buf_len) */
-		BPF_MOV64_IMM(BPF_REG_2, 4),
-
-		/* bpf_strtoul arg3 (flags) */
-		BPF_MOV64_IMM(BPF_REG_3, 0),
-
-		/* bpf_strtoul arg4 (res) */
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-		BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
-		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
-
-		/* bpf_strtoul() */
-		BPF_EMIT_CALL(BPF_FUNC_strtoul),
-
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "invalid indirect read from stack R4 off -16+4 size 8",
-	/* in privileged mode reads from uninitialized stack locations are permitted */
-	.result = ACCEPT,
-},
-{
-	"ARG_PTR_TO_LONG misaligned",
-	.insns = {
-		/* bpf_strtoul arg1 (buf) */
-		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
-		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-
-		/* bpf_strtoul arg2 (buf_len) */
-		BPF_MOV64_IMM(BPF_REG_2, 4),
-
-		/* bpf_strtoul arg3 (flags) */
-		BPF_MOV64_IMM(BPF_REG_3, 0),
-
-		/* bpf_strtoul arg4 (res) */
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -12),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
-		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 4),
-		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
-
-		/* bpf_strtoul() */
-		BPF_EMIT_CALL(BPF_FUNC_strtoul),
-
-		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "misaligned stack access off (0x0; 0x0)+-20+0 size 8",
-},
-{
-	"ARG_PTR_TO_LONG size < sizeof(long)",
-	.insns = {
-		/* bpf_strtoul arg1 (buf) */
-		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -16),
-		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
-		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-
-		/* bpf_strtoul arg2 (buf_len) */
-		BPF_MOV64_IMM(BPF_REG_2, 4),
-
-		/* bpf_strtoul arg3 (flags) */
-		BPF_MOV64_IMM(BPF_REG_3, 0),
-
-		/* bpf_strtoul arg4 (res) */
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, 12),
-		BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
-		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
-
-		/* bpf_strtoul() */
-		BPF_EMIT_CALL(BPF_FUNC_strtoul),
-
-		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid indirect access to stack R4 off=-4 size=8",
-},
-{
-	"ARG_PTR_TO_LONG initialized",
-	.insns = {
-		/* bpf_strtoul arg1 (buf) */
-		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
-		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-
-		/* bpf_strtoul arg2 (buf_len) */
-		BPF_MOV64_IMM(BPF_REG_2, 4),
-
-		/* bpf_strtoul arg3 (flags) */
-		BPF_MOV64_IMM(BPF_REG_3, 0),
-
-		/* bpf_strtoul arg4 (res) */
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
-
-		/* bpf_strtoul() */
-		BPF_EMIT_CALL(BPF_FUNC_strtoul),
-
-		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-},
-- 
2.40.0

