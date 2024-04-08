Return-Path: <bpf+bounces-26139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050FA89B6A4
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 05:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B39281CDF
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 03:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F2522F;
	Mon,  8 Apr 2024 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8pnCjng"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3D1FC8;
	Mon,  8 Apr 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548448; cv=none; b=d2LBDbFGCHizf/h5naSyPLfJkOTugpkMNrBAiQLzlu1Cv0RnUA8iXa3wFLknJgngviKSTLLVnTle7Rbe6Hq2tduxKngNVaNUUPnRyAFSw8McCdpeuRJ/YKccM13idbv3bzAFavsywux5q4L96SBaPqLIC8koUMiuSkDa94iiguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548448; c=relaxed/simple;
	bh=ldaL5TI2vG8hJ2dJM8jnvwvFwNTV8s/Opak7rNRuJkQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kFwO1wyPGg9OKGZ74Z+N9L3IWrxc4FWVCq0VyDy8oda5aOLzrSdSaMFnxLHFS4MQ0ewkPg0jM6mKBAWFTJKS2iRB0CGeQ/viVQHPnYrDcQuYafE2Q+k5U7SfdX8JfV+a3DBCaQk7Cz7TqPuhv2+FasYq9BIWzG3Y3TzH1mGW3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8pnCjng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0C4C433F1;
	Mon,  8 Apr 2024 03:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712548447;
	bh=ldaL5TI2vG8hJ2dJM8jnvwvFwNTV8s/Opak7rNRuJkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V8pnCjngV44K8vktUDKHOC10cJlaZI7dD9ILMpqODQeiAnMyYymlg53uHnn4bTvpS
	 nfLjZNy9IFergsvkjz3kVlipshMlKutYpIQ/qvSAysMYCeNE/GOPyJR0q5l+jBv4GQ
	 juwA/wdWVwJmpITYG3zBVWrb8UddARMslSkOidhLvadEHiWGo3gz68lFc8p/XJbGjv
	 sme6r9YOgeC8Va9i73956WqXI5AouL6Od/VbEjWtauRBfZcnEWiD8JWlVLUE1sj0ev
	 fFqm9Eg0aOkN8ElM0H+yqIqovds1KEL4n/KLJMI1odWcEc/unLDhq2BHPxNYepOWyD
	 erQfeKBReg/xQ==
Date: Mon, 8 Apr 2024 12:54:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-Id: <20240408125401.d4f100d184b11bc01fcd0308@kernel.org>
In-Reply-To: <20240406175558.GC3060@redhat.com>
References: <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
	<CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
	<20240404095829.ec5db177f29cd29e849169fa@kernel.org>
	<CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
	<20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
	<20240404161108.GG7153@redhat.com>
	<20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
	<Zg-8r63tPSkuhN7p@krava>
	<20240405110230.GA22839@redhat.com>
	<20240406120536.57374198f3f45e809d7e4efa@kernel.org>
	<20240406175558.GC3060@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Apr 2024 19:55:59 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 04/06, Masami Hiramatsu wrote:
> >
> > On Fri, 5 Apr 2024 13:02:30 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > With or without this patch userpace can also do
> > >
> > > 	foo() { <-- retprobe1
> > > 		bar() {
> > > 			jump to xol_area
> > > 		}
> > > 	}
> > >
> > > handle_trampoline() will handle retprobe1.
> >
> > This is OK because the execution path has been changed to trampoline,
> 
> Agreed, in this case the misuse is more clear. But please see below.
> 
> > but the above will continue running bar() after sys_uretprobe().
> 
> .. and most probably crash

Yes, unless it returns with longjmp(). (but this is rare case and
maybe malicious program.)

> 
> > > sigreturn() can be "improved" too. Say, it could validate sigcontext->ip
> > > and return -EINVAL if this addr is not valid. But why?
> >
> > Because sigreturn() never returns, but sys_uretprobe() will return.
> 
> You mean, sys_uretprobe() returns to the next insn after syscall.
> 
> Almost certainly yes, but this is not necessarily true. If one of consumers
> changes regs->sp sys_uretprobe() "returns" to another location, just like
> sys_rt_sigreturn().
> 
> That said.
> 
> Masami, it is not that I am trying to prove that you are "wrong" ;) No.
> 
> I see your points even if I am biased, I understand that my objections are
> not 100% "fair".
> 
> I am just trying to explain why, rightly or not, I care much less about the
> abuse of sys_uretprobe().

I would like to clear that the abuse of this syscall will not possible to harm
the normal programs, and even if it is used by malicious code (e.g. injected by
stack overflow) it doesn't cause a problem. At least thsese points are cleared,
and documented. it is easier to push it as new Linux API.

Thank you,

> 
> Thanks!
> 
> Oleg.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

