Return-Path: <bpf+bounces-37613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0D9583F5
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2598D1F25AC1
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EF0188CC5;
	Tue, 20 Aug 2024 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKYqJLmk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E715C12F;
	Tue, 20 Aug 2024 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149057; cv=none; b=ZAGhJqDLahtpFzZ1K55VHGP02vdcFUq69ePerIdW4Y+Y1MxaALXfuclBemswq+G/cpK+3qy9oQpZN0ijpYWCFHUJwNtqP8zfX0r+YxXiuzywhlqHqrKTgFAnDNOfXA9dOqzEt2N+Loi5FGoQM2tj2wffyA8mIbR0RCJXmPSJZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149057; c=relaxed/simple;
	bh=JCKBojmsz/I8qlIZvcARXRDjSJkR3uBjOL+6+Vl/lTs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6pzat+knTykw9ntyxNbn2g4yuedO17IRdBUbiIJCHHrZEoypsoIuK0tkz/4VYmucpJDT3t2XBgtaxVltF3e5IcfXyB19rv4Ns3E46Uq/qLWiwe9IERQT0c8pwLMruawKQxP0hIvqs9hCRTZSBIosS724W4PuowDkMzCvh9kZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKYqJLmk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a94478a4eso1094468066b.1;
        Tue, 20 Aug 2024 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149054; x=1724753854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDCCCZfEDklTEDmwUp0EEGgF+x5DgllGqM8ppmfdIMs=;
        b=nKYqJLmkIft/NJ+jfwlhoQSk6nX73kakmmV0Q3Hmp6X+6aIUEW+3rSYDnUwgtQHpS4
         nS0RtCrC+wKiwGkrUCyhFWO9hyeq5xNZG3lbz4ex/tsYQxAAfi5SpQpaHA8wvA9p0hJL
         FpsjLiZEK/LUrgMkhnyWDsHc9XJeT7deP8li4xvtb8BAS9TTTFv/o5NspUyMg9RLfZYN
         PDBb4bMc1Q02Nj8s/k+gZwPQKJ7gLrDc9KyUF0eyQ0jlGz2InSPyxtbRBwlSMIMa13ju
         nPI2WJWrveLaOCri72P0p67CXAvounppoR6VZHxRIkqDYvwT8Qfccptxkkj6EjCGBtNg
         hfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149054; x=1724753854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDCCCZfEDklTEDmwUp0EEGgF+x5DgllGqM8ppmfdIMs=;
        b=oibiyzQYem6oQYIo1hXipLX8flSz1YR/mh3o7wOAj3YnpraTez0FwrkHhGZHyXufE1
         oxKeqmh7oFCaKeuDnlajiYvauGePNelVx/UJj2Ef40svUt+b7MICLV100CTCEkHZZWYG
         OCiFV5QHPn2Li0qRxPJimTBsuj4z5rfXEM3gxXpdWteXF0iIuq/Ah6GkZYUzY2dqWqLg
         MKNnVc2IptM8oghXQj/raem8gvP1Ira6OzwTQstCUapZgc0ivVEYSg19R6EpIOzJbG/0
         97ZWr9lD+oOil4TGsuCnXiC+p1PckDQ/4SFQYxzUUc73KGuXEIZSRtegMzW8an9X7czg
         isiw==
X-Forwarded-Encrypted: i=1; AJvYcCXEdG5oNnpTZZbLE+1XUgWrEaohbZkLU9bqCCaSoD9UJ9sOvxzy6vOoZxCF0rbs6+eGVZCm0IiGf3ylPEiu3sV/Sj1V7LwS0YdVQRWJq3okfL119iQG1r3b3JvicMjnV6jI
X-Gm-Message-State: AOJu0YyQKJIVDYefvCa6vLV7/S5G0V5WDTZNhjBdyDnqwGa+X7cZO9be
	EbRCev9qfRlXHHXdykAApasIBGwTSMzCO3xrFpQNvvBptfUOjTMh7jjMbQ==
X-Google-Smtp-Source: AGHT+IEGej1nTsHT7LkLDAhVUwrtGbfv7KKa4ADTQE0bCOZPBkQhk5r0OjOkQcdlaDDKuxGCTxRTtA==
X-Received: by 2002:a17:907:9811:b0:a7a:a4cf:4f93 with SMTP id a640c23a62f3a-a8643fee514mr226176466b.32.1724149053358;
        Tue, 20 Aug 2024 03:17:33 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb3bsm738173166b.65.2024.08.20.03.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:17:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 20 Aug 2024 12:17:31 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZsRtOzhicxAhkmoN@krava>
References: <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
 <ZrSh8AuV21AKHfNg@krava>
 <CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
 <Zr3q8ihbe8cUdpfp@krava>
 <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
 <20240816101031.6dd1361b@rorschach.local.home>
 <Zr-ho0ncAk__sZiX@krava>
 <20240816153040.14d36c77@rorschach.local.home>
 <ZsMwyO1Tv6BsOyc-@krava>
 <20240819113747.31d1ae79@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819113747.31d1ae79@gandalf.local.home>

On Mon, Aug 19, 2024 at 11:37:47AM -0400, Steven Rostedt wrote:
> On Mon, 19 Aug 2024 13:47:20 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > verifier assumes that programs attached to the tracepoint can access
> > pointer arguments without checking them for null and some of those
> > programs most likely access such arguments directly
> 
> Hmm, so the verifier made a wrong assumption :-/  That's because that was
> never a requirement for tracepoint arguments and several can easily be
> NULL. That's why the macros have NULL checks for all arguments. For
> example, see include/trace/stages/stage5_get_offsets.h:
> 
>   static inline const char *__string_src(const char *str)
>   {
>        if (!str)
>                return EVENT_NULL_STR;
>        return str;
>   }
> 
> 
> How does the verifier handle accessing function arguments? Because a
> tracepoint call is no different.

verifier is checking program's access to function arguments which in
case of tracepoint is access to context (btf_ctx_access function)

> 
> > 
> > changing that globally and require bpf program to do null check for all
> > pointer arguments will make verifier fail to load existing programs
> > 
> > > 
> > > If you had a macro around the parameter:
> > > 
> > > 		TP_PROTO(struct task_struct *tsk, struct task_struct *__nullable(pi_task)),
> > > 
> > > Could having that go through another macro pass in trace_events.h work?
> > > That is, could we associate the trace event with "nullable" parameters
> > > that could be stored someplace else for you?  
> > 
> > IIUC you mean to store extra data for each tracepoint that would
> > annotate the argument? as Alexei pointed out earlier it might be
> > too much, because we'd be fine with just adding suffix to annotated
> > arguments in __bpf_trace_##call:
> > 
> > 	__bpf_trace_##call(void *__data, proto)                                 \
> > 	{                                                                       \
> > 		CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));        \
> > 	}
> > 
> > with that verifier could easily get suffix information from BTF and
> > once gcc implements btf_type_tag we can easily switch to that
> 
> Could it be possible that the verifier could add to the exception table for
> all accesses to tracepoint arguments? Then if there's a NULL pointer
> dereference, the kernel will not crash but the exception can be sent to the
> user space process instead? That is, it sends SIGSEV to the task accessing
> NULL when it shouldn't.

hm, but that would mean random process that would happened to trigger
the tracepoint would segfault, right? I don't think we can do that

it seems better to teach verifier which tracepoint arguments can be NULL
and deny load of the bpf program that would not check such argument properly

jirka

