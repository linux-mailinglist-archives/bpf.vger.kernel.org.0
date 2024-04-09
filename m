Return-Path: <bpf+bounces-26232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDF89CF78
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 02:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A2E1C21FDC
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101784A04;
	Tue,  9 Apr 2024 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4xZ/DCy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C272A934;
	Tue,  9 Apr 2024 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622885; cv=none; b=eliMdUXuj1ZOun4KcqP2pyXlVuTvP4jLTHbiDOpwCEq5a9/QzXW208O4RXCj5avobDLMmJ4dFN7EGBKcll4MkXAHgrmzmz6xN+NyxTMSUCLRJxfej2B9ALuzP+EAT7uPV9ODRTfdLcX3DjXnk0gJuCAn4qUtxBGc7cRMW87fJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622885; c=relaxed/simple;
	bh=6KWBXWrsN0Smo6wkHN8i3FqroEDuIHPvzii2D1XYW/8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ViVFTSchiKOgJgo5I/YCc1zUVdE3eKIJDVsdqACjDIlAHELQgqBBFEhOIudaKP1PAqCHee6obX/ZoUylvNXE1LoP3tqeb1RRkr904xY66zRNIZivdLnW+GGNv0JRo1eIA++duxeudugBtc8bbclfJjRimJElo/DfkEI92lEP9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4xZ/DCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EBFC43390;
	Tue,  9 Apr 2024 00:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712622885;
	bh=6KWBXWrsN0Smo6wkHN8i3FqroEDuIHPvzii2D1XYW/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4xZ/DCyG/081aBtw0KeHHzb01Qn/FrvDbzH0uG0KgXH8TGJPjfqlM9e1csL16R8a
	 tzwcV2I8Xp9BXsh7zbN7ZkYszRKkpOlpV+MjRjtGIZJEPORDJCrNB8u/FtxxhafWE3
	 D7U5f43UojQDsJa+kFdGmOwbQdstenO7G6T7L0xBd43ingrG1FZS2ArlVuzTFjktSn
	 zsfM98Tb2qjqBACkUQ5jS73wdwwFlt1kRHZFp6OFpE6/rEXz0cSGlZk/6vGGcVECP5
	 oJBKjqKJ1f+G0/rF+DYMf+VHwaVkDyHKIJKu1DavcIaAgBYomCvvhJxERjwfVP9C8G
	 h4ALSHHDYNufw==
Date: Tue, 9 Apr 2024 09:34:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-Id: <20240409093439.3906e3783ab1f5280146934e@kernel.org>
In-Reply-To: <ZhQVBYQYr5ph33Uu@krava>
References: <Zg0lvUIB4WdRUGw_@krava>
	<20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
	<CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
	<20240404095829.ec5db177f29cd29e849169fa@kernel.org>
	<CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
	<20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
	<20240404161108.GG7153@redhat.com>
	<20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
	<Zg-8r63tPSkuhN7p@krava>
	<20240405110230.GA22839@redhat.com>
	<ZhQVBYQYr5ph33Uu@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Apr 2024 18:02:13 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Apr 05, 2024 at 01:02:30PM +0200, Oleg Nesterov wrote:
> > On 04/05, Jiri Olsa wrote:
> > >
> > > On Fri, Apr 05, 2024 at 10:22:03AM +0900, Masami Hiramatsu wrote:
> > > >
> > > > I think this expects setjmp/longjmp as below
> > > >
> > > > foo() { <- retprobe1
> > > > 	setjmp()
> > > > 	bar() { <- retprobe2
> > > > 		longjmp()
> > > > 	}
> > > > } <- return to trampoline
> > > >
> > > > In this case, we need to skip retprobe2's instance.
> > 
> > Yes,
> > 
> > > > My concern is, if we can not find appropriate return instance, what happen?
> > > > e.g.
> > > >
> > > > foo() { <-- retprobe1
> > > >    bar() { # sp is decremented
> > > >        sys_uretprobe() <-- ??
> > > >     }
> > > > }
> > > >
> > > > It seems sys_uretprobe() will handle retprobe1 at that point instead of
> > > > SIGILL.
> > >
> > > yes, and I think it's fine, you get the consumer called in wrong place,
> > > but it's your fault and kernel won't crash
> > 
> > Agreed.
> > 
> > With or without this patch userpace can also do
> > 
> > 	foo() { <-- retprobe1
> > 		bar() {
> > 			jump to xol_area
> > 		}
> > 	}
> > 
> > handle_trampoline() will handle retprobe1.
> > 
> > > this can be fixed by checking the syscall is called from the trampoline
> > > and prevent handle_trampoline call if it's not
> > 
> > Yes, but I still do not think this makes a lot of sense. But I won't argue.
> > 
> > And what should sys_uretprobe() do if it is not called from the trampoline?
> > I'd prefer force_sig(SIGILL) to punish the abuser ;) OK, OK, EINVAL.
> 
> so the similar behaviour with int3 ends up with immediate SIGTRAP
> and not invoking pending uretprobe consumers, like:
> 
>   - setup uretprobe for foo
>   - foo() {
>       executes int 3 -> sends SIGTRAP
>     }
> 
> because the int3 handler checks if it got executed from the uretprobe's
> trampoline.. if not it treats that int3 as regular trap

Yeah, that is consistent behavior. Sounds good to me.

> 
> while for uretprobe syscall we have at the moment following behaviour:
> 
>   - setup uretprobe for foo
>   - foo() {
>      uretprobe_syscall -> executes foo's uretprobe consumers
>     }
>   - at some point we get to the 'ret' instruction that jump into uretprobe
>     trampoline and the uretprobe_syscall won't find pending uretprobe and
>     will send SIGILL
> 
> 
> so I think we should mimic int3 behaviour and:
> 
>   - setup uretprobe for foo
>   - foo() {
>      uretprobe_syscall -> check if we got executed from uretprobe's
>      trampoline and send SIGILL if that's not the case

OK, this looks good to me.

> 
> I think it's better to have the offending process killed right away,
> rather than having more undefined behaviour, waiting for final 'ret'
> instruction that jumps to uretprobe trampoline and causes SIGILL
> 
> > 
> > I agree very much with Andrii,
> > 
> >        sigreturn()  exists only to allow the implementation of signal handlers.  It should never be
> >        called directly.  Details of the arguments (if any) passed to sigreturn() vary depending  on
> >        the architecture.
> > 
> > this is how sys_uretprobe() should be treated/documented.
> 
> yes, will include man page patch in new version

And please follow Documentation/process/adding-syscalls.rst in new version,
then we can avoid repeating the same discussion :-)

Thank you!

> 
> jirka
> 
> > 
> > sigreturn() can be "improved" too. Say, it could validate sigcontext->ip
> > and return -EINVAL if this addr is not valid. But why?
> > 
> > Oleg.
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

