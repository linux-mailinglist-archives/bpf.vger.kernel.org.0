Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B844E5FA8D0
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 01:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJJX7G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 19:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJJX67 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 19:58:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5AD7FF91
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 16:58:57 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z9-20020a17090a468900b00202fdb32ba1so4566878pjf.1
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTUrIJaSpVElDApPbK9Ogfa6jeq4HshVrEJbru1RJcM=;
        b=p+6H8bBZwkvXjYGvxdxhky+agm9qBDmK8LpqI+MkL1oZLYiZQD/o23pMHVwj4xGRhx
         bf9ODEqigYJc6RVWntTsxsj0pOopw1I4WXYAqnonPx4QdbV7S0LHfp0tSEcFoxWUhHn7
         30AMO8eq8jME46yURzfELTkWz8aJr1Iodvfc+7axAwaUAU9UZlkhgR/UF3T9F/wmVjMP
         D8ZLPnEocCn5U6yJ/FyDHNXxbO5lRS9rakU22g2FgjaFEDTsUJ6JSO4Ec9gKycc5Li4A
         1IXJT6f4tjJcpYLEoTuzvQ6FWwPINyF/jj3Ix9q80CwMjA2kZiLMx/JhHsIe2U1VkyLP
         Jchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTUrIJaSpVElDApPbK9Ogfa6jeq4HshVrEJbru1RJcM=;
        b=H4HgCFMKydlJAd1Q1fIFvcB/NQN7ZGMSm1X9ulEDCYtvq1hLCrAd/rlmn+LR8VfL5L
         DqkJ2mhr0+aF0+gZxx6Xuu3kXgyMWtXqVyEjX8VSZ1G9ADY/nfWZnrzZkXyyCsP4Yn2r
         dsxj7Dl0kKjcAbXl0mkLr50+8TwA0M0AzPlxysAlZd8Od4CUtrWgWGjXhusLRlYSVlrX
         4l526lgAvIV1u7AQSLN/5CBhPIjDiQDWGnk4YbzbtYW7aq5kK1SAefrDHLGWkoKgxgyI
         YNi4W63R2iZbCl9w2u/kpf4bpguMaoLGNbuHDix5/1ox5d5MRZ3reXXq0lhQxXksZyRU
         JOFQ==
X-Gm-Message-State: ACrzQf2hCEBZ0S6tEfsyGZfTzvHO2U9P371/M5VcFvN6VyKa396NmhBg
        fXVDUCLKVbnEusg0M5jgu/MQ+eSz7xqz5YB+
X-Google-Smtp-Source: AMsMyM7Lto5Xlv8xKu7VE669vgBYORrets5oSwZzF6NLsybuXw+F8Qy++IDKLe70lX6fUeg2cGtIEv+gwQzD/swm
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:248e:b0:563:7910:29b9 with
 SMTP id c14-20020a056a00248e00b00563791029b9mr5599812pfv.43.1665446337253;
 Mon, 10 Oct 2022 16:58:57 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:58:45 +0000
In-Reply-To: <20221010235845.3379019-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221010235845.3379019-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010235845.3379019-4-yosryahmed@google.com>
Subject: [PATCH v1 3/3] bpf: cgroup_iter: support cgroup1 using cgroup fd
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use cgroup_all_get_from_fd() to support attaching to cgroup1 using fds.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/bpf/cgroup_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 0d200a993489..8bb307139748 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -196,7 +196,7 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
 		return -EINVAL;
 
 	if (fd)
-		cgrp = cgroup_get_from_fd(fd);
+		cgrp = cgroup_all_get_from_fd(fd);
 	else if (id)
 		cgrp = cgroup_get_from_id(id);
 	else /* walk the entire hierarchy by default. */
-- 
2.38.0.rc1.362.ged0d419d3c-goog

