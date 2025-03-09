Return-Path: <bpf+bounces-53695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97781A58910
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6913AC42C
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 23:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DE8221D82;
	Sun,  9 Mar 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="06jh5oW9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DA2206A4
	for <bpf@vger.kernel.org>; Sun,  9 Mar 2025 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561489; cv=none; b=asW6kribSiIWDu8vNjiMoARSqPH/WxnOS4s79Cz+Bem1tkAZVY3U1Ph4qdRBAYxeOoQYxke2WtLOVavorLJP9QjAS4oa8wC/HyBp8eClyzLUTbnDWPJoAG4i1N6+4/c1urrEG+rYB16imgCqy+wfa6G9uPikxvp/5aiNlJUId8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561489; c=relaxed/simple;
	bh=B1Ts3RFnvd7sP8BnN7j00rucYAJ1GW48PEDhnrgDrTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/cIcbWsReVXYhjR7luCf58X+SiuATV6Djf9SOAPA/hnSnG6HSXcH80ydZMeeaFEKJse1wgV9+ZaAA1ZeJGLVorMNotqbPLwNWYSXfJSyLDE6lB+WCG0nrigynwt6m9x/Z2+bxOjyL/vvI4Z4kyBLEpkWvnOyFmwaWWj5ZqwSlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=06jh5oW9; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e6c082eac0so34461186d6.0
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741561486; x=1742166286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kK+kB63E4L8qm5QpB6MpkQEVbLcpOKPBjkoiww7ogI=;
        b=06jh5oW9RLii92krsyOixWTti5yKYt/MeRC7a4/0d5Vzfs9LCAqXVIlSiTb1Z0vgyu
         v/58f4VUmggcVF6ueJIBo1n0ka8/7tgMvwRzq86pnk4I2DErmQkJcpmgZgffQFodsA4j
         Ns9jdGyQOoY5zFLF3U7zmgYgeSCmqRM1o4GAtyCTZEgYKLcB8AhdUC5ig8IJF3Td/0Y5
         mAbFw18kAVCFMfFb7uL6CidGENyArnNlL4Mi5hTq0JzganFTlQKXf7ooO18yIRUr/PA9
         elwPFqElhVWOfN+m2UJwedbyJmvTp3q+0N8kUWrwqXR0lu4WnvQpL3gn9QjjUWdk9Qkq
         2JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561486; x=1742166286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kK+kB63E4L8qm5QpB6MpkQEVbLcpOKPBjkoiww7ogI=;
        b=BCFdhRDTgfLzM9ZsEg83VieQcpZw/zYex4mdtqFkxE3tIBav/G0kD9mYTb9runPlUM
         /SeWXpfJbvL0jtd0I8P6C7yXIckToiSCuQ05r1thMqmuFi4imz8JEndPlfEqJinZO8X9
         Gf7Av1D6VAyBjIcQ0nYSaSXfeNJ0APurlZzF82EfmUU9DF75rGCFAKCrypU2SwcKnIRN
         fDejVTTTWN9aLkyHEvk5DqEQ14mDvb2KqXjk3xDnTHOqmCWsAa0/Tuj7zlm+IUQKGiRJ
         3BmvHRX3UYI0PKe3k7xmLzn0svNnCMjJruvkje9HtplZCowi2s2uy7jRIPFAhNvQ8eq+
         xt1w==
X-Gm-Message-State: AOJu0Yw3y4lZie0OhOFDGLvKcu2TW1ZY5/zLbz/+Ry5Nq48BbNkpjsN7
	qZDb3cFR68ydTYCldqTsi/WDnqJPQp1BNzy2TM+ktoHnugklxO/odgHHRL6hzUzWjq7xn/FkPmi
	JxG50zw==
X-Gm-Gg: ASbGncswClx08b+0eZBIcZPiQg/75c0f4SNGO9VFNisbnnzz51fu2p8k7i5RUeu/nym
	UwH0yiD/qJ/a99I3+6WyauJcIzBYwtVhiKdU0cZWxYJYgP3Rf9zF5L+r7k5IbNmqLBcQEpVms90
	VY1mfjOU7bidK2Vbxj1KJQidKV2kxTgcuXThE4oSYMgLY+qwYrr1+nruqOxsQwISUPAI7VrrZbu
	LsfCdE0J8K5peAptlrjROkTRGcCEh4mrilXy0THQPNxJoKgMe/nkD2AYnFZ2+bWBfREtjxdg/S/
	ZgIF2o5j8RboqgCed7S7R6iUb6BnzVdj/ZmW+mansw==
X-Google-Smtp-Source: AGHT+IHSs55FCfEJQydq1wT07nReP+EBf73VenyljajsmIUrQgbC3MXXxaqgoKoqTjfb94/pDoiI0A==
X-Received: by 2002:a05:6214:19c3:b0:6e6:6252:ad1a with SMTP id 6a1803df08f44-6e90067731amr153719986d6.28.1741561485970;
        Sun, 09 Mar 2025 16:04:45 -0700 (PDT)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e9146790casm14378406d6.55.2025.03.09.16.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 16:04:45 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v7 2/4] selftests: bpf: add bpf_cpumask_populate selftests
Date: Sun,  9 Mar 2025 19:04:25 -0400
Message-ID: <20250309230427.26603-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309230427.26603-1-emil@etsalapatis.com>
References: <20250309230427.26603-1-emil@etsalapatis.com>
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
 .../selftests/bpf/progs/cpumask_success.c     | 119 ++++++++++++++++++
 4 files changed, 161 insertions(+)

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
index 80ee469b0b60..91a5357769a8 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -770,3 +770,122 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
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
+	if (!is_test_task())
+		return 0;
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
+	if (!is_test_task())
+		return 0;
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
+	if (!is_test_task())
+		return 0;
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


