Return-Path: <bpf+bounces-50285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE7A24CE1
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978503A5130
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F451D54F2;
	Sun,  2 Feb 2025 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="Ts2Yt679"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203F1D516D
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482619; cv=none; b=RUwUfnPFokdTfj2j325cYHYAgeuiXVadABhTt8o1szpwJD+N8t9iHbTZNSOiOs8l/nThPDsgF3WK+pnI9P4LuGwHb3uTw4rTzuHViKTdt8jl2WhD2Y1EePXUQYw/1jv1+qIUhMBU41yKsIELwGVKurJhvS58EOUE8FurqiV8zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482619; c=relaxed/simple;
	bh=IwQTUOU0QFfAKuTay2+ndLTm+Fhw23rPjuAYihElo78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXbaW3f4RnZaohvxin6nk7M2vVwMXHPD8kTmsdR50JX8rqJQuZjDQUj1+V1gcV6KPd0Tn75jsCP8soeBXjQqKViSHkHljJ/HkqhZZavHeWI2PYVbPSFxmhHiYfiPIz5zw3GLj3qFLXBwdpZqYIV/oN48MwQXMKgq7lL80cVzI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=Ts2Yt679; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 32F121C2418
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:16 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482615; x=1739346616; bh=IwQTUOU0QFfAKuTay2+ndLTm+Fh
	w23rPjuAYihElo78=; b=Ts2Yt679gaWGSs6CrrhnK6sMT/DpQMKlM/G6EUVwoH+
	kD8gvnNk9Kog1KKEHdUEdb10berqKVN1hLnE3pkAPXMXvmyL0hn3DMu+Kejlx6Rm
	H51kH5kts5sEPkQwqA4sr9yNhi9ez9/ivx5oi3MRkrJL3srXkwOobiWIlqAxirQg
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dY1G4P34Bx5T for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:15 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 916671C241E;
	Sun,  2 Feb 2025 10:50:13 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.1 03/16] bpf: Rename few bpf_mem_alloc fields.
Date: Sun,  2 Feb 2025 07:46:40 +0000
Message-ID: <20250202074709.932174-4-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

commit 12c8d0f4c8702f88a74973fb7ced85b59043b0ab upstream.

Rename:
-       struct rcu_head rcu;
-       struct llist_head free_by_rcu;
-       struct llist_head waiting_for_gp;
-       atomic_t call_rcu_in_progress;
+       struct llist_head free_by_rcu_ttrace;
+       struct llist_head waiting_for_gp_ttrace;
+       struct rcu_head rcu_ttrace;
+       atomic_t call_rcu_ttrace_in_progress;
...
-	static void do_call_rcu(struct bpf_mem_cache *c)
+	static void do_call_rcu_ttrace(struct bpf_mem_cache *c)

to better indicate intended use.

The 'tasks trace' is shortened to 'ttrace' to reduce verbosity.
No functional changes.

Later patches will add free_by_rcu/waiting_for_gp fields to be used with normal RCU.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20230706033447.54696-2-alexei.starovoitov@gmail.com
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 57 ++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index b9bdc9d81b9c..63b787128de8 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -99,10 +99,11 @@ struct bpf_mem_cache {
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
 
-	struct rcu_head rcu;
-	struct llist_head free_by_rcu;
-	struct llist_head waiting_for_gp;
-	atomic_t call_rcu_in_progress;
+	/* list of objects to be freed after RCU tasks trace GP */
+	struct llist_head free_by_rcu_ttrace;
+	struct llist_head waiting_for_gp_ttrace;
+	struct rcu_head rcu_ttrace;
+	atomic_t call_rcu_ttrace_in_progress;
 };
 
 struct bpf_mem_caches {
@@ -165,18 +166,18 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
 		/*
-		 * free_by_rcu is only manipulated by irq work refill_work().
+		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
 		 * IRQ works on the same CPU are called sequentially, so it is
 		 * safe to use __llist_del_first() here. If alloc_bulk() is
 		 * invoked by the initial prefill, there will be no running
 		 * refill_work(), so __llist_del_first() is fine as well.
 		 *
-		 * In most cases, objects on free_by_rcu are from the same CPU.
+		 * In most cases, objects on free_by_rcu_ttrace are from the same CPU.
 		 * If some objects come from other CPUs, it doesn't incur any
 		 * harm because NUMA_NO_NODE means the preference for current
 		 * numa node and it is not a guarantee.
 		 */
-		obj = __llist_del_first(&c->free_by_rcu);
+		obj = __llist_del_first(&c->free_by_rcu_ttrace);
 		if (!obj) {
 			/* Allocate, but don't deplete atomic reserves that typical
 			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
@@ -232,10 +233,10 @@ static void free_all(struct llist_node *llnode, bool percpu)
 
 static void __free_rcu(struct rcu_head *head)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
 
-	free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
-	atomic_set(&c->call_rcu_in_progress, 0);
+	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
 static void __free_rcu_tasks_trace(struct rcu_head *head)
@@ -250,31 +251,31 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 	struct llist_node *llnode = obj;
 
 	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
-	 * Nothing races to add to free_by_rcu list.
+	 * Nothing races to add to free_by_rcu_ttrace list.
 	 */
-	__llist_add(llnode, &c->free_by_rcu);
+	__llist_add(llnode, &c->free_by_rcu_ttrace);
 }
 
-static void do_call_rcu(struct bpf_mem_cache *c)
+static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
 
-	if (atomic_xchg(&c->call_rcu_in_progress, 1))
+	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1))
 		return;
 
-	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
-		/* There is no concurrent __llist_add(waiting_for_gp) access.
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
+	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu_ttrace))
+		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
 		 * It doesn't race with llist_del_all either.
-		 * But there could be two concurrent llist_del_all(waiting_for_gp):
+		 * But there could be two concurrent llist_del_all(waiting_for_gp_ttrace):
 		 * from __free_rcu() and from drain_mem_cache().
 		 */
-		__llist_add(llnode, &c->waiting_for_gp);
+		__llist_add(llnode, &c->waiting_for_gp_ttrace);
 	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
 	 * Then use call_rcu() to wait for normal progs to finish
 	 * and finally do free_one() on each element.
 	 */
-	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
+	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu_tasks_trace);
 }
 
 static void free_bulk(struct bpf_mem_cache *c)
@@ -302,7 +303,7 @@ static void free_bulk(struct bpf_mem_cache *c)
 	/* and drain free_llist_extra */
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
 		enque_to_free(c, llnode);
-	do_call_rcu(c);
+	do_call_rcu_ttrace(c);
 }
 
 static void bpf_mem_refill(struct irq_work *work)
@@ -435,13 +436,13 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
-	 * free_by_rcu or in waiting_for_gp lists, so drain those lists now.
+	 * free_by_rcu_ttrace or in waiting_for_gp_ttrace lists, so drain those lists now.
 	 *
-	 * Except for waiting_for_gp list, there are no concurrent operations
+	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(__llist_del_all(&c->free_by_rcu), percpu);
-	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	free_all(__llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
 }
@@ -456,7 +457,7 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp lists was drained, but __free_rcu might
+	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
 	 * still execute. Wait for it now before we freeing percpu caches.
 	 */
 	rcu_barrier_tasks_trace();
@@ -521,7 +522,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			 */
 			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
-			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
+			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
@@ -536,7 +537,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				c = &cc->cache[i];
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
-				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
+				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 			}
 		}
 		if (c->objcg)
-- 
2.43.0


