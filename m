Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A626C8A7C
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjCYC4y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjCYC4x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9564D1ADEF
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s13so2093173wmr.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuoPS0z3OrblFTOSL3To5B/Bdj1+Ra3acfQsNMIi6ug=;
        b=XOeGyHamtDOrRv+ucse9lkTg34PPV2jDGsaiNqL4o9ODNKdcDM0EaMcLCO+boeZKd/
         9AQbQ93GNzLpgbxRPZBRPIW+bJ3Ys0dpTuqsRXMjC5ejNEmxrH8ojBQJqhIBluhxcHx8
         qJqWgHpI1Qry56UE/s/47p6iMLx6IK10H5r0pVnbP0H9WgBLAZFRCF/4pocSH6HMktGX
         HaCo/R6XnctktWKh8pxcx7ePHP4zVBTJbS1vhN1CPaFdsh9WWmjz7Rhmd5p5wwg2TixZ
         Xkl7eMCaC0Hjy8fSas/Kh8nY12AN//xjuBpQa3Bxp4aY1Cc4lAXIiC7y4m1dZ04LhA1A
         GTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuoPS0z3OrblFTOSL3To5B/Bdj1+Ra3acfQsNMIi6ug=;
        b=Iw+sIBtTgL7N6TGNbRvs7mHVb1VBCnKmsUD2XdfOrImiKdbzx1zdFmffldei3+p1pL
         QgXkotH6HFK5Yws3F0PrKuTCXcVjftqOj7sfQTjTDLP/mgtCvnfIauKR1k69sxT2Iyma
         0VvQyWohMNYQ3XccFHNw2rhVbzW+ejhght4WRruklr0DfgyzL9yCLm+AQcutIcGACWnB
         XSQypo37eyWuRcquPdyCSFq/zi0m/oE+NaiJIq6WH4IsdFYthUVlL0DGINziXYkRJxUl
         GQrTEUy+FfXfR3fY21hTNdXAvhUkCJu1I+xqX3ZPJMYypYLnrj0GsyPKACYj/samFbLV
         5zAw==
X-Gm-Message-State: AO0yUKWY3Bu2esy5EkB0xQ55IlBBmkjj3+C+hcIdRdIyvGbLaCBspvTD
        wrt60ZwM7mWC7juvqXJWa140rtFoiiM=
X-Google-Smtp-Source: AK7set+XMwdl8LlEGa0ojYi0q5NgvmTmJ41ljgJ1LpG4MK875iGntWNVTG/ZNT9iwY42UWDc/4/gDg==
X-Received: by 2002:a7b:c8c3:0:b0:3ed:f966:b272 with SMTP id f3-20020a7bc8c3000000b003edf966b272mr3849192wml.9.1679712998774;
        Fri, 24 Mar 2023 19:56:38 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:37 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 33/43] selftests/bpf: verifier/ringbuf.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:14 +0200
Message-Id: <20230325025524.144043-34-eddyz87@gmail.com>
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

Test verifier/ringbuf.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_ringbuf.c    | 131 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/ringbuf.c  |  95 -------------
 3 files changed, 133 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ringbuf.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ringbuf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index f7488904f26e..df5fc6fe1647 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -30,6 +30,7 @@
 #include "verifier_meta_access.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
+#include "verifier_ringbuf.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -82,3 +83,4 @@ void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
+void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ringbuf.c b/tools/testing/selftests/bpf/progs/verifier_ringbuf.c
new file mode 100644
index 000000000000..ae1d521f326c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ringbuf.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/ringbuf.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} map_ringbuf SEC(".maps");
+
+SEC("socket")
+__description("ringbuf: invalid reservation offset 1")
+__failure __msg("R1 must have zero offset when passed to release func")
+__failure_unpriv
+__naked void ringbuf_invalid_reservation_offset_1(void)
+{
+	asm volatile ("					\
+	/* reserve 8 byte ringbuf memory */		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_ringbuf_reserve];			\
+	/* store a pointer to the reserved memory in R6 */\
+	r6 = r0;					\
+	/* check whether the reservation was successful */\
+	if r0 == 0 goto l0_%=;				\
+	/* spill R6(mem) into the stack */		\
+	*(u64*)(r10 - 8) = r6;				\
+	/* fill it back in R7 */			\
+	r7 = *(u64*)(r10 - 8);				\
+	/* should be able to access *(R7) = 0 */	\
+	r1 = 0;						\
+	*(u64*)(r7 + 0) = r1;				\
+	/* submit the reserved ringbuf memory */	\
+	r1 = r7;					\
+	/* add invalid offset to reserved ringbuf memory */\
+	r1 += 0xcafe;					\
+	r2 = 0;						\
+	call %[bpf_ringbuf_submit];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_submit),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ringbuf: invalid reservation offset 2")
+__failure __msg("R7 min value is outside of the allowed memory range")
+__failure_unpriv
+__naked void ringbuf_invalid_reservation_offset_2(void)
+{
+	asm volatile ("					\
+	/* reserve 8 byte ringbuf memory */		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_ringbuf_reserve];			\
+	/* store a pointer to the reserved memory in R6 */\
+	r6 = r0;					\
+	/* check whether the reservation was successful */\
+	if r0 == 0 goto l0_%=;				\
+	/* spill R6(mem) into the stack */		\
+	*(u64*)(r10 - 8) = r6;				\
+	/* fill it back in R7 */			\
+	r7 = *(u64*)(r10 - 8);				\
+	/* add invalid offset to reserved ringbuf memory */\
+	r7 += 0xcafe;					\
+	/* should be able to access *(R7) = 0 */	\
+	r1 = 0;						\
+	*(u64*)(r7 + 0) = r1;				\
+	/* submit the reserved ringbuf memory */	\
+	r1 = r7;					\
+	r2 = 0;						\
+	call %[bpf_ringbuf_submit];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_submit),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("ringbuf: check passing rb mem to helpers")
+__success __retval(0)
+__naked void passing_rb_mem_to_helpers(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	/* reserve 8 byte ringbuf memory */		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_ringbuf_reserve];			\
+	r7 = r0;					\
+	/* check whether the reservation was successful */\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	/* pass allocated ring buffer memory to fib lookup */\
+	r1 = r6;					\
+	r2 = r0;					\
+	r3 = 8;						\
+	r4 = 0;						\
+	call %[bpf_fib_lookup];				\
+	/* submit the ringbuf memory */			\
+	r1 = r7;					\
+	r2 = 0;						\
+	call %[bpf_ringbuf_submit];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_fib_lookup),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_submit),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/ringbuf.c b/tools/testing/selftests/bpf/verifier/ringbuf.c
deleted file mode 100644
index 92e3f6a61a79..000000000000
--- a/tools/testing/selftests/bpf/verifier/ringbuf.c
+++ /dev/null
@@ -1,95 +0,0 @@
-{
-	"ringbuf: invalid reservation offset 1",
-	.insns = {
-	/* reserve 8 byte ringbuf memory */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
-	/* store a pointer to the reserved memory in R6 */
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	/* spill R6(mem) into the stack */
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
-	/* fill it back in R7 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, -8),
-	/* should be able to access *(R7) = 0 */
-	BPF_ST_MEM(BPF_DW, BPF_REG_7, 0, 0),
-	/* submit the reserved ringbuf memory */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	/* add invalid offset to reserved ringbuf memory */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xcafe),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 1 },
-	.result = REJECT,
-	.errstr = "R1 must have zero offset when passed to release func",
-},
-{
-	"ringbuf: invalid reservation offset 2",
-	.insns = {
-	/* reserve 8 byte ringbuf memory */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
-	/* store a pointer to the reserved memory in R6 */
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	/* spill R6(mem) into the stack */
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
-	/* fill it back in R7 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, -8),
-	/* add invalid offset to reserved ringbuf memory */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, 0xcafe),
-	/* should be able to access *(R7) = 0 */
-	BPF_ST_MEM(BPF_DW, BPF_REG_7, 0, 0),
-	/* submit the reserved ringbuf memory */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 1 },
-	.result = REJECT,
-	.errstr = "R7 min value is outside of the allowed memory range",
-},
-{
-	"ringbuf: check passing rb mem to helpers",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	/* reserve 8 byte ringbuf memory */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	/* pass allocated ring buffer memory to fib lookup */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, 8),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_fib_lookup),
-	/* submit the ringbuf memory */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 2 },
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.result = ACCEPT,
-},
-- 
2.40.0

