Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4A6C8A6F
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCYC42 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCYC41 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56711ADEA
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso4187646wmb.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8tn8+l3oy1A+lhrcMuXy7wVfdsCvsWvcdXuY0OL5Uw=;
        b=hSFAVHueUIUvZSSvVOKofSExKlGQNwlc5A7YhgVGKdEB6d9+Orq02DqSAPj5MI4LK8
         RIcTYssT69738sk8cEDX+fvtyAmaFcndkwD7jIsRD0pdbun1BLXkSaE6SDFBvcWOUTcy
         hxaAOXqryoS0QeFNcNrK/SpY3VE7aC1vrOkdRAwgLBxAsSiywKZjpxCLiAFDbnYupSaq
         I4uYBU/GAUFTK7etQinITS3x0lF7ns7h6TGCGauj3gfEeeNbCS9/LhxH6/N/7yqkfM3P
         IMwL018eifqY7ZaO+g7XL2s0M6BHi+I7kuoPcRHUMdtaJdjXUsaidlOS62w9ZUjuqOP6
         WHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8tn8+l3oy1A+lhrcMuXy7wVfdsCvsWvcdXuY0OL5Uw=;
        b=EIFTj4517ixkvg0ufUY1+XajTthLYFxKAxgI9NYd0RcNio7TvjVhhj7u3Y0U2i1a1N
         SDnJW2UuWw1J4x8gJ9w+h5Qr80FgwQ6XfFAQfehq1AwhgDB5Yrz2l4hdjQW8bWU3aPYW
         HV7iVuc3td88ggT67smB+Z0eoF9jCJpDo8FN8GPqrnJIQKqAOxshL+jl3cP95MfPqcOH
         6TCZ7nrBcmiVgniVP1xBstIN1uiJEVAXwDz1rjTF+OsQrmGSWn+PnXjjxTKS8CGJE6Y9
         S0Brhql6WYiNY74z7mCK4V/sUuDNpB8YLcwtxUzn6XmH4yBXYs7maIItKDPMGHtXLj5J
         L6eQ==
X-Gm-Message-State: AO0yUKWZR916rFJpYWGZL9wnrCHmc9DXDg3fvwARHblAdNMa0BziXV99
        30jnaGROnhmRozsMnvUkscGMrKyjHYA=
X-Google-Smtp-Source: AK7set8GyggqP+330sEOs0MBDX0SfhPd2YcAVCI26w7IKzDzpMrmTsM+S4ZSQDrPBVHB8ZPTuxrv3w==
X-Received: by 2002:a7b:ce86:0:b0:3ed:a2db:dd24 with SMTP id q6-20020a7bce86000000b003eda2dbdd24mr4373084wmj.32.1679712981471;
        Fri, 24 Mar 2023 19:56:21 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:20 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 20/43] selftests/bpf: verifier/helper_access_var_len.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:01 +0200
Message-Id: <20230325025524.144043-21-eddyz87@gmail.com>
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

Test verifier/helper_access_var_len.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/verifier_helper_access_var_len.c    | 825 ++++++++++++++++++
 .../bpf/verifier/helper_access_var_len.c      | 650 --------------
 3 files changed, 827 insertions(+), 650 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/helper_access_var_len.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d92211b4c3af..22d7e152c05e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -17,6 +17,7 @@
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
 #include "verifier_div_overflow.skel.h"
+#include "verifier_helper_access_var_len.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -56,3 +57,4 @@ void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
+void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_len); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
new file mode 100644
index 000000000000..50c6b22606f6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
@@ -0,0 +1,825 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/helper_access_var_len.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
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
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} map_ringbuf SEC(".maps");
+
+SEC("tracepoint")
+__description("helper access to variable memory: stack, bitwise AND + JMP, correct bounds")
+__success
+__naked void bitwise_and_jmp_correct_bounds(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -64;					\
+	r0 = 0;						\
+	*(u64*)(r10 - 64) = r0;				\
+	*(u64*)(r10 - 56) = r0;				\
+	*(u64*)(r10 - 48) = r0;				\
+	*(u64*)(r10 - 40) = r0;				\
+	*(u64*)(r10 - 32) = r0;				\
+	*(u64*)(r10 - 24) = r0;				\
+	*(u64*)(r10 - 16) = r0;				\
+	*(u64*)(r10 - 8) = r0;				\
+	r2 = 16;					\
+	*(u64*)(r1 - 128) = r2;				\
+	r2 = *(u64*)(r1 - 128);				\
+	r2 &= 64;					\
+	r4 = 0;						\
+	if r4 >= r2 goto l0_%=;				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("helper access to variable memory: stack, bitwise AND, zero included")
+/* in privileged mode reads from uninitialized stack locations are permitted */
+__success __failure_unpriv
+__msg_unpriv("invalid indirect read from stack R2 off -64+0 size 64")
+__retval(0)
+__naked void stack_bitwise_and_zero_included(void)
+{
+	asm volatile ("					\
+	/* set max stack size */			\
+	r6 = 0;						\
+	*(u64*)(r10 - 128) = r6;			\
+	/* set r3 to a random value */			\
+	call %[bpf_get_prandom_u32];			\
+	r3 = r0;					\
+	/* use bitwise AND to limit r3 range to [0, 64] */\
+	r3 &= 64;					\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = r10;					\
+	r2 += -64;					\
+	r4 = 0;						\
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with\
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.\
+	 * For unpriv this should signal an error, because memory at &fp[-64] is\
+	 * not initialized.				\
+	 */						\
+	call %[bpf_ringbuf_output];			\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_ringbuf_output),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: stack, bitwise AND + JMP, wrong max")
+__failure __msg("invalid indirect access to stack R1 off=-64 size=65")
+__naked void bitwise_and_jmp_wrong_max(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + 8);				\
+	r1 = r10;					\
+	r1 += -64;					\
+	*(u64*)(r1 - 128) = r2;				\
+	r2 = *(u64*)(r1 - 128);				\
+	r2 &= 65;					\
+	r4 = 0;						\
+	if r4 >= r2 goto l0_%=;				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: stack, JMP, correct bounds")
+__success
+__naked void memory_stack_jmp_correct_bounds(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -64;					\
+	r0 = 0;						\
+	*(u64*)(r10 - 64) = r0;				\
+	*(u64*)(r10 - 56) = r0;				\
+	*(u64*)(r10 - 48) = r0;				\
+	*(u64*)(r10 - 40) = r0;				\
+	*(u64*)(r10 - 32) = r0;				\
+	*(u64*)(r10 - 24) = r0;				\
+	*(u64*)(r10 - 16) = r0;				\
+	*(u64*)(r10 - 8) = r0;				\
+	r2 = 16;					\
+	*(u64*)(r1 - 128) = r2;				\
+	r2 = *(u64*)(r1 - 128);				\
+	if r2 > 64 goto l0_%=;				\
+	r4 = 0;						\
+	if r4 >= r2 goto l0_%=;				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: stack, JMP (signed), correct bounds")
+__success
+__naked void stack_jmp_signed_correct_bounds(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -64;					\
+	r0 = 0;						\
+	*(u64*)(r10 - 64) = r0;				\
+	*(u64*)(r10 - 56) = r0;				\
+	*(u64*)(r10 - 48) = r0;				\
+	*(u64*)(r10 - 40) = r0;				\
+	*(u64*)(r10 - 32) = r0;				\
+	*(u64*)(r10 - 24) = r0;				\
+	*(u64*)(r10 - 16) = r0;				\
+	*(u64*)(r10 - 8) = r0;				\
+	r2 = 16;					\
+	*(u64*)(r1 - 128) = r2;				\
+	r2 = *(u64*)(r1 - 128);				\
+	if r2 s> 64 goto l0_%=;				\
+	r4 = 0;						\
+	if r4 s>= r2 goto l0_%=;			\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: stack, JMP, bounds + offset")
+__failure __msg("invalid indirect access to stack R1 off=-64 size=65")
+__naked void memory_stack_jmp_bounds_offset(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + 8);				\
+	r1 = r10;					\
+	r1 += -64;					\
+	*(u64*)(r1 - 128) = r2;				\
+	r2 = *(u64*)(r1 - 128);				\
+	if r2 > 64 goto l0_%=;				\
+	r4 = 0;						\
+	if r4 >= r2 goto l0_%=;				\
+	r2 += 1;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: stack, JMP, wrong max")
+__failure __msg("invalid indirect access to stack R1 off=-64 size=65")
+__naked void memory_stack_jmp_wrong_max(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + 8);				\
+	r1 = r10;					\
+	r1 += -64;					\
+	*(u64*)(r1 - 128) = r2;				\
+	r2 = *(u64*)(r1 - 128);				\
+	if r2 > 65 goto l0_%=;				\
+	r4 = 0;						\
+	if r4 >= r2 goto l0_%=;				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: stack, JMP, no max check")
+__failure
+/* because max wasn't checked, signed min is negative */
+__msg("R2 min value is negative, either use unsigned or 'var &= const'")
+__naked void stack_jmp_no_max_check(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + 8);				\
+	r1 = r10;					\
+	r1 += -64;					\
+	*(u64*)(r1 - 128) = r2;				\
+	r2 = *(u64*)(r1 - 128);				\
+	r4 = 0;						\
+	if r4 >= r2 goto l0_%=;				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("helper access to variable memory: stack, JMP, no min check")
+/* in privileged mode reads from uninitialized stack locations are permitted */
+__success __failure_unpriv
+__msg_unpriv("invalid indirect read from stack R2 off -64+0 size 64")
+__retval(0)
+__naked void stack_jmp_no_min_check(void)
+{
+	asm volatile ("					\
+	/* set max stack size */			\
+	r6 = 0;						\
+	*(u64*)(r10 - 128) = r6;			\
+	/* set r3 to a random value */			\
+	call %[bpf_get_prandom_u32];			\
+	r3 = r0;					\
+	/* use JMP to limit r3 range to [0, 64] */	\
+	if r3 > 64 goto l0_%=;				\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = r10;					\
+	r2 += -64;					\
+	r4 = 0;						\
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with\
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.\
+	 * For unpriv this should signal an error, because memory at &fp[-64] is\
+	 * not initialized.				\
+	 */						\
+	call %[bpf_ringbuf_output];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_ringbuf_output),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: stack, JMP (signed), no min check")
+__failure __msg("R2 min value is negative")
+__naked void jmp_signed_no_min_check(void)
+{
+	asm volatile ("					\
+	r2 = *(u64*)(r1 + 8);				\
+	r1 = r10;					\
+	r1 += -64;					\
+	*(u64*)(r1 - 128) = r2;				\
+	r2 = *(u64*)(r1 - 128);				\
+	if r2 s> 64 goto l0_%=;				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: map, JMP, correct bounds")
+__success
+__naked void memory_map_jmp_correct_bounds(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = %[sizeof_test_val];			\
+	*(u64*)(r10 - 128) = r2;			\
+	r2 = *(u64*)(r10 - 128);			\
+	if r2 s> %[sizeof_test_val] goto l1_%=;		\
+	r4 = 0;						\
+	if r4 s>= r2 goto l1_%=;			\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l1_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(sizeof_test_val, sizeof(struct test_val))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: map, JMP, wrong max")
+__failure __msg("invalid access to map value, value_size=48 off=0 size=49")
+__naked void memory_map_jmp_wrong_max(void)
+{
+	asm volatile ("					\
+	r6 = *(u64*)(r1 + 8);				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = r6;					\
+	*(u64*)(r10 - 128) = r2;			\
+	r2 = *(u64*)(r10 - 128);			\
+	if r2 s> %[__imm_0] goto l1_%=;			\
+	r4 = 0;						\
+	if r4 s>= r2 goto l1_%=;			\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l1_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) + 1)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: map adjusted, JMP, correct bounds")
+__success
+__naked void map_adjusted_jmp_correct_bounds(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 += 20;					\
+	r2 = %[sizeof_test_val];			\
+	*(u64*)(r10 - 128) = r2;			\
+	r2 = *(u64*)(r10 - 128);			\
+	if r2 s> %[__imm_0] goto l1_%=;			\
+	r4 = 0;						\
+	if r4 s>= r2 goto l1_%=;			\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l1_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) - 20),
+	  __imm_const(sizeof_test_val, sizeof(struct test_val))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: map adjusted, JMP, wrong max")
+__failure __msg("R1 min value is outside of the allowed memory range")
+__naked void map_adjusted_jmp_wrong_max(void)
+{
+	asm volatile ("					\
+	r6 = *(u64*)(r1 + 8);				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 += 20;					\
+	r2 = r6;					\
+	*(u64*)(r10 - 128) = r2;			\
+	r2 = *(u64*)(r10 - 128);			\
+	if r2 s> %[__imm_0] goto l1_%=;			\
+	r4 = 0;						\
+	if r4 s>= r2 goto l1_%=;			\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l1_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) - 19)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to variable memory: size = 0 allowed on NULL (ARG_PTR_TO_MEM_OR_NULL)")
+__success __retval(0)
+__naked void ptr_to_mem_or_null_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	r2 = 0;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to variable memory: size > 0 not allowed on NULL (ARG_PTR_TO_MEM_OR_NULL)")
+__failure __msg("R1 type=scalar expected=fp")
+__naked void ptr_to_mem_or_null_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + 0);				\
+	r1 = 0;						\
+	*(u64*)(r10 - 128) = r2;			\
+	r2 = *(u64*)(r10 - 128);			\
+	r2 &= 64;					\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to variable memory: size = 0 allowed on != NULL stack pointer (ARG_PTR_TO_MEM_OR_NULL)")
+__success __retval(0)
+__naked void ptr_to_mem_or_null_3(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -8;					\
+	r2 = 0;						\
+	*(u64*)(r1 + 0) = r2;				\
+	r2 &= 8;					\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to variable memory: size = 0 allowed on != NULL map pointer (ARG_PTR_TO_MEM_OR_NULL)")
+__success __retval(0)
+__naked void ptr_to_mem_or_null_4(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = 0;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to variable memory: size possible = 0 allowed on != NULL stack pointer (ARG_PTR_TO_MEM_OR_NULL)")
+__success __retval(0)
+__naked void ptr_to_mem_or_null_5(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = *(u64*)(r0 + 0);				\
+	if r2 > 8 goto l0_%=;				\
+	r1 = r10;					\
+	r1 += -8;					\
+	*(u64*)(r1 + 0) = r2;				\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to variable memory: size possible = 0 allowed on != NULL map pointer (ARG_PTR_TO_MEM_OR_NULL)")
+__success __retval(0)
+__naked void ptr_to_mem_or_null_6(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = *(u64*)(r0 + 0);				\
+	if r2 > 8 goto l0_%=;				\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to variable memory: size possible = 0 allowed on != NULL packet pointer (ARG_PTR_TO_MEM_OR_NULL)")
+__success __retval(0)
+/* csum_diff of 64-byte packet */
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void ptr_to_mem_or_null_7(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r6;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = *(u64*)(r6 + 0);				\
+	if r2 > 8 goto l0_%=;				\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: size = 0 not allowed on NULL (!ARG_PTR_TO_MEM_OR_NULL)")
+__failure __msg("R1 type=scalar expected=fp")
+__naked void ptr_to_mem_or_null_8(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	r2 = 0;						\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: size > 0 not allowed on NULL (!ARG_PTR_TO_MEM_OR_NULL)")
+__failure __msg("R1 type=scalar expected=fp")
+__naked void ptr_to_mem_or_null_9(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	r2 = 1;						\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: size = 0 allowed on != NULL stack pointer (!ARG_PTR_TO_MEM_OR_NULL)")
+__success
+__naked void ptr_to_mem_or_null_10(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -8;					\
+	r2 = 0;						\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: size = 0 allowed on != NULL map pointer (!ARG_PTR_TO_MEM_OR_NULL)")
+__success
+__naked void ptr_to_mem_or_null_11(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = 0;						\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: size possible = 0 allowed on != NULL stack pointer (!ARG_PTR_TO_MEM_OR_NULL)")
+__success
+__naked void ptr_to_mem_or_null_12(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = *(u64*)(r0 + 0);				\
+	if r2 > 8 goto l0_%=;				\
+	r1 = r10;					\
+	r1 += -8;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: size possible = 0 allowed on != NULL map pointer (!ARG_PTR_TO_MEM_OR_NULL)")
+__success
+__naked void ptr_to_mem_or_null_13(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = *(u64*)(r0 + 0);				\
+	if r2 > 8 goto l0_%=;				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("helper access to variable memory: 8 bytes leak")
+/* in privileged mode reads from uninitialized stack locations are permitted */
+__success __failure_unpriv
+__msg_unpriv("invalid indirect read from stack R2 off -64+32 size 64")
+__retval(0)
+__naked void variable_memory_8_bytes_leak(void)
+{
+	asm volatile ("					\
+	/* set max stack size */			\
+	r6 = 0;						\
+	*(u64*)(r10 - 128) = r6;			\
+	/* set r3 to a random value */			\
+	call %[bpf_get_prandom_u32];			\
+	r3 = r0;					\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = r10;					\
+	r2 += -64;					\
+	r0 = 0;						\
+	*(u64*)(r10 - 64) = r0;				\
+	*(u64*)(r10 - 56) = r0;				\
+	*(u64*)(r10 - 48) = r0;				\
+	*(u64*)(r10 - 40) = r0;				\
+	/* Note: fp[-32] left uninitialized */		\
+	*(u64*)(r10 - 24) = r0;				\
+	*(u64*)(r10 - 16) = r0;				\
+	*(u64*)(r10 - 8) = r0;				\
+	/* Limit r3 range to [1, 64] */			\
+	r3 &= 63;					\
+	r3 += 1;					\
+	r4 = 0;						\
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with\
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.\
+	 * For unpriv this should signal an error, because memory region [1, 64]\
+	 * at &fp[-64] is not fully initialized.	\
+	 */						\
+	call %[bpf_ringbuf_output];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_ringbuf_output),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to variable memory: 8 bytes no leak (init memory)")
+__success
+__naked void bytes_no_leak_init_memory(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r0 = 0;						\
+	r0 = 0;						\
+	*(u64*)(r10 - 64) = r0;				\
+	*(u64*)(r10 - 56) = r0;				\
+	*(u64*)(r10 - 48) = r0;				\
+	*(u64*)(r10 - 40) = r0;				\
+	*(u64*)(r10 - 32) = r0;				\
+	*(u64*)(r10 - 24) = r0;				\
+	*(u64*)(r10 - 16) = r0;				\
+	*(u64*)(r10 - 8) = r0;				\
+	r1 += -64;					\
+	r2 = 0;						\
+	r2 &= 32;					\
+	r2 += 32;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+	r1 = *(u64*)(r10 - 16);				\
+	exit;						\
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
deleted file mode 100644
index 9c4885885aba..000000000000
--- a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
+++ /dev/null
@@ -1,650 +0,0 @@
-{
-	"helper access to variable memory: stack, bitwise AND + JMP, correct bounds",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -56),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -48),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -40),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -32),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -24),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 64),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: stack, bitwise AND, zero included",
-	.insns = {
-	/* set max stack size */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
-	/* set r3 to a random value */
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	/* use bitwise AND to limit r3 range to [0, 64] */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 64),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
-	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
-	 * For unpriv this should signal an error, because memory at &fp[-64] is
-	 * not initialized.
-	 */
-	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 4 },
-	.errstr_unpriv = "invalid indirect read from stack R2 off -64+0 size 64",
-	.result_unpriv = REJECT,
-	/* in privileged mode reads from uninitialized stack locations are permitted */
-	.result = ACCEPT,
-},
-{
-	"helper access to variable memory: stack, bitwise AND + JMP, wrong max",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 65),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid indirect access to stack R1 off=-64 size=65",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: stack, JMP, correct bounds",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -56),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -48),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -40),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -32),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -24),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 4),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: stack, JMP (signed), correct bounds",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -56),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -48),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -40),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -32),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -24),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, 64, 4),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: stack, JMP, bounds + offset",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 5),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 3),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid indirect access to stack R1 off=-64 size=65",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: stack, JMP, wrong max",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 65, 4),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid indirect access to stack R1 off=-64 size=65",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: stack, JMP, no max check",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	/* because max wasn't checked, signed min is negative */
-	.errstr = "R2 min value is negative, either use unsigned or 'var &= const'",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: stack, JMP, no min check",
-	.insns = {
-	/* set max stack size */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
-	/* set r3 to a random value */
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	/* use JMP to limit r3 range to [0, 64] */
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, 64, 6),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
-	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
-	 * For unpriv this should signal an error, because memory at &fp[-64] is
-	 * not initialized.
-	 */
-	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 4 },
-	.errstr_unpriv = "invalid indirect read from stack R2 off -64+0 size 64",
-	.result_unpriv = REJECT,
-	/* in privileged mode reads from uninitialized stack locations are permitted */
-	.result = ACCEPT,
-},
-{
-	"helper access to variable memory: stack, JMP (signed), no min check",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, 64, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R2 min value is negative",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: map, JMP, correct bounds",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val)),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val), 4),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: map, JMP, wrong max",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) + 1, 4),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.errstr = "invalid access to map value, value_size=48 off=0 size=49",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: map adjusted, JMP, correct bounds",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 20),
-	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val)),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) - 20, 4),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: map adjusted, JMP, wrong max",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 20),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) - 19, 4),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 4 },
-	.errstr = "R1 min value is outside of the allowed memory range",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: size = 0 allowed on NULL (ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_EMIT_CALL(BPF_FUNC_csum_diff),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to variable memory: size > 0 not allowed on NULL (ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 64),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_EMIT_CALL(BPF_FUNC_csum_diff),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R1 type=scalar expected=fp",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to variable memory: size = 0 allowed on != NULL stack pointer (ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_EMIT_CALL(BPF_FUNC_csum_diff),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to variable memory: size = 0 allowed on != NULL map pointer (ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_EMIT_CALL(BPF_FUNC_csum_diff),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to variable memory: size possible = 0 allowed on != NULL stack pointer (ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 7),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_EMIT_CALL(BPF_FUNC_csum_diff),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to variable memory: size possible = 0 allowed on != NULL map pointer (ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_EMIT_CALL(BPF_FUNC_csum_diff),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to variable memory: size possible = 0 allowed on != NULL packet pointer (ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 7),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_EMIT_CALL(BPF_FUNC_csum_diff),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.retval = 0 /* csum_diff of 64-byte packet */,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"helper access to variable memory: size = 0 not allowed on NULL (!ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R1 type=scalar expected=fp",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: size > 0 not allowed on NULL (!ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "R1 type=scalar expected=fp",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: size = 0 allowed on != NULL stack pointer (!ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: size = 0 allowed on != NULL map pointer (!ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: size possible = 0 allowed on != NULL stack pointer (!ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: size possible = 0 allowed on != NULL map pointer (!ARG_PTR_TO_MEM_OR_NULL)",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 2),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to variable memory: 8 bytes leak",
-	.insns = {
-	/* set max stack size */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
-	/* set r3 to a random value */
-	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -56),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -48),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -40),
-	/* Note: fp[-32] left uninitialized */
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -24),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	/* Limit r3 range to [1, 64] */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 63),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 1),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
-	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
-	 * For unpriv this should signal an error, because memory region [1, 64]
-	 * at &fp[-64] is not fully initialized.
-	 */
-	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 3 },
-	.errstr_unpriv = "invalid indirect read from stack R2 off -64+32 size 64",
-	.result_unpriv = REJECT,
-	/* in privileged mode reads from uninitialized stack locations are permitted */
-	.result = ACCEPT,
-},
-{
-	"helper access to variable memory: 8 bytes no leak (init memory)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -56),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -48),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -40),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -32),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -24),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 32),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 32),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-- 
2.40.0

