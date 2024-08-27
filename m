Return-Path: <bpf+bounces-38133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118D960727
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 12:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212871F26ADB
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A31A19E83E;
	Tue, 27 Aug 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODE2sLgW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C719DF9A;
	Tue, 27 Aug 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753323; cv=none; b=Pxfp8UIuh7tXXuxeeroYdsXCl8ugMJrMPb1ROWKXh2QEGZYQn35DBaBCQdxf024llzJaAVLMO3bbQhwGecxPLJhpP7vZCkcq6Dx8q8c4UTHg7b4ZYtZO/hQ966W2bqEr9Vpvww6Ig1wiR0kI1QCOjFh6DD35YT9GtbwklErU/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753323; c=relaxed/simple;
	bh=KWBdcLRlnl5v+404AijGeavbWWipFjEVqt5e5HNPaTQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNxg+HThctZfHJ/95KxiQ2xZqkJAsSf6FrJH/ES98Eu65gDqQbn/nRJ8R9tqK8ZJPjhOxa5mO/onysKnJ+KRayjKuRBUWLLvltkKpuz3PdQreR6k3TvuNblIsGDvW0BiSHcxmUZzGyJfCtVDIXtEcj9rNXXTa3YIhJ3m5xqAOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODE2sLgW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so5825085a12.1;
        Tue, 27 Aug 2024 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724753320; x=1725358120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bxk4oGBqj5TSe2RGYu2wHkf2uvndUY8x3Qox3hJIZr4=;
        b=ODE2sLgWtdgniMW2iAQKaGnI9C9s1AtZkX89oNCzS1KQiJo30k/PzsqQ0zvoEh6pZE
         3WknVnPUsc9KT/oKRMeNETmz8E58pFT3eTZ50Q4J3BYovIJzOvKaCs5EX729Msk5KH6e
         Yolceabyz3foAx7IG4DIH+EieHjCOcoDxppaMyxutEavOimyC4O9Ip07j0lJ47QxW4qh
         uUkIY6dbsYhnBmjiiLUJ8nZe9GQ/p5Awm/yvg9YrjIFnQYxgHjBXSgFNp0spwZS+H6AD
         yWroabcKSyt2mnHtssHS1FwoIffV5GbwzaB7H46QeimyQnwdN+zxNA2Y8IHocXRLY5t3
         UTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724753320; x=1725358120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bxk4oGBqj5TSe2RGYu2wHkf2uvndUY8x3Qox3hJIZr4=;
        b=BdVpuIXrO4exUzHQQIwSwjOsMFdhg2H76G/yyLGIPBDXOYq9pXYJw8h2sdBDTt0GaF
         5He16M0cQbtuc8P4O8XYV3LWp1qGWNK2xkRTKzS799i2LCx7qwmDPYXdzV2CzierZeG5
         /uwK+4FWO4IRu6/AGo3zfVrZpGkR7pEzmZkGx8TOR4qo/BjFTSBkwJ/w/o2ZMLJ/zmz1
         oeDdqEeJWNVeLlbHrxE7BRF2y1E4Yx9UwHou9orwkUs4VcJk6b1gzpHoExGSAMXWOcTH
         VK8Z/snIa/3ly5r7v2ky5Qmbw1HGSFZ6RSWFwIKP0/skaZwctgqvJUfC9FeoJW+AGOuP
         6KZw==
X-Forwarded-Encrypted: i=1; AJvYcCWX7Dnr/RXm7XLbBG6MRpxorlpGDRzgVpD6T4rQxDaVcdblOIduEzQs0ZT+vLhVxodnN1uaWQSiYrvWu+jEtiiKPAHX@vger.kernel.org, AJvYcCXB5yja0SMfA85Y6d+oL+wk+t6ZbCCRObm7bz5TMWUqOIah4lvF9tNfHyBNBHD55125iec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjGLTZnr+h424BvfUS337g4nXBBsp/m5HOf1t7VbJ7+RF2xgR
	kuYMO2EjQEI9flBBxEregqfVNzNgBt9bzbKjD8gmZVOi869ks+ws
X-Google-Smtp-Source: AGHT+IHiS+fumnvhTqX4wqwV/4h1GzURw9WeZF+bM3GDo6fqF0NxU9dM3242dsym4HaeAp8N0y6neg==
X-Received: by 2002:a17:907:f742:b0:a7d:3cf6:48d1 with SMTP id a640c23a62f3a-a86a52ec041mr755573066b.32.1724753319835;
        Tue, 27 Aug 2024 03:08:39 -0700 (PDT)
Received: from krava ([173.38.220.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cf94sm90064166b.80.2024.08.27.03.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:08:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Aug 2024 12:08:37 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zs2lpd0Ni0aJoHwI@krava>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826115752.GA21268@redhat.com>

On Mon, Aug 26, 2024 at 01:57:52PM +0200, Oleg Nesterov wrote:
> On 08/26, Jiri Olsa wrote:
> >
> > On Mon, Aug 26, 2024 at 12:40:18AM +0200, Oleg Nesterov wrote:
> > > 	$ ./test &
> > > 	$ bpftrace -p $! -e 'uprobe:./test:func { printf("%d\n", pid); }'
> > >
> > > I hope that the syntax of the 2nd command is correct...
> > >
> > > I _think_ that it will print 2 pids too.
> >
> > yes.. but with CLONE_VM both processes share 'mm'
> 
> Yes sure,
> 
> > so they are threads,
> 
> Well this depends on definition ;) but the CLONE_VM child is not a sub-thread,
> it has another TGID. See below.
> 
> > and at least uprobe_multi filters by process [1] now.. ;-)
> 
> OK, if you say that this behaviour is fine I won't argue, I simply do not know.
> But see below.
> 
> > > But "perf-record -p" works as expected.
> >
> > I wonder it's because there's the perf layer that schedules each
> > uprobe event only when its process (PID1/2) is scheduled in and will
> > receive events only from that cpu while the process is running on it
> 
> Not sure I understand... The task which hits the breakpoint is always
> current, it is always scheduled in.
> 
> The main purpose of uprobe_perf_func()->uprobe_perf_filter() is NOT that
> we want to avoid __uprobe_perf_func() although this makes sense.
> 
> The main purpose is that we want to remove the breakpoints in current->mm
> when uprobe_perf_filter() returns false, that is why UPROBE_HANDLER_REMOVE.
> IOW, the main purpose is not penalise user-space unnecessarily.
> 
> IIUC (but I am not sure), perf-record -p will work "correctly" even if we
> remove uprobe_perf_filter() altogether. IIRC the perf layer does its own
> filtering but I forgot everything.
> 
> And this makes me think that perhaps BPF can't rely on uprobe_perf_filter()
> either, even we forget about ret-probes.
> 
> > [1] 46ba0e49b642 bpf: fix multi-uprobe PID filtering logic
> 
> Looks obviously wrong... get_pid_task(PIDTYPE_TGID) can return a zombie
> leader with ->mm == NULL while other threads and thus the whole process
> is still alive.
> 
> And again, the changelog says "the intent for PID filtering it to filter by
> *process*", but clone(CLONE_VM) creates another process, not a thread.
> 
> So perhaps we need
> 
> 	-	if (link->task && current->mm != link->task->mm)
> 	+	if (link->task && !same_thread_group(current, link->task))
> 
> in uprobe_prog_run() to make "filter by *process*" true, but this won't
> fix the problem with link->task->mm == NULL in uprobe_multi_link_filter().

would the same_thread_group(current, link->task) work in such case?
(zombie leader with other alive threads)

jirka

> 
> 
> Does bpftrace use bpf_uprobe_multi_link_attach/etc ? I guess not...
> Then which userspace tool uses this code? ;)
> 
> Oleg.
> 

