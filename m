Return-Path: <bpf+bounces-48776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01826A108A1
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA8E1882C2E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60031534FB;
	Tue, 14 Jan 2025 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sy44sGI3"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D614C5AE;
	Tue, 14 Jan 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863670; cv=none; b=YCn9X7+Rl94CurwsyKcQWDFJQ8wn0zeA/B3rM0e3fJCnc1oIzdbFee6YwmQq+1DQvOiS4jA92AyXFaLCmcIhgGWc0EetDKh7TatoZbHbF5ZMghFYhOad2ThGrXHh6Jh5uI1Q/aaiTZM2nxz8bDDiSBjFcXDONWSwOJ7ZjB7d0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863670; c=relaxed/simple;
	bh=x3HZ52JnGpNmOl2AsLimmIqSvIJPVzeNT96X9YEjjJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez3kcN4HyONcCAXyvC/rlQJLA4sV07osXIsrFAiKMZwLCdnU4QaXtVxSyRmCL6KQ6u6ahSQGzM8SPeVMGqVgmsJwtY7Ak9ECVUu3iqmQuzyzm1hxPns4ee0EouvzdKPV5VAoem4VDGjHFJopWCMGV8d0Xwc8hDiWbqb6oYOOLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sy44sGI3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VpmG8m+dTj+FMSiyZTtiB4JAm/QbZbCKXjyCc6K+NFM=; b=Sy44sGI3677yOp60i6Zn8UxdDb
	SQBG8HAy5t93gOwd8yzKa+r/vfoXqH4bz+XtfhXSmQIhf6UZ3DfJd++77r9HqsqrivaQUSsNQjhdQ
	mGd6PW0YKpKUyLvJYKUT6j7+mWwSouGCc8MmbMTgS7+o0k23MHYL5DJUW27CTX2QscVuzEi8dB+PP
	wMnNAI757Z6HdnWIWHjj2dAnaDqwAwihxbclt5SIRb07vZqVQIhITiSL75VamS6C/ATBgMEaekSJi
	0mLBDR2CJbdxSbKmGetBf6oBL8ysmL2CRI7rJbZfMImuiwFw8q2eVjGcx42s/6+Yng6PTm8K9EzBF
	NGf9MPrQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXhZq-0000000ASxi-32oe;
	Tue, 14 Jan 2025 14:07:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83C7B30063F; Tue, 14 Jan 2025 15:07:29 +0100 (CET)
Date: Tue, 14 Jan 2025 15:07:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, tglx@linutronix.de,
	bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250114140729.GQ5388@noisy.programming.kicks-ass.net>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114104215.GD8362@noisy.programming.kicks-ass.net>
 <20250114110149.GB19816@redhat.com>
 <20250114120235.GP5388@noisy.programming.kicks-ass.net>
 <20250114123257.GD19816@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114123257.GD19816@redhat.com>

On Tue, Jan 14, 2025 at 01:32:58PM +0100, Oleg Nesterov wrote:

> Sorry, I don't understand... Perhaps because I am enjoying my state after
> dentist appointment ;)

For some reason I thought to remember that parent thread would spawn
restricted child, however:

> OK, suppose we have
> 
> 	void start_SECCOMP_MODE_STRICT(void)
> 	{
> 		// in particular nacks __NR_uretprobe
> 		seccomp(SECCOMP_MODE_STRICT, ...);
> 	}
> 
> and we want to add uretprobe to this function.
> 
> In this case prepare_uretprobe() can't know that sys_uretprobe() won't
> work when this function returns?

Indeed. But any further probes placed after seccomp() would be able to,
and installing trampolines for them would be a waste, no?

