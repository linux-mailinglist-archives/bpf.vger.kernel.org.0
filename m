Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6751F63D077
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiK3IZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiK3IYh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:24:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF069DC6;
        Wed, 30 Nov 2022 00:24:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w129so16152364pfb.5;
        Wed, 30 Nov 2022 00:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyCwssOUByk9u3EvR0soF76EBPw2aKcIpdc6kp+NXfg=;
        b=EtCiSwOIRsVfBunVEbjhjRdt6RlsAnVVQzGbQRtleJ2RxML28cNc0t3/0YbKwkFXsU
         4fdlbdgJ5MOoWwAiRE+8jKpOYB/xvVazm/Tdl+GcSYLiqJA4NcwHOzRsx2oesPla8++a
         BGkLZoaixYeq7vxmOQY7snFvJoH0Y9phfrpGwWqGMXocIv/cu3hetCHhaCB6nk5TJePR
         XjeZVFr4YlRfQWX8iIom+me0e8zF85/GlIh73q2ljNB5J5mQB95hRoJL9r9b6E4vGpE+
         aOCCyKFYQ82c4jdjFTt2OoMLGWExM8zR9EvSvJ4NLOuU0UIPIlaUN2OyaQig0nncKV/O
         jkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CyCwssOUByk9u3EvR0soF76EBPw2aKcIpdc6kp+NXfg=;
        b=HUiHidjjopUnOYWujMUmpy2Jjc6fQL+5DUkcPlQk1b3JbgiNLPhWckGPSYklj9MX9/
         yiWOtqKxN8k0cw36x1QkEuvCHqBiCkH8zlMu/SolP8eEZ3wQ0u3JXwXNr2W+0osfTOtH
         r4rfpH+BwGVGEhxMazrz1AmhXuZ15nJp7YaZ7lYioHTGT06zwVyrTh/aSvFzKlhzZy9P
         cS97gEI/CeIzgjYlPs164dqO0rsvdzb0Vq86LXfxL4zzHb7G4YR9Jt0j+hmZXDaF1D9w
         04DZPaPlArjeKQy3M7JrJrp6D8D4VxYNOXM3oDHw4EjnB8fM5PuJ+aZCCWgTpBda2Ma6
         JP9Q==
X-Gm-Message-State: ANoB5pngOy+4RRnvGu1jMZFkq0Pueencu2NDL6BwOTZoBH7npDhcHoCk
        lZlNudnfEPFdAzK/AyPIgwg=
X-Google-Smtp-Source: AA0mqf4yns/L88Azq/CVLHRiUU8IgmTZX6KXM9WlWzfRweU7VIZgnLWXOhWhzo1PmqyDFGEnmkZhdA==
X-Received: by 2002:a62:e717:0:b0:572:df9e:d57d with SMTP id s23-20020a62e717000000b00572df9ed57dmr64124119pfh.10.1669796642714;
        Wed, 30 Nov 2022 00:24:02 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b00178b6ccc8a0sm776806plh.51.2022.11.30.00.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:02 -0800 (PST)
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
Subject: [PATCH 12/31] sched: Add normal_policy()
Date:   Tue, 29 Nov 2022 22:22:54 -1000
Message-Id: <20221130082313.3241517-13-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add normal_policy() which wraps testing for %SCHED_NORMAL. Makes no behavior
change. Will be used by a new sched_class to expand what's considered normal
policy.

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
index 6cad7d07186b..1d71e74cb0ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7441,7 +7441,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
 	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (unlikely(!normal_policy(p->policy)) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ef8da88e677c..0741827e3541 100644
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
2.38.1

