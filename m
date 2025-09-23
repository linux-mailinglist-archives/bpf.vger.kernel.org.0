Return-Path: <bpf+bounces-69485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A26BB97A5E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 23:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EDF3220CA
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2501230EF9E;
	Tue, 23 Sep 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbPDkg8x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4130F552;
	Tue, 23 Sep 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664351; cv=none; b=YCjgZrYYZLfwXOcV/4jwxVTxb4Y0wDejqFjA/KoSt7WmUxwEQ5kn1NmeDiBcIXzVIycN+WLXVw5q4ctAgO3M5DUUSze/bf5VKr6r4l5flwue7CYFXYsmo+V+X4exgJZWQE19KRXggQm90y0LKiL9nuPLDIvJHSFux5bOCB1kJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664351; c=relaxed/simple;
	bh=BULakDdKw0A4NZGkv919IsMp+rW5CmZOYDx2mdUjOFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTlyli4McVqF7SsRxaGxbTQylgHMT1IkZ6/wijW1WfQQoPW4m38+flninm8wOZ/C/Qv9DOLDZtTZX+4PohJHI6wgbwMTK0JsXZGp6q69kohVTDufdwLgcGBdF1EyV/gH198/hZTHjGDJ2Ct5MLCOVsMxR0LYe74bDSFsC9JnIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbPDkg8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5A7C4CEF5;
	Tue, 23 Sep 2025 21:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758664351;
	bh=BULakDdKw0A4NZGkv919IsMp+rW5CmZOYDx2mdUjOFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbPDkg8x5vH27VfUoF+koTvyt23ssm+a7u9uXZl1YlS2HNFgfS/7XXfJJcS36jBK+
	 jbI0CCQwFbtQmwdOyJUvQVRVRLOnaomAwjKVnHzJlEMNZ7MsqpA/Hi9F/qxuFUNWVx
	 iZqOyoV41gMhmdN2/QBQgUO8pTSfw2YthTD/82vNjswNC9ftWo3DzQDeriMn8V51WJ
	 4QUpXkEpfQZ9mRg7szIgWPrpYfg3LfGY59rOM9URqQDQTBOYCpp4RwL10WqZlRfHgb
	 0PPOBNd2hpo/yAWgbRVCF8pm1SDCpjwqIQqAJxTL2hpp7trEedJx/XLhPz0U5mZ02H
	 Q1QkPGTs/N0Bw==
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
Subject: [PATCH 3/9] ftrace: Add unregister_ftrace_direct_hash function
Date: Tue, 23 Sep 2025 23:51:41 +0200
Message-ID: <20250923215147.1571952-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923215147.1571952-1-jolsa@kernel.org>
References: <20250923215147.1571952-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding unregister_ftrace_direct_hash function that unregisters
all entries (ip -> direct) provided in hash argument.

The difference to current unregister_ftrace_direct is
 - hash argument that allows to unregister multiple ip -> direct
   entries at once
 - we can call unregister_ftrace_direct_hash multiple times on the
   same ftrace_ops object, becase we do not need to unregister
   all entries at once, we can do it gradualy with the help of
   ftrace_update_ops function

This change will allow us to have simple ftrace_ops for all bpf
direct interface users in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  6 +++
 kernel/trace/ftrace.c  | 98 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 2705c292341a..55f5ead5d4ff 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -527,6 +527,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
+int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
 
 void ftrace_stub_direct_tramp(void);
 
@@ -559,6 +560,11 @@ int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash
 	return -ENODEV;
 }
 
+int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	return -ENODEV;
+}
+
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 06528af2281f..ab5739f72933 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6329,6 +6329,104 @@ int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct_hash);
 
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
+int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	struct ftrace_hash *new_hash = NULL, *filter_hash = NULL, *free_hash = NULL;
+	struct ftrace_func_entry *del, *entry;
+	unsigned long size, i;
+	int err = -EINVAL;
+
+	if (!hash_count(hash))
+		return 0;
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+	if (direct_functions == EMPTY_HASH)
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
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
+	filter_hash = hash_sub(ops->func_hash->filter_hash, hash);
+	if (!filter_hash)
+		goto out_unlock;
+
+	new_hash = hash_sub(direct_functions, hash);
+	if (!new_hash)
+		goto out_unlock;
+
+	/* If there's nothing left, we need to unregister the ops. */
+	if (ftrace_hash_empty(filter_hash)) {
+		err = unregister_ftrace_function(ops);
+		/* cleanup for possible another register call */
+		ops->func = NULL;
+		ops->trampoline = 0;
+		ftrace_free_filter(ops);
+		ops->func_hash->filter_hash = NULL;
+	} else {
+		err = ftrace_update_ops(ops, filter_hash, EMPTY_HASH);
+	}
+
+	free_hash = direct_functions;
+	rcu_assign_pointer(direct_functions, new_hash);
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (free_hash && free_hash != EMPTY_HASH)
+		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
+	if (filter_hash)
+		free_ftrace_hash(filter_hash);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(unregister_ftrace_direct_hash);
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.51.0


