Return-Path: <bpf+bounces-75187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20904C765DC
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FDB6359ACB
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC131691B;
	Thu, 20 Nov 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWEoZaeH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB273074B1;
	Thu, 20 Nov 2025 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673884; cv=none; b=BRcX+1D5AL19uVPKIdIdcDkJ+Hfh4dBw3gB+JiERInD0HFs6wjl28ynWpmkcuZEj3D2fmNc+tXXYYCBCd2Xmu5LBE1hPtwyciqTu0caiT21muGPitazwx0AjAgMCHqZGgLwejpnW6SjjrsKLk0xD6+rcj8pqGJDdzv4wXjQR5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673884; c=relaxed/simple;
	bh=RNLSBGOz/DOmnUQjRG3FQUkHTupM2083U1onRORQjXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEDbFuDxRoAMZqkmVM9cfief1Gw+wchL2k9iVc37BM/LwMZm7tMiMrxxPn7ChpajqZZ3SgWgru3DwSwtoNf9kQuHfblXo/FWXzRt90V+/a3774MsYplEdwcb5M1Lvn6AU6m71GP8/V4pMRgfaurf/jYphVEJRwWuEwivzb69ET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWEoZaeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BB2C4CEF1;
	Thu, 20 Nov 2025 21:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763673884;
	bh=RNLSBGOz/DOmnUQjRG3FQUkHTupM2083U1onRORQjXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWEoZaeHrw5zFW7xdxxw9Ezq7RJXLLmZc32rJRlKB4kG04794aKukSETz38/gDSn4
	 +kaiW0dV69nvkWPoEbtRSsH96MSXYhQzZ/W6qzY6sE4xtGoh/s/dhsP9Ox9fRw9MFA
	 vDcSrH+iqeq5ErAOsYH/RpuLRbEUHJuuJ+faLkLqaYzsYDyRxDsWq3FTGGlsYn88q0
	 Klb3r23xIiBWIh+DjBiPiAIH4yUssV8EUJ6xwJ7eg3YGwMa/ljVDh6HOMDTMzrccQM
	 FgF2ow0uXhfIyvUAkML0uu1NsmopI4CrhjslX7Wr9gSnczo09AQP+PiOyljOnkRxz8
	 03BPjaBEae1UA==
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
Subject: [PATCHv3 bpf-next 3/8] ftrace: Add update_ftrace_direct_add function
Date: Thu, 20 Nov 2025 22:23:57 +0100
Message-ID: <20251120212402.466524-4-jolsa@kernel.org>
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

Adding update_ftrace_direct_add function that adds all entries
(ip -> addr) provided in hash argument to direct ftrace ops
and updates its attachments.

The difference to current register_ftrace_direct is
 - hash argument that allows to register multiple ip -> direct
   entries at once
 - we can call update_ftrace_direct_add multiple times on the
   same ftrace_ops object, becase after first registration with
   register_ftrace_function_nolock, it uses ftrace_update_ops to
   update the ftrace_ops object

This change will allow us to have simple ftrace_ops for all bpf
direct interface users in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |   7 +++
 kernel/trace/ftrace.c  | 128 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 5752553bff60..9cf4cd56d982 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -550,6 +550,8 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
+int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
+
 void ftrace_stub_direct_tramp(void);
 
 #else
@@ -576,6 +578,11 @@ static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned l
 	return -ENODEV;
 }
 
+static inline int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	return -ENODEV;
+}
+
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e6ccf572c5f6..850ff55ff25e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6248,6 +6248,134 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	return err;
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
+
+static unsigned long hash_count(struct ftrace_hash *hash)
+{
+	return hash ? hash->count : 0;
+}
+
+/**
+ * hash_add - adds two struct ftrace_hash and returns the result
+ * @a: struct ftrace_hash object
+ * @b: struct ftrace_hash object
+ *
+ * Returns struct ftrace_hash object on success, NULL on error.
+ */
+static struct ftrace_hash *hash_add(struct ftrace_hash *a, struct ftrace_hash *b)
+{
+	struct ftrace_func_entry *entry;
+	struct ftrace_hash *add;
+	int size, i;
+
+	size = hash_count(a) + hash_count(b);
+	if (size > 32)
+		size = 32;
+
+	add = alloc_and_copy_ftrace_hash(fls(size), a);
+	if (!add)
+		goto error;
+
+	size = 1 << b->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
+			if (add_hash_entry_direct(add, entry->ip, entry->direct) == NULL)
+				goto error;
+		}
+	}
+	return add;
+
+ error:
+	free_ftrace_hash(add);
+	return NULL;
+}
+
+int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
+{
+	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions = NULL;
+	struct ftrace_hash *old_filter_hash = NULL, *new_filter_hash = NULL;
+	struct ftrace_func_entry *entry;
+	int i, size, err = -EINVAL;
+	bool reg;
+
+	if (!hash_count(hash))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+
+	/* Make sure requested entries are not already registered. */
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			if (__ftrace_lookup_ip(direct_functions, entry->ip))
+				goto out_unlock;
+		}
+	}
+
+	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
+	old_direct_functions = direct_functions;
+
+	/* If there's nothing in filter_hash we need to register the ops. */
+	reg = hash_count(old_filter_hash) == 0;
+	if (reg) {
+		if (ops->func || ops->trampoline)
+			goto out_unlock;
+		if (ops->flags & FTRACE_OPS_FL_ENABLED)
+			goto out_unlock;
+	}
+
+	err = -ENOMEM;
+	new_filter_hash = hash_add(old_filter_hash, hash);
+	if (!new_filter_hash)
+		goto out_unlock;
+
+	new_direct_functions = hash_add(old_direct_functions, hash);
+	if (!new_direct_functions)
+		goto out_unlock;
+
+	rcu_assign_pointer(direct_functions, new_direct_functions);
+
+	if (reg) {
+		ops->func = call_direct_funcs;
+		ops->flags |= MULTI_FLAGS;
+		ops->trampoline = FTRACE_REGS_ADDR;
+		ops->local_hash.filter_hash = new_filter_hash;
+
+		err = register_ftrace_function_nolock(ops);
+		if (err) {
+			/* restore old filter on error */
+			ops->local_hash.filter_hash = old_filter_hash;
+			old_filter_hash = new_filter_hash;
+
+			/* cleanup for possible another register call */
+			ops->func = NULL;
+			ops->trampoline = 0;
+		}
+	} else {
+		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
+		/*
+		 * new_filter_hash is dup-ed, so we need to release it anyway,
+		 * old_filter_hash either stays on error or is released already
+		 */
+		old_filter_hash = new_filter_hash;
+	}
+
+	if (err) {
+		/* reset direct_functions and free the new one */
+		rcu_assign_pointer(direct_functions, old_direct_functions);
+		old_direct_functions = new_direct_functions;
+	}
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (old_direct_functions && old_direct_functions != EMPTY_HASH)
+		call_rcu_tasks(&old_direct_functions->rcu, register_ftrace_direct_cb);
+	if (old_filter_hash)
+		free_ftrace_hash(old_filter_hash);
+
+	return err;
+}
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.51.1


