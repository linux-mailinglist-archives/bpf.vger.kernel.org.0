Return-Path: <bpf+bounces-45516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 208119D6BE6
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 23:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998DBB217D3
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 22:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DDB1AAE2E;
	Sat, 23 Nov 2024 22:59:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987217BA6;
	Sat, 23 Nov 2024 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732402761; cv=none; b=iyq0rVJgEYCQs+8x0oj35Fe3ZOBweuczt1N3qtD0YpebJmg9ViTvtbEhzukJH3jxOcd6hS9WUoF42OnoL/QFxXo62DBIPkR2+dWAQVQondmV0CbLuPL22Wyap+qEvP3H2XFFUpXNdl7V6UUkyU389YjHDyKRV8ahawsaVWhfUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732402761; c=relaxed/simple;
	bh=O+BJBB8iRKrtZAFcE3KcXpmfjPRb97tBGjFFNPW4Pwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upBpkhMqdC+t36R4teqV5q1b91Och3/axUZ81v9X/HVxGnFvE3bFU+VXZdsq1+DcaESiZRel1qWgX3emdM+OPpwsEE3SkFjKI/FBlUUOxs5aV5rGS+hKqG77sg6/OjdDzaScCrVf/kfev2wJbIEsmOxoEAhwS42RdNmMeK8WGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED28C4CECD;
	Sat, 23 Nov 2024 22:59:17 +0000 (UTC)
Date: Sat, 23 Nov 2024 18:00:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ruan Bonan <bonan.ruan@u.nus.edu>, "mingo@redhat.com"
 <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "longman@redhat.com" <longman@redhat.com>, "boqun.feng@gmail.com"
 <boqun.feng@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>, "ast@kernel.org"
 <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
 <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
 <yonghong.song@linux.dev>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
 <jolsa@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Fu Yeqi
 <e1374359@u.nus.edu>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer
 available)
Message-ID: <20241123180000.5e219f2e@gandalf.local.home>
In-Reply-To: <20241123202744.GB20633@noisy.programming.kicks-ass.net>
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
	<20241123202744.GB20633@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Nov 2024 21:27:44 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Nov 23, 2024 at 03:39:45AM +0000, Ruan Bonan wrote:
> 
> >  </TASK>
> > FAULT_INJECTION: forcing a failure.
> > name fail_usercopy, interval 1, probability 0, space 0, times 0
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.12.0-rc7-00144-g66418447d27b #8 Not tainted
> > ------------------------------------------------------
> > syz-executor144/330 is trying to acquire lock:
> > ffffffffbcd2da38 ((console_sem).lock){....}-{2:2}, at: down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
> > 
> > but task is already holding lock:
> > ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:598 [inline]
> > ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1506 [inline]
> > ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1805 [inline]
> > ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x140/0x1e70 kernel/sched/core.c:6592
> > 
> > which lock already depends on the new lock.
> > 
> >        _printk+0x7a/0xa0 kernel/printk/printk.c:2432
> >        fail_dump lib/fault-inject.c:46 [inline]
> >        should_fail_ex+0x3be/0x570 lib/fault-inject.c:154
> >        strncpy_from_user+0x36/0x230 lib/strncpy_from_user.c:118
> >        strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
> >        bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
> >        ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:224 [inline]
> >        bpf_probe_read_user_str+0x2a/0x70 kernel/trace/bpf_trace.c:221
> >        bpf_prog_bc7c5c6b9645592f+0x3e/0x40
> >        bpf_dispatcher_nop_func include/linux/bpf.h:1265 [inline]
> >        __bpf_prog_run include/linux/filter.h:701 [inline]
> >        bpf_prog_run include/linux/filter.h:708 [inline]
> >        __bpf_trace_run kernel/trace/bpf_trace.c:2316 [inline]
> >        bpf_trace_run4+0x30b/0x4d0 kernel/trace/bpf_trace.c:2359
> >        __bpf_trace_sched_switch+0x1c6/0x2c0 include/trace/events/sched.h:222
> >        trace_sched_switch+0x12a/0x190 include/trace/events/sched.h:222  
> 
> -EWONTFIX. Don't do stupid.

Ack. BPF should not be causing deadlocks by doing code called from
tracepoints. Tracepoints have a special context similar to NMIs. If you add
a hook into an NMI handler that causes a deadlock, it's a bug in the hook,
not the NMI code. If you add code that causes a deadlock when attaching to a
tracepoint, it's a bug in the hook, not the tracepoint.

-- Steve

