Return-Path: <bpf+bounces-1967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65507724F8C
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 00:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5B5280BDB
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 22:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7907434D60;
	Tue,  6 Jun 2023 22:24:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581122DBA3
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 22:24:45 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE0171B
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 15:24:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1c30a1653so39550551fa.2
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 15:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686090281; x=1688682281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rlmEPPIy5bG3359MOBQccZKiIDA7URWquaR1/cjcmY=;
        b=boPA7cBmQaOW+zujycMWBP9bSMsnyq0PCnLaKQJLdMQSYGhnxVJQWt3tB9iEe/xYkR
         9ROaMTIepFo+kbNAce6/RyQRlqYZlhNR+8yAQJgApJBsWUkA0s0ZQ5ZL2KVISjdzHI1l
         SGqO8bYh4y3dIG65GTIE8EuVgQDFRfOswERTI2/3LSRXKXQd1wflsJy1wzUuyGYW/VSG
         AtUpWvhCgpC/fsY88JhcDT4T3SQG64Lds4vrC0WE0sTWwyavrEs9adVX4qkxnfX//N+f
         7GJ5UJYC/fBISQ/mmGYJH4RXMEDrBu86wuViLReABWG+8C6H6YjnI/xaDruG9rKZhSy2
         /n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090281; x=1688682281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rlmEPPIy5bG3359MOBQccZKiIDA7URWquaR1/cjcmY=;
        b=aIUdsw5Lsxkhi/dHkyjgrOeP74YeIpM46bg1k/Tdg5zbpATec3C/d9bVNZy/ntoCum
         TSnCubkX79ux+PtBF3Bp9XT6HM6MGzcmdRSeb/QTJ0lP7hh5c/wk74ZmGuLnE87ATGxD
         CLVjd0T2wvtogX+xaqsWbPZMEZ8Xl/RYimcmtz76SiERR9vqTMaUl0jGXixkrAG5cCA5
         bXbCMh27w26XI+uoxw4Y3x1uUSdbqy2EvdI70CR58V4OEifi8469GCQuwwf6zIH8oQSL
         paMkDgSqcmh6OFYg0l9/UmZxTAIuKHinYt50A2vuCcQtEDTykoi62ClNNvknO0W1BEm7
         VLpg==
X-Gm-Message-State: AC+VfDzFG1D1Sfa3970MinBWLIpd0ad/WZzaaTd3ZS5KPPImKZqznyEx
	siHYkCbv+oyqyopcyT+REk0aH+kUFTc=
X-Google-Smtp-Source: ACHHUZ5R25mAU/BqIVt5zdTborGbhvGmo1dhgKkgpPnC6A/DkUImnGDHk9JfH4oC7Du8RQcELKG85g==
X-Received: by 2002:a2e:b16f:0:b0:2ad:99dd:de07 with SMTP id a15-20020a2eb16f000000b002ad99ddde07mr1569695ljm.16.1686090281584;
        Tue, 06 Jun 2023 15:24:41 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r15-20020ac252af000000b004f3a79c9e0fsm1577487lfm.57.2023.06.06.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:24:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: verify that check_ids() is used for scalars in regsafe()
Date: Wed,  7 Jun 2023 01:24:11 +0300
Message-Id: <20230606222411.1820404-5-eddyz87@gmail.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Also add test cases to check that check_alu_op() for BPF_MOV instruction does
not allocate scalar ID if source register is a constant.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 0f1071847490..00d80ba525d7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -321,4 +321,188 @@ __naked void precision_two_ids(void)
 	: __clobber_all);
 }
 
+/* Verify that check_ids() is used by regsafe() for scalars.
+ *
+ * r9 = ... some pointer with range X ...
+ * r6 = ... unbound scalar ID=a ...
+ * r7 = ... unbound scalar ID=b ...
+ * if (r6 > r7) goto +1
+ * r6 = r7
+ * if (r6 > X) goto exit
+ * r9 += r7
+ * *(u8 *)r9 = Y
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
+	/* if r6 > 4 exit(0) */
+	"if r7 > 4 goto l2_%=;"
+	/* Access memory at r9[r7] */
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
+	/* Access memory at r9[r7] */
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
 char _license[] SEC("license") = "GPL";
-- 
2.40.1


