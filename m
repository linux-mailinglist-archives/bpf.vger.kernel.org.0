Return-Path: <bpf+bounces-31762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C2902C3C
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 01:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B6F2855CA
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4755315216C;
	Mon, 10 Jun 2024 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VafnmNlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522E1514DA
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060952; cv=none; b=cHbAvlOpRzDJmshWpygB6mDGgvePNQ7OJK4DfautyL5QNO3QyPHroH2OtalkXL9xcGAxzFlJoDMRS4Ld/5I+fN3OsULpx4aaAbfNKTDh8VHYl10souHZPvDCJKeFg+qkJPydAfUCC7Mo2hjlrc3PeV5EXPHuY8/7lNw9PjKm6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060952; c=relaxed/simple;
	bh=CR6Vcz3d7+0UOj5jXKBGi2AQMLu9XLFckpySJup0ttU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJwQQURHNFIdmIBE0YsG3wIFjKa4dfVP3PDmZbAw/VqNxgBFp4ef1VogZ9pTWV6FPAgY9b54Wf+E3e5cf/z6Sdzt0PoBr+0h61gvI/dbqo7vM5UKsjYv5NTIIZjJGhWstsWicpc4Tthr6RkZABBNyjFdpUKG32ZCxM3JZUrNXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VafnmNlW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e620302b01so2018677a12.0
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718060950; x=1718665750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV7xLjOpWeGHh8giULo8MXA150fQenV1ODSbku6laFg=;
        b=VafnmNlWjqrRm+zR0HqU04l7lhhgdODU80ahE9dZChbQAfh8DMNSWGIWgzLIVbWgVL
         U7bHgu1Hy/BPGXLv86v3Vfm+3t+PeVFL1HGpVGeVAPV24ysksD34HTiwGZKZdo/t4RHQ
         dX7o/MrVgv3NCgug0X1aV4USoaLd4bwP6gFet8ZtMGQoMrHnTvwefTnoKOMYikPLwrTw
         MUOan3IN4GgRGbZTAqYIkOQ/qmnvJvk2Pq4Pw0+MwTKlqIxkJz0dIdqlbzwMJmn/AeIU
         0UDAjxQpAC0B8OKGdsC1HoW6QutofFV6Rs1sHW9HTIz1/qhi9xQdhqEnu4sgGVpzRvft
         ASMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060950; x=1718665750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kV7xLjOpWeGHh8giULo8MXA150fQenV1ODSbku6laFg=;
        b=BdrKze0UVQpWtomJHvIyuoNke5D3HW5vhx/Xs0sYQniwJYsuPD5qGVJ+pnACNEiGLo
         EXdx/Qy53uDEqHnTbTQQCYe38dM0YGFgtx09mi0fOXQ7c66SQQimwy6o4x3QOEl8q5Bh
         JN3n0YKPmI+IrfhE5Z5LDcJ8594I+hXYEP8Z7/y4kAXeXwKhV8VmsQ7gc/w0IJVI481B
         Ltb0g9zb9L1bXEb7GSjdZ3eWQSIlSdrqRh6d1Qos4Pxe3w8BE+jR9E6LR6zJN8mqnqqi
         FDz8tcneLmtL6bwDGQOnk3X0mMXnZ0VZoeM/JQU9+wtTLSD6vjpzk64/6kh1OyRwC8t5
         IbEA==
X-Gm-Message-State: AOJu0YylyGoYhm7dX1cVtm14S9NaPHFFZpkLS3y426c9aaCcfTaeoYer
	TbOMZa06mx3nkaJlnhhpt9EasLXrdctRizMocqUmIqkLke1lmayGwa5Rig==
X-Google-Smtp-Source: AGHT+IFNWrpnpPm74DZExxk/+SjsSMMj/XVHlnNIkGWuEzoGbMV8ys9F63yYz2uDuEl+5FCp6K3jrQ==
X-Received: by 2002:a17:902:e802:b0:1f2:fbda:8671 with SMTP id d9443c01a7336-1f6d02d6275mr114340185ad.6.1718060949754;
        Mon, 10 Jun 2024 16:09:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:cfaa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f2e8sm89748925ad.25.2024.06.10.16.09.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jun 2024 16:09:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: Add tests for add_const
Date: Mon, 10 Jun 2024 16:08:49 -0700
Message-Id: <20240610230849.80820-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
References: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
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
 .../bpf/progs/verifier_iterating_callbacks.c  | 208 ++++++++++++++++++
 2 files changed, 221 insertions(+), 3 deletions(-)

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
index bd676d7e615f..627b7f0ca8e1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -405,4 +405,212 @@ int cond_break5(const void *ctx)
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
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


