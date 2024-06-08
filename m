Return-Path: <bpf+bounces-31629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05CD900EF8
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 02:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DBE1F21FC8
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 00:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679CD8BEF;
	Sat,  8 Jun 2024 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzvE7YeV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA13233
	for <bpf@vger.kernel.org>; Sat,  8 Jun 2024 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807508; cv=none; b=W7i9yohRX3aEdyJf4OIXnrSNO30NIf+Ummj0EEb2tk/RYwCrbf02a5JB9Cija7A9GQcQsEzLXEISzKUTGgC91/nXsgEd7EOYS/Rj2TxqCenakYSGWczn2UlvcXgl5Dzs7aBhgrjyMqYJpmTFHFLM0ZSKG4rRbjNK8rcZ58AcxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807508; c=relaxed/simple;
	bh=svYUJxRLhK+Ar/Pb0aXx0A8My+1JrYoxvxWKJTuxCwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdLTHMWV+2nnRwpBk4EkqF6ubaUPf62HGwAVfcs3KWB8LO1BkZEoVgT0zPzurkTn+8Bjlu9R/6oeWlhoCJuYRiZ5Kvq3+hS3GjinDZqirJiXgD22rhKhha4tqz6XoNyvXuI4nxuExB1o3jimJ+77ks7+bZrBt9OUG3WPFMyU5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzvE7YeV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6f1677b26so618575ad.0
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2024 17:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807505; x=1718412305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyB3X3azGpw+Z0mg2bBe8ODTsijUAxM9gasrro+/apc=;
        b=RzvE7YeVYdpnpGsvGzZFhEvWdzSRrGKnRFu+eD8ctj9itegR32Gno7kUuXHE5R6nia
         j+YNXJmWodEoYdCj3UWgxdzSZLEQZXjGqTfe0IBVn/GGAE4tcyxYz0Cdpm3IaAnPNjBS
         1yW7gg0Bsej9JeOz8nIX0LOzugifdorANe2Ytt8yUPhZ1JDUooA4+bJDAQm1qOfi3oc6
         LVO5v+wl7nEnV8m2en0C6ZNJ60WEAypK07m2oLd23hdYQvbEICVdTwgVLNnMnMvqDv/s
         3rQsu8qlHa2gMDKrL2kzXIQtGyJrm3BeQY2tMVMH7G2KmR24WMShpSFbB+ajExPEsFxg
         Xe9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807505; x=1718412305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyB3X3azGpw+Z0mg2bBe8ODTsijUAxM9gasrro+/apc=;
        b=gftS5HTENpBQbMc96C9IIm359ee/rW37/oHG2Hroe+BdpaK3iQ4hjs4bFX2a/ZXaV9
         JbSZ9TqrXeBcSDE3mW8G0G97ckWOJ4XsZX4/o2pbPBiBwmUW9uX1XJ45jLDukfmGldA8
         jp4HDhhNUBFQYC9wJKf96VVCXDprxCfI9/gHFt9K5ibI6bOIsH5+git3ZY3+w5LlGr+5
         keHnWR5KkyZ8uPtEyFqyuc145dIHroTITTkxT+7346KF383XlmGWAsO24egkp/8TXyTR
         I9LTm+D6c6baa+7Tth1S5/IxXsSI5jkeAwBasUoAIwztl+Kl/AsOb70gd7bWyk18WK5/
         kBpQ==
X-Gm-Message-State: AOJu0YwTjN4JwvLfCT4HNlXQGBPzCHsv9umfKo3SYESM8wsEbVwu5ykC
	wiAQqgTGn03MvqyNN6/sqRkS+uNpnYhIciV1wBavqxi4ujeiIqDcNXuTOg==
X-Google-Smtp-Source: AGHT+IHvLACCDF/mL4R/Bg5fDwJ4F2Rm/RgcovSWkO0x/NcnqfkFIH6g/I7tUu/UJirFLCFKNPix4g==
X-Received: by 2002:a17:902:cec9:b0:1eb:7162:82c7 with SMTP id d9443c01a7336-1f6d0154d0cmr63828335ad.18.1717807505275;
        Fri, 07 Jun 2024 17:45:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:81a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ed6desm40645115ad.243.2024.06.07.17.45.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jun 2024 17:45:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for add_const
Date: Fri,  7 Jun 2024 17:44:46 -0700
Message-Id: <20240608004446.54199-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Improve arena based tests and add several C and asm tests
with specific pattern.
These tests would have failed without add_const verifier support.

Also add several loop_inside_iter*() tests that are not related to add_const,
but nice to have.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/progs/arena_htab.c  |  16 +-
 .../bpf/progs/verifier_iterating_callbacks.c  | 150 ++++++++++++++++++
 2 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
index 1e6ac187a6a0..cd598348725e 100644
--- a/tools/testing/selftests/bpf/progs/arena_htab.c
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -18,25 +18,35 @@ void __arena *htab_for_user;
 bool skip = false;
 
 int zero = 0;
+char __arena arr1[100000];
+char arr2[1000];
 
 SEC("syscall")
 int arena_htab_llvm(void *ctx)
 {
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
 	struct htab __arena *htab;
+	char __arena *arr = arr1;
 	__u64 i;
 
 	htab = bpf_alloc(sizeof(*htab));
 	cast_kern(htab);
 	htab_init(htab);
 
+	cast_kern(arr);
+
 	/* first run. No old elems in the table */
-	for (i = zero; i < 1000; i++)
+	for (i = zero; i < 100000 && can_loop; i++) {
 		htab_update_elem(htab, i, i);
+		arr[i] = i;
+	}
 
-	/* should replace all elems with new ones */
-	for (i = zero; i < 1000; i++)
+	/* should replace some elems with new ones */
+	for (i = zero; i < 1000 && can_loop; i++) {
 		htab_update_elem(htab, i, i);
+		/* Access mem to make the verifier use bounded loop logic */
+		arr2[i] = i;
+	}
 	cast_user(htab);
 	htab_for_user = htab;
 #else
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index bd676d7e615f..a87100bf3862 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -405,4 +405,154 @@ int cond_break5(const void *ctx)
 	return cnt1 > 1 && cnt2 > 1 ? 1 : 0;
 }
 
+#define ARR2_SZ 1000
+SEC(".data.arr2")
+char arr2[ARR2_SZ];
+
+SEC("socket")
+__success __flag(BPF_F_TEST_STATE_FREQ)
+int loop_inside_iter(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, sum = 0;
+	__u64 i = 0;
+
+	bpf_iter_num_new(&it, 0, ARR2_SZ);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (i < ARR2_SZ)
+			sum += arr2[i++];
+	}
+	bpf_iter_num_destroy(&it);
+	return sum;
+}
+
+SEC("socket")
+__success __flag(BPF_F_TEST_STATE_FREQ)
+int loop_inside_iter_signed(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, sum = 0;
+	long i = 0;
+
+	bpf_iter_num_new(&it, 0, ARR2_SZ);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (i < ARR2_SZ && i >= 0)
+			sum += arr2[i++];
+	}
+	bpf_iter_num_destroy(&it);
+	return sum;
+}
+
+volatile const int limit = ARR2_SZ;
+
+SEC("socket")
+__success __flag(BPF_F_TEST_STATE_FREQ)
+int loop_inside_iter_volatile_limit(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, sum = 0;
+	__u64 i = 0;
+
+	bpf_iter_num_new(&it, 0, ARR2_SZ);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (i < limit)
+			sum += arr2[i++];
+	}
+	bpf_iter_num_destroy(&it);
+	return sum;
+}
+
+#define ARR_LONG_SZ 1000
+
+SEC(".data.arr_long")
+long arr_long[ARR_LONG_SZ];
+
+SEC("socket")
+__success
+int test1(const void *ctx)
+{
+	long i;
+
+	for (i = 0; i < ARR_LONG_SZ && can_loop; i++)
+		arr_long[i] = i;
+	return 0;
+}
+
+SEC("socket")
+__success
+int test2(const void *ctx)
+{
+	__u64 i;
+
+	for (i = zero; i < ARR_LONG_SZ && can_loop; i++) {
+		barrier_var(i);
+		arr_long[i] = i;
+	}
+	return 0;
+}
+
+SEC(".data.arr_foo")
+struct {
+	int a;
+	int b;
+} arr_foo[ARR_LONG_SZ];
+
+SEC("socket")
+__success
+int test3(const void *ctx)
+{
+	__u64 i;
+
+	for (i = zero; i < ARR_LONG_SZ && can_loop; i++) {
+		barrier_var(i);
+		arr_foo[i].a = i;
+		arr_foo[i].b = i;
+	}
+	return 0;
+}
+
+SEC("socket")
+__success
+int test4(const void *ctx)
+{
+	long i;
+
+	for (i = zero + ARR_LONG_SZ - 1; i < ARR_LONG_SZ && i >= 0 && can_loop; i--) {
+		barrier_var(i);
+		arr_foo[i].a = i;
+		arr_foo[i].b = i;
+	}
+	return 0;
+}
+
+char buf[10] SEC(".data.buf");
+
+SEC("socket")
+__description("check add const")
+__success
+__naked void check_add_const(void)
+{
+	/* typical LLVM generated loop with may_goto */
+	asm volatile ("			\
+	call %[bpf_ktime_get_ns];	\
+	if r0 >= 10 goto l1_%=;		\
+l0_%=:	r1 = %[buf];			\
+	r1 += r0;			\
+	r3 = *(u8 *)(r1 +0);		\
+	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 4; /* off of l1_%=: */	\
+	.long 0; /* imm */		\
+	r2 = r0;			\
+	r2 += 1;			\
+	if r2 <= 10 goto l0_%=;		\
+	exit;				\
+l1_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm_ptr(buf)
+	: __clobber_common);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


