Return-Path: <bpf+bounces-53586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E87A56C48
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF553AF09C
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2E21D5AB;
	Fri,  7 Mar 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="y0+Yfj80"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22A21D3FC
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361936; cv=none; b=PqH0qrNIwmFtb2v8SV6KZIFLsEEqGTYMB3n6cKiIoomIbmF8U+9bFVIJvDTnp3IR5BfGCNeNyys4DfS2teJ3ZbA1haSEDBgHFozW6wSNu4O4tCFgmQGAJGiL+qsPs+L9deMgTwgOdxNAe1K0Nc7z3amZfDycrqc48HRZP3nMY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361936; c=relaxed/simple;
	bh=Yz4wtjJ8WskCqjmGIr/eILoYSlJYWt4hOAx0PxXH4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqnsL8vhtIwZEPvMERiDq4W0NjZGOQg0NWpJ0BV7iEh/CHPwACjmRPWwi376REN9ljQwTxXVt0WCdXFjX062o8dIGcJw1OMl8Is/HOhDgozvhTz7HOcHbRNujH0BA6Lzlq/nutkQXMU9JxDj4IJCsNiAPapo2wyeFIhPvhZXmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=y0+Yfj80; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c3d0e90c4eso311705185a.1
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741361933; x=1741966733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgA91wdVnfJz7wEPNrf8vD1Lf1zdQ0+fTet2NkVOTSY=;
        b=y0+Yfj80OM0Bkk7iV6Fg1hW8eml9E8p1ewcAspuDPfSsmXl/MoTbQKUixDdlOWvJE3
         gQqgzMRIV7V1O+yr69X8svbSEiAkcAiqvL+Cw35MVUGA/YipdQMlq2jDjsngBMI2x0/a
         pSlI8sKYJ46Z6JKbXfvgYFt5qkCWjdaguwSBVzUyj/qRxxi63kXqjZjUbVEZH+Y7Nr9+
         5b7L1Dz4F2bjF6xTbmzrkR63HlJNwHDrAm2PLhcglVvQj46+bJHN9PK0JlVcqXCKCcIy
         t7ZPNbCATEPA68ac/UTfjGO5gPKtMZygXEaGv1IWtbCg+OoNgKVkqtkQaBfKCcdU/V98
         AmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361933; x=1741966733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgA91wdVnfJz7wEPNrf8vD1Lf1zdQ0+fTet2NkVOTSY=;
        b=tB8KosPHdggacyV0i/Dy4MqAYLzGVf6ts40MVMMFORZTLPEvom1iYibkvV1hBS3QnX
         5AUIayMqliPz8aorBzKbzGLZWHFRKiYQQPqjpT/0T8O8ZSNGoNv6+4Nyd+ceBbxn0X19
         +JkxJ53BY84/MnG1YCi11+eLf+qhdM2rA8Parnk5dkVS4FJ4ET7Fhwpf58yzDMPQSX9D
         Hm6sFFJ3aq8W3J8y/KbWJh0idfpTrpkyyq5DgM+S3rALOdGwX+PcqhnVpLQ4onHm7b5K
         1c5rOUfIKMSxRXEz6/FWo9j9JZ5NJceaLuQsw7lBCEVuquhyTHzNk1T2bgDg5yc4Z5OX
         fwJg==
X-Gm-Message-State: AOJu0YzN9mLjqgBRECCOaiaCdIzzZO5epDMo6hvilKc2ZHLyxvVWhao3
	4AZfTwFOFfbN9/gizTXHpKxwSFg+mGaE4/ajvUTvAG+s6daWRs6AUIa0Tc5tPMpVsfbGEQPjmgI
	IkCsJpQ==
X-Gm-Gg: ASbGnctULk3ZGAeCM7O/jkgVK8SCN8GSDVUlMTC88Mil2xbUdqvHBZmsiN/kydG7YLU
	TQHhJhMSVLuRnNbd9UaZKAoDG81Z/loEYOJ4DMt7whH3blw3vEcjLRZLNyGYbYYAYlWqRuaX9Q9
	z5POTyskYlLpt3ziLC14KFke5CoRhokRllMtujDVwJN3ak8A5GE+THr3W4qsqKqpvkPz+J5Uv65
	a6T8S9wmNGHu/+TVX4LFiotS8T2cXF0PWEogfaykB6U9ufewgPsY6eBB0Fpg5ctLtsf7p9UAcJ/
	oYsubH5WiFiNLHDHjaZaKQxWrjC4qUrfzkHyA4eQ4A==
X-Google-Smtp-Source: AGHT+IHGt3pFuS0EJWGpciHaAXngqLRbwhl8JlBStm7wHITpoVo7l3BBzP2dNUOuLYGaOTfYlnQNZw==
X-Received: by 2002:a05:620a:890e:b0:7b6:d273:9b4f with SMTP id af79cd13be357-7c499ba6b04mr628708585a.11.1741361933075;
        Fri, 07 Mar 2025 07:38:53 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511c63sm253828585a.113.2025.03.07.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:38:52 -0800 (PST)
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
Subject: [PATCH v6 2/4] selftests: bpf: add bpf_cpumask_populate selftests
Date: Fri,  7 Mar 2025 10:38:45 -0500
Message-ID: <20250307153847.8530-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307153847.8530-1-emil@etsalapatis.com>
References: <20250307153847.8530-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the bpf_cpumask_populate helper that sets a
bpf_cpumask to a bit pattern provided by a BPF program.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |   3 +
 .../selftests/bpf/progs/cpumask_common.h      |   1 +
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 110 ++++++++++++++++++
 4 files changed, 152 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index e58a04654238..9b09beba988b 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -25,6 +25,9 @@ static const char * const cpumask_success_testcases[] = {
 	"test_global_mask_nested_deep_rcu",
 	"test_global_mask_nested_deep_array_rcu",
 	"test_cpumask_weight",
+	"test_populate_reject_small_mask",
+	"test_populate_reject_unaligned",
+	"test_populate",
 };
 
 static void verify_success(const char *prog_name)
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 4ece7873ba60..86085b79f5ca 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -61,6 +61,7 @@ u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym __weak;
 u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
 				   const struct cpumask *src2) __ksym __weak;
 u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym __weak;
+int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src__sz) __ksym __weak;
 
 void bpf_rcu_read_lock(void) __ksym __weak;
 void bpf_rcu_read_unlock(void) __ksym __weak;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index b40b52548ffb..8a2fd596c8a3 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -222,3 +222,41 @@ int BPF_PROG(test_invalid_nested_array, struct task_struct *task, u64 clone_flag
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__failure __msg("type=scalar expected=fp")
+int BPF_PROG(test_populate_invalid_destination, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *invalid = (struct bpf_cpumask *)0x123456;
+	u64 bits;
+	int ret;
+
+	ret = bpf_cpumask_populate((struct cpumask *)invalid, &bits, sizeof(bits));
+	if (!ret)
+		err = 2;
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("leads to invalid memory access")
+int BPF_PROG(test_populate_invalid_source, struct task_struct *task, u64 clone_flags)
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
+	ret = bpf_cpumask_populate((struct cpumask *)local, garbage, 8);
+	if (!ret)
+		err = 2;
+
+	bpf_cpumask_release(local);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 80ee469b0b60..23ef2737af50 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -770,3 +770,113 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
 		bpf_cpumask_release(mask2);
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_populate_reject_small_mask, struct task_struct *task, u64 clone_flags)
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
+	ret = bpf_cpumask_populate((struct cpumask *)local, &toofewbits, sizeof(toofewbits));
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
+/* Add an extra word for the test_populate_reject_unaligned test. */
+u64 bits[CPUMASK_TEST_MASKLEN / 8 + 1];
+extern bool CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS __kconfig __weak;
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_populate_reject_unaligned, struct task_struct *task, u64 clone_flags)
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
+	ret = bpf_cpumask_populate((struct cpumask *)mask, src, CPUMASK_TEST_MASKLEN);
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
+int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
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
+	ret = bpf_cpumask_populate((struct cpumask *)mask, bits, CPUMASK_TEST_MASKLEN);
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


