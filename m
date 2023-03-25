Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942646C8A84
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjCYC5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjCYC5H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:57:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994B1B2E7
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r11so3494051wrr.12
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679713009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwPKvU/ifubMiBnY9EDiaadqwE4yYtdlmBJn4EFKqdU=;
        b=aU8jk0D7QCXE3zW6kqtYSdu7F/QWD1deCgOWoFViLvL0amLfxttVvYD6QRH2pltpn8
         Ypp8LqiB68HjhmXclArbL9+ISrBBu5rxjWZnQQ8DO3dJchZwMCl7XWuS69X0cvBF1mBG
         53X2Dl1LKfJbt5voyDrG+HycEbbFfubtE3eijsjOidSTiI6APk/nIpZTIOJipMJGvhnM
         BpGZiwCG60oop4fRMAr7iA31UvAFNSicje5Wc/BO9vsGoSqHnngqTfFcfuRhnXrZ/y11
         vuek1eM6banhm6MEbDdC1j4eoSYkF/Bq0FBuueQn530IFynmmW6pQAX0cVZTMSepFi8w
         YsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwPKvU/ifubMiBnY9EDiaadqwE4yYtdlmBJn4EFKqdU=;
        b=YyT7f+I3sl94sMaZSShJtJffRIAAf8JsZkPzSKYzaeGw4Jw6uIvteVuQD0xFG1L9o4
         MgaP6zzDt+PW9ON885RUn2JNshovIpX6x0pQoqMnbPq00BTWXN4BXVkzojRxzTa3HsG3
         uv71U1GJbv4R613ws2oRzWZDxc3NYYw74dh9JG7jyEiXm0zuidwAYUdVqba5yZO8Inab
         K72kgpny8NMFPPfSx1FZp2mI+JECW3Mlst2+SYsX9xiU+aHxjvxS/2e1ogm1IpF6B8kb
         VaSJNYcQ0WpA2jFnCzEBwlVpkwDFh4G0YSfLHJEeihIkTHKlEgH6iEYRCDLAZ+WVcGLR
         Y0vA==
X-Gm-Message-State: AAQBX9f3IAYn7HrUU0e1MtMM7+92AY7HJk5ObQf11snGtjIwr1rRt/I5
        FJpVhVnw0XkNGsRL1dihyrJP9bjac+Y=
X-Google-Smtp-Source: AKy350Y6fJOuGNsbAxjXhOh0jQRmo0yR6IfF+Kq+PcGPRFNPEPbvurW6H+U1hr80BZKTBiUh3B/Veg==
X-Received: by 2002:a5d:4641:0:b0:2cb:c474:7597 with SMTP id j1-20020a5d4641000000b002cbc4747597mr3935370wrs.66.1679713009310;
        Fri, 24 Mar 2023 19:56:49 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:48 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 41/43] selftests/bpf: verifier/xadd.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:22 +0200
Message-Id: <20230325025524.144043-42-eddyz87@gmail.com>
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

Test verifier/xadd.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_xadd.c       | 124 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/xadd.c   |  97 --------------
 3 files changed, 126 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_xadd.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/xadd.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 44350e328da2..cd56fe520145 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -38,6 +38,7 @@
 #include "verifier_value.skel.h"
 #include "verifier_value_or_null.skel.h"
 #include "verifier_var_off.skel.h"
+#include "verifier_xadd.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -98,3 +99,4 @@ void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
 void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
 void test_verifier_var_off(void)              { RUN(verifier_var_off); }
+void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_xadd.c b/tools/testing/selftests/bpf/progs/verifier_xadd.c
new file mode 100644
index 000000000000..05a0a55adb45
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_xadd.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/xadd.c */
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
+SEC("tc")
+__description("xadd/w check unaligned stack")
+__failure __msg("misaligned stack access off")
+__naked void xadd_w_check_unaligned_stack(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	*(u64*)(r10 - 8) = r0;				\
+	lock *(u32 *)(r10 - 7) += w0;			\
+	r0 = *(u64*)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("xadd/w check unaligned map")
+__failure __msg("misaligned value access off")
+__naked void xadd_w_check_unaligned_map(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = 1;						\
+	lock *(u32 *)(r0 + 3) += w1;			\
+	r0 = *(u32*)(r0 + 3);				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("xadd/w check unaligned pkt")
+__failure __msg("BPF_ATOMIC stores into R2 pkt is not allowed")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void xadd_w_check_unaligned_pkt(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 < r3 goto l0_%=;				\
+	r0 = 99;					\
+	goto l1_%=;					\
+l0_%=:	r0 = 1;						\
+	r1 = 0;						\
+	*(u32*)(r2 + 0) = r1;				\
+	r1 = 0;						\
+	*(u32*)(r2 + 3) = r1;				\
+	lock *(u32 *)(r2 + 1) += w0;			\
+	lock *(u32 *)(r2 + 2) += w0;			\
+	r0 = *(u32*)(r2 + 1);				\
+l1_%=:	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("xadd/w check whether src/dst got mangled, 1")
+__success __retval(3)
+__naked void src_dst_got_mangled_1(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	r6 = r0;					\
+	r7 = r10;					\
+	*(u64*)(r10 - 8) = r0;				\
+	lock *(u64 *)(r10 - 8) += r0;			\
+	lock *(u64 *)(r10 - 8) += r0;			\
+	if r6 != r0 goto l0_%=;				\
+	if r7 != r10 goto l0_%=;			\
+	r0 = *(u64*)(r10 - 8);				\
+	exit;						\
+l0_%=:	r0 = 42;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("xadd/w check whether src/dst got mangled, 2")
+__success __retval(3)
+__naked void src_dst_got_mangled_2(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	r6 = r0;					\
+	r7 = r10;					\
+	*(u32*)(r10 - 8) = r0;				\
+	lock *(u32 *)(r10 - 8) += w0;			\
+	lock *(u32 *)(r10 - 8) += w0;			\
+	if r6 != r0 goto l0_%=;				\
+	if r7 != r10 goto l0_%=;			\
+	r0 = *(u32*)(r10 - 8);				\
+	exit;						\
+l0_%=:	r0 = 42;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/xadd.c b/tools/testing/selftests/bpf/verifier/xadd.c
deleted file mode 100644
index b96ef3526815..000000000000
--- a/tools/testing/selftests/bpf/verifier/xadd.c
+++ /dev/null
@@ -1,97 +0,0 @@
-{
-	"xadd/w check unaligned stack",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_10, BPF_REG_0, -7),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "misaligned stack access off",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"xadd/w check unaligned map",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_0, BPF_REG_1, 3),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 3),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = REJECT,
-	.errstr = "misaligned value access off",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"xadd/w check unaligned pkt",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 99),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 6),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_ST_MEM(BPF_W, BPF_REG_2, 3, 0),
-	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_2, BPF_REG_0, 1),
-	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_2, BPF_REG_0, 2),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 1),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "BPF_ATOMIC stores into R2 pkt is not allowed",
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"xadd/w check whether src/dst got mangled, 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_0, 3),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_10, 2),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.retval = 3,
-},
-{
-	"xadd/w check whether src/dst got mangled, 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -8),
-	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
-	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_10, BPF_REG_0, -8),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_0, 3),
-	BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_10, 2),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.retval = 3,
-},
-- 
2.40.0

