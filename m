Return-Path: <bpf+bounces-75951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40777C9E33E
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 09:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C33A9BFF
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEFE2D0605;
	Wed,  3 Dec 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV40A99a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70C2C21FF;
	Wed,  3 Dec 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750326; cv=none; b=EBtKsUzatOazScFnzFOEHA8GFElqcS0oLjpqY9w6dMZli3ntZ/jZfOt8+i2+GbgoJB/KBaQGiB/IRZRA+0aIFWV5F4FEB/HqKbqfgvwPvRcEtRJwtDe59lG6NNugclTzFcG3tRzhLdEGB7iWGVVoGeNAFZEZr49FCToc0Aqqb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750326; c=relaxed/simple;
	bh=tSOG4mEp4ZPM4CNTyzicNcAGJ8np0EHQKNw1pWrn5Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8hishbr6DVmxw18iItZ6Nyl/TFjRjUXrrtk58Enu7vFU2kKa08kxUk464hsaF/mfe2oJYJWOzPL9JKyTxCdeSsYXth3i/sGvQZ3UAFer5eRO8yevqUaFn9XouRgNJRzx7WxTH1JinDGmqffP5RUjvNDZcn/Wz79CoPDsYNZYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV40A99a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F7EC116B1;
	Wed,  3 Dec 2025 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764750326;
	bh=tSOG4mEp4ZPM4CNTyzicNcAGJ8np0EHQKNw1pWrn5Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QV40A99aqtdZftxZn8TC8rQBRa7u7h9M77a2Kv2NAIavwJ795lOCNWDbrHi2Hz6D6
	 3S05RI+WVF7rULr/WBINFG1kEfzUY+XrV4h2A9h3DE4GWF183VG2PhhOsNbfY4jcmu
	 GvYknkaoweAGWVz4wFklVLSagq+G7B8SarJ9w5FMO12wvNOtP9MsmE3NPya5YbFQif
	 8XJnfVIkdKvXSZDHHNOHwg82nmdlwwhm6ZAhadgyW8IUum/1Jj7Tx0RikDkFwfUWwC
	 A6zJ3BVTxloBxTC67phbWl7nv8ZDsJJwmxdlxqSvSyzxO5s9KKEOeUKOCidzhPoKtB
	 E5hvBkv2T8wTw==
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
Subject: [PATCHv4 bpf-next 7/9] bpf: Add trampoline ip hash table
Date: Wed,  3 Dec 2025 09:24:00 +0100
Message-ID: <20251203082402.78816-8-jolsa@kernel.org>
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

Following changes need to lookup trampoline based on its ip address,
adding hash table for that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  7 +++++--
 kernel/bpf/trampoline.c | 30 +++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6498be4c44f8..ef44653eae44 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1307,14 +1307,17 @@ struct bpf_tramp_image {
 };
 
 struct bpf_trampoline {
-	/* hlist for trampoline_table */
-	struct hlist_node hlist;
+	/* hlist for trampoline_key_table */
+	struct hlist_node hlist_key;
+	/* hlist for trampoline_ip_table */
+	struct hlist_node hlist_ip;
 	struct ftrace_ops *fops;
 	/* serializes access to fields of this trampoline */
 	struct mutex mutex;
 	refcount_t refcnt;
 	u32 flags;
 	u64 key;
+	unsigned long ip;
 	struct {
 		struct btf_func_model model;
 		void *addr;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b9a358d7a78f..f298bafab76e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -24,9 +24,10 @@ const struct bpf_prog_ops bpf_extension_prog_ops = {
 #define TRAMPOLINE_HASH_BITS 10
 #define TRAMPOLINE_TABLE_SIZE (1 << TRAMPOLINE_HASH_BITS)
 
-static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
+static struct hlist_head trampoline_key_table[TRAMPOLINE_TABLE_SIZE];
+static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
 
-/* serializes access to trampoline_table */
+/* serializes access to trampoline tables */
 static DEFINE_MUTEX(trampoline_mutex);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
@@ -135,15 +136,15 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
 			   PAGE_SIZE, true, ksym->name);
 }
 
-static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
+static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 {
 	struct bpf_trampoline *tr;
 	struct hlist_head *head;
 	int i;
 
 	mutex_lock(&trampoline_mutex);
-	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
-	hlist_for_each_entry(tr, head, hlist) {
+	head = &trampoline_key_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
+	hlist_for_each_entry(tr, head, hlist_key) {
 		if (tr->key == key) {
 			refcount_inc(&tr->refcnt);
 			goto out;
@@ -164,8 +165,12 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 #endif
 
 	tr->key = key;
-	INIT_HLIST_NODE(&tr->hlist);
-	hlist_add_head(&tr->hlist, head);
+	tr->ip = ftrace_location(ip);
+	INIT_HLIST_NODE(&tr->hlist_key);
+	INIT_HLIST_NODE(&tr->hlist_ip);
+	hlist_add_head(&tr->hlist_key, head);
+	head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
+	hlist_add_head(&tr->hlist_ip, head);
 	refcount_set(&tr->refcnt, 1);
 	mutex_init(&tr->mutex);
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
@@ -846,7 +851,7 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
 					 prog->aux->attach_btf_id);
 
 	bpf_lsm_find_cgroup_shim(prog, &bpf_func);
-	tr = bpf_trampoline_lookup(key);
+	tr = bpf_trampoline_lookup(key, 0);
 	if (WARN_ON_ONCE(!tr))
 		return;
 
@@ -866,7 +871,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 {
 	struct bpf_trampoline *tr;
 
-	tr = bpf_trampoline_lookup(key);
+	tr = bpf_trampoline_lookup(key, tgt_info->tgt_addr);
 	if (!tr)
 		return NULL;
 
@@ -902,7 +907,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 * fexit progs. The fentry-only trampoline will be freed via
 	 * multiple rcu callbacks.
 	 */
-	hlist_del(&tr->hlist);
+	hlist_del(&tr->hlist_key);
+	hlist_del(&tr->hlist_ip);
 	if (tr->fops) {
 		ftrace_free_filter(tr->fops);
 		kfree(tr->fops);
@@ -1175,7 +1181,9 @@ static int __init init_trampolines(void)
 	int i;
 
 	for (i = 0; i < TRAMPOLINE_TABLE_SIZE; i++)
-		INIT_HLIST_HEAD(&trampoline_table[i]);
+		INIT_HLIST_HEAD(&trampoline_key_table[i]);
+	for (i = 0; i < TRAMPOLINE_TABLE_SIZE; i++)
+		INIT_HLIST_HEAD(&trampoline_ip_table[i]);
 	return 0;
 }
 late_initcall(init_trampolines);
-- 
2.52.0


