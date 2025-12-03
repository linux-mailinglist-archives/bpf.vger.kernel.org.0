Return-Path: <bpf+bounces-75949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A608DC9E315
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 09:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E93034A1BD
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70E2C374B;
	Wed,  3 Dec 2025 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re5sBgVv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF652C15BB;
	Wed,  3 Dec 2025 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750305; cv=none; b=dbMBxcDLjlKWmbcjyz3PvsLX7LjbOA4ECs7kxZ6Jsdt/MM3mLL5MeDbFQxNVPUYnIgOW6aLdOLl2fsoX0kn4GPgd32p7mXAWrh+/19rt50LLFp7I89p6BaHBlDbLReRNCpt5ewPRMWaZE+QZLBOlODKoRipjlz4y3urKLsQoBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750305; c=relaxed/simple;
	bh=sjHj3Ruu15dXTg7oJ7kSKcH775GCTI2sTuBpJwydfrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAQvJqWyoGu5jJwlnwrOqr6U1UmFdLsP7rcn93bfBBZs7dO+3nlDDvkfkBU7pes5mU0qDPWW9WSlJm+OXqmy3n2LH3uRUv6kfAd3i0UyalQ9JYpmpULXDh+JeCTFT2x3vI9xdXebjxVKcEWdqTHLJCRJNDBRLaWSVvfT1kFG2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re5sBgVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B739C116B1;
	Wed,  3 Dec 2025 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764750305;
	bh=sjHj3Ruu15dXTg7oJ7kSKcH775GCTI2sTuBpJwydfrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=re5sBgVv5u2FxUbViNNVr8qEsmV76iUDcVhnyxz22MjNNnyD5d+Lq0zVbw/S7iQZ3
	 4D8eYze6f14hAhcIL9I8Ahpv+DfNaU7MS7mKvL5fnBWGTd+M0/jMZ/w7Q7srMYkhNU
	 InJisV06XiUpltFa9ekDYXItUweDJHmWtWnZE2sZ8FgPUx5lQaS3i9LEx1QBsIoGa0
	 oCBjBq/CCFBXy6D2FUMoULQrPfeVsu8qT8M3Rl7qfBkqx4EjLwXwvkRvvs2Kr86bbO
	 UOf5KFBtBpnWVehQxggYO/PMXgGMCiY8Jsosqjk4KEQ/rqXKojKsIgIGj3ZplKGSPu
	 O6Y1a9Bvn7XkA==
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
Subject: [PATCHv4 bpf-next 5/9] ftrace: Add update_ftrace_direct_del function
Date: Wed,  3 Dec 2025 09:23:58 +0100
Message-ID: <20251203082402.78816-6-jolsa@kernel.org>
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
 include/linux/ftrace.h |   6 +++
 kernel/trace/ftrace.c  | 113 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index eb60d971ec1d..bac9dd784826 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -551,6 +551,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
+int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
 
 void ftrace_stub_direct_tramp(void);
 
@@ -583,6 +584,11 @@ static inline int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace
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
index 1660a87547dd..01e830be20e3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6377,6 +6377,119 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
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
+	int size, i;
+
+	sub = alloc_and_copy_ftrace_hash(a->size_bits, a);
+	if (!sub)
+		goto error;
+
+	size = 1 << b->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
+			del = __ftrace_lookup_ip(sub, entry->ip);
+			if (WARN_ON_ONCE(!del))
+				goto error;
+			remove_hash_entry(sub, del);
+			kfree(del);
+		}
+	}
+	return sub;
+
+ error:
+	free_ftrace_hash(sub);
+	return NULL;
+}
+
+int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions = NULL;
+	struct ftrace_hash *old_filter_hash = NULL, *new_filter_hash = NULL;
+	struct ftrace_func_entry *del, *entry;
+	unsigned long size, i;
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
+	old_direct_functions = direct_functions;
+
+	if (!hash_count(old_filter_hash))
+		goto out_unlock;
+
+	/* Make sure requested entries are already registered. */
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
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
+	new_direct_functions = hash_sub(old_direct_functions, hash);
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
+		 * old_filter_hash either stays on error or is released already
+		 */
+	}
+
+	if (err) {
+		/* reset direct_functions and free the new one */
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


