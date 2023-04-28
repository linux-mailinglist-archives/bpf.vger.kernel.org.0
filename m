Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8736F1237
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345466AbjD1HSE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 03:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbjD1HR7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 03:17:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C3E49D5
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 00:17:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so6813180a91.0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682666278; x=1685258278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4couG4BvY3JielUUZmpwOAXPZt7eiYYa/cnyqJtYMcY=;
        b=UNZiuLA31nfuIZXnpg1UDGAw70JBijGze3Ipp7cFW7Xes/GxV5/ep/9cZIhyX/f6LW
         3WOJLCPMKF0SOuMFT8IKdFith2VP+RLp2ImQDFWvn00bNCZEObQ+48FpxaMljx0UgaxJ
         jZ2irFzHRE/SCeFgOgo3c6Gy9dTFXwssAkoteZ5L5jDkhCFboqWY1Q7Esia5Lcs3EHTn
         XNl49vIpjuCo5owRYU3+pgWJbl175FF/vNvIPOkgYB+nhXTj9ccpfFqeKvVBpuocHAp+
         vmLQJtfw4EbJNWAdMuAmPDacE+8YkameJBei+xVuYm05JY2XlDmWHliAgUr0ZQnRtuiz
         b2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682666278; x=1685258278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4couG4BvY3JielUUZmpwOAXPZt7eiYYa/cnyqJtYMcY=;
        b=ZrAnyVQk7ose0BXG0wEYS1jIjYVe2X5ppwTuFE5d2czr/L9Z4rQnkXqyxQbhfbEnii
         mNZUPFWx6tUt5e/+FKRAEzwiTpjWle6VW5cLtCLS/CPfoyxUxUgOxBhpCBA2r5i7GSgn
         RvLiiMASaMiiZX6Dq4tPr0aU3r6lGrvgFkhQL9hheMr5IPoavOIFC7T/FsQqLVpGssQw
         fiEz83OLBEovj+H0nYd0JWh3CKMi99H7rocxm4x9KRujQgCq20dwO+/8IvkCTLgeeUW6
         ABAfA+XLgcJxFRP5mg8C+qSzZRCGWRw5TzdzzOjsV5gHusrWRiTnuIYs7/kuFvBPc15F
         Wacg==
X-Gm-Message-State: AC+VfDy/DNmngxEQNuw/7arIDYxgkfASgRSs4lQBuMNcreQ0fxe/LVT1
        XGkndRs8NWzVm9J9VlmGCc8DNA==
X-Google-Smtp-Source: ACHHUZ5CWg/M4bQAH4GZcYwHsNyR5prU/jNcdmueDnZTm3k4N46PrmOMlEcbkil/EUWg6ndcG4AvLQ==
X-Received: by 2002:a17:90a:d3d5:b0:24b:b22d:c78c with SMTP id d21-20020a17090ad3d500b0024bb22dc78cmr4412642pjw.9.1682666277813;
        Fri, 28 Apr 2023 00:17:57 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a318200b0024739d29252sm14159939pjb.15.2023.04.28.00.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 00:17:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/2] bpf: Add bpf_task_under_cgroup() kfunc
Date:   Fri, 28 Apr 2023 15:17:36 +0800
Message-Id: <20230428071737.43849-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230428071737.43849-1-zhoufeng.zf@bytedance.com>
References: <20230428071737.43849-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

