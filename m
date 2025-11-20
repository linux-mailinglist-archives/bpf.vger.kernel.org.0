Return-Path: <bpf+bounces-75189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 783EDC765D6
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 649424E122D
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300E30EF6B;
	Thu, 20 Nov 2025 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGU9vA0u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A92F12CD;
	Thu, 20 Nov 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673905; cv=none; b=S8lKJZU3HwYIy8gZcMAsDaBd6pO7iXrS2xgLkvAR6LbfHRjtEzXWHlJV9KuB4ycArh8OQRtjJKDzA11nrW7SrvJULcjlhzyAk0C39HrVwpYr18d88wAl5ZgkkK206hXyZyx2+1hZw6J9NkYHdX5M6yc3ZmPkUiW63lF30kDJeb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673905; c=relaxed/simple;
	bh=Xs4AEFpvDY6JzCUFXkOpJeETRBiY34vm/qu0XZbAVcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFOeCcV11DI/nm9inkO9vJmcqKKStra/mW0zy7A5/dAhPiPDQhe2lgPKIcvr7IingrpyQL6RXjgAlGhPSpDYK1lsJbarVfhMI3igJAYRty7LRu8q465JXhdHUm/Fqz7U9fxEVWirOPX5ZH4yceGI/DQqlj8FiebaPxjHPReAf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGU9vA0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B4DC4CEF1;
	Thu, 20 Nov 2025 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763673905;
	bh=Xs4AEFpvDY6JzCUFXkOpJeETRBiY34vm/qu0XZbAVcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGU9vA0ucsFWp6B9XXnY7o7XV791mPu6UI5szkwx4hc5qI4Ar7mkhIRSUqfHcfWLw
	 WnyL2dfOIy7ul01z8SglOlCdK0BGZRvpqJoU54BdFa0Q2PIPhuM1JR7EsvAI92A5av
	 FxJkl5TpFwECRDlW1t8ARXeNNkjehxMCh2PeMj7P/dDSIKoztchSBJse5w2EN/ZLym
	 j68/uoJcKgzVGhGO25iu2VlMeCZ7GpgNSCojS7IJO1eIhLIKtauyBFVJ4+g3qhh2D2
	 D36tKfXrrYv/bPlcVgn3C47WYTGeX0GrI5ngPKba7e5YnfftsvAMWNhbs93w8F452J
	 neOuUbAWEmc5g==
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
Subject: [PATCHv3 bpf-next 5/8] ftrace: Add update_ftrace_direct_mod function
Date: Thu, 20 Nov 2025 22:23:59 +0100
Message-ID: <20251120212402.466524-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120212402.466524-1-jolsa@kernel.org>
References: <20251120212402.466524-1-jolsa@kernel.org>
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
 kernel/trace/ftrace.c  | 68 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index c571deeff840..4e2c0ed769fc 100644
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
index cc730a8fd087..5243aefb6096 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6486,6 +6486,74 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	return err;
 }
 
+int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
+{
+	struct ftrace_hash *orig_hash = ops->func_hash->filter_hash;
+	struct ftrace_func_entry *entry, *tmp;
+	static struct ftrace_ops tmp_ops = {
+		.func		= ftrace_stub,
+		.flags		= FTRACE_OPS_FL_STUB,
+	};
+	unsigned long size, i;
+	int err;
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
2.51.1


