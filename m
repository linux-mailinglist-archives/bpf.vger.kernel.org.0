Return-Path: <bpf+bounces-37397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1195517D
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A3E1C2359E
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE691C37A8;
	Fri, 16 Aug 2024 19:30:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B410E4;
	Fri, 16 Aug 2024 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836643; cv=none; b=qIcDjkblPDA1MtI3rx3t+nH1T2UdeWus7jjv3J46QPLOzvf6GO+SdQcajk3r9CsPwMPZXl5Vjc2pEAbs2vELe4muobNziDhKR9HxQjFXKC7ze7QHy8JMxoYvZCPWGsHE/Pz+FSc3XCHaCLFW6QevGh0Ee2getCSb8HwaTe6P7NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836643; c=relaxed/simple;
	bh=iN7A7inr48pTV1DSy1aigzEmKF2n/mAt4X+XCaxE0Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evgxLnan5CNqEOlEYFCMft0Po8l+ZQ0J50oFt55L1perXEyKJmzTFPO5GO0O72YrhyTTvtR+hRwHFweg3rX0VYTzY8MItvjD+Y4nT9/PfzAlsKbiypUB2hhMhKdKNe6h7I8EOdV8Ga+W/hZ+AJwpkbxrYG1Q0zjH5f1MXLwblo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1DCC32782;
	Fri, 16 Aug 2024 19:30:41 +0000 (UTC)
Date: Fri, 16 Aug 2024 15:30:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Juri Lelli
 <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Artem Savkov <asavkov@redhat.com>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program
 (6.11.0-rc1)
Message-ID: <20240816153040.14d36c77@rorschach.local.home>
In-Reply-To: <Zr-ho0ncAk__sZiX@krava>
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
	<ZrECsnSJWDS7jFUu@krava>
	<CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
	<ZrIj9jkXqpKXRuS7@krava>
	<CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
	<ZrSh8AuV21AKHfNg@krava>
	<CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
	<Zr3q8ihbe8cUdpfp@krava>
	<CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
	<20240816101031.6dd1361b@rorschach.local.home>
	<Zr-ho0ncAk__sZiX@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 20:59:47 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> so far the only working solution I have is adding '__nullable' suffix
> to argument name:
> 
> 	diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> 	index 9ea4c404bd4e..fc46f0b42741 100644
> 	--- a/include/trace/events/sched.h
> 	+++ b/include/trace/events/sched.h
> 	@@ -559,9 +559,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
> 	  */
> 	 TRACE_EVENT(sched_pi_setprio,
> 	 
> 	-	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
> 	+	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task__nullable),
> 	 
> 	-	TP_ARGS(tsk, pi_task),
> 	+	TP_ARGS(tsk, pi_task__nullable),
> 	 
> 		TP_STRUCT__entry(
> 			__array( char,	comm,	TASK_COMM_LEN	)
> 	@@ -574,8 +574,8 @@ TRACE_EVENT(sched_pi_setprio,
> 			memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> 			__entry->pid		= tsk->pid;
> 			__entry->oldprio	= tsk->prio;
> 	-		__entry->newprio	= pi_task ?
> 	-				min(tsk->normal_prio, pi_task->prio) :
> 	+		__entry->newprio	= pi_task__nullable ?
> 	+				min(tsk->normal_prio, pi_task__nullable->prio) :
> 					tsk->normal_prio;
> 			/* XXX SCHED_DEADLINE bits missing */
> 		),
> 
> 
> now I'm trying to make work something like:
> 
> 	diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> 	index 9ea4c404bd4e..4e4aae2d5700 100644
> 	--- a/include/trace/events/sched.h
> 	+++ b/include/trace/events/sched.h
> 	@@ -559,9 +559,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
> 	  */
> 	 TRACE_EVENT(sched_pi_setprio,
> 	 
> 	-	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
> 	+	TP_PROTO(struct task_struct *tsk, struct task_struct *__nullable(pi_task)),
> 	 
> 	-	TP_ARGS(tsk, pi_task),
> 	+	TP_ARGS(tsk, __nullable(pi_task)),
> 	 
> 		TP_STRUCT__entry(
> 			__array( char,	comm,	TASK_COMM_LEN	)

Hmm, that's really ugly though. Both versions.

Now when Alexei said:

> > > > > We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NULL
> > > > > by default, since it will break a bunch of progs.
> > > > > Instead we can annotate this tracepoint arg as __nullable and
> > > > > teach the verifier to recognize such special arguments of tracepoints. 

I'm not familiar with the verifier, so I don't know how the above is
implemented, and why it would break a bunch of progs.

If you had a macro around the parameter:

		TP_PROTO(struct task_struct *tsk, struct task_struct *__nullable(pi_task)),

Could having that go through another macro pass in trace_events.h work?
That is, could we associate the trace event with "nullable" parameters
that could be stored someplace else for you?

-- Steve

