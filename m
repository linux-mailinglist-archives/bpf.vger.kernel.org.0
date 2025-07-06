Return-Path: <bpf+bounces-62328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC4AAF81B4
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA81585170
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE729C337;
	Thu,  3 Jul 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wIRI2tw6"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE123817F
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572838; cv=none; b=tUJ7E44PKUddc48pyhII5g2OGNBr1oeVAGCXZHk9fuP2bJDpuhLyYqXex/sCdal6F4bZx1zPMXmjF2dLrrN+ynjUQvKJms6U1/SYGtbw+iB5AVl/rQo+/ydWT6N/bQlZABd8ANKzn/QPMNtcTpXEtV8YyiQF+a8hTXxFh/YAYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572838; c=relaxed/simple;
	bh=HsSE3h1zNqv5i3HEDrdZwLuCtzUSMGsxL72bV5PYQX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvSsMX6ALCDewYxls/zHe2ltw038wWZzbW/LyEsqVlY91krfgxRVt/HpgGezodrkQqZvcXaHB5aLPr7478mLCDQyI6qXzPfR/BL+NISNRW+w35fHnc9Snc31tZHHNdXAESRBPTlhKQle72I5qeCh2WA3vlonw/59YCWUR/WGOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wIRI2tw6; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751572834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3htcIr0kFzw+gCDg4WtbffUMbfThV2pCzDBCjKYADI=;
	b=wIRI2tw6towRkHe5udmYk4iVq151wFSGoN9j+bmKupg9YRKgw5VYYowQthaOTKXA/aoxwT
	BNzll83RO3sPFNS3F1amVFCLOcR0CjyfLCj1uDPt4aqORfAZtNyoaVP+jIG0etfCPVR8ER
	icna312iBjyCS/cIKYJ/P+xk4FZkI0U=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 2/2] cgroup: explain the race between updater and flusher
Date: Thu,  3 Jul 2025 13:00:12 -0700
Message-ID: <20250703200012.3734798-2-shakeel.butt@linux.dev>
In-Reply-To: <20250703200012.3734798-1-shakeel.butt@linux.dev>
References: <20250703200012.3734798-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently the rstat updater and the flusher can race and cause a
scenario where the stats updater skips adding the css to the lockless
list but the flusher might not see those updates done by the skipped
updater. This is benign race and the subsequent flusher will flush those
stats and at the moment there aren't any rstat users which are not fine
with this kind of race. However some future user might want more
stricter guarantee, so let's add appropriate comments and data_race()
tags to ease the job of future users.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/cgroup/rstat.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c8a48cf83878..b98c03b1af25 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -60,6 +60,12 @@ static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
  * Atomically inserts the css in the ss's llist for the given cpu. This is
  * reentrant safe i.e. safe against softirq, hardirq and nmi. The ss's llist
  * will be processed at the flush time to create the update tree.
+ *
+ * NOTE: if the user needs the guarantee that the updater either add itself in
+ * the lockless list or the concurrent flusher flushes its updated stats, a
+ * memory barrier is needed before the call to css_rstat_updated() i.e. a
+ * barrier after updating the per-cpu stats and before calling
+ * css_rstat_updated().
  */
 __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
@@ -86,8 +92,13 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 		return;
 
 	rstatc = css_rstat_cpu(css, cpu);
-	/* If already on list return. */
-	if (llist_on_list(&rstatc->lnode))
+	/*
+	 * If already on list return. This check is racy and smp_mb() is needed
+	 * to pair it with the smp_mb() in css_process_update_tree() if the
+	 * guarantee that the updated stats are visible to concurrent flusher is
+	 * needed.
+	 */
+	if (data_race(llist_on_list(&rstatc->lnode)))
 		return;
 
 	/*
@@ -145,9 +156,24 @@ static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
 	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
 	struct llist_node *lnode;
 
-	while ((lnode = llist_del_first_init(lhead))) {
+	while ((lnode = data_race(llist_del_first_init(lhead)))) {
 		struct css_rstat_cpu *rstatc;
 
+		/*
+		 * smp_mb() is needed here (more specifically in between
+		 * init_llist_node() and per-cpu stats flushing) if the
+		 * guarantee is required by a rstat user where etiher the
+		 * updater should add itself on the lockless list or the
+		 * flusher flush the stats updated by the updater who have
+		 * observed that they are already on the list. The
+		 * corresponding barrier pair for this one should be before
+		 * css_rstat_updated() by the user.
+		 *
+		 * For now, there aren't any such user, so not adding the
+		 * barrier here but if such a use-case arise, please add
+		 * smp_mb() here.
+		 */
+
 		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
 		__css_process_update_tree(rstatc->owner, cpu);
 	}
-- 
2.47.1


