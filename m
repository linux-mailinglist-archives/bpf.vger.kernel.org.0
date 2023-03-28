Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771B66CCD0E
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 00:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjC1WRz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 18:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjC1WRV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 18:17:21 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89963AAE
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:17:08 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i7-20020a626d07000000b005d29737db06so6411790pfc.15
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3EqK7sQZOfVTLBQ7dVPZO4hRmfVfAzm1laH3BYvfeCs=;
        b=Jh0ANfJdLtvcj14Ycx8o0NJ4r9qhZa68Pa0uc2IX0QIjCZKetrfT/Nq/ZDVr5AllWU
         XClT4UcNh1sPOxMcsh6sWOQo9/2lETExd/HKLVBB2M4wtgPvzRmNcVBtdBrQWB7ALdhZ
         R5a35ECD7K8gif2eOzvhZ1FDX+1AdzcBxQSZ/AU6EUVqL3HECb2nu5rbm6oZEkaJmqE+
         JiSGi5TQPR/5oszlj+b2yUkvaRVAqFo8Ka4HGQ6Ui7wSkXSWPGkTPTug5dc09uPeC/es
         /a05azr2/gL04QjqP7TTdBynMB9W71leZpwkNhiYtT2r27tRHGjbrwcjlQFLDRhwcOoU
         qhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EqK7sQZOfVTLBQ7dVPZO4hRmfVfAzm1laH3BYvfeCs=;
        b=KvVTYN2jjxB/dzJIS0/O8gMJlSltbE1e5AoWtH7ZLvaXPAsS+6xFOW3MiUrOPfJxxH
         1Lnuz3UB8DAl5LlcLbuwUypg5nPktfLy5svfAhdtwYLjuI5b7/hBTbJYNQLBsfV3aH7Z
         X+Svl3Qbf2yPv5nvIJIk5Fk169DzaECj4QXcBSAo5SFpDKr4pFSDr2lHLQVSFQsxXfBa
         3W29k9tP31spzVqoFITXvMwaWyqCWA35CjJMb/nP4LZLDFmU8ghShby80rKDEJX6tF9F
         G/eDGIJmhv7GBl9k9zz6YeA8Tude8QW0INo04YHJAW+fCzdyjHkldslQlPeGrKGjxB0C
         SBqQ==
X-Gm-Message-State: AAQBX9cwM4b1Y2cibPY5yHS/kQICmN1oqbfWtrK6clMRJVaF48qz7Fpa
        zIEnPa/ZTzkGir/6wSBwBlMlyhqFKQcpK1ZQ
X-Google-Smtp-Source: AKy350b8EHObFwTAz134ielB7Lfw4iTDwRchFeXjbgsPVENWxNL5SgSGxt3wM+3XFB7OgKxVRznr5DrlZ29gVq8P
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:fb57:b0:23d:30c2:c5b7 with SMTP
 id iq23-20020a17090afb5700b0023d30c2c5b7mr60436pjb.3.1680041826556; Tue, 28
 Mar 2023 15:17:06 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:44 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-10-yosryahmed@google.com>
Subject: [PATCH v2 9/9] memcg: do not modify rstat tree for zero updates
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

In some situations, we may end up calling memcg_rstat_updated() with a
value of 0, which means the stat was not actually updated. An example is
if we fail to reclaim any pages in shrink_folio_list().

Do not add the cgroup to the rstat updated tree in this case, to avoid
unnecessarily flushing it.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 361c0bbf7283..a63ee2efa780 100644
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
2.40.0.348.gf938b09366-goog

