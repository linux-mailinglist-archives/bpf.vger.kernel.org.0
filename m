Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCF66EB0DE
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjDURn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjDURnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A355AF
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so18116835e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098975; x=1684690975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeJvSxjx784sBWolWdaqQIutCvZLOHAA7uZsJzJtHT8=;
        b=g8IjyA/9M3Qvk5z1avhsPIyn3bKYnXiDY+e8d2LUgCGQz+B8D16NUrrpEFJ74JZrBy
         DkFRskPnr8s5v4U0NTjZqDtY2CBd3Pgt1hXz94VdkgkZqh4JsCM/SqAq0C0clpGHXqpx
         b5X81acwArS21uLC6Pe7qyN9Twf5IJdxeGCcVqwZnCdg4jh5BUzkIXPg8YtJDP/fUFdl
         ItX9woF99fgqn0srvAvOBTiBBh+wywG9MeTUnqd9WZnQfsx4D19tpILplnenx+8alJCZ
         1N+tcjRl855hLKIDCJYOirkV/EA1KG9WnGcc4sBNte9ph8KTC/TE0dLZZ50jLR/NNwQB
         fceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098975; x=1684690975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeJvSxjx784sBWolWdaqQIutCvZLOHAA7uZsJzJtHT8=;
        b=i0z16YCXFMH/GzXaCfhPesWCb9hIfhl6jXpwnQvNpjr/nId+RsJh7VeZwKTrEOQJPn
         2QwTC7iTm9lW63BdfH7gBr4rro4aHAwWrGV8MUJbOa58LQVGrIxrZ6HcMtaromYhyp03
         J4A57r32BSTY2TQwF2qMkIIf+1XNdn34DCsEoDSGKx/oztVFa5/U360vFS+4MqTxuTTB
         PV4HORxSdcFSnqaUSv4y0yJLngxHtONpK3on2tv8a+/qVkuYcaIKstD7a7ZBVxv4a8PF
         6x12EChUl5cvUVbC7+JbM3vh8MiddJM+hM4kbDPsZYsXIcvHLe5Sif9rXHLM8ayU9UAj
         A2bw==
X-Gm-Message-State: AAQBX9emKFaI2H4fPs7pMQ4hqjs1ZtA3fVbKVkixVP/ftZaWaYPMEv+x
        aYVZ3wk4U9LK+R/v6ImpsWdH584N2OwPBQ==
X-Google-Smtp-Source: AKy350YE0MuzpAgNqI4On5gAEvrr6Ay4EZqy0s8WiR4RBPKxyfMQZygw5WQSCBECUVZyxKP9g/TGYQ==
X-Received: by 2002:a5d:4645:0:b0:2cf:efa5:5322 with SMTP id j5-20020a5d4645000000b002cfefa55322mr8421264wrs.14.1682098974771;
        Fri, 21 Apr 2023 10:42:54 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:54 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 08/24] selftests/bpf: verifier/jeq_infer_not_null converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:18 +0300
Message-Id: <20230421174234.2391278-9-eddyz87@gmail.com>
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

Test verifier/jeq_infer_not_null automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 213 ++++++++++++++++++
 .../bpf/verifier/jeq_infer_not_null.c         | 174 --------------
 3 files changed, 215 insertions(+), 174 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 2c9e61b9a83e..de5db0de98a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -29,6 +29,7 @@
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
 #include "verifier_int_ptr.skel.h"
+#include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_map_ptr.skel.h"
@@ -109,6 +110,7 @@ void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_acces
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
+void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
new file mode 100644
index 000000000000..bf16b00502f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_XSKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} map_xskmap SEC(".maps");
+
+/* This is equivalent to the following program:
+ *
+ *   r6 = skb->sk;
+ *   r7 = sk_fullsock(r6);
+ *   r0 = sk_fullsock(r6);
+ *   if (r0 == 0) return 0;    (a)
+ *   if (r0 != r7) return 0;   (b)
+ *   *r7->type;                (c)
+ *   return 0;
+ *
+ * It is safe to dereference r7 at point (c), because of (a) and (b).
+ * The test verifies that relation r0 == r7 is propagated from (b) to (c).
+ */
+SEC("cgroup/skb")
+__description("jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JNE false branch")
+__success __failure_unpriv __msg_unpriv("R7 pointer comparison")
+__retval(0)
+__naked void socket_for_jne_false_branch(void)
+{
+	asm volatile ("					\
+	/* r6 = skb->sk; */				\
+	r6 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	/* if (r6 == 0) return 0; */			\
+	if r6 == 0 goto l0_%=;				\
+	/* r7 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r7 = r0;					\
+	/* r0 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	/* if (r0 == null) return 0; */			\
+	if r0 == 0 goto l0_%=;				\
+	/* if (r0 == r7) r0 = *(r7->type); */		\
+	if r0 != r7 goto l0_%=;		/* Use ! JNE ! */\
+	r0 = *(u32*)(r7 + %[bpf_sock_type]);		\
+l0_%=:	/* return 0 */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+/* Same as above, but verify that another branch of JNE still
+ * prohibits access to PTR_MAYBE_NULL.
+ */
+SEC("cgroup/skb")
+__description("jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JNE true branch")
+__failure __msg("R7 invalid mem access 'sock_or_null'")
+__failure_unpriv __msg_unpriv("R7 pointer comparison")
+__naked void unchanged_for_jne_true_branch(void)
+{
+	asm volatile ("					\
+	/* r6 = skb->sk */				\
+	r6 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	/* if (r6 == 0) return 0; */			\
+	if r6 == 0 goto l0_%=;				\
+	/* r7 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r7 = r0;					\
+	/* r0 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	/* if (r0 == null) return 0; */			\
+	if r0 != 0 goto l0_%=;				\
+	/* if (r0 == r7) return 0; */			\
+	if r0 != r7 goto l1_%=;		/* Use ! JNE ! */\
+	goto l0_%=;					\
+l1_%=:	/* r0 = *(r7->type); */				\
+	r0 = *(u32*)(r7 + %[bpf_sock_type]);		\
+l0_%=:	/* return 0 */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+/* Same as a first test, but not null should be inferred for JEQ branch */
+SEC("cgroup/skb")
+__description("jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JEQ true branch")
+__success __failure_unpriv __msg_unpriv("R7 pointer comparison")
+__retval(0)
+__naked void socket_for_jeq_true_branch(void)
+{
+	asm volatile ("					\
+	/* r6 = skb->sk; */				\
+	r6 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	/* if (r6 == null) return 0; */			\
+	if r6 == 0 goto l0_%=;				\
+	/* r7 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r7 = r0;					\
+	/* r0 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	/* if (r0 == null) return 0; */			\
+	if r0 == 0 goto l0_%=;				\
+	/* if (r0 != r7) return 0; */			\
+	if r0 == r7 goto l1_%=;		/* Use ! JEQ ! */\
+	goto l0_%=;					\
+l1_%=:	/* r0 = *(r7->type); */				\
+	r0 = *(u32*)(r7 + %[bpf_sock_type]);		\
+l0_%=:	/* return 0; */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+/* Same as above, but verify that another branch of JNE still
+ * prohibits access to PTR_MAYBE_NULL.
+ */
+SEC("cgroup/skb")
+__description("jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JEQ false branch")
+__failure __msg("R7 invalid mem access 'sock_or_null'")
+__failure_unpriv __msg_unpriv("R7 pointer comparison")
+__naked void unchanged_for_jeq_false_branch(void)
+{
+	asm volatile ("					\
+	/* r6 = skb->sk; */				\
+	r6 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	/* if (r6 == null) return 0; */			\
+	if r6 == 0 goto l0_%=;				\
+	/* r7 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	r7 = r0;					\
+	/* r0 = sk_fullsock(skb); */			\
+	r1 = r6;					\
+	call %[bpf_sk_fullsock];			\
+	/* if (r0 == null) return 0; */			\
+	if r0 == 0 goto l0_%=;				\
+	/* if (r0 != r7) r0 = *(r7->type); */		\
+	if r0 == r7 goto l0_%=;		/* Use ! JEQ ! */\
+	r0 = *(u32*)(r7 + %[bpf_sock_type]);		\
+l0_%=:	/* return 0; */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+/* Maps are treated in a different branch of `mark_ptr_not_null_reg`,
+ * so separate test for maps case.
+ */
+SEC("xdp")
+__description("jne/jeq infer not null, PTR_TO_MAP_VALUE_OR_NULL -> PTR_TO_MAP_VALUE")
+__success __retval(0)
+__naked void null_ptr_to_map_value(void)
+{
+	asm volatile ("					\
+	/* r9 = &some stack to use as key */		\
+	r1 = 0;						\
+	*(u32*)(r10 - 8) = r1;				\
+	r9 = r10;					\
+	r9 += -8;					\
+	/* r8 = process local map */			\
+	r8 = %[map_xskmap] ll;				\
+	/* r6 = map_lookup_elem(r8, r9); */		\
+	r1 = r8;					\
+	r2 = r9;					\
+	call %[bpf_map_lookup_elem];			\
+	r6 = r0;					\
+	/* r7 = map_lookup_elem(r8, r9); */		\
+	r1 = r8;					\
+	r2 = r9;					\
+	call %[bpf_map_lookup_elem];			\
+	r7 = r0;					\
+	/* if (r6 == 0) return 0; */			\
+	if r6 == 0 goto l0_%=;				\
+	/* if (r6 != r7) return 0; */			\
+	if r6 != r7 goto l0_%=;				\
+	/* read *r7; */					\
+	r0 = *(u32*)(r7 + %[bpf_xdp_sock_queue_id]);	\
+l0_%=:	/* return 0; */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_xskmap),
+	  __imm_const(bpf_xdp_sock_queue_id, offsetof(struct bpf_xdp_sock, queue_id))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
deleted file mode 100644
index 67a1c07ead34..000000000000
--- a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
+++ /dev/null
@@ -1,174 +0,0 @@
-{
-	/* This is equivalent to the following program:
-	 *
-	 *   r6 = skb->sk;
-	 *   r7 = sk_fullsock(r6);
-	 *   r0 = sk_fullsock(r6);
-	 *   if (r0 == 0) return 0;    (a)
-	 *   if (r0 != r7) return 0;   (b)
-	 *   *r7->type;                (c)
-	 *   return 0;
-	 *
-	 * It is safe to dereference r7 at point (c), because of (a) and (b).
-	 * The test verifies that relation r0 == r7 is propagated from (b) to (c).
-	 */
-	"jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JNE false branch",
-	.insns = {
-	/* r6 = skb->sk; */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	/* if (r6 == 0) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 8),
-	/* r7 = sk_fullsock(skb); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	/* r0 = sk_fullsock(skb); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	/* if (r0 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	/* if (r0 == r7) r0 = *(r7->type); */
-	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 1), /* Use ! JNE ! */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
-	/* return 0 */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R7 pointer comparison",
-},
-{
-	/* Same as above, but verify that another branch of JNE still
-	 * prohibits access to PTR_MAYBE_NULL.
-	 */
-	"jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JNE true branch",
-	.insns = {
-	/* r6 = skb->sk */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	/* if (r6 == 0) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 9),
-	/* r7 = sk_fullsock(skb); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	/* r0 = sk_fullsock(skb); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	/* if (r0 == null) return 0; */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
-	/* if (r0 == r7) return 0; */
-	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 1), /* Use ! JNE ! */
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	/* r0 = *(r7->type); */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
-	/* return 0 */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "R7 invalid mem access 'sock_or_null'",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R7 pointer comparison",
-},
-{
-	/* Same as a first test, but not null should be inferred for JEQ branch */
-	"jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JEQ true branch",
-	.insns = {
-	/* r6 = skb->sk; */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	/* if (r6 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 9),
-	/* r7 = sk_fullsock(skb); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	/* r0 = sk_fullsock(skb); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	/* if (r0 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	/* if (r0 != r7) return 0; */
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_7, 1), /* Use ! JEQ ! */
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	/* r0 = *(r7->type); */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
-	/* return 0; */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R7 pointer comparison",
-},
-{
-	/* Same as above, but verify that another branch of JNE still
-	 * prohibits access to PTR_MAYBE_NULL.
-	 */
-	"jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JEQ false branch",
-	.insns = {
-	/* r6 = skb->sk; */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	/* if (r6 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 8),
-	/* r7 = sk_fullsock(skb); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	/* r0 = sk_fullsock(skb); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	/* if (r0 == null) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	/* if (r0 != r7) r0 = *(r7->type); */
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_7, 1), /* Use ! JEQ ! */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
-	/* return 0; */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "R7 invalid mem access 'sock_or_null'",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R7 pointer comparison",
-},
-{
-	/* Maps are treated in a different branch of `mark_ptr_not_null_reg`,
-	 * so separate test for maps case.
-	 */
-	"jne/jeq infer not null, PTR_TO_MAP_VALUE_OR_NULL -> PTR_TO_MAP_VALUE",
-	.insns = {
-	/* r9 = &some stack to use as key */
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_9, -8),
-	/* r8 = process local map */
-	BPF_LD_MAP_FD(BPF_REG_8, 0),
-	/* r6 = map_lookup_elem(r8, r9); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* r7 = map_lookup_elem(r8, r9); */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	/* if (r6 == 0) return 0; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 2),
-	/* if (r6 != r7) return 0; */
-	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_7, 1),
-	/* read *r7; */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_xdp_sock, queue_id)),
-	/* return 0; */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_xskmap = { 3 },
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.result = ACCEPT,
-},
-- 
2.40.0

