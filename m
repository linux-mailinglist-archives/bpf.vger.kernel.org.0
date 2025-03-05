Return-Path: <bpf+bounces-53345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A065A5031E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51EB3A6433
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D10924FC0A;
	Wed,  5 Mar 2025 15:02:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523D24C68D;
	Wed,  5 Mar 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186937; cv=none; b=k2axe5WcxUFpBtJE3EQhSF6En6hpELACud+TGAbJ2UBcsANYLsOZz2x6bu0UWHjWc2ltj6jGD5n9ZDC1vvBvNYaMvKmIxmuV30bgmxMZodEqUlgGJ9ZuoEsqJ5EAu+EpEzf9kwVuoO1FzVkDF7l4yz4U69baD/NUSCS5OP8nXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186937; c=relaxed/simple;
	bh=NssrDju0ex2mZCCZUgAf8PQB3BikrUlFJe7buTpCxxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU8K0jqsN8Ow1O5R7Ae+uXvHr4i7FWU4OOs9e+BZx+Z666K9KnjqHLSBmFxPCs+ISqnRT381TRhBOJ/8qoZLxhwA29mm+/QaZy9qQ7Y6haAjYa7tJsl56amMx9g+jsldGqPD+2kHK7XxI1ARLbcbmkvuPd5aLa5lLkxYx9YuAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08294C4CED1;
	Wed,  5 Mar 2025 15:02:11 +0000 (UTC)
Date: Wed, 5 Mar 2025 10:03:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 mark.rutland@arm.com, alexei.starovoitov@gmail.com,
 catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, samitolvanen@google.com,
 kees@kernel.org, dongml2@chinatelecom.cn, akpm@linux-foundation.org,
 riel@surriel.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
Message-ID: <20250305100306.4685333a@gandalf.local.home>
In-Reply-To: <CADxym3busXZKtX=+FY_xnYw7e1CKp5AiHSasZGjVJTdeCZao-g@mail.gmail.com>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
	<20250303132837.498938-2-dongml2@chinatelecom.cn>
	<20250303165454.GB11590@noisy.programming.kicks-ass.net>
	<CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>
	<20250304053853.GA7099@noisy.programming.kicks-ass.net>
	<20250304061635.GA29480@noisy.programming.kicks-ass.net>
	<CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com>
	<20250304094220.GC11590@noisy.programming.kicks-ass.net>
	<6F9EF5C3-4CAE-4C5E-B70E-F73462AC7CA0@zytor.com>
	<CADxym3busXZKtX=+FY_xnYw7e1CKp5AiHSasZGjVJTdeCZao-g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 09:19:09 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> Ok, let me explain it from the beginning. (My English is not good,
> but I'll try to describe it as clear as possible :/)

I always appreciate those who struggle with English having these
conversations. Thank you for that, as I know I am horrible in speaking any
other language. (I can get by in German, but even Germans tell me to switch
back to English ;-)

> 
> Many BPF program types need to depend on the BPF trampoline,
> such as BPF_PROG_TYPE_TRACING, BPF_PROG_TYPE_EXT,
> BPF_PROG_TYPE_LSM, etc. BPF trampoline is a bridge between
> the kernel (or bpf) function and BPF program, and it acts just like the
> trampoline that ftrace uses.
> 
> Generally speaking, it is used to hook a function, just like what ftrace
> do:
> 
> foo:
>     endbr
>     nop5  -->  call trampoline_foo
>     xxxx
> 
> In short, the trampoline_foo can be this:
> 
> trampoline_foo:
>     prepare a array and store the args of foo to the array
>     call fentry_bpf1
>     call fentry_bpf2
>     ......
>     call foo+4 (origin call)

Note, I brought up this issue when I first heard about how BPF does this.
The calling of the original function from the trampoline. I said this will
cause issues, and is only good for a few functions. Once you start doing
this for 1000s of functions, it's going to be a nightmare.

Looks like you are now in the nightmare phase.

My argument was once you have this case, you need to switch over to the
kretprobe / function graph way of doing things, which is to have a shadow
stack and hijack the return address. Yes, that has slightly more overhead,
but it's better than having to add all theses hacks.

And function graph has been updated so that it can do this for other users.
fprobes uses it now, and bpf can too.

>     save the return value of foo
>     call fexit_bpf1 (this bpf can get the return value of foo)
>     call fexit_bpf2
>     .......
>     return to the caller of foo
> 
> We can see that the trampoline_foo can be only used for
> the function foo, as different kernel function can be attached
> different BPF programs, and have different argument count,
> etc. Therefore, we have to create 1000 BPF trampolines if
> we want to attach a BPF program to 1000 kernel functions.
> 
> The creation of the BPF trampoline is expensive. According to
> my testing, It will spend more than 1 second to create 100 bpf
> trampoline. What's more, it consumes more memory.
> 
> If we have the per-function metadata supporting, then we can
> create a global BPF trampoline, like this:
> 
> trampoline_global:
>     prepare a array and store the args of foo to the array
>     get the metadata by the ip
>     call metadata.fentry_bpf1
>     call metadata.fentry_bpf2
>     ....
>     call foo+4 (origin call)

So if this is a global trampoline, wouldn't this "call foo" need to be an
indirect call? It can't be a direct call, otherwise you need a separate
trampoline for that.

This means you need to mitigate for spectre here, and you just lost the
performance gain from not using function graph.


>     save the return value of foo
>     call metadata.fexit_bpf1 (this bpf can get the return value of foo)
>     call metadata.fexit_bpf2
>     .......
>     return to the caller of foo
> 
> (The metadata holds more information for the global trampoline than
> I described.)
> 
> Then, we don't need to create a trampoline for every kernel function
> anymore.
> 
> Another beneficiary can be ftrace. For now, all the kernel functions that
> are enabled by dynamic ftrace will be added to a filter hash if there are
> more than one callbacks. And hash lookup will happen when the traced
> functions are called, which has an impact on the performance, see
> __ftrace_ops_list_func() -> ftrace_ops_test(). With the per-function
> metadata supporting, we can store the information that if the callback is
> enabled on the kernel function to the metadata, which can make the performance
> much better.

Let me say now that ftrace will not use this. Looks like too much work for
little gain. The only time this impacts ftrace is when there's two
different callbacks tracing the same function, and it only impacts that
function. All other functions being traced still call the appropriate
trampoline for the callback.

-- Steve

> 
> The per-function metadata storage is a basic function, and I think there
> may be other functions that can use it for better performance in the feature
> too.
> 
> (Hope that I'm describing it clearly :/)


