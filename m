Return-Path: <bpf+bounces-14828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059B7E8878
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A21C209B2
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2CC5399;
	Sat, 11 Nov 2023 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQNH0Psm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C8525B
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:49:19 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF746AC;
	Fri, 10 Nov 2023 18:49:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso2137620b3a.1;
        Fri, 10 Nov 2023 18:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670950; x=1700275750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3RhvtoBYI8080FJZ1qVljtWb5EMXCTUnh9MPRtbJS8=;
        b=BQNH0PsmC0Zc/5BRoOk9pUA1m3l0skx0Mv/MsiBig3fDpovqiKJxRwrI393T58ZXth
         plwIuMbhFxftXqT6EWvvlov/5i0wiO6YetmUAj6n+pyzy7ZgKgVbzrq6h041ZSr/zmjl
         xK+Kwk1lkLbKCQbhHoBzq7o691HMIBPkEpjZU+lc0lerju/vb4peTXGUAzjW7gY2KJm1
         a4H3t3O14oXGTYuQNbfl11dwET3+cva+5MQMX8GV6GtlM1fG0q+SsiYw63iwa3LU97Uw
         ZA+O1YzcUf/db03Erk7RsTMNd0lQAuKSRZYqlUMRswmz95VzKjLLIkuTEN2VEcSFRQom
         6QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670950; x=1700275750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H3RhvtoBYI8080FJZ1qVljtWb5EMXCTUnh9MPRtbJS8=;
        b=EtCu7eTPgmIQ87KmW6ASVWYG7kZhl84sdIEhfSgI7DDJCosIomtBbMvSVn12VWc/z/
         0Ws1oJUp2pVZwT9bcQEVwXV1TbLbwf3szuLYXn0QobS7hpCzvjdDrS847etfNaxra7cA
         l+6p1o6TyfxUXGKgxOluuUSsx8CA93eX+21pegsgsuA3heQIia/Kd0vsW75y5aOknfU/
         ApGsNyStYtFrpAo5ubugC9BrG/yW8U4PUtvOV2zowKhR3TQftRUiU54HW1MVuqqqRQOZ
         lzcHMHpAd/amt/P12kiiBMhPulUqSuFD9VynvhQDqychq/CyggkPXKgxrOaoTbpkJD5k
         L5dA==
X-Gm-Message-State: AOJu0Yz6n50Dv9lj0LVawzeLpBMc0V+3wGTlkpjZFf1m+rehcbeFjISP
	WRRZCv3hM9Dew1YIO74Msgo=
X-Google-Smtp-Source: AGHT+IH8Iz/2y6viaQHcQKYd73AvcasdpqxmKkHIW7cU4LTKT9d/V8OZ80YEjd8nEzbP7gtsvQnDKg==
X-Received: by 2002:aa7:84c7:0:b0:6c3:4bf2:7486 with SMTP id x7-20020aa784c7000000b006c34bf27486mr1128372pfn.7.1699670950201;
        Fri, 10 Nov 2023 18:49:10 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id fi11-20020a056a00398b00b006be17e60708sm392644pfb.204.2023.11.10.18.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:09 -0800 (PST)
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
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/36] sched: Enumerate CPU cgroup file types
Date: Fri, 10 Nov 2023 16:47:34 -1000
Message-ID: <20231111024835.2164816-9-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index ce646cdd87dc..971026d6e28f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11150,7 +11150,7 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 }
 #endif
 
-static struct cftype cpu_legacy_files[] = {
+static struct cftype cpu_legacy_cftypes[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
 		.name = "shares",
@@ -11379,21 +11379,21 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
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
@@ -11401,13 +11401,13 @@ static struct cftype cpu_files[] = {
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
@@ -11415,13 +11415,13 @@ static struct cftype cpu_files[] = {
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
@@ -11442,8 +11442,8 @@ struct cgroup_subsys cpu_cgrp_subsys = {
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
index 97f6e8a28387..c5c237031189 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3541,4 +3541,25 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
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
2.42.0


