Return-Path: <bpf+bounces-71733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 363E2BFC8B2
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6344354154
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C8634FF66;
	Wed, 22 Oct 2025 14:28:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955233F8DC;
	Wed, 22 Oct 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143283; cv=none; b=WLGKtsxspshbEmP3Ru1k/9ki5P8YBE4I9wbTvX4i0i74RGW2qJlqS/T6PBduOUmWOibqZSqKKUGLu+EZW1YepO8GwJoGU/fuT/EKaQG9O8AgfG7VC04E7ErlcNrorNKp45M79tmcaujFEkU6KwYFrf3tMxjUjFaUQAvfTtulAOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143283; c=relaxed/simple;
	bh=2xGOWvo4ii83yOt9X6tjIYj4tuTGdBy0glwr7PkKXkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/N1E+L5jLbuWwh0jQS7mh5nXQFOYuyBv2zHF5fzBcZA+NP6WOWyz+oBaJMweRBlaubIgfP9t1PqawxldQOmUirBiZ9Cshaq2+91OSpuwDsacVzamEsjDA/oSOhiCIIxL5mzDLt94oTxG3WN1nS+fA+6WewfQzRNAkQSMGPxlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C5E0513B823;
	Wed, 22 Oct 2025 14:27:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 9672D2F;
	Wed, 22 Oct 2025 14:27:55 +0000 (UTC)
Date: Wed, 22 Oct 2025 10:28:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, andrii@kernel.org,
 bpf@vger.kernel.org, jpoimboe@kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 peterz@infradead.org, x86@kernel.org, yhs@fb.com
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <20251022102819.7675ee7a@gandalf.local.home>
In-Reply-To: <aPjO0yLCxPbUJP9r@krava>
References: <20251015121138.4190d046@gandalf.local.home>
	<20251022090429.136755-1-yangfeng59949@163.com>
	<aPjO0yLCxPbUJP9r@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4q7gbm3wtzdindmqqa3tx1oczef7fyss
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 9672D2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19f6Oq3d1+RMkArEQKCrrnwNBdel1/ZWEk=
X-HE-Tag: 1761143275-604607
X-HE-Meta: U2FsdGVkX1+etYEHLOLCcbCNWR+cr2aKfp3VDNklIdE3kjgei4HZKrskc3smMOpojSjRI8lP2Wk0ycSSbbA0Q0JvTYm10GuDRCDzkaUKEnTdWofVEXTTFdC7JMUg/CNAxV5/xmb0NOkRD/VqEoU0plWcHRxoRHz+zG7CWL40eaLztyRp4/h76mv4PituurS+5OPuOvX48x+MaxlSR75soDsPzVr1q5b1AqYe7eAPOEYnwKg3igSY9h0MqL26x/adN7DG2u8IJCwmtl6MWL/LpQQBxO/8OTKhKA5eNmgB92/q8PxFPiKPzi5TcWNpN+LKjv6cObH5yoKIuZFXEj6fg+tgSZ3ZJYjG

On Wed, 22 Oct 2025 14:32:19 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> thanks for the report.. so above is from arm?
> 
> yes the x86_64 starts with:
>   unwind_start(&state, current, NULL, (void *)regs->sp);
> 
> I seems to get reasonable stack traces on x86 with the change below,
> which just initializes fields in regs that are used later on and sets
> the stack so the ftrace_graph_ret_addr code is triggered during unwind
> 
> but I'm not familiar with this code, Masami, Josh, any idea?

Oh! This is an issue with a stack trace happening from a callback of the
exit handler?

OK, that makes much more sense. As I don't think the code handles that
properly.

> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 367da3638167..2d2bb8c37b56 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -353,6 +353,8 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
>  SYM_CODE_START(return_to_handler)
>  	UNWIND_HINT_UNDEFINED

I believe the above UNWIND_HINT_UNDEFINED means that if ORC were to hit
this, it should just give up.

This is because tracing the exit of the function really doesn't fit in the
normal execution paradigm.

The entry is easy. It's the same as if the callback was called by the
function being traced. The exit is more difficult because the function
being traced has already did its return. Now the callback is in this limbo
area of being called between a return and the caller.

>  	ANNOTATE_NOENDBR
> +	push $return_to_handler
> +	UNWIND_HINT_FUNC

OK, so what happened here is that you put in the return_to_handle into the
stack and told ORC that this is a normal function, and that when it
triggers to do a lookup from the handler itself.

I wonder if we could just add a new UNWIND_HINT that tells ORC to do that?

>  
>  	/* Save ftrace_regs for function exit context  */
>  	subq $(FRAME_SIZE), %rsp
> @@ -360,6 +362,9 @@ SYM_CODE_START(return_to_handler)
>  	movq %rax, RAX(%rsp)
>  	movq %rdx, RDX(%rsp)
>  	movq %rbp, RBP(%rsp)
> +	movq %rsp, RSP(%rsp)
> +	movq $0, EFLAGS(%rsp)
> +	movq $__KERNEL_CS, CS(%rsp)

Is this simulating some kind of interrupt?

>  	movq %rsp, %rdi
>  
>  	call ftrace_return_to_handler

Now it gets tricky in the ftrace_return_to_handler as the first thing it
does is to pop the shadow stack, which makes the return_to_handler lookup
different, as its no longer on the stack that the unwinder will use.

The return address will live in the "ret" variable of that function, which
the unwinder will not have access to. Yeah, this will not be easy to solve.

-- Steve


> @@ -368,7 +373,8 @@ SYM_CODE_START(return_to_handler)
>  	movq RDX(%rsp), %rdx
>  	movq RAX(%rsp), %rax
>  
> -	addq $(FRAME_SIZE), %rsp
> +	addq $(FRAME_SIZE) + 8, %rsp
> +
>  	/*
>  	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
>  	 * since IBT would demand that contain ENDBR, which simply isn't so for


