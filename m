Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EC66C5DAE
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 05:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCWEBA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 00:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCWEAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 00:00:53 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3731320568
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:00:51 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q9-20020a170902dac900b001a18ceff5ebso11679292plx.4
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9m7S+Ebo8MkLWAncbvKsOW8wVqp1O+0Jr3lM7bEbkLI=;
        b=VdCCijFiKDJ4yDz8tFMap2tBXNfAakMH2cmowf1HUrZHuzx98c171wgP+Q37bsMmOY
         dvm3L1704oXKLAgAkOK0GjUnYQoP54+fQujrx3ACvUW9YBMoC0EV4BPolgDqFHWKSqHY
         vC+M0AbP8Thw306r5f0tU0s0RnClNRrpM7iLZQZCh4urjjm1nPlLVN2cvKbhB0gks3OE
         JIza4tgsYELq7gTHgeHRM8vhlVtpzgxg6m7gbPXptQ7q4d0Q9K++kyZO3UiZG82ponKY
         DM+ht1D3A+Eg8Co2dt+ym/gky/eIx2ki3TeVSJ2PxhVMHdlX5/2KaImaACWOeUxKy2jU
         FXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m7S+Ebo8MkLWAncbvKsOW8wVqp1O+0Jr3lM7bEbkLI=;
        b=ach/t9GHZ/QfrhUbscUZOt+zSogFUbD6I8XEevq6HDYhhWBKeHvgSzqyspU1J+TXKM
         fotHEreiCP4wWblHnfAlWL2MV+1xqaQMp67bNnoN6xJQwMFDgnpRSQbRYlWeVNb2iXBo
         Xj4LHb8/GV3nfjs/kleAFPRDD8JpVGR8kmad/OmD1fhhe3f7YuSVqw3aa0t9Y/fVWtYk
         wWTHuNTOfqSTMcR6pHtnDhezeATSgJc3ThM5nEHv42+DK+efe1fJMAxnKcHB9p/QOOKZ
         sSOfnQrwnQ9YG0sOd8zfyQTb7u6QgtShPFVPBdmlRyJy2od0Pn+C/cU5BsQqdhXA4kfK
         94wA==
X-Gm-Message-State: AO0yUKWMmC5hWwpkV8bv4AMZwxVZRHxOxUeHWJfNl4Gu3m7x8G7BHxoW
        lV1nqjvD1nJvv8PERc3co8qtNW4eYPSIJ62K
X-Google-Smtp-Source: AK7set+m4AnWZnXPXOtgLtJe2rjiQdXqc3xUA0g5EOBUkvh8xUumZjwEW1aaQclKH89BoDnkrewjWDyAajrYgNTk
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:80e6:b0:623:8a88:1bba with
 SMTP id ei38-20020a056a0080e600b006238a881bbamr2937696pfb.2.1679544050539;
 Wed, 22 Mar 2023 21:00:50 -0700 (PDT)
Date:   Thu, 23 Mar 2023 04:00:35 +0000
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230323040037.2389095-6-yosryahmed@google.com>
Subject: [RFC PATCH 5/7] vmscan: memcg: sleep when flushing stats during reclaim
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

Memory reclaim should be a sleepable context. Allow sleeping when
flushing memcg stats to avoid unnecessarily performing a lot of work
without sleeping. This can slow down reclaim code if flushing stats is
taking too long, but there is already multiple cond_resched()'s in
reclaim code.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 59d1830d08ac..bae35cfb33c8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats(false);
+	mem_cgroup_flush_stats(true);
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
-- 
2.40.0.rc1.284.g88254d51c5-goog

