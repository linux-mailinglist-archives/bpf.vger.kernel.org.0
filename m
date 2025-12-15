Return-Path: <bpf+bounces-76637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C650CBFE3C
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 22:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53F313024AFA
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248032D0D3;
	Mon, 15 Dec 2025 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af6OpNzq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1A2DE1E0;
	Mon, 15 Dec 2025 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833319; cv=none; b=T/T6N5dxoIB0bP9oE/odYSc1u0ScKN5tSxK+36cNW8IMoC9chbDPPrkc3UaT4Q1Lnp35Rf1FE1tc7cVJRnrsig7IuVKQu3bq3LBwIi3kR54WpEqurccyMaxzXr36Uu6rVIt5gJxgFjZBePDvHeHbnP5TUyf2W53R0N58/mHwO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833319; c=relaxed/simple;
	bh=p6gqLffg23UILKDsdjUK8VuxMZVSEGZ26VdVvM6E4Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bj5z+FAY7LT1aI7keFzCi2IuvZ2m2EQXtkI/7Hyc1bdbWZkcivapQQKCTADIo2TfE3DbJqe6NHXVxICjpsVwZg7bRAvpqiusuXI37TJx5Ttwv10V2E1mMUdlTxzSHMFcegCYbMxGF5rgLr6i8/4jf5tIkjxUW0nEHGr4wYW7jrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af6OpNzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B31C16AAE;
	Mon, 15 Dec 2025 21:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765833318;
	bh=p6gqLffg23UILKDsdjUK8VuxMZVSEGZ26VdVvM6E4Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Af6OpNzq71MMfPjqgppB3DbyU1JFHnVbLu7u99k3Fr1SdUKtHcDJGXmpxRn40xMiQ
	 pjuHBGySCVEXLLBXBL4iFFCHeryRxDJmIhfF+5w6edhWhhiWZZnPr4zIz//MCBAyVN
	 j3DMzV3tdMqUij5mAbwo5nDW6G6KmYkCgaftGzyM8noRwKpcgZGK0D95geAg6pqCBa
	 DnwxfsQTy8vctJwstW3F3wTXq22AdwtiCC04luxMnsSgoE9P/viKWRxys/Y6AiClOw
	 9q/rLqt1SGc0hLYDx0oVdOWPx+mklPwZCYfwZzpVLcOQL5Ld8vVtA5KS1rVVEQvCd3
	 65RC8yoyu5s+g==
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
Subject: [PATCHv5 bpf-next 6/9] ftrace: Add update_ftrace_direct_mod function
Date: Mon, 15 Dec 2025 22:13:59 +0100
Message-ID: <20251215211402.353056-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215211402.353056-1-jolsa@kernel.org>
References: <20251215211402.353056-1-jolsa@kernel.org>
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
 include/linux/ftrace.h |  6 ++++
 kernel/trace/ftrace.c  | 72 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ac4b473c7fd3..c3bf9cede1fe 100644
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
index 48dc0de5f2ce..95a38fb18ed7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6489,6 +6489,78 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	return err;
 }
 
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


