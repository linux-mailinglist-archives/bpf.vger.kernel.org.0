Return-Path: <bpf+bounces-74396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AE7C57787
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BF53BF636
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA034E75C;
	Thu, 13 Nov 2025 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXecUofo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF934DB61;
	Thu, 13 Nov 2025 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037579; cv=none; b=M5nV16lrBBtrjaGIuGpc67R8qQ8QQ9ZvJKoZIYxGAJJJ74JxuljtWSon+wTV0AIEFkxsZLnr6VKQQLZrQGYOQ33Ajg1SIeDDaQOq1U/fWq97s8DYH9tU/T7V3IiWZXAMDt3e0fOxWjsoDudVh15EUj19f+zsoTOq67mOzYkgvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037579; c=relaxed/simple;
	bh=aIYau6uDxLMS1A9xsaQXevZR8ek7oMtKKEyGysFPcmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duzbFRlbstgyJ58eXT2lsAznqneh4dekuN5lnp80y65V5ErjpPNysMjlny/1+4H1OIb8rMxj8996Waz0qK1IgU57hKCIesDpvgCLjlefk2rk4sKT4GyVrM5kSEfMobrFQYcL5CYuwK9UZ7/0hyl/CvDObyeokeuxjBHcC27/v7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXecUofo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FA8C4CEF1;
	Thu, 13 Nov 2025 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763037578;
	bh=aIYau6uDxLMS1A9xsaQXevZR8ek7oMtKKEyGysFPcmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXecUofopVjXOtnsbc7X3hof/SZcyofxVfegvGqqOVIL3Sg4dekA4irnksWLetSH1
	 VY1cjFUWroUf8hSgfv8e9jkF39+oDTG2EK493NBtrVi2zbUnYNwqbiTF3ECoS4t/Tv
	 wNEJIPyyso7/XpkoMIxk2AmryBGchT3O4Ch1xds5/EU3oXK1eCFlOlxq65xJn7N25K
	 2iYYJhfgD/o7xatu14VPmURqh6WVbRDa2L9v//Kneli3/g1030+5wDQcwrjB0n11tp
	 1Ks4fTwKdzzTwDuJXWR62xzwrJPYeLAtHqhgCaaGNKrGT31BgSHp1fXf9iNF5w08Y9
	 Ib0o+2PueAsJg==
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
Subject: [PATCHv2 bpf-next 6/8] bpf: Add trampoline ip hash table
Date: Thu, 13 Nov 2025 13:37:48 +0100
Message-ID: <20251113123750.2507435-7-jolsa@kernel.org>
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

Following changes need to lookup trampoline based on its ip address,
adding hash table for that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  7 +++++--
 kernel/bpf/trampoline.c | 30 +++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 09d5dc541d1c..ad86857a8562 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1295,14 +1295,17 @@ struct bpf_tramp_image {
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
index f2cb0b097093..9ca75b22aae0 100644
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
@@ -799,7 +804,7 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
 					 prog->aux->attach_btf_id);
 
 	bpf_lsm_find_cgroup_shim(prog, &bpf_func);
-	tr = bpf_trampoline_lookup(key);
+	tr = bpf_trampoline_lookup(key, 0);
 	if (WARN_ON_ONCE(!tr))
 		return;
 
@@ -819,7 +824,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 {
 	struct bpf_trampoline *tr;
 
-	tr = bpf_trampoline_lookup(key);
+	tr = bpf_trampoline_lookup(key, tgt_info->tgt_addr);
 	if (!tr)
 		return NULL;
 
@@ -855,7 +860,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 * fexit progs. The fentry-only trampoline will be freed via
 	 * multiple rcu callbacks.
 	 */
-	hlist_del(&tr->hlist);
+	hlist_del(&tr->hlist_key);
+	hlist_del(&tr->hlist_ip);
 	if (tr->fops) {
 		ftrace_free_filter(tr->fops);
 		kfree(tr->fops);
@@ -1128,7 +1134,9 @@ static int __init init_trampolines(void)
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
2.51.1


