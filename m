Return-Path: <bpf+bounces-22148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE5857D3A
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 14:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9D71F2867A
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549C129A60;
	Fri, 16 Feb 2024 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7rZNJaT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E771292E1;
	Fri, 16 Feb 2024 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088949; cv=none; b=auhNdDsQc0VC1XRU4aHjl4raxGeL1GgrbuCNVUzPXIlzoUWfGZPIgmxhG8ZhUpNWRvyS7PITMquICDnJNPkJlDBpSzHJ68qKPnXCou23lMHBwwPp4n8hqeTS3Yb5OgrmKgP7euaF0Tmqq+8HEIFxYVQ3fMl/f3qo7fHOPk5AJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088949; c=relaxed/simple;
	bh=l8eCqc2JVcjsz5LHB1HzzSEipUgWfbwHM1DKBGV0Mag=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=myjqY+1jOj3nFtpsvt4jmq0ZNXBrEjN9wFaKdf1BHg3SD64qyaV+myzWuM5plOnQ7N99EI7GwHgW32V9cZm6lLsTviQS0sTpIqGjUlcsr5/KG5OtnoNMMQen3+6ybiS/gvbscY2qPmrpj6J7jmXTsCEBlfLMdN8e2D3Mv/1JnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7rZNJaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290ECC433F1;
	Fri, 16 Feb 2024 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708088949;
	bh=l8eCqc2JVcjsz5LHB1HzzSEipUgWfbwHM1DKBGV0Mag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L7rZNJaT0LSM48DjcsT2GoEPR/VxZh5AiCWZsMQoROcsVrSQyPnv/YPtg+i+51AWS
	 Q5gThd7KO8qcfOoycu35RaSknWOG0wcTwssxGAizMh+Wt7zSakSZ1YSd9F04qIzcye
	 Wc8N+rFTfLtDdseI9FiHNjCf7q7rRLgAida3qAOFuvExSI7xd9FUqnYUEOJ5C0G+Oz
	 /Z4398F/UG2VAiWkFaqlxTHXCWdD5Zyx0qjTpzOlo7RobwFzS5Gfg5SS+JFu/Pabys
	 8itdtPqRv1l6iE3aQcUX0XiIU5GNQ55naTLylwXA+TMKroB9CQRcXDolCY/b7gKeJy
	 YHesa2RASoMFw==
Date: Fri, 16 Feb 2024 22:09:02 +0900
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
Subject: Re: [PATCH v7 28/36] tracing: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-Id: <20240216220902.a3e017e72273c7894bfe6b16@kernel.org>
In-Reply-To: <20240215111134.7bfd1408@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723236068.502590.9568421023325291255.stgit@devnote2>
	<20240215111134.7bfd1408@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 11:11:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Feb 2024 00:12:40 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> > If the architecture defines its own ftrace_regs, this copies partial
> > registers to pt_regs and returns it. If not, ftrace_regs is the same as
> > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> 
> This says what this patch is doing and not why it is doing it.

Hmm, OK. The reason is the eBPF needs this to keep the same pt_regs
interface to access registers.
Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
used by kprobe_multi eBPF event), this will be required.
I'll add this to next version.

Thanks,

> 
> -- Steve
> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Florent Revest <revest@chromium.org>
> > ---
> >  Changes from previous series: NOTHING, just forward ported.
> > ---


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

