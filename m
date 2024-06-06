Return-Path: <bpf+bounces-31474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7938FDBBA
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 02:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CCF1C22622
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 00:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116117C6B;
	Thu,  6 Jun 2024 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyJ8LC4E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620BCA6F
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635280; cv=none; b=aSR6g6pJayK/vljuYhin9qkYIBEMhgn9hZXaOe8mHZC1tf/TcbxGIsuE5CuIsIAQipBaYHJDzDZBz9WoVy+rB0+r9+HG+g+TNxd6NmXKH7nh3q+b/Po1diV2Qo3aLCY+5xmhaM9w8lFBuBpbCC6fySmd0UjBn/C/VOTxm88wYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635280; c=relaxed/simple;
	bh=AigEvTHh5GOHYNsAyGpVuWw+9jjwcnIKpIg8aOViBeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9fnb7kc9tbdsuf/wVw7UrUICGNc1zd7xu5iPXZss/1NqDYM1AOtlY59wctX71XJ74EJlVf4SJCbvDu+2RbNhMpwC3cvUT4HwP7JSSqkZ9wbCUdKaLm87nDy3Bd1rnvANLW0tEyCh4sHL8q5MwWLS4H+QBzC+B53op7aYlITBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyJ8LC4E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f62a628b4cso4102555ad.1
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 17:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717635277; x=1718240077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au0JZM8089E6OMtbjux3svk8IS/Bbe7byT/O6JMDcm0=;
        b=DyJ8LC4EhAqN4hjad/4yR9QufbVoGwvTXXC6tbvb8ubonBkOsjBVT3WFtld0qcn2h7
         xz0oIYCMUYBb7ew911Yud5y54LatCQNZnwH61NXypDG02gcVsAFPOLZTxLyQ4l1n5MVY
         JBacxd7xG/4wofxGP6UeVuIccQsPyaf3E0CZIKifKuyil2ZLqtR//H1zIsKE8xjt8Voq
         GNICzbjlyhpYORidY//lMmHP78Scs956FIFK3lArGDh6Zl+dnB8/u9yJegPFy0IKTxIv
         Y0IQAzV8ZhBWh7achISIqrn0fcqvfaBOkU2rju1VAzTSYk5Sn1l3J2f328cfD7iE13Mi
         OORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717635277; x=1718240077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au0JZM8089E6OMtbjux3svk8IS/Bbe7byT/O6JMDcm0=;
        b=wNag3rG9JE552DWTvwbZXaKLcGssbDg6mtbcRCG2Z/7a1CP9SWHS6/vq1RGHzj2DGp
         78a2kHIduq8wQPmgVjTd2jiJAxpp5BhS0n9xiPxbs/bzN8TI7oKIANb4sNg3x2EsOA8D
         b1REAa6OMMR6CDJI6mkl5RTFmryvmAJJj5LFa3qDDqyTv0xw6YQHjXoiHcx9fF9VuvBj
         cDI4NfivXysmaMY1T3NZbK3/XxGY4402uFYQfsx2Kp5PU6hxzLwfi5VZApp1lolaqXlM
         ejmRQFbTUlV6ir2Jqgfj27456iD6hs4meyiqtOW05QPXugwt0iyuLvKk0aHEK1nyd0Hd
         ddrg==
X-Gm-Message-State: AOJu0Yy78G7onfoRXfn9y3ffFwNWwC9KxB3MTlYMcmxPiIP5Dgn4jsYz
	ED13h4z8sV6nmn//byCJ2iLYt1Teor1gYDGbaaEY6c7xKtsZlQTul0Njhg==
X-Google-Smtp-Source: AGHT+IGumc0VtEd11D8PjGCUgzdihE5j6OcHLS+KIBW3gMe55JBZLHMpDwroK5SU7CxGTDbO3Ps7vA==
X-Received: by 2002:a17:902:d507:b0:1f6:c04:42a7 with SMTP id d9443c01a7336-1f6a5a5c13fmr53320635ad.42.1717635276572;
        Wed, 05 Jun 2024 17:54:36 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:5ca2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e1efasm1639885ad.221.2024.06.05.17.54.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jun 2024 17:54:36 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v5 bpf-next 3/3] selftests/bpf: Remove i = zero workaround and add new tests.
Date: Wed,  5 Jun 2024 17:54:25 -0700
Message-Id: <20240606005425.38285-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
References: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

. remove i = zero workaround from various tests
. improve arena based tests
. add asm test for this_branch_reg->id == other_branch_reg->id condition
. add several loop inside open coded iter tests

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/progs/arena_htab.c  |  16 ++-
 tools/testing/selftests/bpf/progs/iters.c     |  14 +-
 .../selftests/bpf/progs/iters_task_vma.c      | 130 ++++++++++++++++++
 .../bpf/progs/verifier_iterating_callbacks.c  |  23 ++--
 .../selftests/bpf/progs/verifier_reg_equal.c  |  29 ++++
 5 files changed, 185 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
index 1e6ac187a6a0..1917f35b5963 100644
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
+	for (i = 0; i < 100000 && can_loop; i++) {
 		htab_update_elem(htab, i, i);
+		arr[i] = i;
+	}
 
-	/* should replace all elems with new ones */
-	for (i = zero; i < 1000; i++)
+	/* should replace some elems with new ones */
+	for (i = 0; i < 1000 && can_loop; i++) {
 		htab_update_elem(htab, i, i);
+		/* Access mem to make the verifier use bounded loop logic */
+		arr2[i] = i;
+	}
 	cast_user(htab);
 	htab_for_user = htab;
 #else
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index fe65e0952a1e..1a5adffae5d3 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -291,10 +291,7 @@ int iter_obfuscate_counter(const void *ctx)
 {
 	struct bpf_iter_num it;
 	int *v, sum = 0;
-	/* Make i's initial value unknowable for verifier to prevent it from
-	 * pruning if/else branch inside the loop body and marking i as precise.
-	 */
-	int i = zero;
+	int i = 0;
 
 	MY_PID_GUARD();
 
@@ -304,15 +301,6 @@ int iter_obfuscate_counter(const void *ctx)
 
 		i += 1;
 
-		/* If we initialized i as `int i = 0;` above, verifier would
-		 * track that i becomes 1 on first iteration after increment
-		 * above, and here verifier would eagerly prune else branch
-		 * and mark i as precise, ruining open-coded iterator logic
-		 * completely, as each next iteration would have a different
-		 * *precise* value of i, and thus there would be no
-		 * convergence of state. This would result in reaching maximum
-		 * instruction limit, no matter what the limit is.
-		 */
 		if (i == 1)
 			x = 123;
 		else
diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/testing/selftests/bpf/progs/iters_task_vma.c
index dc0c3691dcc2..31c4e7d9eaa3 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_vma.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
@@ -28,6 +28,10 @@ int iter_task_vma_for_each(const void *ctx)
 		return 0;
 
 	bpf_for_each(task_vma, vma, task, 0) {
+		/*
+		 * Fast to verify, since 'seen' has the same range at every
+		 * loop iteration.
+		 */
 		if (bpf_cmp_unlikely(seen, >=, 1000))
 			break;
 
@@ -40,4 +44,130 @@ int iter_task_vma_for_each(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp/sys_enter")
+int iter_task_vma_for_each_eq(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct vm_area_struct *vma;
+	unsigned int seen = 0;
+
+	if (task->pid != target_pid)
+		return 0;
+
+	if (vmas_seen)
+		return 0;
+
+	bpf_for_each(task_vma, vma, task, 0) {
+		/*
+		 * Also fast, since the verifier recognizes
+		 * 0, 1, 2 != 1000 as [0, 999] range.
+		 */
+		if (bpf_cmp_unlikely(seen, ==, 1000))
+			break;
+
+		vm_ranges[seen].vm_start = vma->vm_start;
+		vm_ranges[seen].vm_end = vma->vm_end;
+		seen++;
+	}
+
+	vmas_seen = seen;
+	return 0;
+}
+
+#define ARR_SZ 100000
+char arr[ARR_SZ];
+
+SEC("socket")
+__success __flag(BPF_F_TEST_STATE_FREQ)
+int loop_inside_iter(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, sum = 0;
+	__u64 i = 0;
+
+	bpf_iter_num_new(&it, 0, ARR_SZ);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (i < ARR_SZ)
+			sum += arr[i++];
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
+	bpf_iter_num_new(&it, 0, ARR_SZ);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (i < ARR_SZ && i >= 0)
+			sum += arr[i++];
+	}
+	bpf_iter_num_destroy(&it);
+	return sum;
+}
+
+volatile const int limit = ARR_SZ;
+
+SEC("socket")
+__success __flag(BPF_F_TEST_STATE_FREQ)
+int loop_inside_iter_volatile_limit(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, sum = 0;
+	__u64 i = 0;
+
+	bpf_iter_num_new(&it, 0, ARR_SZ);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (i < limit)
+			sum += arr[i++];
+	}
+	bpf_iter_num_destroy(&it);
+	return sum;
+}
+
+__noinline
+static void touch_arr(int i)
+{
+	/*
+	 * Though 'i' is signed the verifier sees that 0
+	 * is the lowest number passed into static subprogram
+	 * and determines the range [0, ARR_SZ - 1].
+	 */
+	if (i >= ARR_SZ)
+		return;
+	arr[i] = i;
+}
+
+__noinline
+int touch_arr_global(__u32 i)
+{
+	/*
+	 * In global function the array index 'i' has to be unsigned,
+	 * otherwise the verifier will see unbounded min value.
+	 */
+	if (i >= ARR_SZ)
+		return 0;
+	arr[i] = i;
+	return 0;
+}
+
+SEC("socket")
+__success
+int loop_inside_iter_subprog(const void *ctx)
+{
+	long i;
+
+	for (i = 0; i <= 1000000 && can_loop; i++)
+		touch_arr(i);
+
+	for (i = 0; i <= 1000000 && can_loop; i++)
+		touch_arr_global(i);
+
+	return 0;
+}
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index bd676d7e615f..78016294df95 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -308,7 +308,6 @@ int iter_limit_bug(struct __sk_buff *skb)
 }
 
 #define ARR_SZ 1000000
-int zero;
 char arr[ARR_SZ];
 
 SEC("socket")
@@ -318,9 +317,10 @@ int cond_break1(const void *ctx)
 	unsigned long i;
 	unsigned int sum = 0;
 
-	for (i = zero; i < ARR_SZ && can_loop; i++)
+	for (i = 0; i < ARR_SZ && can_loop; i++)
 		sum += i;
-	for (i = zero; i < ARR_SZ; i++) {
+
+	for (i = 0; i < ARR_SZ; i++) {
 		barrier_var(i);
 		sum += i + arr[i];
 		cond_break;
@@ -333,11 +333,11 @@ SEC("socket")
 __success __retval(999000000)
 int cond_break2(const void *ctx)
 {
-	int i, j;
+	long i, j;
 	int sum = 0;
 
-	for (i = zero; i < 1000 && can_loop; i++)
-		for (j = zero; j < 1000; j++) {
+	for (i = 0; i < 1000 && can_loop; i++)
+		for (j = 0; j < 1000; j++) {
 			sum += i + j;
 			cond_break;
 	}
@@ -346,9 +346,10 @@ int cond_break2(const void *ctx)
 
 static __noinline int loop(void)
 {
-	int i, sum = 0;
+	int sum = 0;
+	long i;
 
-	for (i = zero; i <= 1000000 && can_loop; i++)
+	for (i = 0; i <= 1000000 && can_loop; i++)
 		sum += i;
 
 	return sum;
@@ -365,7 +366,7 @@ SEC("socket")
 __success __retval(1)
 int cond_break4(const void *ctx)
 {
-	int cnt = zero;
+	int cnt = 0;
 
 	for (;;) {
 		/* should eventually break out of the loop */
@@ -378,7 +379,7 @@ int cond_break4(const void *ctx)
 
 static __noinline int static_subprog(void)
 {
-	int cnt = zero;
+	int cnt = 0;
 
 	for (;;) {
 		cond_break;
@@ -392,7 +393,7 @@ SEC("socket")
 __success __retval(1)
 int cond_break5(const void *ctx)
 {
-	int cnt1 = zero, cnt2;
+	int cnt1 = 0, cnt2;
 
 	for (;;) {
 		cond_break;
diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
index dc1d8c30fb0e..cc1e7e372daf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -55,4 +55,33 @@ l1_%=:	exit;						\
 	: __clobber_all);
 }
 
+/*
+ * The tests checks that the verifier doesn't WARN_ON in:
+ * if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
+ *     !WARN_ON_ONCE(dst_reg->id != other_dst_reg->id)) {
+ */
+SEC("socket")
+__description("check this_branch_reg->id == other_branch_reg->id")
+__success
+__naked void reg_id(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	.byte 0xe5; /* may_goto */			\
+	.byte 0; /* regs */				\
+	.short 5; /* off of l0_%=: */			\
+	.long 0; /* imm */				\
+	r0 &= 1;					\
+	r2 = r0;					\
+	/* is_branch_taken will predict fallthrough */	\
+	if r2 == 2 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


