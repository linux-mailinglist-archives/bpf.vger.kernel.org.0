Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416FB6C8A76
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjCYC4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjCYC4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308EB1B2CD
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so1969821wms.2
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d70rNMOc9QfEQgb2hYMJgH0+0UmZBMLOZ+JJ40up6Tk=;
        b=eSqtei8oFxNJaUqilzEBEV50YE4lu5y0cK3S/UenSCJElOw5ZD1vRt7H9bgen3+Oa+
         bvoQp89SD0BagIZz/ugLEVuRCi7zlk1CtRAoVBum8VKd2EXyrWzF2qpKD7MivaFPkB34
         fuGSDiWJP9NTtcGJnac7azQODjySGC3d0Byr0Nl2OTN/xIWMmsl+rCRsw6oEXCDoGjVN
         fVuPpS43z0uOs2ikb7/kg7FWNGtao16GPRAoxd1mRenameJ51UwiDNpSiKytm4M4faYo
         BmMQvXxBh8gR8eGqvlllar2U8O0xwSbyU1xS1wswNwARjDTl63dJN9HEqrSty72AloS3
         Xhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d70rNMOc9QfEQgb2hYMJgH0+0UmZBMLOZ+JJ40up6Tk=;
        b=3srEetLTEdoxPr6ukhog1ggPwGozvc/3zDmEwE4k3QC6l+kpcXKj4rtGz8tLqOdBtO
         rWB4H+vOh9vvIJvNDx1T7QpP2dByOG5KgVUt5rDv5JSkLijSPipYEPynU0fY6HwC0TFk
         f4bxhw2+5yC6w9dA26BU7hVpZFy048/E3RGVALqhKDJGWhlrdGqpI8Xb5fyEv0vU1AiU
         WU2YF6mtdYPfkhcoM+V7UwqojFPOkUOAbYcX703pBOZsp07afhMtLWYaLcxc53OEPk/L
         BA983EN8TgSLemCBcdeGNoCf/gUT3TKeLTMtyW7okhLoTAuo2V1CwH68pf6bzaNKtsxh
         aDHw==
X-Gm-Message-State: AO0yUKWQg0riZZ2wUVhwgarbqEDmmDXywfLBsGUy1YRo9y7id9cfk2Q7
        gZy4LkDm4RJu6OV/s3vn2aFrtKAn+nQ=
X-Google-Smtp-Source: AK7set/tPF5c6LD2r3oqrywO+W8eYzu0yoDowR6CbuLlqNJSxbBQXxMq20NHyQnUtxsIMZohh7CI6Q==
X-Received: by 2002:a05:600c:20d:b0:3ee:672d:caae with SMTP id 13-20020a05600c020d00b003ee672dcaaemr4176391wmi.36.1679712989389;
        Fri, 24 Mar 2023 19:56:29 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:29 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 26/43] selftests/bpf: verifier/leak_ptr.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:07 +0200
Message-Id: <20230325025524.144043-27-eddyz87@gmail.com>
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

Test verifier/leak_ptr.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_leak_ptr.c   | 92 +++++++++++++++++++
 .../testing/selftests/bpf/verifier/leak_ptr.c | 67 --------------
 3 files changed, 94 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_leak_ptr.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/leak_ptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d8d4464b6112..f8b3b6beba3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -23,6 +23,7 @@
 #include "verifier_helper_value_access.skel.h"
 #include "verifier_int_ptr.skel.h"
 #include "verifier_ld_ind.skel.h"
+#include "verifier_leak_ptr.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -68,3 +69,4 @@ void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted);
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
+void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_leak_ptr.c b/tools/testing/selftests/bpf/progs/verifier_leak_ptr.c
new file mode 100644
index 000000000000..d153fbe50055
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_leak_ptr.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/leak_ptr.c */
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
+__description("leak pointer into ctx 1")
+__failure __msg("BPF_ATOMIC stores into R1 ctx is not allowed")
+__failure_unpriv __msg_unpriv("R2 leaks addr into mem")
+__naked void leak_pointer_into_ctx_1(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r1 + %[__sk_buff_cb_0]) = r0;		\
+	r2 = %[map_hash_8b] ll;				\
+	lock *(u64 *)(r1 + %[__sk_buff_cb_0]) += r2;	\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_8b),
+	  __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0]))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("leak pointer into ctx 2")
+__failure __msg("BPF_ATOMIC stores into R1 ctx is not allowed")
+__failure_unpriv __msg_unpriv("R10 leaks addr into mem")
+__naked void leak_pointer_into_ctx_2(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r1 + %[__sk_buff_cb_0]) = r0;		\
+	lock *(u64 *)(r1 + %[__sk_buff_cb_0]) += r10;	\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0]))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("leak pointer into ctx 3")
+__success __failure_unpriv __msg_unpriv("R2 leaks addr into ctx")
+__retval(0)
+__naked void leak_pointer_into_ctx_3(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r2 = %[map_hash_8b] ll;				\
+	*(u64*)(r1 + %[__sk_buff_cb_0]) = r2;		\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_8b),
+	  __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0]))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("leak pointer into map val")
+__success __failure_unpriv __msg_unpriv("R6 leaks addr into mem")
+__retval(0)
+__naked void leak_pointer_into_map_val(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r3 = 0;						\
+	*(u64*)(r0 + 0) = r3;				\
+	lock *(u64 *)(r0 + 0) += r6;			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/leak_ptr.c b/tools/testing/selftests/bpf/verifier/leak_ptr.c
deleted file mode 100644
index 73f0dea95546..000000000000
--- a/tools/testing/selftests/bpf/verifier/leak_ptr.c
+++ /dev/null
@@ -1,67 +0,0 @@
-{
-	"leak pointer into ctx 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_1, BPF_REG_2,
-		      offsetof(struct __sk_buff, cb[0])),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 2 },
-	.errstr_unpriv = "R2 leaks addr into mem",
-	.result_unpriv = REJECT,
-	.result = REJECT,
-	.errstr = "BPF_ATOMIC stores into R1 ctx is not allowed",
-},
-{
-	"leak pointer into ctx 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_1, BPF_REG_10,
-		      offsetof(struct __sk_buff, cb[0])),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R10 leaks addr into mem",
-	.result_unpriv = REJECT,
-	.result = REJECT,
-	.errstr = "BPF_ATOMIC stores into R1 ctx is not allowed",
-},
-{
-	"leak pointer into ctx 3",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2,
-		      offsetof(struct __sk_buff, cb[0])),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 1 },
-	.errstr_unpriv = "R2 leaks addr into ctx",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"leak pointer into map val",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_6, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.errstr_unpriv = "R6 leaks addr into mem",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-- 
2.40.0

