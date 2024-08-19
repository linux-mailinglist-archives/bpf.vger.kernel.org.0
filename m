Return-Path: <bpf+bounces-37508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EF6956CA8
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388421C22AD8
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106E16CD11;
	Mon, 19 Aug 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltr8zDKM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3F16CD02;
	Mon, 19 Aug 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076351; cv=none; b=Yd/TILQdtpm5F39dduLWqCD4PHWOmw26/e0wlkyRByU+ayuqFPlEGTz6tTn4yZMdyzIthE6gXeg5wd3TedPI3gUMvl47fPBXX1t7p5TYA6+UjRDGGcdMpToIW87K+lIMUANGQM4kirujVkouHp+MEkCCfynsxZ3RmdDBSibUxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076351; c=relaxed/simple;
	bh=vFW3lWLK+CvvElgOM3sTvSE8FtIKksMkts8Mxt4Yvw4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVM3oCoh7GJB5XapdhzOmGPq8YkEPb1sPesIyCBzerS2IA4zVbcQtUw+rBX7QWr4sD8r9zBpRG7ELXhbOYPSDzzUfx9txvDNCzoHUBR1UOeG9eo0/SdtZZsQLBV3fr/j0H1YsRsPvVvbRZ6QsYtvv9BamwiEZJm5McXGG5mLr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltr8zDKM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso3350901a12.1;
        Mon, 19 Aug 2024 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724076348; x=1724681148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jNGKDDgZU4u27PGT6KbwFbYsh8pI0viRSO/0ZPMBUZ8=;
        b=Ltr8zDKMWqoSmG/Hj/l71m0jnTin8WgyUxQB4BqS2ZPdc3XiiuTrZF7mIfiRBfSbIF
         gWYqYLXDX48HWsAGdFTa98y0cZ6VGiJ/rW6R/purKh42JeghdE5qbgdgIiWktMO4dTK2
         hHIG/RsAN9eRBzaZrP8tof5ctJrEQrPC1qQkwtnjLYQUYp+goxLLkYyVfpaBc3vgvCGA
         QZwpu6tZgICd/cS27ZWBjKER48yqasEFugdlKbPvFUlsfdi8xRzsB1GCA5SYWQLqqwsL
         0WoQB5VyJ5SKJI4JJywW8ULEfpeFKjU+UzvCoHFe5dDe1/hkEj6eQDyxT5T+fX/5loKQ
         uknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724076348; x=1724681148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNGKDDgZU4u27PGT6KbwFbYsh8pI0viRSO/0ZPMBUZ8=;
        b=N8BiFuwpgYbC484YTRwjdIJ0TeWSYIxETnXDx4Eo1xCdM12nKZNed0bX2KVHpdZSSJ
         AzfGGV3mM1SEsLA7GdTDoZ48K7JFwQTVWgBb/fs8+UhyMWBjs3n3q4PhI5Mp+OaAcU8D
         epSIiLjYQOi4INAODq7KE7pjNiqQNGxW1DRZOpoHNFjaOA/MZsWohC43I1zSYqT/88rO
         sE7iDtaUHi6NZlyczsg4L0lA761lJieoYycEiRU8r9aWNClgg6/jVxjJ3NnIF7ujAFgR
         A2Ay39x/UyU7zxYzeeq48Bvhuc2SipubOeoAfB1t+c539BZ87X9KBIWx08gIghPLgAHK
         G/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkFXzOiZRZ5PwPAT/7rD7GsFN3w8SeYE7XpyFs53rDVevExPuyqfSM6PFSyQn3vx+g0xMCreq1VvKh0blHMRCe2m4iLSg4/18kFqOIud7AAAAVJQnwZD/htfRZcDhgb5FH
X-Gm-Message-State: AOJu0Yy7Jdk/jVYJsQhnUmBqGDrHglsgKNIbh6qMGH/pYuKW/LO4Zob+
	ON/kGrTxA2bNBt+m9Dw56soOnDB+O1rvvGGR68jOzieGCv2dKgGB
X-Google-Smtp-Source: AGHT+IGCFJGk47B48R2BTmbkw+TQtUFRRi3E261ELTldWPeoI/U6rRdwSzGrjNrtAXqqL7Iuc2qlvg==
X-Received: by 2002:a05:6402:3512:b0:5be:fa58:8080 with SMTP id 4fb4d7f45d1cf-5befa588190mr3061713a12.3.1724076347977;
        Mon, 19 Aug 2024 07:05:47 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5becf1f3442sm4185535a12.31.2024.08.19.07.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:05:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 19 Aug 2024 16:05:46 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZsNROjJFEKKY3WSB@krava>
References: <ZrIj9jkXqpKXRuS7@krava>
 <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
 <ZrSh8AuV21AKHfNg@krava>
 <CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
 <Zr3q8ihbe8cUdpfp@krava>
 <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
 <20240816101031.6dd1361b@rorschach.local.home>
 <Zr-ho0ncAk__sZiX@krava>
 <20240816153040.14d36c77@rorschach.local.home>
 <ZsMwyO1Tv6BsOyc-@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsMwyO1Tv6BsOyc-@krava>

On Mon, Aug 19, 2024 at 01:47:20PM +0200, Jiri Olsa wrote:
> On Fri, Aug 16, 2024 at 03:30:40PM -0400, Steven Rostedt wrote:
> > On Fri, 16 Aug 2024 20:59:47 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> > > so far the only working solution I have is adding '__nullable' suffix
> > > to argument name:
> > > 
> > > 	diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > > 	index 9ea4c404bd4e..fc46f0b42741 100644
> > > 	--- a/include/trace/events/sched.h
> > > 	+++ b/include/trace/events/sched.h
> > > 	@@ -559,9 +559,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
> > > 	  */
> > > 	 TRACE_EVENT(sched_pi_setprio,
> > > 	 
> > > 	-	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
> > > 	+	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task__nullable),
> > > 	 
> > > 	-	TP_ARGS(tsk, pi_task),
> > > 	+	TP_ARGS(tsk, pi_task__nullable),
> > > 	 
> > > 		TP_STRUCT__entry(
> > > 			__array( char,	comm,	TASK_COMM_LEN	)
> > > 	@@ -574,8 +574,8 @@ TRACE_EVENT(sched_pi_setprio,
> > > 			memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> > > 			__entry->pid		= tsk->pid;
> > > 			__entry->oldprio	= tsk->prio;
> > > 	-		__entry->newprio	= pi_task ?
> > > 	-				min(tsk->normal_prio, pi_task->prio) :
> > > 	+		__entry->newprio	= pi_task__nullable ?
> > > 	+				min(tsk->normal_prio, pi_task__nullable->prio) :
> > > 					tsk->normal_prio;
> > > 			/* XXX SCHED_DEADLINE bits missing */
> > > 		),
> > > 
> > > 
> > > now I'm trying to make work something like:
> > > 
> > > 	diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > > 	index 9ea4c404bd4e..4e4aae2d5700 100644
> > > 	--- a/include/trace/events/sched.h
> > > 	+++ b/include/trace/events/sched.h
> > > 	@@ -559,9 +559,9 @@ DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
> > > 	  */
> > > 	 TRACE_EVENT(sched_pi_setprio,
> > > 	 
> > > 	-	TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
> > > 	+	TP_PROTO(struct task_struct *tsk, struct task_struct *__nullable(pi_task)),
> > > 	 
> > > 	-	TP_ARGS(tsk, pi_task),
> > > 	+	TP_ARGS(tsk, __nullable(pi_task)),
> > > 	 
> > > 		TP_STRUCT__entry(
> > > 			__array( char,	comm,	TASK_COMM_LEN	)
> > 
> > Hmm, that's really ugly though. Both versions.
> > 
> > Now when Alexei said:
> > 
> > > > > > > We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NULL
> > > > > > > by default, since it will break a bunch of progs.
> > > > > > > Instead we can annotate this tracepoint arg as __nullable and
> > > > > > > teach the verifier to recognize such special arguments of tracepoints. 
> > 
> > I'm not familiar with the verifier, so I don't know how the above is
> > implemented, and why it would break a bunch of progs.
> 
> verifier assumes that programs attached to the tracepoint can access
> pointer arguments without checking them for null and some of those
> programs most likely access such arguments directly
> 
> changing that globally and require bpf program to do null check for all
> pointer arguments will make verifier fail to load existing programs
> 
> > 
> > If you had a macro around the parameter:
> > 
> > 		TP_PROTO(struct task_struct *tsk, struct task_struct *__nullable(pi_task)),
> > 
> > Could having that go through another macro pass in trace_events.h work?
> > That is, could we associate the trace event with "nullable" parameters
> > that could be stored someplace else for you?
> 
> IIUC you mean to store extra data for each tracepoint that would
> annotate the argument? as Alexei pointed out earlier it might be
> too much, because we'd be fine with just adding suffix to annotated
> arguments in __bpf_trace_##call:
> 
> 	__bpf_trace_##call(void *__data, proto)                                 \

nah.. it's defined for class template, so tracepoints like cgroup_mkdir
won't have its own __bpf_trace_cgroup_mkdir function that we could use

we need to do something else

jirka


> 	{                                                                       \
> 		CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));        \
> 	}
> 
> with that verifier could easily get suffix information from BTF and
> once gcc implements btf_type_tag we can easily switch to that
> 
> jirka

