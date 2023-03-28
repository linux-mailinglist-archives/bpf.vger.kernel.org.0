Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8AA6CCD08
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 00:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjC1WRn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 18:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjC1WRR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 18:17:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486DB3592
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:17:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y144-20020a253296000000b00b69ce0e6f2dso13464888yby.18
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvW0vRtvUGz6RfpHjuJf5DcrLtUCw4uDLtzj7kPXkaI=;
        b=s2Rhy6bhmsxOtwUgNmtWPZ1OIy2px3+ZgcKdui8SYbOasl9GBmkC/HgOP+eca1phsP
         jP5oqLAVmD71L+yTcF9Qf7RNoZtsSSFPX0S6Mq6S5HfUed3nW8TUcaJtaUm/tsI8O9Am
         d5OJg/swbll5+1GgM/EDnx0GyYjs89Yzqk1B1Gc+8UCS388fxVzDgMBm93/UJRyrTJYr
         f1CeTGEfaowg6ARY0FoahfZMcN2kOGoi1UzCuTmmzShA86ZvRPo5Rcmo6znhWB9xOjYc
         VRAX/Gquhhjvyizfw+QszvCjk77JT0+yZFVam4Xqz3PGsmr5F2QrldBe6NoQ8SARTtvR
         pWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvW0vRtvUGz6RfpHjuJf5DcrLtUCw4uDLtzj7kPXkaI=;
        b=5kJeF4c5N5veebxtngconKusoApWnFmx9MgoXXrQxkLb3gZ0zzrzRkpcZUsztZczvs
         jXBfi4gcshETU9BBaHtvRkcthlwpqUKJCX9MGa3YUPtF1b8lqocEtSCJUruAH68pq0j1
         Yg6cgd4y/VDVLSzLEzlxhO4P4NUIIgsKYBqViTUt7tE8B+EJZP/f0Md3zPJtBjWQv5KP
         cXe12IT37eMI+SZkHfsj9f1/i+nGD3TPLnzDoiVlKM2soyLBxES2WqZY06iPsqoUnApP
         28Jh1Xo2QmE6xcPO6RGpXw2HzlprLpcjDlJ6w8Mjh0pLvvgZHk65LjnPotY3/WYM4U2Z
         esdQ==
X-Gm-Message-State: AAQBX9dS41wFbZBk/AydIMwOQe/1mjoRVZjOwTISXLVZ681/pMeiSDNC
        h8T9zbo0iP9vPw3WS+3KcTKHGjZMfscIXD07
X-Google-Smtp-Source: AKy350aC/5JUEL/+7c/dIUP+7KT0Wk9JcWhzZQ4Xw7OfNYXAfRzlQJVntfC4MTRTs3t2TIUHulQT5W2wJHMWSZ0v
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:722:b0:a09:314f:a3ef with SMTP
 id l2-20020a056902072200b00a09314fa3efmr10887537ybt.12.1680041825151; Tue, 28
 Mar 2023 15:17:05 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:43 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-9-yosryahmed@google.com>
Subject: [PATCH v2 8/9] vmscan: memcg: sleep when flushing stats during reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
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

Memory reclaim is a sleepable context. Allow sleeping when flushing
memcg stats to avoid unnecessarily performing a lot of work without
sleeping. This can slow down reclaim code if flushing stats is taking
too long, but there is already multiple cond_resched()'s in reclaim
code.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a9511ccb936f..9c1c5e8b24b8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats_atomic();
+	mem_cgroup_flush_stats();
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
-- 
2.40.0.348.gf938b09366-goog

