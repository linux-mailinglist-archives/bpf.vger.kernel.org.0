Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F49A63D06E
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiK3IYi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiK3IYU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:24:20 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BF68C70;
        Wed, 30 Nov 2022 00:23:55 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q12so12076737pfn.10;
        Wed, 30 Nov 2022 00:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PkMg2emfhFv69qdb2Amxj+15eTI7uc+9BwnY9bGLjs=;
        b=YQYjuZ+fbLPlhNrwiRsXT4329Ax25y8medICOYHHg+y5W8AEbfbfBXz3pl3oQ+PGfD
         /g0ShPm0wNAdQNSzxxwPrbM/aYNfF3lorg9TJnCb9sSJbm9vs+6bbU1VTfmjy4ci0w3z
         zsPFWF+P0NO+kW4dvJxshAMcjLzwVKRbl5u870x962WqQ9H7gKPb1Ma5Mq/VPYFJubkF
         duPm8+RBMiOn0hs0Q4NjtM5+4UIh4noWtroB+QNLTAVPQFiAjRTfU5NLGbkBQtDTkgY9
         fvHvz4KkpYoDFvG+X5qH4b/lp88k0zK/eHBKX+vRTt9JRcQQLTC2Q14DSURS649cd/By
         1/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5PkMg2emfhFv69qdb2Amxj+15eTI7uc+9BwnY9bGLjs=;
        b=6eVB7hyPDHm8/xHlQ/MC7HZ0c++llU4u9zjeJZnlilcUoVY5XavxaeTszR50dAkQYD
         MRBC41jgED055RpOWp/SlEy1QGEY1rSpGKMw9OiAAuLu3xzUDLaCt+1LLDsaMRWikDLp
         c+dHoN6cmKivm1XGpMPjw0BhO6xh9pz2stzm+B8utCtwPB+LA0yZ03lRb1D9073k+HW7
         JehpYqYpTkK0xfEjtKB4hYexugJKvvrwACzPv2YHVxHPRWm28Fup/smQFO2aQOxicg1W
         8tqMh+p3ZsC2whWgYv/lBg49f4Nm6cfV2f9MN40nne/3L/Sa0PHepUhJ2vDs56cknhkX
         eXcQ==
X-Gm-Message-State: ANoB5pnni8cUAywCZf4Z5n0WKg9Q4BdoHze4QGUG5dg+eo+SwCOZku4E
        Xu5lbcAoCNoO2J9xYIC2nxM=
X-Google-Smtp-Source: AA0mqf5khfJpBB2SGa+YzS1bCnTZccWpOPVLVk2luE01pJ/m4ZfD3x26EBjSK6mJ5P9b9AueQZ2ttQ==
X-Received: by 2002:a05:6a00:1348:b0:56b:e27f:76ee with SMTP id k8-20020a056a00134800b0056be27f76eemr41494660pfu.31.1669796634425;
        Wed, 30 Nov 2022 00:23:54 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id w63-20020a626242000000b005624e2e0508sm785690pfb.207.2022.11.30.00.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:23:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/31] sched: Expose css_tg() and __setscheduler_prio() in kernel/sched/sched.h
Date:   Tue, 29 Nov 2022 22:22:50 -1000
Message-Id: <20221130082313.3241517-9-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These will be used by a new sched_class.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 7 +------
 kernel/sched/sched.h | 7 +++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cc5d1867bb4c..ec3af657e8f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6845,7 +6845,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-static void __setscheduler_prio(struct task_struct *p, int prio)
+void __setscheduler_prio(struct task_struct *p, int prio)
 {
 	if (dl_prio(prio))
 		p->sched_class = &dl_sched_class;
@@ -10245,11 +10245,6 @@ void sched_move_task(struct task_struct *tsk)
 	task_rq_unlock(rq, tsk, &rf);
 }
 
-static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct task_group, css) : NULL;
-}
-
 static struct cgroup_subsys_state *
 cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 31f008f1e0cc..5d12c386aac6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -469,6 +469,11 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 	return walk_tg_tree_from(&root_task_group, down, up, data);
 }
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 extern int tg_nop(struct task_group *tg, void *data);
 
 extern void free_fair_sched_group(struct task_group *tg);
@@ -493,6 +498,8 @@ extern long sched_group_rt_runtime(struct task_group *tg);
 extern long sched_group_rt_period(struct task_group *tg);
 extern int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk);
 
+extern void __setscheduler_prio(struct task_struct *p, int prio);
+
 extern struct task_group *sched_create_group(struct task_group *parent);
 extern void sched_online_group(struct task_group *tg,
 			       struct task_group *parent);
-- 
2.38.1

