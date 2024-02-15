Return-Path: <bpf+bounces-22084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA585669E
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 15:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E0DB22D08
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C813248E;
	Thu, 15 Feb 2024 14:56:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D220B3D;
	Thu, 15 Feb 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008967; cv=none; b=e5jSyOTwRfoTCnI/vLEa+MR/2jw3AX+VN+RA12/mOA6IqNgQ17HnXdcUPDIQ+ZDQi6hEcqCZnIM2WVyWJgMmKnKZLp8BbJJ/+CgnKwjqmhznZTGzbePKXx0BHFWzfVmQp0tuH9CvCr5tr1mK0o6T51E+6J/YvFjkmzHWpWfl9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008967; c=relaxed/simple;
	bh=nH02mRbEf+x2rpYZvYmd3xMiMm7jKKeDp+ZWKf4JDmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvAjG50/LZFPKq5AAPMa6FGRw6i2ZRjarBJ3zHWoN161HMdlhOM9Q/hGP62q9x7cK1eW2/3LHtvU8A3FuijNhUvaBpcabF67fZmKpkXlQ61lGxylUtSuPmEQpxgZtqNJxOW5kMRvyIWCY2K4VLaZdEVda/o4cIzQ1d+Evj2OxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853DAC433F1;
	Thu, 15 Feb 2024 14:56:05 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:57:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Message-ID: <20240215095739.41a2fac7@gandalf.local.home>
In-Reply-To: <170723227198.502590.10431025573751489041.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723227198.502590.10431025573751489041.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:11:12 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Improve push and data reserve operation on the shadow stack for
> several sequencial interrupts.
> 
> To push a ret_stack or data entry on the shadow stack, we need to
> prepare an index (offset) entry before updating the stack pointer
> (curr_ret_stack) so that unwinder from interrupts can find the
> next return address from the shadow stack. Currently we do write index,
> update the curr_ret_stack, and rewrite it again. But that is not enough
> for the case if two interrupts happens and the first one breaks it.
> For example,
> 
>  1. write reserved index entry at ret_stack[new_index - 1] and ret addr.
>  2. interrupt comes.
>     2.1. push new index and ret addr on ret_stack.
>     2.2. pop it. (corrupt entries on new_index - 1)
>  3. return from interrupt.
>  4. update curr_ret_stack = new_index
>  5. interrupt comes again.
>     5.1. unwind <------ may not work.

I'm curious if you saw this happen?

That is, did you trigger this or only noticed it by inspection?

This code is already quite complex, I would like to simplify it more before
we try to fix rare race conditions that only affect the unwinder.

Let's hold off on this change.

-- Steve


> 
> To avoid this issue, this introduces a new rsrv_ret_stack stack
> reservation pointer and a new push code (slow path) to commit
> previous reserved code forcibly.
> 
>  0. update rsrv_ret_stack = new_index.
>  1. write reserved index entry at ret_stack[new_index - 1] and ret addr.
>  2. interrupt comes.
>     2.0. if rsrv_ret_stack != curr_ret_stack, add reserved index
>         entry on ret_stack[rsrv_ret_stack - 1] to point the previous
> 	ret_stack pointed by ret_stack[curr_ret_stack - 1]. and
> 	update curr_ret_stack = rsrv_ret_stack.
>     2.1. push new index and ret addr on ret_stack.
>     2.2. pop it. (corrupt entries on new_index - 1)
>  3. return from interrupt.
>  4. update curr_ret_stack = new_index
>  5. interrupt comes again.
>     5.1. unwind works, because curr_ret_stack points the previously
>         saved ret_stack.
>     5.2. this can do push/pop operations too.
> 6. return from interrupt.
> 7. rewrite reserved index entry at ret_stack[new_index] again.
> 
> This maybe a bit heavier but safer.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

