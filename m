Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1DD546D68
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 21:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349816AbiFJToq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348303AbiFJToo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 15:44:44 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B63630E
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:44:43 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id oa9-20020a17090b1bc900b001e67bbd7f83so1897513pjb.4
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M8/ooGDXsUIPk2mNJ2l2OjGkicZ3p1bfFAHZWM/Ly3A=;
        b=GsYyQ0tB9bXQvXH2rfH1JcR8TEHmOvJ6SarwER+CY1co37p00ocODWPY6ALAvi7cC/
         BhRL3SNdxxNtunT13h/LwWckSxL/x3PAnQlMiII3OjHHuxFjm/UiaqGQxGXDWeFua/FG
         Y41TkbjTNQZBdWmKWYSTYgE2O7pEhXg8S5aHcheB5zWS3P42tcPr1sfBsttz0m6u2hUS
         k57s9rBU2kRz1kN/xSirNBOIuFSqSk7cJ2Iomhw1Sciw7oQjyaJUK3RsSElxoEdJENaN
         Lak88pvz9+Eaj9JoaT6P2JaZC4ShxM85fhVOaqcNPgOPT2GVKO2t8qNWcDUt1V4NiF6D
         Kovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M8/ooGDXsUIPk2mNJ2l2OjGkicZ3p1bfFAHZWM/Ly3A=;
        b=fwJGZu9gyKCNkleaOzx3Pl94inaqP1QGBG/HcMKb3x7bnMTHrfaS82usqA4C9cpwnH
         F2Fp0UvRUoInRHC6xT1VoG5K2pDJ5ti/5JPMZJx/7RVqXqQY+mc93I0RjaWyutRcJSsI
         DfppOY7hoaiT7O/6YRDBTZ6P7kHUfjcCRcPZHCzSfDmAMeJSkDa1H+0BSUifozQYeQjG
         cL7qHmB2HR9y6O3+44DBA1zU53lUzIuAgDGHTcBK8dc00rlSEHTSV0jtdvBC9yUBpv6I
         nic2dtrEexaOQQfSTKkoj/5EdQwXagvkB1qZGu8/bayZGnPHG1diTxta1+gQTAL0eDkU
         39og==
X-Gm-Message-State: AOAM5322YfpQoohUekPsrd0TtWa/C8mRZTF5UJX2TJwUt2Y5Ye7vuL1y
        azKAm3dYIzcR6FuwsI12dyaBdcGp1wo8nAxY
X-Google-Smtp-Source: ABdhPJwzzXdJSQLS1yhXNkW4jZlIb5MwaItH0qGZ/ykK+7cJuSSeS2jc+LxoBuNLneYOkn5pxgmTPqyeft1R+UIp
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:b81:b0:51c:3bfe:7d89 with SMTP
 id g1-20020a056a000b8100b0051c3bfe7d89mr21514984pfj.31.1654890283002; Fri, 10
 Jun 2022 12:44:43 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:44:28 +0000
In-Reply-To: <20220610194435.2268290-1-yosryahmed@google.com>
Message-Id: <20220610194435.2268290-2-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH bpf-next v2 1/8] cgroup: enable cgroup_get_from_file() on cgroup1
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup_get_from_file() currently fails with -EBADF if called on cgroup
v1. However, the current implementation works on cgroup v1 as well, so
the restriction is unnecessary.

This enabled cgroup_get_from_fd() to work on cgroup v1, which would be
the only thing stopping bpf cgroup_iter from supporting cgroup v1.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/cgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734d..9943fcb1e574d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6090,11 +6090,6 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
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
2.36.1.476.g0c4daa206d-goog

