Return-Path: <bpf+bounces-69068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C949B8BC4A
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE7E5618EB
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28C32DF6FA;
	Sat, 20 Sep 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHDkIf7b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2356B2DF714;
	Sat, 20 Sep 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330011; cv=none; b=DmQ3VMsK2giyFQgaCG99HHNdeN2Ga7wWSkb6k7f8DWnA4wPACsqMU+VUpVJveIfFQKO88HP4GPmlMeO5oelOqjAWts2PeSdPufjzokm4neGZ6CHEMNV3YAnlTB073GDwCFXqLEHqy/N6kudJdC7/YEVhzYYmtO9To15Nwm3AKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330011; c=relaxed/simple;
	bh=1h7JbbWJxult9FJRkXv1UbPtXhywndlgT7Un/HQmmHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKfyTMwkSHp51tX5FzMfSm9d8tzcE+hkj7QPFarSGdfahM9EtQO/HimpwcuFdW4orsdDxE909oOB6Sbw54zOHjH3c6AjZJYw40GkSf/s/iOQenjA4elOK75WHvTPogRtP7AnEdqD6cSaHWlHALK2L7EGvkiRPMLPXx6Rysci7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHDkIf7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBAAC4CEF0;
	Sat, 20 Sep 2025 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330011;
	bh=1h7JbbWJxult9FJRkXv1UbPtXhywndlgT7Un/HQmmHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHDkIf7b/2PQbKWdpIoxyBeQ1g6s1voGXdqiRjAtC4YNVW1Jg/+O5AbRL4V14yXPl
	 GuW297mjNSTvDhd43AFVXRXlhTMt2FY8sJ+T/ioXzx/6sndNeSwy9dvVvAVo+MUr/v
	 XYZub0/o5NlDjSHCZc0qGb//h1E6FxXU7qsy/Kpn01BLPqOr1QlkPhIfcIvQJ45tHu
	 kI9FyQ9TeLI8DdZKfPMm28LZNm8YahJ2AKY8vRVQukQ46KIRJK3Yo+SDgTO7Yhoafn
	 cgOo/QKHp0GSHYo5oaf3FiW7Ct0DY4Fjxi5bwG6BTiYhKqbHXBleYd+bv6EuSgCsN8
	 hePPCGj5fBEaQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 34/46] sched_ext: When calling ops.dispatch() @prev must be on the same scx_sched
Date: Fri, 19 Sep 2025 14:58:57 -1000
Message-ID: <20250920005931.2753828-35-tj@kernel.org>
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

The @prev parameter passed into ops.dispatch() is expected to be on the
same sched. Passing in @prev which isn't on the sched can spuriously
trigger failures that can kill the scheduler. Pass in @prev iff it's on
the same sched.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index efe01ba84e2d..714b45a55112 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2182,8 +2182,9 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			       struct task_struct *prev)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
-	bool prev_on_scx = prev->sched_class == &ext_sched_class;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
+	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
+		sch == rcu_access_pointer(prev->scx.sched);
 
 	if (consume_global_dsq(sch, rq))
 		return true;
@@ -2205,7 +2206,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		dspc->nr_tasks = 0;
 
 		SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq,
-			    cpu_of(rq), prev_on_scx ? prev : NULL);
+			    cpu_of(rq), prev_on_sch ? prev : NULL);
 
 		flush_dispatch_buf(sch, rq);
 
-- 
2.51.0


