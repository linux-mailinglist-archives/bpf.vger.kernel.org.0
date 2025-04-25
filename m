Return-Path: <bpf+bounces-56728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44302A9D326
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEAC3BA606
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0A82222C2;
	Fri, 25 Apr 2025 20:41:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF719E7FA;
	Fri, 25 Apr 2025 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613675; cv=none; b=coGqIuGJWvnONg4GuXzkC98k+7q+dLXTr9/NMPHMS4frWzcnD0RQtTMHGufnmApzzDO/7y/NQH1T87Z599HVpYScW9hMGZ3SZuJRsUkLTSl/dYwdDVfJQtShtUo0IvgqKrlRZ8qtWKRGsvHZdjDvDW3zokBoQixO4AwdNUY7RCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613675; c=relaxed/simple;
	bh=T5Se3pBJwcMYnKAP9wBI4VXJQQY5tEgKvs9XmLOFxIg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=L2/+eAYPUwtla+tn9HjeLWqTG0pQfkkumBzl8iOrHNpEj3ekQ24vv8J50b0PzhBKOX29nJ7xD/9HDgHo/FL29mDkazMsU1OsVqnzQWgIc7f7RViQKed5HJWK90jA1w4FC6DhExQ+EnYOZmxXlEfw4j+DQbo9MuVO4XWYZpo9LVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3474DC4CEE9;
	Fri, 25 Apr 2025 20:41:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u8PtB-000000004Qd-2Sjy;
	Fri, 25 Apr 2025 16:43:13 -0400
Message-ID: <20250425204120.639530125@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Apr 2025 16:41:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org,
 Kees Cook <kees@kernel.org>,
 bpf@vger.kernel.org,
 Tejun Heo <tj@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
Subject: [RFC][PATCH 0/2] Add is_user_thread() and is_kernel_thread() helper functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


While working on the deferred stacktrace code, Peter Zijlstra told
me to use task->flags & PF_KTHREAD instead of checking task->mm for NULL.
This seemed reasonable, but while working on it, as there were several
places that check if the task is a kernel thread and other places that
check if the task is a user space thread I found it a bit confusing
when looking at both:

	if (task->flags & PF_KTHREAD)
and
	if (!(task->flags & PF_KTHREAD))

Where I mixed them up sometimes, and checked for a user space thread when I
really wanted to check for a kernel thread. I found these mistakes before
sending out my patches, but going back and reviewing the code, I always had
to stop and spend a few unnecessary seconds making sure the check was
testing that flag correctly.

To make this a bit more obvious, I introduced two helper functions:

	is_user_thread(task)
	is_kernel_thread(task)

which simply test the flag for you. Thus, seeing:

	if (is_user_thread(task))
or
	if (is_kernel_thread(task))

it was very obvious to which test you wanted to make.

I then created a coccinelle script to change all the checks throughout the
kernel to use one of these macros.

      $ cat kthread.cocci
      @@
      identifier task;
      @@
      -     !(task->flags & PF_KTHREAD)
      +     is_user_thread(task)
      @@
      identifier task;
      @@
      -     (task->flags & PF_KTHREAD) == 0
      +     is_user_thread(task)
      @@
      identifier task;
      @@
      -     (task->flags & PF_KTHREAD) != 0
      +     is_kernel_thread(task)
      @@
      identifier task;
      @@
      -     task->flags & PF_KTHREAD
      +     is_kernel_thread(task)
    
      $ spatch --dir --include-headers kthread.cocci . > /tmp/t.patch
      $ patch -p1 < /tmp/t.patch

Make sure to undo the conversion of the helper functions themselves!
        
      $ git show include/linux/sched.h | patch -p1 -R

It did modify the tools/sched_ext code, and I'm not sure if that's OK
or not. Does it still use the sched.h header? If so, it should be fine.
But if it is an issue, I can undo the changes to tools as well.


Steven Rostedt (2):
      kthread: Add is_user_thread() and is_kernel_thread() helper functions
      treewide: Have the task->flags & PF_KTHREAD check use the helper functions

----
 arch/arm/mm/init.c                         |  2 +-
 arch/arm64/include/asm/uaccess.h           |  2 +-
 arch/arm64/kernel/process.c                |  2 +-
 arch/arm64/kernel/proton-pack.c            |  2 +-
 arch/mips/kernel/process.c                 |  2 +-
 arch/powerpc/kernel/process.c              |  2 +-
 arch/powerpc/kernel/stacktrace.c           |  2 +-
 arch/x86/kernel/fpu/core.c                 |  2 +-
 arch/x86/kernel/process.c                  |  2 +-
 block/blk-cgroup.c                         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-
 drivers/md/dm-vdo/logger.c                 |  2 +-
 drivers/tty/sysrq.c                        |  2 +-
 fs/bcachefs/clock.c                        |  2 +-
 fs/bcachefs/journal_reclaim.c              |  2 +-
 fs/bcachefs/move.c                         |  6 +++---
 fs/exec.c                                  |  2 +-
 fs/file_table.c                            |  2 +-
 fs/namespace.c                             |  2 +-
 fs/proc/array.c                            |  4 ++--
 fs/proc/base.c                             |  6 +++---
 include/linux/sched.h                      | 10 ++++++++++
 io_uring/io_uring.c                        |  2 +-
 kernel/cgroup/cgroup.c                     |  6 +++---
 kernel/cgroup/freezer.c                    |  4 ++--
 kernel/events/core.c                       |  2 +-
 kernel/exit.c                              |  2 +-
 kernel/fork.c                              |  6 +++---
 kernel/freezer.c                           |  4 ++--
 kernel/futex/pi.c                          |  2 +-
 kernel/kthread.c                           | 12 ++++++------
 kernel/livepatch/transition.c              |  2 +-
 kernel/power/process.c                     |  2 +-
 kernel/sched/core.c                        |  6 +++---
 kernel/sched/idle.c                        |  2 +-
 kernel/sched/sched.h                       |  4 ++--
 kernel/signal.c                            |  4 ++--
 kernel/stacktrace.c                        |  2 +-
 lib/is_single_threaded.c                   |  2 +-
 mm/memcontrol.c                            |  2 +-
 mm/oom_kill.c                              |  4 ++--
 mm/page_alloc.c                            |  2 +-
 mm/vmscan.c                                |  2 +-
 security/keys/request_key.c                |  2 +-
 security/smack/smack_access.c              |  2 +-
 security/smack/smack_lsm.c                 |  4 ++--
 security/tomoyo/network.c                  |  2 +-
 security/yama/yama_lsm.c                   |  2 +-
 tools/sched_ext/scx_central.bpf.c          |  2 +-
 tools/sched_ext/scx_flatcg.bpf.c           |  2 +-
 tools/sched_ext/scx_qmap.bpf.c             |  2 +-
 51 files changed, 82 insertions(+), 72 deletions(-)

