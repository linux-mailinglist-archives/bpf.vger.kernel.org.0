Return-Path: <bpf+bounces-70099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F091BB0D1F
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774BF3AC28A
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425330649D;
	Wed,  1 Oct 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qytJBxiv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16220303C8D;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330120; cv=none; b=OiaqCvTmsQJoQmqDdRJhe9OUoJqI+rmIT/CpDA989ZpqObifq08AikR3Lmi+Wq1Nqm5aHs11imSawHKvKLF2DTM6ZCNn+jTrrwqRYvLRRrMZlzHunfm1B7RJ+FCh28Fj11XxnzUqr05O+GU5Vzl1Fv5CLRrFHNicF+ux/25eAQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330120; c=relaxed/simple;
	bh=voJ4b6wMLOYakegASPWhkeR8X8Tsr/P1l+3ILgsYDF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idOtMMjnAA+/YFUq78kEy7BMSgoqdUotkKOfW1D5a2hMiY2m3yQ/mfiMgYfuusiiBsTZav0zUOay79xAptmDEtYgDNkNoo9tYCfYonasKYKEuBs3kViYNGwStMF05fizdrFiNHvhul7AjfRAPcu31xjhmH2bh1YEfoG+d4vcz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qytJBxiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B70EC19421;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330119;
	bh=voJ4b6wMLOYakegASPWhkeR8X8Tsr/P1l+3ILgsYDF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qytJBxiv1s6olJZLe2hETNHsEYKMrLB29Vkbely3ZSm6YP69cs1k5G+Jfj2CPkW9x
	 HO0vJZrDz+Oyb34tuNNP6de2Wywajwe2IZ8ZyJDOXg5N3PgT4601b5LvuYUIfxMODN
	 8CAWvGhx3bfeuXVsPtBAqYdVr0iU+eOxqrLNoPabT08gtc/FDpUh3lI+h7mdR/LOzJ
	 1heSb0BkPIXCSMRUmRV5jztwTOJZ3uxTtGuKIB2rapvmIEc2BGQogLBTCjOIwXO2Ez
	 kZyRoAxGV3lFF2+a7RIgaLaz+LfUshyk0iSKAMsJzXnJCkZvjcWkY8r6V5l/A6PhcW
	 GMTcyPCGvQ8Sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8254FCE1436; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2 13/21] rcutorture: Test rcu_tasks_trace_expedite_current()
Date: Wed,  1 Oct 2025 07:48:24 -0700
Message-Id: <20251001144832.631770-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a ->exp_current member to the tasks_tracing_ops structure
to test the rcu_tasks_trace_expedite_current() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 64803d09fc733a..2e3806b996a80a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1136,6 +1136,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
+	.exp_current	= rcu_tasks_trace_expedite_current,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
 	.cbflood_max	= 50000,
-- 
2.40.1


