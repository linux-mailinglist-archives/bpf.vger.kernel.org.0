Return-Path: <bpf+bounces-74395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD453C57742
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAEC934EDE9
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC334DCFE;
	Thu, 13 Nov 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly1opzBc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8F343D6F;
	Thu, 13 Nov 2025 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037564; cv=none; b=oS1ecrEUoGZyERPNdwu0hTyvNsLeE0fAvvRUTfX64C+hkkSvTDQ3jwsBOXEsIqPpfEdnfC0eTMLooKxax4QNiwu2OrskWbiWdeY30ORoAx8OozK1T5cCQCBql3Mq009JsYJNLK9oPLaGo61wftpTRVPOW6gskxdCl0HrUAB95u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037564; c=relaxed/simple;
	bh=6lnmxNPkG0E34Ygby8OhxGAO2e7EP8lGlJEhRaDEjY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5ELFxBsWhqyivrfQYSoUF1eor7ec2u/oUoysKnmoLs3hbAI1YAny5wI4Sdy+8Z/7MbPuTN/63tFbQTX+QsPNfKUaR2Ua2MN2Vfa5cwdcGcrkWSS1ArGvTw77lOGEq0Y1ezka4YD/jlk7Q0/HbdwjOlKJVXP5hyq3q1Mi4oDKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly1opzBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7F1C113D0;
	Thu, 13 Nov 2025 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763037564;
	bh=6lnmxNPkG0E34Ygby8OhxGAO2e7EP8lGlJEhRaDEjY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ly1opzBc4XwGeL7IPF6Z4UE4+mt5GqrbISi94UN8OPlDJnh04mM+gLTYchMWr9DaX
	 tvBjkPCRiaizt5T8xMC0TxXEFnqX7u1smFsz1x2f8H0ghtqb7p/V8/Ki8df34WYcCp
	 vfBS2JxJpcXxYizs5RwvMG7f7uWjIzPm2W9/fYAS9IV38N2d9WLLX3Slll4Nujtb3L
	 RUJHUZLg/QzVLZAiA6iWs1GQ+RsWvzV6EUuh33O4FGo5rtblRIuocskBJ5pE5aqEqR
	 R0MjR33AGDBytrV5rYQL+ytppYMOm7frOsQF+WB7HbNf4lb+ExeRikwgxDDG4XwCUa
	 r4vjV9jjGyaUA==
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
Subject: [PATCHv2 bpf-next 5/8] ftrace: Add update_ftrace_direct_mod function
Date: Thu, 13 Nov 2025 13:37:47 +0100
Message-ID: <20251113123750.2507435-6-jolsa@kernel.org>
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
index 433c36c3af3b..bacb6d9ab426 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -544,6 +544,7 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
 int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
+int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock);
 
 void ftrace_stub_direct_tramp(void);
 
@@ -581,6 +582,11 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
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
index 3dd1e69aceca..e701516a4a65 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6475,6 +6475,74 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
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


