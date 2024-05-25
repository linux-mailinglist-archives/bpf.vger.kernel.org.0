Return-Path: <bpf+bounces-30575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E5B8CEDB5
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 05:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3141F21A02
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 03:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED1B2F34;
	Sat, 25 May 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFppHYHv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53ED2904
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716606726; cv=none; b=RrTal+lSE5XGE2QfD9w0yqadDN2uAkEy3iwz/8enR/xNFPoAkAnxIko/mZyhMopooBET3MreuwqCZKdciAuy4TvXETntZPhRFjbWxL9bJDs4HJPkkg6NU7xP2fXX5e0NWGMQLf4XUmsh1iYfcDLlulPV9t97Bt4QPA8CZogS/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716606726; c=relaxed/simple;
	bh=8JC7YqWPGz7XJWRCq/nB37vjoU9dQZGMSIqsHkJWato=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huPAin54I1pQR//pAKBlCJfkA8uYda/9vQxP2sneDVZvT21muPADL0t0Q1Q7wGglxg5Ebt+AO6T3yQNqWHDcPfvp2rfY9sWcYZKk8+o7XvsnMSRF7Oou0PeXE9LrxMSgQBBSZPQ6r/l7fmFnPXiKKSz7ggK0cRvQv5VPQXHCi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFppHYHv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f34b5f1964so18525435ad.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716606723; x=1717211523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5BdsPU7h12z6ar/PXA27ljvXqbKexfqH9HJkxs2VqE=;
        b=fFppHYHvDvNbuodLI4333DxxxU5FvRigD1xBrmgcLzCzZLUjMMlMg79jQYMJDDEfqJ
         HI34LEFh38qDof9oseK5QitpBpg5KV79Y+zG1KfruT06tD+tnyOebKVlkcCZQGUs87r4
         J2MO68q0rrlklRBM5WPSE9CA4TO/k8YPSVpR4+JYarvNbBtLcKFjeSOMskkWhkHYF8F/
         Xppe97sJozPPz6BGqm4zrU2GuK2VO9p1ngPVAaBJ8loyDofHc4jUnhmZZ4MSZOn6X+hs
         V8mmokzmFe6dNhhogwWiNRyrIRRFUrb6PG44S1T5uNdipN/e7DqscIJoxxdQZnle2VBc
         b8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716606723; x=1717211523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5BdsPU7h12z6ar/PXA27ljvXqbKexfqH9HJkxs2VqE=;
        b=PYevmY+LJFqBZVTfoQQewsP6cCqYH435s+xOGtqtSXNacAr188KRCrNRaiVXvSawBo
         6ycp0hJcWples+o5p0u2d91wiNEQ1AYhwdSj2EZk0Gr+gSJabLDas8iztQiHpkkBoa+M
         5hLpfz7Rzy9Q6mHI83mIIoiHOA1cQc/Oz2Hr50DqJfNYTG8u+FuvQ6GD+iHGUhelJk6l
         GRDz95HPAXu63aEkVlxHt+nHP5Z6uqLhMoYhKgeF1sn+paaEB2i3IUe4ddJ3aYaIZkAP
         DU5pkENQa0V+VgaGFP7lNYBisYCfYldRp0x9Eyh9g7QES2/Wf42uaxovXn1SYEUaMtLd
         rgfw==
X-Gm-Message-State: AOJu0YxnLp3Npjm0V7iGgJRi+3abTVDfL/nBToyGOyvqz9E97rX04AF9
	a0A4Ty7tPNPDXLUMGRq9EqUH8G+n+5xhVKmo2Ynd8X/0HhwFZIzYEghYTA==
X-Google-Smtp-Source: AGHT+IGWopE+eRF47GiNTLc49pQVdKVI8ZX+M+hweEs8UoPWNrfDAdMJ7owtQ+aYqqfvVWxCw7FdGg==
X-Received: by 2002:a17:902:e74c:b0:1f4:6252:dba9 with SMTP id d9443c01a7336-1f46252de96mr16992265ad.9.1716606723385;
        Fri, 24 May 2024 20:12:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:1a8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c758128sm20815525ad.60.2024.05.24.20.12.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 May 2024 20:12:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Remove i = zero workaround and add new tests.
Date: Fri, 24 May 2024 20:11:56 -0700
Message-Id: <20240525031156.13545-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Remove i = zero workaround, improve arena based tests,
add asm test for this_branch_reg->id == other_branch_reg->id condition.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/progs/arena_htab.c  | 16 ++++++++--
 tools/testing/selftests/bpf/progs/iters.c     | 14 +--------
 .../bpf/progs/verifier_iterating_callbacks.c  | 18 ++++++------
 .../selftests/bpf/progs/verifier_reg_equal.c  | 29 +++++++++++++++++++
 4 files changed, 52 insertions(+), 25 deletions(-)

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
index dc1d8c30fb0e..bca474a5e7b6 100644
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
+	1:.byte 0xe5; /* may_goto */			\
+	.byte 0;					\
+	.long ((l0_%= - 1b - 8) / 8) & 0xffff;	\
+	.short 0;					\
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


