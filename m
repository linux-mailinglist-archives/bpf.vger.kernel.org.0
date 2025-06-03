Return-Path: <bpf+bounces-59484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07C0ACBF65
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 06:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997A416F480
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6AD1F3B97;
	Tue,  3 Jun 2025 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smadgrr1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAB139B;
	Tue,  3 Jun 2025 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926584; cv=none; b=WTDXsCvyx2lnxAuymOib4BdLhMaRY6fVOxc9Kds5TqgTDNeChFqzOf0zvKSevDxojJ93CrzQEfqqXHhQSGjb/CbAwK2t0IzSEkziPpfFOnPVBA1/a3deNGbGYmjasX3ZD/sA2sXQIpM3NKHxMPZ0l4LyAdm7YvolkOUpIdVEjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926584; c=relaxed/simple;
	bh=Igko4L0daaGgQYSXk1QMDHStz33o8RX9bl/FJAt5rrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqO2QQ2rK4OzLbp+L/ymOl9n0/Lg+IKvfWjLuZYOQ1yAtmL7gJe17H+PsmSub+kMPh2nlpzD2Trt5sLAPiW+rl+K8nCKdJ0yqCQuQUoQOowm3fNItZgzrg44kVN3F4aB2PJBFXdPTicB15XeAnOLtJ/DiR+nZ2CUnkZH/1ErSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smadgrr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D43DC4CEED;
	Tue,  3 Jun 2025 04:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748926583;
	bh=Igko4L0daaGgQYSXk1QMDHStz33o8RX9bl/FJAt5rrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Smadgrr1nY59GEmxpD9U1p+n0bwgct9dFGKJGj8L7jV4VMEu4BuyeHzvwOrzbjRHk
	 V9VRusdDv41egiT+JUW5gPxhFbsOU5zXHjIBTZLTAU44QBmZ54ARbJ5n64/XjBAqNn
	 eTMFIiQ5L80X84zNkbas5uP71dkq60l2khd4xtRNYuKC3LOIPJMkUTMUAl37DmiMXy
	 4exQY7aSw4WGM4Up4Pn8r+2YqzdUf+srcf/H8B/0eJBTPUfXI7n3XUprl0Folz7RkY
	 NcD0GCUihuZlH+9nBcm6yfFyiElw2636XGf0avtwWhHvmfRBR0Q5Hf1WvYv3qZBpmt
	 va4yxOCL3CwQg==
Date: Mon, 2 Jun 2025 21:56:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Howard Chu <howardchu95@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
Message-ID: <aD6AdQRLNNGhwRSe@google.com>
References: <20250529065537.529937-1-howardchu95@gmail.com>
 <aDpBTLoeOJ3NAw_-@google.com>
 <CAH0uvojGoLX6mpK9wA1cw-EO-y_fUmdndAU8eZ1pa70Lc_rvvw@mail.gmail.com>
 <20250602181743.1c3dabea@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250602181743.1c3dabea@gandalf.local.home>

Hi Steve,

On Mon, Jun 02, 2025 at 06:17:43PM -0400, Steven Rostedt wrote:
> On Fri, 30 May 2025 17:00:38 -0700
> Howard Chu <howardchu95@gmail.com> wrote:
> 
> > Hello Namhyung,
> > 
> > On Fri, May 30, 2025 at 4:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > (Adding tracing folks)  
> > 
> > (That's so convenient wow)
> 
> Shouldn't the BPF folks be more relevant. I don't see any of the tracing
> code involved here.

Yep, they are CC'ed too.  And sorry I thought you are involved in this
part of the code.

> 
> > 
> > >
> > > On Wed, May 28, 2025 at 11:55:36PM -0700, Howard Chu wrote:  
> > > > perf trace utilizes the tracepoint utility, the only filter in perf
> > > > trace is a filter on syscall type. For example, if perf traces only
> > > > openat, then it filters all the other syscalls, such as readlinkat,
> > > > readv, etc.
> > > >
> > > > This filtering is flawed. Consider this case: two perf trace
> > > > instances are running at the same time, trace instance A tracing
> > > > readlinkat, trace instance B tracing openat. When an openat syscall
> > > > enters, it triggers both BPF programs (sys_enter) in both perf trace
> > > > instances, these kernel functions will be executed:
> > > >
> > > > perf_syscall_enter
> > > >   perf_call_bpf_enter
> > > >     trace_call_bpf
> 
> This is in bpf_trace.c (BPF related, not tracing related).
 
Ok, noted.

Thanks,
Namhyung

> 
> > > >       bpf_prog_run_array
> > > >
> > > > In bpf_prog_run_array:
> > > > ~~~
> > > > while ((prog = READ_ONCE(item->prog))) {
> > > >       run_ctx.bpf_cookie = item->bpf_cookie;
> > > >       ret &= run_prog(prog, ctx);
> > > >       item++;
> > > > }
> > > > ~~~
> > > >
> > > > I'm not a BPF expert, but by tinkering I found that if one of the BPF
> > > > programs returns 0, there will be no tracepoint sample. That is,
> > > >
> > > > (Is there a sample?) = ProgRetA & ProgRetB & ProgRetC
> > > >
> > > > Where ProgRetA is the return value of one of the BPF programs in the BPF
> > > > program array.
> > > >
> > > > Go back to the case, when two perf trace instances are tracing two
> > > > different syscalls, again, A is tracing readlinkat, B is tracing openat,
> > > > when an openat syscall enters, it triggers the sys_enter program in
> > > > instance A, call it ProgA, and the sys_enter program in instance B,
> > > > ProgB, now ProgA will return 0 because ProgA cares about readlinkat only,
> > > > even though ProgB returns 1; (Is there a sample?) = ProgRetA (0) &
> > > > ProgRetB (1) = 0. So there won't be a tracepoint sample in B's output,
> > > > when there really should be one.  
> > >
> > > Sounds like a bug.  I think it should run bpf programs attached to the
> > > current perf_event only.  Isn't it the case for tracepoint + perf + bpf?  
> > 
> > I really can't answer that question.
> > 
> > >  
> > > >
> > > > I also want to point out that openat and readlinkat have augmented
> > > > output, so my example might not be accurate, but it does explain the
> > > > current perf-trace-in-parallel dilemma.
> > > >
> > > > Now for augmented output, it is different. When it calls
> > > > bpf_perf_event_output, there is a sample. There won't be no ProgRetA &
> > > > ProgRetB... thing. So I will send another RFC patch to enable
> > > > parallelism using this feature. Also, augmented_output creates a sample
> > > > on it's own, so returning 1 will create a duplicated sample, when
> > > > augmented, just return 0 instead.  
> > >
> > > Yes, it's bpf-output and tracepoint respectively.  Maybe we should
> > > always return 1 not to drop syscalls unintentionally and perf can
> > > discard duplicated samples.  
> > 
> > I like this.
> > 
> > >
> > > Another approach would be return 0 always and use bpf-output for
> > > unaugmented syscalls too.  But I'm afraid it'd affect other perf tools
> > > using tracepoints.  
> > 
> > Yep.
> > 
> > >  
> > > >
> > > > Is this approach perfect? Absolutely not, there will likely be some
> > > > performance overhead on the kernel side. It is just a quick dirty fix
> > > > that makes perf trace run in parallel without failing. This patch is an
> > > > explanation on the reason of failures and possibly, a link used in a
> > > > nack comment.  
> > >
> > > Thanks for your work, but I'm afraid it'd still miss some syscalls as it
> > > returns 0 sometimes.  
> > 
> > My bad... For example this:
> > 
> > if (pid_filter__has(&pids_filtered, getpid()))
> >    return 0;
> > 
> > This patch is practically meaningless, but it passes the parallel tests.
> > 
> > Thanks,
> > Howard
> 

