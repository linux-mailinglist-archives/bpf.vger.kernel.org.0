Return-Path: <bpf+bounces-56793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D764DA9DCC7
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 20:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAD21B67A28
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3225DCF5;
	Sat, 26 Apr 2025 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEgR5Gac"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D01EDA23;
	Sat, 26 Apr 2025 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745692948; cv=none; b=HUnv11JY547DvQMKOF+QEjS8/DEK3eTdpW9kPwE6PsKBAMJmM8//EgQZ4uel7ZyUW9JFjVmS7TO0kwUx0hbWrFFaPBt57418qQvg6JB9cFR1U8S3fUevUu7jp2Q59NvtYNAZ7aU0Ar8QpbMkq+FYVFDJEWis2Irq072YgyiQA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745692948; c=relaxed/simple;
	bh=fj1/d24GDTzwVAy7KdYIyKPfBQUtNOCWWyBxY/0Mrig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMunpBtKQ2nMm5Hgn1iNAVpcnYPHMgjVeZpK0gHvY0rsZujMxDdVw394lCXpXF8+PazSOxrerngy1aFIKelRxVsDnusSO3bvOZl02SoBmCSH3m60RWk5Z+NGWdJSOXrGyJgaB4cvR11TBC41Z8O/+1MQRvhFIVCMqoZANgZBaa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEgR5Gac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C0BC4CEE2;
	Sat, 26 Apr 2025 18:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745692947;
	bh=fj1/d24GDTzwVAy7KdYIyKPfBQUtNOCWWyBxY/0Mrig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cEgR5GacthLHM5UOOI8D7eoU9Mypr8XcGGQXPOlxffObvN+GL/wexHcwRAqud279f
	 8Fyv2YOcuKWYLF5+8yrwFZQbOI/UOJneEL6+NBDqBsARMO6kQjgtfHDD1tu/cXpT+s
	 949ssxYBMPw2vWg2nnRYLIr5JbGCLWFlx7ffl/dykcimz5x1WBnO3fDUBLRdiOmZzV
	 fu8XJVfP/oaKNqixDNcvs5dvE6sF0sNdmsxI+TYzaRTr6cT1cVhPMM91ICiSzrEghL
	 f55f0+UAqmVPSyglE5LYxdZZW/rb7QYurNYtt0gVIxmlZKp6zrq61gRxvDEwFkV5WP
	 Ft20QCowJSN5A==
Date: Sat, 26 Apr 2025 20:42:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Kees Cook <kees@kernel.org>, bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/core: Introduce task_*() helpers for PF_ flags
Message-ID: <aA0pDUDQViCA1hwi@gmail.com>
References: <20250425204120.639530125@goodmis.org>
 <20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
 <20250426084320.335d4cb2@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426084320.335d4cb2@batman.local.home>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 25 Apr 2025 16:14:49 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > Seems sensible.  Please consider renaming PF_KTHREAD in order to break
> > missed conversion sites.
> 
> It's not wrong to use the thread. I just find using these helper
> functions a bit easier to review code. There's also some places that
> have special tests where it can't use the flag:
> 
> kernel/sched/core.c:    if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
> kernel/sched/fair.c:    if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
> kernel/trace/bpf_trace.c:                    current->flags & (PF_KTHREAD | PF_EXITING)))
> kernel/trace/bpf_trace.c:       if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
> 
> Maybe we can have a: is_user_exiting_or_kthread() ?

No, we don't need is_user_exiting_or_kthread(). At all. Ever. In this 
universe. Or in any alternative universes. We don't even need 
is_user_exiting_or_kthread() in horror fiction novels written for 
kernel developers: there's really a limit to the level of horror that 
people are able to accept. Sheesh ...

This:

	if (task_kthread(task) || task_exiting(task))
		...

is a perfectly fine and readable C expression.

There's also *zero* reason for the whole is_*() complication your 
methods introduce. There's no need for 'is_' if we put a proper noun as 
a prefix before these methods, such as task_*(), and it also nicely 
organizes the namespace!

Let's not complicate trivial use of C logical operators unnecessarily, 
and let's not suck at namespaces more than we need to, 'kay?

( What's next, are we going to redefine 'if (x)' statements???
  ... wait a minute ... ;-)

The attached patch does the sane thing and introduces the following 
helpers for PF_ flags:

	/*
	 * Helpers for PF_ flags:
	 */
	#define task_vcpu(task)				((task)->flags & PF_VCPU)
	#define task_idle(task)				((task)->flags & PF_IDLE)
	#define task_exiting(task)			((task)->flags & PF_EXITING)
	#define task_postcoredump(task)			((task)->flags & PF_POSTCOREDUMP)
	#define task_io_worker(task)			((task)->flags & PF_IO_WORKER)
	#define task_wq_worker(task)			((task)->flags & PF_WQ_WORKER)
	#define task_forknoexec(task)			((task)->flags & PF_FORKNOEXEC)
	#define task_mce_process(task)			((task)->flags & PF_MCE_PROCESS)
	#define task_superpriv(task)			((task)->flags & PF_SUPERPRIV)
	#define task_dumpcore(task)			((task)->flags & PF_DUMPCORE)
	#define task_signaled(task)			((task)->flags & PF_SIGNALED)
	#define task_memalloc(task)			((task)->flags & PF_MEMALLOC)
	#define task_nproc_exceeded(task)		((task)->flags & PF_NPROC_EXCEEDED)
	#define task_used_math(task)			((task)->flags & PF_USED_MATH)
	#define task_user_worker(task)			((task)->flags & PF_USER_WORKER)
	#define task_nofreeze(task)			((task)->flags & PF_NOFREEZE)
	#define task_kcompactd(task)			((task)->flags & PF_KCOMPACTD)
	#define task_kswapd(task)			((task)->flags & PF_KSWAPD)
	#define task_memalloc_nofs(task)		((task)->flags & PF_MEMALLOC_NOFS)
	#define task_memalloc_noio(task)		((task)->flags & PF_MEMALLOC_NOIO)
	#define task_local_throttle(task)		((task)->flags & PF_LOCAL_THROTTLE)
	#define task_kthread(task)			((task)->flags & PF_KTHREAD)
	#define task_randomize(task)			((task)->flags & PF_RANDOMIZE)
	#define task_no_setaffinity(task)		((task)->flags & PF_NO_SETAFFINITY)
	#define task_mce_early(task)			((task)->flags & PF_MCE_EARLY)
	#define task_memalloc_pin(task)			((task)->flags & PF_MEMALLOC_PIN)
	#define task_block_ts(task)			((task)->flags & PF_BLOCK_TS)
	#define task_suspend_task(task)			((task)->flags & PF_SUSPEND_TASK)

These are easy names, precise lower-case variants of the PF_ flag 
names: if you know the PF flag's name, you know the helper's name as 
well.

And no, we don't need separate helpers for !task_kthread() et al: the C 
logical negation unary operator is perfectly readable when placed 
before a function call or a macro invocation, and a competent Linux 
kernel developer is expected to recognize it on sight:

	if (!task_kthread(task))
		...

Let's not infantilize the kernel source...

You can find this patch in my tree at:

	git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git WIP.sched/core

Note that I plan to add a few more patches as well, while we are 
touching this area:

 - tsk_used_math() is now overlapping and should be consolidated a bit. 
   And the used_math() indirection should go away as well.

 - I'll add conversion patches as well, at minimum for the top 10 flags 
   that cover 90%+ of the PF_ flag usage:

             nr of uses | flag
             -------------------------
		      7 | PF_USED_MATH
		      8 | PF_USER_WORKER
		     10   PF_NOFREEZE
		     15   PF_WQ_WORKER
		     18   PF_NO_SETAFFINITY
		     18   PF_VCPU
		     24   PF_RANDOMIZE
		     30   PF_MEMALLOC
		     73   PF_EXITING
		     92   PF_KTHREAD

   [ Or maybe for all of them - see below wrt. set_task_*(). ]

 - PF_ goes for 'per-process flag' and as such it is a total misnomer, 
   proudly misrepresented in <linux/sched.h>:

	/*
	 * Per process flags
	 */
	#define PF_VCPU                 0x00000001      /* I'm a virtual CPU */
	#define PF_IDLE                 0x00000002      /* I am an IDLE thread */

   Yeah, no: the PF_ flags haven't been "per process" ever since we 
   introduced threading 25 years ago...

   Renaming just for that causes churn, but it becomes easier once we 
   have the conversion patches for helpers for explicit uses of PF_ 
   flags.

 - We might want to add set_task_*() helpers as well, to totally 
   encapsulate PF_ uses. Maybe. I dislike how close it is to the 
   existing set_tsk*() methods that manipulate TIF_ flags. The 
   dichotomy between the TIF_ and PF_ space isn't really sensible these 
   days I think on a conceptual level - although merging them is 
   probably not practical due to possibly running out of easy 64-bit 
   word width.

I'll send out a full series if there's no better suggestions for the 
general approach.

Thanks,

	Ingo

============================>
From: Ingo Molnar <mingo@kernel.org>
Date: Sat, 26 Apr 2025 20:00:22 +0200
Subject: [PATCH] sched/core: Introduce task_*() helpers for PF_ flags

Add straightforward PF_ task flag helpers:

	if (!(task->flags & PF_KTHREAD))
		...

                |
               \|/
		V

	if (!task_kthread(task))
		...

( Fortunately there's no namespace collision for any of the new
  methods introduced. )

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac1982893..ef5a2e98dd9e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1747,6 +1747,38 @@ extern struct pid *cad_pid;
 #define PF__HOLE__40000000	0x40000000
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
+/*
+ * Helpers for PF_ flags:
+ */
+#define task_vcpu(task)				((task)->flags & PF_VCPU)
+#define task_idle(task)				((task)->flags & PF_IDLE)
+#define task_exiting(task)			((task)->flags & PF_EXITING)
+#define task_postcoredump(task)			((task)->flags & PF_POSTCOREDUMP)
+#define task_io_worker(task)			((task)->flags & PF_IO_WORKER)
+#define task_wq_worker(task)			((task)->flags & PF_WQ_WORKER)
+#define task_forknoexec(task)			((task)->flags & PF_FORKNOEXEC)
+#define task_mce_process(task)			((task)->flags & PF_MCE_PROCESS)
+#define task_superpriv(task)			((task)->flags & PF_SUPERPRIV)
+#define task_dumpcore(task)			((task)->flags & PF_DUMPCORE)
+#define task_signaled(task)			((task)->flags & PF_SIGNALED)
+#define task_memalloc(task)			((task)->flags & PF_MEMALLOC)
+#define task_nproc_exceeded(task)		((task)->flags & PF_NPROC_EXCEEDED)
+#define task_used_math(task)			((task)->flags & PF_USED_MATH)
+#define task_user_worker(task)			((task)->flags & PF_USER_WORKER)
+#define task_nofreeze(task)			((task)->flags & PF_NOFREEZE)
+#define task_kcompactd(task)			((task)->flags & PF_KCOMPACTD)
+#define task_kswapd(task)			((task)->flags & PF_KSWAPD)
+#define task_memalloc_nofs(task)		((task)->flags & PF_MEMALLOC_NOFS)
+#define task_memalloc_noio(task)		((task)->flags & PF_MEMALLOC_NOIO)
+#define task_local_throttle(task)		((task)->flags & PF_LOCAL_THROTTLE)
+#define task_kthread(task)			((task)->flags & PF_KTHREAD)
+#define task_randomize(task)			((task)->flags & PF_RANDOMIZE)
+#define task_no_setaffinity(task)		((task)->flags & PF_NO_SETAFFINITY)
+#define task_mce_early(task)			((task)->flags & PF_MCE_EARLY)
+#define task_memalloc_pin(task)			((task)->flags & PF_MEMALLOC_PIN)
+#define task_block_ts(task)			((task)->flags & PF_BLOCK_TS)
+#define task_suspend_task(task)			((task)->flags & PF_SUSPEND_TASK)
+
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
  * tasks can access tsk->flags in readonly mode for example

