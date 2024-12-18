Return-Path: <bpf+bounces-47270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823559F6D55
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 19:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E76C169D4C
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B671F75B2;
	Wed, 18 Dec 2024 18:30:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6146155359;
	Wed, 18 Dec 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546649; cv=none; b=exAIntJ79ZVTxsDQ8z3I8AH/mLh2wNt4v4CfwFxME8hXFcIRTbplCFGnisb75XoL8lbjbL2m0eFBafSa9qDkr8ic6g4aB4oEr/IbbvHm/lp6EsUk3rQrTsTMwTG9DW6zMqz+Q5hKA+o9JXNs/a2ya+P8Z3hok8KpwsMvbK973q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546649; c=relaxed/simple;
	bh=+bU+8bjbtEvGdEYSMASO2Du+LwOyygovnO7zicYFQ64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CL18qcp3c6hKTy1UgQkSt8GBy2TpCE90/567E75ilb2eRwnvyZCsibn7MwA6huwxVRpgRsbj1CvjxtAFS5x6oTQ9Eogjn6o9jAy77P/S8UrlEcie1mgzt9/pwniI9qStAQhmvZrxWWsl73SZBQYEuyVqeTmGSIzVOtTwHlHHEaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E114C4CECD;
	Wed, 18 Dec 2024 18:30:48 +0000 (UTC)
Date: Wed, 18 Dec 2024 13:31:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Florent Revest <revest@google.com>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: simplify number handling
Message-ID: <20241218133126.3667d7b1@gandalf.local.home>
In-Reply-To: <20241218130427.16c062e3@gandalf.local.home>
References: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
	<20241218013620.1679088-1-torvalds@linux-foundation.org>
	<20241218103218.7dc82306@gandalf.local.home>
	<CAHk-=whbzEO5sHk777FGWcCjDnX2QLBLX9XszEVh5GnSp+8RWw@mail.gmail.com>
	<20241218130427.16c062e3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 13:04:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > It's very much a part of the standard printf format, and is very much
> > inherent to the whole varargs and C integer promotion rules (ie you
> > literally *cannot* pass an actual 'char' value to a varargs function -
> > the normal C integer type extension rules apply).
> > 
> > So this is not really some odd kernel extension, and while there are
> > only a handful of users in tracing (that apparently trace-cmd cannot
> > deal with), it's not even _that_ uncommon in general:  
> 
> trace-cmd (and libtraceevent for that matter) does handle "%h" and "%hh"
> as well.
> 
> But the vbin_printf() which trace_printk() uses is a different beast, and
> requires rebuilding the arguments so that it can be parsed, and there "%h"
> isn't supported.

Just to state the difference between TP_printk() and trace_printk() is that
with trace events only the data is saved to the ring buffer. For example,
for the sched_waking trace event:

TRACE_EVENT(sched_waking,

	TP_PROTO(struct task_struct *p),

	TP_ARGS(__perf_task(p)),

	TP_STRUCT__entry(
		__array(	char,	comm,	TASK_COMM_LEN	)
		__field(	pid_t,	pid			)
		__field(	int,	prio			)
		__field(	int,	target_cpu		)
	),

	TP_fast_assign(
		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
		__entry->pid		= p->pid;
		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
		__entry->target_cpu	= task_cpu(p);
	),

	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d",
		  __entry->comm, __entry->pid, __entry->prio,
		  __entry->target_cpu)
);

[ Note, I made this into a TRACE_EVENT() but in reality it's multiple
  events that uses DECLARE_EVENT_CLASS() and DEFINE_EVENT(), but the idea is
  still the same. ]

	TP_STRUCT__entry(
		__array(	char,	comm,	TASK_COMM_LEN	)
		__field(	pid_t,	pid			)
		__field(	int,	prio			)
		__field(	int,	target_cpu		)
	),

That turns into:

	struct trace_event_raw_sched_waking {
		struct trace_entry		ent;
		char				comm[TASK_COMM_LEN];
		pid_t				pid;
		int				prio;
		int				target_cpu;
		char				__data[];
	}

Then we have how to load that structure:

	TP_fast_assign(
		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
		__entry->pid		= p->pid;
		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
		__entry->target_cpu	= task_cpu(p);
	),
 
Where the "__entry" is of type struct trace_event_raw_sched_waking and
points into the reserved location in the ring buffer. This has the above
assignments write directly into the ring buffer and avoids any copying.

Now the "trace" file needs to know how to print it, that's where the
TP_printk() is. It is basically a vsprintf(TP_printk()) with the __entry
again pointing to the content of the ring buffer.

But trace_printk() is not a trace event and requires writing the format as
well as the data into the ring buffer when it is called. It use to simply
just use vsnprintf() but it was considered much faster to not do the
formatting during the record and to push it back to when it is read. As
trace_printk() is used specifically to find hard to hit bugs, to keep it
from causing "heisenbugs", using vbin_printf() proved to be much faster and
made trace_printk() less intrusive to debugging.

For historical analysis, here's where it was first introduced:

  https://lore.kernel.org/lkml/49aa0c73.1c07d00a.4fc6.ffffb4d7@mx.google.com/

-- Steve

