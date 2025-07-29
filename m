Return-Path: <bpf+bounces-64611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E0B14C25
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C161C18A140B
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C428A1C3;
	Tue, 29 Jul 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvoNT2pk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E3254841;
	Tue, 29 Jul 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784919; cv=none; b=SCVmdTGhZ7dX5Wr8uruRNkCbwwHM78rKJevcQlGGMbA4QyQ6tqOKx4K6M2li7JSTexfPd9kndpJUgaff4YiNBDRuZpDO7hn4l6x8y+o7BhhtUzJ3F6/LJobQHeyuMoUQ7t2rycIXa/5RiSFu1jEFyqA7J8Hj2p+Pj/x2wkKa2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784919; c=relaxed/simple;
	bh=PoVJYmha+F5Q+Shyh8Z6KZj91FS00Vyug/N39XeYgMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di9yNkO5Ja2NBSzHYqwzmrjjaNNKSeLDo/htf7gnIxzyBvbwaWAsl8kIlElSpcJde/mQQMdk7JNOXeNZCSgPPKxcgtMhPE5Ac6ingbGW2l3oaSOWcqgNgtIM6u5uBtfECGqvjGb69TYL2A7/6sLNFsFG/D0nKgpT+HQ5sJrGtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvoNT2pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CB7C4CEEF;
	Tue, 29 Jul 2025 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753784919;
	bh=PoVJYmha+F5Q+Shyh8Z6KZj91FS00Vyug/N39XeYgMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvoNT2pkbNwrm9T3+/0Qy1iPrq8hPGDjfzb55rvDPU92Tp6ra268grQaNQUx/5YMG
	 flGt4OoLgVr05TK/y0/MaDFjfeaCK9Nmax3CMWqKkBtEQsUomO5+nm4IinpJJAoxKo
	 DiuxSJys3Fu7aNhh/s7CmnP1JP7ESYd+2zu8r4pwK+SC6W8TDAlos1TLXwn6yIJSw5
	 PLqtuv8SRR78GdCvlV+OXenW26soPrMNPSXYxcVCGLhK0yavus3sL3n35uoWAykTU2
	 3r2sseihRrqZPsOB0wjVMzNJ/ibme2TeBY6y8zW9RNF7faQPJ10WIm8FXw+7goiAEU
	 yXy0ct+8CUksg==
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
Subject: [RFC 02/10] ftrace: Add register_ftrace_direct_hash function
Date: Tue, 29 Jul 2025 12:28:05 +0200
Message-ID: <20250729102813.1531457-3-jolsa@kernel.org>
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

Adding register_ftrace_direct_hash function that registers
all entries (ip -> direct) provided in hash argument.

The difference to current register_ftrace_direct is
 - hash argument that allows to register multiple ip -> direct
   entries at once
 - we can call register_ftrace_direct_hash multiple times on the
   same ftrace_ops object, becase after first registration with
   register_ftrace_function_nolock, it uses ftrace_update_ops to
   update the ftrace_ops object

This change will allow us to have simple ftrace_ops for all bpf
direct interface users in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |   7 +++
 kernel/trace/ftrace.c  | 123 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b672ca15f265..e45bcc9de53b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -526,6 +526,8 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
+int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
+
 void ftrace_stub_direct_tramp(void);
 
 #else
@@ -552,6 +554,11 @@ static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned l
 	return -ENODEV;
 }
 
+int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	return -ENODEV;
+}
+
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5b8f565a1258..1dbb113f4e9c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6219,6 +6219,129 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	return err;
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
+
+static unsigned long hash_count(struct ftrace_hash *hash)
+{
+	return hash ? hash->count : 0;
+}
+
+/**
+ * hash_add - adds two struct ftrace_hash and returns the result
+ * @a: struct ftrace_hash object
+ * @b: struct ftrace_hash object
+ *
+ * Returns struct ftrace_hash object on success, NULL on error.
+ */
+static struct ftrace_hash *hash_add(struct ftrace_hash *a, struct ftrace_hash *b)
+{
+	struct ftrace_func_entry *entry;
+	struct ftrace_hash *add;
+	int size, i;
+
+	size = hash_count(a) + hash_count(b);
+	if (size > 32)
+		size = 32;
+
+	add = alloc_and_copy_ftrace_hash(fls(size), a);
+	if (!add)
+		goto error;
+
+	size = 1 << b->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
+			if (add_hash_entry_direct(add, entry->ip, entry->direct) == NULL)
+				goto error;
+		}
+	}
+	return add;
+
+ error:
+	free_ftrace_hash(add);
+	return NULL;
+}
+
+static void call_direct_funcs_hash(unsigned long ip, unsigned long pip,
+				   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	unsigned long addr;
+
+	addr = ftrace_find_rec_direct(ip);
+	if (!addr)
+		return;
+
+	arch_ftrace_set_direct_caller(fregs, addr);
+}
+
+int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	struct ftrace_hash *filter_hash = NULL, *new_hash = NULL, *free_hash = NULL;
+	struct ftrace_func_entry *entry;
+	int i, size, err;
+	bool reg;
+
+	if (!hash_count(hash))
+		return 0;
+
+	mutex_lock(&direct_mutex);
+
+	/* Make sure requested entry is not already registered. */
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			if (__ftrace_lookup_ip(direct_functions, entry->ip))
+				goto out_unlock;
+		}
+	}
+
+	filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
+
+	/* If there's nothing in filter_hash we need to register the ops. */
+	reg = hash_count(filter_hash) == 0;
+	if (reg) {
+		if (ops->func || ops->trampoline)
+			goto out_unlock;
+		if (ops->flags & FTRACE_OPS_FL_ENABLED)
+			goto out_unlock;
+	}
+
+	filter_hash = hash_add(filter_hash, hash);
+	if (!filter_hash)
+		goto out_unlock;
+
+	new_hash = hash_add(direct_functions, hash);
+	if (!new_hash)
+		goto out_unlock;
+
+	free_hash = direct_functions;
+	rcu_assign_pointer(direct_functions, new_hash);
+	new_hash = NULL;
+
+	if (reg) {
+		ops->func = call_direct_funcs_hash;
+		ops->flags = MULTI_FLAGS;
+		ops->trampoline = FTRACE_REGS_ADDR;
+		ops->local_hash.filter_hash = filter_hash;
+
+		err = register_ftrace_function_nolock(ops);
+		if (!err)
+			filter_hash = NULL;
+	} else {
+		err = ftrace_update_ops(ops, filter_hash, EMPTY_HASH);
+	}
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (free_hash && free_hash != EMPTY_HASH)
+		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
+
+	if (filter_hash)
+		free_ftrace_hash(filter_hash);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(register_ftrace_direct_hash);
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.50.1


