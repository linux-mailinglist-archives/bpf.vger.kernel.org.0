Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1446C5DA9
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 05:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCWEA6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 00:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCWEAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 00:00:53 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD6C20042
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:00:46 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y186-20020a62cec3000000b00627df3d6ec4so6826678pfg.12
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0V6KepxSWjC0U8YUMhyf5sEsW80RflfKR4tDJnFyjUM=;
        b=nvFwhwj7qGyMPQaTPrzYFw+T0XNSe66OQzM5b4pjwLTwVBRy9Yg/AbwpYFnRMIM5gG
         L465fbRhjctsBw/iYduTrtP7LUUTB2pfnwQVaagEQM0GyAtfd40drA654+PpJ27hrtIB
         BUWcp/c32KQ98SFLCZ9FSHYNM6vaide1p2wRQYwdJvG/bU3/l2g1YAjLINeXoxbcrV2W
         3/G5Y/6fhAJDfUsgxXfVWzP78YqVFCMwh/+/7IKP9AVvA+7qfhsyQkLxneMASA+CreO0
         VfuwrktKMl3lyTDdGpOXeKO210ebUx1dz4XnfSvMg+6i1Ne/G/0TP1oqkrL/txGwmyNx
         VJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0V6KepxSWjC0U8YUMhyf5sEsW80RflfKR4tDJnFyjUM=;
        b=LvB2bXoo8ToYRmsC1oDbmiFkHl6C2+ERbyrMZZm4olBm3/qMva9h430DM90WK4tNn1
         FbjN+y1QE35wByYVHZz69yXA3TBK6EjuM9bWOVzGn7/VPY2BEphyZGaDfvItzdQNgPel
         z/ofw7iKq5s0d3rO9pIED28WAh2tX3WfjRMO8SKVbz1uesrBDQcBVjluFOGoH6dtFSXc
         xJcI9I/qu0PWpgiKp15TsSGWQsxTh53HCckEYo2phy+QIqqFQm7abi6QZf9WOVOlpMrP
         +fd5VYwp98ajki8RmH2Ptsvp6Fe16DSfIPSAf0W53M/XuND4yVKpYWoYwfeNIlJmQxhj
         9Q/Q==
X-Gm-Message-State: AO0yUKWs63T5k5lx33hMBDFbfySOVA3cHUS+CP22Y/SW4pA7D9N4Y1tW
        eyTJnAJ3FvP63vgbWd8HbyTDJrjFfNf+u8yR
X-Google-Smtp-Source: AK7set+NjW/4AXEB5d0IG7XiVNOSp7doL59qiTn9uvLqiFnoG/BqWGCoWZHV7SR3pQA/2uxuP1t6d8Miz+ziUaX1
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:851:b0:628:30d:2d2f with SMTP
 id q17-20020a056a00085100b00628030d2d2fmr2879444pfk.5.1679544045305; Wed, 22
 Mar 2023 21:00:45 -0700 (PDT)
Date:   Thu, 23 Mar 2023 04:00:32 +0000
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230323040037.2389095-3-yosryahmed@google.com>
Subject: [RFC PATCH 2/7] memcg: do not disable interrupts when holding stats_flush_lock
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

The rstat flushing code was modified so that we do not disable interrupts
when we hold the global rstat lock. Do the same for stats_flush_lock on
the memcg side to avoid unnecessarily disabling interrupts throughout
flushing.

Since the code exclusively uses trylock to acquire this lock, it should
be fine to hold from interrupt contexts or normal contexts without
disabling interrupts as a deadlock cannot occur. For interrupt contexts
we will return immediately without flushing anyway.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..e0e92b38fa51 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -636,15 +636,17 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 
 static void __mem_cgroup_flush_stats(void)
 {
-	unsigned long flag;
-
-	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
+	/*
+	 * This lock can be acquired from interrupt context, but we only acquire
+	 * using trylock so it should be fine as we cannot cause a deadlock.
+	 */
+	if (!spin_trylock(&stats_flush_lock))
 		return;
 
 	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
 	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
 	atomic_set(&stats_flush_threshold, 0);
-	spin_unlock_irqrestore(&stats_flush_lock, flag);
+	spin_unlock(&stats_flush_lock);
 }
 
 void mem_cgroup_flush_stats(void)
-- 
2.40.0.rc1.284.g88254d51c5-goog

