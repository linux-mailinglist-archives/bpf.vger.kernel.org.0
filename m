Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886E56C5DB4
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 05:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCWEBC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 00:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCWEAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 00:00:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB772004C
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:00:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54463468d06so207650777b3.7
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=736+92Vy7w+whzoBxwgGPc/WG8vZYtmz8qFOhZmUk9w=;
        b=GwAMe3Sdh/YfT7TszWBGAWb/Omm+6/db9kDSH3rx0U2jTcaU6cdo97INaHv86kxNQA
         jhXBaZOARcF2wynwqEfwzWZoINYtyHtPiv9iRsKtX2yswvpMBD6qg4pgoYL8XYK3JdrY
         NUg095+EPmMHIupEKGzGCL9BJH8z0FwgmxWYVXMQd4hSYkBDyIXOQyRVbTCpsq34KRPV
         CyG3E5BvF3wTZXEl8tQiaUrIBU2ScbP5rypiT3jSEorEK7YISHgjHIMI4g2IycEeQTfl
         s5/P1y3KHUJjZSE6PJ3e2OlZHSMu+2KD/QDk8kFiQ8Hi9jpOcpijxBB3B0Ib/9iMoeNk
         6zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=736+92Vy7w+whzoBxwgGPc/WG8vZYtmz8qFOhZmUk9w=;
        b=g9ELb/Oktmj+t4U4P8dlBlDxYPjmh/sOUdSPcmoKnsvEzQERCytMZdC1loq5YEppkc
         sUjlRPqyK6+SNXlexpUrU0WXGI8ObZGJtPgIUBDq0UivYTQoJPT7qJyIgmEFxTZ66QHd
         WHwl/iVcI7LWbMTRkF+6Kn9jBdLlP4zog9AjLwHwkJz4A83klK/zdYz+kv65RjrHtzDm
         y1IXA1fPWSTvwEqRUskj3RNunr/m0yD0yl16qRAVaNxtEwnrj4zd/xf0xLmKLQZoy2Rz
         XvnjUR77wv++8D5F6xncmu2p96akSGaM2pRnZCPL0WVoHaIJzhEp9mdK5yj+v3FXCl77
         gPsg==
X-Gm-Message-State: AAQBX9d1CeDhI4Z7Jth5mYrASSkLt/jcNPNl7/lnYYIVCCVHubGppKPq
        NEict3wlEyl0t/8apCl1Gb8wh3cvK7+rXRFS
X-Google-Smtp-Source: AKy350YCGOdNWpxPNSJcwpjqKe6Apct4Cbzrlv7LWeidWe3sKdVG3fkxwH2jR1od8/69JvygqRYEaeYcvlRO26C1
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:ad1b:0:b0:541:69bc:8626 with SMTP
 id l27-20020a81ad1b000000b0054169bc8626mr1137749ywh.10.1679544047097; Wed, 22
 Mar 2023 21:00:47 -0700 (PDT)
Date:   Thu, 23 Mar 2023 04:00:33 +0000
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230323040037.2389095-4-yosryahmed@google.com>
Subject: [RFC PATCH 3/7] cgroup: rstat: remove cgroup_rstat_flush_irqsafe()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The naming of cgroup_rstat_flush_irqsafe() can be confusing.
It can read like "irqsave", which means that it disables
interrupts throughout, but it actually doesn't. It is just "safe" to
call from contexts with interrupts disabled.

Furthermore, this is only used today by mem_cgroup_flush_stats(), which
will be changed by a later patch to optionally allow sleeping. Simplify
the code and make it easier to reason about by instead passing in an
explicit @may_sleep argument to cgroup_rstat_flush(), which gets passed
directly to cgroup_rstat_flush_locked().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 block/blk-cgroup.c     |  2 +-
 include/linux/cgroup.h |  3 +--
 kernel/cgroup/cgroup.c |  4 ++--
 kernel/cgroup/rstat.c  | 24 +++++-------------------
 mm/memcontrol.c        |  6 +++---
 5 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bd50b55bdb61..3fe313ce5e6b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1043,7 +1043,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	if (!seq_css(sf)->parent)
 		blkcg_fill_root_iostats();
 	else
-		cgroup_rstat_flush(blkcg->css.cgroup);
+		cgroup_rstat_flush(blkcg->css.cgroup, true);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 3410aecffdb4..743c345b6a3f 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -691,8 +691,7 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
  * cgroup scalable recursive statistics.
  */
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
-void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
+void cgroup_rstat_flush(struct cgroup *cgrp, bool may_sleep);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(void);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 935e8121b21e..58df0fc379f6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5393,7 +5393,7 @@ static void css_release_work_fn(struct work_struct *work)
 	if (ss) {
 		/* css release path */
 		if (!list_empty(&css->rstat_css_node)) {
-			cgroup_rstat_flush(cgrp);
+			cgroup_rstat_flush(cgrp, true);
 			list_del_rcu(&css->rstat_css_node);
 		}
 
@@ -5406,7 +5406,7 @@ static void css_release_work_fn(struct work_struct *work)
 		/* cgroup release path */
 		TRACE_CGROUP_PATH(release, cgrp);
 
-		cgroup_rstat_flush(cgrp);
+		cgroup_rstat_flush(cgrp, true);
 
 		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index af11e28bd055..fe8690bb1e1c 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -243,30 +243,16 @@ static bool should_skip_flush(void)
  * This function is safe to call from contexts that disable interrupts, but
  * @may_sleep must be set to false, otherwise the function may block.
  */
-__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
+__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp, bool may_sleep)
 {
 	if (should_skip_flush())
 		return;
 
-	might_sleep();
-	spin_lock(&cgroup_rstat_lock);
-	cgroup_rstat_flush_locked(cgrp, true);
-	spin_unlock(&cgroup_rstat_lock);
-}
-
-/**
- * cgroup_rstat_flush_irqsafe - irqsafe version of cgroup_rstat_flush()
- * @cgrp: target cgroup
- *
- * This function can be called from any context.
- */
-void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
-{
-	if (should_skip_flush())
-		return;
+	if (may_sleep)
+		might_sleep();
 
 	spin_lock(&cgroup_rstat_lock);
-	cgroup_rstat_flush_locked(cgrp, false);
+	cgroup_rstat_flush_locked(cgrp, may_sleep);
 	spin_unlock(&cgroup_rstat_lock);
 }
 
@@ -325,7 +311,7 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
 {
 	int cpu;
 
-	cgroup_rstat_flush(cgrp);
+	cgroup_rstat_flush(cgrp, true);
 
 	/* sanity check */
 	for_each_possible_cpu(cpu) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e0e92b38fa51..72cd44f88d97 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -644,7 +644,7 @@ static void __mem_cgroup_flush_stats(void)
 		return;
 
 	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
-	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
+	cgroup_rstat_flush(root_mem_cgroup->css.cgroup, false);
 	atomic_set(&stats_flush_threshold, 0);
 	spin_unlock(&stats_flush_lock);
 }
@@ -7745,7 +7745,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 			break;
 		}
 
-		cgroup_rstat_flush(memcg->css.cgroup);
+		cgroup_rstat_flush(memcg->css.cgroup, true);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
@@ -7810,7 +7810,7 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
-	cgroup_rstat_flush(css->cgroup);
+	cgroup_rstat_flush(css->cgroup, true);
 	return memcg_page_state(mem_cgroup_from_css(css), MEMCG_ZSWAP_B);
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

