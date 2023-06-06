Return-Path: <bpf+bounces-1965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A44724F8A
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 00:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078421C20BD4
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 22:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E134476;
	Tue,  6 Jun 2023 22:24:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA22DBA3
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 22:24:43 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198691723
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 15:24:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f505aace48so8447682e87.0
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686090279; x=1688682279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g64BnN2ydS1vNZAV84VawVAm0Jq4NO5xy2lz+kN8p90=;
        b=dDrScoSUkblEUjdpSK2IfyAUI13+Qi4teakQixOQsVcT0YI0yjpC77gDoVlppbPVuK
         Sx9FG1Qz9n4JH1nNiBMdi6fQj0j3hNpB9bIBt4J1ORrPXAlOHpI93UlAuxmXWBN6ejls
         xkWrtTQE/KBEiosowj7d/nteHXXWeLf4Fs5MqsGUKQz/agTFgYbor0rHz0ca0bpVl31+
         3MfohQkVxOdKIG4ExeFo30sJnaqil92E5pfI+nQTwUvRWjpcjwVrfj24oceCsXpwgHbh
         v8V9A9z76GRW3VjIwLMM98/2ZZ1SAerEWB4n7xsIbLkzFo3u1ZEU6+jsA/T1r0bIDYw7
         DZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090279; x=1688682279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g64BnN2ydS1vNZAV84VawVAm0Jq4NO5xy2lz+kN8p90=;
        b=Jslu8qIxP/UrPOt1vLsZmcR+Uhu6/UFoTeLMcZpn7wdvSEBp/7XjL9e/6A83Wm8PVK
         1loUItL1uY/YLOjCmsf/1i3JLE+msbWPhNTFB6yAnOYoVHr3wbTMq5L033CRF3TouDm/
         jAiTXdMMD/MeJVwZC1SFdzfjCLJRMu6+yTmDH9dO+vglrk+WsBeGImYqmMbt2tO+QxTs
         QvHQtwGSvCjoKKEkPQww9W46mVzzd681D1Qqi0BSu8ksJICHzRkGaM0717n5Awpim0m6
         KWskz5aLQU46JTY6iLjXSgxzPsZx6+3noth68LLJu3qYWoitUh2izXRscjXpZBJAvNtm
         yWBw==
X-Gm-Message-State: AC+VfDwbaFxr8XItUXr5IbFfWNdAdWaIof45cs4WLTlZ+/Cp/PW27mEs
	+rg/nK1RCRti21UgW8B3uX6BrmrYD3k=
X-Google-Smtp-Source: ACHHUZ662UQ+axY5lJVjHEo4ueDqmlgkLSaO2oWEeaUiIVevZdAwrLsqeyqE6z9KxScccoi/NyeKZw==
X-Received: by 2002:ac2:522e:0:b0:4f5:e685:f460 with SMTP id i14-20020ac2522e000000b004f5e685f460mr1367951lfl.36.1686090278976;
        Tue, 06 Jun 2023 15:24:38 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r15-20020ac252af000000b004f3a79c9e0fsm1577487lfm.57.2023.06.06.15.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:24:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: check if mark_chain_precision() follows scalar ids
Date: Wed,  7 Jun 2023 01:24:09 +0300
Message-Id: <20230606222411.1820404-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606222411.1820404-1-eddyz87@gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 324 ++++++++++++++++++
 2 files changed, 326 insertions(+)
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
index 000000000000..0f1071847490
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -0,0 +1,324 @@
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
+/* Check that precision marks propagate through scalar IDs.
+ * Use the same scalar ID in multiple stack frames, check that
+ * precision information is propagated up the call stack.
+ */
+SEC("socket")
+__success __log_level(2)
+/* bar frame */
+__msg("frame2: regs=r1 stack= before 10: (bf) r2 = r10")
+__msg("frame2: regs=r1 stack= before 8: (85) call pc+1")
+/* foo frame */
+__msg("frame1: regs=r1,r6,r7 stack= before 7: (bf) r7 = r1")
+__msg("frame1: regs=r1,r6 stack= before 6: (bf) r6 = r1")
+__msg("frame1: regs=r1 stack= before 4: (85) call pc+1")
+/* main frame */
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
+static __naked __noinline __attribute__((used))
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
+static __naked __noinline __attribute__((used))
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
+static __naked __noinline __attribute__((used))
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


