Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC12D586FD1
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiHARy5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiHARym (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 13:54:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E15BC03
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 10:54:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-324f98aed9eso23844287b3.16
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1MQEHp+uPveOmZBO2w8/VdQxe4yWB13dK4o7EbmOrFM=;
        b=OASAc39jaSNasFVK5EN0ERbBf1LiiHWKnKgjnRjmVVzdPHUdsjvY4hF6IPlZEQmdUe
         tz+SIRqq3C7joulADC7AJO5sE8zqqlTAVdwjipZq0W0rD9iLqcq2n7QB8BkPqp7j/Pj/
         IRaUav0mIyHpo+Nv8I8Y7zy0aTpBHtWda2SEpthbHgfqsj8iISZNG0U9Eb/aPoIAJpsB
         g9ecwAKTh0zl6PMFWv+UOy2cOCXs8IBqyrFi2HNRfaQoAGIA6Qkii384wrNMJEi0Ehxa
         cHdlOYkyeVGn3UVAbCr7OjubrPTzPlT2iVsmzcBIw/8JIFdN/+9hhrTZvgX929w0qFDq
         Du9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1MQEHp+uPveOmZBO2w8/VdQxe4yWB13dK4o7EbmOrFM=;
        b=6290wO/8rXrLkzekEHZxkUGoHD6k7GDBDU2lYtl/7IDYWnGkOOk2WTJeRmnTm73oCE
         8484mjKanuMEd8lNg5FeEdVkeFHxBSmpaNALd5zPjuXene64Hq5MFESodZDh0Am+4W4D
         am4AIr9jjc7R2PLc4AOuQ0ZekjCpRWnObjg+Xev7JZgaGqazEgURo4OASJU7XO8Gn9vw
         0IhKZwS+pylxWSY3i61LS8BkhL2miIl0cV+1Ze4w0lE0IXuQwYNyugqQfHzCO0Subcfg
         YpIzsexce7AnjKf98oG7a7c254keae8/VyLmhCvGRH/5Gux47jHuOvIotRb50lQ/zkNS
         ZrZw==
X-Gm-Message-State: ACgBeo3jcMturO02o5mIXGaR+iJgGVTyEsGkeWXy/JiJurQ0gAnsKTrZ
        XZV+Sp8y1q8dJB5uj1U+TTB84ko5tgE=
X-Google-Smtp-Source: AA6agR4fyH19hzDaq8AHc4igKnH+awdkL2zP+7Q+B8mbbub5P8/WRBsU6hiDMXSigkuA+sAIf3i8yhCLXzA=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:7c9:7b32:e73f:6716])
 (user=haoluo job=sendgmr) by 2002:a81:8351:0:b0:324:5ffb:5d1a with SMTP id
 t78-20020a818351000000b003245ffb5d1amr11742086ywf.337.1659376479536; Mon, 01
 Aug 2022 10:54:39 -0700 (PDT)
Date:   Mon,  1 Aug 2022 10:54:01 -0700
In-Reply-To: <20220801175407.2647869-1-haoluo@google.com>
Message-Id: <20220801175407.2647869-3-haoluo@google.com>
Mime-Version: 1.0
References: <20220801175407.2647869-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next v6 2/8] cgroup: enable cgroup_get_from_file() on cgroup1
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yosry Ahmed <yosryahmed@google.com>

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
2.37.1.455.g008518b4e5-goog

