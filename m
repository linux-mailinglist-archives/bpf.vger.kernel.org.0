Return-Path: <bpf+bounces-70088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC8BB0CE1
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3A47B253F
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD79225A640;
	Wed,  1 Oct 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFtEbNoa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4F172626;
	Wed,  1 Oct 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330101; cv=none; b=ruk96Ohs+4f/RZlsB25li9hV+QFfFgX1cqwrIet8Yhy+yH+XDOp1xATi6jmQJmmJidLWHq9G1rNgowXqjVvSiUBGC1/SQQyBZmS3hzSAS2xMD3fI0qQHoYJAWuHV11604EpWu4Nr1/RZM+EuZNXhUF8Dud+49WZNKLnrB4S8D/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330101; c=relaxed/simple;
	bh=IUQ/08mc8j3yUFCIJ/ggXNU/xiz+c770Pku4qWT2tHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i7hgiorfnVdGMmyJMDpQFMqGgddG3gU00IKjO2RLew2sNqsokwGg3tczNrVAjA6KAqxyJB+p8L6le1HwNWuYJL/YaTRA8KkN3kIqkaylw8eWWc2QvUMJrM5gCi7zlqH5VL3VOWqs8/z27SWfnAYXVi7PIytjMztaKnEzm0gjEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFtEbNoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C053C4CEF1;
	Wed,  1 Oct 2025 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330100;
	bh=IUQ/08mc8j3yUFCIJ/ggXNU/xiz+c770Pku4qWT2tHQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=RFtEbNoaxzgFdCSARZ8YahBF4JCQn6VOoXSv1E6OPcRGieIYXRsvW7Lyw/mBkEu06
	 T8IMUNWXFK1/nVaNsNDohnEXc2641F7zGznSP9C9nSOv6p+u69jA4kC/L/wNec821B
	 RdZ/A+4o8TyALm5w//Ox4o99jhqDtotzGxHQakD+tQ5H80nTB5kYDjLzOFd5T5XQ+s
	 MhnZR/n2QKDtEkRhuuE/Bakrb5lCp3aXUQxjaCbyNE1l8spCZnVBSD7dskgxj3vdMR
	 ZzFIURB8MMvX+CIFePVNM8V4NkSfxVdqoL9pLcouBWV4tJhylqpn7lY4K9tkj3iO+j
	 /WlplaoIT/iFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9A97FCE0F80; Wed,  1 Oct 2025 07:48:17 -0700 (PDT)
Date: Wed, 1 Oct 2025 07:48:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	andrii@kernel.org, ast@kernel.org, peterz@infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/21] Implement RCU Tasks Trace in terms of SRCU-fast and
 optimize
Message-ID: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
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

This v2 series re-implements RCU Tasks Trace in terms of SRCU-fast,
reducing the size of the Linux-kernel RCU implementation by several
hundred lines of code.  It also removes a conditional branch from the
srcu_read_lock_fast() implementation in order to make SRCU-fast a bit
more fastpath-friendly.  The patches are as follows:

1.	Permit Tiny SRCU srcu_read_unlock() with interrupts disabled.

2.	Re-implement RCU Tasks Trace in terms of SRCU-fast.

3.	context_tracking: Remove
	rcu_task_trace_heavyweight_{enter,exit}().

4.	Clean up after the SRCU-fastification of RCU Tasks Trace.

5.	Move rcu_tasks_trace_srcu_struct out of #ifdef
	CONFIG_TASKS_RCU_GENERIC.

6.	Create an srcu_expedite_current() function.

7.	Test srcu_expedite_current().

8.	Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs.

9.	Update Requirements.rst for RCU Tasks Trace.

10.	Deprecate rcu_read_{,un}lock_trace().

11.	Create a DEFINE_SRCU_FAST().

12.	Create an rcu_tasks_trace_expedite_current() function.

13.	Test rcu_tasks_trace_expedite_current().

14.	Make grace-period determination use ssp->srcu_reader_flavor.

15.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().

16.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().

17.	Require special srcu_struct define/init for SRCU-fast readers.

18.	Make SRCU-fast readers enforce use of SRCU-fast definition/init.

19.	Update for SRCU-fast definitions and initialization.

20.	Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.

21.	Mark diagnostic functions as notrace.

Changes since v1:

o	Consolidate RCU Tasks Trace cleanup patches per Alexei Starovoitov
	feedback.  This explains the decrease from 34 patches in v1 to
	only 21 in this v2 series.

o	While consolidating, consolidate the noinstr-fast patches and the
	DEFINE_SRCU_FAST()/init_srcu_struct_fast() patches.

o	Upgrade comments per Peter Zijlstra feedback.

o	Extract Tiny SRCU bug fix into its own commit per Andrii Nakryiko
	feedback.

o	Switch srcu_expedite_current() from preempt_disable() to
	migrate_disable() for PREEMPT_RT kernels per Zqiang feedback.

o	Apply tags.

https://lore.kernel.org/all/580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop/

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Requirements/Requirements.rst   |   33 
 b/Documentation/RCU/Design/Requirements/Requirements.rst |   12 
 b/Documentation/RCU/checklist.rst                        |   12 
 b/Documentation/RCU/whatisRCU.rst                        |    3 
 b/Documentation/admin-guide/kernel-parameters.txt        |   15 
 b/include/linux/notifier.h                               |    2 
 b/include/linux/rcupdate.h                               |   31 
 b/include/linux/rcupdate_trace.h                         |  107 +-
 b/include/linux/sched.h                                  |    1 
 b/include/linux/srcu.h                                   |   16 
 b/include/linux/srcutiny.h                               |    1 
 b/include/linux/srcutree.h                               |    8 
 b/include/linux/tracepoint.h                             |   45 -
 b/include/trace/perf.h                                   |    4 
 b/include/trace/trace_events.h                           |    4 
 b/init/init_task.c                                       |    3 
 b/kernel/context_tracking.c                              |   20 
 b/kernel/fork.c                                          |    3 
 b/kernel/rcu/Kconfig                                     |   18 
 b/kernel/rcu/rcu.h                                       |    9 
 b/kernel/rcu/rcuscale.c                                  |    7 
 b/kernel/rcu/rcutorture.c                                |    2 
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
 include/linux/rcupdate_trace.h                           |   81 +
 include/linux/sched.h                                    |    5 
 include/linux/srcu.h                                     |   40 
 include/linux/srcutiny.h                                 |   14 
 include/linux/srcutree.h                                 |   50 -
 kernel/rcu/Kconfig                                       |   25 
 kernel/rcu/rcutorture.c                                  |   32 
 kernel/rcu/srcutree.c                                    |   39 
 kernel/rcu/tasks.h                                       |  129 ---
 41 files changed, 525 insertions(+), 978 deletions(-)

