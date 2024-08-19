Return-Path: <bpf+bounces-37500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C7C9569D0
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 13:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA61C224BB
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921216D4C7;
	Mon, 19 Aug 2024 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx+KIxy8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B3169AE6;
	Mon, 19 Aug 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068046; cv=none; b=XQ3n2cqOVRWKsNCElv1x+y+E9+Eopyc1XFtBehog//6UF51kkTdelv9KRAXcQICkMX7SBv9Y4hQSYsj1wP6ABz68TMEDC/ZGpwx/zGvFVJjtOv/Gr8UbXyqlD0O+jWe5jeFHmAcCnCm+aJnFzkAGkY2Q7Q9X20wuns5yUWhZsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068046; c=relaxed/simple;
	bh=HEuqXXg8KOM1BSeu3oajipebGyT8C3Sey0AM2P+i730=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq1OqRl6lzdQ+4KOCdT8K+xiX3jSf2ZAUD0I0/cRXdLdn6FPorwKkqF8/s7V3Bz7pMev7lJoV/jMmPrBWfQIGtFZIGw2Rqe36+wLffGU2faZXn7YEtYW/DoI79Nh47k1vqJNinSEFkiiNLK2hY+dMUUu6/XM3rh4y/sbeKDACXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx+KIxy8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so539166a12.3;
        Mon, 19 Aug 2024 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724068043; x=1724672843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+7EmK/x9yGMggIGd6nPIlocVDx2WyNh0YQGki2bgCU=;
        b=Dx+KIxy85H3kHi+0uovl6YHDaH1yhB73NRGOiB0EbbT811bW/m2LomWEqUKlxp1w66
         /mikMWscoP7NSEw7AABRyJipDP3c95/3FX8Grbj5I928LW6V6kxy2vJcl1JTqnSa3VGI
         JiY96lfsPvx7R1peobJO1Uu/awkuICJYGgQ5JdZtDSqzznSAgnqgiOomDlXR7xBBlwBI
         ffqNCi0KkplpkAKIOix2ZCRl98uN2V/Vd5ThCztvOApZ/Q7lS4FKd4nYq2iQbWOFc9z1
         CeH7XvbCpIUbXr0IXNdSRRq7f1l//r+OYpKAzbTzHNrkabO3/S0c+P3m+IPr20Ez2ojU
         2NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068043; x=1724672843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+7EmK/x9yGMggIGd6nPIlocVDx2WyNh0YQGki2bgCU=;
        b=lDCm5ImoyxN3DhAH3Tk79LzWlXtswrm4jR9rz6xa7wnj0uXTCQ3qiKWr+UpaO7Hh2C
         D5o8Nfh/N7p2XBd2ghMmqhaLOlwfaNvLSkd0kCLXX2B7kM0U8sgF5ujm2m1zKWZgwK5i
         jOG9VFPhBgU67hfXhwXbWa1fiE92cMb2PXS3EW9nxqwJ6cv8AR9z3qGQoAZsdUNg1s1m
         QbNxzfhQYB57UC14TPZO7JQnoVa7MBWj7DxKn2UOaiSWcv8I3PArmH3oFkYDym210eEQ
         eDndKx2rWZ3ypSgyPjFnkua7SSHitxCE8uHEHu9BZ42aEk0SWUaeyFkgyHoxXzJTih93
         DuDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsdrRsO/pD8gkKz0mtm9TZFwjr3+Um1hthRz9tAubVJNxVgyVJ60kQb67styROAR68FuAC0biwVnU8oT1fMpgd8ELdpkbY1ydVgU7xxlJUIwCZP1zIF255L8JArRqRH2H7
X-Gm-Message-State: AOJu0YyMODh0CSsdHZwB/kp8GfmoIZib8bv6t0hga2m9tyUlAo6/qMZi
	LAcXe/KunnIOF+jFA+GBrR6+5LahHbzF3e0ZZjzoMWnlz5P0hDDhiHuyhw==
X-Google-Smtp-Source: AGHT+IH45mqlxcKm5QQEQ28ZPtqnfTtU8a5TtZIVrd9A3wueqbUcunKHj3cDhW3wunRXDzy6dZLVQQ==
X-Received: by 2002:a17:907:e291:b0:a75:1069:5b94 with SMTP id a640c23a62f3a-a83928d7cadmr726072366b.21.1724068042810;
        Mon, 19 Aug 2024 04:47:22 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839344fdsm624106966b.100.2024.08.19.04.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:47:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 19 Aug 2024 13:47:20 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZsMwyO1Tv6BsOyc-@krava>
References: <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
 <ZrIj9jkXqpKXRuS7@krava>
 <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
 <ZrSh8AuV21AKHfNg@krava>
 <CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
 <Zr3q8ihbe8cUdpfp@krava>
 <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
 <20240816101031.6dd1361b@rorschach.local.home>
 <Zr-ho0ncAk__sZiX@krava>
 <20240816153040.14d36c77@rorschach.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816153040.14d36c77@rorschach.local.home>

On Fri, Aug 16, 2024 at 03:30:40PM -0400, Steven Rostedt wrote:
> On Fri, 16 Aug 2024 20:59:47 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > so far the only working solution I have is adding '__nullable' suffix
> > to argument name:
> > 
> > 	diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > 	index 9ea4c404bd4e..fc46f0b42741 100644
> > 	--- a/include/trace/events/sched.h
> > 	+++ b/include/trace/events/sched.h
> > 	@@ -559,9 +559,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
> > 	  */
> > 	 TRACE_EVENT(sched_pi_setprio,
> > 	 
> > 	-	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
> > 	+	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task__nullable),
> > 	 
> > 	-	TP_ARGS(tsk, pi_task),
> > 	+	TP_ARGS(tsk, pi_task__nullable),
> > 	 
> > 		TP_STRUCT__entry(
> > 			__array( char,	comm,	TASK_COMM_LEN	)
> > 	@@ -574,8 +574,8 @@ TRACE_EVENT(sched_pi_setprio,
> > 			memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> > 			__entry->pid		= tsk->pid;
> > 			__entry->oldprio	= tsk->prio;
> > 	-		__entry->newprio	= pi_task ?
> > 	-				min(tsk->normal_prio, pi_task->prio) :
> > 	+		__entry->newprio	= pi_task__nullable ?
> > 	+				min(tsk->normal_prio, pi_task__nullable->prio) :
> > 					tsk->normal_prio;
> > 			/* XXX SCHED_DEADLINE bits missing */
> > 		),
> > 
> > 
> > now I'm trying to make work something like:
> > 
> > 	diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > 	index 9ea4c404bd4e..4e4aae2d5700 100644
> > 	--- a/include/trace/events/sched.h
> > 	+++ b/include/trace/events/sched.h
> > 	@@ -559,9 +559,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
> > 	  */
> > 	 TRACE_EVENT(sched_pi_setprio,
> > 	 
> > 	-	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
> > 	+	TP_PROTO(struct task_struct *tsk, struct task_struct *__nullable(pi_task)),
> > 	 
> > 	-	TP_ARGS(tsk, pi_task),
> > 	+	TP_ARGS(tsk, __nullable(pi_task)),
> > 	 
> > 		TP_STRUCT__entry(
> > 			__array( char,	comm,	TASK_COMM_LEN	)
> 
> Hmm, that's really ugly though. Both versions.
> 
> Now when Alexei said:
> 
> > > > > > We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NULL
> > > > > > by default, since it will break a bunch of progs.
> > > > > > Instead we can annotate this tracepoint arg as __nullable and
> > > > > > teach the verifier to recognize such special arguments of tracepoints. 
> 
> I'm not familiar with the verifier, so I don't know how the above is
> implemented, and why it would break a bunch of progs.

verifier assumes that programs attached to the tracepoint can access
pointer arguments without checking them for null and some of those
programs most likely access such arguments directly

changing that globally and require bpf program to do null check for all
pointer arguments will make verifier fail to load existing programs

> 
> If you had a macro around the parameter:
> 
> 		TP_PROTO(struct task_struct *tsk, struct task_struct *__nullable(pi_task)),
> 
> Could having that go through another macro pass in trace_events.h work?
> That is, could we associate the trace event with "nullable" parameters
> that could be stored someplace else for you?

IIUC you mean to store extra data for each tracepoint that would
annotate the argument? as Alexei pointed out earlier it might be
too much, because we'd be fine with just adding suffix to annotated
arguments in __bpf_trace_##call:

	__bpf_trace_##call(void *__data, proto)                                 \
	{                                                                       \
		CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));        \
	}

with that verifier could easily get suffix information from BTF and
once gcc implements btf_type_tag we can easily switch to that

jirka

