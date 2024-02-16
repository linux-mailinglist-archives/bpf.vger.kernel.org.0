Return-Path: <bpf+bounces-22154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A1857F33
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 15:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E751F22888
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1D612CDBD;
	Fri, 16 Feb 2024 14:23:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8612CD81;
	Fri, 16 Feb 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093386; cv=none; b=gfKRkBq7O9kDY+5cPI9d6QEjYEAUwf9bl1Csk5DOzUZSnetZjywoAj6Tv07s/Cjtt8BGL90o18IrfdrZWAQ8plsuuMDVfdtZlA6TLTxlTx5W61D/rBr++6D1p5tUiXuf+ulwPcxHcMFzLUWLReCZ6sKdh9KUMSbFJqs1CKnq9cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093386; c=relaxed/simple;
	bh=3uVqjCq21IDwouamDzcl8wNTz0tAsFTEz5ibWpWf16g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fW3PdSTsenxBsYkffNFWJRkWzx2LcolocrRYveKLV4SZMXHWEKYqAGHd1mbBkhNTsDAMOtAASj9RGICt1zOwq5AO1eDA0+xhqQI50ACFuA0AOaP3nJIQ85mNW4HAT5AsvoJ8dkAkeGwizgHdLAkTqP3ocpweh1ZP+TOxC8K4CSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E4EC433C7;
	Fri, 16 Feb 2024 14:23:04 +0000 (UTC)
Date: Fri, 16 Feb 2024 09:24:39 -0500
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
Subject: Re: [PATCH v7 28/36] tracing: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-ID: <20240216092439.197072a5@gandalf.local.home>
In-Reply-To: <20240216220902.a3e017e72273c7894bfe6b16@kernel.org>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723236068.502590.9568421023325291255.stgit@devnote2>
	<20240215111134.7bfd1408@gandalf.local.home>
	<20240216220902.a3e017e72273c7894bfe6b16@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 22:09:02 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 15 Feb 2024 11:11:34 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed,  7 Feb 2024 00:12:40 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >   
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> > > If the architecture defines its own ftrace_regs, this copies partial
> > > registers to pt_regs and returns it. If not, ftrace_regs is the same as
> > > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.  
> > 
> > This says what this patch is doing and not why it is doing it.  
> 
> Hmm, OK. The reason is the eBPF needs this to keep the same pt_regs
> interface to access registers.
> Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
> used by kprobe_multi eBPF event), this will be required.
> I'll add this to next version.

Thanks, that should go into the change log.

-- Steve

