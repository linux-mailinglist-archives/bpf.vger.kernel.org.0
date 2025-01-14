Return-Path: <bpf+bounces-48755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197DA1047D
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B10169242
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34622DC38;
	Tue, 14 Jan 2025 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sfWKKjh+"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C042229603;
	Tue, 14 Jan 2025 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851353; cv=none; b=VAFrFarjtF9HBxrclpHLEuQTb78kzOsa06G2ksSM7ZV36g6ZUZyxdqbHEQJiqRwJ98dArfHq+FcP/KZsthf/EAo5amJaIZDPwY4oRf+Q+79c3OkKrtw7T+15OEPP44CGPj1HubdBWXSXf9S+ANnXbn4UtctaQoHdZoP9Yhd84mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851353; c=relaxed/simple;
	bh=oQsz4B98RmKuVLiXkzcZqr5I5nm5By5/SQ6Yi+2HJi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaSPJWfL5B0aSLKtG5pu9NaROARAfSCKwe4pdrBtUPQLDhMaAXQkW8KoUzcuHH1OSmCyLUiRKryeFHDUZbzY72tbCzKxgRF6KEb026nV9nAhEimHe88jBJy5j8mcRDtnlhuP0GMkh0ESWO52p1Y8OQqZp7VFJN/5pIAdjAMv+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sfWKKjh+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mt4aJooHjJSiZjcDc7akRx0ZOOUsHsf1anomOTeqn+A=; b=sfWKKjh+2p48a9D4673HOwoWtm
	Ie6ZNBBwBIwGCt7SxTqN1BD0Hhj4YJXWRcW/usCAiBTKP1ynRLIFJcTdGBhhzNgn1/1i3F03S5rFq
	lkwJHcdwYRz5zKa2zQJt2E9bLIYxV4VqwpWQ3bI1Jo6WXzIL/wPeQ/z8Z4r9pf/NQzwKSS8kdln8f
	kiq6USx+GfCsZDkFjLjKUYlLTEG2esVsZ1iNhhd0/ukjte1FMHm2GwfrMPXAXj+Uab1tM7ctsiCaF
	0BGZ3E8W00mOMR2YBb1PfAEtKGl9libhJAvMYI3U5I0BZ5wAWerfag00D3CLK6ccI3lph9bmF+0p/
	SDxK8XCw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXeND-0000000E4EF-32O6;
	Tue, 14 Jan 2025 10:42:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4DB1D3004DE; Tue, 14 Jan 2025 11:42:15 +0100 (CET)
Date: Tue, 14 Jan 2025 11:42:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: oleg@redhat.com, Aleksa Sarai <cyphar@cyphar.com>,
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
Message-ID: <20250114104215.GD8362@noisy.programming.kicks-ass.net>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4YszJfOvFEAaKjF@krava>

On Tue, Jan 14, 2025 at 10:22:20AM +0100, Jiri Olsa wrote:
> On Sat, Jan 11, 2025 at 07:40:15PM +0100, Jiri Olsa wrote:
> > On Sat, Jan 11, 2025 at 02:25:37AM +1100, Aleksa Sarai wrote:
> > > On 2025-01-10, Eyal Birger <eyal.birger@gmail.com> wrote:
> > > > Hi,
> > > > 
> > > > When attaching uretprobes to processes running inside docker, the attached
> > > > process is segfaulted when encountering the retprobe. The offending commit
> > > > is:
> > > > 
> > > > ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
> > > > 
> > > > To my understanding, the reason is that now that uretprobe is a system call,
> > > > the default seccomp filters in docker block it as they only allow a specific
> > > > set of known syscalls.
> > > 
> > > FWIW, the default seccomp profile of Docker _should_ return -ENOSYS for
> > > uretprobe (runc has a bunch of ugly logic to try to guarantee this if
> > > Docker hasn't updated their profile to include it). Though I guess that
> > > isn't sufficient for the magic that uretprobe(2) does...
> > > 
> > > > This behavior can be reproduced by the below bash script, which works before
> > > > this commit.
> > > > 
> > > > Reported-by: Rafael Buchbinder <rafi@rbk.io>
> > 
> > hi,
> > nice ;-) thanks for the report, the problem seems to be that uretprobe syscall
> > is blocked and uretprobe trampoline does not expect that
> > 
> > I think we could add code to the uretprobe trampoline to detect this and
> > execute standard int3 as fallback to process uretprobe, I'm checking on that
> 
> hack below seems to fix the issue, it's using rbx to signal that uretprobe
> syscall got executed, if not, trampoline does int3 and executes uretprobe
> handler in the old way
> 
> unfortunately now the uretprobe trampoline size crosses the xol slot limit so
> will need to come up with some generic/arch code solution for that, code below
> is neglecting that for now

Can't you detect the filter earlier and simply not install the
trampoline?

