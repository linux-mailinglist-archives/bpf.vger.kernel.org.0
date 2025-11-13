Return-Path: <bpf+bounces-74393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4081C5777B
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7A13B38E2
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453034DB74;
	Thu, 13 Nov 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsiMcAyA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F351E343D6F;
	Thu, 13 Nov 2025 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037535; cv=none; b=rIYKod17265BkXZf15tNefsSe6WTOJsGPoBw8bzd1o13YpINXHv6GQ8iBki1WuTAA0vnyepCW/kUV46h5emRR7lv43MPDTQsWNOBJ+zqjK3jaeDcpLzsX+7zmZqE23y5Uz0j2Sn9U4F3U0e8vo4lSkOgwSRPw0vuGyKipXLlu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037535; c=relaxed/simple;
	bh=2L8Cv7+CJlNsi8+VaT6s8vY/MYuUezNjCR97Nxio15Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9toKu1H91ALfVz/KNdLsxVdulmo9IxAb5tImQ4+EMXlDL4vMiHJPfXF1sED4KZQMC8GlMNOU4Q2F0SBiWDdOJXNOZpldr5zihh9ocxWbm5rWk4EK+SMFVcVqve4QtS29IRKh6C9LGRwJ7fRbZG7O8/VD458z/M0yj3GyI89+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsiMcAyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DD6C2BC86;
	Thu, 13 Nov 2025 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763037534;
	bh=2L8Cv7+CJlNsi8+VaT6s8vY/MYuUezNjCR97Nxio15Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsiMcAyAjDGGTbQlYFSk7S/EVT2cSlB9/Ye+v5U4wqUxDhrzFRNLVlVh8goMJTltO
	 pw7nQv99VhdbPQc/vbVkfQd9QewET08mW3Gx63+WXxccngLoDUhgv1ccPclkTiJmzu
	 a6TReY8HcAal4+UAvihkxYHtS3dmZyetO7jhJCucT3/PmnW1r7kyiMuj1gnHFK2+TB
	 MaF3FaOyV4ru828jAhdm2M3spBemumSpi16LkDHD2uhkf4bD8sWZQsjWU/ejpj6lxy
	 BFworAKvrjlcZes7EF4tq7ELtJ1J/XNtYctb6WQEroniU7PCoXazQrHdtwNdrVYnu7
	 rsZBMcubHWO6A==
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
Subject: [PATCHv2 bpf-next 3/8] ftrace: Add update_ftrace_direct_add function
Date: Thu, 13 Nov 2025 13:37:45 +0100
Message-ID: <20251113123750.2507435-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113123750.2507435-1-jolsa@kernel.org>
References: <20251113123750.2507435-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding update_ftrace_direct_add function that adds all entries
(ip -> addr) provided in hash argument to direct ftrace ops
and updates its attachments.

The difference to current register_ftrace_direct is
 - hash argument that allows to register multiple ip -> direct
   entries at once
 - we can call update_ftrace_direct_add multiple times on the
   same ftrace_ops object, becase after first registration with
   register_ftrace_function_nolock, it uses ftrace_update_ops to
   update the ftrace_ops object

This change will allow us to have simple ftrace_ops for all bpf
direct interface users in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |   7 +++
 kernel/trace/ftrace.c  | 128 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e23e6a859e08..ded3a306a8b2 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -542,6 +542,8 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
+int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
+
 void ftrace_stub_direct_tramp(void);
 
 #else
@@ -568,6 +570,11 @@ static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned l
 	return -ENODEV;
 }
 
+int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	return -ENODEV;
+}
+
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e6ccf572c5f6..0b6e1af8f922 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6248,6 +6248,134 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
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
+int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions = NULL;
+	struct ftrace_hash *old_filter_hash = NULL, *new_filter_hash = NULL;
+	struct ftrace_func_entry *entry;
+	int i, size, err = -EINVAL;
+	bool reg;
+
+	if (!hash_count(hash))
+		return 0;
+
+	mutex_lock(&direct_mutex);
+
+	/* Make sure requested entries are not already registered. */
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			if (__ftrace_lookup_ip(direct_functions, entry->ip))
+				goto out_unlock;
+		}
+	}
+
+	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
+	old_direct_functions = direct_functions;
+
+	/* If there's nothing in filter_hash we need to register the ops. */
+	reg = hash_count(old_filter_hash) == 0;
+	if (reg) {
+		if (ops->func || ops->trampoline)
+			goto out_unlock;
+		if (ops->flags & FTRACE_OPS_FL_ENABLED)
+			goto out_unlock;
+	}
+
+	err = -ENOMEM;
+	new_filter_hash = hash_add(old_filter_hash, hash);
+	if (!new_filter_hash)
+		goto out_unlock;
+
+	new_direct_functions = hash_add(old_direct_functions, hash);
+	if (!new_direct_functions)
+		goto out_unlock;
+
+	rcu_assign_pointer(direct_functions, new_direct_functions);
+
+	if (reg) {
+		ops->func = call_direct_funcs;
+		ops->flags |= MULTI_FLAGS;
+		ops->trampoline = FTRACE_REGS_ADDR;
+		ops->local_hash.filter_hash = new_filter_hash;
+
+		err = register_ftrace_function_nolock(ops);
+		if (err) {
+			/* restore old filter on error */
+			ops->local_hash.filter_hash = old_filter_hash;
+			old_filter_hash = new_filter_hash;
+
+			/* cleanup for possible another register call */
+			ops->func = NULL;
+			ops->trampoline = 0;
+		}
+	} else {
+		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
+		/*
+		 * new_filter_hash is dup-ed, so we need to release it anyway,
+		 * old_filter_hash either stays on error or is released already
+		 */
+		old_filter_hash = new_filter_hash;
+	}
+
+	if (err) {
+		/* reset direct_functions and free the new one */
+		rcu_assign_pointer(direct_functions, old_direct_functions);
+		old_direct_functions = new_direct_functions;
+	}
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (old_direct_functions && old_direct_functions != EMPTY_HASH)
+		call_rcu_tasks(&old_direct_functions->rcu, register_ftrace_direct_cb);
+	if (old_filter_hash)
+		free_ftrace_hash(old_filter_hash);
+
+	return err;
+}
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.51.1


