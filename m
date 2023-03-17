Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222866BF446
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjCQVgU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCQVgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092AB4AD25;
        Fri, 17 Mar 2023 14:35:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c18so6658520ple.11;
        Fri, 17 Mar 2023 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6qz8Axre0zWemU+wtTjt8NnBoL1lg5OlFMGApoRxNc=;
        b=CuW8/lpwFnxQ67YvF+TfhggE1zVruHd28MH7kNA52B4YdNuXAQovYBoqFFJJFtMWle
         VRkl0RTm4kIQgXteqZxZ1hFDIBVXgiavfFYG/qXzTe09qZeevxVbV2t13cm2Xz7ev/ca
         WPKfRt+xEcFPqsDpw6lA/+qehrpcXAgjaF1C3PUPoAOjGV+aRFnVuoXkJGJezCNk3qAx
         s+uw0YagcHE9UNFrWNq5egcZfxp6BkjgMhpDRhAoXhS4Xqi0cO+Aa8sEG3II3WvmpMUf
         2QxFiXp10Gq3+Br7jkk8vNxiCBDXIPDBp5apqkhymDBjX61Eb980ZWR3ASzQED6FK0jl
         1YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6qz8Axre0zWemU+wtTjt8NnBoL1lg5OlFMGApoRxNc=;
        b=Ke4tXfTJaohiGzXNIx4/lnuFJBw2gSFTjIBV+NDPdAyM8xSf6KGl8ZMH6zTGY8RE9r
         gkkntKEF6DVRDEYrG5vMfSHbhyNYCR+hyocdKMGsLzCZ95g0es/CORbqWDBi5M2nvnkh
         WpAOuaKfjAzbYwb0xh0HBsN/WIhjCpH7VFcaNEmUYV0S0rCZ+pXCSpYrDqUGQ+mjVX8U
         xHNA0mUAJN7xhFTzUnMx2RHQTXNquYJy1XD5IUHKDy5BtP0sXas1r729nSxMly3O6Ahg
         LG2Kl9fMbhgjnqeFEkLcgd/78cnxhuLed0RV0HO+tNhSIVvuVYPTiIoeaCVQFRe5VphN
         46mQ==
X-Gm-Message-State: AO0yUKU18Ut7A4CzWaJQOM5bAAc+po2cZDM4/zhruYbCviprCNVHu665
        WuTjH5Tzl/CaGuORyYmGQH4=
X-Google-Smtp-Source: AK7set+5U0vFlbi8Qucd968t4RJ5sZmCSbvb4lu7vsIf4g6NLJQJc+aJ4mhWG8IrIb0v5XTiTtawQw==
X-Received: by 2002:a17:90b:17d0:b0:23f:634a:6c7 with SMTP id me16-20020a17090b17d000b0023f634a06c7mr2937291pjb.15.1679088842922;
        Fri, 17 Mar 2023 14:34:02 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b0019a91895cdfsm2002559plz.50.2023.03.17.14.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:02 -0700 (PDT)
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
Subject: [PATCH 11/32] sched: Add normal_policy()
Date:   Fri, 17 Mar 2023 11:33:12 -1000
Message-Id: <20230317213333.2174969-12-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index 28204472a3f1..ea3788ef9686 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7806,7 +7806,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
 	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (unlikely(!normal_policy(p->policy)) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 958613dd8290..6397843b4482 100644
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
2.39.2

