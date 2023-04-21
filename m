Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EDD6EB0DA
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjDURnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjDURnG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC5468F
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so1301540f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098968; x=1684690968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eXGugMjLsLhY2JDJ8sIzUsCeI5JgU7Ior6nMC8RFW0=;
        b=lQvLJ5n9ZyGt2EcEojWIsy6SL07bvuYf1HEpdegfAPCT+VOMP7qNmWM+F86dKCSMUL
         rbbTMYMIOINNi4NIBCOZzNHcG0BECEdO+Gb9OXQZrB8DN3d7+MEp/TFeHQGv1WH6HYZF
         ySZno7eUetqsEVJMD0mOkM5zbQ6zKmwvfO5xcUV4uZP+9jF+LjLRLOZcm6xNLEG037Ri
         VLgEHmt1mBv4ECGUB7P702ZTeP7LmyPLwAyZaZhlEDB1W4LsX4/iJJINeZlrXPbtBykz
         2mvbNiiaAvpVFBHo4agaQH+DS1MMBaTrQju6dnIjJbpunYEPNx5UFuls7PdpSRFw5wgE
         z+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098968; x=1684690968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eXGugMjLsLhY2JDJ8sIzUsCeI5JgU7Ior6nMC8RFW0=;
        b=OqurtPSBkVY+RlugMgM74t0FATOF9PZLk9Mbk4jUb2mb7/76y8UR/LK4zRp7gqq0u8
         nYYYTvqosu1f4dbW4X/nj2DHRuxXJPgyeUGyYfB1PHaWm5E+gFK9FwFLk+wZuGIO1bS2
         Zu3iAqyASsuE6fw2NAJD2xL4FrMXEi9/Hlv/1s7YWRhDqmgtZOtAvy3cRjaBc6O13wkM
         I1tHlbf0VMAjOCchFLklwUC1/l7vrlC6fbbrP8d9PiQRIzisgOb1p5lo/AQr+wQOYGVS
         91Rvqc1tuv1LnQfhruRniu4YV8t5cePxQyZrwVMi3V2CQoeNYNEQljC/361ff3Ai4p+s
         cRPQ==
X-Gm-Message-State: AAQBX9dYNwM7wfN2Ntrfy2E4IfnM0TPXTGENNhB6Ukou7zBd6AX4HAJ0
        sESW041c4FR6bP1yVw6PmcVUscbreJX90w==
X-Google-Smtp-Source: AKy350YaGmjZ0lS4I1igo6Vianzq1m8RgtLbWjw6bQWlMdFpefh2NrJul6+l7M+vAIpXSBM3pj8OOw==
X-Received: by 2002:adf:e590:0:b0:2fb:1f34:dc6d with SMTP id l16-20020adfe590000000b002fb1f34dc6dmr4026896wrm.64.1682098967079;
        Fri, 21 Apr 2023 10:42:47 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:46 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 02/24] selftests/bpf: verifier/bounds converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:12 +0300
Message-Id: <20230421174234.2391278-3-eddyz87@gmail.com>
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

Test verifier/bounds automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/verifier_bounds.c     | 1076 +++++++++++++++++
 tools/testing/selftests/bpf/verifier/bounds.c |  884 --------------
 3 files changed, 1078 insertions(+), 884 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/bounds.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 7c68d78da9ea..e61c9120e261 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -6,6 +6,7 @@
 #include "verifier_and.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_basic_stack.skel.h"
+#include "verifier_bounds.skel.h"
 #include "verifier_bounds_deduction.skel.h"
 #include "verifier_bounds_deduction_non_const.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
@@ -80,6 +81,7 @@ static void run_tests_aux(const char *skel_name,
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
+void test_verifier_bounds(void)               { RUN(verifier_bounds); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
new file mode 100644
index 000000000000..c5588a14fe2e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -0,0 +1,1076 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/bounds.c */
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
+__description("subtraction bounds (map value) variant 1")
+__failure __msg("R0 max value is outside of the allowed memory range")
+__failure_unpriv
+__naked void bounds_map_value_variant_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u8*)(r0 + 0);				\
+	if r1 > 0xff goto l0_%=;			\
+	r3 = *(u8*)(r0 + 1);				\
+	if r3 > 0xff goto l0_%=;			\
+	r1 -= r3;					\
+	r1 >>= 56;					\
+	r0 += r1;					\
+	r0 = *(u8*)(r0 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("subtraction bounds (map value) variant 2")
+__failure
+__msg("R0 min value is negative, either use unsigned index or do a if (index >=0) check.")
+__msg_unpriv("R1 has unknown scalar with mixed signed bounds")
+__naked void bounds_map_value_variant_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u8*)(r0 + 0);				\
+	if r1 > 0xff goto l0_%=;			\
+	r3 = *(u8*)(r0 + 1);				\
+	if r3 > 0xff goto l0_%=;			\
+	r1 -= r3;					\
+	r0 += r1;					\
+	r0 = *(u8*)(r0 + 0);				\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check subtraction on pointers for unpriv")
+__success __failure_unpriv __msg_unpriv("R9 pointer -= pointer prohibited")
+__retval(0)
+__naked void subtraction_on_pointers_for_unpriv(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r1 = %[map_hash_8b] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r6 = 9;						\
+	*(u64*)(r2 + 0) = r6;				\
+	call %[bpf_map_lookup_elem];			\
+	r9 = r10;					\
+	r9 -= r0;					\
+	r1 = %[map_hash_8b] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r6 = 0;						\
+	*(u64*)(r2 + 0) = r6;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	*(u64*)(r0 + 0) = r9;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check based on zero-extended MOV")
+__success __success_unpriv __retval(0)
+__naked void based_on_zero_extended_mov(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	/* r2 = 0x0000'0000'ffff'ffff */		\
+	w2 = 0xffffffff;				\
+	/* r2 = 0 */					\
+	r2 >>= 32;					\
+	/* no-op */					\
+	r0 += r2;					\
+	/* access at offset 0 */			\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	/* exit */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check based on sign-extended MOV. test1")
+__failure __msg("map_value pointer and 4294967295")
+__failure_unpriv
+__naked void on_sign_extended_mov_test1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	/* r2 = 0xffff'ffff'ffff'ffff */		\
+	r2 = 0xffffffff;				\
+	/* r2 = 0xffff'ffff */				\
+	r2 >>= 32;					\
+	/* r0 = <oob pointer> */			\
+	r0 += r2;					\
+	/* access to OOB pointer */			\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	/* exit */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check based on sign-extended MOV. test2")
+__failure __msg("R0 min value is outside of the allowed memory range")
+__failure_unpriv
+__naked void on_sign_extended_mov_test2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	/* r2 = 0xffff'ffff'ffff'ffff */		\
+	r2 = 0xffffffff;				\
+	/* r2 = 0xfff'ffff */				\
+	r2 >>= 36;					\
+	/* r0 = <oob pointer> */			\
+	r0 += r2;					\
+	/* access to OOB pointer */			\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	/* exit */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("bounds check based on reg_off + var_off + insn_off. test1")
+__failure __msg("value_size=8 off=1073741825")
+__naked void var_off_insn_off_test1(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r6 &= 1;					\
+	r6 += %[__imm_0];				\
+	r0 += r6;					\
+	r0 += %[__imm_0];				\
+l0_%=:	r0 = *(u8*)(r0 + 3);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__imm_0, (1 << 29) - 1),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("bounds check based on reg_off + var_off + insn_off. test2")
+__failure __msg("value 1073741823")
+__naked void var_off_insn_off_test2(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r6 &= 1;					\
+	r6 += %[__imm_0];				\
+	r0 += r6;					\
+	r0 += %[__imm_1];				\
+l0_%=:	r0 = *(u8*)(r0 + 3);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__imm_0, (1 << 30) - 1),
+	  __imm_const(__imm_1, (1 << 29) - 1),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check after truncation of non-boundary-crossing range")
+__success __success_unpriv __retval(0)
+__naked void of_non_boundary_crossing_range(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	/* r1 = [0x00, 0xff] */				\
+	r1 = *(u8*)(r0 + 0);				\
+	r2 = 1;						\
+	/* r2 = 0x10'0000'0000 */			\
+	r2 <<= 36;					\
+	/* r1 = [0x10'0000'0000, 0x10'0000'00ff] */	\
+	r1 += r2;					\
+	/* r1 = [0x10'7fff'ffff, 0x10'8000'00fe] */	\
+	r1 += 0x7fffffff;				\
+	/* r1 = [0x00, 0xff] */				\
+	w1 -= 0x7fffffff;				\
+	/* r1 = 0 */					\
+	r1 >>= 8;					\
+	/* no-op */					\
+	r0 += r1;					\
+	/* access at offset 0 */			\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	/* exit */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check after truncation of boundary-crossing range (1)")
+__failure
+/* not actually fully unbounded, but the bound is very high */
+__msg("value -4294967168 makes map_value pointer be out of bounds")
+__failure_unpriv
+__naked void of_boundary_crossing_range_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	/* r1 = [0x00, 0xff] */				\
+	r1 = *(u8*)(r0 + 0);				\
+	r1 += %[__imm_0];				\
+	/* r1 = [0xffff'ff80, 0x1'0000'007f] */		\
+	r1 += %[__imm_0];				\
+	/* r1 = [0xffff'ff80, 0xffff'ffff] or		\
+	 *      [0x0000'0000, 0x0000'007f]		\
+	 */						\
+	w1 += 0;					\
+	r1 -= %[__imm_0];				\
+	/* r1 = [0x00, 0xff] or				\
+	 *      [0xffff'ffff'0000'0080, 0xffff'ffff'ffff'ffff]\
+	 */						\
+	r1 -= %[__imm_0];				\
+	/* error on OOB pointer computation */		\
+	r0 += r1;					\
+	/* exit */					\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__imm_0, 0xffffff80 >> 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check after truncation of boundary-crossing range (2)")
+__failure __msg("value -4294967168 makes map_value pointer be out of bounds")
+__failure_unpriv
+__naked void of_boundary_crossing_range_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	/* r1 = [0x00, 0xff] */				\
+	r1 = *(u8*)(r0 + 0);				\
+	r1 += %[__imm_0];				\
+	/* r1 = [0xffff'ff80, 0x1'0000'007f] */		\
+	r1 += %[__imm_0];				\
+	/* r1 = [0xffff'ff80, 0xffff'ffff] or		\
+	 *      [0x0000'0000, 0x0000'007f]		\
+	 * difference to previous test: truncation via MOV32\
+	 * instead of ALU32.				\
+	 */						\
+	w1 = w1;					\
+	r1 -= %[__imm_0];				\
+	/* r1 = [0x00, 0xff] or				\
+	 *      [0xffff'ffff'0000'0080, 0xffff'ffff'ffff'ffff]\
+	 */						\
+	r1 -= %[__imm_0];				\
+	/* error on OOB pointer computation */		\
+	r0 += r1;					\
+	/* exit */					\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__imm_0, 0xffffff80 >> 1)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check after wrapping 32-bit addition")
+__success __success_unpriv __retval(0)
+__naked void after_wrapping_32_bit_addition(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	/* r1 = 0x7fff'ffff */				\
+	r1 = 0x7fffffff;				\
+	/* r1 = 0xffff'fffe */				\
+	r1 += 0x7fffffff;				\
+	/* r1 = 0 */					\
+	w1 += 2;					\
+	/* no-op */					\
+	r0 += r1;					\
+	/* access at offset 0 */			\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	/* exit */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check after shift with oversized count operand")
+__failure __msg("R0 max value is outside of the allowed memory range")
+__failure_unpriv
+__naked void shift_with_oversized_count_operand(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = 32;					\
+	r1 = 1;						\
+	/* r1 = (u32)1 << (u32)32 = ? */		\
+	w1 <<= w2;					\
+	/* r1 = [0x0000, 0xffff] */			\
+	r1 &= 0xffff;					\
+	/* computes unknown pointer, potentially OOB */	\
+	r0 += r1;					\
+	/* potentially OOB access */			\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	/* exit */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check after right shift of maybe-negative number")
+__failure __msg("R0 unbounded memory access")
+__failure_unpriv
+__naked void shift_of_maybe_negative_number(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	/* r1 = [0x00, 0xff] */				\
+	r1 = *(u8*)(r0 + 0);				\
+	/* r1 = [-0x01, 0xfe] */			\
+	r1 -= 1;					\
+	/* r1 = 0 or 0xff'ffff'ffff'ffff */		\
+	r1 >>= 8;					\
+	/* r1 = 0 or 0xffff'ffff'ffff */		\
+	r1 >>= 8;					\
+	/* computes unknown pointer, potentially OOB */	\
+	r0 += r1;					\
+	/* potentially OOB access */			\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	/* exit */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check after 32-bit right shift with 64-bit input")
+__failure __msg("math between map_value pointer and 4294967294 is not allowed")
+__failure_unpriv
+__naked void shift_with_64_bit_input(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 2;						\
+	/* r1 = 1<<32 */				\
+	r1 <<= 31;					\
+	/* r1 = 0 (NOT 2!) */				\
+	w1 >>= 31;					\
+	/* r1 = 0xffff'fffe (NOT 0!) */			\
+	w1 -= 2;					\
+	/* error on computing OOB pointer */		\
+	r0 += r1;					\
+	/* exit */					\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check map access with off+size signed 32bit overflow. test1")
+__failure __msg("map_value pointer and 2147483646")
+__failure_unpriv
+__naked void size_signed_32bit_overflow_test1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r0 += 0x7ffffffe;				\
+	r0 = *(u64*)(r0 + 0);				\
+	goto l1_%=;					\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check map access with off+size signed 32bit overflow. test2")
+__failure __msg("pointer offset 1073741822")
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__naked void size_signed_32bit_overflow_test2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r0 += 0x1fffffff;				\
+	r0 += 0x1fffffff;				\
+	r0 += 0x1fffffff;				\
+	r0 = *(u64*)(r0 + 0);				\
+	goto l1_%=;					\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check map access with off+size signed 32bit overflow. test3")
+__failure __msg("pointer offset -1073741822")
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__naked void size_signed_32bit_overflow_test3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r0 -= 0x1fffffff;				\
+	r0 -= 0x1fffffff;				\
+	r0 = *(u64*)(r0 + 2);				\
+	goto l1_%=;					\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check map access with off+size signed 32bit overflow. test4")
+__failure __msg("map_value pointer and 1000000000000")
+__failure_unpriv
+__naked void size_signed_32bit_overflow_test4(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = 1000000;					\
+	r1 *= 1000000;					\
+	r0 += r1;					\
+	r0 = *(u64*)(r0 + 2);				\
+	goto l1_%=;					\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check mixed 32bit and 64bit arithmetic. test1")
+__success __failure_unpriv __msg_unpriv("R0 invalid mem access 'scalar'")
+__retval(0)
+__naked void _32bit_and_64bit_arithmetic_test1(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r1 = -1;					\
+	r1 <<= 32;					\
+	r1 += 1;					\
+	/* r1 = 0xffffFFFF00000001 */			\
+	if w1 > 1 goto l0_%=;				\
+	/* check ALU64 op keeps 32bit bounds */		\
+	r1 += 1;					\
+	if w1 > 2 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	/* invalid ldx if bounds are lost above */	\
+	r0 = *(u64*)(r0 - 1);				\
+l1_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check mixed 32bit and 64bit arithmetic. test2")
+__success __failure_unpriv __msg_unpriv("R0 invalid mem access 'scalar'")
+__retval(0)
+__naked void _32bit_and_64bit_arithmetic_test2(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r1 = -1;					\
+	r1 <<= 32;					\
+	r1 += 1;					\
+	/* r1 = 0xffffFFFF00000001 */			\
+	r2 = 3;						\
+	/* r1 = 0x2 */					\
+	w1 += 1;					\
+	/* check ALU32 op zero extends 64bit bounds */	\
+	if r1 > r2 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	/* invalid ldx if bounds are lost above */	\
+	r0 = *(u64*)(r0 - 1);				\
+l1_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("assigning 32bit bounds to 64bit for wA = 0, wB = wA")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void for_wa_0_wb_wa(void)
+{
+	asm volatile ("					\
+	r8 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r7 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	w9 = 0;						\
+	w2 = w9;					\
+	r6 = r7;					\
+	r6 += r2;					\
+	r3 = r6;					\
+	r3 += 8;					\
+	if r3 > r8 goto l0_%=;				\
+	r5 = *(u32*)(r6 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg = 0, reg xor 1")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg_0_reg_xor_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = 0;						\
+	r1 ^= 1;					\
+	if r1 != 0 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg32 = 0, reg32 xor 1")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg32_0_reg32_xor_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	w1 = 0;						\
+	w1 ^= 1;					\
+	if w1 != 0 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg = 2, reg xor 3")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg_2_reg_xor_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = 2;						\
+	r1 ^= 3;					\
+	if r1 > 0 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg = any, reg xor 3")
+__failure __msg("invalid access to map value")
+__msg_unpriv("invalid access to map value")
+__naked void reg_any_reg_xor_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = *(u64*)(r0 + 0);				\
+	r1 ^= 3;					\
+	if r1 != 0 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg32 = any, reg32 xor 3")
+__failure __msg("invalid access to map value")
+__msg_unpriv("invalid access to map value")
+__naked void reg32_any_reg32_xor_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = *(u64*)(r0 + 0);				\
+	w1 ^= 3;					\
+	if w1 != 0 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg > 0, reg xor 3")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg_0_reg_xor_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = *(u64*)(r0 + 0);				\
+	if r1 <= 0 goto l1_%=;				\
+	r1 ^= 3;					\
+	if r1 >= 0 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg32 > 0, reg32 xor 3")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg32_0_reg32_xor_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = *(u64*)(r0 + 0);				\
+	if w1 <= 0 goto l1_%=;				\
+	w1 ^= 3;					\
+	if w1 >= 0 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks after 32-bit truncation. test 1")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0)
+__naked void _32_bit_truncation_test_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	/* This used to reduce the max bound to 0x7fffffff */\
+	if r1 == 0 goto l1_%=;				\
+	if r1 > 0x7fffffff goto l0_%=;			\
+l1_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds checks after 32-bit truncation. test 2")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0)
+__naked void _32_bit_truncation_test_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	if r1 s< 1 goto l1_%=;				\
+	if w1 s< 0 goto l0_%=;				\
+l1_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("bound check with JMP_JLT for crossing 64-bit signed boundary")
+__success __retval(0)
+__naked void crossing_64_bit_signed_boundary_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 1;					\
+	if r1 > r3 goto l0_%=;				\
+	r1 = *(u8*)(r2 + 0);				\
+	r0 = 0x7fffffffffffff10 ll;			\
+	r1 += r0;					\
+	r0 = 0x8000000000000000 ll;			\
+l1_%=:	r0 += 1;					\
+	/* r1 unsigned range is [0x7fffffffffffff10, 0x800000000000000f] */\
+	if r0 < r1 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("bound check with JMP_JSLT for crossing 64-bit signed boundary")
+__success __retval(0)
+__naked void crossing_64_bit_signed_boundary_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 1;					\
+	if r1 > r3 goto l0_%=;				\
+	r1 = *(u8*)(r2 + 0);				\
+	r0 = 0x7fffffffffffff10 ll;			\
+	r1 += r0;					\
+	r2 = 0x8000000000000fff ll;			\
+	r0 = 0x8000000000000000 ll;			\
+l1_%=:	r0 += 1;					\
+	if r0 s> r2 goto l0_%=;				\
+	/* r1 signed range is [S64_MIN, S64_MAX] */	\
+	if r0 s< r1 goto l1_%=;				\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("bound check for loop upper bound greater than U32_MAX")
+__success __retval(0)
+__naked void bound_greater_than_u32_max(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 1;					\
+	if r1 > r3 goto l0_%=;				\
+	r1 = *(u8*)(r2 + 0);				\
+	r0 = 0x100000000 ll;				\
+	r1 += r0;					\
+	r0 = 0x100000000 ll;				\
+l1_%=:	r0 += 1;					\
+	if r0 < r1 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("bound check with JMP32_JLT for crossing 32-bit signed boundary")
+__success __retval(0)
+__naked void crossing_32_bit_signed_boundary_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 1;					\
+	if r1 > r3 goto l0_%=;				\
+	r1 = *(u8*)(r2 + 0);				\
+	w0 = 0x7fffff10;				\
+	w1 += w0;					\
+	w0 = 0x80000000;				\
+l1_%=:	w0 += 1;					\
+	/* r1 unsigned range is [0, 0x8000000f] */	\
+	if w0 < w1 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("bound check with JMP32_JSLT for crossing 32-bit signed boundary")
+__success __retval(0)
+__naked void crossing_32_bit_signed_boundary_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 1;					\
+	if r1 > r3 goto l0_%=;				\
+	r1 = *(u8*)(r2 + 0);				\
+	w0 = 0x7fffff10;				\
+	w1 += w0;					\
+	w2 = 0x80000fff;				\
+	w0 = 0x80000000;				\
+l1_%=:	w0 += 1;					\
+	if w0 s> w2 goto l0_%=;				\
+	/* r1 signed range is [S32_MIN, S32_MAX] */	\
+	if w0 s< w1 goto l1_%=;				\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
deleted file mode 100644
index 43942ce8cf15..000000000000
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ /dev/null
@@ -1,884 +0,0 @@
-{
-	"subtraction bounds (map value) variant 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0xff, 7),
-	BPF_LDX_MEM(BPF_B, BPF_REG_3, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, 0xff, 5),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 56),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "R0 max value is outside of the allowed memory range",
-	.result = REJECT,
-},
-{
-	"subtraction bounds (map value) variant 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0xff, 6),
-	BPF_LDX_MEM(BPF_B, BPF_REG_3, BPF_REG_0, 1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, 0xff, 4),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "R0 min value is negative, either use unsigned index or do a if (index >=0) check.",
-	.errstr_unpriv = "R1 has unknown scalar with mixed signed bounds",
-	.result = REJECT,
-},
-{
-	"check subtraction on pointers for unpriv",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
-	BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_ARG2, 0, 9),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_FP),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
-	BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_ARG2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_9, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 1, 9 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R9 pointer -= pointer prohibited",
-},
-{
-	"bounds check based on zero-extended MOV",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	/* r2 = 0x0000'0000'ffff'ffff */
-	BPF_MOV32_IMM(BPF_REG_2, 0xffffffff),
-	/* r2 = 0 */
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 32),
-	/* no-op */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	/* access at offset 0 */
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT
-},
-{
-	"bounds check based on sign-extended MOV. test1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	/* r2 = 0xffff'ffff'ffff'ffff */
-	BPF_MOV64_IMM(BPF_REG_2, 0xffffffff),
-	/* r2 = 0xffff'ffff */
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 32),
-	/* r0 = <oob pointer> */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	/* access to OOB pointer */
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "map_value pointer and 4294967295",
-	.result = REJECT
-},
-{
-	"bounds check based on sign-extended MOV. test2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	/* r2 = 0xffff'ffff'ffff'ffff */
-	BPF_MOV64_IMM(BPF_REG_2, 0xffffffff),
-	/* r2 = 0xfff'ffff */
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 36),
-	/* r0 = <oob pointer> */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	/* access to OOB pointer */
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "R0 min value is outside of the allowed memory range",
-	.result = REJECT
-},
-{
-	"bounds check based on reg_off + var_off + insn_off. test1",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_6, 1),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, (1 << 29) - 1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, (1 << 29) - 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 3),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.errstr = "value_size=8 off=1073741825",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"bounds check based on reg_off + var_off + insn_off. test2",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_6, 1),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, (1 << 30) - 1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, (1 << 29) - 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 3),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 4 },
-	.errstr = "value 1073741823",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"bounds check after truncation of non-boundary-crossing range",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	/* r1 = [0x00, 0xff] */
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 1),
-	/* r2 = 0x10'0000'0000 */
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 36),
-	/* r1 = [0x10'0000'0000, 0x10'0000'00ff] */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
-	/* r1 = [0x10'7fff'ffff, 0x10'8000'00fe] */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0x7fffffff),
-	/* r1 = [0x00, 0xff] */
-	BPF_ALU32_IMM(BPF_SUB, BPF_REG_1, 0x7fffffff),
-	/* r1 = 0 */
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 8),
-	/* no-op */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	/* access at offset 0 */
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT
-},
-{
-	"bounds check after truncation of boundary-crossing range (1)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	/* r1 = [0x00, 0xff] */
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xffffff80 >> 1),
-	/* r1 = [0xffff'ff80, 0x1'0000'007f] */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xffffff80 >> 1),
-	/* r1 = [0xffff'ff80, 0xffff'ffff] or
-	 *      [0x0000'0000, 0x0000'007f]
-	 */
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 0xffffff80 >> 1),
-	/* r1 = [0x00, 0xff] or
-	 *      [0xffff'ffff'0000'0080, 0xffff'ffff'ffff'ffff]
-	 */
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 0xffffff80 >> 1),
-	/* error on OOB pointer computation */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	/* not actually fully unbounded, but the bound is very high */
-	.errstr = "value -4294967168 makes map_value pointer be out of bounds",
-	.result = REJECT,
-},
-{
-	"bounds check after truncation of boundary-crossing range (2)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	/* r1 = [0x00, 0xff] */
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xffffff80 >> 1),
-	/* r1 = [0xffff'ff80, 0x1'0000'007f] */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xffffff80 >> 1),
-	/* r1 = [0xffff'ff80, 0xffff'ffff] or
-	 *      [0x0000'0000, 0x0000'007f]
-	 * difference to previous test: truncation via MOV32
-	 * instead of ALU32.
-	 */
-	BPF_MOV32_REG(BPF_REG_1, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 0xffffff80 >> 1),
-	/* r1 = [0x00, 0xff] or
-	 *      [0xffff'ffff'0000'0080, 0xffff'ffff'ffff'ffff]
-	 */
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 0xffffff80 >> 1),
-	/* error on OOB pointer computation */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "value -4294967168 makes map_value pointer be out of bounds",
-	.result = REJECT,
-},
-{
-	"bounds check after wrapping 32-bit addition",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	/* r1 = 0x7fff'ffff */
-	BPF_MOV64_IMM(BPF_REG_1, 0x7fffffff),
-	/* r1 = 0xffff'fffe */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0x7fffffff),
-	/* r1 = 0 */
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_1, 2),
-	/* no-op */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	/* access at offset 0 */
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT
-},
-{
-	"bounds check after shift with oversized count operand",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_IMM(BPF_REG_2, 32),
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	/* r1 = (u32)1 << (u32)32 = ? */
-	BPF_ALU32_REG(BPF_LSH, BPF_REG_1, BPF_REG_2),
-	/* r1 = [0x0000, 0xffff] */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xffff),
-	/* computes unknown pointer, potentially OOB */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	/* potentially OOB access */
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "R0 max value is outside of the allowed memory range",
-	.result = REJECT
-},
-{
-	"bounds check after right shift of maybe-negative number",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	/* r1 = [0x00, 0xff] */
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	/* r1 = [-0x01, 0xfe] */
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
-	/* r1 = 0 or 0xff'ffff'ffff'ffff */
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 8),
-	/* r1 = 0 or 0xffff'ffff'ffff */
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 8),
-	/* computes unknown pointer, potentially OOB */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	/* potentially OOB access */
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "R0 unbounded memory access",
-	.result = REJECT
-},
-{
-	"bounds check after 32-bit right shift with 64-bit input",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	/* r1 = 2 */
-	BPF_MOV64_IMM(BPF_REG_1, 2),
-	/* r1 = 1<<32 */
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 31),
-	/* r1 = 0 (NOT 2!) */
-	BPF_ALU32_IMM(BPF_RSH, BPF_REG_1, 31),
-	/* r1 = 0xffff'fffe (NOT 0!) */
-	BPF_ALU32_IMM(BPF_SUB, BPF_REG_1, 2),
-	/* error on computing OOB pointer */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	/* exit */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "math between map_value pointer and 4294967294 is not allowed",
-	.result = REJECT,
-},
-{
-	"bounds check map access with off+size signed 32bit overflow. test1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x7ffffffe),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_JMP_A(0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "map_value pointer and 2147483646",
-	.result = REJECT
-},
-{
-	"bounds check map access with off+size signed 32bit overflow. test2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x1fffffff),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x1fffffff),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x1fffffff),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_JMP_A(0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "pointer offset 1073741822",
-	.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
-	.result = REJECT
-},
-{
-	"bounds check map access with off+size signed 32bit overflow. test3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 0x1fffffff),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 0x1fffffff),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 2),
-	BPF_JMP_A(0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "pointer offset -1073741822",
-	.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
-	.result = REJECT
-},
-{
-	"bounds check map access with off+size signed 32bit overflow. test4",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_1, 1000000),
-	BPF_ALU64_IMM(BPF_MUL, BPF_REG_1, 1000000),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 2),
-	BPF_JMP_A(0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr = "map_value pointer and 1000000000000",
-	.result = REJECT
-},
-{
-	"bounds check mixed 32bit and 64bit arithmetic. test1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_1, -1),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	/* r1 = 0xffffFFFF00000001 */
-	BPF_JMP32_IMM(BPF_JGT, BPF_REG_1, 1, 3),
-	/* check ALU64 op keeps 32bit bounds */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP32_IMM(BPF_JGT, BPF_REG_1, 2, 1),
-	BPF_JMP_A(1),
-	/* invalid ldx if bounds are lost above */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, -1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
-	.result = ACCEPT
-},
-{
-	"bounds check mixed 32bit and 64bit arithmetic. test2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_1, -1),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	/* r1 = 0xffffFFFF00000001 */
-	BPF_MOV64_IMM(BPF_REG_2, 3),
-	/* r1 = 0x2 */
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_1, 1),
-	/* check ALU32 op zero extends 64bit bounds */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 1),
-	BPF_JMP_A(1),
-	/* invalid ldx if bounds are lost above */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, -1),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
-	.result = ACCEPT
-},
-{
-	"assigning 32bit bounds to 64bit for wA = 0, wB = wA",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_MOV32_IMM(BPF_REG_9, 0),
-	BPF_MOV32_REG(BPF_REG_2, BPF_REG_9),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_8, 1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_6, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"bounds check for reg = 0, reg xor 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R0 min value is outside of the allowed memory range",
-	.result_unpriv = REJECT,
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-},
-{
-	"bounds check for reg32 = 0, reg32 xor 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV32_IMM(BPF_REG_1, 0),
-	BPF_ALU32_IMM(BPF_XOR, BPF_REG_1, 1),
-	BPF_JMP32_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R0 min value is outside of the allowed memory range",
-	.result_unpriv = REJECT,
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-},
-{
-	"bounds check for reg = 2, reg xor 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_1, 2),
-	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0, 1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R0 min value is outside of the allowed memory range",
-	.result_unpriv = REJECT,
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-},
-{
-	"bounds check for reg = any, reg xor 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = REJECT,
-	.errstr = "invalid access to map value",
-	.errstr_unpriv = "invalid access to map value",
-},
-{
-	"bounds check for reg32 = any, reg32 xor 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU32_IMM(BPF_XOR, BPF_REG_1, 3),
-	BPF_JMP32_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = REJECT,
-	.errstr = "invalid access to map value",
-	.errstr_unpriv = "invalid access to map value",
-},
-{
-	"bounds check for reg > 0, reg xor 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_1, 0, 3),
-	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R0 min value is outside of the allowed memory range",
-	.result_unpriv = REJECT,
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-},
-{
-	"bounds check for reg32 > 0, reg32 xor 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP32_IMM(BPF_JLE, BPF_REG_1, 0, 3),
-	BPF_ALU32_IMM(BPF_XOR, BPF_REG_1, 3),
-	BPF_JMP32_IMM(BPF_JGE, BPF_REG_1, 0, 1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R0 min value is outside of the allowed memory range",
-	.result_unpriv = REJECT,
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-},
-{
-	"bounds checks after 32-bit truncation. test 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	/* This used to reduce the max bound to 0x7fffffff */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0x7fffffff, 1),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"bounds checks after 32-bit truncation. test 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_1, 1, 1),
-	BPF_JMP32_IMM(BPF_JSLT, BPF_REG_1, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"bound check with JMP_JLT for crossing 64-bit signed boundary",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
-
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
-	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-
-	BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	/* r1 unsigned range is [0x7fffffffffffff10, 0x800000000000000f] */
-	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
-
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"bound check with JMP_JSLT for crossing 64-bit signed boundary",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 13),
-
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
-	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-
-	BPF_LD_IMM64(BPF_REG_2, 0x8000000000000fff),
-	BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_0, BPF_REG_2, 3),
-	/* r1 signed range is [S64_MIN, S64_MAX] */
-	BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -3),
-
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"bound check for loop upper bound greater than U32_MAX",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
-
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
-	BPF_LD_IMM64(BPF_REG_0, 0x100000000),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-
-	BPF_LD_IMM64(BPF_REG_0, 0x100000000),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
-
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"bound check with JMP32_JLT for crossing 32-bit signed boundary",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
-
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
-	BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
-	BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-
-	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
-	/* r1 unsigned range is [0, 0x8000000f] */
-	BPF_JMP32_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
-
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"bound check with JMP32_JSLT for crossing 32-bit signed boundary",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 10),
-
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
-	BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
-	BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-
-	BPF_MOV32_IMM(BPF_REG_2, 0x80000fff),
-	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP32_REG(BPF_JSGT, BPF_REG_0, BPF_REG_2, 3),
-	/* r1 signed range is [S32_MIN, S32_MAX] */
-	BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -3),
-
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-- 
2.40.0

