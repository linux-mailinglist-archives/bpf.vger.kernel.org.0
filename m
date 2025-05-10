Return-Path: <bpf+bounces-57977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1379DAB23F4
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91241883FA4
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDF622370F;
	Sat, 10 May 2025 13:41:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A538385;
	Sat, 10 May 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884495; cv=none; b=ZWxiyzZi1jt8kh3TOeo4zHjKNmPIHumP2Yhm8RZeFJvWJSsKoz0qy6tgCrkiSlTmou6EvoXpCmlQg36f6lCvj0TAQOupkYwAuGucw6vMvjXtMUUqMxADD+FwmzKTom/4akNhEoocKYc/IwcrmxW0/sVQEyOm7tinE1uVvw0/SPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884495; c=relaxed/simple;
	bh=0epkuuuoWFD2aObVfM+VxV/4myz3KNE8tEiMvO76tGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWKgMX9Tl3PY6k+16xzwx5OD0zc9si4B5JINFgto8HCXJsJclnsbMooNXpUlI3BsF6qmw6Ohxl9nyUpGVS9n6r6vuPzfmepTc1cD6zofmmn3za4t1SBOSwfl2zHWI8m2jEnL1dpKxmhwjNiydH5sfIiNiXBXcKVBfg3VzAtwOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73624C4CEE2;
	Sat, 10 May 2025 13:41:32 +0000 (UTC)
Date: Sat, 10 May 2025 09:41:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v8 12/18] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <20250510094149.7e91736d@gandalf.local.home>
In-Reply-To: <CAEf4Bzb7MCv87ZEPXvH7APk9yvmtCWvuUO5ShEaLvz_DLfNqpw@mail.gmail.com>
References: <20250509164524.448387100@goodmis.org>
	<20250509165155.628873521@goodmis.org>
	<CAEf4Bzb7MCv87ZEPXvH7APk9yvmtCWvuUO5ShEaLvz_DLfNqpw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 May 2025 14:49:37 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > @@ -133,13 +135,15 @@ static void unwind_deferred_task_work(struct callback_head *head)
> >
> >         timestamp = info->timestamp;
> >
> > -       guard(mutex)(&callback_mutex);
> > -       list_for_each_entry(work, &callbacks, list) {
> > +       idx = srcu_read_lock(&unwind_srcu);  
> 
> nit: you could have used guard(srcu)(&unwind_srcu) ?

Then it would be a scope_guard() as it is only needed for the list. I
prefer using guard() when it is most of the function that is being
protected. Here it's just the list and nothing else.

One issue I have with guard() is that it tends to "leak". That is, if you
use it to protect only one thing and then add more after what you are
protecting, then the guard ends up protecting more than it needs to.

If anything, I would make the loop into its own function with the guard()
then it is more obvious. But for now, I think it's fine as is, unless
others prefer the switch.

-- Steve

> 
> > +       list_for_each_entry_srcu(work, &callbacks, list,
> > +                                srcu_read_lock_held(&unwind_srcu)) {
> >                 if (task->unwind_mask & (1UL << work->bit)) {
> >                         work->func(work, &trace, timestamp);
> >                         clear_bit(work->bit, &current->unwind_mask);
> >                 }
> >         }
> > +       srcu_read_unlock(&unwind_srcu, idx);
> >  }
> >

