Return-Path: <bpf+bounces-2523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5E172E771
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 17:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D974E2810E8
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ECE3C086;
	Tue, 13 Jun 2023 15:39:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C123DB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:39:07 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA731BF6
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f65779894eso5774710e87.1
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686670719; x=1689262719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9IXfjeD23d9hPD03ntGCnsFDpVLP0lwyTfkRFNmw/g=;
        b=O+REkxHgE0RaGMp8EkT0aBNhByXu/hfAuPw1IzEap15mDbIl6hnzmROHItBuT/4qdN
         qBS9zijr9wCMOLh53/hxAjhviSjqpV9n59/zJgRkbMLKrpKtDMn8G4tQK08CdLvZo4Fm
         ncZq8qYNBP7DJyoFCV2Slq+LN4npcbCrHG74RkaSB3EQdiJH+Q7EH4+g7T6gz6f2Aenc
         dbjEGq/o9RQvfR1k76oWuMgifWIfF+ROqjVuYrlhUs0C92+0FKOUtXX7+cD6my0pRWeH
         YSfo11w1aDUcX5MUk0iTe8aIa4uXYaBvrwnO/1WdjukI3Zb5sjRpzFpVPBD9tWR5IVYv
         88Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670719; x=1689262719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9IXfjeD23d9hPD03ntGCnsFDpVLP0lwyTfkRFNmw/g=;
        b=XBLpbG2CxXOoHr8prOO68c6kqJ0VMsDIakLiwosWeAM659ioHd+vZI9DjJq0r4f482
         FM7ijTnt2XU+DRLLrgyG+6kkHqW6cqyAZHnHx8T8Jg+rxsU2Tc16zzRHL4UgbF6WPOBo
         Wbr5KXlHVJrIYXdVnUz9SG7EOAM8n6ATgDXmtLkdqj/0OGvb/2/KOVsu4CGJ1ItLuCAO
         ckQ8RJLyghkZRdR/MLa0QthD/1TL9OAbIBGowaZfNaxb9/xJ7yJjpWN6IVZ+Ynz+M7iE
         SaA3xOJKR7x77o+HSKhreOEBwiyb+eaWnozZYlFnyBS087liyBZDhChwLWzQQm7l5UbQ
         uVxw==
X-Gm-Message-State: AC+VfDx3NYgOZ4TCQ+ca+j/Nxjs2zORP76g8+vXEjy/bysVESLNNmDz6
	d8iF+gA8sfTandEUjFb+9P7qEBtOFt8Vjw==
X-Google-Smtp-Source: ACHHUZ7FiJ/v8/LZxR5GnV1e7Zre7qjy2d3I5/KJpaV1O6lS8TqGBvFVioctBCAF4O14I4TXwEhQcw==
X-Received: by 2002:a19:6745:0:b0:4f1:2ebf:536f with SMTP id e5-20020a196745000000b004f12ebf536fmr4146469lfj.16.1686670719298;
        Tue, 13 Jun 2023 08:38:39 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c23-20020a197617000000b004f24db9248dsm1818576lff.141.2023.06.13.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:38:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v6 2/4] selftests/bpf: check if mark_chain_precision() follows scalar ids
Date: Tue, 13 Jun 2023 18:38:22 +0300
Message-Id: <20230613153824.3324830-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613153824.3324830-1-eddyz87@gmail.com>
References: <20230613153824.3324830-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Check __mark_chain_precision() log to verify that scalars with same
IDs are marked as precise. Use several scenarios to test that
precision marks are propagated through:
- registers of scalar type with the same ID within one state;
- registers of scalar type with the same ID cross several states;
- registers of scalar type  with the same ID cross several stack frames;
- stack slot of scalar type with the same ID;
- multiple scalar IDs are tracked independently.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 344 ++++++++++++++++++
 2 files changed, 346 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 531621adef42..070a13833c3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -50,6 +50,7 @@
 #include "verifier_regalloc.skel.h"
 #include "verifier_ringbuf.skel.h"
 #include "verifier_runtime_jit.skel.h"
+#include "verifier_scalar_ids.skel.h"
 #include "verifier_search_pruning.skel.h"
 #include "verifier_sock.skel.h"
 #include "verifier_spill_fill.skel.h"
@@ -150,6 +151,7 @@ void test_verifier_ref_tracking(void)         { RUN(verifier_ref_tracking); }
 void test_verifier_regalloc(void)             { RUN(verifier_regalloc); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
+void test_verifier_scalar_ids(void)           { RUN(verifier_scalar_ids); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
 void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
new file mode 100644
index 000000000000..8a5203fb14ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* Check that precision marks propagate through scalar IDs.
+ * Registers r{0,1,2} have the same scalar ID at the moment when r0 is
+ * marked to be precise, this mark is immediately propagated to r{1,2}.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("frame0: regs=r0,r1,r2 stack= before 4: (bf) r3 = r10")
+__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
+__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
+__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
+__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void precision_same_state(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	/* force r0 to be precise, this immediately marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r3 = r10;"
+	"r3 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Same as precision_same_state, but mark propagates through state /
+ * parent state boundary.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("frame0: last_idx 6 first_idx 5 subseq_idx -1")
+__msg("frame0: regs=r0,r1,r2 stack= before 5: (bf) r3 = r10")
+__msg("frame0: parent state regs=r0,r1,r2 stack=:")
+__msg("frame0: regs=r0,r1,r2 stack= before 4: (05) goto pc+0")
+__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
+__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
+__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
+__msg("frame0: parent state regs=r0 stack=:")
+__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void precision_cross_state(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	/* force checkpoint */
+	"goto +0;"
+	/* force r0 to be precise, this immediately marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r3 = r10;"
+	"r3 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Same as precision_same_state, but break one of the
+ * links, note that r1 is absent from regs=... in __msg below.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("frame0: regs=r0,r2 stack= before 5: (bf) r3 = r10")
+__msg("frame0: regs=r0,r2 stack= before 4: (b7) r1 = 0")
+__msg("frame0: regs=r0,r2 stack= before 3: (bf) r2 = r0")
+__msg("frame0: regs=r0 stack= before 2: (bf) r1 = r0")
+__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
+__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void precision_same_state_broken_link(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	/* break link for r1, this is the only line that differs
+	 * compared to the previous test
+	 */
+	"r1 = 0;"
+	/* force r0 to be precise, this immediately marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r3 = r10;"
+	"r3 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Same as precision_same_state_broken_link, but with state /
+ * parent state boundary.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("frame0: regs=r0,r2 stack= before 6: (bf) r3 = r10")
+__msg("frame0: regs=r0,r2 stack= before 5: (b7) r1 = 0")
+__msg("frame0: parent state regs=r0,r2 stack=:")
+__msg("frame0: regs=r0,r1,r2 stack= before 4: (05) goto pc+0")
+__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
+__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
+__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
+__msg("frame0: parent state regs=r0 stack=:")
+__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void precision_cross_state_broken_link(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	/* force checkpoint, although link between r1 and r{0,2} is
+	 * broken by the next statement current precision tracking
+	 * algorithm can't react to it and propagates mark for r1 to
+	 * the parent state.
+	 */
+	"goto +0;"
+	/* break link for r1, this is the only line that differs
+	 * compared to precision_cross_state()
+	 */
+	"r1 = 0;"
+	/* force r0 to be precise, this immediately marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r3 = r10;"
+	"r3 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Check that precision marks propagate through scalar IDs.
+ * Use the same scalar ID in multiple stack frames, check that
+ * precision information is propagated up the call stack.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("11: (0f) r2 += r1")
+/* Current state */
+__msg("frame2: last_idx 11 first_idx 10 subseq_idx -1")
+__msg("frame2: regs=r1 stack= before 10: (bf) r2 = r10")
+__msg("frame2: parent state regs=r1 stack=")
+/* frame1.r{6,7} are marked because mark_precise_scalar_ids()
+ * looks for all registers with frame2.r1.id in the current state
+ */
+__msg("frame1: parent state regs=r6,r7 stack=")
+__msg("frame0: parent state regs=r6 stack=")
+/* Parent state */
+__msg("frame2: last_idx 8 first_idx 8 subseq_idx 10")
+__msg("frame2: regs=r1 stack= before 8: (85) call pc+1")
+/* frame1.r1 is marked because of backtracking of call instruction */
+__msg("frame1: parent state regs=r1,r6,r7 stack=")
+__msg("frame0: parent state regs=r6 stack=")
+/* Parent state */
+__msg("frame1: last_idx 7 first_idx 6 subseq_idx 8")
+__msg("frame1: regs=r1,r6,r7 stack= before 7: (bf) r7 = r1")
+__msg("frame1: regs=r1,r6 stack= before 6: (bf) r6 = r1")
+__msg("frame1: parent state regs=r1 stack=")
+__msg("frame0: parent state regs=r6 stack=")
+/* Parent state */
+__msg("frame1: last_idx 4 first_idx 4 subseq_idx 6")
+__msg("frame1: regs=r1 stack= before 4: (85) call pc+1")
+__msg("frame0: parent state regs=r1,r6 stack=")
+/* Parent state */
+__msg("frame0: last_idx 3 first_idx 1 subseq_idx 4")
+__msg("frame0: regs=r0,r1,r6 stack= before 3: (bf) r6 = r0")
+__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
+__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void precision_many_frames(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r6.id */
+	"r1 = r0;"
+	"r6 = r0;"
+	"call precision_many_frames__foo;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+static __naked __noinline __used
+void precision_many_frames__foo(void)
+{
+	asm volatile (
+	/* conflate one of the register numbers (r6) with outer frame,
+	 * to verify that those are tracked independently
+	 */
+	"r6 = r1;"
+	"r7 = r1;"
+	"call precision_many_frames__bar;"
+	"exit"
+	::: __clobber_all);
+}
+
+static __naked __noinline __used
+void precision_many_frames__bar(void)
+{
+	asm volatile (
+	/* force r1 to be precise, this immediately marks:
+	 * - bar frame r1
+	 * - foo frame r{1,6,7}
+	 * - main frame r{1,6}
+	 */
+	"r2 = r10;"
+	"r2 += r1;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* Check that scalars with the same IDs are marked precise on stack as
+ * well as in registers.
+ */
+SEC("socket")
+__success __log_level(2)
+/* foo frame */
+__msg("frame1: regs=r1 stack=-8,-16 before 9: (bf) r2 = r10")
+__msg("frame1: regs=r1 stack=-8,-16 before 8: (7b) *(u64 *)(r10 -16) = r1")
+__msg("frame1: regs=r1 stack=-8 before 7: (7b) *(u64 *)(r10 -8) = r1")
+__msg("frame1: regs=r1 stack= before 4: (85) call pc+2")
+/* main frame */
+__msg("frame0: regs=r0,r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
+__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
+__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void precision_stack(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == fp[-8].id */
+	"r1 = r0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"call precision_stack__foo;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+static __naked __noinline __used
+void precision_stack__foo(void)
+{
+	asm volatile (
+	/* conflate one of the register numbers (r6) with outer frame,
+	 * to verify that those are tracked independently
+	 */
+	"*(u64*)(r10 - 8) = r1;"
+	"*(u64*)(r10 - 16) = r1;"
+	/* force r1 to be precise, this immediately marks:
+	 * - foo frame r1,fp{-8,-16}
+	 * - main frame r1,fp{-8}
+	 */
+	"r2 = r10;"
+	"r2 += r1;"
+	"exit"
+	::: __clobber_all);
+}
+
+/* Use two separate scalar IDs to check that these are propagated
+ * independently.
+ */
+SEC("socket")
+__success __log_level(2)
+/* r{6,7} */
+__msg("11: (0f) r3 += r7")
+__msg("frame0: regs=r6,r7 stack= before 10: (bf) r3 = r10")
+/* ... skip some insns ... */
+__msg("frame0: regs=r6,r7 stack= before 3: (bf) r7 = r0")
+__msg("frame0: regs=r0,r6 stack= before 2: (bf) r6 = r0")
+/* r{8,9} */
+__msg("12: (0f) r3 += r9")
+__msg("frame0: regs=r8,r9 stack= before 11: (0f) r3 += r7")
+/* ... skip some insns ... */
+__msg("frame0: regs=r8,r9 stack= before 7: (bf) r9 = r0")
+__msg("frame0: regs=r0,r8 stack= before 6: (bf) r8 = r0")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void precision_two_ids(void)
+{
+	asm volatile (
+	/* r6 = random number up to 0xff
+	 * r6.id == r7.id
+	 */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	"r6 = r0;"
+	"r7 = r0;"
+	/* same, but for r{8,9} */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	"r8 = r0;"
+	"r9 = r0;"
+	/* clear r0 id */
+	"r0 = 0;"
+	/* force checkpoint */
+	"goto +0;"
+	"r3 = r10;"
+	/* force r7 to be precise, this also marks r6 */
+	"r3 += r7;"
+	/* force r9 to be precise, this also marks r8 */
+	"r3 += r9;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1


