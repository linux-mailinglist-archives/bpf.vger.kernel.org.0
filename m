Return-Path: <bpf+bounces-78628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C877D15873
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 23:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12737302CF43
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF86342CA7;
	Mon, 12 Jan 2026 22:08:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD4308F28;
	Mon, 12 Jan 2026 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255680; cv=none; b=lo/gureo4hIraqSz6vT4IHKc5CEzlX79gBBt5EK3rYzQw+aGaOQY8JsPXOfhlXANtIIkycEsyo52H/f572DG0FZdCGBrtQxlgQ/EoiPcPpsPnxjvYa1ulvZAepT+/kvEOwSeRC4F0iGpMuuiAeVKV/KIJx+lUa03bNsT/w2egbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255680; c=relaxed/simple;
	bh=+UjQz9fVCtymINENlqbG9LLKzP+BGLHYWu/DHfDV1s0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKf9HeZvGoBvCjfYGr0cD//bnjHsKusrj1UEWUW+Crrw1wlJT7OVcsmVoeb9Wn2I5FsfRhLTbpb0dpe05w/Q6Vb48QBjUH4K6BFcskzHuoD1Qwo4YqnuHjVZbp/LwK7ccL0htpLkKluyyDyBb9KiNMViMIrtpVR5lVYkFx9Jjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id C39E08D8B3;
	Mon, 12 Jan 2026 22:07:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 6F09E20011;
	Mon, 12 Jan 2026 22:07:54 +0000 (UTC)
Date: Mon, 12 Jan 2026 17:07:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Mahe Tardy <mahe.tardy@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi
 program stack unwind to hw_regs path
Message-ID: <20260112170757.4e41c0d8@gandalf.local.home>
In-Reply-To: <20260112214940.1222115-3-jolsa@kernel.org>
References: <20260112214940.1222115-1-jolsa@kernel.org>
	<20260112214940.1222115-3-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F09E20011
X-Stat-Signature: 4qmkiuawmujaomcb31syana7sjo61frk
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+l+CYocrguA66UrT84NPwE7OJ5h+Sb2B0=
X-HE-Tag: 1768255674-610261
X-HE-Meta: U2FsdGVkX1+cAYCjYuYef1BHykeqmeQt4IShM2V0cmFaA7mUD+hoF4pvrfNshgXPbq0xrgX3oDGxi+A7Wzpg70GHzXVoef/N5fZybTKHRFeFY2eJshv3bEE4ccsbHV5Oexyt+iJ6dctgDK1C9HifTV9g+wd/KrdRAeIagA1o54h2nDKg2ROP54r1BO9F23Qe7Vzl7KRDqj04+n5PL+iSBFNM6YkWzTV6Z33Y7l2ZShYLZLtPfM0JJZYi2nXJohGN8p7nzJmzY+Td3qJeV3boI6D16hw8ZqCdeH4gnqM+1yQ3wRTR7+llDHh+j4EyJgXiWF7AIoeksHUPtCP35yLuWfo/qzpOAlB8bGsr0Xqx4lp9DCWu/dF4sQ==

On Mon, 12 Jan 2026 22:49:38 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> To recreate same stack setup for return probe as we have for entry
> probe, we set the instruction pointer to the attached function address,
> which gets us the same unwind setup and same stack trace.
> 
> With the fix, entry probe:
> 
>   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
>   Attaching 1 probe...
> 
>         __x64_sys_newuname+9
>         do_syscall_64+134
>         entry_SYSCALL_64_after_hwframe+118
> 
> return probe:
> 
>   # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
>   Attaching 1 probe...
> 
>         __x64_sys_newuname+4
>         do_syscall_64+134
>         entry_SYSCALL_64_after_hwframe+118

But is this really correct?

The stack trace of the return from __x86_sys_newuname is from offset "+4".

The stack trace from entry is offset "+9". Isn't it confusing that the
offset is likely not from the return portion of that function?

-- Steve


> 
> Fixes: 6d08340d1e35 ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"")
> Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

