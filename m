Return-Path: <bpf+bounces-71969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6332C03698
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 22:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0733050563A
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 20:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48AD2D0605;
	Thu, 23 Oct 2025 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bODeXg8c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB804223702
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252135; cv=none; b=Nll5GhY/9C6dIE8bn3j15FmLNPiGflDZByGTRbDmmp3D5FIfy4bgCkvSKunaSQxDt915Tve7X4Bg8ozUuU7QpvFGNOtLzssUlnd4lPo+1gHMhfn7dlLNkSgfgM/4iK5Q8oYXO8QUiUkTW5Hak/2sIoDQC69n8pTnJeobgBeLgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252135; c=relaxed/simple;
	bh=Ko8enK1JFjO4wksPDhx1vkb6ZOvA41mPBysZQUIMwjA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFXUcsm4dLhz1dUllLbSBE5V4VFzG9arzisdUdQb1K5KZ8zAtKKfp7aLudxuFq9j01Yy6tKgFwf9VxGbtUvyiKyNtBF+eUeAGmfNhLLthBtp34RdoSY9KoezvnuZt06dBcDhd+mCvtQMMfzlaYKinjwykp6gAQmO4AwRPcASkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bODeXg8c; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1221189f8f.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761252131; x=1761856931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66M7HGTPtc8u9frhoZGdDnXO4Jxrrpgkx85w11tGgd0=;
        b=bODeXg8cRBHwkmpEEi1RfGb4AsEb1lzQqCQdJGQzXs9oVrImKPf5xNN022v1kLJxFd
         cery3yPSgXZ6FQowyjnun7JT6HFHLHz4C8Mgv4Yi02MMRm3qJNghBugN7nm2BMD63iHs
         SCaJLpEhOYxJ06jhxNocvMxVAno7pz15OEq3ZtQ+T80Sq9m2UOyZ+Nm9cBu9msRuE6x+
         YXr1PaAkf3PGO10XEjHPhwYGA6cn9JMvSq+4vYL3C6Dy5JJ62oOkxQmqs60qcP5SXx0c
         FVUgPwtdLXcpKl9Vu7cQy1KoVgNOOqVfKxI418o8dInr248JVwrOazeGvgMkNmIbBeK8
         fkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252131; x=1761856931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66M7HGTPtc8u9frhoZGdDnXO4Jxrrpgkx85w11tGgd0=;
        b=qPEwOisEg8SftsHkH3a9mXGJbww3TbBgR62eItlBaf7SxdJEcP78fxEyseo4wwkw9A
         8ivtZuT1lXPe5OXB70O23PpBw7iltTN4vmn7zOD1MLkwYEuB4lbyZ4bh22q25rsypdSl
         zqS1vrIwbEGuqjGVrIgJOhRGhgdLZacWfVQdJ+/suBOWScGRSgPjZMoMb29ktbMng6FQ
         56Aoe1vE1wj1f6KXFtMZcc4ZLkussG7F+qIYS1WKCarL8PgqVM1QFr7mO1g4thwUa5er
         +eFdKEMcg9lIz97wD5ppRLYM/c1IK8fvnZ1tfCTRvLmqPvcs1upEg82+J33t8rO2ITQy
         wCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnyWZ5erfrWMJAGhk2rxPbA1cj5e5mridx2mcGb6YI0PO8/Z0SXcQbM3WvnHG5MO2OclA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmcnSIVEypOno/zh5LBfaYZomTnsQmkAuzqFZzqa2xUexN1+i6
	dkgsGTBVpkFviK1V47KkOFVk88kdU1QRczQy6dJaNIjrjTq0Uul/SsBO
X-Gm-Gg: ASbGnctMl8MHrbZ7HzVjMduvaVeWcZp++7aoPzYIIAR/h3c3VJdMEBnC/TAITwRxw6U
	wlmOgIz+tMBXjqdI2lzjKn+uddi7NtGKk1XJRkfjcvIW8RT3RM4SFPHIpzcP/IIdP6NdJikQ9D0
	/2Td0glBVUkzmOt/JW5ZYy+CKbUlPF/tgwVEpRKE35M1Z/tL0xp+/3XgpVkdIJ44LUqHu1a2eH5
	uCcKHCZFzT84XpUsdC/g7YSmNAhkCcPU1GnQ4o7XPYgDyFiBJOcy0DRIgoVGD7WRSg1k0WYfnst
	fSgcunyEzjNsonzSu8O4Q7Ugml7ym1d95QXfR6+pu7IVwhcT4xamJuVy6UrPl/MzLWbEWDIhW7I
	uSyI2ryfCEusF8n52s/SM1s+zRP/a7ntQ9cNCDQ7KWEK2ntCAkdHE1PWuyp0mbkgrf73lw1HbOW
	4=
X-Google-Smtp-Source: AGHT+IH6iZz8EFIzMppyjzOaLTK75/NP0cBLfDd4PIrxDLXcjekN47dybvrXy+nypfWmsQABw7E9fg==
X-Received: by 2002:a05:6000:2586:b0:426:d81f:483c with SMTP id ffacd0b85a97d-42704daed1amr18761932f8f.33.1761252130798;
        Thu, 23 Oct 2025 13:42:10 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f5696sm5985507f8f.14.2025.10.23.13.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:42:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 23 Oct 2025 22:42:08 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Feng Yang <yangfeng59949@163.com>,
	andrii@kernel.org, bpf@vger.kernel.org, jpoimboe@kernel.org,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	peterz@infradead.org, x86@kernel.org, yhs@fb.com
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <aPqTIDSHOSTiwYA6@krava>
References: <20251015121138.4190d046@gandalf.local.home>
 <20251022090429.136755-1-yangfeng59949@163.com>
 <aPjO0yLCxPbUJP9r@krava>
 <20251022102819.7675ee7a@gandalf.local.home>
 <aPlBcKq7S-bD3B56@krava>
 <20251022171711.5c18f043@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022171711.5c18f043@gandalf.local.home>

On Wed, Oct 22, 2025 at 05:17:11PM -0400, Steven Rostedt wrote:
> On Wed, 22 Oct 2025 22:41:20 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > >   
> > > >  	ANNOTATE_NOENDBR
> > > > +	push $return_to_handler
> > > > +	UNWIND_HINT_FUNC  
> > > 
> > > OK, so what happened here is that you put in the return_to_handle into the
> > > stack and told ORC that this is a normal function, and that when it
> > > triggers to do a lookup from the handler itself.  
> > 
> > together with the "push $return_to_handler" it suppose to instruct ftrace_graph_ret_addr
> > to go get the 'real' return address from shadow stack
> > 
> > > 
> > > I wonder if we could just add a new UNWIND_HINT that tells ORC to do that?  
> > 
> > if I remove the initial UNWIND_HINT_UNDEFINED I get objtool warning
> > about unreachable instruction
> 
> Right. I was thinking we add UNWIND_HINT_RETHOOK and an
> UNWIND_HINT_TYPE_RETHOOK that lets objtool know that this function is a
> "return_to_hook" function and the unwinder can do something special with it.
> 
> > 
> > >   
> > > >  
> > > >  	/* Save ftrace_regs for function exit context  */
> > > >  	subq $(FRAME_SIZE), %rsp
> > > > @@ -360,6 +362,9 @@ SYM_CODE_START(return_to_handler)
> > > >  	movq %rax, RAX(%rsp)
> > > >  	movq %rdx, RDX(%rsp)
> > > >  	movq %rbp, RBP(%rsp)
> > > > +	movq %rsp, RSP(%rsp)
> > > > +	movq $0, EFLAGS(%rsp)
> > > > +	movq $__KERNEL_CS, CS(%rsp)  
> > > 
> > > Is this simulating some kind of interrupt?  
> > 
> > there are several checks in pt_regs on these fields 
> > 
> > - in get_perf_callchain we check user_mode(regs) so CS has to be set
> > - in perf_callchain_kernel we call perf_hw_regs(regs), so EFLAGS has to be set
> 
> So this is a different issue. I rather have this added in
> kprobe_multi_link_prog_run as its the only user of it. Or have the

there's also fprobe tracer that probably needs it as well

> ftrace_regs conversion update it. This isn't something that should be done
> at every call and slow everyone else down.

I think it's ok, but not sure where to get rsp value at that point,
perhaps we could just use the pt_regs address

jirka

> 
> > 
> > >   
> > > >  	movq %rsp, %rdi
> > > >  
> > > >  	call ftrace_return_to_handler  

SNIP

