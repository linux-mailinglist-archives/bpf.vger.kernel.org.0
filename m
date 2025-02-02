Return-Path: <bpf+bounces-50292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F163A24CFA
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5A93A816A
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35771DA0FE;
	Sun,  2 Feb 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="ajXFeEXb"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC91D95A1
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482639; cv=none; b=dsl/cXgE7hbEyp7FpbmCOVYpaNySzCGa8xW2qBa1/84bjpMIHsw89VsyaBTyDd8ElDc5Z5jYJIfcYEGyvjIKKFslxJEpfAKrLH1Y5bEez7JxzYYkP1UsE/IPRvFpsp3J/hMUzosUkVHpSpcgPYP+W0QDBnYF+J130+oFIhNfulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482639; c=relaxed/simple;
	bh=WDmPhbPjaBOyb4n4TIkxcM+XtXL4YuLClhkf3C21BIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU2JR2nmDdqFUntYkdpkysWPwEXBfTiBdyezzUUkR6zeDPwZct39jU8fg56mNCMJQWHjvucb3s3ACOo0H6r+SlauZ3mYRywz8JYSxjQhXVvawEhfHPLdHHzglA2beJWRebhTGOufiOm8Bu8ISAotRkicpfMVV8WTWkI9PtU4EP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=ajXFeEXb; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id B17961C242A
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:35 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482635; x=1739346636; bh=WDmPhbPjaBOyb4n4TIkxcM+XtXL
	4YuLClhkf3C21BIM=; b=ajXFeEXbFMIr5GkpvMtgdz9D1PJdpxKajAwhHx835XD
	9UwjNB5cEaklrwzypTHp7+pj2zfszUbm4wnJNwV2e7kduuWXST/8uI8O/a8bPc+A
	UiN5R7cfSmcmaLmV+W5UdQ4vx93M/X8p1XHzalBaXzusI2YhA2uU0NgllNgvgM30
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yNyBDuNqXiA5 for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:35 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 68D931C241F;
	Sun,  2 Feb 2025 10:50:21 +0300 (MSK)
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
Subject: [PATCH 6.1 10/16] bpf: Add a hint to allocated objects.
Date: Sun,  2 Feb 2025 07:46:47 +0000
Message-ID: <20250202074709.932174-11-sdl@nppct.ru>
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

commit 822fb26bdb55932d0635f43cc418d2004b19e358 upstream.

To address OOM issue when one cpu is allocating and another cpu is freeing add
a target bpf_mem_cache hint to allocated objects and when local cpu free_llist
overflows free to that bpf_mem_cache. The hint addresses the OOM while
maintaining the same performance for common case when alloc/free are done on the
same cpu.

Note that do_call_rcu_ttrace() now has to check 'draining' flag in one more case,
since do_call_rcu_ttrace() is called not only for current cpu.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20230706033447.54696-9-alexei.starovoitov@gmail.com
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 50 +++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 16a57cc4992c..fb390dcdbdaa 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -99,6 +99,7 @@ struct bpf_mem_cache {
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
 	bool draining;
+	struct bpf_mem_cache *tgt;
 
 	/* list of objects to be freed after RCU tasks trace GP */
 	struct llist_head free_by_rcu_ttrace;
@@ -199,18 +200,11 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 
 	for (i = 0; i < cnt; i++) {
 		/*
-		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
-		 * IRQ works on the same CPU are called sequentially, so it is
-		 * safe to use __llist_del_first() here. If alloc_bulk() is
-		 * invoked by the initial prefill, there will be no running
-		 * refill_work(), so __llist_del_first() is fine as well.
-		 *
-		 * In most cases, objects on free_by_rcu_ttrace are from the same CPU.
-		 * If some objects come from other CPUs, it doesn't incur any
-		 * harm because NUMA_NO_NODE means the preference for current
-		 * numa node and it is not a guarantee.
+		 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
+		 * done only by one CPU == current CPU. Other CPUs might
+		 * llist_add() and llist_del_all() in parallel.
 		 */
-		obj = __llist_del_first(&c->free_by_rcu_ttrace);
+		obj = llist_del_first(&c->free_by_rcu_ttrace);
 		if (!obj)
 			break;
 		add_obj_to_free_list(c, obj);
@@ -284,18 +278,23 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
 	 * Nothing races to add to free_by_rcu_ttrace list.
 	 */
-	__llist_add(llnode, &c->free_by_rcu_ttrace);
+	llist_add(llnode, &c->free_by_rcu_ttrace);
 }
 
 static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
 
-	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1))
+	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
+		if (unlikely(READ_ONCE(c->draining))) {
+			llnode = llist_del_all(&c->free_by_rcu_ttrace);
+			free_all(llnode, !!c->percpu_size);
+		}
 		return;
+	}
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu_ttrace))
+	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
 		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
 		 * It doesn't race with llist_del_all either.
 		 * But there could be two concurrent llist_del_all(waiting_for_gp_ttrace):
@@ -318,10 +317,13 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 
 static void free_bulk(struct bpf_mem_cache *c)
 {
+	struct bpf_mem_cache *tgt = c->tgt;
 	struct llist_node *llnode, *t;
 	unsigned long flags;
 	int cnt;
 
+	WARN_ON_ONCE(tgt->unit_size != c->unit_size);
+
 	do {
 		inc_active(c, &flags);
 		llnode = __llist_del_first(&c->free_llist);
@@ -331,13 +333,13 @@ static void free_bulk(struct bpf_mem_cache *c)
 			cnt = 0;
 		dec_active(c, flags);
 		if (llnode)
-			enque_to_free(c, llnode);
+			enque_to_free(tgt, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
 
 	/* and drain free_llist_extra */
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
-		enque_to_free(c, llnode);
-	do_call_rcu_ttrace(c);
+		enque_to_free(tgt, llnode);
+	do_call_rcu_ttrace(tgt);
 }
 
 static void bpf_mem_refill(struct irq_work *work)
@@ -435,6 +437,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -457,6 +460,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 	}
@@ -475,7 +479,7 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(__llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu);
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
@@ -595,8 +599,10 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		llnode = __llist_del_first(&c->free_llist);
-		if (llnode)
+		if (llnode) {
 			cnt = --c->free_cnt;
+			*(struct bpf_mem_cache **)llnode = c;
+		}
 	}
 	local_dec(&c->active);
 	local_irq_restore(flags);
@@ -620,6 +626,12 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 
 	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
 
+	/*
+	 * Remember bpf_mem_cache that allocated this object.
+	 * The hint is not accurate.
+	 */
+	c->tgt = *(struct bpf_mem_cache **)llnode;
+
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		__llist_add(llnode, &c->free_llist);
-- 
2.43.0


