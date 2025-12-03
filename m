Return-Path: <bpf+bounces-75950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6546C9E332
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 09:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EC23A952C
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318BD2D0C8A;
	Wed,  3 Dec 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn8G+9ZK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C852C21FF;
	Wed,  3 Dec 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750315; cv=none; b=PE3ud2FSc+sU5K1us3HtInTRo8DdS/Busr4XfAqrVEmamSB2I1cP/wsuvT/yLzWUWVSEPS1LG8q0CFFtxdrbLBLPnV0VDJp4S2Zeo2DrLA8lSqIkG4T0HtBUy6oIAt0al0l2Ihg8JudmAvynoIpmckvg8M7P31F8p3CxK06GrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750315; c=relaxed/simple;
	bh=pLgdjqwxCmhdWC6Ct/H1SR3MVjIRGtL9kTHwK/vSQVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLGia+tHnAUsXPhFMPjf7gvJdSQN2XfVk90imN77FHirJAJv1q2GrHmPSc/H6cMwQoVEZkREoskjPG/7lAiK3kgfyWS7YqJoT1keMsmJapLRLj2mcERSZWaGyoBeiJe72Ka/GlN6khGzv5jCvdB+1hVZ/Bk8t7G+S3FfsIiOyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn8G+9ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6150DC4CEFB;
	Wed,  3 Dec 2025 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764750315;
	bh=pLgdjqwxCmhdWC6Ct/H1SR3MVjIRGtL9kTHwK/vSQVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zn8G+9ZKr+LfhPle/3GxYOBDUz5mKUF0Mk1s4FShEHpgZeVYHOL6VOMlWE22IG9G/
	 B/g7mAdFI2/PcqVDaurUoITlvirqRV7SiEoP1SR+d6MkLOegg97QTxRcjpP2cE2xKy
	 2ZUpSYz5ipWao2WmDEj54jLdc29c+5DGLib6QARHRvaRCIQKiVEyYBcSOsyWbRl8Fr
	 MT/Mxa2X61YnLEk0mxRsa0cYLfSiR0VX5faFFUGlWukljC7DRZvtlK0tG/5iFhwOCw
	 oGcSeLbidHqlFTcOXNiuXIqhpmuOez/zsQF5FjdF+slLyq7HdoX330uERIfaUywGU4
	 7t3UOHMKvV/Fw==
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
Subject: [PATCHv4 bpf-next 6/9] ftrace: Add update_ftrace_direct_mod function
Date: Wed,  3 Dec 2025 09:23:59 +0100
Message-ID: <20251203082402.78816-7-jolsa@kernel.org>
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
index bac9dd784826..c27b7381c5f1 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -552,6 +552,7 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
 int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
+int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock);
 
 void ftrace_stub_direct_tramp(void);
 
@@ -589,6 +590,11 @@ static inline int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace
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
index 01e830be20e3..c77f620b3eb3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6490,6 +6490,78 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
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


