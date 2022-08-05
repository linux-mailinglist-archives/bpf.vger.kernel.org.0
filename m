Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A80658B148
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbiHEVtO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 17:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbiHEVtL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 17:49:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A31B7AC13
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 14:48:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id bu13-20020a056902090d00b00671743601f1so3078785ybb.0
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=yX3R/1i2LvTgNgg51J0RQhSR+naxU23tOgWOVNggIfM=;
        b=a7tYZIN2B6Y2XNLphifwjcXADFx7gkBmMvn3k+uUvzZ3plqE2SbhHbFhSrzbeff3ob
         gpEkWJ+BU4BsSNfrGwlvuHWUfSz9wrzda85SNVzeODOFirlekVdIFXIDC690ySk6LjnV
         TKO7Dajm4ek5OH5PQo33IjTrMjr23rtrutvRF8uWrZBGLMdE4hI0vfFixcLZKpnrvxof
         MJhLvW7up+1p/h18noKqidVfcZrWhSkNQRSCmX2jeEpraXunH+F4G0xLO1YXelQ02PQ/
         OOykHlZU56GWzNfJT0elWItS0IcvSaxsXc+l6TRBYs7vgujcEPzpqiK68zkf+UF7XHZ5
         ONAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=yX3R/1i2LvTgNgg51J0RQhSR+naxU23tOgWOVNggIfM=;
        b=ta+t90WH5B4GRaBJN7FGr7wYTIAOluTcUAiwYhNdYqjJRvOwcBrm4wEkQM6EcxTwP/
         +WEZoSu3ZI6/kC6EISRnErbVBGTEqyWBE1bArGOFTvm87QFmuWbpjmKDNlN7PZl2vb7q
         AcB4LRjg9pbaOEspWXVYjPXE4DacISWh/aTxtf/oKOa5lnJHBi49QXdKhYL324B5dUis
         NSiRFEjV1haFTmQpwADW5SSGtEEm8LMoSez5V+T5IHX+a8jFPReaZdUZpEuNFwkmgv72
         3xYP3fPLbsaQLrwxpklmS/O7aOvlO+ZQ5CORka9/Bmljk7e6myp4Sxn61eY5Kaxd0lp7
         SKvg==
X-Gm-Message-State: ACgBeo0tm3wrd0QsHBYQuz98J/4AfEWqCcSCQi18QQmp7EfWtU6a9mok
        nZtE8oVY4xd1IDmPwimBJOH7J4WEIvQ=
X-Google-Smtp-Source: AA6agR4H2bQkt5vkX1vf0DXDEkJRbK1x+84BjvFdi5mYU07GFA9bTVydk11jeARHUUFFpgLekr8jfkDBotQ=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:4f27:97db:8644:dc82])
 (user=haoluo job=sendgmr) by 2002:a81:1390:0:b0:322:2378:c198 with SMTP id
 138-20020a811390000000b003222378c198mr7864153ywt.244.1659736136411; Fri, 05
 Aug 2022 14:48:56 -0700 (PDT)
Date:   Fri,  5 Aug 2022 14:48:15 -0700
In-Reply-To: <20220805214821.1058337-1-haoluo@google.com>
Message-Id: <20220805214821.1058337-3-haoluo@google.com>
Mime-Version: 1.0
References: <20220805214821.1058337-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH bpf-next v7 2/8] cgroup: enable cgroup_get_from_file() on cgroup1
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yosry Ahmed <yosryahmed@google.com>

cgroup_get_from_file() currently fails with -EBADF if called on cgroup
v1. However, the current implementation works on cgroup v1 as well, so
the restriction is unnecessary.

This enabled cgroup_get_from_fd() to work on cgroup v1, which would be
the only thing stopping bpf cgroup_iter from supporting cgroup v1.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/cgroup/cgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 13c8e91d7862..49803849a289 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6099,11 +6099,6 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 		return ERR_CAST(css);
 
 	cgrp = css->cgroup;
-	if (!cgroup_on_dfl(cgrp)) {
-		cgroup_put(cgrp);
-		return ERR_PTR(-EBADF);
-	}
-
 	return cgrp;
 }
 
-- 
2.37.1.559.g78731f0fdb-goog

