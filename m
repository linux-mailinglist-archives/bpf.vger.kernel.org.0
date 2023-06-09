Return-Path: <bpf+bounces-2266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0E672A512
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6416F281A78
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56323209A0;
	Fri,  9 Jun 2023 21:02:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312231DDDC
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:02:02 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DC30FC
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:02:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1c5a6129eso24463661fa.2
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686344518; x=1688936518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62GLomNpDywhoz4Nr7QyMfQKxaeXL5T5x9VIyDfoD3g=;
        b=id5gNwFQzC/hQpfjVsTiLC0iNcpRapFpgq8hEzGJ2LAQ6KJNx/S5erOTvRi64zMIW5
         ejGbs9LCU2/IIShpcecxZV6y7phLyT2FVIPtgPMj1PHogOc5/pZj1pta2v/UnzFA2Z/y
         02X809H67fcy3OqDrF6wHz6hXt8CR+H0BYZkE9Ds3ZsxOapDrmWus4P7GW0h6V2s38M3
         VxwT88Ozm1dwsoBcpISCqflc1XCEPfRN6hpJD1t4AkWjdAxH5RIMp2L/SIY0IF2UzDS+
         xCBS2ngohPompxMzeO70RyO6rCcL28d8jh3uO8mSs6dEnMjB8hNGFwcZK4SGUByQHgk+
         LIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686344518; x=1688936518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62GLomNpDywhoz4Nr7QyMfQKxaeXL5T5x9VIyDfoD3g=;
        b=aiYY8fzuWnuViOPEzzAmjEeDhTnYkVzePY/EOa6p3FcXoK8CJ1ji83MLxQrwGei2Hj
         7HUdj9lJA8km5evfA+8r84OELXLz/Y/5Rw4H1BecMuqclQC5Gdf60ovFdT89GSbycPV/
         iFdZzRziVFNd8xHpCiqFo/YGYjlbhHFJt5W9Bh2k/uxHixYWanSIVC7dozwcL45FJmIs
         GWs1qYASufMBZ9Y99Owppn+RUDMQH7uLqyTTC0Ypb2gaDi5q4RG/ERbehDmDLQRpRya8
         G3EGxJJvRx+Cjb1uvB4tYy5KlcOtuon6+xwVFwArgc0OEvm9cIB2T14AD7PHMwQxtcdo
         Joiw==
X-Gm-Message-State: AC+VfDxJY0o6NMz9oEgEYhbwgiKb43fXtDjsGN9fhTauyuxFCSUJLYc0
	YV2EqjhxQKRyOdEpBNaBUhQBW7lVWmM=
X-Google-Smtp-Source: ACHHUZ4lKhC4CNxZlBx6f6ImKanTCz1Quc7zBrFbSam22KS0hBEi3+n+auNWsg8JtGrvqur0/nhUbQ==
X-Received: by 2002:a2e:a177:0:b0:2b1:da62:2a86 with SMTP id u23-20020a2ea177000000b002b1da622a86mr1627629ljl.33.1686344517940;
        Fri, 09 Jun 2023 14:01:57 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9dc1000000b002a8bc2fb3cesm521732ljj.115.2023.06.09.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:01:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: verify that check_ids() is used for scalars in regsafe()
Date: Sat, 10 Jun 2023 00:01:43 +0300
Message-Id: <20230609210143.2625430-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609210143.2625430-1-eddyz87@gmail.com>
References: <20230609210143.2625430-1-eddyz87@gmail.com>
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
 .../selftests/bpf/progs/verifier_scalar_ids.c | 313 ++++++++++++++++++
 1 file changed, 313 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 8a5203fb14ca..5d56e764fe43 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -341,4 +341,317 @@ __naked void precision_two_ids(void)
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
+	 * Thus, marker instruction "r0 = r0;" would be verified twice.
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


