Return-Path: <bpf+bounces-49839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6425A1CEFE
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 23:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D663A232C
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 22:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5B878F29;
	Sun, 26 Jan 2025 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDxurefg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CB28691
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737929197; cv=none; b=OKBB7VmVlR+HZMSUuzB6EOOJMNECDq8NBj12NClr+4OwYYiVKSbaTSFbLcSkMyuO+Io+BLWfYFL1pT+xzPxBdS5oCt2jxEc6csaLysmq3TiFaPVK6Kq/V81p+1/FuLoh2NDd/NtHQZ/r6oXS0SCFTOh00Tdn4HejoqQ2/bjvCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737929197; c=relaxed/simple;
	bh=Xaqkgbj27+rHW7bYvtUyImJjmfIZFtmedmNkaJF3GkM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7whTWUk/4pP1Fzm1SAsfhv70GfQ4YeN9MgdeZkA5Fa1KNxqD9RNWtGyWmmsiJsGs7Dt4GRdh4r4JEAlwaqDDGcWzq0Lt4eZ/8FTOl0ovLQ3biRf8cKHJJyqAeu7Pe9qkOYwt2I7HaXxmjOUvHI6xuuao6HyPJa7qdhAEhGeb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDxurefg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso30386605e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 14:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737929194; x=1738533994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6gXFttI9tomEAiDcFCPxDD4UJtPiHoJxMvYXMLmQGdY=;
        b=DDxurefgQ+QnRh/I9M4LYBJKhJVZ9DE1T3Wj2j9nxTZ2z05XdqEx/zQxLWHERXOfrT
         QUM0s6kzU9ZhROXKmujYXmhgjJGiY7LjOKIMsSpD6+bBkbg8pDO8pdwDEj5gSwe2niJ6
         ed02wWGQsMcuCfJw8/2w4rYwmCk5SvMzwyCZR5SjQKM0Ew//SlYWpNWcYKok23EkNBHL
         +EDOTRTglbE00VATcBA1VuiDJSj7lRcitFCzMMTbSX9Jiqq1MZuf+U6PfTDlaG9fvoDW
         iDbJiJlHt2rv5Lhgr2x2C3fPYvaEqDf4/1TONhiKNqwlj+2gNANFsL5DtqYEiT4hIrS5
         mpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737929194; x=1738533994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gXFttI9tomEAiDcFCPxDD4UJtPiHoJxMvYXMLmQGdY=;
        b=xNwf552XBkfswMiz+B4ukJSMpaAym0NJJ88Vy02qZkACyD7rHNqZT7i1oVdFgBtwlr
         Mi4RwMe6AzJ61U7D/W1+qOETZn435ynkpGpSY+n7M8LX8m1dMWkzUQjSbcgEdhSFM9MM
         8Utt1Uw0wBWMjKcVgh9vTJE/bOoJKb8Fsim86x1BB6KfkP9sI+YW+2EmlAkY5qSZ4jBi
         g43fkiQZcgmbyhzec9AmJWJ68ZgyZUoor9/J5gXmuY9M8iyKM12do613AOepIwSLMeLt
         F+PHKy1T5mDKiUnlnW1CB9hfOpucHOdBug2thMNY0qN5QHuff4awzaWdn3IjU6ld8lgj
         y0yg==
X-Forwarded-Encrypted: i=1; AJvYcCUZW07ltcy+xZX/Ny1z4yPkUz7ETEWOQuLERiyu0i16ZtjtaCI8RNph5T4qIhLHyHpygHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqnz6P3O76ykD0rZx+3xiefnPTmqLMrOD+gHmy0QJjmlD1/TTu
	Ds72OJXqvW7o97Tr4tq4QFhJCGuvBOZDKnLIFtj1iE09JuckVYTk
X-Gm-Gg: ASbGnctqH7rwOW1W33ZtTB5mj50OXL4DkSX3PvqDOygSexGUldYWPcV1F7WJITw9CKg
	xdQNtiOfzbFc9CrsOemWzLrMOI/MZjOf/3uNwAAnZubNMeNBCvY7PJJ/kw4KSNm02ngUYJDLD5E
	DhCoDu+U9t1xizaqbSIPUmBrpygp19I4W+tEJWlgDbpWaGLBvp8l3LFnkUq6ZV9gjXTRE9dC4zj
	GYQMNvbKpRT2RJRS/GtnJAkBjET8ZXwHL/v438MUf8QSaoeExW1YOUaLkTNuk2GTdCTejpHSqN1
	pNQrxSB6mLWazw==
X-Google-Smtp-Source: AGHT+IGbzKUU6xb10R7fejU2jEyzFllDdtR4gtiggohpiFKpwnyIvGoYUaIQf60MVCXnwViO6f+zVw==
X-Received: by 2002:a05:600c:63ce:b0:437:c453:ff19 with SMTP id 5b1f17b1804b1-438bd0bd5eemr95800825e9.14.1737929193425;
        Sun, 26 Jan 2025 14:06:33 -0800 (PST)
Received: from krava (37-188-142-26.red.o2.cz. [37.188.142.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b1cc8571sm121073335e9.1.2025.01.26.14.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 14:06:32 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 26 Jan 2025 23:06:28 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Sven Schnelle <svens@linux.ibm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [TEST FAILURE] bpf: s390: missed/kprobe_recursion
Message-ID: <Z5ax5AKwIaD6ONM-@krava>
References: <3c841f0a-772a-406c-9888-f8e71826daff@linux.dev>
 <Z5N4N6MUMt8_EwGS@krava>
 <Z5O0shrdgeExZ2kF@krava>
 <20250126234005.70cb3b43193b08ed8a211553@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126234005.70cb3b43193b08ed8a211553@kernel.org>

On Sun, Jan 26, 2025 at 11:40:05PM +0900, Masami Hiramatsu wrote:
> On Fri, 24 Jan 2025 16:41:38 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Fri, Jan 24, 2025 at 12:23:35PM +0100, Jiri Olsa wrote:
> > > On Thu, Jan 23, 2025 at 02:32:38PM -0800, Martin KaFai Lau wrote:
> > > > Hi Jiri,
> > > > 
> > > > The "missed/kprobe_recursion" fails consistently on s390. It seems to start
> > > > failing after the recent bpf and bpf-next tree ffwd.
> > > > 
> > > > An example:
> > > > https://github.com/kernel-patches/bpf/actions/runs/12934431612/job/36076956920
> > > > 
> > > > Can you help to take a look?
> > > > 
> > > > afaict, it only happens on s390 so far, so cc IIya if there is any recent
> > > > change that may ring the bell.
> > > 
> > > hi,
> > > I need to check more but I wonder it's the:
> > >   7495e179b478 s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
> > > 
> > > which seems to add recursion check and bail out before we have
> > > a chance to trigger it in bpf code
> > 
> > so the test attaches bpf program test1 to bpf_fentry_test1 via kprobe.multi
> > 
> > 	SEC("kprobe.multi/bpf_fentry_test1")
> > 	int test1(struct pt_regs *ctx)
> > 	{
> > 		bpf_kfunc_common_test();
> > 		return 0;
> > 	}
> > 
> > and several other programs are attached to bpf_kfunc_common_test function
> > 
> > 
> > I can't test this on s390, but looks like following is happening:
> > 
> > kprobe.multi uses fprobe, so the test kernel path goes:
> > 
> >     bpf_fentry_test1
> >       ftrace_graph_func
> >         function_graph_enter_regs
> > 	   fprobe_entry
> > 	     kprobe_multi_link_prog_run
> > 	       test1 (bpf program)
> > 	         bpf_kfunc_common_test
> > 		   kprobe_ftrace_handler
> > 		     kprobe_perf_func
> > 		       trace_call_bpf
> > 		         -> bpf_prog_active check fails, missed count is incremented
> > 
> > 
> > kprobe_ftrace_handler calls/takes ftrace_test_recursion_trylock (ftrace recursion lock)
> > 
> > but s390 now calls/takes ftrace_test_recursion_trylock already in ftrace_graph_func,
> > so s390 stops at kprobe_ftrace_handler and does not get to trace_call_bpf to increment
> > prog->missed counters
> 
> Oops, good catch! I missed to remove it from s390. We've already moved it
> in function_graph_enter_regs().
> 
> 
> > 
> > adding Sven, Masami, any idea?
> > 
> > if the ftrace_test_recursion_trylock is needed ftrace_graph_func on s390, then
> > I think we will need to fix our test to skip s390 arch
> 
> Yes. Please try this patch;
> 
> 
> From 12fcda79d0b1082449d5f7cfb8039b0237cf246d Mon Sep 17 00:00:00 2001
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Sun, 26 Jan 2025 23:38:59 +0900
> Subject: [PATCH] s390: fgraph: Fix to remove ftrace_test_recursion_trylock()
> 
> Fix to remove ftrace_test_recursion_trylock() from ftrace_graph_func()
> because commit d576aec24df9 ("fgraph: Get ftrace recursion lock in
> function_graph_enter") has been moved it to function_graph_enter_regs()
> already.
> 
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Fixes: d576aec24df9 ("fgraph: Get ftrace recursion lock in function_graph_enter")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

great, ci is passing with this fix

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  arch/s390/kernel/ftrace.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> index c0b2c97efefb..63ba6306632e 100644
> --- a/arch/s390/kernel/ftrace.c
> +++ b/arch/s390/kernel/ftrace.c
> @@ -266,18 +266,13 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
>  	unsigned long *parent = &arch_ftrace_regs(fregs)->regs.gprs[14];
> -	int bit;
>  
>  	if (unlikely(ftrace_graph_is_dead()))
>  		return;
>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
>  		return;
> -	bit = ftrace_test_recursion_trylock(ip, *parent);
> -	if (bit < 0)
> -		return;
>  	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
>  		*parent = (unsigned long)&return_to_handler;
> -	ftrace_test_recursion_unlock(bit);
>  }
>  
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> -- 
> 2.43.0
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

