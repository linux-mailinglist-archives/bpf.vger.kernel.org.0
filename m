Return-Path: <bpf+bounces-2524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF472E773
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 17:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D55E28123A
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F13C0A4;
	Tue, 13 Jun 2023 15:39:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920123DB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:39:08 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF01FC2
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f762b3227dso80165e87.1
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686670722; x=1689262722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+rf5Uqf4f16nv0jFDp5YWLf+sYMDgIQkMQ6+uUpWBU=;
        b=DkzESJgEEhaow8wDJzJqdMkMuxH7JZNHrCFGIB/vU2ed+CT2qjt87Jp7eLaCz10HvK
         bt7xD3BDyhRuNpRQTQctRooB+BaUUG533em04URXNzkptjMajOORiN0WP7NQIVOl4LJR
         6Hy9b65rtuZPBuG++e7lFZMghOGt7gdIcLVDP804+YLIMYPjS5ELJYg24FCUsrlHZ6n2
         Bxtv+FEJDRDJlXWRNtfpBFKvwpoWFVFoW5Enuj7NlWtE5Odox71LTsQe5coOWFHW199d
         6kgg9/pnOgE6ph+N8FfwNJ4A1RvgxHfGN1hsGfI1xYbn2L02mzm4Mg/q4uiMuCYY0hrg
         Wygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670722; x=1689262722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+rf5Uqf4f16nv0jFDp5YWLf+sYMDgIQkMQ6+uUpWBU=;
        b=ZpYCiRuah3bamaPjcG7vDQoZ5bzcYDdF3L2jctSZUkclvqSVjMGNqcPNWkyEmHwlWC
         tcEowjD8/JkoAup4+Hy/v4HtrG9BofO8WB1BsKkZdmOjC7LJ3RTdIajN1fxARaSvCwvB
         GBJurvwqnQer6fhMZ/SmVypC/32DVpkRc+GrZgEVlL4ZCLYGzeC47UY0FruZc3V3UqQn
         ZVmKxIg1mQfQs9mm3Z3roxQgdbNzZagj5MDfqr9LfQVnOH17wmzdlt7Dfjj72hpoiy3e
         saRS1uDX1hkETrVAg8UNmMFy4joQq4ui30FC46kIg6Gjq3jmwg8i86WLtzE8wzd7oQvp
         QpRQ==
X-Gm-Message-State: AC+VfDy1+BGRKPWAh6W/oZbjnSvzP0xr2MIw7vAPE0aJGoewQRPRiUDs
	QzWdF+Y6XxYU2G4y9/NC7eHe67pQIOIPxg==
X-Google-Smtp-Source: ACHHUZ446N3qv8XG7dKDSiy6MbLzxTykmL5kgub7v1s1AmMC3Mt634izKmYMybtv2X948yb+Lq71Ag==
X-Received: by 2002:a05:6512:10c8:b0:4f7:47bb:2ce0 with SMTP id k8-20020a05651210c800b004f747bb2ce0mr2033570lfg.4.1686670722240;
        Tue, 13 Jun 2023 08:38:42 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c23-20020a197617000000b004f24db9248dsm1818576lff.141.2023.06.13.08.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:38:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v6 4/4] selftests/bpf: verify that check_ids() is used for scalars in regsafe()
Date: Tue, 13 Jun 2023 18:38:24 +0300
Message-Id: <20230613153824.3324830-5-eddyz87@gmail.com>
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

Verify that the following example is rejected by verifier:

  r9 = ... some pointer with range X ...
  r6 = ... unbound scalar ID=a ...
  r7 = ... unbound scalar ID=b ...
  if (r6 > r7) goto +1
  r7 = r6
  if (r7 > X) goto exit
  r9 += r6
  *(u64 *)r9 = Y

Also add test cases to:
- check that check_alu_op() for BPF_MOV instruction does not allocate
  scalar ID if source register is a constant;
- check that unique scalar IDs are ignored when new verifier state is
  compared to cached verifier state;
- check that two different scalar IDs in a verified state can't be
  mapped to the same scalar ID in current state.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 315 ++++++++++++++++++
 1 file changed, 315 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 8a5203fb14ca..13b29a7faa71 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -341,4 +341,319 @@ __naked void precision_two_ids(void)
 	: __clobber_all);
 }
 
+/* Verify that check_ids() is used by regsafe() for scalars.
+ *
+ * r9 = ... some pointer with range X ...
+ * r6 = ... unbound scalar ID=a ...
+ * r7 = ... unbound scalar ID=b ...
+ * if (r6 > r7) goto +1
+ * r7 = r6
+ * if (r7 > X) goto exit
+ * r9 += r6
+ * ... access memory using r9 ...
+ *
+ * The memory access is safe only if r7 is bounded,
+ * which is true for one branch and not true for another.
+ */
+SEC("socket")
+__failure __msg("register with unbounded min value")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void check_ids_in_regsafe(void)
+{
+	asm volatile (
+	/* Bump allocated stack */
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	/* r9 = pointer to stack */
+	"r9 = r10;"
+	"r9 += -8;"
+	/* r7 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r7 = r0;"
+	/* r6 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r6 = r0;"
+	/* if r6 > r7 is an unpredictable jump */
+	"if r6 > r7 goto l1_%=;"
+	"r7 = r6;"
+"l1_%=:"
+	/* if r7 > 4 ...; transfers range to r6 on one execution path
+	 * but does not transfer on another
+	 */
+	"if r7 > 4 goto l2_%=;"
+	/* Access memory at r9[r6], r6 is not always bounded */
+	"r9 += r6;"
+	"r0 = *(u8*)(r9 + 0);"
+"l2_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Similar to check_ids_in_regsafe.
+ * The l0 could be reached in two states:
+ *
+ *   (1) r6{.id=A}, r7{.id=A}, r8{.id=B}
+ *   (2) r6{.id=B}, r7{.id=A}, r8{.id=B}
+ *
+ * Where (2) is not safe, as "r7 > 4" check won't propagate range for it.
+ * This example would be considered safe without changes to
+ * mark_chain_precision() to track scalar values with equal IDs.
+ */
+SEC("socket")
+__failure __msg("register with unbounded min value")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void check_ids_in_regsafe_2(void)
+{
+	asm volatile (
+	/* Bump allocated stack */
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	/* r9 = pointer to stack */
+	"r9 = r10;"
+	"r9 += -8;"
+	/* r8 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r8 = r0;"
+	/* r7 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r7 = r0;"
+	/* r6 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r6 = r0;"
+	/* scratch .id from r0 */
+	"r0 = 0;"
+	/* if r6 > r7 is an unpredictable jump */
+	"if r6 > r7 goto l1_%=;"
+	/* tie r6 and r7 .id */
+	"r6 = r7;"
+"l0_%=:"
+	/* if r7 > 4 exit(0) */
+	"if r7 > 4 goto l2_%=;"
+	/* Access memory at r9[r6] */
+	"r9 += r6;"
+	"r0 = *(u8*)(r9 + 0);"
+"l2_%=:"
+	"r0 = 0;"
+	"exit;"
+"l1_%=:"
+	/* tie r6 and r8 .id */
+	"r6 = r8;"
+	"goto l0_%=;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Check that scalar IDs *are not* generated on register to register
+ * assignments if source register is a constant.
+ *
+ * If such IDs *are* generated the 'l1' below would be reached in
+ * two states:
+ *
+ *   (1) r1{.id=A}, r2{.id=A}
+ *   (2) r1{.id=C}, r2{.id=C}
+ *
+ * Thus forcing 'if r1 == r2' verification twice.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("11: (1d) if r3 == r4 goto pc+0")
+__msg("frame 0: propagating r3,r4")
+__msg("11: safe")
+__msg("processed 15 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void no_scalar_id_for_const(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	/* unpredictable jump */
+	"if r0 > 7 goto l0_%=;"
+	/* possibly generate same scalar ids for r3 and r4 */
+	"r1 = 0;"
+	"r1 = r1;"
+	"r3 = r1;"
+	"r4 = r1;"
+	"goto l1_%=;"
+"l0_%=:"
+	/* possibly generate different scalar ids for r3 and r4 */
+	"r1 = 0;"
+	"r2 = 0;"
+	"r3 = r1;"
+	"r4 = r2;"
+"l1_%=:"
+	/* predictable jump, marks r3 and r4 precise */
+	"if r3 == r4 goto +0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Same as no_scalar_id_for_const() but for 32-bit values */
+SEC("socket")
+__success __log_level(2)
+__msg("11: (1e) if w3 == w4 goto pc+0")
+__msg("frame 0: propagating r3,r4")
+__msg("11: safe")
+__msg("processed 15 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void no_scalar_id_for_const32(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	/* unpredictable jump */
+	"if r0 > 7 goto l0_%=;"
+	/* possibly generate same scalar ids for r3 and r4 */
+	"w1 = 0;"
+	"w1 = w1;"
+	"w3 = w1;"
+	"w4 = w1;"
+	"goto l1_%=;"
+"l0_%=:"
+	/* possibly generate different scalar ids for r3 and r4 */
+	"w1 = 0;"
+	"w2 = 0;"
+	"w3 = w1;"
+	"w4 = w2;"
+"l1_%=:"
+	/* predictable jump, marks r1 and r2 precise */
+	"if w3 == w4 goto +0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Check that unique scalar IDs are ignored when new verifier state is
+ * compared to cached verifier state. For this test:
+ * - cached state has no id on r1
+ * - new state has a unique id on r1
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("6: (25) if r6 > 0x7 goto pc+1")
+__msg("7: (57) r1 &= 255")
+__msg("8: (bf) r2 = r10")
+__msg("from 6 to 8: safe")
+__msg("processed 12 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void ignore_unique_scalar_ids_cur(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	"r6 = r0;"
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* r1.id == r0.id */
+	"r1 = r0;"
+	/* make r1.id unique */
+	"r0 = 0;"
+	"if r6 > 7 goto l0_%=;"
+	/* clear r1 id, but keep the range compatible */
+	"r1 &= 0xff;"
+"l0_%=:"
+	/* get here in two states:
+	 * - first: r1 has no id (cached state)
+	 * - second: r1 has a unique id (should be considered equivalent)
+	 */
+	"r2 = r10;"
+	"r2 += r1;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Check that unique scalar IDs are ignored when new verifier state is
+ * compared to cached verifier state. For this test:
+ * - cached state has a unique id on r1
+ * - new state has no id on r1
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("6: (25) if r6 > 0x7 goto pc+1")
+__msg("7: (05) goto pc+1")
+__msg("9: (bf) r2 = r10")
+__msg("9: safe")
+__msg("processed 13 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void ignore_unique_scalar_ids_old(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	"r6 = r0;"
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* r1.id == r0.id */
+	"r1 = r0;"
+	/* make r1.id unique */
+	"r0 = 0;"
+	"if r6 > 7 goto l1_%=;"
+	"goto l0_%=;"
+"l1_%=:"
+	/* clear r1 id, but keep the range compatible */
+	"r1 &= 0xff;"
+"l0_%=:"
+	/* get here in two states:
+	 * - first: r1 has a unique id (cached state)
+	 * - second: r1 has no id (should be considered equivalent)
+	 */
+	"r2 = r10;"
+	"r2 += r1;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Check that two different scalar IDs in a verified state can't be
+ * mapped to the same scalar ID in current state.
+ */
+SEC("socket")
+__success __log_level(2)
+/* The exit instruction should be reachable from two states,
+ * use two matches and "processed .. insns" to ensure this.
+ */
+__msg("13: (95) exit")
+__msg("13: (95) exit")
+__msg("processed 18 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void two_old_ids_one_cur_id(void)
+{
+	asm volatile (
+	/* Give unique scalar IDs to r{6,7} */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	"r6 = r0;"
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	"r7 = r0;"
+	"r0 = 0;"
+	/* Maybe make r{6,7} IDs identical */
+	"if r6 > r7 goto l0_%=;"
+	"goto l1_%=;"
+"l0_%=:"
+	"r6 = r7;"
+"l1_%=:"
+	/* Mark r{6,7} precise.
+	 * Get here in two states:
+	 * - first:  r6{.id=A}, r7{.id=B} (cached state)
+	 * - second: r6{.id=A}, r7{.id=A}
+	 * Currently we don't want to consider such states equivalent.
+	 * Thus "exit;" would be verified twice.
+	 */
+	"r2 = r10;"
+	"r2 += r6;"
+	"r2 += r7;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.40.1


