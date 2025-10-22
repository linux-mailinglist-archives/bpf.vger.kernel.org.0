Return-Path: <bpf+bounces-71711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9FFBFBDEF
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D91422E70
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7533446DF;
	Wed, 22 Oct 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoXu6e17"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74693446DA
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136345; cv=none; b=HSOB+gtfs2t0zGnyykBEQBsJuXkhCdVOV5nVCiuEmk+4zuxTaih9353H1pVJKLA4Y9Hgj/6R0CgNrS760zSGVJgiweC7APpN4THqS8fQ738CI6iE0nYi2XZisnePHazfGGFBC+6jEL4dPbQHszXE9FWno9p3XtH+kmO3Wp3bLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136345; c=relaxed/simple;
	bh=AMGbie63VUMOzJvd/z0itmKbmmfP/MazEZuGYEYWieg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtMZQ0dpJgaXOI2UdeYuPC+wff6dORGBogPMeAWMRu24sg1yTZ3ni3Hxa4psQea2Wqq3Pc3TYpVoacsnZOxL4inT5SG6gOVzuFuCEpNXhATZesjXqLrCanqRFIGnR3F74HGB3PD+DqdHMy23SeHTukf46Nl+dfMfB9YTkhODDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoXu6e17; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471131d6121so51897635e9.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761136342; x=1761741142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jK9H5n3KatNwCpAdsxB6P4TupwFSUahOuVAwqjA3SLc=;
        b=UoXu6e17WmAtWYTQpprdi3WuHAkBm+7p5akKb8X88qP/XWHpomTGzMo7o8/CTwVnu9
         7yT3u+1b0gQ3KTHYki0BauSaylBkDoC8X3cwLBzUTOTLKngmT1hkL6dczLs3YKp6HHEK
         xMRwfwCc94OAq7BNewB+EFEUA82ew0Lff5F4G4AxQOwGzX8cKvZHIJULjiKvIdfFg7DV
         rAuTMehC1fFvsl+H5LZDh6WRA9oueCWX1oqu3bzzVYvBVWtKL7Q+XA5bi1Wj9tcx13QK
         qcuerIL/u8QTr5dotR9XHljvWPQXF7XoPuyBvNBdfSg4mKXp0W1shLpoXw+98eE/5SUi
         ERjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136342; x=1761741142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK9H5n3KatNwCpAdsxB6P4TupwFSUahOuVAwqjA3SLc=;
        b=MYzuRCIczpZmw9kZGCbAwaUyHrfN7SRk+MsF+bHkgN2Q1dVI2wzGkvUlDXyyzHxuRG
         t018uqpLpc7PWru4Psdqy+M9Qr6Lde6l2+foQOtPTN6GzjSlojMTcLQXAx2Hdf9zVjdj
         FSWglfjvNtoAkeGJsUvcaXTe51zBwPN5nXOsocTWhySwBzIgzqTygWhnC237iIODa2Ki
         YdGdTY2dAe8GKAd+nyZyvdEfaxVI4jYmlN+COvZ8EeNum+76FJjRIHkY2+UlPQeK9TA5
         6hnl3l8W1o8fcUmolRfEMXChIkGRG0tOR7/DmDaN/n73fT25w89cLqdXkZkH7MPMAM41
         FrFA==
X-Forwarded-Encrypted: i=1; AJvYcCVPkFNpK/alQXINV/0Or5PmQv6aCzxApovqCl+Wvd3Itp2vkz4Y5QXNMWzSdeknqe0mnEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSOQ+iSg2b4vNWzKnvHebWDKaOACDvgdW0M9RHcgVBEP/GRxf
	UaoNm4/XzhifMcAbRODpfHad1SJvEeE89xb2X+2+xndsqRPe4El1QMbW
X-Gm-Gg: ASbGncvUEGVCLNJJ7BsTfOZPT8td/bBvRJdbcBD12neojbqvPQ66TsFICSh4cTgjjEj
	2kdb8V2B+/7KPjaqg0OdM1COHz4l3Mz1VwyziQvXXcL/qbxJoWjtIkuXo4Fw2zzM21dqEX5Ngo7
	7hlW82+03ptBftddVk5ToZCW5jaHJ9t/gECyuw0QgS2DROaaNnYhFkdRntLkmc78JP+xVZwioTv
	YUmh3On7puOe5lmI9RTirDFlWc51OuUy7p9nM1lAfU2ScyOd4/2cqG/cGHREbpMzO96rlrIloUz
	hbI4uJaSKCt9V7dl/alB6V4bT2PeZpanVuMwyZFKtoJCyLrhzDCp0HewYqIPJjlfkUuPYTGlDKK
	e9NETUqmhuKgOIjMNtuTnzmaBs/bZKYoXCfImifEUbKb/fQLqhz1g8tMPydmjxHHw02YV0HY=
X-Google-Smtp-Source: AGHT+IFwb7mGnekyaVXtffl2/v5cB4GHx+5gbgUZH2WGTpYvumYXMSmaUse5I9AadBrqK4sba4O/Bw==
X-Received: by 2002:a05:600c:5298:b0:46d:996b:826a with SMTP id 5b1f17b1804b1-4711791d69fmr139608645e9.36.1761136341840;
        Wed, 22 Oct 2025 05:32:21 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428a16bsm48727245e9.5.2025.10.22.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:32:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 Oct 2025 14:32:19 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: rostedt@goodmis.org, andrii@kernel.org, bpf@vger.kernel.org,
	jpoimboe@kernel.org, linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org, olsajiri@gmail.com, peterz@infradead.org,
	x86@kernel.org, yhs@fb.com
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <aPjO0yLCxPbUJP9r@krava>
References: <20251015121138.4190d046@gandalf.local.home>
 <20251022090429.136755-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022090429.136755-1-yangfeng59949@163.com>

On Wed, Oct 22, 2025 at 05:04:29PM +0800, Feng Yang wrote:
> On Wed, 15 Oct 2025 12:11:38 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > > Hmm, we do have a way to retrieve the actual return caller from a location
> > > > for return_to_handler:
> > > > 
> > > >   See kernel/trace/fgraph.c: ftrace_graph_get_ret_stack()
> > > > 
> > > > Hmm, I think the x86 ORC unwinder needs to use this.  
> > > 
> > > I'm confused, is that not what ftrace_graph_ret_addr() already does?
> 
> > Ah yeah, that does it too. I just searched for the first function that did
> > the look up ;-)
> 
> > Now I guess the question is, why is this not working?
> 
> 
> I've also encountered this issue recently. It only outputs the stack trace of return_to_handler, for example:
> 
> # bpftrace -e 'kretprobe:vfs_rea* {@[kstack]=count()}'
> Attaching 1 probe...
> ^C
> 
> @[
>     ksys_read+192
>     get_perf_callchain+211
>     bpf_get_stackid+101
>     cleanup_module+303100
>     kprobe_multi_link_prog_run+175
>     fprobe_return+265
>     __ftrace_return_to_handler.isra.0+433
>     return_to_handler+30
> ]: 1

that looks messed up

> 
> The return stack trace when directly executing samples/fprobe/fprobe_example.c is similar:
> [ 71.892353] return_to_handler: kernel_thread+0x71/0xa0
> [ 71.892356] sample_exit_handler: Return from <kernel_clone+0x4/0x470> ip = 0x000000000e0e2004 to rip = 0x00000000127e6d58 (kernel_thread+0x71/0xa0)
> [ 71.892361] __ftrace_return_to_handler.isra.0+0x1b1/0x280
> [ 71.892363] return_to_handler+0x1e/0x50
> 
> No cases were found where the ret of the ftrace_graph_ret_addr function is equal to return_handler.
> 
> Additionally, I noticed that when the x86 architecture executes perf_callchain_kernel, perf_hw_regs(regs) is false,
> and it calls unwind_start(&state, current, NULL, (void *)regs->sp);
> which then proceeds to __unwind_start where the check task == current is performed.
> However, the ARM architecture executes kunwind_init_from_regs(&state, regs);
> instead of taking the second branch with the task == current check.
> 
> I hope these phenomena can help you analyze the cause of this issue.
> Thanks.
> 

thanks for the report.. so above is from arm?

yes the x86_64 starts with:
  unwind_start(&state, current, NULL, (void *)regs->sp);

I seems to get reasonable stack traces on x86 with the change below,
which just initializes fields in regs that are used later on and sets
the stack so the ftrace_graph_ret_addr code is triggered during unwind

but I'm not familiar with this code, Masami, Josh, any idea?

thanks,
jirka


---
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 367da3638167..2d2bb8c37b56 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -353,6 +353,8 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
 SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
+	push $return_to_handler
+	UNWIND_HINT_FUNC
 
 	/* Save ftrace_regs for function exit context  */
 	subq $(FRAME_SIZE), %rsp
@@ -360,6 +362,9 @@ SYM_CODE_START(return_to_handler)
 	movq %rax, RAX(%rsp)
 	movq %rdx, RDX(%rsp)
 	movq %rbp, RBP(%rsp)
+	movq %rsp, RSP(%rsp)
+	movq $0, EFLAGS(%rsp)
+	movq $__KERNEL_CS, CS(%rsp)
 	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
@@ -368,7 +373,8 @@ SYM_CODE_START(return_to_handler)
 	movq RDX(%rsp), %rdx
 	movq RAX(%rsp), %rax
 
-	addq $(FRAME_SIZE), %rsp
+	addq $(FRAME_SIZE) + 8, %rsp
+
 	/*
 	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
 	 * since IBT would demand that contain ENDBR, which simply isn't so for

