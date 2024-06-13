Return-Path: <bpf+bounces-32015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B8F90612C
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 03:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D561F216AA
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0959B71;
	Thu, 13 Jun 2024 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHFiH7JP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ADE168D0
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242718; cv=none; b=DFsFa97+dd8wVywzRIzeKQ8941VHRkBObdFxf8/pQ0e+9tqlAM5p3Ezjao1rz5X1NXkchhv08Jk9PWOdSCtyrdV2iU5ryHi9WuIPgaHcfg37FvvWXkHE0HrFBPm3QTXXflyJEqXT417jT1HmTpgid4dEQ3HseRriP3hq+vl7Sog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242718; c=relaxed/simple;
	bh=0C7YFIXX4V6L4MugzHRCmje1MAySHz560R7vtuAISy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEYEkXZzcAjwHT7rPdPIOWS9Q/T0LltbH4R7kKNPf6m9eHIEgW14K9MYzd+6dIylN+UQMpQfh9cWJhiVGb16l0rGqVYHHxmxz+3szoHxjZDxnXLgTCFs8FqfHw7DXJ4HY1SaTSxqMkzRU7gZIE7c7CtCVd/ewCzpjLvbOiTx514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHFiH7JP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-705c7e2d31cso424294b3a.3
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 18:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718242715; x=1718847515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hkdNXD0ldSnRyH//rXl3FD1wqGeU2gjckNjPaQlUqg=;
        b=bHFiH7JPJaXZNevGE+2f3OQ2OyeXXn3dk+Rh3JwjTrIMTEISAN0sbDqZIpK66MFDmh
         fXZC8uEmxLzcva0AoDOpjRNjf8LDYEP0S3wxe3i5KLdJSa4M3tfmaozRMMVPU3K20ZiP
         InW+BQ5qyd1NYJxtK7D7WQbVwfIe6iveuhAIpIJPM+g8HPjbMbfEjtvdoWNPhobfw5wg
         fmxjxHCi6fKCerW0r4ShFu0tE5OHRmRh3dnT5yt+13Bj4dfblhNfgFaU6ng5Cg7q08M9
         oVzTGlkM2sWBFHpoEo9ip8ccC54LR2d5QSmx8MLujHkOh1sf5zWVZyidu5MARzlRlL9m
         BRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242715; x=1718847515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hkdNXD0ldSnRyH//rXl3FD1wqGeU2gjckNjPaQlUqg=;
        b=j1PRV2TiahHeXqSrajjmxBCBzqaYEblmS8hH2ByFqQSbGylURY6uR16s/44EdqjcyO
         onjvGD0PFLoDKApIdZfXxUB7W+mHu2rz0+Ag14ft81YF6bIo7Rs98xilw8lDKyjTybGt
         w6W/CYxLsjX3v4RiYzikF6nGVrSfv+oKnGHPWlL1DnE3k07giycAB9Q8SOTN3t48P7Yu
         inMvklbXQtE8VAHI1/fu765+5tbpER70MKHc81l2zvVj0HSVOXnkM8xsjRIs963c4FQl
         4ERA56Pkd6fHSZ7Dql9zx9i0RgTA8cU5urC+E7gOmPTzIWadOJGKmEo5K9vIwLKhR09i
         IF9A==
X-Gm-Message-State: AOJu0YxiqlPx+RyMlVXcroPNRxZcZvs28wEblm0Y5vmDvjcYHxAWFYy7
	/yUhC/RyhPcXBXc4rsZEqLfKdL1MMWTQlsSfvO8R3yjvzghxbci2FzbAoQ==
X-Google-Smtp-Source: AGHT+IGVJ/g4W+OaG1pLnTH0oRjnOys18OTCN3HlFCUMBRwPKUcOoUDNtRVPkPtkmDhl5OYCJSpAPA==
X-Received: by 2002:a05:6a00:2347:b0:703:ed39:fbb7 with SMTP id d2e1a72fcca58-705bcdf4708mr4158633b3a.5.1718242714946;
        Wed, 12 Jun 2024 18:38:34 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:b914])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91e154sm217999b3a.44.2024.06.12.18.38.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Jun 2024 18:38:34 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 4/4] selftests/bpf: Add tests for add_const
Date: Wed, 12 Jun 2024 18:38:15 -0700
Message-Id: <20240613013815.953-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240613013815.953-1-alexei.starovoitov@gmail.com>
References: <20240613013815.953-1-alexei.starovoitov@gmail.com>
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
 .../bpf/progs/verifier_iterating_callbacks.c  | 236 ++++++++++++++++++
 2 files changed, 249 insertions(+), 3 deletions(-)

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
index bd676d7e615f..53679252e8a1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -405,4 +405,240 @@ int cond_break5(const void *ctx)
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
+	if r0 > 9 goto l1_%=;		\
+l0_%=:	r1 = %[buf];			\
+	r2 = r0;			\
+	r1 += r2;			\
+	r3 = *(u8 *)(r1 +0);		\
+	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short 4; /* off of l1_%=: */	\
+	.long 0; /* imm */		\
+	r0 = r2;			\
+	r0 += 1;			\
+	if r2 < 9 goto l0_%=;		\
+	exit;				\
+l1_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm_ptr(buf)
+	: __clobber_common);
+}
+
+SEC("socket")
+__failure
+__msg("*(u8 *)(r7 +0) = r0")
+__msg("invalid access to map value, value_size=10 off=10 size=1")
+__naked void check_add_const_3regs(void)
+{
+	asm volatile (
+	"r6 = %[buf];"
+	"r7 = %[buf];"
+	"call %[bpf_ktime_get_ns];"
+	"r1 = r0;"              /* link r0.id == r1.id == r2.id */
+	"r2 = r0;"
+	"r1 += 1;"              /* r1 == r0+1 */
+	"r2 += 2;"              /* r2 == r0+2 */
+	"if r0 > 8 goto 1f;"    /* r0 range [0, 8]  */
+	"r6 += r1;"             /* r1 range [1, 9]  */
+	"r7 += r2;"             /* r2 range [2, 10] */
+	"*(u8 *)(r6 +0) = r0;"  /* safe, within bounds   */
+	"*(u8 *)(r7 +0) = r0;"  /* unsafe, out of bounds */
+	"1: exit;"
+	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm_ptr(buf)
+	: __clobber_common);
+}
+
+SEC("socket")
+__failure
+__msg("*(u8 *)(r8 -1) = r0")
+__msg("invalid access to map value, value_size=10 off=10 size=1")
+__naked void check_add_const_3regs_2if(void)
+{
+	asm volatile (
+	"r6 = %[buf];"
+	"r7 = %[buf];"
+	"r8 = %[buf];"
+	"call %[bpf_ktime_get_ns];"
+	"if r0 < 2 goto 1f;"
+	"r1 = r0;"              /* link r0.id == r1.id == r2.id */
+	"r2 = r0;"
+	"r1 += 1;"              /* r1 == r0+1 */
+	"r2 += 2;"              /* r2 == r0+2 */
+	"if r2 > 11 goto 1f;"   /* r2 range [0, 11] -> r0 range [-2, 9]; r1 range [-1, 10] */
+	"if r0 s< 0 goto 1f;"   /* r0 range [0, 9] -> r1 range [1, 10]; r2 range [2, 11]; */
+	"r6 += r0;"             /* r0 range [0, 9]  */
+	"r7 += r1;"             /* r1 range [1, 10] */
+	"r8 += r2;"             /* r2 range [2, 11] */
+	"*(u8 *)(r6 +0) = r0;"  /* safe, within bounds   */
+	"*(u8 *)(r7 -1) = r0;"  /* safe */
+	"*(u8 *)(r8 -1) = r0;"  /* unsafe */
+	"1: exit;"
+	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm_ptr(buf)
+	: __clobber_common);
+}
+
+SEC("socket")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void check_add_const_regsafe_off(void)
+{
+	asm volatile (
+	"r8 = %[buf];"
+	"call %[bpf_ktime_get_ns];"
+	"r6 = r0;"
+	"call %[bpf_ktime_get_ns];"
+	"r7 = r0;"
+	"call %[bpf_ktime_get_ns];"
+	"r1 = r0;"              /* same ids for r1 and r0 */
+	"if r6 > r7 goto 1f;"   /* this jump can't be predicted */
+	"r1 += 1;"              /* r1.off == +1 */
+	"goto 2f;"
+	"1: r1 += 100;"         /* r1.off == +100 */
+	"goto +0;"              /* verify r1.off in regsafe() after this insn */
+	"2: if r0 > 8 goto 3f;" /* r0 range [0,8], r1 range either [1,9] or [100,108]*/
+	"r8 += r1;"
+	"*(u8 *)(r8 +0) = r0;"  /* potentially unsafe, buf size is 10 */
+	"3: exit;"
+	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm_ptr(buf)
+	: __clobber_common);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


