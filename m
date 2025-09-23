Return-Path: <bpf+bounces-69430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF39B96420
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D364218A1683
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F61329F34;
	Tue, 23 Sep 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENRh2Xt9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308132951D;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637316; cv=none; b=tiwFvqqHoDmZVga82SfOE0YVPeuuOSggiLLvoiwh5Mjtj8D49jFpH5WO7tx9gc/5uasvLUCybgOkHPgb67e++jT6ih1uvCpOwd5AxSTaeabf7ZCaDVlNsXmOs39feNP6wbulAL4OFIdTUZfeQHZSKZol0bgxBmOfcGY3Ogv+t+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637316; c=relaxed/simple;
	bh=yoqbhMjTVIhFKUY7WHtA9XbOwGqrdzO6YdCd2MFIJdw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=erT+UL3906FBESm8NW09dLc4YvUQq0v96pBt12Mb0+0s6RVELXVmSaGmpShCYx4ut8PrUEHgZQqwtUBGdAL7HxHQ8Zs3YxTanpSeW6Im62naAy/FUxFmp30+O72+U8kqb6zPNDV6ZN6qHVTZhOmystqZCJFEw3bM4NFt2KKuaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENRh2Xt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED77C113CF;
	Tue, 23 Sep 2025 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637316;
	bh=yoqbhMjTVIhFKUY7WHtA9XbOwGqrdzO6YdCd2MFIJdw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=ENRh2Xt9+rk8cIOOyaMtdkdQqRR9Owy32/W64hPfCbA6AjctbqOoI0d7M4NJeR3q6
	 vktioI/cmW+XhZOQ7Zurs31PGoPgR59Hwsmp8Ef3T9ADdlBF8WzmqZ8kVs+APYFIec
	 c7e+FtcU9kU8TFTTHfwUqmGigRSxQy0g8YTfiTg+qj2Hnjnq0oJgrV7LWWgiI1/iua
	 bdhdjXddlOiRaj4lsTO3ExmQ93RWN4UaaqH4nGSHVUSkBU+NfAQd+jLNSfX479w4Z9
	 1HN7aK3IQY4+295eoXFQjbkarLRP9fuDJUPeai+2OfY1x+AYCCt8fTVgrTAH5YE0mf
	 rXjx+87R/rtJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 44229CE0E40; Tue, 23 Sep 2025 07:20:27 -0700 (PDT)
Date: Tue, 23 Sep 2025 07:20:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	andrii@kernel.org, ast@kernel.org, peterz@infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH 0/34] Implement RCU Tasks Trace in terms of SRCU-fast and
 optimize
Message-ID: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series re-implements RCU Tasks Trace in terms of SRCU-fast,
reducing the size of the Linux-kernel RCU implementation by several
hundred lines of code.  It also removes a conditional branch from the
srcu_read_lock_fast() implementation in order to make SRCU-fast a
bit more fastpath-friendly.  The patches are as follows:

1.	Re-implement RCU Tasks Trace in terms of SRCU-fast.

2.	Remove unused ->trc_ipi_to_cpu and ->trc_blkd_cpu from
	task_struct.

3.	Remove ->trc_blkd_node from task_struct.

4.	Remove ->trc_holdout_list from task_struct.

5.	Remove rcu_tasks_trace_qs() and the functions that it calls.

6.	context_tracking: Remove
	rcu_task_trace_heavyweight_{enter,exit}().

7.	Remove ->trc_reader_special from task_struct.

8.	Remove now-empty RCU Tasks Trace functions and calls to them.

9.	Remove unused rcu_tasks_trace_lazy_ms and trc_stall_chk_rdr
	struct.

10.	Remove now-empty show_rcu_tasks_trace_gp_kthread() function.

11.	Remove now-empty rcu_tasks_trace_get_gp_data() function.

12.	Remove now-empty rcu_tasks_trace_torture_stats_print() function.

13.	Remove now-empty get_rcu_tasks_trace_gp_kthread() function.

14.	Move rcu_tasks_trace_srcu_struct out of #ifdef
	CONFIG_TASKS_RCU_GENERIC.

15.	Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs.

16.	Remove now-unused rcu_task_ipi_delay and TASKS_TRACE_RCU_READ_MB.

17.	Create a DEFINE_SRCU_FAST().

18.	Use smp_mb() only when necessary in RCU Tasks Trace readers.

19.	Update Requirements.rst for RCU Tasks Trace.

20.	Deprecate rcu_read_{,un}lock_trace().

21.	Mark diagnostic functions as notrace.

22.	Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.

23.	Create an srcu_expedite_current() function.

24.	Test srcu_expedite_current().

25.	Create an rcu_tasks_trace_expedite_current() function.

26.	Test rcu_tasks_trace_expedite_current().

27.	Make DEFINE_SRCU_FAST() available to modules.

28.	Make SRCU-fast available to heap srcu_struct structures.

29.	Make grace-period determination use ssp->srcu_reader_flavor.

30.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().

31.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().

32.	Require special srcu_struct define/init for SRCU-fast readers.

33.	Make SRCU-fast readers enforce use of SRCU-fast definition/init.

34.	Update for SRCU-fast definitions and initialization.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Requirements/Requirements.rst   |   33 
 Documentation/admin-guide/kernel-parameters.txt          |    7 
 b/Documentation/RCU/Design/Requirements/Requirements.rst |   12 
 b/Documentation/RCU/checklist.rst                        |   12 
 b/Documentation/RCU/whatisRCU.rst                        |    3 
 b/Documentation/admin-guide/kernel-parameters.txt        |    8 
 b/include/linux/notifier.h                               |    2 
 b/include/linux/rcupdate.h                               |   26 
 b/include/linux/rcupdate_trace.h                         |  107 +-
 b/include/linux/sched.h                                  |    1 
 b/include/linux/srcu.h                                   |   16 
 b/include/linux/srcutiny.h                               |    1 
 b/include/linux/srcutree.h                               |   20 
 b/include/linux/tracepoint.h                             |   45 -
 b/include/trace/perf.h                                   |    4 
 b/include/trace/trace_events.h                           |    4 
 b/init/init_task.c                                       |    1 
 b/kernel/context_tracking.c                              |   20 
 b/kernel/fork.c                                          |    1 
 b/kernel/rcu/Kconfig                                     |    2 
 b/kernel/rcu/rcu.h                                       |    5 
 b/kernel/rcu/rcuscale.c                                  |    6 
 b/kernel/rcu/rcutorture.c                                |    1 
 b/kernel/rcu/refscale.c                                  |    9 
 b/kernel/rcu/srcutiny.c                                  |   13 
 b/kernel/rcu/srcutree.c                                  |   58 +
 b/kernel/rcu/tasks.h                                     |  617 ---------------
 b/kernel/rcu/tree.c                                      |    2 
 b/kernel/rcu/update.c                                    |    8 
 b/kernel/tracepoint.c                                    |   21 
 b/scripts/checkpatch.pl                                  |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 |    1 
 include/linux/rcupdate.h                                 |    5 
 include/linux/rcupdate_trace.h                           |   85 +-
 include/linux/sched.h                                    |    5 
 include/linux/srcu.h                                     |   40 
 include/linux/srcutiny.h                                 |   16 
 include/linux/srcutree.h                                 |   48 -
 init/init_task.c                                         |    2 
 kernel/fork.c                                            |    2 
 kernel/rcu/Kconfig                                       |   41 
 kernel/rcu/rcu.h                                         |    4 
 kernel/rcu/rcuscale.c                                    |    1 
 kernel/rcu/rcutorture.c                                  |   33 
 kernel/rcu/srcutree.c                                    |   39 
 kernel/rcu/tasks.h                                       |  129 ---
 47 files changed, 529 insertions(+), 990 deletions(-)

