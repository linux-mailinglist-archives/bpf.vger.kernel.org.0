Return-Path: <bpf+bounces-74394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 83522C57739
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F934E434
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6485734DCEC;
	Thu, 13 Nov 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRPlbQ/e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D87346E7A;
	Thu, 13 Nov 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037549; cv=none; b=splelaS/EIy/i7sUxA2+c1wX6VoWHSFUrXMpY2sktgsN8QXeV0PR/Umm1C2jkXaai4TYpyhP8xx67muoEy3YlZjPSsWnTfuetF8WDHhNoiWRDaZbcNqp7KPtEidF9Ie4d2U+RW0dbk0PLdPJ05k/Obx99+uTvXBpsAP9cxR9FOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037549; c=relaxed/simple;
	bh=ZgPgafOsTrCHIaMoJUIubdvBowQLIX9k8MopM5ZtCBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/WGlIW1bQSwf9WwZuORRi9RnzU3FpquVa4Fme9BZ/iMePG8RU7ccxna3uqV4gCqp83bTY2waVUpvQUNT1HSFKApPdEQK7NtKntcplSND1glpJIUVQ74rAA0Q1EA5LLqRF6gfnLlmXv2M6gG95EouRcGT/u28jol96p8mdkz47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRPlbQ/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A25FC4CEF5;
	Thu, 13 Nov 2025 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763037549;
	bh=ZgPgafOsTrCHIaMoJUIubdvBowQLIX9k8MopM5ZtCBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRPlbQ/eRkdKWHi0XtaoJ7Boq++k7y7xE69bxtEDqm+v1VSHl0Ic1dxd/kSoMRQu6
	 jPe/aLAnzzqZ/L/9omGuY4rX7hXsV4EAiL9KPhYGeFEiyDJM2jasZOFcjVQOhYe2x+
	 OS/eLzMeCKBjuN9QiNfpAC6ImAnDvaDyCvqOyKzXCdUq1+RWm9tawpYYRDx54j8GJB
	 Ccbpm6GhG6RLLLtFacBEtwcdWMWVCyIbblPDGI5SUc540oXkfufTtuRTL4VbNWNnNR
	 ELiFR49w0IhbAxU3AHuDgYkT9J5Q0j87VnEboXmhoKy8R6GxCxtwTModpqwvOK+jK0
	 aa/pOqQhRRiMA==
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
Subject: [PATCHv2 bpf-next 4/8] ftrace: Add update_ftrace_direct_del function
Date: Thu, 13 Nov 2025 13:37:46 +0100
Message-ID: <20251113123750.2507435-5-jolsa@kernel.org>
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
 include/linux/ftrace.h |  6 +++
 kernel/trace/ftrace.c  | 99 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ded3a306a8b2..433c36c3af3b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -543,6 +543,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
+int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
 
 void ftrace_stub_direct_tramp(void);
 
@@ -575,6 +576,11 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	return -ENODEV;
 }
 
+int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	return -ENODEV;
+}
+
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0b6e1af8f922..3dd1e69aceca 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6376,6 +6376,105 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
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
+	if (!err) {
+		free_hash = direct_functions;
+		rcu_assign_pointer(direct_functions, new_hash);
+	}
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
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.51.1


