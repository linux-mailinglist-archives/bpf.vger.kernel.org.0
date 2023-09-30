Return-Path: <bpf+bounces-11153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64BE7B3FA5
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 11:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 07373282012
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92587946F;
	Sat, 30 Sep 2023 09:14:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9A23AA;
	Sat, 30 Sep 2023 09:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3BDC433C7;
	Sat, 30 Sep 2023 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696065282;
	bh=IDH9i4ossG8fiz9uTqL/nI6nmle6vBA4f7lhXd87Uxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rm9SNykJQwdTVW6S+Rf801ssab1h5iVg8gzKgmoRtFEW4Gs155ybnm+rBuwmhe/wo
	 ItrleESvVOeL0vTQJuHBxCkj8xmEBUEOEZ0vkQ2MOmwnNrOpXHIXAni0aewiGrx6OZ
	 xqz/ajf48Q8tqaV6nFOwuUovw9OxlzKfu3rhwjT0vI1sR3aUmvKBmC3Fa233NAFHi5
	 p0epjZiJZ+tvH+uo3MTRZVjE9gbw5Rn+Cmu8I94npTDDhnx+OV8yiZg90Nt2a/iDHc
	 5JgNvnNXsyV9LE1MDj3pA/VQcAbLuJhxdr047t8cmFyKwNaQ/IYSKQ0kH7ecurl1lW
	 Io1hmHa9fALOg==
Date: Sat, 30 Sep 2023 18:14:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 00/12] tracing: fprobe: rethook: Use ftrace_regs
 instead of pt_regs
Message-Id: <20230930181435.6663ef5a6ad718548a1e414a@kernel.org>
In-Reply-To: <CAADnVQ+HCLx+QUE88uVxeBNYFY4D=2-HADOU1C_czT1S1sRHgA@mail.gmail.com>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
	<20230929102115.09c015b9af03e188f1fbb25c@kernel.org>
	<CAADnVQ+HCLx+QUE88uVxeBNYFY4D=2-HADOU1C_czT1S1sRHgA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 29 Sep 2023 17:12:07 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Sep 28, 2023 at 6:21 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> >
> > Thus, what I need is to make fprobe to use function-graph tracer's shadow
> > stack and trampoline instead of rethook. This may need to generalize its
> > interface so that we can share it between fprobe and function-graph tracer,
> > but we don't need to involve rethook and kretprobes anymore.
> 
> ...
> 
> > And need to add patches
> >
> >  - Introduce a generized function exit hook interface for ftrace.
> >  - Replace rethook in fprobe with the function exit hook interface.
> 
> you mean that rethook will be removed after that?

No, it is too late. rethook is deeply integrated with kretprobe.
So when we remove the kretprobe, rethook will be removed too.
(fprobe and kretprobe provides similar functionality, so we can
move to fprobe)

Even though, objpool(*) itself might be kept for some other use
cases. As far as I can see, ftrace_ret_stack can not provide a context
local storage between entry -> exit callbacks. (so this feature must
be dropped from fprobe)

(*) https://lore.kernel.org/all/20230905015255.81545-1-wuqiang.matt@bytedance.com/

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

