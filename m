Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00395677E6E
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 15:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjAWOwU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 09:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjAWOwS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 09:52:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB76227A6
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso8742656wmq.5
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwZOPyOCDfCNfEwj1LZpRu0/ZN5cDHbQPABExyOPQnc=;
        b=QRrnEu0vnPDdSIYTlN0kW+fKjwBMezL+CKmY2lZdXnE9AkI/x9Zgsrkj9Ut9pLJ+jA
         u+NTvcu3VB4a0pzIK45itjELLbiO6RIccwFRo67guh1OWOA2WMBn/lUBp3eZYVn/RXN1
         jl/ltBXnh54gXVmjwgsmgkmT1g80EdB2h4aDPUo8h2nWvTrFAsY3aj/JZCId7d4bllIg
         RqlMq6RUDcD6fuKTvDou1lbBS50evWefJYPAqbljpQnAgC2eoh73RZ9s/CSQh8DMao+R
         30boXyLmcsVbThw3TJZthKJQzodGFnXu0p6F7VH0YPOo07XPqlP8oXrNOJX21SXtkULp
         axNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwZOPyOCDfCNfEwj1LZpRu0/ZN5cDHbQPABExyOPQnc=;
        b=QjNKsNVooZ2tkAbeC0tXouAIdTV6FS/xdhO7Mqr6NGRCtNtfKZDIIu6WRhcKN2uBWo
         67mONWImmMcUYbd6gXx3EJ2DMhnCwqlX96V1XysLLQQl8cl4TCagZz5lzst8ljR4uVrs
         V/X3XJ4UTwALLutavnJbuxYFCSsZbU7yVMBG9iQ0IX/OaHLi0fzBVQE04ai0RPmswoRs
         N/ATqq3fSApyir2j3SFhDjWNonTS7+NKFe4eOBciDcXvR1wgXbeMIMe3JnDMUCMU05V7
         Q3LHt3xRuGRNRtMhIoWz3S7UMuU6YAkR5srgoxv1TXl9paUppV8EnqqKoJr87sroFReQ
         wdWA==
X-Gm-Message-State: AFqh2krUm2ZCmuNrVq734VhHfaVrpJnVbHQLCZ6pYKlbIJkjoWBaTaC1
        nU0M5sTZTSYGPRwgdWsDoiHYYxRZd0E=
X-Google-Smtp-Source: AMrXdXtVa1D5dPXndSNObtT8aBBhhuAF2p7YrgcjIWxXlnmN66tmrDNnSpoDhxmZstWrX66G/NeAnQ==
X-Received: by 2002:a05:600c:5390:b0:3d9:a145:4d1a with SMTP id hg16-20020a05600c539000b003d9a1454d1amr21105630wmb.34.1674485534807;
        Mon, 23 Jan 2023 06:52:14 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003d1e1f421bfsm11999649wmq.10.2023.01.23.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:52:14 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 5/5] selftests/bpf: convert jeq_infer_not_null tests to inline assembly
Date:   Mon, 23 Jan 2023 16:51:48 +0200
Message-Id: <20230123145148.2791939-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123145148.2791939-1-eddyz87@gmail.com>
References: <20230123145148.2791939-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use updated test_loader interface to convert progs/jeq_infer_not_null
verifier test to inline assembly. Some redundant comments are removed
in the process.

Existing test progs/jeq_infer_not_null_fail.c is updated to use
"Use test_loader marker" to remove trivial
progs_tests/jeq_infer_not_null.c boilerplate code.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/jeq_infer_not_null.c       |   9 -
 .../selftests/bpf/progs/jeq_infer_not_null.c  | 186 ++++++++++++++++++
 .../bpf/progs/jeq_infer_not_null_fail.c       |   1 +
 .../bpf/verifier/jeq_infer_not_null.c         | 174 ----------------
 4 files changed, 187 insertions(+), 183 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/jeq_infer_not_null.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

diff --git a/tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c b/tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c
deleted file mode 100644
index 3add34df5767..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <test_progs.h>
-#include "jeq_infer_not_null_fail.skel.h"
-
-void test_jeq_infer_not_null(void)
-{
-	RUN_TESTS(jeq_infer_not_null_fail);
-}
diff --git a/tools/testing/selftests/bpf/progs/jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/jeq_infer_not_null.c
new file mode 100644
index 000000000000..7c506eccacaf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/jeq_infer_not_null.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c */
+/* Use test_loader marker */
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
+__description("jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JNE false branch")
+__success __failure_unpriv __msg_unpriv("R7 pointer comparison")
+SEC("cgroup/skb")
+__naked void sock_or_null_jne_false_branch(void)
+{
+	asm volatile (
+"	r6 = *(u64*)(r1 + %[__sk_buff_sk_offset]);	\n\
+	if r6 == 0 goto exit_%=;			\n\
+	r1 = r6;					\n\
+	call %[bpf_sk_fullsock];			\n\
+	r7 = r0;					\n\
+	r1 = r6;					\n\
+	call %[bpf_sk_fullsock];			\n\
+	if r0 == 0 goto exit_%=;			\n\
+	if r0 != r7 goto exit_%=;			\n\
+	r0 = *(u32*)(r7 + %[bpf_sock_type_offset]);	\n\
+exit_%=:						\n\
+	r0 = 0;						\n\
+	exit;						\n\
+"	:
+	: [__sk_buff_sk_offset]"i"(offsetof(struct __sk_buff, sk)),
+	  [bpf_sock_type_offset]"i"(offsetof(struct bpf_sock, type)),
+	  __imm(bpf_sk_fullsock)
+	: __clobber_all);
+}
+
+/* Same as above, but verify that another branch of JNE still
+ * prohibits access to PTR_MAYBE_NULL.
+ */
+__description("jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JNE true branch")
+__failure __msg("R7 invalid mem access 'sock_or_null'")
+__failure_unpriv __msg_unpriv("R7 pointer comparison")
+SEC("cgroup/skb")
+__naked void sock_or_null_jne_true_branch(void)
+{
+	asm volatile (
+"	r6 = *(u64*)(r1 + %[__sk_buff_sk_offset]);	\n\
+	if r6 == 0 goto exit_%=;			\n\
+	r1 = r6;					\n\
+	call %[bpf_sk_fullsock];			\n\
+	r7 = r0;					\n\
+	r1 = r6;					\n\
+	call %[bpf_sk_fullsock];			\n\
+	if r0 != 0 goto exit_%=;			\n\
+	if r0 != r7 goto l1_%=;				\n\
+	goto exit_%=;					\n\
+l1_%=:							\n\
+	r0 = *(u32*)(r7 + %[bpf_sock_type_offset]);	\n\
+exit_%=:						\n\
+	r0 = 0;						\n\
+	exit;						\n\
+"	:
+	: [__sk_buff_sk_offset]"i"(offsetof(struct __sk_buff, sk)),
+	  [bpf_sock_type_offset]"i"(offsetof(struct bpf_sock, type)),
+	  __imm(bpf_sk_fullsock)
+	: __clobber_all);
+}
+
+/* Same as a first test, but not null should be inferred for JEQ branch */
+__description("jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JEQ true branch")
+__success __failure_unpriv __msg_unpriv("R7 pointer comparison")
+SEC("cgroup/skb")
+__naked void sock_or_null_jeq_true_branch(void)
+{
+	asm volatile (
+"	r6 = *(u64*)(r1 + %[__sk_buff_sk_offset]);	\n\
+	if r6 == 0 goto exit_%=;			\n\
+	r1 = r6;					\n\
+	call %[bpf_sk_fullsock];			\n\
+	r7 = r0;					\n\
+	r1 = r6;					\n\
+	call %[bpf_sk_fullsock];			\n\
+	if r0 == 0 goto exit_%=;			\n\
+	if r0 == r7 goto l1_%=;				\n\
+	goto exit_%=;					\n\
+l1_%=:							\n\
+	r0 = *(u32*)(r7 + %[bpf_sock_type_offset]);	\n\
+exit_%=:						\n\
+	r0 = 0;						\n\
+	exit;						\n\
+"	:
+	: [__sk_buff_sk_offset]"i"(offsetof(struct __sk_buff, sk)),
+	  [bpf_sock_type_offset]"i"(offsetof(struct bpf_sock, type)),
+	  __imm(bpf_sk_fullsock)
+	: __clobber_all);
+}
+
+/* Same as above, but verify that another branch of JNE still
+ * prohibits access to PTR_MAYBE_NULL.
+ */
+__description("jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL unchanged for JEQ false branch")
+__failure __msg("R7 invalid mem access 'sock_or_null'")
+__failure_unpriv __msg_unpriv("R7 pointer comparison")
+SEC("cgroup/skb")
+__naked void sock_or_null_jeq_false_branch(void)
+{
+	asm volatile (
+"	r6 = *(u64*)(r1 + %[__sk_buff_sk_offset]);	\n\
+	if r6 == 0 goto exit_%=;			\n\
+	r1 = r6;					\n\
+	call %[bpf_sk_fullsock];			\n\
+	r7 = r0;					\n\
+	r1 = r6;					\n\
+	call %[bpf_sk_fullsock];			\n\
+	if r0 == 0 goto exit_%=;			\n\
+	if r0 == r7 goto exit_%=;			\n\
+	r0 = *(u32*)(r7 + %[bpf_sock_type_offset]);	\n\
+exit_%=:						\n\
+	r0 = 0;						\n\
+	exit;						\n\
+"	:
+	: [__sk_buff_sk_offset]"i"(offsetof(struct __sk_buff, sk)),
+	  [bpf_sock_type_offset]"i"(offsetof(struct bpf_sock, type)),
+	  __imm(bpf_sk_fullsock)
+	: __clobber_all);
+}
+
+/* Maps are treated in a different branch of `mark_ptr_not_null_reg`,
+ * so separate test for maps case.
+ */
+__description("jne/jeq infer not null, PTR_TO_MAP_VALUE_OR_NULL -> PTR_TO_MAP_VALUE")
+__success
+SEC("xdp")
+__naked void ptr_to_map(void)
+{
+	asm volatile (
+"	r1 = 0;						\n\
+	*(u32*)(r10 - 8) = r1;				\n\
+	r9 = r10;					\n\
+	r9 += -8;					\n\
+	/* r8 = process local map */			\n\
+	r8 = %[map_xskmap] ll;				\n\
+	/* r6 = map_lookup_elem(r8, r9); */		\n\
+	r1 = r8;					\n\
+	r2 = r9;					\n\
+	call %[bpf_map_lookup_elem];			\n\
+	r6 = r0;					\n\
+	/* r7 = map_lookup_elem(r8, r9); */		\n\
+	r1 = r8;					\n\
+	r2 = r9;					\n\
+	call %[bpf_map_lookup_elem];			\n\
+	r7 = r0;					\n\
+	if r6 == 0 goto exit_%=;			\n\
+	if r6 != r7 goto exit_%=;			\n\
+	/* read *r7; */					\n\
+	r0 = *(u32*)(r7 + %[bpf_xdp_sock_queue_id_offset]);\n\
+exit_%=:						\n\
+	r0 = 0;						\n\
+	exit;						\n\
+"	:
+	: [bpf_xdp_sock_queue_id_offset]"i"(offsetof(struct bpf_xdp_sock, queue_id)),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_xskmap)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
+
diff --git a/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
index f46965053acb..8048d76f60ca 100644
--- a/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
+++ b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+/* Use test_loader marker */
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
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
2.39.0

