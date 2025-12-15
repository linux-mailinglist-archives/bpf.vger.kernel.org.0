Return-Path: <bpf+bounces-76638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2722BCBFE3F
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 22:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83269302CF79
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6743030E82E;
	Mon, 15 Dec 2025 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaDvB+FJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1C32D444;
	Mon, 15 Dec 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833330; cv=none; b=rYjVfgMNMAMDI0AZ9oAT/MSKsjDWojT2Q8kJKIwQzjeg8KcIIOcSHBDibSyFKbmib5H3C2sAMI/XAyIs1GeuIbzGuemsEEp/5v3KsT71rUMBShl3qBWNn49zvO5ntkIIGfD/s4Lx+QfeYcCX7q2/DRcEeC0axuTd7rXAausOEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833330; c=relaxed/simple;
	bh=thPqwJZpy/cFrOdbISBUERcHVGXHatMvgfn7FshenKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwkTvFDLReN166hVLuyb1p98UyLN7IrrZCPCCl3oFsVQKQjZflKDba329JPxcFzCi65W2Ku0hVKURwui1BSOOpVFXellayxOBG8hoM55dkF6grBZijNfqPs3cpwWYY6vYSsSpjQlMzFHUuc4x5QtvpqLZZyjYZn3HUNMeTIBGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaDvB+FJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AB0C4CEF5;
	Mon, 15 Dec 2025 21:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765833329;
	bh=thPqwJZpy/cFrOdbISBUERcHVGXHatMvgfn7FshenKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaDvB+FJZp+jYGbrpjzuCcWiqS04u6ryg8zKTfApC7C+acfAUrbtHVLmI/2EwCef0
	 WpUHsGtli4sFb6yAU503+PyG3vfXk1khgwJdak5xEw2MUTuTmkffKZAc4QAsMK5J23
	 nWn7Q9RAjrFFW4HkVx7A3exf9dki00sGhzvaAkvmNbl2AC+VTgs4D122znnbdiM8Z2
	 SpHNJDTlpocD6Rsc9Ng++6Y/k1//elwVUPX1Dwqur28HUErul+IXjpy+dEDg/Bfkd9
	 S0ZbN8avYGpF1W6jv2aOwfRpyuErsEL+45hyXh62kpqMR46fehjR9O9iuvQTYQnFTx
	 ZqPEmdgna4O0w==
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
Subject: [PATCHv5 bpf-next 7/9] bpf: Add trampoline ip hash table
Date: Mon, 15 Dec 2025 22:14:00 +0100
Message-ID: <20251215211402.353056-8-jolsa@kernel.org>
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

Following changes need to lookup trampoline based on its ip address,
adding hash table for that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  7 +++++--
 kernel/bpf/trampoline.c | 30 +++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 28d8d6b7bb1e..7bcb33e2ec9f 100644
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


