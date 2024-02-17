Return-Path: <bpf+bounces-22217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8BC8590AE
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 16:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3D21F218D1
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FCC7CF09;
	Sat, 17 Feb 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHw1PLJv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B27B3CC;
	Sat, 17 Feb 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708185246; cv=none; b=LGREmAXrKkQ+75xEzivUm5btR12zkHtyvDLzx5uRbkBh4TN49y1TttazhMr9fBaqidrPI5d9hQJrhdXyShQhCdagr6p0jzG0BS4ij+ERzuRstZh/lHrJccdQ80CmdLCM4ftxuyYD8WGaKZ6DQMzTFE5mvi9N0Cm6MJc3suC03F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708185246; c=relaxed/simple;
	bh=yG8vscJnWU0ovGCkwuzXNoGwaH1DWcjjYwxNQHJgFCo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hFJfgpD67KMUoLrxPkjXoH0dl0HRd9zJVp5hAyBQlimnwpM7Y5Yrf7d9wqBdG6dPo91aCJwfYf2eJT7yrh74m3GhlaTJcKam+NkBfQ7gHNUv7yPHupXnKAViwrazTwm7rYA83umLEQyoMKFSvJ9whC7hGaUKn+nTvMluFHn93rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHw1PLJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0C5C433C7;
	Sat, 17 Feb 2024 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708185246;
	bh=yG8vscJnWU0ovGCkwuzXNoGwaH1DWcjjYwxNQHJgFCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AHw1PLJvhfjZhLGK5KHkBIVj+9XeG0/PyI3CH36/yDz5FeAFPcjq87whLIvrbE6rj
	 bwQOUkRIBYocELBbTrPp8Ys47/5ZB1h2vZPYOytZCoxea+gVWR4qlBj6CCvW9JmwGc
	 NhVPtYg43u+MX8Axj7Kby5CBdNL2KHEmsrxCi05hW22h7TpFh2MPu12ReyBJvTDG/M
	 5ff3BAlKcPp8Ya5WVMwFX8iv2hWxLr6rI4hpMf2tpmooememXcUqzpCAk5qInxOfBD
	 /ztSkHZnSJAAWlkpXvvgtAQcu/t4Ad48T536TuTATHL5XK4CbCEtOrak10v/jT0+c3
	 EJPC4KNSqf0Ww==
Date: Sun, 18 Feb 2024 00:53:59 +0900
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
Subject: Re: [PATCH v7 20/36] function_graph: Improve push operation for
 several interrupts
Message-Id: <20240218005359.7072c27c99bcfe426e2126b6@kernel.org>
In-Reply-To: <20240215095739.41a2fac7@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723227198.502590.10431025573751489041.stgit@devnote2>
	<20240215095739.41a2fac7@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 09:57:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Feb 2024 00:11:12 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Improve push and data reserve operation on the shadow stack for
> > several sequencial interrupts.
> > 
> > To push a ret_stack or data entry on the shadow stack, we need to
> > prepare an index (offset) entry before updating the stack pointer
> > (curr_ret_stack) so that unwinder from interrupts can find the
> > next return address from the shadow stack. Currently we do write index,
> > update the curr_ret_stack, and rewrite it again. But that is not enough
> > for the case if two interrupts happens and the first one breaks it.
> > For example,
> > 
> >  1. write reserved index entry at ret_stack[new_index - 1] and ret addr.
> >  2. interrupt comes.
> >     2.1. push new index and ret addr on ret_stack.
> >     2.2. pop it. (corrupt entries on new_index - 1)
> >  3. return from interrupt.
> >  4. update curr_ret_stack = new_index
> >  5. interrupt comes again.
> >     5.1. unwind <------ may not work.
> 
> I'm curious if you saw this happen?
> 
> That is, did you trigger this or only noticed it by inspection?

I just noticed this scenario while explaining why we write the same value
twice to Jiri.

https://lore.kernel.org/all/20231220004540.0af568c69ecaf9170430a383@kernel.org/

> 
> This code is already quite complex, I would like to simplify it more before
> we try to fix rare race conditions that only affect the unwinder.
> 
> Let's hold off on this change.

OK, then drop this until someone hits the actual problem, maybe that
should be rare case.

Thank you,

> 
> -- Steve
> 
> 
> > 
> > To avoid this issue, this introduces a new rsrv_ret_stack stack
> > reservation pointer and a new push code (slow path) to commit
> > previous reserved code forcibly.
> > 
> >  0. update rsrv_ret_stack = new_index.
> >  1. write reserved index entry at ret_stack[new_index - 1] and ret addr.
> >  2. interrupt comes.
> >     2.0. if rsrv_ret_stack != curr_ret_stack, add reserved index
> >         entry on ret_stack[rsrv_ret_stack - 1] to point the previous
> > 	ret_stack pointed by ret_stack[curr_ret_stack - 1]. and
> > 	update curr_ret_stack = rsrv_ret_stack.
> >     2.1. push new index and ret addr on ret_stack.
> >     2.2. pop it. (corrupt entries on new_index - 1)
> >  3. return from interrupt.
> >  4. update curr_ret_stack = new_index
> >  5. interrupt comes again.
> >     5.1. unwind works, because curr_ret_stack points the previously
> >         saved ret_stack.
> >     5.2. this can do push/pop operations too.
> > 6. return from interrupt.
> > 7. rewrite reserved index entry at ret_stack[new_index] again.
> > 
> > This maybe a bit heavier but safer.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

