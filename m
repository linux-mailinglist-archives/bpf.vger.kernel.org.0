Return-Path: <bpf+bounces-77521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF47CEA038
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 16:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE6443088143
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4603246E1;
	Tue, 30 Dec 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl7+of8P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB6322B76;
	Tue, 30 Dec 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106314; cv=none; b=YZdhbQJimViJT2l1WR+Zhqo5uf5bGLMdepl9S/idIcKqRMRsQq2WCFJzZ/8igi/D5VsYmYGFey4ODD08I1TPyI2Q08RnRCYDNlPuep5O2P4ifLLViHq6zg21maSGve0/1L5jpa7t4+arQ9Qf301MlRoT/BfSMbqop6V70lkpeGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106314; c=relaxed/simple;
	bh=WKE/XYNcBzOf0ZIHqjBiCq2xvyLfPnltvhfX9fnz+wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISeo4x0bJuC8DkZ+VPSb6enLADrfIkzYV8+khPKLriI7NToeI9Ym4OgiOWyMYcysOE8ThAtRj6u919GitmBnF6vQ57m2G5sFhV/7Ip5boHYgh8Gutw359QYeUjxjvUvSNW1O3puRv5n4h9i5Pk7rgrujnz8zxRAphswzwzm0B9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl7+of8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84D9C4CEFB;
	Tue, 30 Dec 2025 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767106313;
	bh=WKE/XYNcBzOf0ZIHqjBiCq2xvyLfPnltvhfX9fnz+wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dl7+of8PQYOKIbHtdfkfn9V6WccfsEMLmBm3vSay7LfTce7rS6hUBXCstI6zqs2S2
	 mxI2+AEmlNwOjAiayujxul9mbt0CziwYRSo+oZZC0Lv+e72cal3klBjWdwsV2+RjFT
	 P8Kp+AFpAag9iEAu0Gnt3IgxXT/PL7gm8gOw7+6pJALE+pc3dwcUsevv82oP4+ReD9
	 D2sO0MnaTNBfFsQ5stQAqV/48nqMI2q0Z1osWYDSYxPlxLQK1YCzK+qSBbLSVlbV9r
	 OH5Iv257OUYsstpUXbYN9uT36JO5BBnJdHp0HAhaZaAxOk1YO4qRTACRjkknlqIKHG
	 uex1b0GcXT11w==
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
Subject: [PATCHv6 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct calls
Date: Tue, 30 Dec 2025 15:50:10 +0100
Message-ID: <20251230145010.103439-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230145010.103439-1-jolsa@kernel.org>
References: <20251230145010.103439-1-jolsa@kernel.org>
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
in ftrace_ops::direct_call). Archs that do not support this will continue
to use *_ftrace_direct api.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/Kconfig        |   1 +
 kernel/bpf/trampoline.c | 220 ++++++++++++++++++++++++++++++++++------
 kernel/trace/Kconfig    |   3 +
 kernel/trace/ftrace.c   |   7 +-
 4 files changed, 200 insertions(+), 31 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80527299f859..53bf2cf7ff6f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -336,6 +336,7 @@ config X86
 	select SCHED_SMT			if SMP
 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
 	select ARCH_SUPPORTS_SCHED_MC		if SMP
+	select HAVE_SINGLE_FTRACE_DIRECT_OPS	if X86_64 && DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e5a0d58ed6dc..248cd368fa37 100644
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
@@ -137,6 +165,162 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
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
+	if (!add_ftrace_hash_entry_direct(hash, ip, addr)) {
+		free_ftrace_hash(hash);
+		return NULL;
+	}
+	return hash;
+}
+
+static int direct_ops_add(struct bpf_trampoline *tr, void *addr)
+{
+	struct ftrace_hash *hash = hash_from_ip(tr, addr);
+	int err;
+
+	if (!hash)
+		return -ENOMEM;
+	err = update_ftrace_direct_add(tr->fops, hash);
+	free_ftrace_hash(hash);
+	return err;
+}
+
+static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
+{
+	struct ftrace_hash *hash = hash_from_ip(tr, addr);
+	int err;
+
+	if (!hash)
+		return -ENOMEM;
+	err = update_ftrace_direct_del(tr->fops, hash);
+	free_ftrace_hash(hash);
+	return err;
+}
+
+static int direct_ops_mod(struct bpf_trampoline *tr, void *addr, bool lock_direct_mutex)
+{
+	struct ftrace_hash *hash = hash_from_ip(tr, addr);
+	int err;
+
+	if (!hash)
+		return -ENOMEM;
+	err = update_ftrace_direct_mod(tr->fops, hash, lock_direct_mutex);
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
+	if (!tr->fops)
+		return;
+	ftrace_free_filter(tr->fops);
+	kfree(tr->fops);
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
+
+static int direct_ops_alloc(struct bpf_trampoline *tr)
+{
+	return 0;
+}
+
+static int direct_ops_add(struct bpf_trampoline *tr, void *addr)
+{
+	return -ENODEV;
+}
+
+static int direct_ops_del(struct bpf_trampoline *tr, void *addr)
+{
+	return -ENODEV;
+}
+
+static int direct_ops_mod(struct bpf_trampoline *tr, void *ptr, bool lock_direct_mutex)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 {
 	struct bpf_trampoline *tr;
@@ -154,16 +338,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 	if (!tr)
 		goto out;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
-	if (!tr->fops) {
+	if (direct_ops_alloc(tr)) {
 		kfree(tr);
 		tr = NULL;
 		goto out;
 	}
-	tr->fops->private = tr;
-	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
-#endif
 
 	tr->key = key;
 	tr->ip = ftrace_location(ip);
@@ -206,7 +385,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
+		ret = direct_ops_del(tr, old_addr);
 	else
 		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
 
@@ -220,15 +399,7 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
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
@@ -251,15 +422,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
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
@@ -910,10 +1073,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
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
index bfa2ec46e075..d7042a09fe46 100644
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
index 02030f62d737..4ed910d3d00d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2631,8 +2631,13 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
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


