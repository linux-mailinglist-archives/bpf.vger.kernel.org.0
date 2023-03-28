Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681C06CB6CB
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 08:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjC1GRF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 02:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjC1GRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:02 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC8F30ED
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 23:16:46 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id z14-20020a170903018e00b001a1a2bee58dso7050565plg.3
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 23:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKfUWPDFjTfCFAmAu+PDSXoVaLfaEZa4F2xpA6M98WI=;
        b=ML25Z5sJR8k5t8kSQzNLjGMjEKmdcebxHFtYwKZcrTLZX2wK0gMrUstJ28IAfa/l/B
         dmJfAqHqeUNGDMqpjHMcUn/3rl6ZtTwoLtJc4kM6PKx7oTSnQD1aK8fu6wcMuvNpddNP
         JXz/aPGcRNjn7CdP1wNYEAXnpd0Uj2w+rzBilII9bcn8vsNoKap2/emH97XB9yYmQX0j
         zWlTQgN/LRjTLn7LSTnUMs5Zi8YiSMdP4rhUt8H9KINdPVTgc9z/VX9FnrviFmsMUsqK
         yY+aBb6I7/+gAXbDQAsJSzcOoGzk7Nj4yOSGJy0Va4z4/Vp/gmfRCs4LrcZySZjB+aj0
         I08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKfUWPDFjTfCFAmAu+PDSXoVaLfaEZa4F2xpA6M98WI=;
        b=Ic5zQSiAOEMugLFvHwVyqafUCT1MARYTYeKyX/1Ozn/F4TTfPe4vvZvtj02QZ1hrNK
         EoLVzPkJvD5MkRfi+bTCLJ6YQSaK2iRa6Rc4agRd85aa5aK2JZyO0ZtC2Pje7agrT07n
         GhalJkf8JC0JZz7vWHUI3KYPyGS5OjyV1CmeM02lUqlS+AvvccFg0j0gGxsaA/SB3K6f
         bpmCPVzuPXvbpsjY5tetoYuNwJoN+PJRvNheoTzEhD2QzqpJGZm+udosEUbEGOZfLGex
         u53tJXmjcz8WVY7i9L1jzng2+n1FdtfeJO9XDkZTTmtHM4geHGf8kD7r1DSmak15N4n2
         fhCQ==
X-Gm-Message-State: AAQBX9fvhZWFTDMe3INyKlTXgGAp53oK6Ob9Qz0u1WIgyn42aToabmbU
        w5jQjmkyoyu8peX0gDGAiHbHWFCP+va9uSc7
X-Google-Smtp-Source: AKy350Z/+j+6P1wMetl7E14Y1prBzO4hFyvwBGRqSlF4uLs1fV1I04aur9Q5rKjp70R1U9RxRmWGSymD4DlPFw5z
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:7088:b0:19a:5953:e85c with SMTP
 id z8-20020a170902708800b0019a5953e85cmr5289230plk.1.1679984205498; Mon, 27
 Mar 2023 23:16:45 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:31 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-3-yosryahmed@google.com>
Subject: [PATCH v1 2/9] memcg: rename mem_cgroup_flush_stats_"delayed" to "ratelimited"
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

mem_cgroup_flush_stats_delayed() suggests his is using a delayed_work,
but this is actually sometimes flushing directly from the callsite.

What it's doing is ratelimited calls. A better name would be
mem_cgroup_flush_stats_ratelimited().

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 2 +-
 mm/workingset.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b6eda2ab205d..ac3f3b3a45e2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1037,7 +1037,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_delayed(void);
+void mem_cgroup_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1535,7 +1535,7 @@ static inline void mem_cgroup_flush_stats(void)
 {
 }
 
-static inline void mem_cgroup_flush_stats_delayed(void)
+static inline void mem_cgroup_flush_stats_ratelimited(void)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0205e58ea430..c3b6aae78901 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -653,7 +653,7 @@ void mem_cgroup_flush_stats(void)
 		__mem_cgroup_flush_stats();
 }
 
-void mem_cgroup_flush_stats_delayed(void)
+void mem_cgroup_flush_stats_ratelimited(void)
 {
 	if (time_after64(jiffies_64, flush_next_time))
 		mem_cgroup_flush_stats();
diff --git a/mm/workingset.c b/mm/workingset.c
index 00c6f4d9d9be..af862c6738c3 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -462,7 +462,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
-	mem_cgroup_flush_stats_delayed();
+	mem_cgroup_flush_stats_ratelimited();
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-- 
2.40.0.348.gf938b09366-goog

