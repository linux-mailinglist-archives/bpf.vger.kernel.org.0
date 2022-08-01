Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9EF586FE0
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 19:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiHARzB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiHARy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 13:54:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715B61F2F4
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 10:54:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f5d66fcdeso98207977b3.21
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cxTBeNDE2Vos2amVx0IFxaTBG3CN0O03w1708CxS3o8=;
        b=LD0tmXtaxZIUTmWgxb2yYUv+ugYjOBYoAhpT0qn1mRMoeh/za9CtDmbENwz/QcVd21
         Wfi7jNdvjtvP3y9bFeXo7p0tAE7vjU1+ha+Iung12c4X0AeofP92ASLi8YrusWVUf8F+
         6B38if1U0WT6tXZpsmVPk8BOSDwLOMhRgenRnLN68eIgbioxHG/4bvUeVyGvDLBM/6Pw
         MOsSIo8FfPtmyMQqVssLpTYz6gFa8FKipYo/At4Qi9d2XWN2+xSnIOAf44kA/brabdaM
         cQNZuC+rhLzPb6085SzHi7w4QqOdQ5BrAHOojo0Q/AlghSXxYu6zLIUgEw5ZCdS5lE4V
         NXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cxTBeNDE2Vos2amVx0IFxaTBG3CN0O03w1708CxS3o8=;
        b=chLw0NW9uRoEmVvFz4b5fl2fvMWp/M8v63zoIsoyfz22nFw0sycKZOXmijCzSv3W/+
         KrUKhZtl0Kr4/Gt9Jj3T88oHUOlLMkU4N81m+JvA9K/ZQBrS7uu/Cwbc6CkYwwHu6TN2
         YbmyGuhXJNkzCYOTTfW9tLiRYYrRBbPgNTVsgb/Q5vTJjMSZdbAM4cGnOo2OeK6nYXzW
         t9Fh+3YeJKsvV8UGVWN0F9xiAPa/aX3a75qRj54smWuE7ws47+lB2+1eLrNZIIGxuxKX
         hhvidLVuoM8zYNIdTgeN8JpNbth1/MYnueSlFilGccgrYNYFhRu7TqS77E3TU114bwrI
         gyTw==
X-Gm-Message-State: ACgBeo3KB+8Cq/1L6s0hzfZ8jCOXPjy9DX18HBW//3Hb2WdDgJkNybME
        q4ixm4Csui6F5bxaVQjbvOBGEKVpg2E=
X-Google-Smtp-Source: AA6agR5ZDhPslrM56YGY7QhzssWog/JF08icdlHjp9Q4/N23vQ1TYo1yBl4EoRAeZrVlJz2BYb2G6TaukYY=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:7c9:7b32:e73f:6716])
 (user=haoluo job=sendgmr) by 2002:a5b:144:0:b0:66e:a56a:4011 with SMTP id
 c4-20020a5b0144000000b0066ea56a4011mr13049409ybp.133.1659376482040; Mon, 01
 Aug 2022 10:54:42 -0700 (PDT)
Date:   Mon,  1 Aug 2022 10:54:02 -0700
In-Reply-To: <20220801175407.2647869-1-haoluo@google.com>
Message-Id: <20220801175407.2647869-4-haoluo@google.com>
Mime-Version: 1.0
References: <20220801175407.2647869-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next v6 3/8] bpf, iter: Fix the condition on p when
 calling stop.
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

In bpf_seq_read, seq->op->next() could return an ERR and jump to
the label stop. However, the existing code in stop does not handle
the case when p (returned from next()) is an ERR. Adds the handling
of ERR of p by converting p into an error and jumping to done.

Because all the current implementations do not have a case that
returns ERR from next(), so this patch doesn't have behavior changes
right now.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/bpf_iter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 7e8fd49406f6..4688ba39ef25 100644
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
2.37.1.455.g008518b4e5-goog

