Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2773C6C8A79
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjCYC4r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjCYC4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4322E193F4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so3540893wrd.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBWBp54T0iO6u/2HpSC40hQWnx75wn2e49A++553KHY=;
        b=MadgBoe/N+SaVX/ZMD46dG5t3e46GwS37XOxBtcAma1lB/tsLUHfwRa2YeX2EPYgeB
         cheO3P6eVUQzL8idByqcvwdkwfmRLx36+i8jYo79k8qb9IJFdBy+B4Zf9O2f24mmgD7o
         R314zjD4syvhj/HyB8/hHp9pVe1qhiyNJhOtpYMCzCezraqPUM9RqNMC8qk98yVnuJ+f
         Uma4FAOTkTfhX5F8Wf/K0efUHk7txH/ktY7EjCDBPFMTxusta4/2neO43cXg7MHC09N/
         eyI6a8NNBoEgrlRi18VlWzJSocGpX2szAibyBjogWLUDQ8EEl+ttXP4zjvIDLGj37k5x
         IV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBWBp54T0iO6u/2HpSC40hQWnx75wn2e49A++553KHY=;
        b=QuMV4izdoHi0hoDnLlF2O2jWj5bY+oNNqNLzrfkwUt8Q938tPK/9xlDgOO+xRIP1Uw
         p1fgI5fmqLyPEFvKZZdIGzZ4s2DsHARdCCrP4BOuY9Pil8A9zWMwNEiAL6JgVyln5FGg
         CyCAkg47qWhRnEb4p5dD6MvCxg3LuhqOPXl0LSjOxfyVVATrBzPVWUS9EHrYvowRiAO6
         nNoPfcWT8QpY3qnnjm6JiqQQ2hE8CuM1OQb4E7Af1juJCTpR+91uQaRluxjtdkkMWc2K
         gmfTghV+YRYsdgjOUhB9IY4Su35lE92D2HkoAcwaiMLTw8xE9VGtKp+EZt3nk9V0eiTy
         q0VA==
X-Gm-Message-State: AAQBX9cY957m2yuuRfTuQ0ErBFuBD6efTJnoAuYZLbGkFnSz70ORJb5M
        co+KN2VCTzc+dZhpn3f7mqNX437pAok=
X-Google-Smtp-Source: AKy350ZZyCXKHE55qwz4n+PbT3YDlecnm5sCfqC5sji2LWxxN71D+0wouk7KR8EpI/LaW3LRXPkBQw==
X-Received: by 2002:adf:ef84:0:b0:2d7:783b:dc08 with SMTP id d4-20020adfef84000000b002d7783bdc08mr3940722wro.39.1679712994510;
        Fri, 24 Mar 2023 19:56:34 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:33 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 30/43] selftests/bpf: verifier/meta_access.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:11 +0200
Message-Id: <20230325025524.144043-31-eddyz87@gmail.com>
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

Test verifier/meta_access.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_meta_access.c          | 284 ++++++++++++++++++
 .../selftests/bpf/verifier/meta_access.c      | 235 ---------------
 3 files changed, 286 insertions(+), 235 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_meta_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/meta_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b23fcbe4f83b..bd48a584a356 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -27,6 +27,7 @@
 #include "verifier_map_ptr.skel.h"
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
+#include "verifier_meta_access.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -76,3 +77,4 @@ void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
+void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_meta_access.c b/tools/testing/selftests/bpf/progs/verifier_meta_access.c
new file mode 100644
index 000000000000..d81722fb5f19
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_meta_access.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/meta_access.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("xdp")
+__description("meta access, test1")
+__success __retval(0)
+__naked void meta_access_test1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test2")
+__failure __msg("invalid access to packet, off=-8")
+__naked void meta_access_test2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r0 = r2;					\
+	r0 -= 8;					\
+	r4 = r2;					\
+	r4 += 8;					\
+	if r4 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test3")
+__failure __msg("invalid access to packet")
+__naked void meta_access_test3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test4")
+__failure __msg("invalid access to packet")
+__naked void meta_access_test4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r4 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r0 = r4;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test5")
+__failure __msg("R3 !read_ok")
+__naked void meta_access_test5(void)
+{
+	asm volatile ("					\
+	r3 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r4 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r0 = r3;					\
+	r0 += 8;					\
+	if r0 > r4 goto l0_%=;				\
+	r2 = -8;					\
+	call %[bpf_xdp_adjust_meta];			\
+	r0 = *(u8*)(r3 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_xdp_adjust_meta),
+	  __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test6")
+__failure __msg("invalid access to packet")
+__naked void meta_access_test6(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r0 = r3;					\
+	r0 += 8;					\
+	r4 = r2;					\
+	r4 += 8;					\
+	if r4 > r0 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test7")
+__success __retval(0)
+__naked void meta_access_test7(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r0 = r3;					\
+	r0 += 8;					\
+	r4 = r2;					\
+	r4 += 8;					\
+	if r4 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test8")
+__success __retval(0)
+__naked void meta_access_test8(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r4 = r2;					\
+	r4 += 0xFFFF;					\
+	if r4 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test9")
+__failure __msg("invalid access to packet")
+__naked void meta_access_test9(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r4 = r2;					\
+	r4 += 0xFFFF;					\
+	r4 += 1;					\
+	if r4 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test10")
+__failure __msg("invalid access to packet")
+__naked void meta_access_test10(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r4 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r5 = 42;					\
+	r6 = 24;					\
+	*(u64*)(r10 - 8) = r5;				\
+	lock *(u64 *)(r10 - 8) += r6;			\
+	r5 = *(u64*)(r10 - 8);				\
+	if r5 > 100 goto l0_%=;				\
+	r3 += r5;					\
+	r5 = r3;					\
+	r6 = r2;					\
+	r6 += 8;					\
+	if r6 > r5 goto l0_%=;				\
+	r2 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test11")
+__success __retval(0)
+__naked void meta_access_test11(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r5 = 42;					\
+	r6 = 24;					\
+	*(u64*)(r10 - 8) = r5;				\
+	lock *(u64 *)(r10 - 8) += r6;			\
+	r5 = *(u64*)(r10 - 8);				\
+	if r5 > 100 goto l0_%=;				\
+	r2 += r5;					\
+	r5 = r2;					\
+	r6 = r2;					\
+	r6 += 8;					\
+	if r6 > r3 goto l0_%=;				\
+	r5 = *(u8*)(r5 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("meta access, test12")
+__success __retval(0)
+__naked void meta_access_test12(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r4 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r5 = r3;					\
+	r5 += 16;					\
+	if r5 > r4 goto l0_%=;				\
+	r0 = *(u8*)(r3 + 0);				\
+	r5 = r2;					\
+	r5 += 16;					\
+	if r5 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/meta_access.c b/tools/testing/selftests/bpf/verifier/meta_access.c
deleted file mode 100644
index b45e8af41420..000000000000
--- a/tools/testing/selftests/bpf/verifier/meta_access.c
+++ /dev/null
@@ -1,235 +0,0 @@
-{
-	"meta access, test1",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test2",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 8),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet, off=-8",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test3",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test4",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct xdp_md, data_end)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_4),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test5",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_4, 3),
-	BPF_MOV64_IMM(BPF_REG_2, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_xdp_adjust_meta),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R3 !read_ok",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test6",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_0, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test7",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test8",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 0xFFFF),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test9",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 0xFFFF),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test10",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,
-		    offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_IMM(BPF_REG_5, 42),
-	BPF_MOV64_IMM(BPF_REG_6, 24),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_5, -8),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_6, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -8),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_5, 100, 6),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_5),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_5, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test11",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_MOV64_IMM(BPF_REG_5, 42),
-	BPF_MOV64_IMM(BPF_REG_6, 24),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_5, -8),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_6, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_10, -8),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_5, 100, 6),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_5),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_5, BPF_REG_5, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"meta access, test12",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, data_meta)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,
-		    offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 16),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_4, 5),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_3, 0),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 16),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-- 
2.40.0

