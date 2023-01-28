Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6F067F2EE
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjA1ASC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjA1ARi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:17:38 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9C18CE37;
        Fri, 27 Jan 2023 16:17:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jm10so6535493plb.13;
        Fri, 27 Jan 2023 16:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jROUCebATWHzru8W0ZlCpbTQs5sWj+GIwoxmhemafT4=;
        b=pQ8MBm2tl47RCvTAA3WauynPpa04W1aKkRrEeDObjEVsK8Ab8jq6/ZXkL4Erqz/fVz
         R354yJ4Hb7mJD3OpFyDwkJLJHSmp3vmQcC1kWd0rMGIJExGewN98PLvpYV6d+UQ2mV4u
         WDeP49mX6jp1+SUIaUkPwLKPJroTt53RKRQHHOGzNvGNRDvBShMKPdofxAlKmRmr5kjo
         r31Enjjha/MGbDzlzAUTmB6vfyIS01mNHgeqO2uFkYHtUhsJJId8HAttd9gJb2mPSCVf
         g3rRfAwTUawOQ2uDD65tf2+jP1MW6GuX/+sAaTnXKpNLZxlYFJPS15XOlXwzvDOsH16M
         085g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jROUCebATWHzru8W0ZlCpbTQs5sWj+GIwoxmhemafT4=;
        b=KzQb9EHqXIjva6GBwoVHi5uY71yOBzXJb83m+9MZfhcIdZGxfUqEQ/6AuUigOfPbN+
         IG9aU6fbMtwpkpNrlMyCABCXCD76DE3pfrsrksPWBAys5KYrJMsCVHoOXXet2zhvj6KX
         ZPVhrpZyTtEsLKQk6mpP1tG5JmxW3Xrlpe8d74Rhiq0YclpuGdF7wuh2OP6urr6Vqkf+
         CmNwXxG7SV021jbYibU1b3hkfA9ni4c5qLKHGfm4ZRueZ7UKI/qGwYgSlT4BopsOQ0Cf
         Ng7I72XVUjTFRqAMNRTLg9ZEqzBIQxwRBtf6HuIPx7kraLwuX0IeJ6bOHe3lJewxJVmX
         Y1qg==
X-Gm-Message-State: AFqh2kohWizncCGBZxueO8JbC2LrpWWDEUEuyzOqAiAFUT2wbvq8IiIh
        6vnAiqFo8N/DpxvdONxaPms=
X-Google-Smtp-Source: AMrXdXt4JvKNriBpmFEfiXMKmDPkQFJs9UWUHpApjn1/vhyKrrs85QEgvE41GDhuRX2zFJA4j6molQ==
X-Received: by 2002:a05:6a20:7d98:b0:ad:3ada:c712 with SMTP id v24-20020a056a207d9800b000ad3adac712mr55134239pzj.14.1674865032178;
        Fri, 27 Jan 2023 16:17:12 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b0058bc5f6426asm3133204pfm.169.2023.01.27.16.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/30] sched: Add normal_policy()
Date:   Fri, 27 Jan 2023 14:16:20 -1000
Message-Id: <20230128001639.3510083-12-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new BPF extensible sched_class will need to dynamically change how a task
picks its sched_class. For example, if the loaded BPF scheduler progs fail,
the tasks will be forced back on CFS even if the task's policy is set to the
new sched_class. To support such mapping, add normal_policy() which wraps
testing for %SCHED_NORMAL. This doesn't cause any behavior changes.

v2: Update the description with more details on the expected use.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/fair.c  | 2 +-
 kernel/sched/sched.h | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b4db8943ed8b..6055903cc3de 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7617,7 +7617,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
 	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (unlikely(!normal_policy(p->policy)) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cc1163b15aa0..91b6fed6aa93 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -182,9 +182,15 @@ static inline int idle_policy(int policy)
 {
 	return policy == SCHED_IDLE;
 }
+
+static inline int normal_policy(int policy)
+{
+	return policy == SCHED_NORMAL;
+}
+
 static inline int fair_policy(int policy)
 {
-	return policy == SCHED_NORMAL || policy == SCHED_BATCH;
+	return normal_policy(policy) || policy == SCHED_BATCH;
 }
 
 static inline int rt_policy(int policy)
-- 
2.39.1

