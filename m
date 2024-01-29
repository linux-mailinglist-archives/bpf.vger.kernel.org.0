Return-Path: <bpf+bounces-20556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6501F84024A
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 10:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8957D1C227A9
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE256B96;
	Mon, 29 Jan 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtlwp4+R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF857871;
	Mon, 29 Jan 2024 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522065; cv=none; b=foatTqY8r4t9xFu1k2NXK8ThejAau19U0nCbEsIq1O5c9fZxHN3fWinbxH8WX84BrEDec/TiPyyfPkQcUizzwKHnsjL35HLB6GRh4ZkbmPPd7bDvJNiNSq4iomAvE1r61kCZ4qhHg8DNpTdnEHGL4DtVb5TTl/6fk8eb7Hd34r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522065; c=relaxed/simple;
	bh=Xxht6U4VSYKYvcFm5QKEYFp05/uW5TH2MJnFmQ9fcjU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChqvlA7In0wnXhGHcFQz53ny9gj8rQdKUN2pv6m9yaSpC/QTp8vKC2rVLvynzeOMAHwwDYfcj5+WnIT1QYquGhSVM+5u/FZ6q9mioUXCSyMyg+yNKqqu2STgeMpa7EIQNWopBCCnvLAcpNxmekWzKoXzuFlTsvM+6DR6Lo/PwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jtlwp4+R; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so3003696a12.2;
        Mon, 29 Jan 2024 01:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706522062; x=1707126862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsyq9RDJnyx/vwAlCABE4IQoDmtfQ9ujfI3zrm1Np8k=;
        b=Jtlwp4+RKlWQKnTE+Yie3uw+WgTL0uGzcvC6TyYpq7RiXcXgfNGhkWR7lHzlhp3eyy
         N9N9uTtZOZibSZZ8HTe/KXYRGNqFp0XBxrCrr74PoJmqkK/dwGh6OpVpZceyhjqbsZaa
         JmKsTS0UVzDoa5faqHzEgR+FgWio7FU0QUqCa4bTO4hPIRFSAlD0dmiRP2c2gwhyk+zB
         itfppoq1p6ewVSTCIyH0JfWYjDOV3kknoEv06JLdt3Dn18Y5EIS0aARirg3C1M6BId3z
         jyQYLqupc4JpBXrg5zFsBaRyOckUu94e+XUE7z17bCh/2AGQUIxym/6JCQajAr83pqwg
         tFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706522062; x=1707126862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hsyq9RDJnyx/vwAlCABE4IQoDmtfQ9ujfI3zrm1Np8k=;
        b=gdGDZT1jNHmqpGdi/YetGvVlNpbdSeOn7A/vvgDrCtMdn2Vy811s4GTCnGN5W6cCpj
         geVZDOTwVT9qWbffdIx5ai0PNUoxEsgeSlBLqTR0Y936+JoYsMEdYN34sogBMjyKJXqQ
         nH3o5cNWdij6omPMd7Mnb86iHE1k8hWrHcYe3GpdGvQCAQEEoXkhWCkVrH2lxrhixKB9
         L7fBBUPgui3jQAW9zijYrXYf/FVFzfgAwFE4meci2YrRIN9evgUz516WlneI6y+J08hE
         idmn16uktixaH+r6GuVTT8uedE6n85NF/8Exx8BM9JCa8JO73vE4c8sxbfJ3S5Q+a1FG
         fpxQ==
X-Gm-Message-State: AOJu0YxRoahafwb364j5rzlLfLDmmF10qabuShKccNyuibcIUw/uR2Rg
	PTHY4rXu6ZQej27oRaVbtejSFfCLieL/6I/JpQEWwrQFZDAyi/uU
X-Google-Smtp-Source: AGHT+IEZfWmmqffnPjC9XgPKd+2w+8UYFBSDMfNDkeKUhfXXXBALKwEvO4NuuDo6hstyrnAd4354HA==
X-Received: by 2002:a17:906:acb:b0:a31:1907:2fe8 with SMTP id z11-20020a1709060acb00b00a3119072fe8mr3987816ejf.48.1706522061544;
        Mon, 29 Jan 2024 01:54:21 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906354f00b00a3186c2c254sm3714270eja.213.2024.01.29.01.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:54:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 Jan 2024 10:54:18 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v6 00/36] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
Message-ID: <Zbd1ypWJEVMW0uFv@krava>
References: <170505424954.459169.10630626365737237288.stgit@devnote2>
 <ZbJ2PfSt3RM3pm43@krava>
 <20240127001405.c031ad1d7ab37089b563371b@kernel.org>
 <ZbVO9oKa7Ti-EvAa@krava>
 <20240128165153.5e6d71be8ad9c3dd69bd02bf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128165153.5e6d71be8ad9c3dd69bd02bf@kernel.org>

On Sun, Jan 28, 2024 at 04:51:53PM +0900, Masami Hiramatsu wrote:
> On Sat, 27 Jan 2024 19:44:06 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Sat, Jan 27, 2024 at 12:14:05AM +0900, Masami Hiramatsu wrote:
> > > On Thu, 25 Jan 2024 15:54:53 +0100
> > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > 
> > > > On Fri, Jan 12, 2024 at 07:10:50PM +0900, Masami Hiramatsu (Google) wrote:
> > > > > Hi,
> > > > > 
> > > > > Here is the 6th version of the series to re-implement the fprobe on
> > > > > function-graph tracer. The previous version is;
> > > > > 
> > > > > https://lore.kernel.org/all/170290509018.220107.1347127510564358608.stgit@devnote2/
> > > > > 
> > > > > This version fixes use-after-unregister bug and arm64 stack unwinding
> > > > > bug [13/36], add an improvement for multiple interrupts during push
> > > > > operation[20/36], keep SAVE_REGS until BPF and fprobe_event using
> > > > > ftrace_regs[26/36], also reorder the patches[30/36][31/36] so that new
> > > > > fprobe can switch to SAVE_ARGS[32/36] safely.
> > > > > This series also temporarily adds a DIRECT_CALLS bugfix[1/36], which
> > > > > should be pushed separatedly as a stable bugfix.
> > > > > 
> > > > > There are some TODOs:
> > > > >  - Add s390x and loongarch support to fprobe (multiple fgraph).
> > > > >  - Fix to get the symbol address from ftrace entry address on arm64.
> > > > >    (This should be done in BPF trace event)
> > > > >  - Cleanup code, rename some terms(offset/index) and FGRAPH_TYPE_BITMAP
> > > > >    part should be merged to FGRAPH_TYPE_ARRAY patch.
> > > > 
> > > > hi,
> > > > I'm getting kasan bugs below when running bpf selftests on top of this
> > > > patchset.. I think it's probably the reason I see failures in some bpf
> > > > kprobe_multi/fprobe tests
> > > > 
> > > > so far I couldn't find the reason.. still checking ;-)
> > > 
> > > Thanks for reporting! Have you built the kernel with debuginfo? In that
> > > case, can you decode the line from the address?
> > > 
> > > $ eu-addr2line -fi -e vmlinux ftrace_push_return_trace.isra.0+0x346
> > > 
> > > This helps me a lot.
> > 
> > I had to recompile/regenerate the fault, it points in here:
> > 
> >         ffffffff8149b390 <ftrace_push_return_trace.isra.0>:    
> >         ...
> > 
> >                         current->ret_stack[rindex - 1] = val;  
> >         ffffffff8149b6b1:       48 8d bd 78 28 00 00    lea    0x2878(%rbp),%rdi
> >         ffffffff8149b6b8:       e8 63 e4 28 00          call   ffffffff81729b20 <__asan_load8>
> >         ffffffff8149b6bd:       48 8b 95 78 28 00 00    mov    0x2878(%rbp),%rdx
> >         ffffffff8149b6c4:       41 8d 47 ff             lea    -0x1(%r15),%eax
> >         ffffffff8149b6c8:       48 98                   cltq
> >         ffffffff8149b6ca:       4c 8d 24 c2             lea    (%rdx,%rax,8),%r12
> >         ffffffff8149b6ce:       4c 89 e7                mov    %r12,%rdi
> >         ffffffff8149b6d1:       e8 ea e4 28 00          call   ffffffff81729bc0 <__asan_store8>
> > --->    ffffffff8149b6d6:       49 89 1c 24             mov    %rbx,(%r12)
> >                         current->curr_ret_stack = index = rindex;
> >         ffffffff8149b6da:       48 8d bd 6c 28 00 00    lea    0x286c(%rbp),%rdi
> >         ffffffff8149b6e1:       e8 9a e3 28 00          call   ffffffff81729a80 <__asan_store4>
> >         ffffffff8149b6e6:       44 89 bd 6c 28 00 00    mov    %r15d,0x286c(%rbp)
> >         ffffffff8149b6ed:       e9 8d fd ff ff          jmp    ffffffff8149b47f <ftrace_push_return_trace.isra.0+0xef>
> >                 if (WARN_ON_ONCE(idx <= 0))      
> > 
> 
> Thanks! So this shows that this bug is failed to check the boundary of
> shadow stack while pushing the return trace.
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 0f11f80bdd6c..8e1fcc3f4bda 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -550,7 +550,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  	smp_rmb();
>  
>  	/* The return trace stack is full */
> -	if (current->curr_ret_stack + FGRAPH_RET_INDEX >= SHADOW_STACK_MAX_INDEX) {
> +	if (current->curr_ret_stack + FGRAPH_RET_INDEX + 1 >= SHADOW_STACK_MAX_INDEX) {
>  		atomic_inc(&current->trace_overrun);
>  		return -EBUSY;
>  	} 
> 
> Sorry, I forgot to increment the space for reserved entry...

hum, I'm getting same error even with the change above, same backtrace/line

jirka

