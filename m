Return-Path: <bpf+bounces-30577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA1F8CEE5C
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 11:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C0E1F217E4
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 09:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B571F92F;
	Sat, 25 May 2024 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYJtmxYW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46C2F34;
	Sat, 25 May 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716630260; cv=none; b=awdXoCI0v1esZ1T3zOZsOsD3lo1B4Y32tXtIfMFdR1enysVJ5PE4SGPFb0tTCtXWQ+7zwjjgDqM5108hDI4bqrGThCZnmJ0GIW5tuHzB2J/kq26F8dIwGWy0PQbeoBTP1oQUKtm6H24zP7RY0zVipvswuS4dpuUZjtlsLoT8Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716630260; c=relaxed/simple;
	bh=QGYXWnMmAcQH0S/ZvqQBsiamdeIE/ZeX9XXDq5EIp1E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EyzMKSLe0WxVG3JMvbCi/Z5cNziReUdOzm7GUaLAGtBRg+aji7SUmHvwAYQeY2g2/Wc+qvNheAfqaM1yE/opluVlBHV6eicy5/wXUG9tRXPHqH2YdXYcxgojXVwqwU8JApJkA8qZP295XbiaXxrTO43fUb5Dyub1SouwUaVKeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYJtmxYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36434C2BD11;
	Sat, 25 May 2024 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716630260;
	bh=QGYXWnMmAcQH0S/ZvqQBsiamdeIE/ZeX9XXDq5EIp1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tYJtmxYWb1A3mWtjziwqmuClDOKboe4NvqQSW2Em2UQ7N1C0cLwKsZToXZhnZ7Ufb
	 cxr7E774rEquqweViWpdww1fOcmdaQTweNZqurH1wFdCIQpY04HRklB82qBtpjUFUC
	 7Bv4ITZaO40Iwt3PgkbPitUGQIsNjKjknWkHeZfRTSOYwVEA0rYViVHV0NEfoS05My
	 KrLIJwXaKJeGT438WAr+qF/H2PAqlLKOnvLxIXmbFd2JYJp5pDviUCjfwjbgEcIg4c
	 U+Zg3D9CXUP9XdiXBwZjUyfMrWRnH5862nbXxB/Owg0gVQ09bTmoO9MI44kCOjiGhR
	 U8K6OkeH8t/4Q==
Date: Sat, 25 May 2024 18:44:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v10 07/36] function_graph: Allow multiple users to
 attach to function graph
Message-Id: <20240525184414.a9e1953e0a9cd390b3e75513@kernel.org>
In-Reply-To: <20240524213208.36f274c8@gandalf.local.home>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
	<171509096221.162236.8806372072523195752.stgit@devnote2>
	<20240524213208.36f274c8@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 21:32:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  7 May 2024 23:09:22 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -109,6 +244,21 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >  	if (!current->ret_stack)
> >  		return -EBUSY;
> >  
> > +	/*
> > +	 * At first, check whether the previous fgraph callback is pushed by
> > +	 * the fgraph on the same function entry.
> > +	 * But if @func is the self tail-call function, we also need to ensure
> > +	 * the ret_stack is not for the previous call by checking whether the
> > +	 * bit of @fgraph_idx is set or not.
> > +	 */
> > +	ret_stack = get_ret_stack(current, current->curr_ret_stack, &offset);
> > +	if (ret_stack && ret_stack->func == func &&
> > +	    get_fgraph_type(current, offset + FGRAPH_FRAME_OFFSET) == FGRAPH_TYPE_BITMAP &&
> > +	    !is_fgraph_index_set(current, offset + FGRAPH_FRAME_OFFSET, fgraph_idx))
> > +		return offset + FGRAPH_FRAME_OFFSET;
> > +
> > +	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
> > +
> >  	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
> 
> I'm trying to figure out what the above is trying to do. This gets called
> once in function_graph_enter() (or function_graph_enter_ops()). What
> exactly are you trying to catch here?

Aah, good catch! This was originally for catching the self tail-call case with
multiple fgraph callback on the same function, but it was my misread.
In later patch ([12/36]), we introduced function_graph_enter_ops() so that
we can skip checking hash table and directly pass the fgraph_ops to user
callback. I thought this function_graph_enter_ops() is used even if multiple
fgraph is set on the same function. In this case, we always need to check the
stack can be reused(pushed by other fgraph_ops on the same function) or not.
But as we discussed, the function_graph_enter_ops() is used only when only
one fgraph is set on the function (if there are multiple fgraphs are set on
the same function, use function_graph_enter() ), we are sure that 
ftrace_push_return_trace() is called only once on hooking the function entry.
Thus we don't need to reuse it.

> 
> Is it from this email:
> 
>   https://lore.kernel.org/all/20231110105154.df937bf9f200a0c16806c522@kernel.org/
> 
> As that's the last version before you added the above code.
> 
> But you also noticed it may not be needed, but triggered a crash without it
> in v3:
> 
>   https://lore.kernel.org/all/20231205234511.3839128259dfec153ea7da81@kernel.org/
> 
> I removed this code in my version and it runs just fine. Perhaps there was
> another bug that this was hiding that you fixed in later versions?

No problem. I think we can remove this block safely.

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

