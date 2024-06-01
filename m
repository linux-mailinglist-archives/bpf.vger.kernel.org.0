Return-Path: <bpf+bounces-31086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FD78D6DD8
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 05:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B841C2120A
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 03:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A4B653;
	Sat,  1 Jun 2024 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdkq0o4Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50457AD5A
	for <bpf@vger.kernel.org>; Sat,  1 Jun 2024 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213343; cv=none; b=e1OokvUccovE3KQg4aPyZQBqLSnH12XTEjU9S836QWxEcsDvi2mY59HX5y0wWYZuW8XRQsOMzthP6vuRJTPt+2JdOa63lQwKWWR5VcwHuosqK1pCYdrkhKwfQrKAIVjCfmsMEx87ZVdRC9rXUfCo5xFE3ODqjq5OHHEi8pNfwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213343; c=relaxed/simple;
	bh=yWREFOxd9zF21yoinYLWJ55qU+e12tX4a18KOXDxmS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oR9yAr3jZRmucggzQc/P7dObgYWVFWvdghvoxBkRCUec6MjTY5gvclVDnxlgTQLkDS4QVuluX2yY1CdZH1xBBahxMODl0xs+PSo8XJPh9skCKxIS26h6bx9G89G4TxkvUsUNo0YvjlKEB3tLga0xnWlns+UqwUxbNaRGpTeSVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdkq0o4Q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7024d560b32so751325b3a.1
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717213341; x=1717818141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvEqT3RkukeAf6mE2EjGKfr1XTmfUQg7e4iHAXy0v0s=;
        b=Gdkq0o4QuN2/z2NYUZfW7YPOdHBL7/LkgF6yNBQD2pV5xdD6xPYKO4YkfLRg/ojLKb
         vJjhA9ZnL7dmyU5awRDDp9akPe5nyJiQSfhUvwUiXLv35lxa96Qdf67spvrn+icjO4Ts
         /ku4Xfq24bPOW3RfSyAF/k/DFE8GEy/zqd7TshbHFIUvF09o2iMo15QQJChHVWliK7ve
         +4KmuBtwshRV0zlkTB5l4VHpwfywY+wGr6ryPtTdOp4BBSrpzJ61IvabhQY1OXqEu0DJ
         uQatFZWDetVEcQaMh4+aRRP2jeZrLrm5S3Zw9IBiudqnIl2UfmXBulvpNEboEbfgSLcm
         bVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717213341; x=1717818141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvEqT3RkukeAf6mE2EjGKfr1XTmfUQg7e4iHAXy0v0s=;
        b=mr1VJkfYbcNrNxZjfasVCXm/0VnA1ATc3v8DT6QudVY/aDPG4qU5EGxf6YAB5K0iej
         RpA5bZi85wGmOzva/ATONJxHNFA2v83RLtcZQu/80nH8NnZoIX8uJVW/1196CSSexVea
         mf4J3A45Es+R444j4KIkpWPCJJ+Lp7XpfmCgtdzHckzfcLe4px6HA9SUMJcm90lMUbj9
         HU4EA4ySMoc/vTYaIKWG2+4ZGvjk1u1o1PGCxcVKBJRappLyv4Q8B8qSF1VHrcuxN1no
         OO62SzGs7mzyNzT+rn+M+ro85HXagwbdBtmmxT2QKOmYA+2SJwq9pFBW/A7vTiptpZ47
         yIGg==
X-Gm-Message-State: AOJu0Ywqg0HPTsUl+rVy8D+7GLShgqqu5L03uZsi8X16TPAjq+EE0a1b
	xuSRUO+lmoRL0aYmHI4h8fWUYI3cYLN4ZLarY1xO0VI7sFkrUtlouR7Pyg==
X-Google-Smtp-Source: AGHT+IFMF9K0EEnAHBgEGn+15V4PcaaxSsAPuY1DTR3bb6jyADbcB4fdjWpKRzigktZUJmT9o0e+eA==
X-Received: by 2002:a05:6a00:6701:b0:6ed:825b:30c0 with SMTP id d2e1a72fcca58-70231b19bd9mr8716170b3a.15.1717213340234;
        Fri, 31 May 2024 20:42:20 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:428])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7024a9b5639sm1803531b3a.170.2024.05.31.20.42.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 May 2024 20:42:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 2/2] selftests/bpf: Remove i = zero workaround and add new tests.
Date: Fri, 31 May 2024 20:42:11 -0700
Message-Id: <20240601034211.63962-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240601034211.63962-1-alexei.starovoitov@gmail.com>
References: <20240601034211.63962-1-alexei.starovoitov@gmail.com>
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
 .../testing/selftests/bpf/progs/arena_htab.c  | 16 +++-
 tools/testing/selftests/bpf/progs/iters.c     | 14 +--
 .../selftests/bpf/progs/iters_task_vma.c      | 89 +++++++++++++++++++
 .../bpf/progs/verifier_iterating_callbacks.c  | 18 ++--
 .../selftests/bpf/progs/verifier_reg_equal.c  | 29 ++++++
 5 files changed, 141 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
index 1e6ac187a6a0..e669db468c5a 100644
--- a/tools/testing/selftests/bpf/progs/arena_htab.c
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -18,25 +18,35 @@ void __arena *htab_for_user;
 bool skip = false;
 
 int zero = 0;
+char __arena arr1[100000]; /* works */
+char arr2[1000]; /* ok for small sizes */
 
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
index dc0c3691dcc2..8899821bf6d9 100644
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
 
@@ -40,4 +44,89 @@ int iter_task_vma_for_each(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp/sys_enter")
+int iter_task_vma_for_each_slow(const void *ctx)
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
+		 * Slow to verify. The verifier has to check
+		 * all possible values of seen = 0, 1, ..., 1000.
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
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index bd676d7e615f..b2159d9cd4ad 100644
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
@@ -336,8 +336,8 @@ int cond_break2(const void *ctx)
 	int i, j;
 	int sum = 0;
 
-	for (i = zero; i < 1000 && can_loop; i++)
-		for (j = zero; j < 1000; j++) {
+	for (i = 0; i < 1000 && can_loop; i++)
+		for (j = 0; j < 1000; j++) {
 			sum += i + j;
 			cond_break;
 	}
@@ -348,7 +348,7 @@ static __noinline int loop(void)
 {
 	int i, sum = 0;
 
-	for (i = zero; i <= 1000000 && can_loop; i++)
+	for (i = 0; i <= 1000000 && can_loop; i++)
 		sum += i;
 
 	return sum;
@@ -365,7 +365,7 @@ SEC("socket")
 __success __retval(1)
 int cond_break4(const void *ctx)
 {
-	int cnt = zero;
+	int cnt = 0;
 
 	for (;;) {
 		/* should eventually break out of the loop */
@@ -378,7 +378,7 @@ int cond_break4(const void *ctx)
 
 static __noinline int static_subprog(void)
 {
-	int cnt = zero;
+	int cnt = 0;
 
 	for (;;) {
 		cond_break;
@@ -392,7 +392,7 @@ SEC("socket")
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


