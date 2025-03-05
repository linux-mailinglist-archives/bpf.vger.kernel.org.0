Return-Path: <bpf+bounces-53350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5FFA5044E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981AE3A5DBA
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA542250C15;
	Wed,  5 Mar 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="QDT+JQOU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B752505DF
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191215; cv=none; b=YWN/2ejNCkiKUg8y3WsBK9QeYnlScf6y+wpmYSsg6DQYFyAUT5Mz7KugIwFwxuJVtxkuJP2rOvgMiEw6Y+uXmYHfYOZOQcuG2cNWNjF6msOxmBrabx0Zb8qJHrp+SVrsIZQvDpTdfEmAVHXsnhtTBJNsOPtjLwmnF2TKzAdesNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191215; c=relaxed/simple;
	bh=9tDmoPTCfZRDQz+7mukoSidrjoQgIh+F9foa08FtQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqgLoZ++2F+C+P2aoug8iN1qAYVP4/T0Fq06UpTCG1oiEydFXmU9yTRl4l5qqRMf0TTfUBUarluu30oeRegil9PA7B/mhtEVHoHOxOky1e7xooTt5nPyluorOux/L/ip83t3372DvHuRQEFL4aeNh37weABajgMp2KTWw5O2thU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=QDT+JQOU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c3c4ff7d31so363373885a.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741191212; x=1741796012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvasM6dor305bsSmqjtkjur/OZbXNOaJrZ/0cME2rqs=;
        b=QDT+JQOUhikPQWc266V9g9r6cEzWoxrvSzhIfYnuK3d+LqqnF32JJRHiOJ3Rk+/2xb
         N3sOIKVnAalv540CZtAlUakfZ7XaeKYCqhG6Qs8c7xqm9+Hn8ehAxrWcrDLztx/9jiW6
         gJwwuK7AJt9GAUqiEuJJ9Y9Xuft34szV1fIgHhJFDNZMDwfr2niAHXnlXokglDRvJ4au
         EyAXt1dHGVd5M2WIaXc1hZyCWA1LTL/5IsGbKKaQts123ybZyZGWwihbX44+2XfctefY
         SqvKZ61qdy/S8NFCrXu5oUEs17eALD0Ige7+VbY5rAbeq/J2FX72kiKwEhuEazNjhxg7
         QEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191212; x=1741796012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvasM6dor305bsSmqjtkjur/OZbXNOaJrZ/0cME2rqs=;
        b=RHGMHCaSUasP3A7eK4AMnKwAQMzENVOV2Dw/tKxoRacQde6bM7tP5Nip92Rn9Y0aeI
         9ZQFo+TUX04mW6QvHqpCsy0I/5RX3NqEaAdVPXtl9W7ASnGXoOgxUXNVCiLy7x9ivLdx
         Tf78XD1m/TxniBgkmPxqjtiD3E1MM8s0nT72xZbTnemT+0j7d1zIxvrTis2QQjaV/xWU
         /JswnMx/aKb5Z/fEjeqQ57a851BTVs1mEH8pviD7iOpVt/96Rf5wAtZ/S8JgGedscQ7B
         m752CxtCgEOUo7M92ui9KfEv8EERYSSOXbxJSyyNBJpRfHB6nik4rqs7eKxd0fBGTwii
         SJAA==
X-Gm-Message-State: AOJu0YwPdKt8MoU9hdt0ITPLX0495SKZuzTr5SSsjmIUH/CI1s+2MatV
	s7VcU+P/LmOiNuxXKVWAwysD/CFx+HuQ6YKLuJMprdHIJJgoD0y0H9qCTVnCIcyo2ZFGFUOLuzv
	NlKPfkw==
X-Gm-Gg: ASbGncuM+EevOTNBITJ772KuxQWdXIOeIVAIXOUIEE3+PPIMI8YWh1feCVswAsf2RsI
	IT+Lfi5tNwK5Kinan5pt1KCEyIxgdBRX9KNdXIU2pptcHsutzH9GExqWvP2Jmzfh10KQrhj+Rvb
	BeFoa2xhJV26pWzebYxweWHqvNfpVBKf7OxN+0095D3vCvr8wi2aZSiaJ9Wg1o8ynp+cA1xOmLX
	/siAcTdj2ZhgnJ3tCglyQapW28+Eu9ISkWT4ShhVbLBbm6fSskjgIepoEDIdlHPnLLvYToJyqTt
	p3cKLHAbYKXsGnS7wxGkzg6HaxzY+DsRdJIU1k7yyQ==
X-Google-Smtp-Source: AGHT+IGe4DLs/xSe7BHJq4x3F8oYgrLVhmCNF2jkdUe3LMvfIlEL3yl32FIqlOCbPi8VvZ9S0Ez8Zg==
X-Received: by 2002:a05:620a:2b96:b0:7c3:d79c:9c41 with SMTP id af79cd13be357-7c3d8e65e88mr709570485a.25.1741191212233;
        Wed, 05 Mar 2025 08:13:32 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c32aa5c6sm368393085a.48.2025.03.05.08.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:13:32 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 2/2] selftests: bpf: add bpf_cpumask_fill selftests
Date: Wed,  5 Mar 2025 11:13:27 -0500
Message-ID: <20250305161327.203396-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305161327.203396-1-emil@etsalapatis.com>
References: <20250305161327.203396-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the bpf_cpumask_fill helper that sets a bpf_cpumask to
a bit pattern provided by a BPF program.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |   3 +
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 114 ++++++++++++++++++
 3 files changed, 155 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index e58a04654238..6185b63b931b 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -25,6 +25,9 @@ static const char * const cpumask_success_testcases[] = {
 	"test_global_mask_nested_deep_rcu",
 	"test_global_mask_nested_deep_array_rcu",
 	"test_cpumask_weight",
+	"test_fill_reject_unaligned",
+	"test_fill_reject_small_mask",
+	"test_fill",
 };
 
 static void verify_success(const char *prog_name)
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index b40b52548ffb..acecded8b155 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -222,3 +222,41 @@ int BPF_PROG(test_invalid_nested_array, struct task_struct *task, u64 clone_flag
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__failure __msg("type=scalar expected=fp")
+int BPF_PROG(test_fill_invalid_destination, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *invalid = (struct bpf_cpumask *)0x123456;
+	u64 bits;
+	int ret;
+
+	ret = bpf_cpumask_fill((struct cpumask *)invalid, &bits, sizeof(bits));
+	if (!ret)
+		err = 2;
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("leads to invalid memory access")
+int BPF_PROG(test_fill_invalid_source, struct task_struct *task, u64 clone_flags)
+{
+	void *garbage = (void *)0x123456;
+	struct bpf_cpumask *local;
+	int ret;
+
+	local = create_cpumask();
+	if (!local) {
+		err = 1;
+		return 0;
+	}
+
+	ret = bpf_cpumask_fill((struct cpumask *)local, garbage, 8);
+	if (!ret)
+		err = 2;
+
+	bpf_cpumask_release(local);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 80ee469b0b60..ba22878028c1 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -757,6 +757,7 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
 	mask1 = bpf_cpumask_create();
 	mask2 = bpf_cpumask_create();
 
+
 	if (!mask1 || !mask2)
 		goto free_masks_return;
 
@@ -770,3 +771,116 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
 		bpf_cpumask_release(mask2);
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_fill_reject_small_mask, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local;
+	u8 toofewbits;
+	int ret;
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	/* The kfunc should prevent this operation */
+	ret = bpf_cpumask_fill((struct cpumask *)local, &toofewbits, sizeof(toofewbits));
+	if (ret != -EACCES)
+		err = 2;
+
+	bpf_cpumask_release(local);
+
+	return 0;
+}
+
+/* Mask is guaranteed to be large enough for bpf_cpumask_t. */
+#define CPUMASK_TEST_MASKLEN (sizeof(cpumask_t))
+
+/* Add an extra word for the test_fill_reject_unaligned test. */
+u64 bits[CPUMASK_TEST_MASKLEN / 8 + 1];
+extern bool CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS __kconfig __weak;
+
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_fill_reject_unaligned, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *mask;
+	char *src;
+	int ret;
+
+	/* Skip if unaligned accesses are fine for this arch.  */
+	if (CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+		return 0;
+
+	mask = bpf_cpumask_create();
+	if (!mask) {
+		err = 1;
+		return 0;
+	}
+
+	/* Misalign the source array by a byte. */
+	src = &((char *)bits)[1];
+
+	ret = bpf_cpumask_fill((struct cpumask *)mask, src, CPUMASK_TEST_MASKLEN);
+	if (ret != -EINVAL)
+		err = 2;
+
+	bpf_cpumask_release(mask);
+
+	return 0;
+}
+
+
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_fill, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *mask;
+	bool bit;
+	int ret;
+	int i;
+
+	/* Set only odd bits. */
+	__builtin_memset(bits, 0xaa, CPUMASK_TEST_MASKLEN);
+
+	mask = bpf_cpumask_create();
+	if (!mask) {
+		err = 1;
+		return 0;
+	}
+
+	/* Pass the entire bits array, the kfunc will only copy the valid bits. */
+	ret = bpf_cpumask_fill((struct cpumask *)mask, bits, CPUMASK_TEST_MASKLEN);
+	if (ret) {
+		err = 2;
+		goto out;
+	}
+
+	/*
+	 * Test is there to appease the verifier. We cannot directly
+	 * access NR_CPUS, the upper bound for nr_cpus, so we infer
+	 * it from the size of cpumask_t.
+	 */
+	if (nr_cpus < 0 || nr_cpus >= CPUMASK_TEST_MASKLEN * 8) {
+		err = 3;
+		goto out;
+	}
+
+	bpf_for(i, 0, nr_cpus) {
+		/* Odd-numbered bits should be set, even ones unset. */
+		bit = bpf_cpumask_test_cpu(i, (const struct cpumask *)mask);
+		if (bit == (i % 2 != 0))
+			continue;
+
+		err = 4;
+		break;
+	}
+
+out:
+	bpf_cpumask_release(mask);
+
+	return 0;
+}
+
+#undef CPUMASK_TEST_MASKLEN
-- 
2.47.1


