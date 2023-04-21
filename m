Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7436EB0E7
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjDURne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjDURnX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F987EDD
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f939bea9ebso1851565f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098985; x=1684690985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiuvGIClNsEIagMd1FZ+2rHU8wqfRWr9jhPMeSLP8mg=;
        b=btL856ZXyRf/XiR1PJxdQiWsCj71vStmenZYuD21o7cKEgPs32bLk0BzIIoJymShAe
         Z94DzTwtp1nF5+OnYE3nF/gMSqBVZ+sBd9zgMeMCPy0NX6aG/gfEnVNWwq4VebrJ2QCl
         R2mnm9LBSX0Q5rWseit0R7/HJKCCzjA01iNRK4EPlApJyZw71CDkPxTaQDqa3zgRuds2
         TrZdeRUhg6e4+AdyXbeVUzEbADBj7q83q4BTCfM7ILXmbpYfT0ugpDr48AiKz8ugTgau
         Iumn7LSHoE4FO6d0oWUWu05JDicVVx5WdDs/spP/bgkroI1XfpVdxjEA6DqEZUY+z0lN
         EyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098985; x=1684690985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiuvGIClNsEIagMd1FZ+2rHU8wqfRWr9jhPMeSLP8mg=;
        b=iEQHHCQis2FAo5WL6/xJB/ZaXQtXTaFdIqIDajMalS8FyZ369ojwKJqqXbxAJsDI4s
         /pt6aSVWrEWWUs8TJT7EfjmY1cktfg64r85qiFPDsGAnuLnoiMp/j5bto+kiWrbdtfCO
         80Pc3XBzkjPwSxeJOcYm/uxG2ebQIlYewedQjyBW98N0ouvAKeHI5DqcXQr8+0BnrC+f
         qiOa3i7vrVaBHoXzi/4O3Gdl4nlvzPg6il/R/lt30a36mka8vPa/8XXpEcl0zUIiN4rt
         0xqDwArvafJyxbwnxqi0XR+YT0EV0CjPnamKxse1ZSr9jOXsbH4fSjqs4ml4Is0QeUrv
         RjeA==
X-Gm-Message-State: AAQBX9etnq5b9pPIXc67xz/7SRhnp27oOFQmpUivdLiaZJC0sR5F7AHd
        NsSpOhxoHkLCqZoJ4SuKAheDDRDU6z3Nfg==
X-Google-Smtp-Source: AKy350ZxyyWW38boL6Deg0gdPLUYRHv9szhV/tNxUQjNO6M2RHv7LfutgygfP83sN2Prl58eZeWfuQ==
X-Received: by 2002:a5d:508c:0:b0:2fb:600e:55bd with SMTP id a12-20020a5d508c000000b002fb600e55bdmr4609122wrt.39.1682098985483;
        Fri, 21 Apr 2023 10:43:05 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:05 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 17/24] selftests/bpf: verifier/runtime_jit converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:27 +0300
Message-Id: <20230421174234.2391278-18-eddyz87@gmail.com>
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

Test verifier/runtime_jit automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_runtime_jit.c          | 360 ++++++++++++++++++
 .../selftests/bpf/verifier/runtime_jit.c      | 231 -----------
 3 files changed, 362 insertions(+), 231 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_runtime_jit.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/runtime_jit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index f0b9b74c43d7..072b0eb47391 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -48,6 +48,7 @@
 #include "verifier_ref_tracking.skel.h"
 #include "verifier_regalloc.skel.h"
 #include "verifier_ringbuf.skel.h"
+#include "verifier_runtime_jit.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_uninit.skel.h"
@@ -137,6 +138,7 @@ void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
 void test_verifier_ref_tracking(void)         { RUN(verifier_ref_tracking); }
 void test_verifier_regalloc(void)             { RUN(verifier_regalloc); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
+void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_runtime_jit.c b/tools/testing/selftests/bpf/progs/verifier_runtime_jit.c
new file mode 100644
index 000000000000..27ebfc1fd9ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_runtime_jit.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/runtime_jit.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+void dummy_prog_42_socket(void);
+void dummy_prog_24_socket(void);
+void dummy_prog_loop1_socket(void);
+void dummy_prog_loop2_socket(void);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 4);
+	__uint(key_size, sizeof(int));
+	__array(values, void (void));
+} map_prog1_socket SEC(".maps") = {
+	.values = {
+		[0] = (void *)&dummy_prog_42_socket,
+		[1] = (void *)&dummy_prog_loop1_socket,
+		[2] = (void *)&dummy_prog_24_socket,
+	},
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 8);
+	__uint(key_size, sizeof(int));
+	__array(values, void (void));
+} map_prog2_socket SEC(".maps") = {
+	.values = {
+		[1] = (void *)&dummy_prog_loop2_socket,
+		[2] = (void *)&dummy_prog_24_socket,
+		[7] = (void *)&dummy_prog_42_socket,
+	},
+};
+
+SEC("socket")
+__auxiliary __auxiliary_unpriv
+__naked void dummy_prog_42_socket(void)
+{
+	asm volatile ("r0 = 42; exit;");
+}
+
+SEC("socket")
+__auxiliary __auxiliary_unpriv
+__naked void dummy_prog_24_socket(void)
+{
+	asm volatile ("r0 = 24; exit;");
+}
+
+SEC("socket")
+__auxiliary __auxiliary_unpriv
+__naked void dummy_prog_loop1_socket(void)
+{
+	asm volatile ("			\
+	r3 = 1;				\
+	r2 = %[map_prog1_socket] ll;	\
+	call %[bpf_tail_call];		\
+	r0 = 41;			\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__auxiliary __auxiliary_unpriv
+__naked void dummy_prog_loop2_socket(void)
+{
+	asm volatile ("			\
+	r3 = 1;				\
+	r2 = %[map_prog2_socket] ll;	\
+	call %[bpf_tail_call];		\
+	r0 = 41;			\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog2_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, prog once")
+__success __success_unpriv __retval(42)
+__naked void call_within_bounds_prog_once(void)
+{
+	asm volatile ("					\
+	r3 = 0;						\
+	r2 = %[map_prog1_socket] ll;			\
+	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, prog loop")
+__success __success_unpriv __retval(41)
+__naked void call_within_bounds_prog_loop(void)
+{
+	asm volatile ("					\
+	r3 = 1;						\
+	r2 = %[map_prog1_socket] ll;			\
+	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, no prog")
+__success __success_unpriv __retval(1)
+__naked void call_within_bounds_no_prog(void)
+{
+	asm volatile ("					\
+	r3 = 3;						\
+	r2 = %[map_prog1_socket] ll;			\
+	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, key 2")
+__success __success_unpriv __retval(24)
+__naked void call_within_bounds_key_2(void)
+{
+	asm volatile ("					\
+	r3 = 2;						\
+	r2 = %[map_prog1_socket] ll;			\
+	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, key 2 / key 2, first branch")
+__success __success_unpriv __retval(24)
+__naked void _2_key_2_first_branch(void)
+{
+	asm volatile ("					\
+	r0 = 13;					\
+	*(u8*)(r1 + %[__sk_buff_cb_0]) = r0;		\
+	r0 = *(u8*)(r1 + %[__sk_buff_cb_0]);		\
+	if r0 == 13 goto l0_%=;				\
+	r3 = 2;						\
+	r2 = %[map_prog1_socket] ll;			\
+	goto l1_%=;					\
+l0_%=:	r3 = 2;						\
+	r2 = %[map_prog1_socket] ll;			\
+l1_%=:	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket),
+	  __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0]))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, key 2 / key 2, second branch")
+__success __success_unpriv __retval(24)
+__naked void _2_key_2_second_branch(void)
+{
+	asm volatile ("					\
+	r0 = 14;					\
+	*(u8*)(r1 + %[__sk_buff_cb_0]) = r0;		\
+	r0 = *(u8*)(r1 + %[__sk_buff_cb_0]);		\
+	if r0 == 13 goto l0_%=;				\
+	r3 = 2;						\
+	r2 = %[map_prog1_socket] ll;			\
+	goto l1_%=;					\
+l0_%=:	r3 = 2;						\
+	r2 = %[map_prog1_socket] ll;			\
+l1_%=:	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket),
+	  __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0]))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, key 0 / key 2, first branch")
+__success __success_unpriv __retval(24)
+__naked void _0_key_2_first_branch(void)
+{
+	asm volatile ("					\
+	r0 = 13;					\
+	*(u8*)(r1 + %[__sk_buff_cb_0]) = r0;		\
+	r0 = *(u8*)(r1 + %[__sk_buff_cb_0]);		\
+	if r0 == 13 goto l0_%=;				\
+	r3 = 0;						\
+	r2 = %[map_prog1_socket] ll;			\
+	goto l1_%=;					\
+l0_%=:	r3 = 2;						\
+	r2 = %[map_prog1_socket] ll;			\
+l1_%=:	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket),
+	  __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0]))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, key 0 / key 2, second branch")
+__success __success_unpriv __retval(42)
+__naked void _0_key_2_second_branch(void)
+{
+	asm volatile ("					\
+	r0 = 14;					\
+	*(u8*)(r1 + %[__sk_buff_cb_0]) = r0;		\
+	r0 = *(u8*)(r1 + %[__sk_buff_cb_0]);		\
+	if r0 == 13 goto l0_%=;				\
+	r3 = 0;						\
+	r2 = %[map_prog1_socket] ll;			\
+	goto l1_%=;					\
+l0_%=:	r3 = 2;						\
+	r2 = %[map_prog1_socket] ll;			\
+l1_%=:	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket),
+	  __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0]))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, different maps, first branch")
+__success __failure_unpriv __msg_unpriv("tail_call abusing map_ptr")
+__retval(1)
+__naked void bounds_different_maps_first_branch(void)
+{
+	asm volatile ("					\
+	r0 = 13;					\
+	*(u8*)(r1 + %[__sk_buff_cb_0]) = r0;		\
+	r0 = *(u8*)(r1 + %[__sk_buff_cb_0]);		\
+	if r0 == 13 goto l0_%=;				\
+	r3 = 0;						\
+	r2 = %[map_prog1_socket] ll;			\
+	goto l1_%=;					\
+l0_%=:	r3 = 0;						\
+	r2 = %[map_prog2_socket] ll;			\
+l1_%=:	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket),
+	  __imm_addr(map_prog2_socket),
+	  __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0]))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call within bounds, different maps, second branch")
+__success __failure_unpriv __msg_unpriv("tail_call abusing map_ptr")
+__retval(42)
+__naked void bounds_different_maps_second_branch(void)
+{
+	asm volatile ("					\
+	r0 = 14;					\
+	*(u8*)(r1 + %[__sk_buff_cb_0]) = r0;		\
+	r0 = *(u8*)(r1 + %[__sk_buff_cb_0]);		\
+	if r0 == 13 goto l0_%=;				\
+	r3 = 0;						\
+	r2 = %[map_prog1_socket] ll;			\
+	goto l1_%=;					\
+l0_%=:	r3 = 0;						\
+	r2 = %[map_prog2_socket] ll;			\
+l1_%=:	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket),
+	  __imm_addr(map_prog2_socket),
+	  __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0]))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: tail_call out of bounds")
+__success __success_unpriv __retval(2)
+__naked void tail_call_out_of_bounds(void)
+{
+	asm volatile ("					\
+	r3 = 256;					\
+	r2 = %[map_prog1_socket] ll;			\
+	call %[bpf_tail_call];				\
+	r0 = 2;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: pass negative index to tail_call")
+__success __success_unpriv __retval(2)
+__naked void negative_index_to_tail_call(void)
+{
+	asm volatile ("					\
+	r3 = -1;					\
+	r2 = %[map_prog1_socket] ll;			\
+	call %[bpf_tail_call];				\
+	r0 = 2;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("runtime/jit: pass > 32bit index to tail_call")
+__success __success_unpriv __retval(42)
+/* Verifier rewrite for unpriv skips tail call here. */
+__retval_unpriv(2)
+__naked void _32bit_index_to_tail_call(void)
+{
+	asm volatile ("					\
+	r3 = 0x100000000 ll;				\
+	r2 = %[map_prog1_socket] ll;			\
+	call %[bpf_tail_call];				\
+	r0 = 2;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/runtime_jit.c b/tools/testing/selftests/bpf/verifier/runtime_jit.c
deleted file mode 100644
index 94c399d1faca..000000000000
--- a/tools/testing/selftests/bpf/verifier/runtime_jit.c
+++ /dev/null
@@ -1,231 +0,0 @@
-{
-	"runtime/jit: tail_call within bounds, prog once",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 1 },
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"runtime/jit: tail_call within bounds, prog loop",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 1 },
-	.result = ACCEPT,
-	.retval = 41,
-},
-{
-	"runtime/jit: tail_call within bounds, no prog",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_3, 3),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 1 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"runtime/jit: tail_call within bounds, key 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_3, 2),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 1 },
-	.result = ACCEPT,
-	.retval = 24,
-},
-{
-	"runtime/jit: tail_call within bounds, key 2 / key 2, first branch",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 13),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 2),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 2),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 5, 9 },
-	.result = ACCEPT,
-	.retval = 24,
-},
-{
-	"runtime/jit: tail_call within bounds, key 2 / key 2, second branch",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 14),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 2),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 2),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 5, 9 },
-	.result = ACCEPT,
-	.retval = 24,
-},
-{
-	"runtime/jit: tail_call within bounds, key 0 / key 2, first branch",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 13),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 2),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 5, 9 },
-	.result = ACCEPT,
-	.retval = 24,
-},
-{
-	"runtime/jit: tail_call within bounds, key 0 / key 2, second branch",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 14),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 2),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 5, 9 },
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"runtime/jit: tail_call within bounds, different maps, first branch",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 13),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 5 },
-	.fixup_prog2 = { 9 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "tail_call abusing map_ptr",
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"runtime/jit: tail_call within bounds, different maps, second branch",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 14),
-	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 13, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 5 },
-	.fixup_prog2 = { 9 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "tail_call abusing map_ptr",
-	.result = ACCEPT,
-	.retval = 42,
-},
-{
-	"runtime/jit: tail_call out of bounds",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_3, 256),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 2),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 1 },
-	.result = ACCEPT,
-	.retval = 2,
-},
-{
-	"runtime/jit: pass negative index to tail_call",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_3, -1),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 2),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 1 },
-	.result = ACCEPT,
-	.retval = 2,
-},
-{
-	"runtime/jit: pass > 32bit index to tail_call",
-	.insns = {
-	BPF_LD_IMM64(BPF_REG_3, 0x100000000ULL),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 2),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 2 },
-	.result = ACCEPT,
-	.retval = 42,
-	/* Verifier rewrite for unpriv skips tail call here. */
-	.retval_unpriv = 2,
-},
-- 
2.40.0

