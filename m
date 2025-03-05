Return-Path: <bpf+bounces-53399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D2A50D1E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E462B1721B7
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DD0256C71;
	Wed,  5 Mar 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="NUMv7UA+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9D1FC0F3
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209168; cv=none; b=kNT+6LFXYJa8ebf/pi678TTbIl5ThAumhoBoLdBL/YJ20MRDObpOPqeYjL1DUPyV0+wx3lfRSzxyaGc+B7NVffzGhkaLCuBQB9S/eWkvvevoZgHqYwzhdSyAsvCC49n9pnFIUGHd+CfpbbcTw0RPGaUfVomhaT2CYsGvQ3HQXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209168; c=relaxed/simple;
	bh=Q+M7ITeliy4I1QVtUflC9vsSCW+e19xHlw6fwckMuPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqXVojq5OfVwc4FruO3ZLnvJdO2r6vQga17bX9QfJ2A3lW4gnxkUHiRM6xxchUw0SPzaa3qGVuC11/uDYn4RdqpVprf4X8ZwRBUkk5QU2FEUtcuGB+PHTmfJuHlMU6IcL+pwmmsXDUSvXqJQhMdxQJhqmfbWZ8AyOgRazbQlPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=NUMv7UA+; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471fe5e0a80so65282021cf.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 13:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741209165; x=1741813965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptvDvINcrJ+IHiQEaD0ERRof30Fe7KxAOaVsuQI4KFQ=;
        b=NUMv7UA+xcSyM40O5bb3CsLUrToa6SlAmgdeVwZUKz1iW+2T19WWHC4mk3DsjOjT2V
         NDYRbBCpE9Qu8qgQKD6Zk1+2iBmPtzBsFDRWKS6vNA19Rylnq93wHF2dmU5QGvH5+19P
         2mXrwzWyaZ6CDnExZECzuTZv0+ohqB6iFCK3dw7F5HzoHXpfwO+reIgboAZlyLBVTgQZ
         gjjI9CCFFsLfHu4RT703B48i+OCoIaKLa3IJgxobEDoqsGKVvasjq8/KXmTJpYoivjYq
         220WiT/6MbUPuvc3yPHWUpjuaBcp1WwRhDs/+kmQjqcKtNzynIxJaVBdk0gliC00D/Af
         iILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741209165; x=1741813965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptvDvINcrJ+IHiQEaD0ERRof30Fe7KxAOaVsuQI4KFQ=;
        b=bvKL2UNa8Z2KK2QCqkkooB56idzXKbvAikh4nX8vdpiaSBJne/li/pFX5xThBbT/8T
         Ly7PI/X97rHz0AS95LnG1uEYi7Q0KGvIDFBmNyET2zvTYX9IkrvpDTjSJ8Rnq3QJ7I/O
         4le6xblS9My8rHDlJsiZLcQup/Nn/uBDROujQ8Uj5O+DMe4Ebppu6nRibNAq1fzyEcgK
         vpcUmTFdM5iYGvWzMjqO12PrzslOTuybnivqcy6mkOUSE2QhrliUcbx0f989QXFksZsd
         lLJuwg+twTBofL1iDvw0G3J3m9FvbPbHIEQEeI6nvy8zOmAdsuGqktcrS0okN/zowG/w
         FG5w==
X-Gm-Message-State: AOJu0YynZ/4f9KMxt7RASFZh7CzlSk3UYO2YQD2m+L3xTtAPipk7teoh
	4Z6AXuLJxk/RnlR3tzBld+K9ODq0T0gbGrI4An4RQXvGVQHZkwn5lbXslXyEWcPKD+CYBcCfy5F
	mjXipXQ==
X-Gm-Gg: ASbGncvlYqLvreUuo7C9t73rXogZjXOvl0nwWqj9KjJjI4m5NtaGyGHRPf+/VgMSVuF
	KKiZcZzPXbtKg8CfoScxl+G3t47ybIty+3v4VsBULEOubezz/bSyKgFOJX8usJA5fZfDY+wIgOh
	1owt1Y/Bed6zVWASA4bG6SOPmM/+zTa6JynWaoRivylBebxRVAaAiL9GRZeIn/uQ/FD9RssJ1lO
	KhYZ2fzQ83BIONODjnNSZLaaqlvaOwPWZA1pR7WyLe8GLd0r0rLr5H3zva1n/w/7F7on4BcDK/X
	wXspvApctYoCuFMdYoRjgi0CFX5PMZTPz+a9yNlong==
X-Google-Smtp-Source: AGHT+IGIJzAfmdUgm6mfcadFHWNecCdZ9FN/zoctgiLHLQU/A7heuBDNkp5cAto614rUR61sndhfdg==
X-Received: by 2002:ac8:5750:0:b0:471:f08e:d661 with SMTP id d75a77b69052e-4750b4411fdmr80338271cf.13.1741209165241;
        Wed, 05 Mar 2025 13:12:45 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474eced9880sm43726851cf.17.2025.03.05.13.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:12:44 -0800 (PST)
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
Subject: [PATCH v4 2/3] selftests: bpf: add bpf_cpumask_fill selftests
Date: Wed,  5 Mar 2025 16:12:34 -0500
Message-ID: <20250305211235.368399-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305211235.368399-1-emil@etsalapatis.com>
References: <20250305211235.368399-1-emil@etsalapatis.com>
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
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 114 ++++++++++++++++++
 2 files changed, 152 insertions(+)

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
index 80ee469b0b60..5dc0fe9940dc 100644
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


