Return-Path: <bpf+bounces-28508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693358BAD1C
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297C6284D55
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99E5153BE5;
	Fri,  3 May 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU68yLv6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465C152E17;
	Fri,  3 May 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741471; cv=none; b=gXRVxDdnEIf8RKa8az65w7rQmujOhFMO0V++cuZoFS9Q2c0Lum6Rym4O7G/OgUxXYBLzMJbeu0ysmlCSsn/17gbaATgHP0UVCPLOAAl280vMMVq5gpOne3E6izBTXjTQfUQFeMMGAVx4mxEIQqxQ40BaPqnVNjjg6DGwafBtu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741471; c=relaxed/simple;
	bh=fOlo+GMuztfiqTj7P5x+iF4RQcbKQS7tGnnk8lGMy1w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNj8cE70Ve1iAvshZzZGHvGT5C+RcK7hj8A9JiF9u7GbEXT5YKi4h390G7O8GnVSvN7hd3jnTmCDk2ufHqQIHa7oUMh59EhqbLeMSyMlyNudW8ZRYo7z/rO2UsMW1YC7qbp4BNQyo+ycM12kLURBc0e1KXpM4ciU9ExAciv9r8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SU68yLv6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a599af16934so91253366b.1;
        Fri, 03 May 2024 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714741468; x=1715346268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfzmlT4PMypwMBle7ZsZNzT+S9kweSo9iiTEGtqzGjk=;
        b=SU68yLv6uFL9bW3BPLNolvcy6eT/6hb4dvkJ6J0lZx+TfQUc+erd5jWCnMquLT0VCm
         hHsHNy7a8i+gGbNa7inyj1opmiHTDIsO6+fdrCgp3FsSGWJg8KtmWmsSwudpNbONC4m1
         OfiIdr/f4cpwHe9qb/mDjMks6EAE3GSROR7VXfONjjyvptuVjsoa0VAcRlIEYommSGXs
         fGsBQBRJbNWVA66r2LTnWTdQRjocil1gAZQhlSoqY78pNQY7FYU2tm9ngkVnyill/Xcl
         oeVbWzFS3Wfng285OOcA6OtUV5WNzQLhCUV6EMNF8H8ZfTKQbSo9M/DY+tdo/GDek9UH
         tKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714741468; x=1715346268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfzmlT4PMypwMBle7ZsZNzT+S9kweSo9iiTEGtqzGjk=;
        b=GaW+MWUd/N8ZOrs3GxRNCMOLq040R9Rr8Xqh0Guevwa76M2EY4BrZp3NKYzI48FRVI
         Fh4KrTfy6JcE7mmZ/SPTZZOVRw0BGpGs2ngpEoN/zwJJQkX+PVlCCiDffNRpCJyzIc8I
         wyQWCkt0AxUivh8gvi193Rp5eaqLmt6Pvu8qDxnXxMYCtRWqzRNTFzWHTPLgsRaHOOkw
         YQXMElh7Toax3wIEEt65ffjUXMTRKEstAPDPg7jft2f22AnjwVKDw00t2qlKW/U4ukKO
         P0+w6KCx9SMNAp27kgERVKTh4kSXyZHFQLdPZzQMamNFynXI/UXkG4WgRTd2vHixJw7U
         /BVw==
X-Forwarded-Encrypted: i=1; AJvYcCU7/lpiAI54od51pq+ScTr4lDhblR5SVppCBd7KLKybnbGjYKO1CZaBgkzrgKGYg/R8HQfw2jk1Bm2+T4p4vynXKQAB0MLARRxTqb3UJe0s0/EJix/Cgp5w/Yn86RQFeJ+/jJecZv4DRtl95iu/GBo+0dlJsQxoKZ5UOmpvmx8mK7Pv2pyKteP3Qv4TUDL7ZBYXcNeKaIrn5yZCjsA36ZuMU6hYK8VaYJFBziqRFdOoBjQVAqe39YOQsfka
X-Gm-Message-State: AOJu0YxlJBj1qME9ZHPAUxhKkYS64zXtz2Dxv5o8OcPr+VMDvTTVWcPC
	itMUvXUIt4ps+Lff8JwlPxLy+rOb88fexF7BiXnJLuBN89zWUWDqOj4ymTMz
X-Google-Smtp-Source: AGHT+IFL3T/NXKQC5oSZT3arNu2E5drAgDtmtyKibo1KDyLP50CmVntj5PoGlHXkP/Da6TsyqPpiCw==
X-Received: by 2002:a17:906:2ac7:b0:a52:19ea:8df0 with SMTP id m7-20020a1709062ac700b00a5219ea8df0mr1601884eje.66.1714741467755;
        Fri, 03 May 2024 06:04:27 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id kk1-20020a170907766100b00a599c00442fsm234634ejc.150.2024.05.03.06.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:04:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 May 2024 15:04:25 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <ZjTg2cunShA6VbpY@krava>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <20240502122313.1579719-3-jolsa@kernel.org>
 <20240503113453.GK40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503113453.GK40213@noisy.programming.kicks-ass.net>

On Fri, May 03, 2024 at 01:34:53PM +0200, Peter Zijlstra wrote:
> On Thu, May 02, 2024 at 02:23:08PM +0200, Jiri Olsa wrote:
> > Adding uretprobe syscall instead of trap to speed up return probe.
> > 
> > At the moment the uretprobe setup/path is:
> > 
> >   - install entry uprobe
> > 
> >   - when the uprobe is hit, it overwrites probed function's return address
> >     on stack with address of the trampoline that contains breakpoint
> >     instruction
> > 
> >   - the breakpoint trap code handles the uretprobe consumers execution and
> >     jumps back to original return address
> > 
> > This patch replaces the above trampoline's breakpoint instruction with new
> > ureprobe syscall call. This syscall does exactly the same job as the trap
> > with some more extra work:
> > 
> >   - syscall trampoline must save original value for rax/r11/rcx registers
> >     on stack - rax is set to syscall number and r11/rcx are changed and
> >     used by syscall instruction
> > 
> >   - the syscall code reads the original values of those registers and
> >     restore those values in task's pt_regs area
> > 
> >   - only caller from trampoline exposed in '[uprobes]' is allowed,
> >     the process will receive SIGILL signal otherwise
> > 
> 
> Did you consider shadow stacks? IIRC we currently have userspace shadow
> stack support available, and that will utterly break all of this.

nope.. I guess it's the extra ret instruction in the trampoline that would
make it crash?

> 
> It would be really nice if the new scheme would consider shadow stacks.

I seem to have the hw with support for user_shstk, let me test that

thanks,
jirka

