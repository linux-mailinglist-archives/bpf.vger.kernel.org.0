Return-Path: <bpf+bounces-72994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3473FC1FA79
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0888B4EA130
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B88234D92B;
	Thu, 30 Oct 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LGKfnvfV"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6353396E0
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821608; cv=none; b=G2v4ufx2taW4Yq6+OgbJVu8Upd3XDL0w/dHFDakqU49+XvcX+Eq1/v3nnoDp3f7E75xFYAB3M/6MMI/SA70FUvgoPP+fjIoim/hLEtYt2PPWfaDLHbhiuTzqszYZe5FhxBwndokyNiI4hSc24Ee009UYk71tfiWwOvho2oz5rtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821608; c=relaxed/simple;
	bh=fAgyfBlTLNvsBQRvEdX8rM8nBRe6BP7UrtxbhzMv6L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7gtIAGr+2zLd5hag3VIhRMWjc4BsgzAXslGsqgGE4+3LfBrLE9M+THyzHxxN3dY0S63JjnshJeAa8hlAhWbW3ZNqct1pAwHAjBIuyShnLff9eCJenIzK4B6meCJWYhQl0sk0UuJpH8sBxhn4HQDgnuviNtNAHDEJEK7f0E1W9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LGKfnvfV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Qfwi9W4clT+SPPZuDMaOVf+Bxm9lWlGAzoBkTm2pne8=; b=LGKfnvfVaMFGirCfO77SQ5H0WH
	9+fZk/5L1Hl9UbnbsV51IYxfzuhrKn+GJDBuDDjPpBHjV/rKHVX7gGwuXnIZVcN9nxKjdD+I9DMEU
	2H3eZ5HAqLKxsYOz1/Kds5ywtpObwmbxD3NhxcMMmN4APpSFWVT1bwhJVJgdmRWBBcayPcrdz1bVj
	D2rG1rIxHhpj4honwTqWXHC6oDKHwD1r3Bwl/vLEF0Xk/eijsYDYN+bwVuFyykDXToPJQUnkqQqEX
	f+XworfccGL7DjLnWeaBRjGaIwb07/Vm9N/Cgi9DxSxWZ126J6hPTeAY6+Flv3akAUREOhnkjFTCl
	tt09+zsg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEQHN-00000002VTW-2qht;
	Thu, 30 Oct 2025 10:53:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5A3E730029E; Thu, 30 Oct 2025 11:53:18 +0100 (CET)
Date: Thu, 30 Oct 2025 11:53:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kernel Team <kernel-team@fb.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf] bpf: Make migrate_{disable,enable} always inline if
 in header file
Message-ID: <20251030105318.GK4067720@noisy.programming.kicks-ass.net>
References: <20251029183646.3811774-1-yonghong.song@linux.dev>
 <CAADnVQJbat5mwSoDUUf9yNheTe6h58f3JFM=UMpgOSytnCCWuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJbat5mwSoDUUf9yNheTe6h58f3JFM=UMpgOSytnCCWuw@mail.gmail.com>

On Wed, Oct 29, 2025 at 06:13:21PM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 29, 2025 at 11:37 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> >
> > With latest bpf/bpf-next tree and latest pahole master, I got the following
> > build failure:
> >
> >   $ make LLVM=1 -j
> >     ...
> >     LD      vmlinux.o
> >     GEN     .vmlinux.objs
> >     ...
> >     BTF     .tmp_vmlinux1.btf.o
> >     ...
> >     AS      .tmp_vmlinux2.kallsyms.o
> >     LD      vmlinux.unstripped
> >     BTFIDS  vmlinux.unstripped
> >   WARN: resolve_btfids: unresolved symbol migrate_enable
> >   WARN: resolve_btfids: unresolved symbol migrate_disable
> >   make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> >   make[2]: *** Deleting file 'vmlinux.unstripped'
> >   make[1]: *** [/home/yhs/work/bpf-next/Makefile:1242: vmlinux] Error 2
> >   make: *** [/home/yhs/work/bpf-next/Makefile:248: __sub-make] Error 2
> >
> > In pahole patch [1], if two functions having identical names but different
> > addresses, then this function name is considered ambiguous and later on
> > this function will not be added to vmlinux/module BTF.
> >
> > Commit 378b7708194f ("sched: Make migrate_{en,dis}able() inline") changed
> > original global funcitons migrate_{enable,disable} to
> >   - in kernel/sched/core.c, migrate_{enable,disable} are global funcitons.
> >   - in other places, migrate_{enable,disable} may survive as static functions
> >     since they are marked as 'inline' in include/linux/sched.h and the
> >     'inline' attribute does not garantee inlining.
> >
> > If I build with clang compiler (make LLVM=1 -j) (llvm21 and llvm22), I found
> > there are four symbols for migrate_{enable,disable} respectively, three
> > static functions and one global function. With the above pahole patch [1],
> > migrate_{enable,disable} are not in vmlinux BTF and this will cause
> > later resolve_btfids failure.
> >
> > Making migrate_{enable,disable} always inline in include/linux/sched.h
> > can fix the problem.
> >
> >   [1] https://lore.kernel.org/dwarves/79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com/
> >
> > Fixes: 378b7708194f ("sched: Make migrate_{en,dis}able() inline")
> > Cc: Menglong Dong <menglong8.dong@gmail.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  include/linux/sched.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index cbb7340c5866..b469878de25c 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2407,12 +2407,12 @@ static inline void __migrate_enable(void) { }
> >   * be defined in kernel/sched/core.c.
> >   */
> >  #ifndef INSTANTIATE_EXPORTED_MIGRATE_DISABLE
> > -static inline void migrate_disable(void)
> > +static __always_inline void migrate_disable(void)
> >  {
> >         __migrate_disable();
> >  }
> >
> > -static inline void migrate_enable(void)
> > +static __always_inline void migrate_enable(void)
> >  {
> >         __migrate_enable();
> >  }
> 
> Peter,
> 
> Are you ok if we take this?

Yes, but WTH would clang not inline this trivial function to begin with?

