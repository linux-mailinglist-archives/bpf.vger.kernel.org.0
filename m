Return-Path: <bpf+bounces-69427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A923B963DB
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FC93BFCF5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7176329F14;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ParMViib"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55822328995;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637316; cv=none; b=RkYgyi07e4mLtMHImiXzuhD5asQZu8aZb6ou0Fyhl4w2gx8dQx45VqXsubPmr9RnaUbOGoIOxy1x5NsoAGsfup5ysU4+BSD2eZD345c7+C+qH0OA7DBtZ3wByTpMN8xiIM/WsBtDO3u0skpBRWpmlxfq6rcvVEaF6/QoQND5iYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637316; c=relaxed/simple;
	bh=dnfn0DMyZqHCyXyDBX7gMCl/aLGTGuiQmNJ7YTCoJDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDpH6GrVeLyjPnXM8vtGGZDme181ZFh6hNTw9kZje6dmCcCcjqefrpcP1KvLrWvIqqedbWNzWbuuOzpFJojravS8/Aa/foYKD0JBxxVlS4/rPPXMR4Fmb3wyKw3U7B8ssRHnutS0wBsrvlcj5vp4jVfufCQjzllYigrx4JrWowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ParMViib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49DAC2BCB2;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637316;
	bh=dnfn0DMyZqHCyXyDBX7gMCl/aLGTGuiQmNJ7YTCoJDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ParMViibAmTiqgmB/IaxzQprSDe/SSYbMrxjZuNxLy6Idjo9dZ7kQRw5NzLellG2E
	 hdKH2/297Ey+6gSGkBjDXb4/ZDFRBrQzOY9vXUK2yxKxg+3gPPSMIo2x8xbxFuQ/5v
	 r0fp5fj4bGXlHXxTf7x14SxjGtQlO7ghIBG6/YSqqC8Ogg1UE3CBQNuPi+t83qCLgE
	 tkxOWoIDWawKIiXakty6VpJhY74sIQ6ZwH1dJ84lgAFTg/Bs87rdGGqOuo39B8shU0
	 mckXAWK0ZLywViwmRrPaYRUZ8xDOFZyypZDu+y7phQ29h+HW+aOFoArhKjmm5GNt7J
	 Rzili71TsYQQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7442CE1418; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 13/34] rcu: Remove now-empty get_rcu_tasks_trace_gp_kthread() function
Date: Tue, 23 Sep 2025 07:20:15 -0700
Message-Id: <20250923142036.112290-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_rcu_tasks_trace_gp_kthread() is used by rcuscale to diagnose
bugs involving the RCU Tasks Trace grace-period kthread, which now no
longer exists.  This commit therefore removes this function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate_trace.h | 1 -
 kernel/rcu/rcuscale.c          | 1 -
 kernel/rcu/tasks.h             | 6 ------
 3 files changed, 8 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index ffd4dcd6339ae4..0bd47f12ecd17b 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -137,7 +137,6 @@ static inline void rcu_barrier_tasks_trace(void)
 
 // Placeholders to enable stepwise transition.
 void __init rcu_tasks_trace_suppress_unused(void);
-struct task_struct *get_rcu_tasks_trace_gp_kthread(void);
 
 #else
 /*
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 16ba9050dab66b..17d038e26b65de 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -411,7 +411,6 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 	.gp_barrier	= rcu_barrier_tasks_trace,
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
-	.rso_gp_kthread	= get_rcu_tasks_trace_gp_kthread,
 	.name		= "tasks-tracing"
 };
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4fb61b3c78283d..e70609c85ece5d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1467,12 +1467,6 @@ void __init rcu_tasks_trace_suppress_unused(void)
 	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
 }
 
-struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
-{
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
-
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
 #ifndef CONFIG_TINY_RCU
-- 
2.40.1


