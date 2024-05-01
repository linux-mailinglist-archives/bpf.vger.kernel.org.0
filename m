Return-Path: <bpf+bounces-28338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D784C8B8C89
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062011C21A7B
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB61130E2A;
	Wed,  1 May 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn37Rb4E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695D1304B9;
	Wed,  1 May 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576414; cv=none; b=hcB6WxFrqTHCH7SCl6x3DgFhpGZkdPBROiUlYy9m++Tk/0A5VQjJ+ZSZk4Q4erNHFNV8gw8HdTmmLN6Bv4/GYzP5g6sv7Bv8SsLaCfPhpCiJw6PljihiF0phH3EpkaoAgg6KwSLyra3rcluxyCOBeL0e0egR51JQchP25+YW78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576414; c=relaxed/simple;
	bh=yb7JP+vyezOzTHBibbJ7pzRn4NehbJyRKXIeim0dvEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geyv4W1Wva5CRvr4mz/ZjvErK5dgyeEUcRFE1zcLvW05YNuOQ6XsZLuxwWrCsGg1xlR/5itc1r7j0KizZtcvKtzplVC7XTpT1iC2O6WcWr2zZcfWSfIFsGg/tjKOKpYCKQPO36z30k7Dq3trtbSh0s0FvjTZlLnuLaiFQZ1TzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn37Rb4E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3ff14f249so7019285ad.1;
        Wed, 01 May 2024 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576413; x=1715181213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NlXaWkfWscApjJVamzuM/t1PaeHWnW1AqCSWviBjFQ=;
        b=Fn37Rb4EX18u3wZxm3LfA5XP8tjf8WvTh1bdcBrbqIuE8ld11FHfiBKxYolpQyXkBw
         vVYjLCYsvh+HvU79T8Tqus8+17ywxzg78pHJqjry939JCLCQ6w6+WefpnQt4ITMSc7en
         yXsc5qmWVc62cRvUY6lVV6DVDe6JO04GxyKXD4wXx55FGTQRRi0UhvYSQQpxseXluM4I
         M7DxaedcyNhJLIEAmHEMNFVrIjNYCELXJQpzcqOOuG6gDRcVxFoJsTrk0z2cA+s4QLRS
         HarFBXO6qpluidfGbB/HeODb7S+Dlg7vVt4DwYYfwO6/yvn8Uc1atvRXG52tAlEaqI13
         n20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576413; x=1715181213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NlXaWkfWscApjJVamzuM/t1PaeHWnW1AqCSWviBjFQ=;
        b=hT5FdSEGtnuk7htY7v0Jcv2sU9a3dZ3/3AY0/5yBgxfe2LYymDjMBbyUPk26HpyVLC
         DdbHQ8QmsqcHi7o5msMz96f4qE1e37O4kbJ1CWZ+2+arp0MgoA8VB0cCyYcFltPazh64
         oI75xSa/iA2NECw/d3xq3GCrGY230ID9tdXXaprp2ZQeHqDDkn7EfdgyZ+u+MNGcQ/E0
         AYKQWxT4/LvAXOllrm/r4Pt7nzcD3t3edrsedBJF3boM9Zkt8NU/Aw6Hv79p6U8E3SVn
         /viYwSlNbCnn8/7IjEpjYCl5RWGuCqiQdECn6zfR6m+G+r5fgkyUHQc0cYjVX6MObaSD
         9CYw==
X-Forwarded-Encrypted: i=1; AJvYcCVv5h1wOsMf/hKpCpRwQyi/evAhykhnv4vF+fft7BCOt5/XlZzvyRJG1nolORprLWCkqHM/zlWissrDeWVn86WDAjBP
X-Gm-Message-State: AOJu0Yy8pDDJxyjAWWiYnKmwBDNgmgF3ZRCZwxGUco7a0FNcMBWw/ImL
	rC6GsNe4Dse/wwi3ZfEfisewwjMj8eg4Iw0lVzc5d1hdpa3u2EV/
X-Google-Smtp-Source: AGHT+IGclSSJQujUmNUVwDgxmHnsOJaZ1DuFQLUGw0H5oQc6N7Jt75HvIZ9jIY3RMfNyPGWKcoXvnQ==
X-Received: by 2002:a17:903:113:b0:1e0:bc64:a37a with SMTP id y19-20020a170903011300b001e0bc64a37amr6456884plc.8.1714576412575;
        Wed, 01 May 2024 08:13:32 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902860600b001ec5f1f363csm2686694plo.90.2024.05.01.08.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:32 -0700 (PDT)
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
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/39] sched: Enumerate CPU cgroup file types
Date: Wed,  1 May 2024 05:09:43 -1000
Message-ID: <20240501151312.635565-9-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
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
index 987209c0e672..e48af9fbbd71 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11196,7 +11196,7 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 }
 #endif
 
-static struct cftype cpu_legacy_files[] = {
+static struct cftype cpu_legacy_cftypes[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
 		.name = "shares",
@@ -11425,21 +11425,21 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
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
@@ -11447,13 +11447,13 @@ static struct cftype cpu_files[] = {
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
@@ -11461,13 +11461,13 @@ static struct cftype cpu_files[] = {
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
@@ -11488,8 +11488,8 @@ struct cgroup_subsys cpu_cgrp_subsys = {
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
index 7e0de4cb5a52..0b6a34ba2457 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3505,4 +3505,25 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
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
2.44.0


