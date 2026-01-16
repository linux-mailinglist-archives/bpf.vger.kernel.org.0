Return-Path: <bpf+bounces-79336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 238EAD38735
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9EEF302DCB6
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F43A7E16;
	Fri, 16 Jan 2026 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rwx9kzsD"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD053A7858
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594698; cv=none; b=Xc7r7IS/UobjDjIH9KDfQoLoneDyyJVFbF1wQKQ9imn7ek4ifC+xj8exLj5szufkag4TffpHWCRr7ySEhgA2fjk0l+ZQyxp0ZgQ+HdPyTaaeWAs3wLpOMbMc/epyCewPajk6pIAa+1HgUBdlHGtvMAtYDoOYjf26FqabsbPtwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594698; c=relaxed/simple;
	bh=vBHjyw/hYj3zLonFk9pCUtMlB1Ka+QnD60kV7c0604Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKc0hBieq760G2vjpzX8tDnwTPr0vOpjufEQfjG84zH5ycjRpPVnMTlv0dab9WHoy7exvWoklc5ISqjEozGjghT/U7XD8p+e1YtWcYXN7jibRHWNKC9CCuTT5jAbHkVy/hZFymwbti0wozzSWyXxnLb4SeIEtLj2GjYzTffBxrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rwx9kzsD; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768594695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xd1q0+5EcF59BHhz0hdJGHGQYrQFn/Df+WIN5kKXCbQ=;
	b=rwx9kzsD7TKiR66wZajuTJl0XovgHKrkK2aF0RWNflQ4QGj5xHr0WMa2jixmiXfY8TTbBs
	OgrL+onNrL2gKJXhTYCWVneiDjPTC6goNnO5NcGicYoaUmwxL2RHM3bStOCKD4DTNJe56R
	bmoahe4QnkpDqeT5r4QYf0WP0fIhAVQ=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v2 11/13] selftests/bpf: Migrate struct_ops_assoc test to KF_IMPLICIT_ARGS
Date: Fri, 16 Jan 2026 12:16:58 -0800
Message-ID: <20260116201700.864797-12-ihor.solodrai@linux.dev>
In-Reply-To: <20260116201700.864797-1-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A test kfunc named bpf_kfunc_multi_st_ops_test_1_impl() is a user of
__prog suffix. Subsequent patch removes __prog support in favor of
KF_IMPLICIT_ARGS, so migrate this kfunc to use implicit argument.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/progs/struct_ops_assoc.c     | 8 ++++----
 .../selftests/bpf/progs/struct_ops_assoc_in_timer.c      | 4 ++--
 .../testing/selftests/bpf/progs/struct_ops_assoc_reuse.c | 6 +++---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c     | 9 ++++-----
 .../testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h | 6 ++++--
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
index 8f1097903e22..68842e3f936b 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
@@ -32,7 +32,7 @@ int BPF_PROG(sys_enter_prog_a, struct pt_regs *regs, long id)
 	if (!test_pid || task->pid != test_pid)
 		return 0;
 
-	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	if (ret != MAP_A_MAGIC)
 		test_err_a++;
 
@@ -45,7 +45,7 @@ int syscall_prog_a(void *ctx)
 	struct st_ops_args args = {};
 	int ret;
 
-	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	if (ret != MAP_A_MAGIC)
 		test_err_a++;
 
@@ -79,7 +79,7 @@ int BPF_PROG(sys_enter_prog_b, struct pt_regs *regs, long id)
 	if (!test_pid || task->pid != test_pid)
 		return 0;
 
-	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	if (ret != MAP_B_MAGIC)
 		test_err_b++;
 
@@ -92,7 +92,7 @@ int syscall_prog_b(void *ctx)
 	struct st_ops_args args = {};
 	int ret;
 
-	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	if (ret != MAP_B_MAGIC)
 		test_err_b++;
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
index d5a2ea934284..0bed49e9f217 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
@@ -31,7 +31,7 @@ __noinline static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 	struct st_ops_args args = {};
 
 	recur++;
-	timer_test_1_ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	timer_test_1_ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	recur--;
 
 	timer_cb_run++;
@@ -64,7 +64,7 @@ int syscall_prog(void *ctx)
 	struct st_ops_args args = {};
 	int ret;
 
-	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	if (ret != MAP_MAGIC)
 		test_err++;
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
index 5bb6ebf5eed4..396b3e58c729 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
@@ -23,7 +23,7 @@ int BPF_PROG(test_1_a, struct st_ops_args *args)
 
 	if (!recur) {
 		recur++;
-		ret = bpf_kfunc_multi_st_ops_test_1_impl(args, NULL);
+		ret = bpf_kfunc_multi_st_ops_test_1_assoc(args);
 		if (ret != -1)
 			test_err_a++;
 		recur--;
@@ -40,7 +40,7 @@ int syscall_prog_a(void *ctx)
 	struct st_ops_args args = {};
 	int ret;
 
-	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	if (ret != MAP_A_MAGIC)
 		test_err_a++;
 
@@ -62,7 +62,7 @@ int syscall_prog_b(void *ctx)
 	struct st_ops_args args = {};
 	int ret;
 
-	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	if (ret != MAP_A_MAGIC)
 		test_err_b++;
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index a996b816ecc4..0d542ba64365 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1140,7 +1140,7 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 }
 
 __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id);
-__bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *aux_prog);
+__bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, struct bpf_prog_aux *aux);
 
 __bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
 __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
@@ -1187,7 +1187,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10)
 BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1)
-BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl)
+BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_assoc, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
@@ -1669,13 +1669,12 @@ int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
 }
 
 /* Call test_1() of the associated struct_ops map */
-int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *aux__prog)
+int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, struct bpf_prog_aux *aux)
 {
-	struct bpf_prog_aux *prog_aux = (struct bpf_prog_aux *)aux__prog;
 	struct bpf_testmod_multi_st_ops *st_ops;
 	int ret = -1;
 
-	st_ops = (struct bpf_testmod_multi_st_ops *)bpf_prog_get_assoc_struct_ops(prog_aux);
+	st_ops = (struct bpf_testmod_multi_st_ops *)bpf_prog_get_assoc_struct_ops(aux);
 	if (st_ops)
 		ret = st_ops->test_1(args);
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 2357a0340ffe..225ea30c4e3d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -161,7 +161,9 @@ void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
 struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
 int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
 
-int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ksym;
-int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *aux__prog) __ksym;
+#ifndef __KERNEL__
+extern int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __weak __ksym;
+extern int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args) __weak __ksym;
+#endif
 
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.52.0


