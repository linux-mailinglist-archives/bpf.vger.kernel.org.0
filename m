Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042E36C8A7D
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjCYC44 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjCYC4z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8B01B314
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so1969914wms.2
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679713001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZQzHAvXhDPwgxZDN/YqtGVKbePEtmBKdOq64spJKKc=;
        b=TPtME8WfOBOLZ0rQWPXF9D+en5q2c2UDfi9PgQWcC7j/Jsr7TJ+cOkai7tn5u7R7tx
         Xfc4Em72WR2kplgNrkd+KNiKihiamwLIPBPQBL5Ua+M/VyGNYTAEe1wR7D69gwxKxa9H
         E3y5r3X7uwnhKdp/LzPtN1cp20O10rfvbbvtHZF9laVhhhTzt51sA1pKPxr4rZNkBZ3B
         Co89941dSr2tBljUn0+LK302Rs3bLk0/YIOoK5WpDpMFcYrTHFTip51hKeb301YoMQ6+
         /uE9yIbrfSVIMVdw0Y768Fqxg08G5AevtBddWl2frTd9BYbooa7S2djSlFtE9FL1VZb0
         yeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZQzHAvXhDPwgxZDN/YqtGVKbePEtmBKdOq64spJKKc=;
        b=qZMKGp16ZrNUkg2D+sxpjVlbOpaPLG8A7oyvyZY97lkaWwycHup3fNgpafWYRuEsZM
         SLJXk6vx8Yl3jj31jhmrFEDu5gZ2c1Ne7BivQC2ZFmY3a7lJruJkxrhFVKdrqEPwLcH4
         hb/f+JyqkbtOOK3sjL+CwlygqiX00S5ksP6tGXK4L6K8Cz+CxOcqT3I8J8PV4SQSubR3
         qHUgJ8EpJWyRKzOovg/Zscf57MZ3gronBhxmyYpLoK77yIWGcqG7nONAxoFRsix7iB6d
         Y0GFJ7s5hZbWwxiu2Aooogz+y4yQe4dEULmlfN4GYzhUa53Iej8lK+cRYBrrnDkJ4ppl
         23Ng==
X-Gm-Message-State: AO0yUKXNvlrFnSd0aZ4iGxAFEFaaW65LaIF8gtusNR5IlBkID8TZkShS
        K+yS38Xj3GK5wKUuzQLRfVs2e2UYXM0=
X-Google-Smtp-Source: AK7set9gD73+siUGCp/cXM/Hug6ZAUI+/OAuJYf38+Drff+nZ0p0ucb8J1Cgwj3gj1sJQzxkST6M+w==
X-Received: by 2002:a05:600c:2286:b0:3ea:ecc2:daab with SMTP id 6-20020a05600c228600b003eaecc2daabmr4650993wmf.3.1679713001244;
        Fri, 24 Mar 2023 19:56:41 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:40 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 35/43] selftests/bpf: verifier/stack_ptr.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:16 +0200
Message-Id: <20230325025524.144043-36-eddyz87@gmail.com>
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

Test verifier/stack_ptr.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_stack_ptr.c  | 484 ++++++++++++++++++
 .../selftests/bpf/verifier/stack_ptr.c        | 359 -------------
 3 files changed, 486 insertions(+), 359 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/stack_ptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e2b131d2ba94..ce1ca8c0c02e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -32,6 +32,7 @@
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_ringbuf.skel.h"
 #include "verifier_spill_fill.skel.h"
+#include "verifier_stack_ptr.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -86,3 +87,4 @@ void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
+void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
new file mode 100644
index 000000000000..e0f77e3e7869
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/stack_ptr.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <limits.h>
+#include "bpf_misc.h"
+
+#define MAX_ENTRIES 11
+
+struct test_val {
+	unsigned int index;
+	int foo[MAX_ENTRIES];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct test_val);
+} map_array_48b SEC(".maps");
+
+SEC("socket")
+__description("PTR_TO_STACK store/load")
+__success __success_unpriv __retval(0xfaceb00c)
+__naked void ptr_to_stack_store_load(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -10;					\
+	r0 = 0xfaceb00c;				\
+	*(u64*)(r1 + 2) = r0;				\
+	r0 = *(u64*)(r1 + 2);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK store/load - bad alignment on off")
+__failure __msg("misaligned stack access off (0x0; 0x0)+-8+2 size 8")
+__failure_unpriv
+__naked void load_bad_alignment_on_off(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -8;					\
+	r0 = 0xfaceb00c;				\
+	*(u64*)(r1 + 2) = r0;				\
+	r0 = *(u64*)(r1 + 2);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK store/load - bad alignment on reg")
+__failure __msg("misaligned stack access off (0x0; 0x0)+-10+8 size 8")
+__failure_unpriv
+__naked void load_bad_alignment_on_reg(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -10;					\
+	r0 = 0xfaceb00c;				\
+	*(u64*)(r1 + 8) = r0;				\
+	r0 = *(u64*)(r1 + 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK store/load - out of bounds low")
+__failure __msg("invalid write to stack R1 off=-79992 size=8")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void load_out_of_bounds_low(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -80000;					\
+	r0 = 0xfaceb00c;				\
+	*(u64*)(r1 + 8) = r0;				\
+	r0 = *(u64*)(r1 + 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK store/load - out of bounds high")
+__failure __msg("invalid write to stack R1 off=0 size=8")
+__failure_unpriv
+__naked void load_out_of_bounds_high(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -8;					\
+	r0 = 0xfaceb00c;				\
+	*(u64*)(r1 + 8) = r0;				\
+	r0 = *(u64*)(r1 + 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check high 1")
+__success __success_unpriv __retval(42)
+__naked void to_stack_check_high_1(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -1;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check high 2")
+__success __success_unpriv __retval(42)
+__naked void to_stack_check_high_2(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r0 = 42;					\
+	*(u8*)(r1 - 1) = r0;				\
+	r0 = *(u8*)(r1 - 1);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check high 3")
+__success __failure_unpriv
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__retval(42)
+__naked void to_stack_check_high_3(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += 0;					\
+	r0 = 42;					\
+	*(u8*)(r1 - 1) = r0;				\
+	r0 = *(u8*)(r1 - 1);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check high 4")
+__failure __msg("invalid write to stack R1 off=0 size=1")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void to_stack_check_high_4(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += 0;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check high 5")
+__failure __msg("invalid write to stack R1")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void to_stack_check_high_5(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += %[__imm_0];				\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, (1 << 29) - 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check high 6")
+__failure __msg("invalid write to stack")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void to_stack_check_high_6(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += %[__imm_0];				\
+	r0 = 42;					\
+	*(u8*)(r1 + %[shrt_max]) = r0;			\
+	r0 = *(u8*)(r1 + %[shrt_max]);			\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, (1 << 29) - 1),
+	  __imm_const(shrt_max, SHRT_MAX)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check high 7")
+__failure __msg("fp pointer offset")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void to_stack_check_high_7(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += %[__imm_0];				\
+	r1 += %[__imm_0];				\
+	r0 = 42;					\
+	*(u8*)(r1 + %[shrt_max]) = r0;			\
+	r0 = *(u8*)(r1 + %[shrt_max]);			\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, (1 << 29) - 1),
+	  __imm_const(shrt_max, SHRT_MAX)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check low 1")
+__success __success_unpriv __retval(42)
+__naked void to_stack_check_low_1(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -512;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check low 2")
+__success __failure_unpriv
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__retval(42)
+__naked void to_stack_check_low_2(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -513;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 1) = r0;				\
+	r0 = *(u8*)(r1 + 1);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check low 3")
+__failure __msg("invalid write to stack R1 off=-513 size=1")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void to_stack_check_low_3(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -513;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check low 4")
+__failure __msg("math between fp pointer")
+__failure_unpriv
+__naked void to_stack_check_low_4(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += %[int_min];				\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check low 5")
+__failure __msg("invalid write to stack")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void to_stack_check_low_5(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += %[__imm_0];				\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, -((1 << 29) - 1))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check low 6")
+__failure __msg("invalid write to stack")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void to_stack_check_low_6(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += %[__imm_0];				\
+	r0 = 42;					\
+	*(u8*)(r1  %[shrt_min]) = r0;			\
+	r0 = *(u8*)(r1  %[shrt_min]);			\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, -((1 << 29) - 1)),
+	  __imm_const(shrt_min, SHRT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK check low 7")
+__failure __msg("fp pointer offset")
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__naked void to_stack_check_low_7(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += %[__imm_0];				\
+	r1 += %[__imm_0];				\
+	r0 = 42;					\
+	*(u8*)(r1  %[shrt_min]) = r0;			\
+	r0 = *(u8*)(r1  %[shrt_min]);			\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, -((1 << 29) - 1)),
+	  __imm_const(shrt_min, SHRT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK mixed reg/k, 1")
+__success __success_unpriv __retval(42)
+__naked void stack_mixed_reg_k_1(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -3;					\
+	r2 = -3;					\
+	r1 += r2;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK mixed reg/k, 2")
+__success __success_unpriv __retval(42)
+__naked void stack_mixed_reg_k_2(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r10 - 8) = r0;				\
+	r0 = 0;						\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = r10;					\
+	r1 += -3;					\
+	r2 = -3;					\
+	r1 += r2;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r5 = r10;					\
+	r0 = *(u8*)(r5 - 6);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK mixed reg/k, 3")
+__success __success_unpriv __retval(-3)
+__naked void stack_mixed_reg_k_3(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -3;					\
+	r2 = -3;					\
+	r1 += r2;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK reg")
+__success __success_unpriv __retval(42)
+__naked void ptr_to_stack_reg(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r2 = -3;					\
+	r1 += r2;					\
+	r0 = 42;					\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = *(u8*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("stack pointer arithmetic")
+__success __success_unpriv __retval(0)
+__naked void stack_pointer_arithmetic(void)
+{
+	asm volatile ("					\
+	r1 = 4;						\
+	goto l0_%=;					\
+l0_%=:	r7 = r10;					\
+	r7 += -10;					\
+	r7 += -10;					\
+	r2 = r7;					\
+	r2 += r1;					\
+	r0 = 0;						\
+	*(u32*)(r2 + 4) = r0;				\
+	r2 = r7;					\
+	r2 += 8;					\
+	r0 = 0;						\
+	*(u32*)(r2 + 4) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("store PTR_TO_STACK in R10 to array map using BPF_B")
+__success __retval(42)
+__naked void array_map_using_bpf_b(void)
+{
+	asm volatile ("					\
+	/* Load pointer to map. */			\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	r0 = 2;						\
+	exit;						\
+l0_%=:	r1 = r0;					\
+	/* Copy R10 to R9. */				\
+	r9 = r10;					\
+	/* Pollute other registers with unaligned values. */\
+	r2 = -1;					\
+	r3 = -1;					\
+	r4 = -1;					\
+	r5 = -1;					\
+	r6 = -1;					\
+	r7 = -1;					\
+	r8 = -1;					\
+	/* Store both R9 and R10 with BPF_B and read back. */\
+	*(u8*)(r1 + 0) = r10;				\
+	r2 = *(u8*)(r1 + 0);				\
+	*(u8*)(r1 + 0) = r9;				\
+	r3 = *(u8*)(r1 + 0);				\
+	/* Should read back as same value. */		\
+	if r2 == r3 goto l1_%=;				\
+	r0 = 1;						\
+	exit;						\
+l1_%=:	r0 = 42;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/stack_ptr.c b/tools/testing/selftests/bpf/verifier/stack_ptr.c
deleted file mode 100644
index 8ab94d65f3d5..000000000000
--- a/tools/testing/selftests/bpf/verifier/stack_ptr.c
+++ /dev/null
@@ -1,359 +0,0 @@
-{
-	"PTR_TO_STACK store/load",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -10),
-	BPF_ST_MEM(BPF_DW, BPF_REG_1, 2, 0xfaceb00c),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 0xfaceb00c,
-},
-{
-	"PTR_TO_STACK store/load - bad alignment on off",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_1, 2, 0xfaceb00c),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 2),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "misaligned stack access off (0x0; 0x0)+-8+2 size 8",
-},
-{
-	"PTR_TO_STACK store/load - bad alignment on reg",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -10),
-	BPF_ST_MEM(BPF_DW, BPF_REG_1, 8, 0xfaceb00c),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 8),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "misaligned stack access off (0x0; 0x0)+-10+8 size 8",
-},
-{
-	"PTR_TO_STACK store/load - out of bounds low",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -80000),
-	BPF_ST_MEM(BPF_DW, BPF_REG_1, 8, 0xfaceb00c),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 8),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid write to stack R1 off=-79992 size=8",
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-},
-{
-	"PTR_TO_STACK store/load - out of bounds high",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_1, 8, 0xfaceb00c),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 8),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid write to stack R1 off=0 size=8",
-},
-{
-	"PTR_TO_STACK check high 1",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -1),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"PTR_TO_STACK check high 2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, -1, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, -1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"PTR_TO_STACK check high 3",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, -1, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, -1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"PTR_TO_STACK check high 4",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.errstr = "invalid write to stack R1 off=0 size=1",
-	.result = REJECT,
-},
-{
-	"PTR_TO_STACK check high 5",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, (1 << 29) - 1),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.errstr = "invalid write to stack R1",
-},
-{
-	"PTR_TO_STACK check high 6",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, (1 << 29) - 1),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, SHRT_MAX, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, SHRT_MAX),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.errstr = "invalid write to stack",
-},
-{
-	"PTR_TO_STACK check high 7",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, (1 << 29) - 1),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, (1 << 29) - 1),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, SHRT_MAX, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, SHRT_MAX),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.errstr = "fp pointer offset",
-},
-{
-	"PTR_TO_STACK check low 1",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -512),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"PTR_TO_STACK check low 2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -513),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 1, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 1),
-	BPF_EXIT_INSN(),
-	},
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"PTR_TO_STACK check low 3",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -513),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.errstr = "invalid write to stack R1 off=-513 size=1",
-	.result = REJECT,
-},
-{
-	"PTR_TO_STACK check low 4",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, INT_MIN),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "math between fp pointer",
-},
-{
-	"PTR_TO_STACK check low 5",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -((1 << 29) - 1)),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.errstr = "invalid write to stack",
-},
-{
-	"PTR_TO_STACK check low 6",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -((1 << 29) - 1)),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, SHRT_MIN, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, SHRT_MIN),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid write to stack",
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-},
-{
-	"PTR_TO_STACK check low 7",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -((1 << 29) - 1)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -((1 << 29) - 1)),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, SHRT_MIN, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, SHRT_MIN),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.errstr = "fp pointer offset",
-},
-{
-	"PTR_TO_STACK mixed reg/k, 1",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -3),
-	BPF_MOV64_IMM(BPF_REG_2, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"PTR_TO_STACK mixed reg/k, 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -3),
-	BPF_MOV64_IMM(BPF_REG_2, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_10),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_5, -6),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"PTR_TO_STACK mixed reg/k, 3",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -3),
-	BPF_MOV64_IMM(BPF_REG_2, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = -3,
-},
-{
-	"PTR_TO_STACK reg",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_MOV64_IMM(BPF_REG_2, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"stack pointer arithmetic",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -10),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
-	BPF_ST_MEM(0, BPF_REG_2, 4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 8),
-	BPF_ST_MEM(0, BPF_REG_2, 4, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-},
-{
-	"store PTR_TO_STACK in R10 to array map using BPF_B",
-	.insns = {
-	/* Load pointer to map. */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 2),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	/* Copy R10 to R9. */
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_10),
-	/* Pollute other registers with unaligned values. */
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_MOV64_IMM(BPF_REG_3, -1),
-	BPF_MOV64_IMM(BPF_REG_4, -1),
-	BPF_MOV64_IMM(BPF_REG_5, -1),
-	BPF_MOV64_IMM(BPF_REG_6, -1),
-	BPF_MOV64_IMM(BPF_REG_7, -1),
-	BPF_MOV64_IMM(BPF_REG_8, -1),
-	/* Store both R9 and R10 with BPF_B and read back. */
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_10, 0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_1, 0),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_9, 0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_3, BPF_REG_1, 0),
-	/* Should read back as same value. */
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_3, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 42),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 42,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-- 
2.40.0

