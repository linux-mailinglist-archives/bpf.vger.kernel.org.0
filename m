Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F2C6C8A66
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjCYC4O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjCYC4N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D820193F4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so3540480wrd.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IblyOyTQli4avz4P0YzTwzWaLsUKVjYmFUh+H3l3Cxk=;
        b=AZl5FXrDDflxMP/b0QsPxg6DvLSchdxMI8cVWfL1asb9rX+tva7HZH67q02Sx+2wjG
         1GHpxRAkyswAC/Sl3rJt1zWJb4R2PMoWbRAkmdY/Y+drlF2ly5LOZJUTNUBsmLcuxrqW
         mpT6dh+u22RIfaFbD9EwKBUrlmr3qY1IToU0kkb2WNGPgWW8FDC1SVn/YM3ng7BxW3sD
         4C3s8cZkGh576Y/in9fNhxvOAOs/iMU68y7zYs5tYhf5Mhy7Ix8wC6PNDMG5RpFqX7x2
         6vI7TOpoUELahSfqnrrtwhJptps7t+pZZ3Pp8s3CfravEPOUa2oNbTGSUg1QDLU9DJfu
         dJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IblyOyTQli4avz4P0YzTwzWaLsUKVjYmFUh+H3l3Cxk=;
        b=Qd+iRK/1Eo6DBKUrZ4V3t6rY2nqempGFtozkTTfuVeiwv61fp5S/L9k+Mi/Ijvxd/5
         XLy+6tCwEsDL9TqLCPo1CiEIn4DY7cTbvvvurruih3zibvSLXQicD/ujM/op2vWjdbo5
         l0IuGzlUOG9Ge0ZjfjmeLDIOypNmPrDK2NZw3s8WzRCM7Paaw81F+y6SKP6/L7k+JBWp
         oaoAviHE/ZzXXm8tXr7+7kax8ptMoLVNpyRh7O26/XeXmpRnl52O+nppJp8gbmuy+qPW
         YI/BjCOgPB9iMSlo3wnQRj6a5EwznT+eFDYbQ06jdkFklX+0KrM1sh5jsUe4CQf2WJZF
         xxFw==
X-Gm-Message-State: AAQBX9fWurc6QTYqLzUxELR+XcLXgYf+uicNHEGLO84DzvDLkrnwLdAI
        JlGchcuqQ5VAceVLFbLL81udN55ItHQ=
X-Google-Smtp-Source: AKy350ZjO42h2Qoeccr2egCrfA9I9pOaH4PDrRHJiNJmsi2P94pFiASP+17z0JR1I3tAnhD5lbBcKQ==
X-Received: by 2002:a5d:54c5:0:b0:2cf:f06b:858a with SMTP id x5-20020a5d54c5000000b002cff06b858amr3954134wrv.17.1679712967099;
        Fri, 24 Mar 2023 19:56:07 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:06 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 10/43] selftests/bpf: verifier/bounds_mix_sign_unsign.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:51 +0200
Message-Id: <20230325025524.144043-11-eddyz87@gmail.com>
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

Test verifier/bounds_mix_sign_unsign.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/verifier_bounds_mix_sign_unsign.c   | 554 ++++++++++++++++++
 .../bpf/verifier/bounds_mix_sign_unsign.c     | 411 -------------
 3 files changed, 556 insertions(+), 411 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds_mix_sign_unsign.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index a8cfef92ed64..bbc39412fcd1 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -7,6 +7,7 @@
 #include "verifier_array_access.skel.h"
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bounds_deduction.skel.h"
+#include "verifier_bounds_mix_sign_unsign.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -36,3 +37,4 @@ void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_array_access(void)         { RUN(verifier_array_access); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
+void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_mix_sign_unsign.c b/tools/testing/selftests/bpf/progs/verifier_bounds_mix_sign_unsign.c
new file mode 100644
index 000000000000..91a66357896a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_mix_sign_unsign.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c */
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
+__description("bounds checks mixing signed and unsigned, positive bounds")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_positive_bounds(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = 2;						\
+	if r2 >= r1 goto l0_%=;				\
+	if r1 s> 4 goto l0_%=;				\
+	r0 += r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void checks_mixing_signed_and_unsigned(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -1;					\
+	if r1 > r2 goto l0_%=;				\
+	if r1 s> 1 goto l0_%=;				\
+	r0 += r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 2")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -1;					\
+	if r1 > r2 goto l0_%=;				\
+	r8 = 0;						\
+	r8 += r1;					\
+	if r8 s> 1 goto l0_%=;				\
+	r0 += r8;					\
+	r0 = 0;						\
+	*(u8*)(r8 + 0) = r0;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 3")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -1;					\
+	if r1 > r2 goto l0_%=;				\
+	r8 = r1;					\
+	if r8 s> 1 goto l0_%=;				\
+	r0 += r8;					\
+	r0 = 0;						\
+	*(u8*)(r8 + 0) = r0;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 4")
+__success __success_unpriv __retval(0)
+__naked void signed_and_unsigned_variant_4(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = 1;						\
+	r1 &= r2;					\
+	if r1 s> 1 goto l0_%=;				\
+	r0 += r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 5")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_5(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -1;					\
+	if r1 > r2 goto l0_%=;				\
+	if r1 s> 1 goto l0_%=;				\
+	r0 += 4;					\
+	r0 -= r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 6")
+__failure __msg("R4 min value is negative, either use unsigned")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_6(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = r9;					\
+	r2 = 0;						\
+	r3 = r10;					\
+	r3 += -512;					\
+	r4 = *(u64*)(r10 - 16);				\
+	r6 = -1;					\
+	if r4 > r6 goto l0_%=;				\
+	if r4 s> 1 goto l0_%=;				\
+	r4 += 1;					\
+	r5 = 0;						\
+	r6 = 0;						\
+	*(u16*)(r10 - 512) = r6;			\
+	call %[bpf_skb_load_bytes];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 7")
+__success __success_unpriv __retval(0)
+__naked void signed_and_unsigned_variant_7(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = %[__imm_0];				\
+	if r1 > r2 goto l0_%=;				\
+	if r1 s> 1 goto l0_%=;				\
+	r0 += r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__imm_0, 1024 * 1024 * 1024)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 8")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_8(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -1;					\
+	if r2 > r1 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	if r1 s> 1 goto l0_%=;				\
+	r0 += r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 9")
+__success __success_unpriv __retval(0)
+__naked void signed_and_unsigned_variant_9(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -9223372036854775808ULL ll;		\
+	if r2 > r1 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	if r1 s> 1 goto l0_%=;				\
+	r0 += r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 10")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_10(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = 0;						\
+	if r2 > r1 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	if r1 s> 1 goto l0_%=;				\
+	r0 += r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 11")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_11(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -1;					\
+	if r2 >= r1 goto l1_%=;				\
+	/* Dead branch. */				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	if r1 s> 1 goto l0_%=;				\
+	r0 += r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 12")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_12(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -6;					\
+	if r2 >= r1 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	if r1 s> 1 goto l0_%=;				\
+	r0 += r1;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 13")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_13(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = 2;						\
+	if r2 >= r1 goto l0_%=;				\
+	r7 = 1;						\
+	if r7 s> 0 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r7 += r1;					\
+	if r7 s> 4 goto l2_%=;				\
+	r0 += r7;					\
+	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 14")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_14(void)
+{
+	asm volatile ("					\
+	r9 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -1;					\
+	r8 = 2;						\
+	if r9 == 42 goto l1_%=;				\
+	if r8 s> r1 goto l2_%=;				\
+l3_%=:	if r1 s> 1 goto l2_%=;				\
+	r0 += r1;					\
+l0_%=:	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+l2_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	if r1 > r2 goto l2_%=;				\
+	goto l3_%=;					\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks mixing signed and unsigned, variant 15")
+__failure __msg("unbounded min value")
+__failure_unpriv
+__naked void signed_and_unsigned_variant_15(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64*)(r10 - 16) = r0;				\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r10 - 16);				\
+	r2 = -6;					\
+	if r2 >= r1 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 += r1;					\
+	if r0 > 1 goto l2_%=;				\
+	r0 = 0;						\
+	exit;						\
+l2_%=:	r1 = 0;						\
+	*(u8*)(r0 + 0) = r1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
deleted file mode 100644
index bf82b923c5fe..000000000000
--- a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
+++ /dev/null
@@ -1,411 +0,0 @@
-{
-	"bounds checks mixing signed and unsigned, positive bounds",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, 2),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 4, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 2",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
-	BPF_MOV64_IMM(BPF_REG_8, 0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_8, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
-	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 3",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 4),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_8, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
-	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 4",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, 1),
-	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.result = ACCEPT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 5",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 4),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 4),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 6",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -512),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_6, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_6, 5),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_4, 1, 4),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 1),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_ST_MEM(BPF_H, BPF_REG_10, -512, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R4 min value is negative, either use unsigned",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 7",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, 1024 * 1024 * 1024),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.result = ACCEPT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 8",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 9",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_LD_IMM64(BPF_REG_2, -9223372036854775808ULL),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.result = ACCEPT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 10",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 11",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
-	/* Dead branch. */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 12",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, -6),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 13",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, 2),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
-	BPF_MOV64_IMM(BPF_REG_7, 1),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_7, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_7, 4, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_7),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 14",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_1,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_MOV64_IMM(BPF_REG_8, 2),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 42, 6),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_8, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_1, 1, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, -3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -7),
-	},
-	.fixup_map_hash_8b = { 6 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-{
-	"bounds checks mixing signed and unsigned, variant 15",
-	.insns = {
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_MOV64_IMM(BPF_REG_2, -6),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_0, 1, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_ST_MEM(BPF_B, BPF_REG_0, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "unbounded min value",
-	.result = REJECT,
-},
-- 
2.40.0

