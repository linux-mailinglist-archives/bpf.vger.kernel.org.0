Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85F16BF448
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCQVgU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCQVgK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F9211C1;
        Fri, 17 Mar 2023 14:35:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d13so6698035pjh.0;
        Fri, 17 Mar 2023 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G334uj+j3RQjKOT2zxeoftYC9/ECccSqiye4Nkect10=;
        b=hmMg4kTnuGkoCJwMWYzyR+RqBxdIAsEeDJAtlfJ2+mSUxNxrUn4mE2AxJA2w8DRluY
         WuyIojchrFdRDlHsX92lHGMnBwKjqDDOL+yUl2mAQcExggynHW0nE0kBxw3sUf+NXy1K
         x2KsRzDHCOKO3txmd3Di50qDL7xQaFn29ZSHotpYVnTvipugeuFO4U6YT+H+MR3dVhBb
         +xWehPmw0vhajWZUiRm5oykf8+Yhwnt0ygbdJupLXwh0eEwjcafXQWYuP/UC6JuwSW+g
         SIYbPA3A7NLSLTmHplddA4ETYkPyv5DXYLoIluxP9QtO1Y0PB61IVUFbdMquXLYhcgws
         GySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G334uj+j3RQjKOT2zxeoftYC9/ECccSqiye4Nkect10=;
        b=CqLE/+HUhI7cYrEtnRix2kOmgV/1+SnAj4yPVWf/rZifkwob17HGK3xveIWGYxNim9
         b9mtuiHLU44dAzyqhcViQ4aMH1wNtr2S26bT+NMIo1BGySBcWbcpUt4FmQEHjT64xkAd
         24oZHHY5IJq8y4zA5O1PAELqt4IotqxIJI1dnUaV7MT8Bn1EZqB0jO5qa+zDjPdxBLfY
         AJegRNIQbXSRs6fz3/WVx40jwGIgco1M+E6nLpRncGbIBzqjV1eGmal32BZXaW5TVMPc
         fN78Tqw2+HKD1kWAkKQfmC9Tlo/vzBCPxnXs7rROLvk1PI85ltchCVQKBrce1x6OYIev
         jIyw==
X-Gm-Message-State: AO0yUKUz7dqKOi4EdhUcdmJj6k42zM15ki2pfiwNSL2GBWdTdoWrjbzb
        HN8h7oEmnVFPmfBhtLSbFtE=
X-Google-Smtp-Source: AK7set8MTwrrUfoNe2NGfSF99nwviFaXMgKpsviGcHkyi1yUaaBMg3TYOK2uNjFErMupkGHXKg/Oyw==
X-Received: by 2002:a17:90b:4b84:b0:23d:3c7b:8684 with SMTP id lr4-20020a17090b4b8400b0023d3c7b8684mr9915122pjb.41.1679088839311;
        Fri, 17 Mar 2023 14:33:59 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id gj15-20020a17090b108f00b00233864f21a7sm5383549pjb.51.2023.03.17.14.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:33:59 -0700 (PDT)
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
Subject: [PATCH 09/32] sched: Enumerate CPU cgroup file types
Date:   Fri, 17 Mar 2023 11:33:10 -1000
Message-Id: <20230317213333.2174969-10-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rename cpu[_legacy]_files to cpu[_legacy]_cftypes for clarity and add
cpu_cftype_id which enumerates every cgroup2 interface file type. This
doesn't make any functional difference now. The enums will be used to access
specific cftypes by a new BPF extensible sched_class to selectively show and
hide CPU controller interface files depending on the capability of the
currently loaded BPF scheduler progs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 22 +++++++++++-----------
 kernel/sched/sched.h | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2a602f93f5f8..59136fafa94c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11014,7 +11014,7 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 }
 #endif
 
-static struct cftype cpu_legacy_files[] = {
+static struct cftype cpu_legacy_cftypes[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
 		.name = "shares",
@@ -11221,21 +11221,21 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 }
 #endif
 
-static struct cftype cpu_files[] = {
+struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	{
+	[CPU_CFTYPE_WEIGHT] = {
 		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_weight_read_u64,
 		.write_u64 = cpu_weight_write_u64,
 	},
-	{
+	[CPU_CFTYPE_WEIGHT_NICE] = {
 		.name = "weight.nice",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_s64 = cpu_weight_nice_read_s64,
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
-	{
+	[CPU_CFTYPE_IDLE] = {
 		.name = "idle",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_s64 = cpu_idle_read_s64,
@@ -11243,13 +11243,13 @@ static struct cftype cpu_files[] = {
 	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
-	{
+	[CPU_CFTYPE_MAX] = {
 		.name = "max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_max_show,
 		.write = cpu_max_write,
 	},
-	{
+	[CPU_CFTYPE_MAX_BURST] = {
 		.name = "max.burst",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_cfs_burst_read_u64,
@@ -11257,13 +11257,13 @@ static struct cftype cpu_files[] = {
 	},
 #endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
-	{
+	[CPU_CFTYPE_UCLAMP_MIN] = {
 		.name = "uclamp.min",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_uclamp_min_show,
 		.write = cpu_uclamp_min_write,
 	},
-	{
+	[CPU_CFTYPE_UCLAMP_MAX] = {
 		.name = "uclamp.max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_uclamp_max_show,
@@ -11283,8 +11283,8 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.can_attach	= cpu_cgroup_can_attach,
 #endif
 	.attach		= cpu_cgroup_attach,
-	.legacy_cftypes	= cpu_legacy_files,
-	.dfl_cftypes	= cpu_files,
+	.legacy_cftypes	= cpu_legacy_cftypes,
+	.dfl_cftypes	= cpu_cftypes,
 	.early_init	= true,
 	.threaded	= true,
 };
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 866ce69a445e..67f7f1149630 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3379,4 +3379,25 @@ static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *n
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
 #endif
 
+#ifdef CONFIG_CGROUP_SCHED
+enum cpu_cftype_id {
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	CPU_CFTYPE_WEIGHT,
+	CPU_CFTYPE_WEIGHT_NICE,
+	CPU_CFTYPE_IDLE,
+#endif
+#ifdef CONFIG_CFS_BANDWIDTH
+	CPU_CFTYPE_MAX,
+	CPU_CFTYPE_MAX_BURST,
+#endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	CPU_CFTYPE_UCLAMP_MIN,
+	CPU_CFTYPE_UCLAMP_MAX,
+#endif
+	CPU_CFTYPE_CNT,
+};
+
+extern struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1];
+#endif /* CONFIG_CGROUP_SCHED */
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.39.2

