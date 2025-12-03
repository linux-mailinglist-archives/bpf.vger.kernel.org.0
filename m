Return-Path: <bpf+bounces-75953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1DDC9E353
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 09:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D841A4E19F2
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7B2D59F7;
	Wed,  3 Dec 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAhBi1UU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059ED2D190C;
	Wed,  3 Dec 2025 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750347; cv=none; b=ZUlL4FBGooZyLGajleB48Nrcr4ejMhJ9HID37J5az5lBSPnMy5fkGavJzn9rImoWvqiLk1hkVVXRIwnVP1C/q7ro0+QgZY6up0RbMV7XqIeir9DKv753tU+O7TmB5a/Atr5UeOlC2bhktHuqWI7eK+0D6ZJyQXqR2Dlh92fuBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750347; c=relaxed/simple;
	bh=++f6yMiTdCFKivbaWeEKJoZJDBxCoJ9zz2SvUyi+7IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs0iPilEkKMqgy+vTaQ+GPR/7V0rkGsNtvZnNwkIPCrFfECYUglZrdCxnMW9UoPWzLcJMJpqZdSkTW4kmWI1EqDPyCXtOPZ2m73sqG8wJk48l4kP1+VcfcnusAcHULKut7ffleGCy7KvPh3zjtOz5mHWD5wSd+tiPwhjAUetmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAhBi1UU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9231BC2BC86;
	Wed,  3 Dec 2025 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764750346;
	bh=++f6yMiTdCFKivbaWeEKJoZJDBxCoJ9zz2SvUyi+7IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAhBi1UUmJik11A52rWsoA5W6YmvvEc/TvhJtPYDFmu9ph/98InowC+hokUTrhAgL
	 i29Q1NqIbjUvH65rrHwbY0b0ej15AsZsU9KM6uvzPTE4PVOjYAXCJ1HFUpkHVZZFvY
	 cLPXG/VCkZyj/cLpkurzYSxnBX72fPSY5WBzErAsyX9ri/4msBbCk0qZR1ol4ZXMKk
	 t+nbw8H4zkYDMJ6BQClhc0y5ePI6UeEAwqxhWStNVLIn8GoGtP2qbmlfKSGPEmwAfC
	 Sz8FWSD4mNzjAXYVJDsQVPMgUHIOby3hsSXvZ9ZqtD1yXdbldUAPyR+AWtTaHJxNjU
	 tcnWh1/0HMkGg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [PATCHv4 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct calls
Date: Wed,  3 Dec 2025 09:24:02 +0100
Message-ID: <20251203082402.78816-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203082402.78816-1-jolsa@kernel.org>
References: <20251203082402.78816-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using single ftrace_ops for direct calls update instead of allocating
ftrace_ops object for each trampoline.

With single ftrace_ops object we can use update_ftrace_direct_* api
that allows multiple ip sites updates on single ftrace_ops object.

Adding HAVE_SINGLE_FTRACE_DIRECT_OPS config option to be enabled on
each arch that supports this.

At the moment we can enable this only on x86 arch, because arm relies
on ftrace_ops object representing just single trampoline image (stored
in ftrace_ops::direct_call). Ach that do not support this will continue
to use *_ftrace_direct api.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/Kconfig        |   1 +
 kernel/bpf/trampoline.c | 195 ++++++++++++++++++++++++++++++++++------
 kernel/trace/Kconfig    |   3 +
 kernel/trace/ftrace.c   |   7 +-
 4 files changed, 177 insertions(+), 29 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 462250a20311..737dff48342b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -333,6 +333,7 @@ config X86
 	select SCHED_SMT			if SMP
 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
 	select ARCH_SUPPORTS_SCHED_MC		if SMP
+	select HAVE_SINGLE_FTRACE_DIRECT_OPS	if X86_64 && DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 17af2aad8382..02371db3db3e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -33,12 +33,40 @@ static DEFINE_MUTEX(trampoline_mutex);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
+#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
+{
+	struct hlist_head *head_ip;
+	struct bpf_trampoline *tr;
+
+	mutex_lock(&trampoline_mutex);
+	head_ip = &trampoline_ip_table[hash_64(ip, TRAMPOLINE_HASH_BITS)];
+	hlist_for_each_entry(tr, head_ip, hlist_ip) {
+		if (tr->ip == ip)
+			goto out;
+	}
+	tr = NULL;
+out:
+	mutex_unlock(&trampoline_mutex);
+	return tr;
+}
+#else
+static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
+{
+	return ops->private;
+}
+#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
+
 static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 				     enum ftrace_ops_cmd cmd)
 {
-	struct bpf_trampoline *tr = ops->private;
+	struct bpf_trampoline *tr;
 	int ret = 0;
 
+	tr = direct_ops_ip_lookup(ops, ip);
+	if (!tr)
+		return -EINVAL;
+
 	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
 		/* This is called inside register_ftrace_direct_multi(), so
 		 * tr->mutex is already locked.
@@ -137,6 +165,139 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
 			   PAGE_SIZE, true, ksym->name);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+/*
+ * We have only single direct_ops which contains all the direct call
+ * sites and is the only global ftrace_ops for all trampolines.
+ *
+ * We use 'update_ftrace_direct_*' api for attachment.
+ */
+struct ftrace_ops direct_ops = {
+	.ops_func = bpf_tramp_ftrace_ops_func,
+};
+
+static int direct_ops_alloc(struct bpf_trampoline *tr)
+{
+	tr->fops = &direct_ops;
+	return 0;
+}
+
+static void direct_ops_free(struct bpf_trampoline *tr) { }
+
+static struct ftrace_hash *hash_from_ip(struct bpf_trampoline *tr, void *ptr)
+{
+	unsigned long ip, addr = (unsigned long) ptr;
+	struct ftrace_hash *hash;
+
+	ip = ftrace_location(tr->ip);
+	if (!ip)
+		return NULL;
+	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	if (!hash)
+		return NULL;
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+	if (!add_hash_entry_direct(hash, ip, addr)) {
+		free_ftrace_hash(hash);
+		return NULL;
+	}
+	return hash;
+}
+
+static int direct_ops_add(struct bpf_trampoline *tr, void *addr)
+{
+	struct ftrace_hash *hash = hash_from_ip(tr, addr);
+	int err = -ENOMEM;
+
+	if (hash)
+		err = update_ftrace_direct_add(tr->fops, hash);
+	free_ftrace_hash(hash);
+	return err;
+}
+
+static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
+{
+	struct ftrace_hash *hash = hash_from_ip(tr, addr);
+	int err = -ENOMEM;
+
+	if (hash)
+		err = update_ftrace_direct_del(tr->fops, hash);
+	free_ftrace_hash(hash);
+	return err;
+}
+
+static int direct_ops_mod(struct bpf_trampoline *tr, void *addr, bool lock_direct_mutex)
+{
+	struct ftrace_hash *hash = hash_from_ip(tr, addr);
+	int err = -ENOMEM;
+
+	if (hash)
+		err = update_ftrace_direct_mod(tr->fops, hash, lock_direct_mutex);
+	free_ftrace_hash(hash);
+	return err;
+}
+#else
+/*
+ * We allocate ftrace_ops object for each trampoline and it contains
+ * call site specific for that trampoline.
+ *
+ * We use *_ftrace_direct api for attachment.
+ */
+static int direct_ops_alloc(struct bpf_trampoline *tr)
+{
+	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
+	if (!tr->fops)
+		return -ENOMEM;
+	tr->fops->private = tr;
+	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
+	return 0;
+}
+
+static void direct_ops_free(struct bpf_trampoline *tr)
+{
+	if (tr->fops) {
+		ftrace_free_filter(tr->fops);
+		kfree(tr->fops);
+	}
+}
+
+static int direct_ops_add(struct bpf_trampoline *tr, void *ptr)
+{
+	unsigned long addr = (unsigned long) ptr;
+	struct ftrace_ops *ops = tr->fops;
+	int ret;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+
+	ret = ftrace_set_filter_ip(ops, tr->ip, 0, 1);
+	if (ret)
+		return ret;
+	return register_ftrace_direct(ops, addr);
+}
+
+static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
+{
+	return unregister_ftrace_direct(tr->fops, (long)addr, false);
+}
+
+static int direct_ops_mod(struct bpf_trampoline *tr, void *ptr, bool lock_direct_mutex)
+{
+	unsigned long addr = (unsigned long) ptr;
+	struct ftrace_ops *ops = tr->fops;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+	if (lock_direct_mutex)
+		return modify_ftrace_direct(ops, addr);
+	return modify_ftrace_direct_nolock(ops, addr);
+}
+#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
+#else
+static void direct_ops_free(struct bpf_trampoline *tr) { }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 {
 	struct bpf_trampoline *tr;
@@ -155,14 +316,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	if (!tr)
 		goto out;
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
-	if (!tr->fops) {
+	if (direct_ops_alloc(tr)) {
 		kfree(tr);
 		tr = NULL;
 		goto out;
 	}
-	tr->fops->private = tr;
-	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
 #endif
 
 	tr->key = key;
@@ -206,7 +364,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
+		ret = direct_ops_del(tr, old_addr);
 	else
 		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
 
@@ -220,15 +378,7 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 	int ret;
 
 	if (tr->func.ftrace_managed) {
-		unsigned long addr = (unsigned long) new_addr;
-
-		if (bpf_trampoline_use_jmp(tr->flags))
-			addr = ftrace_jmp_set(addr);
-
-		if (lock_direct_mutex)
-			ret = modify_ftrace_direct(tr->fops, addr);
-		else
-			ret = modify_ftrace_direct_nolock(tr->fops, addr);
+		ret = direct_ops_mod(tr, new_addr, lock_direct_mutex);
 	} else {
 		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
 						   new_addr);
@@ -251,15 +401,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	}
 
 	if (tr->func.ftrace_managed) {
-		unsigned long addr = (unsigned long) new_addr;
-
-		if (bpf_trampoline_use_jmp(tr->flags))
-			addr = ftrace_jmp_set(addr);
-
-		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
-		if (ret)
-			return ret;
-		ret = register_ftrace_direct(tr->fops, addr);
+		ret = direct_ops_add(tr, new_addr);
 	} else {
 		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
 	}
@@ -910,10 +1052,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 */
 	hlist_del(&tr->hlist_key);
 	hlist_del(&tr->hlist_ip);
-	if (tr->fops) {
-		ftrace_free_filter(tr->fops);
-		kfree(tr->fops);
-	}
+	direct_ops_free(tr);
 	kfree(tr);
 out:
 	mutex_unlock(&trampoline_mutex);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 4661b9e606e0..1ad2e307c834 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -50,6 +50,9 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
 config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	bool
 
+config HAVE_SINGLE_FTRACE_DIRECT_OPS
+	bool
+
 config HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
 	bool
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9582cb374d4f..0bdee1758fa1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2605,8 +2605,13 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	unsigned long addr = READ_ONCE(ops->direct_call);
+	unsigned long addr;
 
+#ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
+	addr = ftrace_find_rec_direct(ip);
+#else
+	addr = READ_ONCE(ops->direct_call);
+#endif
 	if (!addr)
 		return;
 
-- 
2.52.0


