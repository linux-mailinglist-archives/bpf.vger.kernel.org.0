Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E733546D76
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350470AbiFJTpH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 15:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350290AbiFJTo4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 15:44:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0793DA6B
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:44:47 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id y1-20020a17090a390100b001e66bb0fcefso1925020pjb.0
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oRH9s66i/tSGRatQjV8lrlYVzRqMhVkli+0iViEEm3E=;
        b=EWvIhNpLP4xn7/AaqRD2ry5tJ0od8mdvtIo1l8Mu+AVSg+pAqesAczV/0Lr9wi2kiz
         Fy1MQLHaGvnHVaKfEvTTAGxuQ35arwQTMzrK2HRvce7BKsnt7sTyah4aPc8tPwHAGwCP
         alnn29BH+uZT8ISPg2q0Aplzk57S3UfzlWezvPJ4bm6+UjnhYvJElPhjilELUc3eMS3i
         biAZPX2dSat+7EcVOoZvb8GhkN6J+dYfXoCwKW+EU9nHCjcLl83cMunu9bKv9Kdj8e3T
         TmfhQM5pKilrhRQQjzkRZ7h9oFsr0mAh0K0WVdTgcxvqo9ykb8W3YB6HehNxkS1wukLn
         Pf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oRH9s66i/tSGRatQjV8lrlYVzRqMhVkli+0iViEEm3E=;
        b=qadks9/94sfULVIPLZET8k4vt+ba6XHTPsDOgkavuRZY1k6zJYkUtSh8Fa9r0bFAic
         Q2YLYfLsflZwDKlm1VSeSRYriQ6pxHZcDgUwA+xznr1v9zoX279d2I5ymcVwz0ekO96E
         JyVo4Dve0xFJDK/UZR0Nr5YzmDIhJM37dfIhfcWAr+5YJpOr/EjNpBGvwi3Zeb+gwpc2
         jmcgbgMzbUx2jV+jPOy+5iqq9TMZlmYRw0tmIsdqVXZZgnz/5JXGLjyDIAff8vg9grbV
         oxxPqitdhhDexuqrCxA9B9j/QdzxOqsd3da8kOw+CgUiUEdFhthi7pp9jnQHr0E9zVf6
         5+gA==
X-Gm-Message-State: AOAM5306ETPqPSTzl54BPxlfGarj4HaxL94qcW0i3JeV+vSpkRATGtWV
        LA+57dtEn+yXm3rE4IHbg+zatU+uPgV8X2E/
X-Google-Smtp-Source: ABdhPJxLzCg7BT12DYURFJcz5iuhljjyz60dSOKo1LAt2zz0VKFLfw3YaQHFlASgYFV2U5cX9TzLETp7QJyh9R1w
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP
 id t9-20020a17090a024900b001e0a8a33c6cmr2523pje.0.1654890286518; Fri, 10 Jun
 2022 12:44:46 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:44:30 +0000
In-Reply-To: <20220610194435.2268290-1-yosryahmed@google.com>
Message-Id: <20220610194435.2268290-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH bpf-next v2 3/8] bpf, iter: Fix the condition on p when
 calling stop.
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hao Luo <haoluo@google.com>

In bpf_seq_read, seq->op->next() could return an ERR and jump to
the label stop. However, the existing code in stop does not handle
the case when p (returned from next()) is an ERR. Adds the handling
of ERR of p by converting p into an error and jumping to done.

Because all the current implementations do not have a case that
returns ERR from next(), so this patch doesn't have behavior changes
right now.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/bpf/bpf_iter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index d5d96ceca1058..1585caf7c7200 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -198,6 +198,11 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 	}
 stop:
 	offs = seq->count;
+	if (IS_ERR(p)) {
+		seq->op->stop(seq, NULL);
+		err = PTR_ERR(p);
+		goto done;
+	}
 	/* bpf program called if !p */
 	seq->op->stop(seq, p);
 	if (!p) {
-- 
2.36.1.476.g0c4daa206d-goog

