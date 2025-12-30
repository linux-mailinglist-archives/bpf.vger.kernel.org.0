Return-Path: <bpf+bounces-77517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F6CE9FC5
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86FE0301E166
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C053176E4;
	Tue, 30 Dec 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkY5645S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126331690A;
	Tue, 30 Dec 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106272; cv=none; b=c4Q/Z0LdObXFlTWiEreb2Prbwxgv3tZQud/l+q6+EFfxjOxcSONmSxESQIHMP8uCGlly/mYXmNIFi4iLlKCY8wBXUUguOwiBPIyEUJr00nNIMkmIhG5MwHTdkSposeLnQZlECMK3UH1ZqC8hu0odxMYOD4xgRzAaJ5KXAtWv6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106272; c=relaxed/simple;
	bh=3UKM0kw1EtWMFlDFQ1Qvy2lN1AtSkYlGoVhjsmE0TqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9VCoeaW5t/n0mh1vVYMav52Me8U+IuGFFNGApVHJXSItcALO/p1RCcm96aylB2Wz72b6dyJZodb8FmLrWnvLRqv8YhQkI7blK+iF+mmlcysyr/uZJgVKXn7SYcCi6Tcx/hp5usOStSzs0tei95gIj9+YEKHFe+5a66P/W4Z1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkY5645S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4150FC19422;
	Tue, 30 Dec 2025 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767106272;
	bh=3UKM0kw1EtWMFlDFQ1Qvy2lN1AtSkYlGoVhjsmE0TqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TkY5645S3Ez9H117822O6ikO1jbuxx643qMIaVT0/7H1Ix3Jz+8BTutdur7ahOOQu
	 XKctShpCl98n1VNVtlCPwuQFX2IMy+samTtc5kN068Q/A7Cl73HxjotKwkijOiSYZ2
	 w1rJEXxFEMS2V5ov4kQcet+LENx7WhU1l0SF1zZpl1bM2Xe7iExIC85ykNcdCSUn6+
	 4Wn3Q//mTJZ91wbLmwcCKeENPuW2N3RLOKiPTWOAzHmMw9fh6vxLMFlimMESzocWAa
	 yTIH6IGwet4UbrE78olZ6VtIV9xmosvIhSjv41Nhk/XuwKcbVO+vBBCEuWESHZSh7p
	 Es16mGXIzd+GQ==
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
Subject: [PATCHv6 bpf-next 5/9] ftrace: Add update_ftrace_direct_del function
Date: Tue, 30 Dec 2025 15:50:06 +0100
Message-ID: <20251230145010.103439-6-jolsa@kernel.org>
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

Adding update_ftrace_direct_del function that removes all entries
(ip -> addr) provided in hash argument to direct ftrace ops and
updates its attachments.

The difference to current unregister_ftrace_direct is
 - hash argument that allows to unregister multiple ip -> direct
   entries at once
 - we can call update_ftrace_direct_del multiple times on the
   same ftrace_ops object, becase we do not need to unregister
   all entries at once, we can do it gradualy with the help of
   ftrace_update_ops function

This change will allow us to have simple ftrace_ops for all bpf
direct interface users in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |   6 ++
 kernel/trace/ftrace.c  | 127 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index f0fcff389061..a3cc1b48c9fc 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -544,6 +544,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
+int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
 
 void ftrace_stub_direct_tramp(void);
 
@@ -576,6 +577,11 @@ static inline int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace
 	return -ENODEV;
 }
 
+static inline int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	return -ENODEV;
+}
+
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3d1170da1bb8..8b75166fb223 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6415,6 +6415,133 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	return err;
 }
 
+/**
+ * hash_sub - substracts @b from @a and returns the result
+ * @a: struct ftrace_hash object
+ * @b: struct ftrace_hash object
+ *
+ * Returns struct ftrace_hash object on success, NULL on error.
+ */
+static struct ftrace_hash *hash_sub(struct ftrace_hash *a, struct ftrace_hash *b)
+{
+	struct ftrace_func_entry *entry, *del;
+	struct ftrace_hash *sub;
+	int size;
+
+	sub = alloc_and_copy_ftrace_hash(a->size_bits, a);
+	if (!sub)
+		return NULL;
+
+	size = 1 << b->size_bits;
+	for (int i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
+			del = __ftrace_lookup_ip(sub, entry->ip);
+			if (WARN_ON_ONCE(!del)) {
+				free_ftrace_hash(sub);
+				return NULL;
+			}
+			remove_hash_entry(sub, del);
+			kfree(del);
+		}
+	}
+	return sub;
+}
+
+/**
+ * update_ftrace_direct_del - Updates @ops by removing its direct
+ * callers provided in @hash
+ * @ops: The address of the struct ftrace_ops object
+ * @hash: The address of the struct ftrace_hash object
+ *
+ * This is used to delete custom direct callers (ip -> addr) in
+ * @ops specified via @hash. The @ops will be either unregistered
+ * updated.
+ *
+ * Returns: zero on success. Non zero on error, which includes:
+ *  -EINVAL - The @hash is empty
+ *  -EINVAL - The @ops is not registered
+ */
+int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	struct ftrace_hash *old_direct_functions = NULL;
+	struct ftrace_hash *new_direct_functions;
+	struct ftrace_hash *new_filter_hash = NULL;
+	struct ftrace_hash *old_filter_hash;
+	struct ftrace_func_entry *entry;
+	struct ftrace_func_entry *del;
+	unsigned long size;
+	int err = -EINVAL;
+
+	if (!hash_count(hash))
+		return -EINVAL;
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+	if (direct_functions == EMPTY_HASH)
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+
+	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
+
+	if (!hash_count(old_filter_hash))
+		goto out_unlock;
+
+	/* Make sure requested entries are already registered. */
+	size = 1 << hash->size_bits;
+	for (int i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			del = __ftrace_lookup_ip(direct_functions, entry->ip);
+			if (!del || del->direct != entry->direct)
+				goto out_unlock;
+		}
+	}
+
+	err = -ENOMEM;
+	new_filter_hash = hash_sub(old_filter_hash, hash);
+	if (!new_filter_hash)
+		goto out_unlock;
+
+	new_direct_functions = hash_sub(direct_functions, hash);
+	if (!new_direct_functions)
+		goto out_unlock;
+
+	/* If there's nothing left, we need to unregister the ops. */
+	if (ftrace_hash_empty(new_filter_hash)) {
+		err = unregister_ftrace_function(ops);
+		if (!err) {
+			/* cleanup for possible another register call */
+			ops->func = NULL;
+			ops->trampoline = 0;
+			ftrace_free_filter(ops);
+			ops->func_hash->filter_hash = NULL;
+		}
+	} else {
+		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
+		/*
+		 * new_filter_hash is dup-ed, so we need to release it anyway,
+		 * old_filter_hash either stays on error or is already released
+		 */
+	}
+
+	if (err) {
+		/* free the new_direct_functions */
+		old_direct_functions = new_direct_functions;
+	} else {
+		rcu_assign_pointer(direct_functions, new_direct_functions);
+	}
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (old_direct_functions && old_direct_functions != EMPTY_HASH)
+		call_rcu_tasks(&old_direct_functions->rcu, register_ftrace_direct_cb);
+	free_ftrace_hash(new_filter_hash);
+
+	return err;
+}
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.52.0


