Return-Path: <bpf+bounces-177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C916F8E48
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 05:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC4C281100
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 03:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786101C05;
	Sat,  6 May 2023 03:16:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F71857
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 03:16:09 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B77D81
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 20:16:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso132871b3a.1
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683342966; x=1685934966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12hdTKRnWgWYBI/c8XKFkpu0HU3jtNl5td2foqM9iPY=;
        b=MzphiRViPhHlc280608eePs8ynETZ2b7P+HwIIxB6+Z/axscsWkRnhL10NE6yugEkM
         caE/rr7mt25gIyCHXJcV6rwlKwuI7CWVHAjuLk4WlRoRFZj1GmmQJztnYFG1uGKKXKFb
         3jOPICfSc48ikntdLzz7FHzwlKmeaN6X3stTiGaWGxU0vK2SYh2qIPmaMMaAivD9oiBh
         4T9Wi0G4OE/g8G6OIOWIMquxnbgv+K9B+D5y70sDbNcQbRCugXELWHK9E11l+yj6tVWY
         5r4UwCf3Z23FAw5nshH11I8Bkgzg4s/LGVhRLbShRHDnDWbjGiW+2N3uTtQ5EgARTdBP
         GLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683342966; x=1685934966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12hdTKRnWgWYBI/c8XKFkpu0HU3jtNl5td2foqM9iPY=;
        b=bWUDg3VlGDgKtxxjn3rjogCHJDnxR32aeXQXR1zrC+YAfvzlBARSknra86id4yvQRT
         R+ChTsWremhANdOOsx/lFiFjfh0FUGmEWBRInOSOox1mLZQRwUdZHX+JbapLBcCuB2WN
         /piJvLC+aywr+IE4W5GLyQilKzEUkY/eFUI2K9vUI71Lz3cSOHE8qWYeyME8JJDWEeVe
         imAZMQCbCW1q0vYRxmsNZ+81lCkY3c3KAQqW/VO0H7h1t2hA9sbq2/ELWBOfh98W5n8j
         MHm/wWobSpqdCpiOIoC0U6y6SQgkxK9oHjNveXGtxHyWggvPTUJT1QJymMe6r6Z2d93e
         aP2g==
X-Gm-Message-State: AC+VfDwxVoHTe4iEp6BlovSjnvR4xoMLHt1wV1Yk5CQen+hYBFq1a30M
	GEEuAUGygBoJSb1DVEpNtEDErA==
X-Google-Smtp-Source: ACHHUZ4Corn9SYGDaNfFKrHwTdh7kiOsEP/Mr3gVK9kadXF5bNntSJBGGkp5HLEkIY4hCqufVory4g==
X-Received: by 2002:a05:6a20:7484:b0:f8:a493:5290 with SMTP id p4-20020a056a20748400b000f8a4935290mr4674612pzd.20.1683342966713;
        Fri, 05 May 2023 20:16:06 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id j1-20020aa783c1000000b0063a1e7d7439sm2256663pfn.69.2023.05.05.20.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 20:16:06 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v7 1/2] bpf: Add bpf_task_under_cgroup() kfunc
Date: Sat,  6 May 2023 11:15:44 +0800
Message-Id: <20230506031545.35991-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230506031545.35991-1-zhoufeng.zf@bytedance.com>
References: <20230506031545.35991-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Add a kfunc that's similar to the bpf_current_task_under_cgroup.
The difference is that it is a designated task.

When hook sched related functions, sometimes it is necessary to
specify a task instead of the current task.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/helpers.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb6b4637ebf2..a128fe0ab2d0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2149,6 +2149,22 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
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
+	return task_under_cgroup_hierarchy(task, ancestor);
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2400,6 +2416,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
-- 
2.20.1


