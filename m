Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F3D6C8A83
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjCYC5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjCYC5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:57:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2781ADE9
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1994027wmq.5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679713008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcZGRsdag1ZZUZT8iClDOrVXoqs7IUmHnLWfOf2shy4=;
        b=Ky4oNeKL1ntm22PVOPbzW1ZP/LBHjy8GK5rxARABclowWD6AXos/KzUoJjE/GOePk9
         z3JQv5dTG6H1Y8f6F0Z571MRR1H6/fI9rWC8eGKD9LNHLh1kauGMzrpbXdOoBlR7r5lh
         5guOQPkAEXOZkbnr7DXdNjC0fyJfgwvnLuIWULvwf3PnadnAAqo1kH/kYi+eTjOEAJLY
         qcQ3j18aw9LPxSo89TB5/ucdi3SFZ4iJHJgiwBGu9jnfkm37d1wWrmcYGbq+eV91BNE1
         hyFJ0xzP3uU0YpEjhQT49yT7iQCWjvtbDRJhejMre0z3lfr4tUY1EXlN9xAN99lJtiT2
         4ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcZGRsdag1ZZUZT8iClDOrVXoqs7IUmHnLWfOf2shy4=;
        b=UTM1pX9VYJizkv6kMLOz4xBgEtLi7kCYZA/G52RH3i/PntlYGG45JGPAPIzoaIIES8
         Dq1w8DG0S6LBnTvO5Jqh0nQb+Rm258dJ1E3CC+klDxTJ6/kVBCuFgri4kOt5q/4DnxzC
         iySAIxQSnSGz02R6BwV76nS2gyTLLPxXpe11Epb7Tslsr+SUzSOyZxHighaMHpsn62u6
         vgX7DiWWXsqQJSRdQ1/uDfMSjqA9+CnnAaWr95g8gqKY62kA6OlZQHrnF5gtLGqaZVeB
         +mw8V9w0XvCL4UPimqucKC83j7rx9nIMBktZoqjZvP+wArFZg2hNbzUA34gFhPTm2sxz
         VNuw==
X-Gm-Message-State: AO0yUKWP12eud0Jwq25mjC1GAs3lRydbpIDC9CWC9DVBqK3f2FK1mqEo
        LvKBMISzBUcajnqCaFb0WQZm5o9wNOY=
X-Google-Smtp-Source: AK7set/RkUreSOUE3yoNrt8Z2UIx6gud1+xVKxKwCny5GFiDzeeTwO7BlVUknOQulGP+/0EKR7cHQA==
X-Received: by 2002:a7b:c8c3:0:b0:3ed:711c:e8fe with SMTP id f3-20020a7bc8c3000000b003ed711ce8femr4482859wml.2.1679713007776;
        Fri, 24 Mar 2023 19:56:47 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:47 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 40/43] selftests/bpf: verifier/var_off.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:21 +0200
Message-Id: <20230325025524.144043-41-eddyz87@gmail.com>
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

Test verifier/var_off.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_var_off.c    | 349 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/var_off.c  | 291 ---------------
 3 files changed, 351 insertions(+), 291 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_var_off.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/var_off.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 54eb21ef9fad..44350e328da2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -37,6 +37,7 @@
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
 #include "verifier_value_or_null.skel.h"
+#include "verifier_var_off.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -96,3 +97,4 @@ void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
 void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
+void test_verifier_var_off(void)              { RUN(verifier_var_off); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
new file mode 100644
index 000000000000..83a90afba785
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/var_off.c */
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
+SEC("lwt_in")
+__description("variable-offset ctx access")
+__failure __msg("variable ctx access var_off=(0x0; 0x4)")
+__naked void variable_offset_ctx_access(void)
+{
+	asm volatile ("					\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 4-byte aligned */		\
+	r2 &= 4;					\
+	/* add it to skb.  We now have either &skb->len or\
+	 * &skb->pkt_type, but we don't know which	\
+	 */						\
+	r1 += r2;					\
+	/* dereference it */				\
+	r0 = *(u32*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read, priv vs unpriv")
+__success __failure_unpriv
+__msg_unpriv("R2 variable stack access prohibited for !root")
+__retval(0)
+__naked void stack_read_priv_vs_unpriv(void)
+{
+	asm volatile ("					\
+	/* Fill the top 8 bytes of the stack */		\
+	r0 = 0;						\
+	*(u64*)(r10 - 8) = r0;				\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 4-byte aligned */		\
+	r2 &= 4;					\
+	r2 -= 8;					\
+	/* add it to fp.  We now have either fp-4 or fp-8, but\
+	 * we don't know which				\
+	 */						\
+	r2 += r10;					\
+	/* dereference it for a stack read */		\
+	r0 = *(u32*)(r2 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lwt_in")
+__description("variable-offset stack read, uninitialized")
+__failure __msg("invalid variable-offset read from stack R2")
+__naked void variable_offset_stack_read_uninitialized(void)
+{
+	asm volatile ("					\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 4-byte aligned */		\
+	r2 &= 4;					\
+	r2 -= 8;					\
+	/* add it to fp.  We now have either fp-4 or fp-8, but\
+	 * we don't know which				\
+	 */						\
+	r2 += r10;					\
+	/* dereference it for a stack read */		\
+	r0 = *(u32*)(r2 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("variable-offset stack write, priv vs unpriv")
+__success __failure_unpriv
+/* Variable stack access is rejected for unprivileged.
+ */
+__msg_unpriv("R2 variable stack access prohibited for !root")
+__retval(0)
+__naked void stack_write_priv_vs_unpriv(void)
+{
+	asm volatile ("					\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 8-byte aligned */		\
+	r2 &= 8;					\
+	r2 -= 16;					\
+	/* Add it to fp.  We now have either fp-8 or fp-16, but\
+	 * we don't know which				\
+	 */						\
+	r2 += r10;					\
+	/* Dereference it for a stack write */		\
+	r0 = 0;						\
+	*(u64*)(r2 + 0) = r0;				\
+	/* Now read from the address we just wrote. This shows\
+	 * that, after a variable-offset write, a priviledged\
+	 * program can read the slots that were in the range of\
+	 * that write (even if the verifier doesn't actually know\
+	 * if the slot being read was really written to or not.\
+	 */						\
+	r3 = *(u64*)(r2 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("variable-offset stack write clobbers spilled regs")
+__failure
+/* In the priviledged case, dereferencing a spilled-and-then-filled
+ * register is rejected because the previous variable offset stack
+ * write might have overwritten the spilled pointer (i.e. we lose track
+ * of the spilled register when we analyze the write).
+ */
+__msg("R2 invalid mem access 'scalar'")
+__failure_unpriv
+/* The unprivileged case is not too interesting; variable
+ * stack access is rejected.
+ */
+__msg_unpriv("R2 variable stack access prohibited for !root")
+__naked void stack_write_clobbers_spilled_regs(void)
+{
+	asm volatile ("					\
+	/* Dummy instruction; needed because we need to patch the next one\
+	 * and we can't patch the first instruction.	\
+	 */						\
+	r6 = 0;						\
+	/* Make R0 a map ptr */				\
+	r0 = %[map_hash_8b] ll;				\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 8-byte aligned */		\
+	r2 &= 8;					\
+	r2 -= 16;					\
+	/* Add it to fp. We now have either fp-8 or fp-16, but\
+	 * we don't know which.				\
+	 */						\
+	r2 += r10;					\
+	/* Spill R0(map ptr) into stack */		\
+	*(u64*)(r10 - 8) = r0;				\
+	/* Dereference the unknown value for a stack write */\
+	r0 = 0;						\
+	*(u64*)(r2 + 0) = r0;				\
+	/* Fill the register back into R2 */		\
+	r2 = *(u64*)(r10 - 8);				\
+	/* Try to dereference R2 for a memory load */	\
+	r0 = *(u64*)(r2 + 8);				\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("sockops")
+__description("indirect variable-offset stack access, unbounded")
+__failure __msg("invalid unbounded variable-offset indirect access to stack R4")
+__naked void variable_offset_stack_access_unbounded(void)
+{
+	asm volatile ("					\
+	r2 = 6;						\
+	r3 = 28;					\
+	/* Fill the top 16 bytes of the stack. */	\
+	r4 = 0;						\
+	*(u64*)(r10 - 16) = r4;				\
+	r4 = 0;						\
+	*(u64*)(r10 - 8) = r4;				\
+	/* Get an unknown value. */			\
+	r4 = *(u64*)(r1 + %[bpf_sock_ops_bytes_received]);\
+	/* Check the lower bound but don't check the upper one. */\
+	if r4 s< 0 goto l0_%=;				\
+	/* Point the lower bound to initialized stack. Offset is now in range\
+	 * from fp-16 to fp+0x7fffffffffffffef, i.e. max value is unbounded.\
+	 */						\
+	r4 -= 16;					\
+	r4 += r10;					\
+	r5 = 8;						\
+	/* Dereference it indirectly. */		\
+	call %[bpf_getsockopt];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_getsockopt),
+	  __imm_const(bpf_sock_ops_bytes_received, offsetof(struct bpf_sock_ops, bytes_received))
+	: __clobber_all);
+}
+
+SEC("lwt_in")
+__description("indirect variable-offset stack access, max out of bound")
+__failure __msg("invalid variable-offset indirect access to stack R2")
+__naked void access_max_out_of_bound(void)
+{
+	asm volatile ("					\
+	/* Fill the top 8 bytes of the stack */		\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 4-byte aligned */		\
+	r2 &= 4;					\
+	r2 -= 8;					\
+	/* add it to fp.  We now have either fp-4 or fp-8, but\
+	 * we don't know which				\
+	 */						\
+	r2 += r10;					\
+	/* dereference it indirectly */			\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("lwt_in")
+__description("indirect variable-offset stack access, min out of bound")
+__failure __msg("invalid variable-offset indirect access to stack R2")
+__naked void access_min_out_of_bound(void)
+{
+	asm volatile ("					\
+	/* Fill the top 8 bytes of the stack */		\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 4-byte aligned */		\
+	r2 &= 4;					\
+	r2 -= 516;					\
+	/* add it to fp.  We now have either fp-516 or fp-512, but\
+	 * we don't know which				\
+	 */						\
+	r2 += r10;					\
+	/* dereference it indirectly */			\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("lwt_in")
+__description("indirect variable-offset stack access, min_off < min_initialized")
+__failure __msg("invalid indirect read from stack R2 var_off")
+__naked void access_min_off_min_initialized(void)
+{
+	asm volatile ("					\
+	/* Fill only the top 8 bytes of the stack. */	\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	/* Get an unknown value */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 4-byte aligned. */		\
+	r2 &= 4;					\
+	r2 -= 16;					\
+	/* Add it to fp.  We now have either fp-12 or fp-16, but we don't know\
+	 * which. fp-16 size 8 is partially uninitialized stack.\
+	 */						\
+	r2 += r10;					\
+	/* Dereference it indirectly. */		\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("indirect variable-offset stack access, priv vs unpriv")
+__success __failure_unpriv
+__msg_unpriv("R2 variable stack access prohibited for !root")
+__retval(0)
+__naked void stack_access_priv_vs_unpriv(void)
+{
+	asm volatile ("					\
+	/* Fill the top 16 bytes of the stack. */	\
+	r2 = 0;						\
+	*(u64*)(r10 - 16) = r2;				\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	/* Get an unknown value. */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 4-byte aligned. */		\
+	r2 &= 4;					\
+	r2 -= 16;					\
+	/* Add it to fp.  We now have either fp-12 or fp-16, we don't know\
+	 * which, but either way it points to initialized stack.\
+	 */						\
+	r2 += r10;					\
+	/* Dereference it indirectly. */		\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("lwt_in")
+__description("indirect variable-offset stack access, ok")
+__success __retval(0)
+__naked void variable_offset_stack_access_ok(void)
+{
+	asm volatile ("					\
+	/* Fill the top 16 bytes of the stack. */	\
+	r2 = 0;						\
+	*(u64*)(r10 - 16) = r2;				\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	/* Get an unknown value. */			\
+	r2 = *(u32*)(r1 + 0);				\
+	/* Make it small and 4-byte aligned. */		\
+	r2 &= 4;					\
+	r2 -= 16;					\
+	/* Add it to fp.  We now have either fp-12 or fp-16, we don't know\
+	 * which, but either way it points to initialized stack.\
+	 */						\
+	r2 += r10;					\
+	/* Dereference it indirectly. */		\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
deleted file mode 100644
index b183e26c03f1..000000000000
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ /dev/null
@@ -1,291 +0,0 @@
-{
-	"variable-offset ctx access",
-	.insns = {
-	/* Get an unknown value */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	/* add it to skb.  We now have either &skb->len or
-	 * &skb->pkt_type, but we don't know which
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
-	/* dereference it */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "variable ctx access var_off=(0x0; 0x4)",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-{
-	"variable-offset stack read, priv vs unpriv",
-	.insns = {
-	/* Fill the top 8 bytes of the stack */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 8),
-	/* add it to fp.  We now have either fp-4 or fp-8, but
-	 * we don't know which
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* dereference it for a stack read */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R2 variable stack access prohibited for !root",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"variable-offset stack read, uninitialized",
-	.insns = {
-	/* Get an unknown value */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 8),
-	/* add it to fp.  We now have either fp-4 or fp-8, but
-	 * we don't know which
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* dereference it for a stack read */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid variable-offset read from stack R2",
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-{
-	"variable-offset stack write, priv vs unpriv",
-	.insns = {
-	/* Get an unknown value */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 8-byte aligned */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 8),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
-	/* Add it to fp.  We now have either fp-8 or fp-16, but
-	 * we don't know which
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* Dereference it for a stack write */
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	/* Now read from the address we just wrote. This shows
-	 * that, after a variable-offset write, a priviledged
-	 * program can read the slots that were in the range of
-	 * that write (even if the verifier doesn't actually know
-	 * if the slot being read was really written to or not.
-	 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	/* Variable stack access is rejected for unprivileged.
-	 */
-	.errstr_unpriv = "R2 variable stack access prohibited for !root",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"variable-offset stack write clobbers spilled regs",
-	.insns = {
-	/* Dummy instruction; needed because we need to patch the next one
-	 * and we can't patch the first instruction.
-	 */
-	BPF_MOV64_IMM(BPF_REG_6, 0),
-	/* Make R0 a map ptr */
-	BPF_LD_MAP_FD(BPF_REG_0, 0),
-	/* Get an unknown value */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 8-byte aligned */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 8),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
-	/* Add it to fp. We now have either fp-8 or fp-16, but
-	 * we don't know which.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* Spill R0(map ptr) into stack */
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	/* Dereference the unknown value for a stack write */
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	/* Fill the register back into R2 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -8),
-	/* Try to dereference R2 for a memory load */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 8),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 1 },
-	/* The unprivileged case is not too interesting; variable
-	 * stack access is rejected.
-	 */
-	.errstr_unpriv = "R2 variable stack access prohibited for !root",
-	.result_unpriv = REJECT,
-	/* In the priviledged case, dereferencing a spilled-and-then-filled
-	 * register is rejected because the previous variable offset stack
-	 * write might have overwritten the spilled pointer (i.e. we lose track
-	 * of the spilled register when we analyze the write).
-	 */
-	.errstr = "R2 invalid mem access 'scalar'",
-	.result = REJECT,
-},
-{
-	"indirect variable-offset stack access, unbounded",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 6),
-	BPF_MOV64_IMM(BPF_REG_3, 28),
-	/* Fill the top 16 bytes of the stack. */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value. */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
-							   bytes_received)),
-	/* Check the lower bound but don't check the upper one. */
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_4, 0, 4),
-	/* Point the lower bound to initialized stack. Offset is now in range
-	 * from fp-16 to fp+0x7fffffffffffffef, i.e. max value is unbounded.
-	 */
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_4, 16),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_10),
-	BPF_MOV64_IMM(BPF_REG_5, 8),
-	/* Dereference it indirectly. */
-	BPF_EMIT_CALL(BPF_FUNC_getsockopt),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid unbounded variable-offset indirect access to stack R4",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
-},
-{
-	"indirect variable-offset stack access, max out of bound",
-	.insns = {
-	/* Fill the top 8 bytes of the stack */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 8),
-	/* add it to fp.  We now have either fp-4 or fp-8, but
-	 * we don't know which
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* dereference it indirectly */
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "invalid variable-offset indirect access to stack R2",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-{
-	"indirect variable-offset stack access, min out of bound",
-	.insns = {
-	/* Fill the top 8 bytes of the stack */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 516),
-	/* add it to fp.  We now have either fp-516 or fp-512, but
-	 * we don't know which
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* dereference it indirectly */
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "invalid variable-offset indirect access to stack R2",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-{
-	"indirect variable-offset stack access, min_off < min_initialized",
-	.insns = {
-	/* Fill only the top 8 bytes of the stack. */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned. */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
-	/* Add it to fp.  We now have either fp-12 or fp-16, but we don't know
-	 * which. fp-16 size 8 is partially uninitialized stack.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* Dereference it indirectly. */
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "invalid indirect read from stack R2 var_off",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-{
-	"indirect variable-offset stack access, priv vs unpriv",
-	.insns = {
-	/* Fill the top 16 bytes of the stack. */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value. */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned. */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
-	/* Add it to fp.  We now have either fp-12 or fp-16, we don't know
-	 * which, but either way it points to initialized stack.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* Dereference it indirectly. */
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 6 },
-	.errstr_unpriv = "R2 variable stack access prohibited for !root",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"indirect variable-offset stack access, ok",
-	.insns = {
-	/* Fill the top 16 bytes of the stack. */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value. */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned. */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
-	/* Add it to fp.  We now have either fp-12 or fp-16, we don't know
-	 * which, but either way it points to initialized stack.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* Dereference it indirectly. */
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 6 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
-- 
2.40.0

