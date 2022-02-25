Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AB54C5228
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 00:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbiBYXoc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 18:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiBYXo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579241A2717
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j17-20020a25ec11000000b0061dabf74012so4922343ybh.15
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zSQ3ZyUQ2OEfiGKk7osb66v16UBXeasV5LfSlDNJLTs=;
        b=RAWcMz9SCO9AYZ5Pdggqlu3RxuyFkY6L5ZYVTbuszydG5Wij7F33XdUpXekqDNvgDb
         BbWbrze1Z2q5JkRVH/Mrso+MKEvpttminKC8Jc8Xr9EZ4/5mI1+WvY6YbaYulqScKQ9j
         1YLBQR1mMvdAHHfUlaqPu3ftcgq2VlgRWG5Q/GgUJKgBwYQa4yvPUYeZOCtdTy2Z88cI
         1OgIKH+ZbEIKHOz5hZX4svpyPB4h86ryzdTGE/bvN1dTBn28bElnZWfe4IDGdFs5di39
         4PGMTjYksntvmqRVXi+U2b/LGkRjGmblq9KBt6ylJxGB+j711I9tATWezK3+pr2Z+60A
         c6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zSQ3ZyUQ2OEfiGKk7osb66v16UBXeasV5LfSlDNJLTs=;
        b=2bPU4LjU8yz/frkgCyJtyqO/TWjXTjMztgEk4NjVk39LwzRyit42sCA2ev8f3xwUGB
         cegaFMyq1TqlL4T3D1mvBd7X5YDhCOzzp59nec35DhiY/+5Wg43IZPWDWkstM04w2QIH
         I4dOZ2P6bogZ1vuJNhmAYpjwnWnFQcr3z4l3SQhjXUQFQnq4MtVLTfX4P864hRuFfj94
         iirVrCpx2hX199hEurD6dERlTUoAUzkMHSjU3SIlU5bXvFqi6D2G9wKGUZpSzDOIJqxu
         +W9/WmPpBZA+xdGe/8c//FMYvIOO8yZdehmrrR2WXB0WrM3QgJ0gJT7ZctP2Xhq+XSZz
         wWzg==
X-Gm-Message-State: AOAM5319n/x3+gxBqDdRD5YXGlLke3YSM1t6/8amxUEJgmzroNB6XItg
        7piuyPog0DsSoq8ZHvSo35zfAjN5V7A=
X-Google-Smtp-Source: ABdhPJxqiIRkNLzksIZdrDz6SCwnzk2SPJ/9GP6wVJL0Xqy6aFUvgU6B8ncEMVzBhuX/1S7CgZJDqPIDleo=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a25:c5d0:0:b0:624:41d4:e37c with SMTP id
 v199-20020a25c5d0000000b0062441d4e37cmr9499906ybe.318.1645832635508; Fri, 25
 Feb 2022 15:43:55 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:35 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-6-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 5/9] cgroup: Sleepable cgroup tracepoints.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Add two new sleepable tracepoints in cgroup: cgroup_mkdir_s and
cgroup_rmdir_s. The suffix _s means they are in a sleepable context.
These two tracepoints don't need full cgroup paths, they don't have
to live in atomic context. These two tracepoints are also called without
holding cgroup_mutex.

They can be used for bpf to monitor cgroup creation and deletion. Bpf
sleepable programs can attach to these two tracepoints and create
corresponding directories in bpffs. The created directories don't need
the cgroup paths, cgroup id is sufficient to identify the cgroup. Once
the bpffs directories have been created, the bpf prog can further pin
bpf objects inside the directories and allow users to read the pinned
objects.

This serves a way to extend the fixed cgroup interface.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/trace/events/cgroup.h | 45 +++++++++++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c        |  5 ++++
 2 files changed, 50 insertions(+)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index dd7d7c9efecd..4483a7d6c43a 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -204,6 +204,51 @@ DEFINE_EVENT(cgroup_event, cgroup_notify_frozen,
 	TP_ARGS(cgrp, path, val)
 );
 
+/*
+ * The following tracepoints are supposed to be called in a sleepable context.
+ */
+DECLARE_EVENT_CLASS(cgroup_sleepable_tp,
+
+	TP_PROTO(struct cgroup *cgrp),
+
+	TP_ARGS(cgrp),
+
+	TP_STRUCT__entry(
+		__field(	int,		root			)
+		__field(	int,		level			)
+		__field(	u64,		id			)
+	),
+
+	TP_fast_assign(
+		__entry->root = cgrp->root->hierarchy_id;
+		__entry->id = cgroup_id(cgrp);
+		__entry->level = cgrp->level;
+	),
+
+	TP_printk("root=%d id=%llu level=%d",
+		  __entry->root, __entry->id, __entry->level)
+);
+
+#ifdef DEFINE_EVENT_SLEEPABLE
+#undef DEFINE_EVENT
+#define DEFINE_EVENT(template, call, proto, args)		\
+	DEFINE_EVENT_SLEEPABLE(template, call, PARAMS(proto), PARAMS(args))
+#endif
+
+DEFINE_EVENT(cgroup_sleepable_tp, cgroup_mkdir_s,
+
+	TP_PROTO(struct cgroup *cgrp),
+
+	TP_ARGS(cgrp)
+);
+
+DEFINE_EVENT(cgroup_sleepable_tp, cgroup_rmdir_s,
+
+	TP_PROTO(struct cgroup *cgrp),
+
+	TP_ARGS(cgrp)
+);
+
 #endif /* _TRACE_CGROUP_H */
 
 /* This part must be outside protection */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9d05c3ca2d5e..f14ab00d9ef5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5535,6 +5535,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	cgroup_destroy_locked(cgrp);
 out_unlock:
 	cgroup_kn_unlock(parent_kn);
+	if (!ret)
+		trace_cgroup_mkdir_s(cgrp);
 	return ret;
 }
 
@@ -5725,6 +5727,9 @@ int cgroup_rmdir(struct kernfs_node *kn)
 		TRACE_CGROUP_PATH(rmdir, cgrp);
 
 	cgroup_kn_unlock(kn);
+
+	if (!ret)
+		trace_cgroup_rmdir_s(cgrp);
 	return ret;
 }
 
-- 
2.35.1.574.g5d30c73bfb-goog

