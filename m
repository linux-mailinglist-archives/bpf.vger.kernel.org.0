Return-Path: <bpf+bounces-75186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EC6C765D3
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 18DDC2B0ED
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10E530E855;
	Thu, 20 Nov 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzgihrQW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D04C3074B1;
	Thu, 20 Nov 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673874; cv=none; b=qP+9pKQcIBTU7bidoAuXFrS6rWOpYCppxlAYMaw43Q/eBPzdxU8tme4VAR7MtmCCXb1hE8P/MqWCrPv/vKvYA4jtiRvxVHzUo0VLGR1YwNKkR0IjMx9FxShJjBlX4uWSq2sRFRd9YLBe5/ij2iT4IQZOZQ2e/sP+/bIpWOtHuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673874; c=relaxed/simple;
	bh=oeNb+XAyf1viA+5+4m2jeQ8qke3jBIhnjww7lRhsWv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU+rnLNOeTCrGxjhC9BNCDk8l6JcS81W9dFM8GnL5I/yat3eLede0NDw8vs0gZUuKw5TGMWJDK+/rGR+VvLOVXhf/2Q+1xkzBNV+R4mfCyv3s558wQP7+HFe5IiGG74v7v0dSSqC+4n4w7f+7Cqx3vvq3KlVixhCjIH0BHEN/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzgihrQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB15C4CEF1;
	Thu, 20 Nov 2025 21:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763673874;
	bh=oeNb+XAyf1viA+5+4m2jeQ8qke3jBIhnjww7lRhsWv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzgihrQWD4WHooWmm+FJzIEL3hm6gaK8lRcUGxAH0J8CuTrGQojVLXZD7fPAO2Y6+
	 /LSMQLhi6SHh1HwO/08tYGsdNQIYyb9uuuE/OU3+PCUFYGHQ8RshxAGxgmzc+rRpLc
	 3T+eT6rHvLU4M5Z/pHBoLr+LCQUdXDGmmijD4dTWAHQ4YosUiIaGQFVK6Y7cazPdXi
	 5TQ0mtlyuWGDdCocmw6xH9df1xI9yPLDhKfWjzuturwoJv3eqrp/1kg3XAv+3dJs7K
	 U0M8xoSei1I9KZ+uaZ+tCnZE+CWntUV58ZpX3o06xXftmMKpKTHbuVpMaVvGKaXrmL
	 d/V9nhYpeaJAw==
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
Subject: [PATCHv3 bpf-next 2/8] ftrace: Export some of hash related functions
Date: Thu, 20 Nov 2025 22:23:56 +0100
Message-ID: <20251120212402.466524-3-jolsa@kernel.org>
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

We are going to use these functions in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h | 16 ++++++++++++++++
 kernel/trace/ftrace.c  |  7 +++----
 kernel/trace/trace.h   |  8 --------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 07f8c309e432..5752553bff60 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -405,6 +405,22 @@ enum ftrace_ops_cmd {
 typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, enum ftrace_ops_cmd cmd);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+#define FTRACE_HASH_DEFAULT_BITS 10
+
+struct ftrace_hash {
+	unsigned long		size_bits;
+	struct hlist_head	*buckets;
+	unsigned long		count;
+	unsigned long		flags;
+	struct rcu_head		rcu;
+};
+
+struct ftrace_hash *alloc_ftrace_hash(int size_bits);
+void free_ftrace_hash(struct ftrace_hash *hash);
+struct ftrace_func_entry *add_hash_entry_direct(struct ftrace_hash *hash,
+						unsigned long ip, unsigned long direct);
+
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
 	struct ftrace_hash __rcu	*notrace_hash;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0e3714b796d9..e6ccf572c5f6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -68,7 +68,6 @@
 	})
 
 /* hash bits for specific function selection */
-#define FTRACE_HASH_DEFAULT_BITS 10
 #define FTRACE_HASH_MAX_BITS 12
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -1185,7 +1184,7 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 	hash->count++;
 }
 
-static struct ftrace_func_entry *
+struct ftrace_func_entry *
 add_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigned long direct)
 {
 	struct ftrace_func_entry *entry;
@@ -1265,7 +1264,7 @@ static void clear_ftrace_mod_list(struct list_head *head)
 	mutex_unlock(&ftrace_lock);
 }
 
-static void free_ftrace_hash(struct ftrace_hash *hash)
+void free_ftrace_hash(struct ftrace_hash *hash)
 {
 	if (!hash || hash == EMPTY_HASH)
 		return;
@@ -1305,7 +1304,7 @@ void ftrace_free_filter(struct ftrace_ops *ops)
 }
 EXPORT_SYMBOL_GPL(ftrace_free_filter);
 
-static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
+struct ftrace_hash *alloc_ftrace_hash(int size_bits)
 {
 	struct ftrace_hash *hash;
 	int size;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 85eabb454bee..62e0ac625f65 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -899,14 +899,6 @@ enum {
 	FTRACE_HASH_FL_MOD	= (1 << 0),
 };
 
-struct ftrace_hash {
-	unsigned long		size_bits;
-	struct hlist_head	*buckets;
-	unsigned long		count;
-	unsigned long		flags;
-	struct rcu_head		rcu;
-};
-
 struct ftrace_func_entry *
 ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip);
 
-- 
2.51.1


