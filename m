Return-Path: <bpf+bounces-48764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D03A1061B
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 13:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F61E1888844
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB2229614;
	Tue, 14 Jan 2025 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NtIlZqeX"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855E1ADC82;
	Tue, 14 Jan 2025 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856171; cv=none; b=VqpHXLLf5kfB6qqcv4VLWfYZsDPJ0xr/sXUM/wBuApeK1IW0FwgmFN9vVUUSzozVQHEg9yP0tmd2U5YoCB/gEH8FMeCX+7ef4LgvftctGuEaOLUjiScgcJ2SIzIE1oNQfAO1e03s/FwIBTiCkte9x/3RkRL8F/TBgFgkhgeeF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856171; c=relaxed/simple;
	bh=637wNzgSuIS+Zn874K8ghiEojfD+yCOKwXPNsi8RCPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8IeVNe5aKCXaeYp/xdeBxmgcTsxFpRhZtKvEFJHpY6lnx6UI1g328pgUUWW8L5kDfAHrseI1wsQ77V0YsPjimGBMCsp4XqpDwhkHKatL/vLRaInzUepYGQy/qUxGlCtmmPxmcEIht5jObAhce6PxZwFdKjT+lMev/vzhiGWvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NtIlZqeX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F4NMF9UahwUu1XEu+vXYS4BJ4r/g8g18XnHn1h1S5ls=; b=NtIlZqeX4Q9tTQBoMoSXaPcmdD
	ScHib+Lgc7FMzrtKsXtetMpeh5/wEqaG5Xjree8a+YoQirKwMJ77CI8Y3wFeXNW0N3rM5lozyRM4E
	5zOaQe/uIiSis0aWnYpJWRPEn9gUJ1dWXoNpSsM8mgjoc0XDw3N8O4BASero3+dpsAwJ2FulUXbVs
	xT5AS2eBWTg66w3NPxP86aeruvhpxQJhI6W7Sl4OpDqzPUN1PCY7UsfRXXq4CHro7btSdJDD7SdDx
	JOWfZZq7E6Hii0gLgFfXii0w4n+c2Xk1AN2yYyAeXnZUbbvc19294RsyaAcI31ikvt+xRMo3SgCZz
	0m7RBm/g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfcx-0000000F9Fq-43RC;
	Tue, 14 Jan 2025 12:02:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E973300346; Tue, 14 Jan 2025 13:02:35 +0100 (CET)
Date: Tue, 14 Jan 2025 13:02:35 +0100
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
Message-ID: <20250114120235.GP5388@noisy.programming.kicks-ass.net>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114104215.GD8362@noisy.programming.kicks-ass.net>
 <20250114110149.GB19816@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114110149.GB19816@redhat.com>

On Tue, Jan 14, 2025 at 12:01:50PM +0100, Oleg Nesterov wrote:
> On 01/14, Peter Zijlstra wrote:
> >
> > On Tue, Jan 14, 2025 at 10:22:20AM +0100, Jiri Olsa wrote:
> > >
> > > hack below seems to fix the issue, it's using rbx to signal that uretprobe
> > > syscall got executed, if not, trampoline does int3 and executes uretprobe
> > > handler in the old way
> > >
> > > unfortunately now the uretprobe trampoline size crosses the xol slot limit so
> > > will need to come up with some generic/arch code solution for that, code below
> > > is neglecting that for now
> >
> > Can't you detect the filter earlier and simply not install the
> > trampoline?
> 
> Did you mean detect the filter in prepare_uretprobe() ?

Yep. Aren't syscall filters static for the duration of the task?

> The probed function can install the filter before return...

If you're running a task with dynamic syscall filtering, you get to keep
the pieces no?

