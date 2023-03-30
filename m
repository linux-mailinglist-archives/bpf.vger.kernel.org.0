Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB85D6D0E7B
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 21:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjC3TSU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 15:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjC3TSN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 15:18:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674D3FF16
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:18:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54574d6204aso197363467b3.15
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVus0GFA9nzxOZ5lNIH1Nx8kHcLEa/aLkX98gl9HKOI=;
        b=Rb2fsB8aWLuAh/6UfhLacuvSldBOfVahXww4db+vgAZH6d8hHK5iS/Pb3yBuHu8zXu
         8OHs3K+JgNd5BWKL8HmUqSNmeBMWOUfM93BgScQIJGiFyUTuS/OhqqsgB8B/zESgECWW
         id0La031n/vRfUHiqMH5ptV4ZUHLtuC1awDopegwUjfP8gYPSzkD9GboR6Sv+BT5F0il
         4cP0p/kpaTUv9ECKBi7X6nDyHboM9b8Z+lLZ6iyDmkLsMIt+cWstg1DQo4e/ZnrIN56I
         iRBi8QgWvfbGxJTMXxv2zZuY7CwzGwzqEOEYe4XvyV9MRzo4MibTgBPKLkzWKa272DY9
         IgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVus0GFA9nzxOZ5lNIH1Nx8kHcLEa/aLkX98gl9HKOI=;
        b=7XR/xUhcdZsWkNctqqCn4GX755dPHJHPnPglrZnNbEI+rXcONkgqCB4kv4weAdARIz
         Zc14mjIgolC8ZBxAeAQp08riVPeN7bFKS0KvEs+gkW10KpXKdwI1CdSQutvBtpLNPpV9
         V5hxyEzgQMIspeF3wVCQ/yfjvFCa4SIhX2fsow4GwJkDvaZuxX+cvIQZpj8RiYABOtjn
         2bNE4NiNqRBNeFGWLmWGxsqbgdrzy5U70TqmjZxj+daKMpeFbVl9jN57tmgC6qA8zPz6
         /eAyxjGBm5x55fUeFlI1z+w4L1NxgNA3r329pBYuziQQKeLfidr0QCWHivcsiojAWZ5t
         ZYgA==
X-Gm-Message-State: AAQBX9cHAm+Jf0S/hp/7OBRfNXFk/xSKIHzokpaiqUw1r7y8IcWbRoEa
        gda5dbUdXgv7kzv43M+rzFju9Ujpk+aIZS81
X-Google-Smtp-Source: AKy350az4CClmAfjDaxG6/AcT2u/aalMEwRTuNYj9qh25Mudi/3feszrufxHB4k9is1ESXC81UQXzGZVI+EC5ExV
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:10c3:b0:b79:4826:e8e3 with
 SMTP id w3-20020a05690210c300b00b794826e8e3mr10930499ybu.1.1680203889210;
 Thu, 30 Mar 2023 12:18:09 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:17:56 +0000
In-Reply-To: <20230330191801.1967435-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330191801.1967435-4-yosryahmed@google.com>
Subject: [PATCH v3 3/8] memcg: do not flush stats in irq context
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
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>
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

Currently, the only context in which we can invoke an rstat flush from
irq context is through mem_cgroup_usage() on the root memcg when called
from memcg_check_events(). An rstat flush is an expensive operation that
should not be done in irq context, so do not flush stats and use the
stale stats in this case.

Arguably, usage threshold events are not reliable on the root memcg
anyway since its usage is ill-defined.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c3b6aae78901..ff39f78f962e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3669,7 +3669,21 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 	unsigned long val;
 
 	if (mem_cgroup_is_root(memcg)) {
-		mem_cgroup_flush_stats();
+		/*
+		 * We can reach here from irq context through:
+		 * uncharge_batch()
+		 * |--memcg_check_events()
+		 *    |--mem_cgroup_threshold()
+		 *       |--__mem_cgroup_threshold()
+		 *          |--mem_cgroup_usage
+		 *
+		 * rstat flushing is an expensive operation that should not be
+		 * done from irq context; use stale stats in this case.
+		 * Arguably, usage threshold events are not reliable on the root
+		 * memcg anyway since its usage is ill-defined.
+		 */
+		if (in_task())
+			mem_cgroup_flush_stats();
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
-- 
2.40.0.348.gf938b09366-goog

