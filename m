Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808BF6EEB1B
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbjDYXtr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbjDYXtr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:49:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E45B232
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:43 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEjBS031728
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:43 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6hju3dh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:43 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:42 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3BC162F2D84BA; Tue, 25 Apr 2023 16:49:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 09/10] selftests/bpf: add precision propagation tests in the presence of subprogs
Date:   Tue, 25 Apr 2023 16:49:10 -0700
Message-ID: <20230425234911.2113352-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425234911.2113352-1-andrii@kernel.org>
References: <20230425234911.2113352-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BwS6-fbi0MXfo9kV6v775l6q4Y-R9n4s
X-Proofpoint-ORIG-GUID: BwS6-fbi0MXfo9kV6v775l6q4Y-R9n4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a bunch of tests validating verifier's precision backpropagation
logic in the presence of subprog calls and/or callback-calling
helpers/kfuncs.

We validate the following conditions:
  - subprog_result_precise: static subprog r0 result precision handling;
  - global_subprog_result_precise: global subprog r0 precision
    shortcutting, similar to BPF helper handling;
  - callback_result_precise: similarly r0 marking precise for
    callback-calling helpers;
  - parent_callee_saved_reg_precise, parent_callee_saved_reg_precise_global:
    propagation of precision for callee-saved registers bypassing
    static/global subprogs;
  - parent_callee_saved_reg_precise_with_callback: same as above, but in
    the presence of callback-calling helper;
  - parent_stack_slot_precise, parent_stack_slot_precise_global:
    similar to above, but instead propagating precision of stack slot
    (spilled SCALAR reg);
  - parent_stack_slot_precise_with_callback: same as above, but in the
    presence of callback-calling helper;
  - subprog_arg_precise: propagation of precision of static subprog's
    input argument back to caller;
  - subprog_spill_into_parent_stack_slot_precise: negative test
    validating that verifier currently can't support backtracking of stack
    access with non-r10 register, we validate that we fallback to
    forcing precision for all SCALARs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../bpf/progs/verifier_subprog_precision.c    | 536 ++++++++++++++++++
 3 files changed, 542 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 2497716ee379..531621adef42 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -55,6 +55,7 @@
 #include "verifier_spill_fill.skel.h"
 #include "verifier_spin_lock.skel.h"
 #include "verifier_stack_ptr.skel.h"
+#include "verifier_subprog_precision.skel.h"
 #include "verifier_subreg.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_unpriv.skel.h"
@@ -154,6 +155,7 @@ void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
+void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index d3c1217ba79a..38a57a2e70db 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -86,6 +86,10 @@
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
 
+#ifndef __used
+#define __used __attribute__((used))
+#endif
+
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__x64_"
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
new file mode 100644
index 000000000000..ece317c0a7ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <errno.h>
+#include <string.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
+
+int vals[] SEC(".data.vals") = {1, 2, 3, 4};
+
+__naked __noinline __used
+static unsigned long identity_subprog()
+{
+	/* the simplest *static* 64-bit identity function */
+	asm volatile (
+		"r0 = r1;"
+		"exit;"
+	);
+}
+
+__noinline __used
+unsigned long global_identity_subprog(__u64 x)
+{
+	/* the simplest *global* 64-bit identity function */
+	return x;
+}
+
+__naked __noinline __used
+static unsigned long callback_subprog()
+{
+	/* the simplest callback function */
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("7: (0f) r1 += r0")
+__msg("mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 6: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 5: (27) r0 *= 4")
+__msg("mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 11: (95) exit")
+__msg("mark_precise: frame1: regs(0x1)=r0 stack(0x0)= before 10: (bf) r0 = r1")
+__msg("mark_precise: frame1: regs(0x2)=r1 stack(0x0)= before 4: (85) call pc+5")
+__msg("mark_precise: frame0: regs(0x2)=r1 stack(0x0)= before 3: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 2: (b7) r6 = 3")
+__naked int subprog_result_precise(void)
+{
+	asm volatile (
+		"r6 = 3;"
+		/* pass r6 through r1 into subprog to get it back as r0;
+		 * this whole chain will have to be marked as precise later
+		 */
+		"r1 = r6;"
+		"call identity_subprog;"
+		/* now use subprog's returned value (which is a
+		 * r6 -> r1 -> r0 chain), as index into vals array, forcing
+		 * all of that to be known precisely
+		 */
+		"r0 *= 4;"
+		"r1 = %[vals];"
+		/* here r0->r1->r6 chain is forced to be precise and has to be
+		 * propagated back to the beginning, including through the
+		 * subprog call
+		 */
+		"r1 += r0;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("9: (0f) r1 += r0")
+__msg("mark_precise: frame0: last_idx 9 first_idx 0")
+__msg("mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 8: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 7: (27) r0 *= 4")
+__msg("mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 5: (a5) if r0 < 0x4 goto pc+1")
+__msg("mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 4: (85) call pc+7")
+__naked int global_subprog_result_precise(void)
+{
+	asm volatile (
+		"r6 = 3;"
+		/* pass r6 through r1 into subprog to get it back as r0;
+		 * given global_identity_subprog is global, precision won't
+		 * propagate all the way back to r6
+		 */
+		"r1 = r6;"
+		"call global_identity_subprog;"
+		/* now use subprog's returned value (which is unknown now, so
+		 * we need to clamp it), as index into vals array, forcing r0
+		 * to be marked precise (with no effect on r6, though)
+		 */
+		"if r0 < %[vals_arr_sz] goto 1f;"
+		"r0 = %[vals_arr_sz] - 1;"
+	"1:"
+		"r0 *= 4;"
+		"r1 = %[vals];"
+		/* here r0 is forced to be precise and has to be
+		 * propagated back to the global subprog call, but it
+		 * shouldn't go all the way to mark r6 as precise
+		 */
+		"r1 += r0;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals),
+		  __imm_const(vals_arr_sz, ARRAY_SIZE(vals))
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("14: (0f) r1 += r6")
+__msg("mark_precise: frame0: last_idx 14 first_idx 10")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 13: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 12: (27) r6 *= 4")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 11: (25) if r6 > 0x3 goto pc+4")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 10: (bf) r6 = r0")
+__msg("mark_precise: frame0: parent state regs(0x1)=r0 stack(0x0)=:")
+__msg("mark_precise: frame0: last_idx 18 first_idx 0")
+__msg("mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 18: (95) exit")
+__naked int callback_result_precise(void)
+{
+	asm volatile (
+		"r6 = 3;"
+
+		/* call subprog and use result; r0 shouldn't propagate back to
+		 * callback_subprog
+		 */
+		"r1 = r6;"			/* nr_loops */
+		"r2 = %[callback_subprog];"	/* callback_fn */
+		"r3 = 0;"			/* callback_ctx */
+		"r4 = 0;"			/* flags */
+		"call %[bpf_loop];"
+
+		"r6 = r0;"
+		"if r6 > 3 goto 1f;"
+		"r6 *= 4;"
+		"r1 = %[vals];"
+		/* here r6 is forced to be precise and has to be propagated
+		 * back to the bpf_loop() call, but not beyond
+		 */
+		"r1 += r6;"
+		"r0 = *(u32 *)(r1 + 0);"
+	"1:"
+		"exit;"
+		:
+		: __imm_ptr(vals),
+		  __imm_ptr(callback_subprog),
+		  __imm(bpf_loop)
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("7: (0f) r1 += r6")
+__msg("mark_precise: frame0: last_idx 7 first_idx 0")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 6: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 5: (27) r6 *= 4")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 11: (95) exit")
+__msg("mark_precise: frame1: regs(0x0)= stack(0x0)= before 10: (bf) r0 = r1")
+__msg("mark_precise: frame1: regs(0x0)= stack(0x0)= before 4: (85) call pc+5")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 3: (b7) r1 = 0")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 2: (b7) r6 = 3")
+__naked int parent_callee_saved_reg_precise(void)
+{
+	asm volatile (
+		"r6 = 3;"
+
+		/* call subprog and ignore result; we need this call only to
+		 * complicate jump history
+		 */
+		"r1 = 0;"
+		"call identity_subprog;"
+
+		"r6 *= 4;"
+		"r1 = %[vals];"
+		/* here r6 is forced to be precise and has to be propagated
+		 * back to the beginning, handling (and ignoring) subprog call
+		 */
+		"r1 += r6;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("7: (0f) r1 += r6")
+__msg("mark_precise: frame0: last_idx 7 first_idx 0")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 6: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 5: (27) r6 *= 4")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 4: (85) call pc+5")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 3: (b7) r1 = 0")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 2: (b7) r6 = 3")
+__naked int parent_callee_saved_reg_precise_global(void)
+{
+	asm volatile (
+		"r6 = 3;"
+
+		/* call subprog and ignore result; we need this call only to
+		 * complicate jump history
+		 */
+		"r1 = 0;"
+		"call global_identity_subprog;"
+
+		"r6 *= 4;"
+		"r1 = %[vals];"
+		/* here r6 is forced to be precise and has to be propagated
+		 * back to the beginning, handling (and ignoring) subprog call
+		 */
+		"r1 += r6;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("12: (0f) r1 += r6")
+__msg("mark_precise: frame0: last_idx 12 first_idx 10")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 11: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 10: (27) r6 *= 4")
+__msg("mark_precise: frame0: parent state regs(0x40)=r6 stack(0x0)=:")
+__msg("mark_precise: frame0: last_idx 16 first_idx 0")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 16: (95) exit")
+__msg("mark_precise: frame1: regs(0x0)= stack(0x0)= before 15: (b7) r0 = 0")
+__msg("mark_precise: frame1: regs(0x0)= stack(0x0)= before 9: (85) call bpf_loop#181")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 8: (b7) r4 = 0")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 7: (b7) r3 = 0")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 6: (bf) r2 = r8")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 5: (b7) r1 = 1")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 4: (b7) r6 = 3")
+__naked int parent_callee_saved_reg_precise_with_callback(void)
+{
+	asm volatile (
+		"r6 = 3;"
+
+		/* call subprog and ignore result; we need this call only to
+		 * complicate jump history
+		 */
+		"r1 = 1;"			/* nr_loops */
+		"r2 = %[callback_subprog];"	/* callback_fn */
+		"r3 = 0;"			/* callback_ctx */
+		"r4 = 0;"			/* flags */
+		"call %[bpf_loop];"
+
+		"r6 *= 4;"
+		"r1 = %[vals];"
+		/* here r6 is forced to be precise and has to be propagated
+		 * back to the beginning, handling (and ignoring) callback call
+		 */
+		"r1 += r6;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals),
+		  __imm_ptr(callback_subprog),
+		  __imm(bpf_loop)
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("9: (0f) r1 += r6")
+__msg("mark_precise: frame0: last_idx 9 first_idx 6")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 8: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 7: (27) r6 *= 4")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 6: (79) r6 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: parent state regs(0x0)= stack(0x1)=-8:")
+__msg("mark_precise: frame0: last_idx 13 first_idx 0")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 13: (95) exit")
+__msg("mark_precise: frame1: regs(0x0)= stack(0x0)= before 12: (bf) r0 = r1")
+__msg("mark_precise: frame1: regs(0x0)= stack(0x0)= before 5: (85) call pc+6")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 4: (b7) r1 = 0")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 3: (7b) *(u64 *)(r10 -8) = r6")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 2: (b7) r6 = 3")
+__naked int parent_stack_slot_precise(void)
+{
+	asm volatile (
+		/* spill reg */
+		"r6 = 3;"
+		"*(u64 *)(r10 - 8) = r6;"
+
+		/* call subprog and ignore result; we need this call only to
+		 * complicate jump history
+		 */
+		"r1 = 0;"
+		"call identity_subprog;"
+
+		/* restore reg from stack; in this case we'll be carrying
+		 * stack mask when going back into subprog through jump
+		 * history
+		 */
+		"r6 = *(u64 *)(r10 - 8);"
+
+		"r6 *= 4;"
+		"r1 = %[vals];"
+		/* here r6 is forced to be precise and has to be propagated
+		 * back to the beginning, handling (and ignoring) subprog call
+		 */
+		"r1 += r6;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("9: (0f) r1 += r6")
+__msg("mark_precise: frame0: last_idx 9 first_idx 6")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 8: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 7: (27) r6 *= 4")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 6: (79) r6 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: parent state regs(0x0)= stack(0x1)=-8:")
+__msg("mark_precise: frame0: last_idx 5 first_idx 0")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 5: (85) call pc+6")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 4: (b7) r1 = 0")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 3: (7b) *(u64 *)(r10 -8) = r6")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 2: (b7) r6 = 3")
+__naked int parent_stack_slot_precise_global(void)
+{
+	asm volatile (
+		/* spill reg */
+		"r6 = 3;"
+		"*(u64 *)(r10 - 8) = r6;"
+
+		/* call subprog and ignore result; we need this call only to
+		 * complicate jump history
+		 */
+		"r1 = 0;"
+		"call global_identity_subprog;"
+
+		/* restore reg from stack; in this case we'll be carrying
+		 * stack mask when going back into subprog through jump
+		 * history
+		 */
+		"r6 = *(u64 *)(r10 - 8);"
+
+		"r6 *= 4;"
+		"r1 = %[vals];"
+		/* here r6 is forced to be precise and has to be propagated
+		 * back to the beginning, handling (and ignoring) subprog call
+		 */
+		"r1 += r6;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common, "r6"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("14: (0f) r1 += r6")
+__msg("mark_precise: frame0: last_idx 14 first_idx 11")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 13: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 12: (27) r6 *= 4")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 11: (79) r6 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: parent state regs(0x0)= stack(0x1)=-8:")
+__msg("mark_precise: frame0: last_idx 18 first_idx 0")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 18: (95) exit")
+__msg("mark_precise: frame1: regs(0x0)= stack(0x0)= before 17: (b7) r0 = 0")
+__msg("mark_precise: frame1: regs(0x0)= stack(0x0)= before 10: (85) call bpf_loop#181")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 9: (b7) r4 = 0")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 8: (b7) r3 = 0")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 7: (bf) r2 = r8")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 6: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 5: (7b) *(u64 *)(r10 -8) = r6")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 4: (b7) r6 = 3")
+__naked int parent_stack_slot_precise_with_callback(void)
+{
+	asm volatile (
+		/* spill reg */
+		"r6 = 3;"
+		"*(u64 *)(r10 - 8) = r6;"
+
+		/* ensure we have callback frame in jump history */
+		"r1 = r6;"			/* nr_loops */
+		"r2 = %[callback_subprog];"	/* callback_fn */
+		"r3 = 0;"			/* callback_ctx */
+		"r4 = 0;"			/* flags */
+		"call %[bpf_loop];"
+
+		/* restore reg from stack; in this case we'll be carrying
+		 * stack mask when going back into subprog through jump
+		 * history
+		 */
+		"r6 = *(u64 *)(r10 - 8);"
+
+		"r6 *= 4;"
+		"r1 = %[vals];"
+		/* here r6 is forced to be precise and has to be propagated
+		 * back to the beginning, handling (and ignoring) subprog call
+		 */
+		"r1 += r6;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals),
+		  __imm_ptr(callback_subprog),
+		  __imm(bpf_loop)
+		: __clobber_common, "r6"
+	);
+}
+
+__noinline __used
+static __u64 subprog_with_precise_arg(__u64 x)
+{
+	return vals[x]; /* x is forced to be precise */
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("8: (0f) r2 += r1")
+__msg("mark_precise: frame1: last_idx 8 first_idx 0")
+__msg("mark_precise: frame1: regs(0x2)=r1 stack(0x0)= before 6: (18) r2 = ")
+__msg("mark_precise: frame1: regs(0x2)=r1 stack(0x0)= before 5: (67) r1 <<= 2")
+__msg("mark_precise: frame1: regs(0x2)=r1 stack(0x0)= before 2: (85) call pc+2")
+__msg("mark_precise: frame0: regs(0x2)=r1 stack(0x0)= before 1: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs(0x40)=r6 stack(0x0)= before 0: (b7) r6 = 3")
+__naked int subprog_arg_precise(void)
+{
+	asm volatile (
+		"r6 = 3;"
+		"r1 = r6;"
+		/* subprog_with_precise_arg expects its argument to be
+		 * precise, so r1->r6 will be marked precise from inside the
+		 * subprog
+		 */
+		"call subprog_with_precise_arg;"
+		"r0 += r6;"
+		"exit;"
+		:
+		:
+		: __clobber_common, "r6"
+	);
+}
+
+/* r1 is pointer to stack slot;
+ * r2 is a register to spill into that slot
+ * subprog also spills r2 into its own stack slot
+ */
+__naked __noinline __used
+static __u64 subprog_spill_reg_precise(void)
+{
+	asm volatile (
+		/* spill to parent stack */
+		"*(u64 *)(r1 + 0) = r2;"
+		/* spill to subprog stack (we use -16 offset to avoid
+		 * accidental confusion with parent's -8 stack slot in
+		 * verifier log output)
+		 */
+		"*(u64 *)(r10 - 16) = r2;"
+		/* use both spills as return result to propagete precision everywhere */
+		"r0 = *(u64 *)(r10 - 16);"
+		"r2 = *(u64 *)(r1 + 0);"
+		"r0 += r2;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+/* precision backtracking can't currently handle stack access not through r10,
+ * so we won't be able to mark stack slot fp-8 as precise, and so will
+ * fallback to forcing all as precise
+ */
+__msg("mark_precise: frame0: falling back to forcing all scalars precise")
+__naked int subprog_spill_into_parent_stack_slot_precise(void)
+{
+	asm volatile (
+		"r6 = 1;"
+
+		/* pass pointer to stack slot and r6 to subprog;
+		 * r6 will be marked precise and spilled into fp-8 slot, which
+		 * also should be marked precise
+		 */
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = r6;"
+		"call subprog_spill_reg_precise;"
+
+		/* restore reg from stack; in this case we'll be carrying
+		 * stack mask when going back into subprog through jump
+		 * history
+		 */
+		"r7 = *(u64 *)(r10 - 8);"
+
+		"r7 *= 4;"
+		"r1 = %[vals];"
+		/* here r7 is forced to be precise and has to be propagated
+		 * back to the beginning, handling subprog call and logic
+		 */
+		"r1 += r7;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common, "r6", "r7"
+	);
+}
+
+__naked __noinline __used
+static __u64 subprog_with_checkpoint(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		/* guaranteed checkpoint if BPF_F_TEST_STATE_FREQ is used */
+		"goto +0;"
+		"exit;"
+	);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

