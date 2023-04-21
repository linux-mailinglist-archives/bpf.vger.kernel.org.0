Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4360A6EB0DB
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjDURnZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjDURnG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7C49E0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2f58125b957so1844145f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098971; x=1684690971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMALvQLQ9jCQgkNwTl1g4hr895uRYr2kc3tJMgZG3bU=;
        b=rwsblcMp+jd5gEX/m01VDx43QiAneG+PLPd9KiILLq4B2A7afXX00F8LzPRu/Lj+iy
         wMG8pw3mIFMi7fDHcC6RCTDwyXdNOEg3wnKzw8SKqJsMazlH8Qmy/M7Ud+fLVmGFiU+F
         XjzAVRUQG9iay5C9qDQ1hna123qcTRDGdfquo2RtwwXKr2616kJzJURkyqCcvhg6Muj6
         9TC+z+qMrPtSA1FsM1lmuduakmnUrx+U75i/EZDTe2+/eWflqaZHmJXFwOXV5utuzWSF
         aOVDYLjMz9R5kKaPfyMrKCIb/6VCjsFF8ihvd9YFbyEOK9yOoYcQnIUGsoHwNCwqzgcr
         iwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098971; x=1684690971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMALvQLQ9jCQgkNwTl1g4hr895uRYr2kc3tJMgZG3bU=;
        b=j7QfFCaZUrCZhU2wzr5Gq35KWTn+sFGZeXZyt14iYOcEnVNNiqnimcDhYY/qJOo8fo
         WvITZYPKRSyYfXrY5p5ulfLNOYh7BKSt07uB1uugEbGkSSdYxtr7hLdvzFSjwYjAKVcj
         hvELgiYHm8E7g4fl9B13hLKm+CHj5xVhL5GLT43o3tj/U+MIvnSU+NpSactez24Y8Wdy
         ir/5+ZOrFcsUFYC1z/ASVJOsAagt/c8Zbq9WoMnKC2m8faOOdErP39Xig2thNNfZ9Tt1
         1Z91rshviF7LFeAAIWTh7kIH50bPyhlDmioex05GqLLuXHyYtbmW//YpJBdWIFXrHmP8
         1OxA==
X-Gm-Message-State: AAQBX9cTsbNLEl6KHcY4Ub4Go4NaLa95yLM3W4AV1+R+ExBa+jWleSAG
        6k7y/YpluooX9BDKupELBqaYWdveG5SabQ==
X-Google-Smtp-Source: AKy350Z8bzJ7seCWTD9nMlw3VYAYqa0VEllFBpaX36tZWAxu7a9AQBvB6/UsonFURYD3NKyeoUVK8Q==
X-Received: by 2002:adf:e686:0:b0:303:e387:aabf with SMTP id r6-20020adfe686000000b00303e387aabfmr1855894wrm.71.1682098971135;
        Fri, 21 Apr 2023 10:42:51 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:50 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 05/24] selftests/bpf: verifier/ctx converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:15 +0300
Message-Id: <20230421174234.2391278-6-eddyz87@gmail.com>
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

Test verifier/ctx automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_ctx.c        | 221 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/ctx.c    | 186 ---------------
 3 files changed, 223 insertions(+), 186 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/ctx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b42601f7edcb..f559bc3f7c2f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -17,6 +17,7 @@
 #include "verifier_cgroup_skb.skel.h"
 #include "verifier_cgroup_storage.skel.h"
 #include "verifier_const_or.skel.h"
+#include "verifier_ctx.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
@@ -94,6 +95,7 @@ void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode)
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
 void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
+void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
new file mode 100644
index 000000000000..a83809a1dbbf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/ctx.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tc")
+__description("context stores via BPF_ATOMIC")
+__failure __msg("BPF_ATOMIC stores into R1 ctx is not allowed")
+__naked void context_stores_via_bpf_atomic(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	lock *(u32 *)(r1 + %[__sk_buff_mark]) += w0;	\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("arithmetic ops make PTR_TO_CTX unusable")
+__failure __msg("dereference of modified ctx ptr")
+__naked void make_ptr_to_ctx_unusable(void)
+{
+	asm volatile ("					\
+	r1 += %[__imm_0];				\
+	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	exit;						\
+"	:
+	: __imm_const(__imm_0,
+		      offsetof(struct __sk_buff, data) - offsetof(struct __sk_buff, mark)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("pass unmodified ctx pointer to helper")
+__success __retval(0)
+__naked void unmodified_ctx_pointer_to_helper(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	call %[bpf_csum_update];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_update)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("pass modified ctx pointer to helper, 1")
+__failure __msg("negative offset ctx ptr R1 off=-612 disallowed")
+__naked void ctx_pointer_to_helper_1(void)
+{
+	asm volatile ("					\
+	r1 += -612;					\
+	r2 = 0;						\
+	call %[bpf_csum_update];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_update)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("pass modified ctx pointer to helper, 2")
+__failure __msg("negative offset ctx ptr R1 off=-612 disallowed")
+__failure_unpriv __msg_unpriv("negative offset ctx ptr R1 off=-612 disallowed")
+__naked void ctx_pointer_to_helper_2(void)
+{
+	asm volatile ("					\
+	r1 += -612;					\
+	call %[bpf_get_socket_cookie];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_socket_cookie)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("pass modified ctx pointer to helper, 3")
+__failure __msg("variable ctx access var_off=(0x0; 0x4)")
+__naked void ctx_pointer_to_helper_3(void)
+{
+	asm volatile ("					\
+	r3 = *(u32*)(r1 + 0);				\
+	r3 &= 4;					\
+	r1 += r3;					\
+	r2 = 0;						\
+	call %[bpf_csum_update];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_update)
+	: __clobber_all);
+}
+
+SEC("cgroup/sendmsg6")
+__description("pass ctx or null check, 1: ctx")
+__success
+__naked void or_null_check_1_ctx(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_netns_cookie];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_netns_cookie)
+	: __clobber_all);
+}
+
+SEC("cgroup/sendmsg6")
+__description("pass ctx or null check, 2: null")
+__success
+__naked void or_null_check_2_null(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	call %[bpf_get_netns_cookie];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_netns_cookie)
+	: __clobber_all);
+}
+
+SEC("cgroup/sendmsg6")
+__description("pass ctx or null check, 3: 1")
+__failure __msg("R1 type=scalar expected=ctx")
+__naked void or_null_check_3_1(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	call %[bpf_get_netns_cookie];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_netns_cookie)
+	: __clobber_all);
+}
+
+SEC("cgroup/sendmsg6")
+__description("pass ctx or null check, 4: ctx - const")
+__failure __msg("negative offset ctx ptr R1 off=-612 disallowed")
+__naked void null_check_4_ctx_const(void)
+{
+	asm volatile ("					\
+	r1 += -612;					\
+	call %[bpf_get_netns_cookie];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_netns_cookie)
+	: __clobber_all);
+}
+
+SEC("cgroup/connect4")
+__description("pass ctx or null check, 5: null (connect)")
+__success
+__naked void null_check_5_null_connect(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	call %[bpf_get_netns_cookie];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_netns_cookie)
+	: __clobber_all);
+}
+
+SEC("cgroup/post_bind4")
+__description("pass ctx or null check, 6: null (bind)")
+__success
+__naked void null_check_6_null_bind(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	call %[bpf_get_netns_cookie];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_netns_cookie)
+	: __clobber_all);
+}
+
+SEC("cgroup/post_bind4")
+__description("pass ctx or null check, 7: ctx (bind)")
+__success
+__naked void null_check_7_ctx_bind(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_socket_cookie];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_socket_cookie)
+	: __clobber_all);
+}
+
+SEC("cgroup/post_bind4")
+__description("pass ctx or null check, 8: null (bind)")
+__failure __msg("R1 type=scalar expected=ctx")
+__naked void null_check_8_null_bind(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	call %[bpf_get_socket_cookie];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_socket_cookie)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/ctx.c b/tools/testing/selftests/bpf/verifier/ctx.c
deleted file mode 100644
index 2fd31612c0b8..000000000000
--- a/tools/testing/selftests/bpf/verifier/ctx.c
+++ /dev/null
@@ -1,186 +0,0 @@
-{
-	"context stores via BPF_ATOMIC",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_1, BPF_REG_0, offsetof(struct __sk_buff, mark)),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "BPF_ATOMIC stores into R1 ctx is not allowed",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"arithmetic ops make PTR_TO_CTX unusable",
-	.insns = {
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1,
-			      offsetof(struct __sk_buff, data) -
-			      offsetof(struct __sk_buff, mark)),
-		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-			    offsetof(struct __sk_buff, mark)),
-		BPF_EXIT_INSN(),
-	},
-	.errstr = "dereference of modified ctx ptr",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"pass unmodified ctx pointer to helper",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_csum_update),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"pass modified ctx pointer to helper, 1",
-	.insns = {
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -612),
-		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_csum_update),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
-},
-{
-	"pass modified ctx pointer to helper, 2",
-	.insns = {
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -612),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_socket_cookie),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.result_unpriv = REJECT,
-	.result = REJECT,
-	.errstr_unpriv = "negative offset ctx ptr R1 off=-612 disallowed",
-	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
-},
-{
-	"pass modified ctx pointer to helper, 3",
-	.insns = {
-		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, 0),
-		BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 4),
-		BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_csum_update),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "variable ctx access var_off=(0x0; 0x4)",
-},
-{
-	"pass ctx or null check, 1: ctx",
-	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_netns_cookie),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-	.expected_attach_type = BPF_CGROUP_UDP6_SENDMSG,
-	.result = ACCEPT,
-},
-{
-	"pass ctx or null check, 2: null",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_netns_cookie),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-	.expected_attach_type = BPF_CGROUP_UDP6_SENDMSG,
-	.result = ACCEPT,
-},
-{
-	"pass ctx or null check, 3: 1",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_1, 1),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_netns_cookie),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-	.expected_attach_type = BPF_CGROUP_UDP6_SENDMSG,
-	.result = REJECT,
-	.errstr = "R1 type=scalar expected=ctx",
-},
-{
-	"pass ctx or null check, 4: ctx - const",
-	.insns = {
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -612),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_netns_cookie),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-	.expected_attach_type = BPF_CGROUP_UDP6_SENDMSG,
-	.result = REJECT,
-	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
-},
-{
-	"pass ctx or null check, 5: null (connect)",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_netns_cookie),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-	.expected_attach_type = BPF_CGROUP_INET4_CONNECT,
-	.result = ACCEPT,
-},
-{
-	"pass ctx or null check, 6: null (bind)",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_netns_cookie),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-	.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-	.result = ACCEPT,
-},
-{
-	"pass ctx or null check, 7: ctx (bind)",
-	.insns = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_socket_cookie),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-	.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-	.result = ACCEPT,
-},
-{
-	"pass ctx or null check, 8: null (bind)",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_1, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_socket_cookie),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK,
-	.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-	.result = REJECT,
-	.errstr = "R1 type=scalar expected=ctx",
-},
-- 
2.40.0

