Return-Path: <bpf+bounces-4671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51A874E329
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AFD1C20C3D
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A441C04;
	Tue, 11 Jul 2023 01:14:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233D1C01
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:14:38 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D551E10C7;
	Mon, 10 Jul 2023 18:14:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so2330648b3a.3;
        Mon, 10 Jul 2023 18:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038072; x=1691630072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idhyn/cZ6skuKFGetCBf+5E7CPyzYpUR1uXeIkOAxtQ=;
        b=id5g4lf07Yqgiyq9uWJwZR1qav7WGDGOFdHztP/oZLZs82jKJfycWg/yf3JoW2NMtK
         0HXgT+zt1H2EzLEuvkFN/riZIxUZ9rLg7rtL1aWVaGc4G9revrPaS7PYBuM4p2XHgaXI
         DkrZOLpT8+mHLR412K58ehsL2A9dtpWb241HjSzSsOLBLKpsrN5xdmMhlYAkDQYk7EZg
         p4MPrT0N4PlUSNP+tCMeLvl19sybEhfzdyhPGgerhN22OuuVwAmEU1qxGEdIBWEljafN
         jOCExRHL8YqOmTzdzIbP7KEXkkBPJlGjtWlp8C2/3I+xDXkIsczg6TKjSVXIAOFxG3Cx
         oTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038072; x=1691630072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=idhyn/cZ6skuKFGetCBf+5E7CPyzYpUR1uXeIkOAxtQ=;
        b=MoRQTgVG7ZWVVbSS5OBk5P/bEN4w2IMgoRIeq2eDRrd5lcPTEpSy7FI7v5JHM29G38
         kVmz6FrY+Lu3XNN7+3p1GNAD2vZfCzW6mYjPRwLEeKG62A6njBcJUQYMMR5dpMQ2p5n2
         Nqy6wrJMlIhxGDorSFNoQKx9Zf2VaYsWofZphp1aHhdd8zPWq7hYfHK3B26IeA/Tdllp
         3OcP/sRXLRUiIEMf/oShxoE3831aw2mMYEH32rZcpFhWnibu4peggWJ8YNvuX3Mqca6P
         BAd/Za3Z3nYKaMzbXP9FJMX4HBeM2UCDpJueQv0TTTH7QChgrQdomyLYT7SQcAfcM97j
         X4Yw==
X-Gm-Message-State: ABy/qLYrdBxebMXGOFgqCG9b/irBsUucgYZEyCIvwjj+5Hlt6vft/vOH
	vppT8oNrPVukZFEzFKNEvbM=
X-Google-Smtp-Source: APBJJlH1xTCWQlDs5lv5WfBuZqynQ8XrKPeFY6sajOlvZ3NBoxzJZ2sm8i0+rcYtdXxYd+B5nCg+8A==
X-Received: by 2002:a05:6a00:80a:b0:666:a46b:63c9 with SMTP id m10-20020a056a00080a00b00666a46b63c9mr13072079pfk.11.1689038072004;
        Mon, 10 Jul 2023 18:14:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id z5-20020aa785c5000000b0066f37665a63sm408362pfn.73.2023.07.10.18.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/34] sched: Enumerate CPU cgroup file types
Date: Mon, 10 Jul 2023 15:13:26 -1000
Message-ID: <20230711011412.100319-9-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 6818ed1a7a42..f7e7a25a0fdf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11160,7 +11160,7 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 }
 #endif
 
-static struct cftype cpu_legacy_files[] = {
+static struct cftype cpu_legacy_cftypes[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
 		.name = "shares",
@@ -11367,21 +11367,21 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
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
@@ -11389,13 +11389,13 @@ static struct cftype cpu_files[] = {
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
@@ -11403,13 +11403,13 @@ static struct cftype cpu_files[] = {
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
@@ -11429,8 +11429,8 @@ struct cgroup_subsys cpu_cgrp_subsys = {
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
index 71343472e6b1..eddc3775cc92 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3519,4 +3519,25 @@ static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
 static inline void init_sched_mm_cid(struct task_struct *t) { }
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
2.41.0


