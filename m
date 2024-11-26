Return-Path: <bpf+bounces-45615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2D89D9384
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 09:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA71CB245A8
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA91A2C04;
	Tue, 26 Nov 2024 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j04hBOGa"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA017BA0;
	Tue, 26 Nov 2024 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610781; cv=none; b=nATlD/asa0PcJ2svTr7vPW1619PvmY0opOKfY9TIdlHoVWRt2hhStm5dOMT/BlyXe7RK1wT+4YEhtZ+Z019ajQh/uvmHbSbxZVB72apKf7kJStr8bwll5G6JIcIr0pTmdGYynrOoSG1yTfPeBzw785c+zm+wBjXhap/TxE3bY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610781; c=relaxed/simple;
	bh=P/73mi7h9ycpq8mYG3yiCW8bhPS08V1hedn0vA5rBj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMXnaQX6ptzb3X7Znxfa87Vwn43hT+0Jdfxw4EBq+TtkUuZnbphQ3Vws1fTS3HkL4jqaMvZbgq7BVkbJDQR2W8fZg/p3jrV0GR676zPwBBB0rLSPSh8wljJoBdhlzsltyc0GtVcwcc9nQnvYv1QsScaDh8STNxS/667b9FAgZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j04hBOGa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bIpYVnktOJf0cyRhIrhtQQqof4u4G/r3xTrDfyfu+IU=; b=j04hBOGaxjK4CwcmeIkgiV/sUM
	Rf+5n3/HwuCkyjGzSJEPEOoK/SFkOHMiZwhoNJh2qfMerB8qUkIeXvWHFlyneq30fsBp/AjZRWUqr
	Z7ZU+1vBHduwa6VOiI6nPgB9z3FRiprX6G5Cr9XkSiiJpdYGch9aqQdJ6YOKvdiUFxNEJzYgZehir
	Ewb1Z8GBuIDeQ40TaeCTqNpCuZ9GolOnYfgEzp67XsDS/FaFKzwsmCr4ucvDDV4T+qanQGnLqkvrA
	75r6gPL6JyrQ8eAmczkOz/egr/CIxhqWmmSVNelV8Sl6IWV6Xd2MGzzJP+oMhaXnXDVck+BngiYHo
	D1ZV9U8A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFrCm-0000000DJPH-0gUK;
	Tue, 26 Nov 2024 08:45:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8B8133002A2; Tue, 26 Nov 2024 09:45:56 +0100 (CET)
Date: Tue, 26 Nov 2024 09:45:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Jeanson <mjeanson@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Jordan Rife <jrife@google.com>, linux-trace-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from
 __DO_TRACE()
Message-ID: <20241126084556.GI38837@noisy.programming.kicks-ass.net>
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
 <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com>
 <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
 <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>

On Mon, Nov 25, 2024 at 09:51:43AM -0800, Linus Torvalds wrote:

> That said, I have a "lovely" suggestion. Instead of the "if(0)+goto"
> games, I think you can just do this:
> 
>   #define scoped_guard(_name, args...)                                   \
>          for (CLASS(_name, scope)(args), *_once = (void *)1; _once &&    \
>               (__guard_ptr(_name)(&scope) || !__is_cond_ptr(_name));     \
>               _once = NULL)
> 

Right, so that's more or less what we used to have:

#define scoped_guard(_name, args...)                                    \
        for (CLASS(_name, scope)(args), *done = NULL;			\
	     __guard_ptr(_name)(&scope) && !done; done = (void *)1)

But it turns out the compilers have a hard time dealing with this. From
commit fcc22ac5baf0 ("cleanup: Adjust scoped_guard() macros to avoid
potential warning"):	

    int foo(struct my_drv *adapter)
    {
            scoped_guard(spinlock, &adapter->some_spinlock)
                    return adapter->spinlock_protected_var;
    }

Using that (old) form results in:

    error: control reaches end of non-void function [-Werror=return-type]


Now obviously the above can also be written like:

    int foo(struct my_drv *adapter)
    {
            guard(spinlock)(&adapter->some_spinlock);
	    return adapter->spinlock_protected_var;
    }

But the point is to show the compilers get confused. Additionally Dan
Carpenter noted that smatch has a much easier time dealing with the new
form.

And the commit notes the generated code is actually slighly smaller with
e new form too (probably because the compiler is less confused about
control flow).

Except of course, now we get that dangling-else warning, there is no
winning this :-/

So I merged that patch because of the compilers getting less confused
and better code-gen, but if you prefer the old one we can definitely go
back. In which case we should go talk to compiler folks to figure out
how to make it not so confused.


