Return-Path: <bpf+bounces-56730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873E4A9D32B
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321F31B6325E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF0D224233;
	Fri, 25 Apr 2025 20:41:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472822370F;
	Fri, 25 Apr 2025 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613676; cv=none; b=Ptfq9oqsmKDXWXP5r/+L0PB3xs7oHpiwfVTn20ua/qw1qOkmli/FV+0t6EigcWhXL6TO1X7TVieyCZatSIBiVNN9Qy9jxwV+o/ae1I7B2k5PlVE1xROCwhy87vMx5nuXuZcL6DyHC3VZYDHYr1Nf2A2boBNHRG3Y4MKfyY9AOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613676; c=relaxed/simple;
	bh=7jIzFulZv8yJPbz0IMKchFoi4kjUIdNA3gUxrBgPne0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rzMWJX8ee18fjQEIeodbgMJPG0mKqf4kpnsdih9IflfadWkfj1Wxh7DQeK7Z5QZjxRMogxM6P/zaQe3nJS4pQ1RHhQaF9v1Vtd1vUcoai9PE32jAmtDES0aeJlld8cHrsbIOcR9m99SsSM7sbZ/KvQLnSlREqkEd9Yl51SJViaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4A5C4CEE4;
	Fri, 25 Apr 2025 20:41:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u8PtB-000000004R9-3C54;
	Fri, 25 Apr 2025 16:43:13 -0400
Message-ID: <20250425204313.616425861@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Apr 2025 16:41:21 -0400
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
Subject: [RFC][PATCH 1/2] kthread: Add is_user_thread() and is_kernel_thread() helper functions
References: <20250425204120.639530125@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to know if a task is a user thread or a kernel thread it is
recommended to test the task flags for PF_KTHREAD. The old way was to
check if the task mm pointer is NULL.

It is an easy mistake to not test the flag correctly, as:

	if (!(task->flag & PF_KTHREAD))

Is not immediately obvious that it's testing for a user thread.

Add helper functions:

  is_user_thread()
  is_kernel_thread()

that can make seeing what is being tested for much more obvious:

	if (is_user_thread(task))

Link: https://lore.kernel.org/all/20250425133416.63d3e3b8@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/sched.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac1982893..823f38b0fd3e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1785,6 +1785,16 @@ static __always_inline bool is_percpu_thread(void)
 #endif
 }
 
+static __always_inline bool is_user_thread(struct task_struct *task)
+{
+	return !(task->flags & PF_KTHREAD);
+}
+
+static __always_inline bool is_kernel_thread(struct task_struct *task)
+{
+	return task->flags & PF_KTHREAD;
+}
+
 /* Per-process atomic flags. */
 #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
 #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
-- 
2.47.2



