Return-Path: <bpf+bounces-50284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A7BA24CDE
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E517A1A23
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3DC1D5162;
	Sun,  2 Feb 2025 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="lgRHzxLa"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3932AD11
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482616; cv=none; b=vBC0aSnUotznNiRKHn2y2Bu8T2f9h6hmSbp2Ut/rbrJ2Nxw0P0jUqq/IF2UOWVSfc8FJOHJ0nhCC6NI2RdUbu3nOIjce7C3asWXyV/wNvTnCvKHE0qJWTi644mdrN6CeXCYHKpjs+cnJc2oM/QPV4OkgTt+Tv+0YcCFLdXtOE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482616; c=relaxed/simple;
	bh=ARoDWwW98f9Qqj1Z/6pNaVICFhd0AJ487nZVCYeZmfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbzXmNedsT2nVQuFXqiWJ4Vp35dFMV14ldGwqmE7Js9tefE5dbft71I6/EHPCqoMOy1I9IPPWzkivA9xRdZpd/3HF4S1N+EjuA7w8I57cdgQ/G3TUhStoH1Agw/S73kDsVaATvp351555Drq3JoemG9XkzCkyajUvaqYffk7Lcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=lgRHzxLa; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 48D8B1C2410
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:13 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482612; x=1739346613; bh=ARoDWwW98f9Qqj1Z/6pNaVICFhd
	0AJ487nZVCYeZmfU=; b=lgRHzxLaMcqtbHHszHOc8xU69UH/rVOZmwJzyRukI5R
	iCrJrnyNh6aZbnst6SY5f/CM/1p1TYsMry4yP7/MbO3xnE70KqkjjzoilBrlGoCD
	G0gBuhRB3gC6jIuh48I/0s6dp80l1dKZRx0nKoAyi7GnlW4e0shsfKl8WRr290HU
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5Nvrf30TRred for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:12 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id CCF2C1C19B7;
	Sun,  2 Feb 2025 10:50:10 +0300 (MSK)
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
Subject: [PATCH 6.1 02/16] bpf: Factor out a common helper free_all()
Date: Sun,  2 Feb 2025 07:46:39 +0000
Message-ID: <20250202074709.932174-3-sdl@nppct.ru>
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

From: Hou Tao <houtao1@huawei.com>

commit aa7881fcfe9d328484265d589bc2785533e33c4d upstream.

Factor out a common helper free_all() to free all normal elements or
per-cpu elements on a lock-less list.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20230606035310.4026145-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 6382da64459a..b9bdc9d81b9c 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -211,9 +211,9 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	mem_cgroup_put(memcg);
 }
 
-static void free_one(struct bpf_mem_cache *c, void *obj)
+static void free_one(void *obj, bool percpu)
 {
-	if (c->percpu_size) {
+	if (percpu) {
 		free_percpu(((void **)obj)[1]);
 		kfree(obj);
 		return;
@@ -222,14 +222,19 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
 	kfree(obj);
 }
 
-static void __free_rcu(struct rcu_head *head)
+static void free_all(struct llist_node *llnode, bool percpu)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
-	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
 	struct llist_node *pos, *t;
 
 	llist_for_each_safe(pos, t, llnode)
-		free_one(c, pos);
+		free_one(pos, percpu);
+}
+
+static void __free_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+
+	free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
 	atomic_set(&c->call_rcu_in_progress, 0);
 }
 
@@ -426,7 +431,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	bool percpu = !!c->percpu_size;
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
@@ -435,14 +440,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist_extra))
-		free_one(c, llnode);
+	free_all(__llist_del_all(&c->free_by_rcu), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	free_all(__llist_del_all(&c->free_llist), percpu);
+	free_all(__llist_del_all(&c->free_llist_extra), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
-- 
2.43.0


