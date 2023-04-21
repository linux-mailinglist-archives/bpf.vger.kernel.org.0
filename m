Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4E6EB0F5
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjDURnv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjDURnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5724234
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f3fe12de15so1274442f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098991; x=1684690991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iQdnDakyrB2TT8Z/oJI675XR5NS4HGYYftltcWFsX8=;
        b=PNNVSXxaB8eWZot0nRwSdGTtNsG/kC+G8pnlw+2fvZxbxDZhPTkkfXix6dqwn+JYqk
         LwEEjEEelk4DEVfykWoN80+99w6TykOGtzx4H8uqRXfaqIG4NWDKoLGYgKT9KJcXcVCc
         V3iGbp2bvkq4YFUxNng+9xnV940vSI+X8ixCXrK29ieFugZ52VsV21YFYOud7yV0cTiq
         7L4CEKJaTyn1Xn+4Xj92YWuPrs3Ef4SNY/5PoXpMef9SV159djZof6GOnLBLsTO+B2C5
         Kvo6MBflVteywEzdi/6wZeAu7VADzbYIoLn/T3j8meIZQfqp/dzd4LCT5CczUMqY96XK
         p7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098991; x=1684690991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iQdnDakyrB2TT8Z/oJI675XR5NS4HGYYftltcWFsX8=;
        b=eQYtjBPduEXfl3IXwk8rDkbu3ddTvegKR4v5n5FMXeMs9QE4AsS/B6MUPwiEmWQt1H
         5o7GhKEbtM6sv+Tu97jKMhyTv5/OhmzhplN8nyTd/Vfbl8xG/Pmv5XmUXMBScZShz3FS
         xolssaQY7zSU6kI7K05CSgy7m4AGlB/3neFGPkVln76KJKu+O7HosQfU59VtrB7GfuxN
         xKSv4Upg7La+tozqrbOuoKj5xajd97alkCUWXlnYXSQEt4miSXrCcGkSZfKeLUWs9n9k
         rZ91NmFPQ21a7zs74qSNtAB/82RXFPy/+Zj+QNc8qMSHKFNT1s0DEtQ+OX/1iQz/orKU
         PBzA==
X-Gm-Message-State: AAQBX9fWpyiZcmOfnqyIlT0Oor6KF9ogYPloqfK2qIHeOfGgOP+gtJ+M
        1BugNCySIPe+cxSdpZoRgDH7JUJxo7XucQ==
X-Google-Smtp-Source: AKy350aQWailbjrOMQmbfycF/K5icEJg8Z30s13mCQp3QGf5mVjcf9E0NTfWvdmmud79JlNKw/+0fQ==
X-Received: by 2002:a5d:46c9:0:b0:2f0:2d92:9c81 with SMTP id g9-20020a5d46c9000000b002f02d929c81mr4772521wrs.19.1682098991190;
        Fri, 21 Apr 2023 10:43:11 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:10 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 22/24] selftests/bpf: verifier/unpriv converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:32 +0300
Message-Id: <20230421174234.2391278-23-eddyz87@gmail.com>
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

Test verifier/unpriv semi-automatically converted to use inline assembly.

The verifier/unpriv.c had to be split in two parts:
- the bulk of the tests is in the progs/verifier_unpriv.c;
- the single test that needs `struct bpf_perf_event_data`
  definition is in the progs/verifier_unpriv_perf.c.

The tests above can't be in a single file because:
- first requires inclusion of the filter.h header
  (to get access to BPF_ST_MEM macro, inline assembler does
   not support this isntruction);
- the second requires vmlinux.h, which contains definitions
  conflicting with filter.h.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/verifier_unpriv.c     | 726 ++++++++++++++++++
 .../bpf/progs/verifier_unpriv_perf.c          |  34 +
 tools/testing/selftests/bpf/verifier/unpriv.c | 562 --------------
 4 files changed, 764 insertions(+), 562 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unpriv.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/unpriv.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 999b694850d3..94405bf00b47 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -56,6 +56,8 @@
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_subreg.skel.h"
 #include "verifier_uninit.skel.h"
+#include "verifier_unpriv.skel.h"
+#include "verifier_unpriv_perf.skel.h"
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
 #include "verifier_value_or_null.skel.h"
@@ -150,6 +152,8 @@ void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
+void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
+void test_verifier_unpriv_perf(void)          { RUN(verifier_unpriv_perf); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
 void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
new file mode 100644
index 000000000000..7ea535bfbacd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -0,0 +1,726 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/unpriv.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+#define BPF_SK_LOOKUP(func) \
+	/* struct bpf_sock_tuple tuple = {} */ \
+	"r2 = 0;"			\
+	"*(u32*)(r10 - 8) = r2;"	\
+	"*(u64*)(r10 - 16) = r2;"	\
+	"*(u64*)(r10 - 24) = r2;"	\
+	"*(u64*)(r10 - 32) = r2;"	\
+	"*(u64*)(r10 - 40) = r2;"	\
+	"*(u64*)(r10 - 48) = r2;"	\
+	/* sk = func(ctx, &tuple, sizeof tuple, 0, 0) */ \
+	"r2 = r10;"			\
+	"r2 += -48;"			\
+	"r3 = %[sizeof_bpf_sock_tuple];"\
+	"r4 = 0;"			\
+	"r5 = 0;"			\
+	"call %[" #func "];"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+void dummy_prog_42_socket(void);
+void dummy_prog_24_socket(void);
+void dummy_prog_loop1_socket(void);
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
+__description("unpriv: return pointer")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(POINTER_VALUE)
+__naked void unpriv_return_pointer(void)
+{
+	asm volatile ("					\
+	r0 = r10;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: add const to pointer")
+__success __success_unpriv __retval(0)
+__naked void unpriv_add_const_to_pointer(void)
+{
+	asm volatile ("					\
+	r1 += 8;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: add pointer to pointer")
+__failure __msg("R1 pointer += pointer")
+__failure_unpriv
+__naked void unpriv_add_pointer_to_pointer(void)
+{
+	asm volatile ("					\
+	r1 += r10;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: neg pointer")
+__success __failure_unpriv __msg_unpriv("R1 pointer arithmetic")
+__retval(0)
+__naked void unpriv_neg_pointer(void)
+{
+	asm volatile ("					\
+	r1 = -r1;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: cmp pointer with const")
+__success __failure_unpriv __msg_unpriv("R1 pointer comparison")
+__retval(0)
+__naked void unpriv_cmp_pointer_with_const(void)
+{
+	asm volatile ("					\
+	if r1 == 0 goto l0_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: cmp pointer with pointer")
+__success __failure_unpriv __msg_unpriv("R10 pointer comparison")
+__retval(0)
+__naked void unpriv_cmp_pointer_with_pointer(void)
+{
+	asm volatile ("					\
+	if r1 == r10 goto l0_%=;			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("unpriv: check that printk is disallowed")
+__success
+__naked void check_that_printk_is_disallowed(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r1 = r10;					\
+	r1 += -8;					\
+	r2 = 8;						\
+	r3 = r1;					\
+	call %[bpf_trace_printk];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_trace_printk)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: pass pointer to helper function")
+__success __failure_unpriv __msg_unpriv("R4 leaks addr")
+__retval(0)
+__naked void pass_pointer_to_helper_function(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	r3 = r2;					\
+	r4 = r2;					\
+	call %[bpf_map_update_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_update_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: indirectly pass pointer on stack to helper function")
+__success __failure_unpriv
+__msg_unpriv("invalid indirect read from stack R2 off -8+0 size 8")
+__retval(0)
+__naked void on_stack_to_helper_function(void)
+{
+	asm volatile ("					\
+	*(u64*)(r10 - 8) = r10;				\
+	r2 = r10;					\
+	r2 += -8;					\
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
+SEC("socket")
+__description("unpriv: mangle pointer on stack 1")
+__success __failure_unpriv __msg_unpriv("attempt to corrupt spilled")
+__retval(0)
+__naked void mangle_pointer_on_stack_1(void)
+{
+	asm volatile ("					\
+	*(u64*)(r10 - 8) = r10;				\
+	r0 = 0;						\
+	*(u32*)(r10 - 8) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: mangle pointer on stack 2")
+__success __failure_unpriv __msg_unpriv("attempt to corrupt spilled")
+__retval(0)
+__naked void mangle_pointer_on_stack_2(void)
+{
+	asm volatile ("					\
+	*(u64*)(r10 - 8) = r10;				\
+	r0 = 0;						\
+	*(u8*)(r10 - 1) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: read pointer from stack in small chunks")
+__failure __msg("invalid size")
+__failure_unpriv
+__naked void from_stack_in_small_chunks(void)
+{
+	asm volatile ("					\
+	*(u64*)(r10 - 8) = r10;				\
+	r0 = *(u32*)(r10 - 8);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: write pointer into ctx")
+__failure __msg("invalid bpf_context access")
+__failure_unpriv __msg_unpriv("R1 leaks addr")
+__naked void unpriv_write_pointer_into_ctx(void)
+{
+	asm volatile ("					\
+	*(u64*)(r1 + 0) = r1;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: spill/fill of ctx")
+__success __success_unpriv __retval(0)
+__naked void unpriv_spill_fill_of_ctx(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -8;					\
+	*(u64*)(r6 + 0) = r1;				\
+	r1 = *(u64*)(r6 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("unpriv: spill/fill of ctx 2")
+__success __retval(0)
+__naked void spill_fill_of_ctx_2(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -8;					\
+	*(u64*)(r6 + 0) = r1;				\
+	r1 = *(u64*)(r6 + 0);				\
+	call %[bpf_get_hash_recalc];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_hash_recalc)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("unpriv: spill/fill of ctx 3")
+__failure __msg("R1 type=fp expected=ctx")
+__naked void spill_fill_of_ctx_3(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -8;					\
+	*(u64*)(r6 + 0) = r1;				\
+	*(u64*)(r6 + 0) = r10;				\
+	r1 = *(u64*)(r6 + 0);				\
+	call %[bpf_get_hash_recalc];			\
+	exit;						\
+"	:
+	: __imm(bpf_get_hash_recalc)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("unpriv: spill/fill of ctx 4")
+__failure __msg("R1 type=scalar expected=ctx")
+__naked void spill_fill_of_ctx_4(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -8;					\
+	*(u64*)(r6 + 0) = r1;				\
+	r0 = 1;						\
+	lock *(u64 *)(r10 - 8) += r0;			\
+	r1 = *(u64*)(r6 + 0);				\
+	call %[bpf_get_hash_recalc];			\
+	exit;						\
+"	:
+	: __imm(bpf_get_hash_recalc)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("unpriv: spill/fill of different pointers stx")
+__failure __msg("same insn cannot be used with different pointers")
+__naked void fill_of_different_pointers_stx(void)
+{
+	asm volatile ("					\
+	r3 = 42;					\
+	r6 = r10;					\
+	r6 += -8;					\
+	if r1 == 0 goto l0_%=;				\
+	r2 = r10;					\
+	r2 += -16;					\
+	*(u64*)(r6 + 0) = r2;				\
+l0_%=:	if r1 != 0 goto l1_%=;				\
+	*(u64*)(r6 + 0) = r1;				\
+l1_%=:	r1 = *(u64*)(r6 + 0);				\
+	*(u32*)(r1 + %[__sk_buff_mark]) = r3;		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+/* Same as above, but use BPF_ST_MEM to save 42
+ * instead of BPF_STX_MEM.
+ */
+SEC("tc")
+__description("unpriv: spill/fill of different pointers st")
+__failure __msg("same insn cannot be used with different pointers")
+__naked void fill_of_different_pointers_st(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -8;					\
+	if r1 == 0 goto l0_%=;				\
+	r2 = r10;					\
+	r2 += -16;					\
+	*(u64*)(r6 + 0) = r2;				\
+l0_%=:	if r1 != 0 goto l1_%=;				\
+	*(u64*)(r6 + 0) = r1;				\
+l1_%=:	r1 = *(u64*)(r6 + 0);				\
+	.8byte %[st_mem];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_insn(st_mem,
+		     BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("unpriv: spill/fill of different pointers stx - ctx and sock")
+__failure __msg("type=ctx expected=sock")
+__naked void pointers_stx_ctx_and_sock(void)
+{
+	asm volatile ("					\
+	r8 = r1;					\
+	/* struct bpf_sock *sock = bpf_sock_lookup(...); */\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r2 = r0;					\
+	/* u64 foo; */					\
+	/* void *target = &foo; */			\
+	r6 = r10;					\
+	r6 += -8;					\
+	r1 = r8;					\
+	/* if (skb == NULL) *target = sock; */		\
+	if r1 == 0 goto l0_%=;				\
+	*(u64*)(r6 + 0) = r2;				\
+l0_%=:	/* else *target = skb; */			\
+	if r1 != 0 goto l1_%=;				\
+	*(u64*)(r6 + 0) = r1;				\
+l1_%=:	/* struct __sk_buff *skb = *target; */		\
+	r1 = *(u64*)(r6 + 0);				\
+	/* skb->mark = 42; */				\
+	r3 = 42;					\
+	*(u32*)(r1 + %[__sk_buff_mark]) = r3;		\
+	/* if (sk) bpf_sk_release(sk) */		\
+	if r1 == 0 goto l2_%=;				\
+	call %[bpf_sk_release];				\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("unpriv: spill/fill of different pointers stx - leak sock")
+__failure
+//.errstr = "same insn cannot be used with different pointers",
+__msg("Unreleased reference")
+__naked void different_pointers_stx_leak_sock(void)
+{
+	asm volatile ("					\
+	r8 = r1;					\
+	/* struct bpf_sock *sock = bpf_sock_lookup(...); */\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r2 = r0;					\
+	/* u64 foo; */					\
+	/* void *target = &foo; */			\
+	r6 = r10;					\
+	r6 += -8;					\
+	r1 = r8;					\
+	/* if (skb == NULL) *target = sock; */		\
+	if r1 == 0 goto l0_%=;				\
+	*(u64*)(r6 + 0) = r2;				\
+l0_%=:	/* else *target = skb; */			\
+	if r1 != 0 goto l1_%=;				\
+	*(u64*)(r6 + 0) = r1;				\
+l1_%=:	/* struct __sk_buff *skb = *target; */		\
+	r1 = *(u64*)(r6 + 0);				\
+	/* skb->mark = 42; */				\
+	r3 = 42;					\
+	*(u32*)(r1 + %[__sk_buff_mark]) = r3;		\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("unpriv: spill/fill of different pointers stx - sock and ctx (read)")
+__failure __msg("same insn cannot be used with different pointers")
+__naked void stx_sock_and_ctx_read(void)
+{
+	asm volatile ("					\
+	r8 = r1;					\
+	/* struct bpf_sock *sock = bpf_sock_lookup(...); */\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r2 = r0;					\
+	/* u64 foo; */					\
+	/* void *target = &foo; */			\
+	r6 = r10;					\
+	r6 += -8;					\
+	r1 = r8;					\
+	/* if (skb) *target = skb */			\
+	if r1 == 0 goto l0_%=;				\
+	*(u64*)(r6 + 0) = r1;				\
+l0_%=:	/* else *target = sock */			\
+	if r1 != 0 goto l1_%=;				\
+	*(u64*)(r6 + 0) = r2;				\
+l1_%=:	/* struct bpf_sock *sk = *target; */		\
+	r1 = *(u64*)(r6 + 0);				\
+	/* if (sk) u32 foo = sk->mark; bpf_sk_release(sk); */\
+	if r1 == 0 goto l2_%=;				\
+	r3 = *(u32*)(r1 + %[bpf_sock_mark]);		\
+	call %[bpf_sk_release];				\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(bpf_sock_mark, offsetof(struct bpf_sock, mark)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("unpriv: spill/fill of different pointers stx - sock and ctx (write)")
+__failure
+//.errstr = "same insn cannot be used with different pointers",
+__msg("cannot write into sock")
+__naked void stx_sock_and_ctx_write(void)
+{
+	asm volatile ("					\
+	r8 = r1;					\
+	/* struct bpf_sock *sock = bpf_sock_lookup(...); */\
+"	BPF_SK_LOOKUP(bpf_sk_lookup_tcp)
+"	r2 = r0;					\
+	/* u64 foo; */					\
+	/* void *target = &foo; */			\
+	r6 = r10;					\
+	r6 += -8;					\
+	r1 = r8;					\
+	/* if (skb) *target = skb */			\
+	if r1 == 0 goto l0_%=;				\
+	*(u64*)(r6 + 0) = r1;				\
+l0_%=:	/* else *target = sock */			\
+	if r1 != 0 goto l1_%=;				\
+	*(u64*)(r6 + 0) = r2;				\
+l1_%=:	/* struct bpf_sock *sk = *target; */		\
+	r1 = *(u64*)(r6 + 0);				\
+	/* if (sk) sk->mark = 42; bpf_sk_release(sk); */\
+	if r1 == 0 goto l2_%=;				\
+	r3 = 42;					\
+	*(u32*)(r1 + %[bpf_sock_mark]) = r3;		\
+	call %[bpf_sk_release];				\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release),
+	  __imm_const(bpf_sock_mark, offsetof(struct bpf_sock, mark)),
+	  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: write pointer into map elem value")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(0)
+__naked void pointer_into_map_elem_value(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	*(u64*)(r0 + 0) = r0;				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("alu32: mov u32 const")
+__success __failure_unpriv __msg_unpriv("R7 invalid mem access 'scalar'")
+__retval(0)
+__naked void alu32_mov_u32_const(void)
+{
+	asm volatile ("					\
+	w7 = 0;						\
+	w7 &= 1;					\
+	w0 = w7;					\
+	if r0 == 0 goto l0_%=;				\
+	r0 = *(u64*)(r7 + 0);				\
+l0_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: partial copy of pointer")
+__success __failure_unpriv __msg_unpriv("R10 partial copy")
+__retval(0)
+__naked void unpriv_partial_copy_of_pointer(void)
+{
+	asm volatile ("					\
+	w1 = w10;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: pass pointer to tail_call")
+__success __failure_unpriv __msg_unpriv("R3 leaks addr into helper")
+__retval(0)
+__naked void pass_pointer_to_tail_call(void)
+{
+	asm volatile ("					\
+	r3 = r1;					\
+	r2 = %[map_prog1_socket] ll;			\
+	call %[bpf_tail_call];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_prog1_socket)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: cmp map pointer with zero")
+__success __failure_unpriv __msg_unpriv("R1 pointer comparison")
+__retval(0)
+__naked void cmp_map_pointer_with_zero(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	r1 = %[map_hash_8b] ll;				\
+	if r1 == 0 goto l0_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: write into frame pointer")
+__failure __msg("frame pointer is read only")
+__failure_unpriv
+__naked void unpriv_write_into_frame_pointer(void)
+{
+	asm volatile ("					\
+	r10 = r1;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: spill/fill frame pointer")
+__failure __msg("frame pointer is read only")
+__failure_unpriv
+__naked void unpriv_spill_fill_frame_pointer(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -8;					\
+	*(u64*)(r6 + 0) = r10;				\
+	r10 = *(u64*)(r6 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: cmp of frame pointer")
+__success __failure_unpriv __msg_unpriv("R10 pointer comparison")
+__retval(0)
+__naked void unpriv_cmp_of_frame_pointer(void)
+{
+	asm volatile ("					\
+	if r10 == 0 goto l0_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: adding of fp, reg")
+__success __failure_unpriv
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__retval(0)
+__naked void unpriv_adding_of_fp_reg(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r1 = 0;						\
+	r1 += r10;					\
+	*(u64*)(r1 - 8) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: adding of fp, imm")
+__success __failure_unpriv
+__msg_unpriv("R1 stack pointer arithmetic goes out of range")
+__retval(0)
+__naked void unpriv_adding_of_fp_imm(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r1 = r10;					\
+	r1 += 0;					\
+	*(u64*)(r1 - 8) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: cmp of stack pointer")
+__success __failure_unpriv __msg_unpriv("R2 pointer comparison")
+__retval(0)
+__naked void unpriv_cmp_of_stack_pointer(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r2 == 0 goto l0_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c b/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
new file mode 100644
index 000000000000..4d77407a0a79
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/unpriv.c */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("perf_event")
+__description("unpriv: spill/fill of different pointers ldx")
+__failure __msg("same insn cannot be used with different pointers")
+__naked void fill_of_different_pointers_ldx(void)
+{
+	asm volatile ("					\
+	r6 = r10;					\
+	r6 += -8;					\
+	if r1 == 0 goto l0_%=;				\
+	r2 = r10;					\
+	r2 += %[__imm_0];				\
+	*(u64*)(r6 + 0) = r2;				\
+l0_%=:	if r1 != 0 goto l1_%=;				\
+	*(u64*)(r6 + 0) = r1;				\
+l1_%=:	r1 = *(u64*)(r6 + 0);				\
+	r1 = *(u64*)(r1 + %[sample_period]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__imm_0,
+		      -(__s32) offsetof(struct bpf_perf_event_data, sample_period) - 8),
+	  __imm_const(sample_period,
+		      offsetof(struct bpf_perf_event_data, sample_period))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testing/selftests/bpf/verifier/unpriv.c
deleted file mode 100644
index af0c0f336625..000000000000
--- a/tools/testing/selftests/bpf/verifier/unpriv.c
+++ /dev/null
@@ -1,562 +0,0 @@
-{
-	"unpriv: return pointer",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 leaks addr",
-	.retval = POINTER_VALUE,
-},
-{
-	"unpriv: add const to pointer",
-	.insns = {
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-},
-{
-	"unpriv: add pointer to pointer",
-	.insns = {
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_10),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R1 pointer += pointer",
-},
-{
-	"unpriv: neg pointer",
-	.insns = {
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R1 pointer arithmetic",
-},
-{
-	"unpriv: cmp pointer with const",
-	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R1 pointer comparison",
-},
-{
-	"unpriv: cmp pointer with pointer",
-	.insns = {
-	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_10, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R10 pointer comparison",
-},
-{
-	"unpriv: check that printk is disallowed",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_trace_printk),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "unknown func bpf_trace_printk#6",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"unpriv: pass pointer to helper function",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr_unpriv = "R4 leaks addr",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: indirectly pass pointer on stack to helper function",
-	.insns = {
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_10, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr_unpriv = "invalid indirect read from stack R2 off -8+0 size 8",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: mangle pointer on stack 1",
-	.insns = {
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_10, -8),
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -8, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "attempt to corrupt spilled",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: mangle pointer on stack 2",
-	.insns = {
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_10, -8),
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "attempt to corrupt spilled",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: read pointer from stack in small chunks",
-	.insns = {
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_10, -8),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid size",
-	.result = REJECT,
-},
-{
-	"unpriv: write pointer into ctx",
-	.insns = {
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 leaks addr",
-	.result_unpriv = REJECT,
-	.errstr = "invalid bpf_context access",
-	.result = REJECT,
-},
-{
-	"unpriv: spill/fill of ctx",
-	.insns = {
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-},
-{
-	"unpriv: spill/fill of ctx 2",
-	.insns = {
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"unpriv: spill/fill of ctx 3",
-	.insns = {
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R1 type=fp expected=ctx",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"unpriv: spill/fill of ctx 4",
-	.insns = {
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_RAW_INSN(BPF_STX | BPF_ATOMIC | BPF_DW,
-		     BPF_REG_10, BPF_REG_0, -8, BPF_ADD),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_hash_recalc),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R1 type=scalar expected=ctx",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"unpriv: spill/fill of different pointers stx",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_3, 42),
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "same insn cannot be used with different pointers",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	/* Same as above, but use BPF_ST_MEM to save 42
-	 * instead of BPF_STX_MEM.
-	 */
-	"unpriv: spill/fill of different pointers st",
-	.insns = {
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "same insn cannot be used with different pointers",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"unpriv: spill/fill of different pointers stx - ctx and sock",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
-	/* struct bpf_sock *sock = bpf_sock_lookup(...); */
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	/* u64 foo; */
-	/* void *target = &foo; */
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	/* if (skb == NULL) *target = sock; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
-	/* else *target = skb; */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	/* struct __sk_buff *skb = *target; */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	/* skb->mark = 42; */
-	BPF_MOV64_IMM(BPF_REG_3, 42),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
-		    offsetof(struct __sk_buff, mark)),
-	/* if (sk) bpf_sk_release(sk) */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-		BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "type=ctx expected=sock",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"unpriv: spill/fill of different pointers stx - leak sock",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
-	/* struct bpf_sock *sock = bpf_sock_lookup(...); */
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	/* u64 foo; */
-	/* void *target = &foo; */
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	/* if (skb == NULL) *target = sock; */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
-	/* else *target = skb; */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	/* struct __sk_buff *skb = *target; */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	/* skb->mark = 42; */
-	BPF_MOV64_IMM(BPF_REG_3, 42),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	//.errstr = "same insn cannot be used with different pointers",
-	.errstr = "Unreleased reference",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"unpriv: spill/fill of different pointers stx - sock and ctx (read)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
-	/* struct bpf_sock *sock = bpf_sock_lookup(...); */
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	/* u64 foo; */
-	/* void *target = &foo; */
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	/* if (skb) *target = skb */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	/* else *target = sock */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
-	/* struct bpf_sock *sk = *target; */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	/* if (sk) u32 foo = sk->mark; bpf_sk_release(sk); */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2),
-		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-			    offsetof(struct bpf_sock, mark)),
-		BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "same insn cannot be used with different pointers",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"unpriv: spill/fill of different pointers stx - sock and ctx (write)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
-	/* struct bpf_sock *sock = bpf_sock_lookup(...); */
-	BPF_SK_LOOKUP(sk_lookup_tcp),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	/* u64 foo; */
-	/* void *target = &foo; */
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	/* if (skb) *target = skb */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	/* else *target = sock */
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
-	/* struct bpf_sock *sk = *target; */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	/* if (sk) sk->mark = 42; bpf_sk_release(sk); */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
-		BPF_MOV64_IMM(BPF_REG_3, 42),
-		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
-			    offsetof(struct bpf_sock, mark)),
-		BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	//.errstr = "same insn cannot be used with different pointers",
-	.errstr = "cannot write into sock",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"unpriv: spill/fill of different pointers ldx",
-	.insns = {
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2,
-		      -(__s32)offsetof(struct bpf_perf_event_data,
-				       sample_period) - 8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1,
-		    offsetof(struct bpf_perf_event_data, sample_period)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "same insn cannot be used with different pointers",
-	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
-},
-{
-	"unpriv: write pointer into map elem value",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.errstr_unpriv = "R0 leaks addr",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"alu32: mov u32 const",
-	.insns = {
-	BPF_MOV32_IMM(BPF_REG_7, 0),
-	BPF_ALU32_IMM(BPF_AND, BPF_REG_7, 1),
-	BPF_MOV32_REG(BPF_REG_0, BPF_REG_7),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R7 invalid mem access 'scalar'",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"unpriv: partial copy of pointer",
-	.insns = {
-	BPF_MOV32_REG(BPF_REG_1, BPF_REG_10),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R10 partial copy",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: pass pointer to tail_call",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_1),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog1 = { 1 },
-	.errstr_unpriv = "R3 leaks addr into helper",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: cmp map pointer with zero",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 1 },
-	.errstr_unpriv = "R1 pointer comparison",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: write into frame pointer",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_10, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "frame pointer is read only",
-	.result = REJECT,
-},
-{
-	"unpriv: spill/fill frame pointer",
-	.insns = {
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "frame pointer is read only",
-	.result = REJECT,
-},
-{
-	"unpriv: cmp of frame pointer",
-	.insns = {
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_10, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R10 pointer comparison",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: adding of fp, reg",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_10),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, -8),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: adding of fp, imm",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, -8),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-{
-	"unpriv: cmp of stack pointer",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R2 pointer comparison",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-},
-- 
2.40.0

