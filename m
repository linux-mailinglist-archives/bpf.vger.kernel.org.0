Return-Path: <bpf+bounces-69055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C5B8BC29
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3AC5B61297
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EEE2C08D1;
	Sat, 20 Sep 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upf1Fs+w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1626B0A9;
	Sat, 20 Sep 2025 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329996; cv=none; b=fBUKjqURl5XK3cTaZcYsT4SVLUCbCduL1amvx6qLqm5yMxDbDBpIm4wEyr7P945dQ/VmaMK/i5uXDGFUi249GV8wdZFsm4+aHRXjzv30xEG7P+0H5Xj3ecvjnwreuJ/CpDwo+ZzgHr/rRfKo2Ibmh/H8pSZnCgcoD1Lwn46uH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329996; c=relaxed/simple;
	bh=9Z3WNgXqW4CAIaAZOBX6UH4rwdoBjVrajjmyb9Z+Xu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRUZc6w39NiOrVBhxwUvm325VLyUGpuxeRC4J9jcYPP19T6ntkMNp7+t9bn7TD2Q2w+dnCTGCWFr37y51r3NyBezHmdAjedwQo0qtJOE98/g0i3DyJ7OiRZ2wKrz/MnBRnqUknHyURP16GpW9UjmDKxCFBlUs6Wy7IHHlyPT34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upf1Fs+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FEEC4CEF5;
	Sat, 20 Sep 2025 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329994;
	bh=9Z3WNgXqW4CAIaAZOBX6UH4rwdoBjVrajjmyb9Z+Xu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Upf1Fs+wvvvPVZ0MiUWyHPScT9C4GbdVeuQiSBYzpMZ/6xkcmDV/Cxw399p2XiIyx
	 DdUXsgDt78jIEWl5LOPj7EFLcl2YjgbuYB5wpWUHrHwWFPNwbUVaS/f8aAZMJ3NHI6
	 OWGoo3hr4j6vLPFuD2kcobBnN5HA/1QnV9oIQIZ96+oeRBvJtRIxYcR+RMrzF+drEM
	 Wn6ZQ696BWfFBUP/sq2AlJb1TywcIAZKJRY1h0nbJe04Yfv5BBWuVGSeGLNSbNaHlj
	 FgIxwi+hbD7Tq3Tr045eKVJabMqiHJUhV4CShaI1KY/J9oamD8ANDSBE6/o1eR1v7k
	 FhDtc7RKIqS5Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 20/46] sched_ext: Update p->scx.disallow warning in scx_init_task()
Date: Fri, 19 Sep 2025 14:58:43 -1000
Message-ID: <20250920005931.2753828-21-tj@kernel.org>
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

- Always trigger the warning if p->scx.disallow is set for fork inits. There
  is no reason to set it during forks.

- Flip the positions of if/else arms to ease adding error conditions.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ddceae539e11..0ee716ff4dab 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2825,7 +2825,10 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 	scx_set_task_state(p, SCX_TASK_INIT);
 
 	if (p->scx.disallow) {
-		if (!fork) {
+		if (unlikely(fork)) {
+			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
+				  p->comm, p->pid);
+		} else {
 			struct rq *rq;
 			struct rq_flags rf;
 
@@ -2844,9 +2847,6 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 			}
 
 			task_rq_unlock(rq, p, &rf);
-		} else if (p->policy == SCHED_EXT) {
-			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
-				  p->comm, p->pid);
 		}
 	}
 
-- 
2.51.0


