Return-Path: <bpf+bounces-1451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768BC716AEC
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 19:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3157A281270
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63824123;
	Tue, 30 May 2023 17:28:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3307200C0
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:28:29 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535A198
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:28:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso5337991e87.0
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685467677; x=1688059677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AzOuRrSlParB9JLCIe2IxndwSw/AxAffv4FvWCBK+8=;
        b=aQlmvPj6IP96l7B9vG/Mn6N79C9zrEfgBUePm6Dgf7PQjqiht/3vmKFOHjf4cbfyDX
         HG3jEZhFym2BEh21RYYrlANaZ+nM8i0IUERZfYuyqtxZP2lsH84EwuTc0ClkNPxxKSF7
         TQ3eMQRxV8G+sbWjMzUXuwcz9z8/unvERsx0xUlt5QGX7fBCtPQxqNDreTzMLDBjW9hA
         GHvzxwdAFmMJevN/MCVQ3692xeRnkrTkt9hQ388VdeFAfS1MMifbciwzQ4D6cYz8iE5N
         z1wylVBaJVgK+Yx1qeZTCCh6wRbLDPtdrxFmIIFw5wMqcsgKYs/9zEQOTpnFADrmPrJD
         NPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467677; x=1688059677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AzOuRrSlParB9JLCIe2IxndwSw/AxAffv4FvWCBK+8=;
        b=GTjwPl0zdZoCTREBtLF7TK3G99G1TBCXlHq14nMQEwX6G7vCjQmm6VqrbWS6eqbSQm
         6+ykQz4FuSa5B+ajwg6JWnx7WC0573Xc53bdAmnyNrn2o7UfSavIgHhGN5aCVd9fGtIv
         MzcEghio3p5zR0N1lAany7ZU/h+7ZMPgtrXhHG2tF94/iQ4ZEumLBVLVSoMfGQdITp/1
         RxDoj88hOkL5BQcZA7D2MJuTZnaycN/v9Bt8lVX6e8BID0ltZAHNy5qIQ66aRXPM6pUR
         n/mUZKwaF/IoPgEK3+sGZcIj6NHasuxjwBBLO1N5rCk0YhPhM2S/SzeY3LOUuHClCM94
         sdPQ==
X-Gm-Message-State: AC+VfDwtyAgyQvZSd9b6q5iA2iCNPjL35pTdsHdrmEX38yxVOCtuKmpU
	LEEMUnADbuyiETtYzPoRd/pMyT4MsqjEkA==
X-Google-Smtp-Source: ACHHUZ6bHeFsurm7JRcXhBwBm7eSTdRJjywf0NS/Zr73MsuTT4G2I5u6bDBssoqf/HerY+jxxRFAgQ==
X-Received: by 2002:ac2:43ac:0:b0:4e9:74a8:134c with SMTP id t12-20020ac243ac000000b004e974a8134cmr1125574lfl.43.1685467676779;
        Tue, 30 May 2023 10:27:56 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a1-20020a056512020100b004f262997496sm405985lfo.76.2023.05.30.10.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:27:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: check env->that range_transfer_ids has effect
Date: Tue, 30 May 2023 20:27:39 +0300
Message-Id: <20230530172739.447290-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530172739.447290-1-eddyz87@gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
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

Previous commit adds bpf_verifier_env::range_transfer_ids check to
verifier.c:regsafe(). This check allows to skip check_ids() for some
ids in the cached verifier state and thus improves verification
performance.

This commit adds two test cases:
- first: showing that check_ids() is indeed skipped as expected;
- second: modification of first where check_ids() cannot be skipped.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 0ea9a1f6e1ae..2c5bb72696ce 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -105,4 +105,110 @@ __naked void ids_id_mapping_in_regsafe_2(void)
 	: __clobber_all);
 }
 
+/* Label l1 could be reached in two combinations:
+ *
+ *   (1) r6{.id=A}, r7{.id=A}, r8{.id=B}
+ *   (2) r6{.id=B}, r7{.id=A}, r8{.id=B}
+ *
+ * However neither A nor B are used in find_equal_scalars()
+ * to transfer range information in this test.
+ * Thus states (1) and (2) should be considered identical due
+ * to bpf_verifier_env::range_transfer_ids handling.
+ *
+ * Make sure that this is the case by checking that second jump
+ * to l1 hits cached state.
+ */
+SEC("socket")
+__success __log_level(7) __msg("14: safe")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void no_range_transfer_ids(void)
+{
+	asm volatile (
+	/* Bump allocated stack */
+	"r1 = 0;"
+	"*(u64*)(r10 - 16) = r1;"
+	/* r9 = pointer to stack */
+	"r9 = r10;"
+	"r9 += -16;"
+	/* r7 = ktime_get_ns() & 0b11 */
+	"call %[bpf_ktime_get_ns];"
+	"r8 = r0;"
+	"r8 &= 3;"
+	/* r6 = ktime_get_ns() & 0b11 */
+	"call %[bpf_ktime_get_ns];"
+	"r7 = r0;"
+	"r7 &= 3;"
+	/* if r6 > r7 is an unpredictable jump */
+	"if r7 > r8 goto l0_%=;"
+	"r6 = r7;"
+	"goto l1_%=;"
+"l0_%=:"
+	"r6 = r8;"
+"l1_%=:"
+	/* insn #14 */
+	"r9 += r6;"
+	"r9 += r7;"
+	"r9 += r8;"
+	"r0 = *(u8*)(r9 + 0);"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Same as above, but cached state for l1 has id used for
+ * range transfer:
+ *
+ *   (1) r6{.id=A}, r7{.id=A}, r8{.id=B}
+ *   (2) r6{.id=B}, r7{.id=A}, r8{.id=B}
+ *
+ * If (A) is used for range transfer (1) and (2) should not
+ * be considered identical.
+ *
+ * Check this by verifying that instruction immediately following l1
+ * is visited twice.
+ */
+SEC("socket")
+__success __log_level(7) __msg("r9 = r9") __msg("r9 = r9")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void has_range_transfer_ids(void)
+{
+	asm volatile (
+	/* Bump allocated stack */
+	"r1 = 0;"
+	"*(u64*)(r10 - 16) = r1;"
+	/* r9 = pointer to stack */
+	"r9 = r10;"
+	"r9 += -16;"
+	/* r7 = ktime_get_ns() & 0b11 */
+	"call %[bpf_ktime_get_ns];"
+	"r8 = r0;"
+	/* r6 = ktime_get_ns() & 0b11 */
+	"call %[bpf_ktime_get_ns];"
+	"r7 = r0;"
+	/* if r6 > r7 is an unpredictable jump */
+	"if r7 > r8 goto l0_%=;"
+	"r6 = r7;"
+	"goto l1_%=;"
+"l0_%=:"
+	"r6 = r8;"
+"l1_%=:"
+	/* just a unique marker, this insn should be verified twice */
+	"r9 = r9;"
+	/* one of the instructions below transfers range for r6 */
+	"if r7 > 2 goto l2_%=;"
+	"if r8 > 2 goto l2_%=;"
+	"r9 += r6;"
+	"r9 += r7;"
+	"r9 += r8;"
+	"r0 = *(u8*)(r9 + 0);"
+"l2_%=:"
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


