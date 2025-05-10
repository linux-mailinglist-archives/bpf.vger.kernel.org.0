Return-Path: <bpf+bounces-57978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58AFAB23F8
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574E34A699A
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F027C223339;
	Sat, 10 May 2025 13:46:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16F29D0E;
	Sat, 10 May 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884783; cv=none; b=tb5XpS/8zDyQgvauZJ4uw+0yXxQt6W7DbCmUJfykSimZFSuprwJscdRly3iVOzOywl5xeR+74T7Bhg3WYvmzrq2iZdmUs3c+Cwe5UyOy6oiWcWi37t4ISAIu3Zb6Ap5kRkbbxwMwGUxQ0bqfj0Sn++21wYtAilCc83fNzql3Qng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884783; c=relaxed/simple;
	bh=fjpKoWqdc3vCm/9VC/lrOl0V74WomSTGSztx/tIggqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkC9/hERXcWZkMQ+NlgJvD233FhvhKIQWSp8wrINgAiCZoED9N8VEjA5tRJMXP1SYSEI3lHD7LpQD/X5ZwoZmfQ44wPxORpcH6hqfGb6DJKzF9oMseRlDm1YHbnc2MT3tpE/yhP+WpDgVCu4yvSZYKOovJxYGTtN+oCNe7QrFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5762C4CEE2;
	Sat, 10 May 2025 13:46:21 +0000 (UTC)
Date: Sat, 10 May 2025 09:46:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v8 15/18] perf: Have get_perf_callchain() return NULL if
 crosstask and user are set
Message-ID: <20250510094638.27aa5f8b@gandalf.local.home>
In-Reply-To: <CAEf4BzaKfvCu2T+jJ2e-CCt0N50urfx+p6kQfV899_jkmT_XKQ@mail.gmail.com>
References: <20250509164524.448387100@goodmis.org>
	<20250509165156.135430576@goodmis.org>
	<CAEf4BzaKfvCu2T+jJ2e-CCt0N50urfx+p6kQfV899_jkmT_XKQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 May 2025 14:53:38 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > @@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> >         struct perf_callchain_entry_ctx ctx;
> >         int rctx, start_entry_idx;
> >
> > +       /* crosstask is not supported for user stacks */
> > +       if (crosstask && user)
> > +               return NULL;  
> 
> I think get_perf_callchain() supports requesting both user and kernel
> stack traces, and if it's crosstask, you can still get kernel (but not
> user) stack, if I'm reading the code correctly.
> 
> So by just returning NULL early you will change this behavior, no?

Basically you are saying that one could ask for a kernel/user stack trace
with crosstask enabled and still just get the kernel trace?

If this is the case, then I think it may be best to remove patches 15-18
from this series and work on them in the "perf specific" series, as this
doesn't have anything to do with the unwind infrastructure itself.

Actually, patch 14 doesn't either, so I may move that one too (and keep the
acks to it).

Thanks,

-- Steve


> 
> > +
> >         entry = get_callchain_entry(&rctx);
> >         if (!entry)
> >                 return NULL;

