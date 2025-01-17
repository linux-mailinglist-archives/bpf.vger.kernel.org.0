Return-Path: <bpf+bounces-49151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8F6A14783
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 02:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D94116680A
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664292EAF7;
	Fri, 17 Jan 2025 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bqy00K6L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D113138DE3;
	Fri, 17 Jan 2025 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076994; cv=none; b=IBr23jgdYbdOdKVGkklSEv2jmhkl5GpS0ziTnS9zKeZFkZFyvi7ocA4YfwptDMNmxoxmC8OZA22ZYOrjTM6fA9M2yFhm4wPvw01aoEEnbarIOdAHB+VzX/OkO5RPVtTWPi8cFdJqp1D2i0Lq7pcDwX/tliYyMBPPifgqSCrFj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076994; c=relaxed/simple;
	bh=wIT9IZfUMJtxKYEmAWkkr+Vs51mMi8q9ct0lyYCDvHM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ivk8qeRtCqCJi9w7tKBUj7FukQgjdFxML/WK/Hwv0ezEXDWFmwDsRTHGNNZHYp4d3vwLcwtoxFGspTrVfRPAdpiqAFEHERPddtRaq2Bm+Z+PFjyHGnrWVFrdL1HOlgZioLdGCNPw6uyH85e8t2VQslBTVhLuxqtJXiU6aQMwa98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bqy00K6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E20C4CED6;
	Fri, 17 Jan 2025 01:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737076992;
	bh=wIT9IZfUMJtxKYEmAWkkr+Vs51mMi8q9ct0lyYCDvHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bqy00K6LyPPhuy2uJt4sFf345HeojZCIcneZ6fg38dC+fjoOsdtRXBRckRPRJrdVo
	 JYefeOgjfNFPSw7JRdZRqyCc2Ke5cgCL7htPX2FBawI6usbxUXXeIltvAOSpV7vvqz
	 +m2Lbvhl3IGH/1xGLC6TtSk3wu1c6jj4MlWDpZ+qmIuoy5t/C/r7S67IzKw0LBfC19
	 xwynJyxWDRlSkzng7lEjHbkk4CtxSH0eplm24itSCbgty7fjhqDueVh1cf6p4BOxzk
	 aZQmTc0/B6NEhE7cA9xp6TuZSPS43QxOdEWej0pER8qn9BYdedGQA9fwyrFD9baaXT
	 lStJC1nfAmZhg==
Date: Fri, 17 Jan 2025 10:23:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Aleksa Sarai <cyphar@cyphar.com>, Eyal Birger <eyal.birger@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, BPF-dev-list <bpf@vger.kernel.org>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John
 Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
 tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
 linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, "rostedt@goodmis.org"
 <rostedt@goodmis.org>, rafi@rbk.io, Shmulik Ladkani
 <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-Id: <20250117102307.cf919a0e7e59e3df0ddbcd3c@kernel.org>
In-Reply-To: <Z4Zy6W6z3ICp6SdJ@krava>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
	<20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
	<Z4K7D10rjuVeRCKq@krava>
	<Z4YszJfOvFEAaKjF@krava>
	<20250114190521.0b69a1af64cac41106101154@kernel.org>
	<20250114112106.GC19816@redhat.com>
	<Z4Zy6W6z3ICp6SdJ@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 15:21:29 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Tue, Jan 14, 2025 at 12:21:07PM +0100, Oleg Nesterov wrote:
> > On 01/14, Masami Hiramatsu wrote:
> > >
> > > On Tue, 14 Jan 2025 10:22:20 +0100
> > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > > @@ -418,6 +439,9 @@ SYSCALL_DEFINE0(uretprobe)
> > > >  	regs->r11 = regs->flags;
> > > >  	regs->cx  = regs->ip;
> > > >
> > > > +	/* zero rbx to signal trampoline that uretprobe syscall was executed */
> > > > +	regs->bx  = 0;
> > >
> > > Can we just return -ENOSYS as like as other syscall instead of
> > > using rbx as a side channel?
> > > We can carefully check the return address is not -ERRNO when set up
> > > and reserve the -ENOSYS for this use case.
> > 
> > Not sure I understand...
> > 
> > But please not that the uretprobed function can return any value
> > including -ENOSYS, and this is what sys_uretprobe() has to return.
> 
> right, uretprobe syscall returns value of the uretprobed function,
> so we can't use any reserved value

We can make uretprobe (entry) fail if the return value is one of
errno or NULL, because it *knows* what the return value here.

Thank you,

> 
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

