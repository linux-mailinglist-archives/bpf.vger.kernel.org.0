Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585B06C5DB9
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 05:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCWEBH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 00:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCWEA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 00:00:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16611F92C
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:00:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544781e30easo205820777b3.1
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbeROioJTSRzpGZIx65CHc5YHmhlz1VRWOdmKxovUco=;
        b=Hsck6MLI0adIPASRaTY3d/eUkBNtZFq5fHTozHNB8yOtl2ZkHkJQQ4GNrxQh4iSoWz
         JkY9CbdFxu+ujh+Pyx1oKlS53Vj0EANz1HJ/mNRwoFFcZsbYiHuLCMd4Lx5axIZ0gB5l
         yaad/tHsVvn1tHU57blkHy/+dS8g9HHclDAV/QT3pdal8fCNCqCcJD9lMmCv5J074fQc
         TEWaFK69tR0mz3hWUAlm/mUgTwQep/HE638zK7huhLNEr0Yv6vPjLeQWwk4UQCFbwI31
         KRefecpL1tiBaS/Y5Rnpmz8ntCNmT0BogLXtNGk9m7i1zmm8BH4noVNiIwwFJbgEqIWE
         ZH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbeROioJTSRzpGZIx65CHc5YHmhlz1VRWOdmKxovUco=;
        b=ofnDewpFcYKwJ1fc0jFfXSVbFDmgGTq+ZDCQHKjnfYI6IeVNGxuducy52o3TYYIf8j
         yQC1796KB9iNcKUrdcfi8q9kDpRKqyL9CeHoYTO/ydCq3F+qO87MwVt0PrknfalGJ9wA
         1/DEtp31lXE8poTVfrd4158uDCznIKvtpOoqKtVJ8g1gNF+nnMC2v/eOvEpPeZ8jQzwn
         MVTcwuxvfzgWbxuiOZNfjt6JBOWQ3/LXbdXgZiOBcofdbV2fc56Hw52N45BgB3+sKR8D
         1Z+n3dZ/WARjIhB1+dvi468Sj1D++Y+7Cj6Z/O+a0LcDktM9UUHPoNCmVf4iltBkjZ9J
         heqw==
X-Gm-Message-State: AAQBX9eoXlF4RCWHl3KowtufK16yN88Y+oCgkB7x8CBeiPRZ0vGSLRcG
        CenyKSYw8PJy0nKQfL07zR2LCONlc+315SQ+
X-Google-Smtp-Source: AKy350aHC0fJxZVNDyOM4vrsmksnjt2c5UEEiO2IoOQY1+2DycjUjKQKdK6RunG6Yd33ZztPbzyijCwEZgPQmgPG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1549:b0:b73:4a25:fd36 with
 SMTP id r9-20020a056902154900b00b734a25fd36mr1286158ybu.2.1679544053971; Wed,
 22 Mar 2023 21:00:53 -0700 (PDT)
Date:   Thu, 23 Mar 2023 04:00:37 +0000
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230323040037.2389095-8-yosryahmed@google.com>
Subject: [RFC PATCH 7/7] memcg: do not modify rstat tree for zero updates
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

In some situations, we may end up calling memcg_rstat_updated() with a
value of 0, which means the stat was not actually updated. An example is
if we fail to reclaim any pages in shrink_folio_list().

Do not add the cgroup to the rstat updated tree in this case, to avoid
unnecessarily flushing it.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 39a9c7a978ae..7afd29399409 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -618,6 +618,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	unsigned int x;
 
+	if (!val)
+		return;
+
 	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
 
 	x = __this_cpu_add_return(stats_updates, abs(val));
-- 
2.40.0.rc1.284.g88254d51c5-goog

