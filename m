Return-Path: <bpf+bounces-64863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADBFB17ABC
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 03:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60CA3B33A9
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFC078F5D;
	Fri,  1 Aug 2025 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN8YOyx2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA4224D6;
	Fri,  1 Aug 2025 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754010711; cv=none; b=p+TCVfXEEIeekUmspnzRNeBYGSNnWxJJbvCDkLLYhOlxYrhZp9VkWmru/vI59m2HwXwi+0fm76vU16hLUzNyVE5ML2ykN6T0u2UGaaUQKYi/hUZvyNucmIZGbH8auMgjChWC0HM+whaRlbIl2/LqaoPYQXC1tdJ/JRTzrFEtBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754010711; c=relaxed/simple;
	bh=YV9Bekb3nRJvWiUStA1Mo4OC6Y4BeSo9oE0wxKzf1/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4IsqUdQgdmw5kZV6CUflk8H2MTCs/F5QWNP8k7N+frbELMR5/P4cU3M+JSyx5415l4wQAiHt0z9Viqn9fab6k+8IybSPOSnhUbUs/xCeckIlAlo/ARgxUTn70kmUUIAnBXfSdT77MVpeyaLAypFV7n9Pkl3ckbbMCbDr6IagC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN8YOyx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D12C4CEEF;
	Fri,  1 Aug 2025 01:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754010711;
	bh=YV9Bekb3nRJvWiUStA1Mo4OC6Y4BeSo9oE0wxKzf1/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rN8YOyx2OxFDyZmvIJapDZVmsdQj1ngKhCYcnxpr2fzl8KP1SZ8eLTgad++E8Ww2k
	 bZaV7ILZ03wqNzxNn1e3zUEEGLjGwncoolNzOWOLWD98fAj5wm32aVlq4QOqrJHv5R
	 hd1syiInW7CYyiyUmvUElcygn+n6dh2/6P3QY3SdMgu9GjJ9vjPeX7oIsbRKquPUhJ
	 IJsoiR1OvqehBkBJK78MmDSt5lO63TA5nLYbO+ZXUPH3+iRRjF4lFUA72D4xfaKSVq
	 L7zuCJyXo/6WEVjAuWF6RKu4O34ilChUhrV6+UnZ9ZQEeTT7xsO7cBE9VpjBoejDoL
	 2ZjgVDvZQJnvg==
Date: Thu, 31 Jul 2025 21:11:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v16 09/10] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <20250731211146.508d8387@batman.local.home>
In-Reply-To: <21c67d70-d8c2-4d6b-99d8-2de8f2966621@paulmck-laptop>
References: <20250729182304.965835871@kernel.org>
	<20250729182406.331548065@kernel.org>
	<21c67d70-d8c2-4d6b-99d8-2de8f2966621@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 17:29:44 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > @@ -281,10 +291,15 @@ void unwind_deferred_cancel(struct unwind_work *work)
> >  		return;
> >  
> >  	guard(mutex)(&callback_mutex);
> > -	list_del(&work->list);  
> 
> What happens if unwind_deferred_task_work() finds this item right here...

Should be fine.

> 
> > +	list_del_rcu(&work->list);  
> 
> ...and then unwind_deferred_request() does its WARN_ON_ONCE() check
> against -1 right here?

If unwind_deferred_request() is called after unwind_deferred_cancel()
then that's a bug. As both functions are called by the tracer. The
cancel() function is for the tracer to tell this infrastructure that
it's done with the deferred tracing. If it calls a request() function
after (or during) the call to cancel(), then it's a bug in the tracer.
The tracer is responsible for making sure it will not do any more
requests before calling the cancel() function.

But what the tracer can't do is to know if there's a pending request
still happening and this has to handle that.

> 
> Can't that cause UAF?
> 
> This is quite possibly a stupid question because I am not seeing where to
> apply this patch, so I don't know what other mechanisms might be in place.

Yeah, you were only Cc'd on this patch because it was the only one that
uses RCU. You can see the entire series here:

  https://lore.kernel.org/all/20250729182304.965835871@kernel.org/

Or in patchwork:

  https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=986813

-- Steve


> 
> > +	/* Do not allow any more requests and prevent callbacks */
> > +	work->bit = -1;
> >  
> >  	__clear_bit(bit, &unwind_mask);
> >  
> > +	synchronize_srcu(&unwind_srcu);
> > +
> >  	guard(rcu)();
> >  	/* Clear this bit from all threads */
> >  	for_each_process_thread(g, t) {

