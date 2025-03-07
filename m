Return-Path: <bpf+bounces-53533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D487A55F48
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 05:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903953B32BB
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 04:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9A1922C6;
	Fri,  7 Mar 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="SRk4VEGS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82818DB1F
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741321065; cv=none; b=OI8oHCUQ4pG6hKiMiTcUM4iF0hAY2U23OkDkrfTQ6pxzEuwqTulVhOwMGdTwRofjyBYNXv6zwFJcqow3dKy8sdsteX6NGcwKGFApG3zkwv5/AnIG9DtJooU9sTErY+tUjp5cb3ZLPz8HAf8yglIcdNuyTvG4D14ax0cLJkX6noY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741321065; c=relaxed/simple;
	bh=YDT7Sh5v0Yam1nCsPKADYKKn5PY6M0j+JaCuzRJ6Z2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA21sUKrgj436CSF1wus6sGzkHIEtoc0xI+I579J9B0I9nhebNcpGK1WCaxvBCLw3TkAe4CpIQ3Jh/GKWoI1HPaNbuzNm9UAlE3nGCdBQGy01K6FT1z5P4uSUxW2j0e1xkELYxkwYRLpHWD5KRV1KbDTfA2ArY71TqgpXgJLT20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=SRk4VEGS; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be8f28172dso100277485a.3
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 20:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741321063; x=1741925863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0moReXPNjWc8b1AJ5JBr9O/f6u0316M//hylR1kcV78=;
        b=SRk4VEGSkg0FOcY5Eqx2i3CHyXoinm4v2Us4Beg1DFYfviLTZIj6hMYdwy2Lx41j0E
         dJGEwdxu6MS25/kMW82PqcnjHdJiyvHphV6S9OIfXRNVoFZW0W4kjE5Ly4kQPo9+cvVF
         ceVD5Yki2Go2UckDty6sZApkhUlr7F5yBGoJ1I2u2wNCZIo0pK0iWdj/RM12RnJtK+YB
         quPrjPbTZ2Y6Kt2KcYtZwBmWPbOzBDDY0BONUdn58OHrXrtVGsRyLG7aegR+yk4TxRcI
         ysKokzXgM4xclaz9RTI0v6x8khYNxf6WSCAmNcuav3jo0Xmlu11w4PVf9Hwwmh2+VzQu
         6+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741321063; x=1741925863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0moReXPNjWc8b1AJ5JBr9O/f6u0316M//hylR1kcV78=;
        b=sOVtDDksrTSIaHGTaMwUV/0swo8HJx0SsY5KFeuEx1MW/DuMsT8JWn+r2yS43J8r+z
         x5p0+QGv7TADW+9bj112BBF64IW7pbZkBqvRUv6/MjUzjS7fiyJ8w7zlTEU5H2mIj45d
         9Ztp/ha5D66CsFuUFDAcjYYoMa/Uxb9MGdbjeRGL6x1yDOMWsTX6007acCv6Z6evqj8V
         GDkRnAYyAppkmv+WMRaPD3tmSz7UnaIhqi95qmEwkrDid44pKcCbHJfO5DDAYqw2Acn7
         YY//EExokLU/f666shEgPS9S2W3DYqVkbhzHeU2rMlamyfJfdv6FdMmp/Qp46AmlTSxf
         lSjQ==
X-Gm-Message-State: AOJu0YyM+8AyTs6c3ud8H8FCXX+JE+O2+UbpUuJ6PYxIYWiQpoNRiJiq
	tkPlIQQMeW0y+9WbusV8Ms5qnmy4Z/cAcoU3Vwt9gklPfXJZOgf66zNxaWygMqgwLtr+c3EvxsC
	yFTmC5A==
X-Gm-Gg: ASbGncv73x3kTqT7WGnRa48A7IuqUUciZjnt6op6bw6+5I64jckvrruaPpZxqHPw2p9
	qdJlcDo77VsjA9ecitrCDu6syOcyYh5Qc+/eVEJhdXiN9+f0HpCpE8J6qF9RyLgtftjSlIkEw54
	orK1pk6QS6etTyiwqqB9trd3UHem0BpAzoIwP62sFxSCqEK/QEEkjeMdTvmhprxHDo8Wl/mycBM
	pdFz1jchBYp+WLHeVAE+vk3IZz9682XpZrDOFSwNE6JbguT1LDOGKg9TXoe/IczpJSJ22wZj/s1
	uIzmS1q5imxXrxSbutdzKMLXCZYC0k7aUgO+G9p9vw==
X-Google-Smtp-Source: AGHT+IFmCZWdyicH8Entbh45gKW4XWo63dJBsvlOU3L3o43nERh/2c3rMcc/sSAQu5A9kzEO8wJ4mg==
X-Received: by 2002:a05:620a:2694:b0:7c0:a63e:4622 with SMTP id af79cd13be357-7c4e610a1c9mr291687585a.31.1741321062504;
        Thu, 06 Mar 2025 20:17:42 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534ba85sm186108085a.28.2025.03.06.20.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 20:17:42 -0800 (PST)
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
Subject: [PATCH v5 2/4] selftests: bpf: add bpf_cpumask_fill selftests
Date: Thu,  6 Mar 2025 23:17:36 -0500
Message-ID: <20250307041738.6665-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307041738.6665-1-emil@etsalapatis.com>
References: <20250307041738.6665-1-emil@etsalapatis.com>
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
 .../selftests/bpf/progs/cpumask_common.h      |   1 +
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 113 ++++++++++++++++++
 4 files changed, 155 insertions(+)

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
index 80ee469b0b60..51f3dcf8869f 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -770,3 +770,116 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
 		bpf_cpumask_release(mask2);
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__success
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
+__success
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
+__success
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


