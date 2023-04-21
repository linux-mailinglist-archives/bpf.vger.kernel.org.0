Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214AA6EB0DC
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjDURn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjDURnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA811BFC
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2fddb442d47so1845587f8f.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098972; x=1684690972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIY93kluNmo8IdAK/xBD53faZl2yu1KIRdFHLx14s00=;
        b=gTkzlvsSZz40oszOa472G1feYx4vcsFF3sWPXTbDI2FXqt68DVdtQIMu4mh7WHkNQy
         xWp5DJQw6u6kQy0YoNpkbJqQ0rge+AORyTGVaKMHeLbBt0f4izXeoJ0cmByvhfFj/KE5
         nvO/ZdjqZi8iEWVxUI1BRbqvEXGeIwsOcdrGxz8TfYya1uGhkSMRSdjsCmppYN0I2nxH
         LCgRqqmJT6YFEjfymcyldHZpKCPJaUgQE28PoFGl71ibOzUrMvEbC3A3h14puRSSq1IJ
         2NhA7YfEFnS+xn6akd6g6qd4tQLA293+akzia+N0PT/GWszh+ae9SISFVNY12r/uTxxY
         Q/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098972; x=1684690972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIY93kluNmo8IdAK/xBD53faZl2yu1KIRdFHLx14s00=;
        b=QlkQtFsFB4ySkQQw7/UtBog5RhmAbMRv74rYOUXA9YhVaiaI/ZU+1Es96flN4nRsAX
         OCnn7MlSpAj3bsRagN9wcNMx4CB54pkjdF1UIeGBl0WCGiVE2kbEG7dcBbF+DesiXnb/
         iKEUomEF8n4H21j+nqYC9GkS3lBYTdSUd8cCfm7kBQmHZ8dC7GGLsHfUOyuoDr9ssVT+
         5oWJ4KT1rxoeU7gUpDNWC7bBVBDWvAAzmvDMHpvpAIIn+Mmp3QJff0hpGaqXDcszm62F
         hJRU5cBRRHTPIf7rXTd2qVM1HhxgR8z+oKdM/oDURDyou3oEt8rQL/4e9h5eI1YYf2yP
         b9hQ==
X-Gm-Message-State: AAQBX9drAgoc96Wp/1gMV71dETwFtlud3I7QjuR7fj/PJwRJCiopepfZ
        tXRBmm6h30Dx5ETx8h7cqgPi/R8GWyJaNw==
X-Google-Smtp-Source: AKy350bJ1UjRbl6fXFW9CVjENZGJRQ0xU0OT9UMfQgMeoOZzeVb1si54nL7/I+yDvm2U3/OJX23N8g==
X-Received: by 2002:a5d:44cd:0:b0:2f2:cfc8:ab7c with SMTP id z13-20020a5d44cd000000b002f2cfc8ab7cmr4345892wrr.1.1682098972486;
        Fri, 21 Apr 2023 10:42:52 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:51 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 06/24] selftests/bpf: verifier/d_path converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:16 +0300
Message-Id: <20230421174234.2391278-7-eddyz87@gmail.com>
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

Test verifier/d_path automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_d_path.c     | 48 +++++++++++++++++++
 tools/testing/selftests/bpf/verifier/d_path.c | 37 --------------
 3 files changed, 50 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_d_path.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/d_path.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index f559bc3f7c2f..ae4da5f7598c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -19,6 +19,7 @@
 #include "verifier_const_or.skel.h"
 #include "verifier_ctx.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
+#include "verifier_d_path.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
 #include "verifier_div_overflow.skel.h"
@@ -97,6 +98,7 @@ void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
+void test_verifier_d_path(void)               { RUN(verifier_d_path); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_d_path.c b/tools/testing/selftests/bpf/progs/verifier_d_path.c
new file mode 100644
index 000000000000..ec79cbcfde91
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_d_path.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/d_path.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("fentry/dentry_open")
+__description("d_path accept")
+__success __retval(0)
+__naked void d_path_accept(void)
+{
+	asm volatile ("					\
+	r1 = *(u32*)(r1 + 0);				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r6 = 0;						\
+	*(u64*)(r2 + 0) = r6;				\
+	r3 = 8 ll;					\
+	call %[bpf_d_path];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_d_path)
+	: __clobber_all);
+}
+
+SEC("fentry/d_path")
+__description("d_path reject")
+__failure __msg("helper call is not allowed in probe")
+__naked void d_path_reject(void)
+{
+	asm volatile ("					\
+	r1 = *(u32*)(r1 + 0);				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r6 = 0;						\
+	*(u64*)(r2 + 0) = r6;				\
+	r3 = 8 ll;					\
+	call %[bpf_d_path];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_d_path)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/d_path.c b/tools/testing/selftests/bpf/verifier/d_path.c
deleted file mode 100644
index b988396379a7..000000000000
--- a/tools/testing/selftests/bpf/verifier/d_path.c
+++ /dev/null
@@ -1,37 +0,0 @@
-{
-	"d_path accept",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_MOV64_IMM(BPF_REG_6, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6, 0),
-	BPF_LD_IMM64(BPF_REG_3, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_d_path),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACING,
-	.expected_attach_type = BPF_TRACE_FENTRY,
-	.kfunc = "dentry_open",
-},
-{
-	"d_path reject",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_MOV64_IMM(BPF_REG_6, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6, 0),
-	BPF_LD_IMM64(BPF_REG_3, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_d_path),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "helper call is not allowed in probe",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACING,
-	.expected_attach_type = BPF_TRACE_FENTRY,
-	.kfunc = "d_path",
-},
-- 
2.40.0

