Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10856F633D
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 05:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEDDQt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 23:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjEDDQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 23:16:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2042694
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 20:15:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aad55244b7so44253255ad.2
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 20:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683170133; x=1685762133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4couG4BvY3JielUUZmpwOAXPZt7eiYYa/cnyqJtYMcY=;
        b=RdIpHuXrIdZdrLZD5GQY5cDg6P+FgWa4EpLYMB+eMiwXeySE3PqhoXIEbj9y1HswHy
         FdZb8DebR9Ai3PUYWSWIfBQEbv4DIt3NpKTPNECZWgrNWKx1lnbcg7fCbOyhrqjXxWw9
         St42hO8jXLTQzCsp479eSYDbAeu0RmqscYkFgEUasmQeV8N4t4pGq4RrWm9AAnrwQ23a
         KQbah8ecHaW31WzSFNFNT7cSMeV3J7hlftVN/TR07lQXMrTzO0TUbI+LGcHQzeUMWKZ8
         efaSbI+l43x5sZvhbMzMOBUK+XJV7SOQ8GSkA/KtqVuZ/HIscRkB8O2MAhUNNDDMfYP0
         BiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683170133; x=1685762133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4couG4BvY3JielUUZmpwOAXPZt7eiYYa/cnyqJtYMcY=;
        b=Xr16yp+QiVrKsZN9kusRO7mbClIK5X8V6G056u+s4xHSpO1/+f2vQu3rwYtPjVfa3W
         1ZPQ89P73UeB6A/RSU2R8uxQ9ZsYB2H4Q2pd90kRgf/gntlRtwOjEdoDDz/K5ywIRc+s
         MoGcXeID7GdZINXJ4dXyh+GoDpHaBjsQaR777tuBx1d0HH89qazY3a2nZ6dfNBp8Howb
         yVPfqeplU9Ms2R2nOUjXNwqN1LmrJwYUHYbQqZ15rXkWry9nZWaP2qFXiiJPGti6nQhq
         xc+N5T7y2yeEn+jSvkAXbA3bFIJvJDs2SpgSIXAcCvJR4PWUDwhbcCtGrp6/4Z5ufyQ4
         xnPg==
X-Gm-Message-State: AC+VfDxSzAfweMdfiT9kWs41BldtGyA8ZnRUC7YMeY11X+3LrLfwAx26
        EecXRZ38JX52op74gFItVIiKmA==
X-Google-Smtp-Source: ACHHUZ6AjhdkvWkT8w6Mj92ZHNvWQaJQGVrTeNa+kPUUJwxK5WvIueleFWkG5v9xszzcYw/nCiJ2Wg==
X-Received: by 2002:a17:902:7444:b0:1ab:ab1:f8aa with SMTP id e4-20020a170902744400b001ab0ab1f8aamr2135234plt.17.1683170133183;
        Wed, 03 May 2023 20:15:33 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001aaecc15d66sm7146121plb.289.2023.05.03.20.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:15:32 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v5 1/2] bpf: Add bpf_task_under_cgroup() kfunc
Date:   Thu,  4 May 2023 11:15:11 +0800
Message-Id: <20230504031513.13749-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230504031513.13749-1-zhoufeng.zf@bytedance.com>
References: <20230504031513.13749-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Add a kfunc that's similar to the bpf_current_task_under_cgroup.
The difference is that it is a designated task.

When hook sched related functions, sometimes it is necessary to
specify a task instead of the current task.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb6b4637ebf2..453cbd312366 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2149,6 +2149,25 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_under_cgroup - wrap task_under_cgroup_hierarchy() as a kfunc, test
+ * task's membership of cgroup ancestry.
+ * @task: the task to be tested
+ * @ancestor: possible ancestor of @task's cgroup
+ *
+ * Tests whether @task's default cgroup hierarchy is a descendant of @ancestor.
+ * It follows all the same rules as cgroup_is_descendant, and only applies
+ * to the default hierarchy.
+ */
+__bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
+				       struct cgroup *ancestor)
+{
+	if (unlikely(!ancestor || !task))
+		return -EINVAL;
+
+	return task_under_cgroup_hierarchy(task, ancestor);
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2400,6 +2419,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
-- 
2.20.1

