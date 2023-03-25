Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC46C8A7A
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjCYC4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjCYC4s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A466215170
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s13so2093150wmr.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgnjozw+HtmSwQ6AMvxB0DXem3D4q67nysz/ZVq82qk=;
        b=mNtwqpEAJc+Y9yfjmgcq0qHE/5kbeYxjRixZ7zB1fNQWU+Zd+M3NgD0buy0H2k6guS
         X1H1R6S1//WDg8GL6vRegKrDVEDv11Td6PFDUgZ3h6FsDMJwXKN5I/8SMrgI+uVVbOta
         2H3fDLvcNnqEm52YBJEzAs2G5E6lgfjAbqkwiOZ/NBKdLKpqn8T1b37UEvIX2rZjafL6
         mgkxL9GBndXBMxR4xVWLhrUpN7PIY1cXsiopmnl8ZNtmauoK02041IL+Ip7EBEjAL7bf
         t1U3+q1gxeT2l0km3j7JaVfNhSLVADub48LJXgbbmaR49zJLttJpgDqw87Ssso/tO6z2
         1wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qgnjozw+HtmSwQ6AMvxB0DXem3D4q67nysz/ZVq82qk=;
        b=4Z15GK2yz5K9akojymjB6RoW0C0awSLuryn7cKS0Kvck1GZAhv4ZKPIWUNSEkP4ld7
         fnqYE3+FhydYxjhfWMHJjG7xO/ceZXLekArfB0S9SHItwgPqvivs37b56/ZrazI6QyT4
         90Bu766iq3B5RYl7THLRJOmc2umtLwisWMcPlc2jIh3IjelvWIibDIspH400Ggf/GR6a
         613zDJLBx2s6ucoU0ySrbINSfVFfiZqzxDK3MiyyUaDYWnVGqsTuDMUONkn2R88L0N8+
         zTb7MlbR8HnaBUqnD+LQ/O0F3G9FW7guqJZphbvAUy77LPdBnxWFDPJxfniQzwjQPded
         d08A==
X-Gm-Message-State: AO0yUKWzRT/3dwJdPe9RiTIzfLRlNE87scj+unCWmobr3jMXQ6SQSwP2
        xNgzuCD18GBTy2eMrmYzK5orxkkE5Do=
X-Google-Smtp-Source: AK7set8nsAE/RwNxq72xDFqC0LZ0ICbrChCaRd9/1UST3fJH9/XFSY/lWSRUxR8t42miN3MF5I5xlQ==
X-Received: by 2002:a7b:cb86:0:b0:3dc:433a:e952 with SMTP id m6-20020a7bcb86000000b003dc433ae952mr3808519wmi.33.1679712995848;
        Fri, 24 Mar 2023 19:56:35 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:35 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 31/43] selftests/bpf: verifier/raw_stack.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:12 +0200
Message-Id: <20230325025524.144043-32-eddyz87@gmail.com>
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

Test verifier/raw_stack.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_raw_stack.c  | 371 ++++++++++++++++++
 .../selftests/bpf/verifier/raw_stack.c        | 305 --------------
 3 files changed, 373 insertions(+), 305 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_raw_stack.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/raw_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index bd48a584a356..4a73cac3f9ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -28,6 +28,7 @@
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
 #include "verifier_meta_access.skel.h"
+#include "verifier_raw_stack.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -78,3 +79,4 @@ void test_verifier_map_ptr(void)              { RUN(verifier_map_ptr); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
+void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
new file mode 100644
index 000000000000..efbfc3a4ad6a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/raw_stack.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tc")
+__description("raw_stack: no skb_load_bytes")
+__failure __msg("invalid read from stack R6 off=-8 size=8")
+__naked void stack_no_skb_load_bytes(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	r3 = r6;					\
+	r4 = 8;						\
+	/* Call to skb_load_bytes() omitted. */		\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, negative len")
+__failure __msg("R4 min value is negative")
+__naked void skb_load_bytes_negative_len(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	r3 = r6;					\
+	r4 = -8;					\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, negative len 2")
+__failure __msg("R4 min value is negative")
+__naked void load_bytes_negative_len_2(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	r3 = r6;					\
+	r4 = %[__imm_0];				\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__imm_0, ~0)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, zero len")
+__failure __msg("invalid zero-sized read")
+__naked void skb_load_bytes_zero_len(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	r3 = r6;					\
+	r4 = 0;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, no init")
+__success __retval(0)
+__naked void skb_load_bytes_no_init(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	r3 = r6;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, init")
+__success __retval(0)
+__naked void stack_skb_load_bytes_init(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	r3 = 0xcafe;					\
+	*(u64*)(r6 + 0) = r3;				\
+	r3 = r6;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, spilled regs around bounds")
+__success __retval(0)
+__naked void bytes_spilled_regs_around_bounds(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -16;					\
+	*(u64*)(r6 - 8) = r1;				\
+	*(u64*)(r6 + 8) = r1;				\
+	r3 = r6;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 - 8);				\
+	r2 = *(u64*)(r6 + 8);				\
+	r0 = *(u32*)(r0 + %[__sk_buff_mark]);		\
+	r2 = *(u32*)(r2 + %[__sk_buff_priority]);	\
+	r0 += r2;					\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(__sk_buff_priority, offsetof(struct __sk_buff, priority))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, spilled regs corruption")
+__failure __msg("R0 invalid mem access 'scalar'")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void load_bytes_spilled_regs_corruption(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	*(u64*)(r6 + 0) = r1;				\
+	r3 = r6;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	r0 = *(u32*)(r0 + %[__sk_buff_mark]);		\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, spilled regs corruption 2")
+__failure __msg("R3 invalid mem access 'scalar'")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void bytes_spilled_regs_corruption_2(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -16;					\
+	*(u64*)(r6 - 8) = r1;				\
+	*(u64*)(r6 + 0) = r1;				\
+	*(u64*)(r6 + 8) = r1;				\
+	r3 = r6;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 - 8);				\
+	r2 = *(u64*)(r6 + 8);				\
+	r3 = *(u64*)(r6 + 0);				\
+	r0 = *(u32*)(r0 + %[__sk_buff_mark]);		\
+	r2 = *(u32*)(r2 + %[__sk_buff_priority]);	\
+	r0 += r2;					\
+	r3 = *(u32*)(r3 + %[__sk_buff_pkt_type]);	\
+	r0 += r3;					\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(__sk_buff_pkt_type, offsetof(struct __sk_buff, pkt_type)),
+	  __imm_const(__sk_buff_priority, offsetof(struct __sk_buff, priority))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, spilled regs + data")
+__success __retval(0)
+__naked void load_bytes_spilled_regs_data(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -16;					\
+	*(u64*)(r6 - 8) = r1;				\
+	*(u64*)(r6 + 0) = r1;				\
+	*(u64*)(r6 + 8) = r1;				\
+	r3 = r6;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 - 8);				\
+	r2 = *(u64*)(r6 + 8);				\
+	r3 = *(u64*)(r6 + 0);				\
+	r0 = *(u32*)(r0 + %[__sk_buff_mark]);		\
+	r2 = *(u32*)(r2 + %[__sk_buff_priority]);	\
+	r0 += r2;					\
+	r0 += r3;					\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(__sk_buff_priority, offsetof(struct __sk_buff, priority))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, invalid access 1")
+__failure __msg("invalid indirect access to stack R3 off=-513 size=8")
+__naked void load_bytes_invalid_access_1(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -513;					\
+	r3 = r6;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, invalid access 2")
+__failure __msg("invalid indirect access to stack R3 off=-1 size=8")
+__naked void load_bytes_invalid_access_2(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -1;					\
+	r3 = r6;					\
+	r4 = 8;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, invalid access 3")
+__failure __msg("R4 min value is negative")
+__naked void load_bytes_invalid_access_3(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += 0xffffffff;				\
+	r3 = r6;					\
+	r4 = 0xffffffff;				\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, invalid access 4")
+__failure
+__msg("R4 unbounded memory access, use 'var &= const' or 'if (var < const)'")
+__naked void load_bytes_invalid_access_4(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -1;					\
+	r3 = r6;					\
+	r4 = 0x7fffffff;				\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, invalid access 5")
+__failure
+__msg("R4 unbounded memory access, use 'var &= const' or 'if (var < const)'")
+__naked void load_bytes_invalid_access_5(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -512;					\
+	r3 = r6;					\
+	r4 = 0x7fffffff;				\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, invalid access 6")
+__failure __msg("invalid zero-sized read")
+__naked void load_bytes_invalid_access_6(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -512;					\
+	r3 = r6;					\
+	r4 = 0;						\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("raw_stack: skb_load_bytes, large access")
+__success __retval(0)
+__naked void skb_load_bytes_large_access(void)
+{
+	asm volatile ("					\
+	r2 = 4;						\
+	r6 = r10;					\
+	r6 += -512;					\
+	r3 = r6;					\
+	r4 = 512;					\
+	call %[bpf_skb_load_bytes];			\
+	r0 = *(u64*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/raw_stack.c b/tools/testing/selftests/bpf/verifier/raw_stack.c
deleted file mode 100644
index eb5ed936580b..000000000000
--- a/tools/testing/selftests/bpf/verifier/raw_stack.c
+++ /dev/null
@@ -1,305 +0,0 @@
-{
-	"raw_stack: no skb_load_bytes",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	/* Call to skb_load_bytes() omitted. */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid read from stack R6 off=-8 size=8",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, negative len",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, -8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R4 min value is negative",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, negative len 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, ~0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R4 min value is negative",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, zero len",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid zero-sized read",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, no init",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, init",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_6, 0, 0xcafe),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, spilled regs around bounds",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,  8),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6,  8),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_2,
-		    offsetof(struct __sk_buff, priority)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, spilled regs corruption",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R0 invalid mem access 'scalar'",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"raw_stack: skb_load_bytes, spilled regs corruption 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,  0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,  8),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6,  8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,  0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_2,
-		    offsetof(struct __sk_buff, priority)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_3,
-		    offsetof(struct __sk_buff, pkt_type)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_3),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R3 invalid mem access 'scalar'",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"raw_stack: skb_load_bytes, spilled regs + data",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,  0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,  8),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6,  8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,  0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_2,
-		    offsetof(struct __sk_buff, priority)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_3),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, invalid access 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -513),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid indirect access to stack R3 off=-513 size=8",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, invalid access 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -1),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid indirect access to stack R3 off=-1 size=8",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, invalid access 3",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 0xffffffff),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 0xffffffff),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R4 min value is negative",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, invalid access 4",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -1),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 0x7fffffff),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R4 unbounded memory access, use 'var &= const' or 'if (var < const)'",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, invalid access 5",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -512),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 0x7fffffff),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R4 unbounded memory access, use 'var &= const' or 'if (var < const)'",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, invalid access 6",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -512),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid zero-sized read",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"raw_stack: skb_load_bytes, large access",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -512),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_4, 512),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-- 
2.40.0

