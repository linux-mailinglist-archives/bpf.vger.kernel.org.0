Return-Path: <bpf+bounces-77518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBBFCE9FDA
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20DFB3075F16
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563031A7E3;
	Tue, 30 Dec 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUXc+yTI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F43191CE;
	Tue, 30 Dec 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106283; cv=none; b=kEQyUXzPpfERVfplfgELwPHS5rHUuH6DVDnfMSYkYRvLGNyjL0hHF6E1Jjz64CRDykRMeSq7SKA0m1D1qzYp2GjC52IgIXVr/yt3lYVjGQ515cX2IB99EgFZDCsqG9YSYqeV7eHGuCMDn0qrHeO5/pkFw6NnTyLMPG/tnUvz2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106283; c=relaxed/simple;
	bh=rQ2iTT+yI1RxB3ZOf5yqVU+kkCf2GWoXN4fuBj4HQFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1Jn6Cq0JY8J71E+x/OWr/829WpKrbI4D5046NW8LbjdU5F5v/5bY3BbYASpy3G0lL52cdQQfsXUB3xdVhcCaHDLRJffxr3Xn+lZPvZFF6rCotlTVvjojCW9l3qSnyp151xpSy+8Ocj3vYiSnHIvOzN6+t+3QE6iz9wWD+qUxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUXc+yTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0177C4CEFB;
	Tue, 30 Dec 2025 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767106282;
	bh=rQ2iTT+yI1RxB3ZOf5yqVU+kkCf2GWoXN4fuBj4HQFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fUXc+yTIU2u3TkJ9XVhrI2uuB61jgcjXj9LT+fxq6j8kT3aank129i3vbPoPDsGh8
	 iA+eOIcmv/NEB08NF1hoIaB6WqJJ6Vpv/m0Fjy9fwuS4tINMiaxzSwmIUXdjKKvkqh
	 4SOEqRfvQs3aVq0YHp+ymoyR0T4JdJ8oNgA4NgegoMTHSuhnpWwybfKvRxmH+hmViw
	 0QtJ7mdqFGPp9baHWyprwzi+5I0E6HIqsB5R6ZtHgCDwL72GBIsC8PDpE/gUGOh2zy
	 ZFUodG0rRVZGRVilXIpPTRzIFuBGU3U73P8knefkOMGE3L4IiQgkfk4u+qeJEXDqa9
	 AShJM3+0Xillw==
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
Subject: [PATCHv6 bpf-next 6/9] ftrace: Add update_ftrace_direct_mod function
Date: Tue, 30 Dec 2025 15:50:07 +0100
Message-ID: <20251230145010.103439-7-jolsa@kernel.org>
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

Adding update_ftrace_direct_mod function that modifies all entries
(ip -> direct) provided in hash argument to direct ftrace ops and
updates its attachments.

The difference to current modify_ftrace_direct is:
- hash argument that allows to modify multiple ip -> direct
  entries at once

This change will allow us to have simple ftrace_ops for all bpf
direct interface users in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  6 +++
 kernel/trace/ftrace.c  | 94 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a3cc1b48c9fc..6c1680ab8bf9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -545,6 +545,7 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
 int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
+int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock);
 
 void ftrace_stub_direct_tramp(void);
 
@@ -582,6 +583,11 @@ static inline int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace
 	return -ENODEV;
 }
 
+static inline int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
+{
+	return -ENODEV;
+}
+
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8b75166fb223..d24f28677007 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6542,6 +6542,100 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	return err;
 }
 
+/**
+ * update_ftrace_direct_mod - Updates @ops by modifing its direct
+ * callers provided in @hash
+ * @ops: The address of the struct ftrace_ops object
+ * @hash: The address of the struct ftrace_hash object
+ * @do_direct_lock: If true lock the direct_mutex
+ *
+ * This is used to modify custom direct callers (ip -> addr) in
+ * @ops specified via @hash.
+ *
+ * This can be called from within ftrace ops_func callback with
+ * direct_mutex already locked, in which case @do_direct_lock
+ * needs to be false.
+ *
+ * Returns: zero on success. Non zero on error, which includes:
+ *  -EINVAL - The @hash is empty
+ *  -EINVAL - The @ops is not registered
+ */
+int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
+{
+	struct ftrace_func_entry *entry, *tmp;
+	static struct ftrace_ops tmp_ops = {
+		.func		= ftrace_stub,
+		.flags		= FTRACE_OPS_FL_STUB,
+	};
+	struct ftrace_hash *orig_hash;
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
+	/*
+	 * We can be called from within ops_func callback with direct_mutex
+	 * already taken.
+	 */
+	if (do_direct_lock)
+		mutex_lock(&direct_mutex);
+
+	orig_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
+	if (!orig_hash)
+		goto unlock;
+
+	/* Enable the tmp_ops to have the same functions as the direct ops */
+	ftrace_ops_init(&tmp_ops);
+	tmp_ops.func_hash = ops->func_hash;
+
+	err = register_ftrace_function_nolock(&tmp_ops);
+	if (err)
+		goto unlock;
+
+	/*
+	 * Call __ftrace_hash_update_ipmodify() here, so that we can call
+	 * ops->ops_func for the ops. This is needed because the above
+	 * register_ftrace_function_nolock() worked on tmp_ops.
+	 */
+	err = __ftrace_hash_update_ipmodify(ops, orig_hash, orig_hash, true);
+	if (err)
+		goto out;
+
+	/*
+	 * Now the ftrace_ops_list_func() is called to do the direct callers.
+	 * We can safely change the direct functions attached to each entry.
+	 */
+	mutex_lock(&ftrace_lock);
+
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			tmp = __ftrace_lookup_ip(direct_functions, entry->ip);
+			if (!tmp)
+				continue;
+			tmp->direct = entry->direct;
+		}
+	}
+
+	mutex_unlock(&ftrace_lock);
+
+out:
+	/* Removing the tmp_ops will add the updated direct callers to the functions */
+	unregister_ftrace_function(&tmp_ops);
+
+unlock:
+	if (do_direct_lock)
+		mutex_unlock(&direct_mutex);
+	return err;
+}
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.52.0


