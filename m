Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208C96496D2
	for <lists+bpf@lfdr.de>; Sun, 11 Dec 2022 23:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiLKWne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 17:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKWnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 17:43:33 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71125201;
        Sun, 11 Dec 2022 14:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P0qci+mDQ+1pwu9JHlj+WOBQhevXBwcTQ7WNZsvyN68=;
  b=KvyRaYe45OY2sjVZdb2S4E9A0YP96CQkx7R/guG2HrWzxXYKUXxa2dZ2
   6kUcT4jysyv/q8VIz/WPqsyWbB1MYR0jdQt5lWheTYQpbVV8e9dpebW/8
   EtSGFT5vZcManHVnZsc9KgZbxQSpmiTDx6YSgI+yqOSYpVOjSa72EG3II
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,237,1665439200"; 
   d="scan'208";a="82839137"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:43:30 +0100
Date:   Sun, 11 Dec 2022 23:43:30 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Tejun Heo <tj@kernel.org>
cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH] sched_ext: use msecs_to_jiffies consistently
Message-ID: <alpine.DEB.2.22.394.2212112334020.29296@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The watchdog's timeout is processed by msecs_to_jiffies when it is
checked, but not when the delay for running the watchdog is set.  The
watchdog will thus run at a time that is later than that time at which it
is checked that it has run, and the scheduler aborts.

Add the needed calls to msecs_to_jiffies.

Signed-off-by: Julia Lawall <julia.lawall@inria.fr>

---

Another solution would be to use jiffies everywhere.

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a28144220501..9d711a70d996 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1626,6 +1626,7 @@ static bool check_rq_for_timeouts(struct rq *rq)
 static void scx_check_timeout_workfn(struct work_struct *work)
 {
 	int cpu;
+	unsigned long timeout;

 	last_timeout_check = jiffies;
 	for_each_online_cpu(cpu) {
@@ -1634,8 +1635,8 @@ static void scx_check_timeout_workfn(struct work_struct *work)

 		cond_resched();
 	}
-	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
-			   task_runnable_timeout_ms / 2);
+	timeout = msecs_to_jiffies(task_runnable_timeout_ms);
+	queue_delayed_work(system_unbound_wq, to_delayed_work(work), timeout / 2);
 }

 static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
@@ -2590,6 +2591,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 {
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	unsigned long timeout;
 	int i, ret;

 	mutex_lock(&scx_ops_enable_mutex);
@@ -2674,8 +2676,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	}

 	last_timeout_check = jiffies;
-	queue_delayed_work(system_unbound_wq, &check_timeout_work,
-			   task_runnable_timeout_ms / 2);
+	timeout = msecs_to_jiffies(task_runnable_timeout_ms);
+	queue_delayed_work(system_unbound_wq, &check_timeout_work, timeout / 2);

 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
