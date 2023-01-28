Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48E567F2EB
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjA1ARy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjA1ARg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:17:36 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9530F8CE07;
        Fri, 27 Jan 2023 16:17:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w6-20020a17090ac98600b0022c58cc7a18so1747400pjt.1;
        Fri, 27 Jan 2023 16:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5onzYI/BoYPJ5RTBoK9F833IAc/xj+dSgz/8Wr9CLE=;
        b=MsBTe2ED10UEbb4ZWanyUT51HInOMEhoF46KLis73uMOpkqCJB3XbReyi0AA6zU1On
         7CWM8N3bBkmEwZ+QOfMl9YUr2Jj0qocgMj66AQGt6GfcgElhhngx9u0fUxrAOEzbFhco
         b2QzM9dyE6iFnyr+6rHJuuKSQ3a861T6dW+LZ7ipPNGqfQ37OAnDtwzelkpo+68dP4+5
         o93YqOj+tAgarsQqh+Mj02/k41PCuKjXeR0/DEDTxV7aQvVrTlz60eF3nGIBEEiBooj3
         SOzGB2usd7fEiM5yAZtcw0rAGF1G6ZjQGey9uAa+aBxoqVrAlsA3OI3Ibak0FfqZPRrt
         FhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5onzYI/BoYPJ5RTBoK9F833IAc/xj+dSgz/8Wr9CLE=;
        b=XwCEvmU5CQWCJRDSXQSHNtfNHVau1KcE0RTw/vC7XODJJIYB77tzSFx9ljyy51ga8Y
         PFIxzijGSATe9sMitDxMWGFCfClACJS5CzFMzvloEGs9NYTUEU2eDX8yHIRH2hFmBYX5
         vu9l5fFC2LroWqwxEFTetjIJZ9KSsEfe10VhJ+kt/Q6H0FXWZnGL7Rj/Kb7l6VLcKQ3T
         VepV8kzYudo0GlSDc0oFW+NfQ1Vfg9VFodNcExNTeYf1xeW802EV/NrG+A8xNtdQfRwD
         Eks93o0rNLB6+l8x70Uh73C2xR+3uDNb2GqOfKQZMHt1pQ4yhHTBngyoS+tLZarU9/m8
         SjXA==
X-Gm-Message-State: AO0yUKVwtHl/pWRUBJAKVxQq+ybEdLMJUBIdkcW/cFvZK27s9Cuc33U1
        QIY/3WPJl5pLRO46itd3YwA=
X-Google-Smtp-Source: AK7set8NNnptk7HMvEl0rpRIke72trhWugiUNgz0ZnYalNWo7QMB/vOFdGl4UQ1pVokiuaeyA+b1tA==
X-Received: by 2002:a17:903:2093:b0:192:ef8e:4258 with SMTP id d19-20020a170903209300b00192ef8e4258mr148224plc.14.1674865028680;
        Fri, 27 Jan 2023 16:17:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b00194706d3f25sm3423369plj.144.2023.01.27.16.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:08 -0800 (PST)
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
Subject: [PATCH 09/30] sched: Enumerate CPU cgroup file types
Date:   Fri, 27 Jan 2023 14:16:18 -1000
Message-Id: <20230128001639.3510083-10-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index 1fd4e2cde35c..729de63ee6ec 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10941,7 +10941,7 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 }
 #endif
 
-static struct cftype cpu_legacy_files[] = {
+static struct cftype cpu_legacy_cftypes[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
 		.name = "shares",
@@ -11148,21 +11148,21 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
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
@@ -11170,13 +11170,13 @@ static struct cftype cpu_files[] = {
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
@@ -11184,13 +11184,13 @@ static struct cftype cpu_files[] = {
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
@@ -11210,8 +11210,8 @@ struct cgroup_subsys cpu_cgrp_subsys = {
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
index 1927adc6c4bb..dd567eb7881a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3334,4 +3334,25 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 	cgroup_account_cputime(curr, delta_exec);
 }
 
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
2.39.1

