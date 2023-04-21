Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6C76EB0DD
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjDURn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjDURnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DF3E55
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3023a56048bso1532382f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098974; x=1684690974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86+vKaa0Y/wDRSeqvnAcwiFf5Ld26MElEI3W8iSZvGM=;
        b=Hk+rGLUMh4oDPxJyu6DNYBN0vCBWm+ejZrODxbkQamRB601K208QnrY3PyjzBjjTng
         XAs6n3EUhnXDdLLdW0qixXcZTnqlSEECmiAZ5dOgPhVdaTHT82hMu83v47A76y6vSbbZ
         OD2tkaGoUGcMC8RwQtPoNvP+0wK8FBJxKxa/326Uts+RtRP/8DPKQK8BvMx4u4l2ft9c
         RqMjJXlFeNt7CucNU8Iu/mEboGay5UA5I+tt1Bmp7ZiSWTJvm7a3fZuOnTt5V+VveVB5
         21fGossS5fzAQMpklD/Sk/vtq6bUCLW0t4f3jRJm9h7zPYIyMiHIUsltCbLY282+5rUE
         DQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098974; x=1684690974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86+vKaa0Y/wDRSeqvnAcwiFf5Ld26MElEI3W8iSZvGM=;
        b=D2dV5+JDl07ZDt7mh8Gt0xGu0jj27S4UEpeHi0oYkK20lygGAoDjbJQkj3YkrTEG5U
         DDxmR//HJ4w58PceSH8kZhdZG4B38e0uDOH6GdzlLVx+6j3EkdiP184Qz269XlWW6all
         JX17omLtx3N04PT3UPgLNfctHXgxaourz2vBbSwNq03vDCJjVcVU33qgRsfGG7w8P6l5
         piSRaDx4paCtbJVc28nc2i0MDJkt5ELTDkVEJQoUOjdEPqt9w+555OerWExw/WLNbE1W
         B4vl2C4W3JvOfmJYZLaymQjW9EjK0DhLlZ5sKcWszGb56i8z+MUsrwwJnAuLEUM3lesq
         nuRA==
X-Gm-Message-State: AAQBX9dc5hqfuZQ1ZnQgCMajWt2JyZyo123Ow3K561mHZA6m+wt4VsTi
        tA1/eHulITpyXfyzTc//uUOc7MnemDUDvA==
X-Google-Smtp-Source: AKy350YBcyRQwyW5j4rJSn3zRgzwUR7zZ9Cd7lgYscLta/w1VuuiI3j4IoXUTXg6Kj/a1tTjddWYbQ==
X-Received: by 2002:a05:6000:10c8:b0:2f5:b1aa:679c with SMTP id b8-20020a05600010c800b002f5b1aa679cmr4401299wrx.39.1682098973676;
        Fri, 21 Apr 2023 10:42:53 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:53 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 07/24] selftests/bpf: verifier/direct_packet_access converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:17 +0300
Message-Id: <20230421174234.2391278-8-eddyz87@gmail.com>
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

Test verifier/direct_packet_access automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_direct_packet_access.c | 803 ++++++++++++++++++
 .../bpf/verifier/direct_packet_access.c       | 710 ----------------
 3 files changed, 805 insertions(+), 710 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/direct_packet_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index ae4da5f7598c..2c9e61b9a83e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -20,6 +20,7 @@
 #include "verifier_ctx.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_d_path.skel.h"
+#include "verifier_direct_packet_access.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
 #include "verifier_div_overflow.skel.h"
@@ -99,6 +100,7 @@ void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_d_path(void)               { RUN(verifier_d_path); }
+void test_verifier_direct_packet_access(void) { RUN(verifier_direct_packet_access); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
new file mode 100644
index 000000000000..99a23dea8233
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -0,0 +1,803 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/direct_packet_access.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tc")
+__description("pkt_end - pkt_start is allowed")
+__success __retval(TEST_DATA_LEN)
+__naked void end_pkt_start_is_allowed(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r0 -= r2;					\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test1")
+__success __retval(0)
+__naked void direct_packet_access_test1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test2")
+__success __retval(0)
+__naked void direct_packet_access_test2(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	r4 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r3 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r5 = r3;					\
+	r5 += 14;					\
+	if r5 > r4 goto l0_%=;				\
+	r0 = *(u8*)(r3 + 7);				\
+	r4 = *(u8*)(r3 + 12);				\
+	r4 *= 14;					\
+	r3 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 += r4;					\
+	r2 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r2 <<= 49;					\
+	r2 >>= 49;					\
+	r3 += r2;					\
+	r2 = r3;					\
+	r2 += 8;					\
+	r1 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	if r2 > r1 goto l1_%=;				\
+	r1 = *(u8*)(r3 + 4);				\
+l1_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("direct packet access: test3")
+__failure __msg("invalid bpf_context access off=76")
+__failure_unpriv
+__naked void direct_packet_access_test3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test4 (write)")
+__success __retval(0)
+__naked void direct_packet_access_test4_write(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	*(u8*)(r2 + 0) = r2;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test5 (pkt_end >= reg, good access)")
+__success __retval(0)
+__naked void pkt_end_reg_good_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r3 >= r0 goto l0_%=;				\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = *(u8*)(r2 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test6 (pkt_end >= reg, bad access)")
+__failure __msg("invalid access to packet")
+__naked void pkt_end_reg_bad_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r3 >= r0 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test7 (pkt_end >= reg, both accesses)")
+__failure __msg("invalid access to packet")
+__naked void pkt_end_reg_both_accesses(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r3 >= r0 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = *(u8*)(r2 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test8 (double test, variant 1)")
+__success __retval(0)
+__naked void test8_double_test_variant_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r3 >= r0 goto l0_%=;				\
+	if r0 > r3 goto l1_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l1_%=:	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = *(u8*)(r2 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test9 (double test, variant 2)")
+__success __retval(0)
+__naked void test9_double_test_variant_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r3 >= r0 goto l0_%=;				\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	if r0 > r3 goto l1_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l1_%=:	r0 = *(u8*)(r2 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test10 (write invalid)")
+__failure __msg("invalid access to packet")
+__naked void packet_access_test10_write_invalid(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	*(u8*)(r2 + 0) = r2;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test11 (shift, good access)")
+__success __retval(1)
+__naked void access_test11_shift_good_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 22;					\
+	if r0 > r3 goto l0_%=;				\
+	r3 = 144;					\
+	r5 = r3;					\
+	r5 += 23;					\
+	r5 >>= 3;					\
+	r6 = r2;					\
+	r6 += r5;					\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test12 (and, good access)")
+__success __retval(1)
+__naked void access_test12_and_good_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 22;					\
+	if r0 > r3 goto l0_%=;				\
+	r3 = 144;					\
+	r5 = r3;					\
+	r5 += 23;					\
+	r5 &= 15;					\
+	r6 = r2;					\
+	r6 += r5;					\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test13 (branches, good access)")
+__success __retval(1)
+__naked void access_test13_branches_good_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 22;					\
+	if r0 > r3 goto l0_%=;				\
+	r3 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r4 = 1;						\
+	if r3 > r4 goto l1_%=;				\
+	r3 = 14;					\
+	goto l2_%=;					\
+l1_%=:	r3 = 24;					\
+l2_%=:	r5 = r3;					\
+	r5 += 23;					\
+	r5 &= 15;					\
+	r6 = r2;					\
+	r6 += r5;					\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test14 (pkt_ptr += 0, CONST_IMM, good access)")
+__success __retval(1)
+__naked void _0_const_imm_good_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 22;					\
+	if r0 > r3 goto l0_%=;				\
+	r5 = 12;					\
+	r5 >>= 4;					\
+	r6 = r2;					\
+	r6 += r5;					\
+	r0 = *(u8*)(r6 + 0);				\
+	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test15 (spill with xadd)")
+__failure __msg("R2 invalid mem access 'scalar'")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void access_test15_spill_with_xadd(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r5 = 4096;					\
+	r4 = r10;					\
+	r4 += -8;					\
+	*(u64*)(r4 + 0) = r2;				\
+	lock *(u64 *)(r4 + 0) += r5;			\
+	r2 = *(u64*)(r4 + 0);				\
+	*(u32*)(r2 + 0) = r5;				\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test16 (arith on data_end)")
+__failure __msg("R3 pointer arithmetic on pkt_end")
+__naked void test16_arith_on_data_end(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	r3 += 16;					\
+	if r0 > r3 goto l0_%=;				\
+	*(u8*)(r2 + 0) = r2;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test17 (pruning, alignment)")
+__failure __msg("misaligned packet access off 2+(0x0; 0x0)+15+-4 size 4")
+__flag(BPF_F_STRICT_ALIGNMENT)
+__naked void packet_access_test17_pruning_alignment(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r7 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	r0 = r2;					\
+	r0 += 14;					\
+	if r7 > 1 goto l0_%=;				\
+l2_%=:	if r0 > r3 goto l1_%=;				\
+	*(u32*)(r0 - 4) = r0;				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 += 1;					\
+	goto l2_%=;					\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test18 (imm += pkt_ptr, 1)")
+__success __retval(0)
+__naked void test18_imm_pkt_ptr_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = 8;						\
+	r0 += r2;					\
+	if r0 > r3 goto l0_%=;				\
+	*(u8*)(r2 + 0) = r2;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test19 (imm += pkt_ptr, 2)")
+__success __retval(0)
+__naked void test19_imm_pkt_ptr_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r4 = 4;						\
+	r4 += r2;					\
+	*(u8*)(r4 + 0) = r4;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test20 (x += pkt_ptr, 1)")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void test20_x_pkt_ptr_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = 0xffffffff;				\
+	*(u64*)(r10 - 8) = r0;				\
+	r0 = *(u64*)(r10 - 8);				\
+	r0 &= 0x7fff;					\
+	r4 = r0;					\
+	r4 += r2;					\
+	r5 = r4;					\
+	r4 += %[__imm_0];				\
+	if r4 > r3 goto l0_%=;				\
+	*(u64*)(r5 + 0) = r4;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0x7fff - 1),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test21 (x += pkt_ptr, 2)")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void test21_x_pkt_ptr_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r4 = 0xffffffff;				\
+	*(u64*)(r10 - 8) = r4;				\
+	r4 = *(u64*)(r10 - 8);				\
+	r4 &= 0x7fff;					\
+	r4 += r2;					\
+	r5 = r4;					\
+	r4 += %[__imm_0];				\
+	if r4 > r3 goto l0_%=;				\
+	*(u64*)(r5 + 0) = r4;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0x7fff - 1),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test22 (x += pkt_ptr, 3)")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void test22_x_pkt_ptr_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	*(u64*)(r10 - 8) = r2;				\
+	*(u64*)(r10 - 16) = r3;				\
+	r3 = *(u64*)(r10 - 16);				\
+	if r0 > r3 goto l0_%=;				\
+	r2 = *(u64*)(r10 - 8);				\
+	r4 = 0xffffffff;				\
+	lock *(u64 *)(r10 - 8) += r4;			\
+	r4 = *(u64*)(r10 - 8);				\
+	r4 >>= 49;					\
+	r4 += r2;					\
+	r0 = r4;					\
+	r0 += 2;					\
+	if r0 > r3 goto l0_%=;				\
+	r2 = 1;						\
+	*(u16*)(r4 + 0) = r2;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test23 (x += pkt_ptr, 4)")
+__failure __msg("invalid access to packet, off=0 size=8, R5(id=2,off=0,r=0)")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void test23_x_pkt_ptr_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	*(u64*)(r10 - 8) = r0;				\
+	r0 = *(u64*)(r10 - 8);				\
+	r0 &= 0xffff;					\
+	r4 = r0;					\
+	r0 = 31;					\
+	r0 += r4;					\
+	r0 += r2;					\
+	r5 = r0;					\
+	r0 += %[__imm_0];				\
+	if r0 > r3 goto l0_%=;				\
+	*(u64*)(r5 + 0) = r0;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0xffff - 1),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test24 (x += pkt_ptr, 5)")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void test24_x_pkt_ptr_5(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = 0xffffffff;				\
+	*(u64*)(r10 - 8) = r0;				\
+	r0 = *(u64*)(r10 - 8);				\
+	r0 &= 0xff;					\
+	r4 = r0;					\
+	r0 = 64;					\
+	r0 += r4;					\
+	r0 += r2;					\
+	r5 = r0;					\
+	r0 += %[__imm_0];				\
+	if r0 > r3 goto l0_%=;				\
+	*(u64*)(r5 + 0) = r0;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__imm_0, 0x7fff - 1),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test25 (marking on <, good access)")
+__success __retval(0)
+__naked void test25_marking_on_good_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 < r3 goto l0_%=;				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u8*)(r2 + 0);				\
+	goto l1_%=;					\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test26 (marking on <, bad access)")
+__failure __msg("invalid access to packet")
+__naked void test26_marking_on_bad_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 < r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+l0_%=:	goto l1_%=;					\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test27 (marking on <=, good access)")
+__success __retval(1)
+__naked void test27_marking_on_good_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r3 <= r0 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test28 (marking on <=, bad access)")
+__failure __msg("invalid access to packet")
+__naked void test28_marking_on_bad_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r3 <= r0 goto l0_%=;				\
+l1_%=:	r0 = 1;						\
+	exit;						\
+l0_%=:	r0 = *(u8*)(r2 + 0);				\
+	goto l1_%=;					\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test29 (reg > pkt_end in subprog)")
+__success __retval(0)
+__naked void reg_pkt_end_in_subprog(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r2 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r3 = r6;					\
+	r3 += 8;					\
+	call reg_pkt_end_in_subprog__1;			\
+	if r0 == 0 goto l0_%=;				\
+	r0 = *(u8*)(r6 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void reg_pkt_end_in_subprog__1(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	if r3 > r2 goto l0_%=;				\
+	r0 = 1;						\
+l0_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test30 (check_id() in regsafe(), bad access)")
+__failure __msg("invalid access to packet, off=0 size=1, R2")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void id_in_regsafe_bad_access(void)
+{
+	asm volatile ("					\
+	/* r9 = ctx */					\
+	r9 = r1;					\
+	/* r7 = ktime_get_ns() */			\
+	call %[bpf_ktime_get_ns];			\
+	r7 = r0;					\
+	/* r6 = ktime_get_ns() */			\
+	call %[bpf_ktime_get_ns];			\
+	r6 = r0;					\
+	/* r2 = ctx->data				\
+	 * r3 = ctx->data				\
+	 * r4 = ctx->data_end				\
+	 */						\
+	r2 = *(u32*)(r9 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r9 + %[__sk_buff_data]);		\
+	r4 = *(u32*)(r9 + %[__sk_buff_data_end]);	\
+	/* if r6 > 100 goto exit			\
+	 * if r7 > 100 goto exit			\
+	 */						\
+	if r6 > 100 goto l0_%=;				\
+	if r7 > 100 goto l0_%=;				\
+	/* r2 += r6              ; this forces assignment of ID to r2\
+	 * r2 += 1               ; get some fixed off for r2\
+	 * r3 += r7              ; this forces assignment of ID to r3\
+	 * r3 += 1               ; get some fixed off for r3\
+	 */						\
+	r2 += r6;					\
+	r2 += 1;					\
+	r3 += r7;					\
+	r3 += 1;					\
+	/* if r6 > r7 goto +1    ; no new information about the state is derived from\
+	 *                       ; this check, thus produced verifier states differ\
+	 *                       ; only in 'insn_idx'	\
+	 * r2 = r3               ; optionally share ID between r2 and r3\
+	 */						\
+	if r6 != r7 goto l1_%=;				\
+	r2 = r3;					\
+l1_%=:	/* if r3 > ctx->data_end goto exit */		\
+	if r3 > r4 goto l0_%=;				\
+	/* r5 = *(u8 *) (r2 - 1) ; access packet memory using r2,\
+	 *                       ; this is not always safe\
+	 */						\
+	r5 = *(u8*)(r2 - 1);				\
+l0_%=:	/* exit(0) */					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/direct_packet_access.c b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
deleted file mode 100644
index dce2e28aeb43..000000000000
--- a/tools/testing/selftests/bpf/verifier/direct_packet_access.c
+++ /dev/null
@@ -1,710 +0,0 @@
-{
-	"pkt_end - pkt_start is allowed",
-	.insns = {
-		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-			    offsetof(struct __sk_buff, data_end)),
-		BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-			    offsetof(struct __sk_buff, data)),
-		BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_2),
-		BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = TEST_DATA_LEN,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test1",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_4, 15),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_3, 7),
-	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_3, 12),
-	BPF_ALU64_IMM(BPF_MUL, BPF_REG_4, 14),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 49),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 49),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 8),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_3, 4),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test3",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid bpf_context access off=76",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
-},
-{
-	"direct packet access: test4 (write)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test5 (pkt_end >= reg, good access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test6 (pkt_end >= reg, bad access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 3),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid access to packet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test7 (pkt_end >= reg, both accesses)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 3),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid access to packet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test8 (double test, variant 1)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 4),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test9 (double test, variant 2)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test10 (write invalid)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid access to packet",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test11 (shift, good access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 22),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 144),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 23),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_5, 3),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_5),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.retval = 1,
-},
-{
-	"direct packet access: test12 (and, good access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 22),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 144),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 23),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_5, 15),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_5),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.retval = 1,
-},
-{
-	"direct packet access: test13 (branches, good access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 22),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 13),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_MOV64_IMM(BPF_REG_4, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_4, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 14),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 24),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 23),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_5, 15),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_5),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.retval = 1,
-},
-{
-	"direct packet access: test14 (pkt_ptr += 0, CONST_IMM, good access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 22),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 7),
-	BPF_MOV64_IMM(BPF_REG_5, 12),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_5, 4),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_5),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.retval = 1,
-},
-{
-	"direct packet access: test15 (spill with xadd)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 8),
-	BPF_MOV64_IMM(BPF_REG_5, 4096),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_4, BPF_REG_5, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_4, 0),
-	BPF_STX_MEM(BPF_W, BPF_REG_2, BPF_REG_5, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R2 invalid mem access 'scalar'",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"direct packet access: test16 (arith on data_end)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 16),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R3 pointer arithmetic on pkt_end",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test17 (pruning, alignment)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 14),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_7, 1, 4),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, -4),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	BPF_JMP_A(-6),
-	},
-	.errstr = "misaligned packet access off 2+(0x0; 0x0)+15+-4 size 4",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.flags = F_LOAD_WITH_STRICT_ALIGNMENT,
-},
-{
-	"direct packet access: test18 (imm += pkt_ptr, 1)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_IMM(BPF_REG_0, 8),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_B, BPF_REG_2, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test19 (imm += pkt_ptr, 2)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 3),
-	BPF_MOV64_IMM(BPF_REG_4, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_2),
-	BPF_STX_MEM(BPF_B, BPF_REG_4, BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test20 (x += pkt_ptr, 1)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_IMM(BPF_REG_0, 0xffffffff),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0x7fff),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_4),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 0x7fff - 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"direct packet access: test21 (x += pkt_ptr, 2)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 9),
-	BPF_MOV64_IMM(BPF_REG_4, 0xffffffff),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_4, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_4, 0x7fff),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_4),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 0x7fff - 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"direct packet access: test22 (x += pkt_ptr, 3)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_3, -16),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_10, -16),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 11),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -8),
-	BPF_MOV64_IMM(BPF_REG_4, 0xffffffff),
-	BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_4, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 49),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_4),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 2),
-	BPF_MOV64_IMM(BPF_REG_2, 1),
-	BPF_STX_MEM(BPF_H, BPF_REG_4, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"direct packet access: test23 (x += pkt_ptr, 4)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffff),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_0, 31),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0xffff - 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid access to packet, off=0 size=8, R5(id=2,off=0,r=0)",
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"direct packet access: test24 (x += pkt_ptr, 5)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_IMM(BPF_REG_0, 0xffffffff),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xff),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_0, 64),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 0x7fff - 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_5, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"direct packet access: test25 (marking on <, good access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_3, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -4),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test26 (marking on <, bad access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_3, 3),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -3),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test27 (marking on <=, good access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_0, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.retval = 1,
-},
-{
-	"direct packet access: test28 (marking on <=, bad access)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -4),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test29 (reg > pkt_end in subprog)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 8),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 1),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"direct packet access: test30 (check_id() in regsafe(), bad access)",
-	.insns = {
-	/* r9 = ctx */
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
-	/* r7 = ktime_get_ns() */
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	/* r6 = ktime_get_ns() */
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* r2 = ctx->data
-	 * r3 = ctx->data
-	 * r4 = ctx->data_end
-	 */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_9, offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_9, offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_9, offsetof(struct __sk_buff, data_end)),
-	/* if r6 > 100 goto exit
-	 * if r7 > 100 goto exit
-	 */
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_6, 100, 9),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_7, 100, 8),
-	/* r2 += r6              ; this forces assignment of ID to r2
-	 * r2 += 1               ; get some fixed off for r2
-	 * r3 += r7              ; this forces assignment of ID to r3
-	 * r3 += 1               ; get some fixed off for r3
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_7),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 1),
-	/* if r6 > r7 goto +1    ; no new information about the state is derived from
-	 *                       ; this check, thus produced verifier states differ
-	 *                       ; only in 'insn_idx'
-	 * r2 = r3               ; optionally share ID between r2 and r3
-	 */
-	BPF_JMP_REG(BPF_JNE, BPF_REG_6, BPF_REG_7, 1),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_3),
-	/* if r3 > ctx->data_end goto exit */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_4, 1),
-	/* r5 = *(u8 *) (r2 - 1) ; access packet memory using r2,
-	 *                       ; this is not always safe
-	 */
-	BPF_LDX_MEM(BPF_B, BPF_REG_5, BPF_REG_2, -1),
-	/* exit(0) */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.flags = BPF_F_TEST_STATE_FREQ,
-	.result = REJECT,
-	.errstr = "invalid access to packet, off=0 size=1, R2",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-- 
2.40.0

