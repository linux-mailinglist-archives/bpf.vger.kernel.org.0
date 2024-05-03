Return-Path: <bpf+bounces-28506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD0A8BABA5
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 13:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C941F2244F
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C492A152788;
	Fri,  3 May 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EXuP307l"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A4152180;
	Fri,  3 May 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736111; cv=none; b=q2fLiPD8gEl/o91Ew48Pi8cLDB3S5CS7Lev/PI6M6/MRKuuQ+do3Z83IrYeXc7ehrzovpZbF6dlWZ3ZDsDi84dY168coxPuZNUJ60mx+ZGS8j5LrRCDhG5oGPwjNanQRMKLYS91MOl7oframZjFIr8dkGvfnzvXT8tPuTobH/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736111; c=relaxed/simple;
	bh=NGCnV/jwRUnhIBk4eqhuNe7GPUCIIScfqyZphbH1u3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC+Y8zT6rOAqVqaUCs+rPfz6UCXVZAQFfXBOtXxWJg480qGvRMsVsnlB6MOBSx33NM1VHA0dmH0764rarVpFZ0ygoNLODwz88zl1s6qB4d/Dz1KQQnQI0JeDm7SjiZEa5hqwzmkIuLagK2Nx/n8nhHMFihiM/gzYIsZKmGF0ONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EXuP307l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sxVQ/UPJFlyGRDmIkbFV8gUftaJHcE4mZegeO9XShts=; b=EXuP307lalwf/R+RmqAOGe5qq7
	fd0cZn6+STJkV0IVWQAvGai3Xv8VqeUTQDeTM+eLovrpsJdA9poPUUo9ixiHOuhGjF9pcTh0+BcBV
	5tY53XLfIFtG8bdHSl+1j9o/lYoG40IWQwJXh/T4LNo3GVaieoUX1gaYBiWvHUgUzv0coI0C1AwoQ
	FTHXpzpbryJZzYtmVfrCsQ/kB/mf/OJNoRS+FnZaKoFOmdQd1sQiDqi+9UOkh2/g1INakPnV9JkRg
	t1bIFnHXZ6bizin2WR/1+A43kT8i2CgTUPF7wwMczJZyPxRRftalTK75WgFLre8CBtjD9ChyoDKe3
	1nL5c0vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2rBl-00000003z6t-33bZ;
	Fri, 03 May 2024 11:34:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 62FD73001FD; Fri,  3 May 2024 13:34:53 +0200 (CEST)
Date: Fri, 3 May 2024 13:34:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <20240503113453.GK40213@noisy.programming.kicks-ass.net>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <20240502122313.1579719-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502122313.1579719-3-jolsa@kernel.org>

On Thu, May 02, 2024 at 02:23:08PM +0200, Jiri Olsa wrote:
> Adding uretprobe syscall instead of trap to speed up return probe.
> 
> At the moment the uretprobe setup/path is:
> 
>   - install entry uprobe
> 
>   - when the uprobe is hit, it overwrites probed function's return address
>     on stack with address of the trampoline that contains breakpoint
>     instruction
> 
>   - the breakpoint trap code handles the uretprobe consumers execution and
>     jumps back to original return address
> 
> This patch replaces the above trampoline's breakpoint instruction with new
> ureprobe syscall call. This syscall does exactly the same job as the trap
> with some more extra work:
> 
>   - syscall trampoline must save original value for rax/r11/rcx registers
>     on stack - rax is set to syscall number and r11/rcx are changed and
>     used by syscall instruction
> 
>   - the syscall code reads the original values of those registers and
>     restore those values in task's pt_regs area
> 
>   - only caller from trampoline exposed in '[uprobes]' is allowed,
>     the process will receive SIGILL signal otherwise
> 

Did you consider shadow stacks? IIRC we currently have userspace shadow
stack support available, and that will utterly break all of this.

It would be really nice if the new scheme would consider shadow stacks.

