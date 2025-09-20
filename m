Return-Path: <bpf+bounces-69037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2BBB8BB8D
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B383B2596
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002131D514B;
	Sat, 20 Sep 2025 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8wpgRzz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B3921C16A;
	Sat, 20 Sep 2025 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329977; cv=none; b=lLxgVX26DPHybx91PY+PwlCaHroOifH5HVtH+DyScZbSBbeQhBLIClOcMqiUf93VLd8vV1oMpcCTLgTEmRKqEQw7rFrHEm8sde4sFPHu1IUy+QRJR5zkuNI2UGLFaAn8TWlRa0wh505J0EPyNQSMAVRBeb81rjrdI+YRdIkMwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329977; c=relaxed/simple;
	bh=DX8xACRQB3Q0f9Mpj9jSY6cREEKLJMBXATnCxkYx2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8rUZRjv3ntNTlkHYzag5RIkFL/CUpxiYB2ASBmo96q4Rg8/g/bV3So8E5KSd05fwstJE9ZE8pt3alKJZKtgguykb8+9qNz+d2JU1kV4YLt/yHrn8leiBavy8zPwp67rbRH1cr4R0Ia7H2N5ARrfgCzPcoS59S01fpfsYttDih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8wpgRzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36745C4CEFA;
	Sat, 20 Sep 2025 00:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329977;
	bh=DX8xACRQB3Q0f9Mpj9jSY6cREEKLJMBXATnCxkYx2EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8wpgRzzuQoG/3X9F1miVyEOa1EkXx4nUfqvOB/4x6GN23yw6lepMhdijnUTiCSfi
	 RcnGfywq6Ie0+pnCYgFumnP6El8uwB5FNVGFELKb8UjmMDRisDpmoJORz9W/l6fBIO
	 7rPf3zu/Xu/xeEd8HT6id8Pu1pYUZukhovTI5fGx4znQe8ckRl6OHrlfjCL5A+nZEA
	 NnuCQvUAFcYE1PsagQZ1pLWzCgMn2IdkUcTa007mcc+7joES6F1CxTszpffLFfzdUF
	 TGWiOcOVu0gRvyQmTaPNV5JCylM8wo4TYbxtwaQ//2tSUPL0b5ZW4ouctKAGw7duiR
	 ZAmwABU6NYRLA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/46] sched_ext: Fix stray scx_root usage in task_can_run_on_remote_rq()
Date: Fri, 19 Sep 2025 14:58:26 -1000
Message-ID: <20250920005931.2753828-4-tj@kernel.org>
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

task_can_run_on_remote_rq() takes @sch but it is using scx_root when
incrementing SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE, which is inconsistent and
gets in the way of implementing multiple scheduler support. Use @sch
instead. As currently scx_root is the only possible scheduler instance, this
doesn't cause any behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index df433f6fab4b..5801ac676d59 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1622,8 +1622,7 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	if (!scx_rq_online(rq)) {
 		if (enforce)
-			__scx_add_event(scx_root,
-					SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE, 1);
+			__scx_add_event(sch, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE, 1);
 		return false;
 	}
 
-- 
2.51.0


