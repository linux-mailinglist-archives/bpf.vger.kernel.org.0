Return-Path: <bpf+bounces-69486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4468FB97A64
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 23:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E874C4A42
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD98E30FC24;
	Tue, 23 Sep 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWaFgWqA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF630F95C;
	Tue, 23 Sep 2025 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664362; cv=none; b=pTH5A4kJgcLeLMVnOuQXAp/WQWbgFrJQ/3LMkXBaebcQd9SpYrc9IajR6hajJEi7S6ibBtzlpcfANawCNXojhBBlAsHpdtWri1XIARnPTBU08T5K364EFhRtQ8RyRg2oYGBV5MKDDHpKXdpHV8dB1nZU5FbxfImEuvPh23LcURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664362; c=relaxed/simple;
	bh=pmgvSXZ8M3DblJ5mReSvIJZRwy/X4JecZikM42Xh1AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYVOIKatCp/uFTgsshaLuRrrM373NJlMtIJ/P+p+Wr6xO1cxDEn92i3h+yFkrXAn8DEoTOBc464YWzmQejJZAKXIrR4K4hsbCCZdrhKb2vx+JJsCCwJrd1oXKRIzBwZB8Joiqe3AW7bDwmbDLRDe/fwTVZa+ceCwtxb8pnpDcrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWaFgWqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F2BC4CEF5;
	Tue, 23 Sep 2025 21:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758664361;
	bh=pmgvSXZ8M3DblJ5mReSvIJZRwy/X4JecZikM42Xh1AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWaFgWqA0PP9vYEvVPItBeOobenZz3qoM+P2SNYzAZs15aInDppLM96GRRkH+GaAr
	 2ErT/bv9j+Tay0R7AfvXMWXQbds/ipp02jc51MKsd+U6FSdeb8UDwWZJ1B7OyO4tpd
	 kvY1LAknkNHDrCMSWzTGcJvTOUpP7u+mZ353V7y/qut2do2VpvOmGz8btOj03VgA7X
	 1mgrQLbs7OX7QiHzZTAiRJGevmLXX9r6kPEywUJ2P5L9Rnnz6TRMicB1ABf1zjVijp
	 TzniDmpUdBRpNclKKUpFaF8Rk/hIDSY97XXPYHZMMbiVM29BxgE2MVUuoMg+UPK7kg
	 ycdOUo9yrhCoQ==
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
Subject: [PATCH 4/9] ftrace: Add modify_ftrace_direct_hash function
Date: Tue, 23 Sep 2025 23:51:42 +0200
Message-ID: <20250923215147.1571952-5-jolsa@kernel.org>
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
index 55f5ead5d4ff..1cf6d0bb9a81 100644
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
index ab5739f72933..4eb08817e4ee 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6427,6 +6427,64 @@ int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *ha
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
2.51.0


