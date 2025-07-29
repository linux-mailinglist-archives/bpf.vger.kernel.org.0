Return-Path: <bpf+bounces-64612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509CBB14C27
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1694D7A68F8
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67A28A1D1;
	Tue, 29 Jul 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYpdw+Ph"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD57254841;
	Tue, 29 Jul 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784931; cv=none; b=i2j4SIEG6Es/tMnarx9NQBlnGMFIBiC0x2Bc3E76vh3LR0V7P6l10trecYKUApeWCaG/NiPSnZ6AtmAi9Chp0l90+mDOV6oA1aUv1wtlNni41qe1ot8ytjD91d5RUA32ty2wnqckfjUIxeS0LUbCtjh5HZ3QufWscS2xvUQqCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784931; c=relaxed/simple;
	bh=h3k3dbcXrYPALSttNREnJ435oHCZsHpXZ8zQdyx2QEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S27suGYM/EJIwRbU54JNLwy6cmP8aKPgWyf9enwtLI2W/b/4xDoI6oRX8qMEtuggMuvLyMWQ9kU5SatIvt4WupVSz+SlmbdrgS4jta57+6KKut106xSckj8Dp9e9p1vQXqX8E4nQCCRS8NHBFbH+fI85S2z5BIWkTQSuuVelvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYpdw+Ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33DEC4CEEF;
	Tue, 29 Jul 2025 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753784930;
	bh=h3k3dbcXrYPALSttNREnJ435oHCZsHpXZ8zQdyx2QEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYpdw+Ph67FkPffntdOi6PrnWlZxh4yCTGTMToqQPOHc4at6u6XbgCY+XOEiDkG2d
	 IEW+R6cUKYMvkfs2s0C67Bjyfs73V6KFcr4s0IaAEQQJC54oELWuzApH3QeFdblp+w
	 FRM+DxOAN9N+uxe9r9IauULWkUxkuNBygGWqwuoXipP58cqIbF4z8vhMEPq1NWnsn+
	 cPrR6M88PkrfcdeA3nZj4kEglWi9ueQq4jnUCf+206U9BBNq0Xl+biu4B88p9kWfIO
	 pnx/SfOorAG02aZj6Ai1ZC+/aBcDQ+Mkvv2TckMf9tIHtrSH74Dec5u8egU4t/cmOS
	 lMr0e+E57ic7A==
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
Subject: [RFC 03/10] ftrace: Add unregister_ftrace_direct_hash function
Date: Tue, 29 Jul 2025 12:28:06 +0200
Message-ID: <20250729102813.1531457-4-jolsa@kernel.org>
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
index e45bcc9de53b..7ff6004498c0 100644
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
index 1dbb113f4e9c..d761237ec70f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6342,6 +6342,104 @@ int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash
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
+
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
2.50.1


