Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60756C8A73
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjCYC4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjCYC4f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65EE1ADF2
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso2015420wmo.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiaqMExy4zobUrQrPa6AqBA/PE0WJgxlhG4RjZo6acA=;
        b=fDlvs5Wdkh3YqAMdX1q0DzgpTFEBH8FwzCtw4yMUbkWwR/VpnNc61cCbozAiXKcVhS
         62OXp10sQ36ZHRdxv/b0UFfDvJfihHfEwcdCLKxqO+PtdlYUZq4UFyhPf0uhS9TgdrkV
         RjWk9g7SzD8yBAxHFuBPuv8JDvFWh+4pf00HxBEFCUvjIuvHYVzWp0vLXvqCQ0wA/uxt
         cqJhRmYld5q6JbHR/Al4baa3sIdsy3KN1keinXpWHdQZsCIPE7gyI45p+9dYQVBo1COX
         DSMXEHL4cMoDakbdCwu5pAF8HRVvZ1cwXfe5Xvq+gl4DecUoSs1G/9hdW4n1E6u3eLax
         T3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiaqMExy4zobUrQrPa6AqBA/PE0WJgxlhG4RjZo6acA=;
        b=uP/picBLIO5Sznm5dHQ/ujmJoChDxTmv46qqGts0/X6ZT2FfsKM4ia9FFoUliDj2Yi
         0CSm4+V1BOBSx5b9dDicLuH4NMbhocS35uFM4GjF3HhyxRwAl0E6mkPes4QyNy9SxSS6
         YWutlOhMbXgwoLnAdrxKo4OlyEIwBE9PayJDUhm+cF07wb1c6xbSUpEccdQ5o8v2vT3U
         L6y/qRSIKXIpRboUB/BVRHm9Z3hGY9qbmMvqVcnQ4K8uwnhrJu7PSt2cSYu8I/XYP/35
         Zx2M7fxRcU06URfPDbO8Bu5nybe0XDM68jjiqoQuWuIZUwj6cfMZVryAPnct98LXvsim
         K2+Q==
X-Gm-Message-State: AO0yUKUaLTQ7dcCX+MeLaBrGqjlaFgOmF9YO/5CrCYZVH+2dKcdZLqK+
        bTfBXJDUO22MC9/d1BHDh+gzxiNxRRU=
X-Google-Smtp-Source: AK7set9StroKzbPlbQBL6AvQ6K0hgUxvg1ORRMphVQm5sbL5M1xUXzQJQQ/0RLyUl8S4YUk1hm/X3g==
X-Received: by 2002:a7b:c413:0:b0:3ee:4531:8448 with SMTP id k19-20020a7bc413000000b003ee45318448mr4159909wmi.39.1679712988213;
        Fri, 24 Mar 2023 19:56:28 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:27 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 25/43] selftests/bpf: verifier/ld_ind.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:06 +0200
Message-Id: <20230325025524.144043-26-eddyz87@gmail.com>
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

Test verifier/ld_ind.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_ld_ind.c     | 110 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/ld_ind.c |  72 ------------
 3 files changed, 112 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ld_ind.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ld_ind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d9180da30f1b..d8d4464b6112 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -22,6 +22,7 @@
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
 #include "verifier_int_ptr.skel.h"
+#include "verifier_ld_ind.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -66,3 +67,4 @@ void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_acces
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
+void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ld_ind.c b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
new file mode 100644
index 000000000000..c925ba9a2e74
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/ld_ind.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("ld_ind: check calling conv, r1")
+__failure __msg("R1 !read_ok")
+__failure_unpriv
+__naked void ind_check_calling_conv_r1(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 1;						\
+	.8byte %[ld_ind];				\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_1, -0x200000))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_ind: check calling conv, r2")
+__failure __msg("R2 !read_ok")
+__failure_unpriv
+__naked void ind_check_calling_conv_r2(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r2 = 1;						\
+	.8byte %[ld_ind];				\
+	r0 = r2;					\
+	exit;						\
+"	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_2, -0x200000))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_ind: check calling conv, r3")
+__failure __msg("R3 !read_ok")
+__failure_unpriv
+__naked void ind_check_calling_conv_r3(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r3 = 1;						\
+	.8byte %[ld_ind];				\
+	r0 = r3;					\
+	exit;						\
+"	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_3, -0x200000))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_ind: check calling conv, r4")
+__failure __msg("R4 !read_ok")
+__failure_unpriv
+__naked void ind_check_calling_conv_r4(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r4 = 1;						\
+	.8byte %[ld_ind];				\
+	r0 = r4;					\
+	exit;						\
+"	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_4, -0x200000))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_ind: check calling conv, r5")
+__failure __msg("R5 !read_ok")
+__failure_unpriv
+__naked void ind_check_calling_conv_r5(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r5 = 1;						\
+	.8byte %[ld_ind];				\
+	r0 = r5;					\
+	exit;						\
+"	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_5, -0x200000))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_ind: check calling conv, r7")
+__success __success_unpriv __retval(1)
+__naked void ind_check_calling_conv_r7(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r7 = 1;						\
+	.8byte %[ld_ind];				\
+	r0 = r7;					\
+	exit;						\
+"	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_7, -0x200000))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/ld_ind.c b/tools/testing/selftests/bpf/verifier/ld_ind.c
deleted file mode 100644
index 079734227538..000000000000
--- a/tools/testing/selftests/bpf/verifier/ld_ind.c
+++ /dev/null
@@ -1,72 +0,0 @@
-{
-	"ld_ind: check calling conv, r1",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_LD_IND(BPF_W, BPF_REG_1, -0x200000),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R1 !read_ok",
-	.result = REJECT,
-},
-{
-	"ld_ind: check calling conv, r2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_2, 1),
-	BPF_LD_IND(BPF_W, BPF_REG_2, -0x200000),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R2 !read_ok",
-	.result = REJECT,
-},
-{
-	"ld_ind: check calling conv, r3",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_LD_IND(BPF_W, BPF_REG_3, -0x200000),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_3),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R3 !read_ok",
-	.result = REJECT,
-},
-{
-	"ld_ind: check calling conv, r4",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_4, 1),
-	BPF_LD_IND(BPF_W, BPF_REG_4, -0x200000),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_4),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R4 !read_ok",
-	.result = REJECT,
-},
-{
-	"ld_ind: check calling conv, r5",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_5, 1),
-	BPF_LD_IND(BPF_W, BPF_REG_5, -0x200000),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_5),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R5 !read_ok",
-	.result = REJECT,
-},
-{
-	"ld_ind: check calling conv, r7",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_7, 1),
-	BPF_LD_IND(BPF_W, BPF_REG_7, -0x200000),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_7),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 1,
-},
-- 
2.40.0

