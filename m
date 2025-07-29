Return-Path: <bpf+bounces-64613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D17B14C2E
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A2D18A250C
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B77289E07;
	Tue, 29 Jul 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a42U5aG5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E3288C16;
	Tue, 29 Jul 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784942; cv=none; b=mj1Xr9+x75Z2kVJxq1uCNDkVV1n1GpsKmBN8jm4vQQePzX0t+J3SlXpIXE2VDXeAhyASUhprV9+5TT6AZLcAx0qjtbe7Ai6kJi9a9N1R4M6Wl0yPYqgKNfEL5RONGPdDEIrSNJUVTq75AWO8IVEjuLJ3Z+7Sa6ZdpAqV+YrAdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784942; c=relaxed/simple;
	bh=oE3MjIoq7PdzWxxy/FqOc+ixaBdp6bBF/6oQYdRPSBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIc5R8+sekMw0nc1M2Li/SgRKTwNKIb3fivWRCWX95khNtvRLreSwmM2TSdEi8sL9I51AUVlnv+JJdD4qe4N0uOLRkbOKPcExj3ffjRRqKvcq+EMeEUXUqX4ltSHhfXPSq+WT/of3WHzTSkClnT3Nqsp5m8TcffpM8D83zgB2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a42U5aG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F78DC4CEEF;
	Tue, 29 Jul 2025 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753784941;
	bh=oE3MjIoq7PdzWxxy/FqOc+ixaBdp6bBF/6oQYdRPSBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a42U5aG5a3fObGpx09e13vzlH8lWFxPtU3jQ9W6k96sXIjw38o+IqjNYzqZtTENk6
	 yGK+6RAQOaU4nKzQ8pDHasG6tqGANgcWrLG+oRde7haZ38J9LxP9Z0HzJ3cMwiqLBQ
	 y015CVcacFqd+j0OOXXZ71fgADmsb2NCF+wl/rwk2ezbaERYPFre5ILI3eHdmKE17r
	 EaIfP/zvGSgNXsyfmJST6LXZcQnHaYceMqDsGo3yO/NT2qEm0LoMCHQ+XYVlmJAnHu
	 4KKz+3+HaC1aiuNdFnlZsGi3VIUzZ8j2Q+bdgQcMDkwRGweiyIkrjlbxRGyAZTPPVb
	 kdInU15FKBnNw==
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
Subject: [RFC 04/10] ftrace: Add modify_ftrace_direct_hash function
Date: Tue, 29 Jul 2025 12:28:07 +0200
Message-ID: <20250729102813.1531457-5-jolsa@kernel.org>
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

Adding modify_ftrace_direct_hash function that modifies
all entries (ip -> direct) provided in hash argument.

The difference to current unregister_ftrace_direct is
- hash argument that allows to modify multiple ip -> direct
  entries at once

This change will allow us to have simple ftrace_ops for all bpf
direct interface users in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  6 +++++
 kernel/trace/ftrace.c  | 58 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 7ff6004498c0..8761765d9abc 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -528,6 +528,7 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
 int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
+int modify_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock);
 
 void ftrace_stub_direct_tramp(void);
 
@@ -565,6 +566,11 @@ int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *ha
 	return -ENODEV;
 }
 
+int modify_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
+{
+	return -ENODEV;
+}
+
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d761237ec70f..755d5550ac44 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6440,6 +6440,64 @@ int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *ha
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_hash);
 
+int modify_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
+{
+	struct ftrace_func_entry *entry, *tmp;
+	static struct ftrace_ops tmp_ops = {
+		.func		= ftrace_stub,
+		.flags		= FTRACE_OPS_FL_STUB,
+	};
+	unsigned long size, i;
+	int err;
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
+	if (do_direct_lock)
+		mutex_lock(&direct_mutex);
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
+	/* Removing the tmp_ops will add the updated direct callers to the functions */
+	unregister_ftrace_function(&tmp_ops);
+
+unlock:
+	if (do_direct_lock)
+		mutex_unlock(&direct_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(modify_ftrace_direct_hash);
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.50.1


