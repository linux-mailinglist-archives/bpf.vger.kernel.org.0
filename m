Return-Path: <bpf+bounces-64615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA0B14C2F
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3EB97AA00D
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A67028A712;
	Tue, 29 Jul 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVYSeU9r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40A289E1D;
	Tue, 29 Jul 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784963; cv=none; b=UO5sJ7uwMhWFws46j6fhGiujyN8MUHRPElY1/zQQc91iHDglBD39RGH7Tv8etPhkgBxI+xkRdg79iwtHkdXMB2mzjKh2osYwjhmtx2CfaZNooA4/ghV9mD/FVc9fdmgt0Sai4cC5sI96p65JQgAGXzYIU2yDkTV3Jfw6dh+8vtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784963; c=relaxed/simple;
	bh=LkMiSu9rJHL78CHuuZGPPKsY5tkXMO6EbHSe73wtQp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCFAKkRjk5sOist45vBcKiIfXIYglFWvog8lGCpMa7/dsGEUxreEnU+Qwgf//tLF06Gb+vemJf9C94SJtTfpd1OnBrtZFoRLGpte81ChV5OViXx16o+MlkbSEHjzSE/6wXX4RFZe6+1Qn7dToTtciJOQ1RwtraKZ7yiZdL3pLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVYSeU9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE94C4CEEF;
	Tue, 29 Jul 2025 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753784962;
	bh=LkMiSu9rJHL78CHuuZGPPKsY5tkXMO6EbHSe73wtQp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVYSeU9r1+uoZGBIGoBMQ6R+h4oY3hJF2KI+FDxgk5+uR6qnN5Wb9kjh7u6IMih6i
	 O5jfI1GiHFgpxpo+HuYXZuHthjNJ5ms74hedEX7TfJmXzkiqMU4TMDwErUdajRxIwQ
	 O4pt4+0jtJrojvbSrwLxvmoUwewjfLJRbfn7zHT383JT3QbYk6+V18BIHn7B/kD2MP
	 StEoMpXkVCDweHzbG1dt+yA7qia0tfLCmQ0MwB57/y5SoTn99bOjhYcKdX9R27adND
	 zlglEGgArKhemOYfUc9dZf2QNGZkqHcblZvwB6M5cK5f9t/nLeFIkPUSeZ5gLNSfSI
	 TJlplUdrP/sww==
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
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [RFC 06/10] ftrace: Use direct hash interface in direct functions
Date: Tue, 29 Jul 2025 12:28:09 +0200
Message-ID: <20250729102813.1531457-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729102813.1531457-1-jolsa@kernel.org>
References: <20250729102813.1531457-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement current *_ftrace_direct function with their *_hash
function counterparts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h        |  17 +--
 kernel/bpf/trampoline.c       |  10 +-
 kernel/trace/ftrace.c         | 242 +++++-----------------------------
 kernel/trace/trace_selftest.c |   5 +-
 4 files changed, 45 insertions(+), 229 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9a6fcdafeda2..85f4ab1a1e72 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -536,11 +536,10 @@ struct ftrace_func_entry {
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 unsigned long ftrace_find_rec_direct(unsigned long ip);
-int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
-int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
+int register_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long addr);
+int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long addr,
 			     bool free_filters);
-int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
-int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
+int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long addr, bool lock_direct_mutex);
 
 int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
 int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
@@ -554,20 +553,16 @@ static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
 }
-static inline int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
+static inline int register_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long addr)
 {
 	return -ENODEV;
 }
-static inline int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
+static inline int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long addr,
 					   bool free_filters)
 {
 	return -ENODEV;
 }
-static inline int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
-{
-	return -ENODEV;
-}
-static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr)
+static inline int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long addr, bool lock_direct_mutex)
 {
 	return -ENODEV;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 0e364614c3a2..6bf272715f0e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -181,7 +181,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
+		ret = unregister_ftrace_direct(tr->fops, (unsigned long) ip, (long)old_addr, false);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
@@ -195,10 +195,7 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 	int ret;
 
 	if (tr->func.ftrace_managed) {
-		if (lock_direct_mutex)
-			ret = modify_ftrace_direct(tr->fops, (long)new_addr);
-		else
-			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
+		ret = modify_ftrace_direct(tr->fops, (unsigned long) ip, (long)new_addr, lock_direct_mutex);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
 	}
@@ -220,8 +217,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	}
 
 	if (tr->func.ftrace_managed) {
-		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
-		ret = register_ftrace_direct(tr->fops, (long)new_addr);
+		ret = register_ftrace_direct(tr->fops, (unsigned long)ip, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fcb8f2d3172b..151ca94f496a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2593,16 +2593,6 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 	return entry->direct;
 }
 
-static void call_direct_funcs(unsigned long ip, unsigned long pip,
-			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
-{
-	unsigned long addr = READ_ONCE(ops->direct_call);
-
-	if (!addr)
-		return;
-
-	arch_ftrace_set_direct_caller(fregs, addr);
-}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
@@ -5935,28 +5925,24 @@ static int check_direct_multi(struct ftrace_ops *ops)
 	return 0;
 }
 
-static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long addr)
+static void register_ftrace_direct_cb(struct rcu_head *rhp)
 {
-	struct ftrace_func_entry *entry, *del;
-	int size, i;
+	struct ftrace_hash *fhp = container_of(rhp, struct ftrace_hash, rcu);
 
-	size = 1 << hash->size_bits;
-	for (i = 0; i < size; i++) {
-		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			del = __ftrace_lookup_ip(direct_functions, entry->ip);
-			if (del && del->direct == addr) {
-				remove_hash_entry(direct_functions, del);
-				kfree(del);
-			}
-		}
-	}
+	free_ftrace_hash(fhp);
 }
 
-static void register_ftrace_direct_cb(struct rcu_head *rhp)
+static struct ftrace_hash *hash_from_ip(unsigned long ip, unsigned long addr)
 {
-	struct ftrace_hash *fhp = container_of(rhp, struct ftrace_hash, rcu);
+	struct ftrace_hash *hash;
 
-	free_ftrace_hash(fhp);
+	ip = ftrace_location(ip);
+	if (!ip)
+		return NULL;
+	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	if (!hash || !add_hash_entry_direct(hash, ip, addr))
+		return NULL;
+	return hash;
 }
 
 /**
@@ -5981,89 +5967,17 @@ static void register_ftrace_direct_cb(struct rcu_head *rhp)
  *  -ENODEV  - @ip does not point to a ftrace nop location (or not supported)
  *  -ENOMEM  - There was an allocation failure.
  */
-int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
+int register_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long addr)
 {
-	struct ftrace_hash *hash, *new_hash = NULL, *free_hash = NULL;
-	struct ftrace_func_entry *entry, *new;
-	int err = -EBUSY, size, i;
-
-	if (ops->func || ops->trampoline)
-		return -EINVAL;
-	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
-		return -EINVAL;
-	if (ops->flags & FTRACE_OPS_FL_ENABLED)
-		return -EINVAL;
-
-	hash = ops->func_hash->filter_hash;
-	if (ftrace_hash_empty(hash))
-		return -EINVAL;
-
-	mutex_lock(&direct_mutex);
-
-	/* Make sure requested entries are not already registered.. */
-	size = 1 << hash->size_bits;
-	for (i = 0; i < size; i++) {
-		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			if (ftrace_find_rec_direct(entry->ip))
-				goto out_unlock;
-		}
-	}
-
-	err = -ENOMEM;
-
-	/* Make a copy hash to place the new and the old entries in */
-	size = hash->count + direct_functions->count;
-	size = fls(size);
-	if (size > FTRACE_HASH_MAX_BITS)
-		size = FTRACE_HASH_MAX_BITS;
-	new_hash = alloc_ftrace_hash(size);
-	if (!new_hash)
-		goto out_unlock;
-
-	/* Now copy over the existing direct entries */
-	size = 1 << direct_functions->size_bits;
-	for (i = 0; i < size; i++) {
-		hlist_for_each_entry(entry, &direct_functions->buckets[i], hlist) {
-			new = add_hash_entry(new_hash, entry->ip);
-			if (!new)
-				goto out_unlock;
-			new->direct = entry->direct;
-		}
-	}
-
-	/* ... and add the new entries */
-	size = 1 << hash->size_bits;
-	for (i = 0; i < size; i++) {
-		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			new = add_hash_entry(new_hash, entry->ip);
-			if (!new)
-				goto out_unlock;
-			/* Update both the copy and the hash entry */
-			new->direct = addr;
-			entry->direct = addr;
-		}
-	}
-
-	free_hash = direct_functions;
-	rcu_assign_pointer(direct_functions, new_hash);
-	new_hash = NULL;
-
-	ops->func = call_direct_funcs;
-	ops->flags = MULTI_FLAGS;
-	ops->trampoline = FTRACE_REGS_ADDR;
-	ops->direct_call = addr;
-
-	err = register_ftrace_function_nolock(ops);
-
- out_unlock:
-	mutex_unlock(&direct_mutex);
-
-	if (free_hash && free_hash != EMPTY_HASH)
-		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
+	struct ftrace_hash *hash;
+	int err;
 
-	if (new_hash)
-		free_ftrace_hash(new_hash);
+	hash = hash_from_ip(ip, addr);
+	if (!hash)
+		return -ENOMEM;
 
+	err = register_ftrace_direct_hash(ops, hash);
+	free_ftrace_hash(hash);
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
@@ -6083,111 +5997,24 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
  *  0 on success
  *  -EINVAL - The @ops object was not properly registered.
  */
-int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
+int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long addr,
 			     bool free_filters)
 {
-	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+	struct ftrace_hash *hash;
 	int err;
 
-	if (check_direct_multi(ops))
-		return -EINVAL;
-	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
-		return -EINVAL;
-
-	mutex_lock(&direct_mutex);
-	err = unregister_ftrace_function(ops);
-	remove_direct_functions_hash(hash, addr);
-	mutex_unlock(&direct_mutex);
-
-	/* cleanup for possible another register call */
-	ops->func = NULL;
-	ops->trampoline = 0;
+	hash = hash_from_ip(ip, addr);
+	if (!hash)
+		return -ENOMEM;
 
+	err = unregister_ftrace_direct_hash(ops, hash);
+	free_ftrace_hash(hash);
 	if (free_filters)
 		ftrace_free_filter(ops);
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
 
-static int
-__modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
-{
-	struct ftrace_hash *hash;
-	struct ftrace_func_entry *entry, *iter;
-	static struct ftrace_ops tmp_ops = {
-		.func		= ftrace_stub,
-		.flags		= FTRACE_OPS_FL_STUB,
-	};
-	int i, size;
-	int err;
-
-	lockdep_assert_held_once(&direct_mutex);
-
-	/* Enable the tmp_ops to have the same functions as the direct ops */
-	ftrace_ops_init(&tmp_ops);
-	tmp_ops.func_hash = ops->func_hash;
-	tmp_ops.direct_call = addr;
-
-	err = register_ftrace_function_nolock(&tmp_ops);
-	if (err)
-		return err;
-
-	/*
-	 * Now the ftrace_ops_list_func() is called to do the direct callers.
-	 * We can safely change the direct functions attached to each entry.
-	 */
-	mutex_lock(&ftrace_lock);
-
-	hash = ops->func_hash->filter_hash;
-	size = 1 << hash->size_bits;
-	for (i = 0; i < size; i++) {
-		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
-			entry = __ftrace_lookup_ip(direct_functions, iter->ip);
-			if (!entry)
-				continue;
-			entry->direct = addr;
-		}
-	}
-	/* Prevent store tearing if a trampoline concurrently accesses the value */
-	WRITE_ONCE(ops->direct_call, addr);
-
-	mutex_unlock(&ftrace_lock);
-
-	/* Removing the tmp_ops will add the updated direct callers to the functions */
-	unregister_ftrace_function(&tmp_ops);
-
-	return err;
-}
-
-/**
- * modify_ftrace_direct_nolock - Modify an existing direct 'multi' call
- * to call something else
- * @ops: The address of the struct ftrace_ops object
- * @addr: The address of the new trampoline to call at @ops functions
- *
- * This is used to unregister currently registered direct caller and
- * register new one @addr on functions registered in @ops object.
- *
- * Note there's window between ftrace_shutdown and ftrace_startup calls
- * where there will be no callbacks called.
- *
- * Caller should already have direct_mutex locked, so we don't lock
- * direct_mutex here.
- *
- * Returns: zero on success. Non zero on error, which includes:
- *  -EINVAL - The @ops object was not properly registered.
- */
-int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr)
-{
-	if (check_direct_multi(ops))
-		return -EINVAL;
-	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
-		return -EINVAL;
-
-	return __modify_ftrace_direct(ops, addr);
-}
-EXPORT_SYMBOL_GPL(modify_ftrace_direct_nolock);
-
 /**
  * modify_ftrace_direct - Modify an existing direct 'multi' call
  * to call something else
@@ -6203,18 +6030,17 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct_nolock);
  * Returns: zero on success. Non zero on error, which includes:
  *  -EINVAL - The @ops object was not properly registered.
  */
-int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
+int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long ip, unsigned long addr, bool lock_direct_mutex)
 {
+	struct ftrace_hash *hash;
 	int err;
 
-	if (check_direct_multi(ops))
-		return -EINVAL;
-	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
-		return -EINVAL;
+	hash = hash_from_ip(ip, addr);
+	if (!hash)
+		return -ENOMEM;
 
-	mutex_lock(&direct_mutex);
-	err = __modify_ftrace_direct(ops, addr);
-	mutex_unlock(&direct_mutex);
+	err = modify_ftrace_direct_hash(ops, hash, lock_direct_mutex);
+	free_ftrace_hash(hash);
 	return err;
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index d88c44f1dfa5..37f5eb1f252b 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -1135,8 +1135,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 * Register direct function together with graph tracer
 	 * and make sure we get graph trace.
 	 */
-	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
-	ret = register_ftrace_direct(&direct,
+	ret = register_ftrace_direct(&direct, (unsigned long)DYN_FTRACE_TEST_NAME,
 				     (unsigned long)ftrace_stub_direct_tramp);
 	if (ret)
 		goto out;
@@ -1159,7 +1158,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 
 	unregister_ftrace_graph(&fgraph_ops);
 
-	ret = unregister_ftrace_direct(&direct,
+	ret = unregister_ftrace_direct(&direct, (unsigned long)DYN_FTRACE_TEST_NAME,
 				       (unsigned long)ftrace_stub_direct_tramp,
 				       true);
 	if (ret)
-- 
2.50.1


