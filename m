Return-Path: <bpf+bounces-53275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2838A4F475
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FFA188C878
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC86155333;
	Wed,  5 Mar 2025 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="VX7HmHQG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E613D279
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140659; cv=none; b=uP9wA4YmzIk0/5yLsfNT+wNBuPdym5owiDUibgueIolgBs4yny0bJhYCDXRZFvpi1dK19K02g27Ep/1kNt7y5K6nRadZFiN7hDF7R/6VuB478w4V3Kis1I5QXbZ4pdv1tDN7kXq6dla8alM0ZS9Edx3IoIWjOsOxIY4beCxIt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140659; c=relaxed/simple;
	bh=pj7Co+DzVazB6x3jULnLCjGepnWzkrz6b92QvaACqp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP+fuIGeeVUDKcliCu64+9xhg/zM1njYwFpJQKcGkwSU11cLaerteBT8rppRpmvi/gM+bknh1Y4OGYYv91l1GSbURisZTARtTNCT0TVU/tcYrFQ2C+NcWCMMYiKuVWWUVNhGnUQ+S/gCXM/7vDXFXqIG8fTw7bXa/dFekkvw0+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=VX7HmHQG; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e891e447dcso67943676d6.2
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 18:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741140656; x=1741745456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+jAiwiNxeDokUC0tjgjWFxaAsWjihSPyOQw6J7xLiI=;
        b=VX7HmHQGi2BwoBkYh2vz4y2iDyLH4edD+0ZEcQHh6EzvM1Tuk/iaHG0gwUk5S88HN8
         UhzgsRtkptwgtrDmZXUeC8Xfo7kqR5mgkBSu5ySvbDRlBCd0XZcNIqn5942f4SA2Ijt7
         ++7fif8TYK01KDd4dD4BcnE+MzP35LY+M8bAZcxDDOqnUER+r4Jl+ZDL5rT5LK1iQ+dP
         LxmMgu3CsCcxYqewmcrjj+yAoo6IgTat6iSosuMyFpLF0UIElxdAepDcgt6k5dxV2vuO
         z/LNeEnB5EWdwvOaT7y9BDph5fP8JiFe04Ra7Cwo6/4QS9ibIQoZ7PY4o7m1huLeI3Mo
         dI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140656; x=1741745456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+jAiwiNxeDokUC0tjgjWFxaAsWjihSPyOQw6J7xLiI=;
        b=CO40x64+PQCluLu+kEeRCQFF9uei/yOpbAmIrlGV5dCXKURbWA5ufkvP3kgAtHFkWx
         rNYLvFV0k43lmwihiRCnH6QhuAhafPr+9IHU2+m5pzboyF8QzEw9wVmi2YGR9dtFKD8/
         FHajLS9eUNoDymb+VNmDvdDmJAm62fGHabcZuriSztYf68KmoesjqX0adwwMhJ6ktXfl
         VNwVTeeCrX6X315G8CtRhM1FLESvZuGO5Bb9kkZXcDA95kkAufQF/me1DoaykO3bz6fw
         D4iYOdBGKF/+EVP5oYVxNzL/OY+QUkVs48f1C7g7OMp4bE0Hf4qd/D9SZUpj0wqHqUyt
         Uqqg==
X-Gm-Message-State: AOJu0Yxr9Yi80BPXAjFM7h6nW/77NL996Ut1WyDYHWoYLV66VBLVr6T5
	7ZrDYBUA1FYf7/TlbgBsotjERvTwxc1+OkoOwWYXPrIF068m1rNop3tit6H+ef4HoCVDukNCPHV
	qriuP1w==
X-Gm-Gg: ASbGncuEdnAHVK8Ql9IMm9KA2YBf3k+iUBSwt506YI6hgxxioqjqiE4nrDIUyc176rn
	vxqDYoDASPI+/8fnNmVQKKJEBp5E1QX4rn4zemEZbpKKbfOhgUxICEG/JfYdtdHNYle4kebF++Y
	hPoo8AOMi41Wg9nwCp387xO69SEah+d8wH4LF198fA4VySbffLGds7xyamRKQ3QPpS4ZnTcW8Mm
	WKiwW/as+WwNEEfHUNx9a4bMmZ5OyQYgWjIYBxUbzTZDrnLmjJK+bn+So0XEd1kdP4lSllEPtdt
	RlKXzNUZBAZXo6ixqwm8Nw06nxnViltZcXALJJY8wQ==
X-Google-Smtp-Source: AGHT+IHpJdSqmtFhfjnAavGIcrpbZCwqbhzCx5Cis4dVPOSxrJYkhW4W+GUOh0K9NKizFBNe0rY74Q==
X-Received: by 2002:a05:6214:4110:b0:6e4:2dcb:33c8 with SMTP id 6a1803df08f44-6e8e6d357f1mr18577416d6.29.1741140656340;
        Tue, 04 Mar 2025 18:10:56 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec158sm73622826d6.119.2025.03.04.18.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:10:56 -0800 (PST)
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
Subject: [PATCH v2 2/2] selftests: bpf: add bpf_cpumask_fill selftests
Date: Tue,  4 Mar 2025 21:10:20 -0500
Message-ID: <20250305021020.1004858-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305021020.1004858-1-emil@etsalapatis.com>
References: <20250305021020.1004858-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |   3 +
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 109 ++++++++++++++++++
 3 files changed, 150 insertions(+)

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
index 80ee469b0b60..8f782e929af1 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -757,6 +757,7 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
 	mask1 = bpf_cpumask_create();
 	mask2 = bpf_cpumask_create();
 
+
 	if (!mask1 || !mask2)
 		goto free_masks_return;
 
@@ -770,3 +771,111 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
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
+
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_fill_reject_unaligned, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *mask;
+	char *src;
+	int ret;
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


