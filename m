Return-Path: <bpf+bounces-69050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444EB8BBD8
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4D0174F01
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB026E711;
	Sat, 20 Sep 2025 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT82JATG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4A26B098;
	Sat, 20 Sep 2025 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329992; cv=none; b=tgECMqeqfyaSv6mBGInWTOi/euWRwwXmqXSaqvCYcpRy5+43qMIXRtxtdXDE4UB/VusZc8wbjLo8ONc0S5h66pEBTnsPVHLU6WKharo+QVFVYe68UYnua8MX3dXFT4eUM2gbKsQuvqJnJ6wu5IDO0T+GdBYJNevOGllNf60+N/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329992; c=relaxed/simple;
	bh=xzfj4LPy2mT0HW1TSm0enbz44zGQS+PqKNS2MD/8XCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyDovQUaKYNamiJNmetcU4DVf/21m5jEmVNFt2wrQF+36MMWYm7q7F6UCqjFRNnzCzluWvEzvjHLHbbXv2JGoy0vsSiVjasIvvbIH8gVKl+dRe/ZV3DT+gX/UqBGa+N12jTvVeCcmm6mCeX1Ng3mbUiAkAHVIg98DWxZkMNBmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT82JATG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02DDC4CEF0;
	Sat, 20 Sep 2025 00:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329991;
	bh=xzfj4LPy2mT0HW1TSm0enbz44zGQS+PqKNS2MD/8XCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PT82JATGmTpakqIcm+ogWCHqa/FHNze0znv4FiLdbjw46eiR+aVhWmLBMjjsJndjt
	 6AJ8GnHFA4FdubGQoaMQL8LSCeItxxnZ13MrXcQ3HJFDTTPhQmI0fojQuJppji2Ctw
	 PEsFqMyzF3BZgnwyX+RKTCn3BewAlfVy0SDs1r5fasLk8STOF2dHMGemkWir2AShfD
	 1jcTFato2ZzXL89DvMPIOYAiwrg4l/8OZnrnRhPXs1Pi9JWXka5CaoP/3TdNZFpWGb
	 ddosTM0qRzfJdzMrhiZ0qC+8webM/AhoPl/1WXmhGXVpvOpH95G6epytggpjEbbDRt
	 TW+sMLYAKevRA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 17/46] sched_ext: Add @kargs to scx_fork()
Date: Fri, 19 Sep 2025 14:58:40 -1000
Message-ID: <20250920005931.2753828-18-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sched_cgroup_fork() pass @kargs to scx_fork(). This will be used to
determine @p's cgroup for cgroup sub-sched support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 2 +-
 kernel/sched/ext.c  | 2 +-
 kernel/sched/ext.h  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 27dda808ed83..f2c6aaf4cc77 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4805,7 +4805,7 @@ int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
-	return scx_fork(p);
+	return scx_fork(p, kargs);
 }
 
 void sched_cancel_fork(struct task_struct *p)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ca8221378924..ddceae539e11 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2950,7 +2950,7 @@ void scx_pre_fork(struct task_struct *p)
 	percpu_down_read(&scx_fork_rwsem);
 }
 
-int scx_fork(struct task_struct *p)
+int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 43429b33e52c..0b7fc46aee08 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -11,7 +11,7 @@
 void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
-int scx_fork(struct task_struct *p);
+int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
 bool scx_can_stop_tick(struct rq *rq);
@@ -44,7 +44,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
-static inline int scx_fork(struct task_struct *p) { return 0; }
+static inline int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
 static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
-- 
2.51.0


