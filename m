Return-Path: <bpf+bounces-37522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8D2956EE8
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 17:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5009D1F2216E
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D990673501;
	Mon, 19 Aug 2024 15:37:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F460335BA;
	Mon, 19 Aug 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081844; cv=none; b=NgV0zv8BwmJJn4jgMYfa3HFBVONrWwMS7aJCGGFonw3iryacMEUqCk/LoPgq0E7kOj2J6j322n5RphOC8CfPYvHi75u3cpgPEYHsFmgcUEOJcAp1oItO800tFPcH+oo+/sVounSe7nPTYBM8Ra7nz6lHTxkHxxLJzcU9yqaZWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081844; c=relaxed/simple;
	bh=vYk1twbbXqvX1AtN4/MqafyNtDHmCb0Y1jS6HN6zQEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5vdSqgYydrolABNsLvvKA03bEVFNzhVYeTVvBtFHt/jGKfBRv4C/Orhbm28MrUV0mzBU5b4d1eo6wnaojV5mU9hualFQ+2C2PLOI+BI+msHPKND+W1sHf/FYrIbs5eBMg10OT/GIb1nkaYjipJ11MAwaDFmDPAUTtJ9xUIN+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A5AC32782;
	Mon, 19 Aug 2024 15:37:23 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:37:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Juri Lelli
 <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Artem Savkov <asavkov@redhat.com>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program
 (6.11.0-rc1)
Message-ID: <20240819113747.31d1ae79@gandalf.local.home>
In-Reply-To: <ZsMwyO1Tv6BsOyc-@krava>
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
	<ZsMwyO1Tv6BsOyc-@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 13:47:20 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> verifier assumes that programs attached to the tracepoint can access
> pointer arguments without checking them for null and some of those
> programs most likely access such arguments directly

Hmm, so the verifier made a wrong assumption :-/  That's because that was
never a requirement for tracepoint arguments and several can easily be
NULL. That's why the macros have NULL checks for all arguments. For
example, see include/trace/stages/stage5_get_offsets.h:

  static inline const char *__string_src(const char *str)
  {
       if (!str)
               return EVENT_NULL_STR;
       return str;
  }


How does the verifier handle accessing function arguments? Because a
tracepoint call is no different.

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
> 	{                                                                       \
> 		CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));        \
> 	}
> 
> with that verifier could easily get suffix information from BTF and
> once gcc implements btf_type_tag we can easily switch to that

Could it be possible that the verifier could add to the exception table for
all accesses to tracepoint arguments? Then if there's a NULL pointer
dereference, the kernel will not crash but the exception can be sent to the
user space process instead? That is, it sends SIGSEV to the task accessing
NULL when it shouldn't.

-- Steve

