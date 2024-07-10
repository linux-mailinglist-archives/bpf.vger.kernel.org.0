Return-Path: <bpf+bounces-34385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FA792D0D1
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 13:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64291C22A61
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9D19049E;
	Wed, 10 Jul 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BdBSdh66"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7518FDDD;
	Wed, 10 Jul 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611547; cv=none; b=RVKxOJxllvAOplQ9vgIR+Zo7dkq7e1ep6/nBNyHlUVIVyUYJ0pOrUUmmxv5Ljb6zn6zI8HH4iNUU8xDh7+/A5xIpFh2BuH8Ke9ndtBFNK8hoYQ7IHXiaTN5M+pyEMhvWRw0Vj36PYfClN8v7oJVbXFA1CXVp8kiKMPnip6kQSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611547; c=relaxed/simple;
	bh=CsfC70dE9C/jDtS4ftUnV84YF80YPgShyOTPX8of6Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyVa4MeauQYPl9hqnZbVv0zZdzWPGU8AE45u6LnJesA2YZYm+1ZnmtrKcpgB7gFovVCqeog4ZRWWrzGSCmaxrf5JtVJHwHOoQv692rT3Iit1iXTuBXvSb6GYS2GZcr6iOZWw51L5gTqwYyb7LGzK9lfr76BTzbKn6u20Tf1RwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BdBSdh66; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NbizRAFDomWAX7KLbEak4d3LCCuk+dnnOq+zYA+vfEo=; b=BdBSdh66pEPXyclRDHMNTOCfgX
	DYHDBzZybtIuleBqPjmzoGabNuNj5vk91w0A1SufT7XvHk0y9HE3ajvshVEf8VAhnweMU63JbzjYs
	uFWlPc236kmkQC4l0S0/rlq0FjCFM3MixQveMziScIX+2SI2B2Q+b5/sMJ+UtO4Td9sOQ43QraHPI
	mMttZaNOU1QOd7UHL2doy5H9womEXItYMy0XASs43JhL8X3fZK37j2E0U6zhG4/FpfeeLz80cMsnw
	FcMa1jISsV1v5ZSiCu1iWFGYOVznOFzhz0e9zCKsvic9DK9qXHGOgqrTvtTc5EwmHEA10PBHnscto
	VFfyCVdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRVey-00000009Coj-2sIc;
	Wed, 10 Jul 2024 11:38:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B84EB300694; Wed, 10 Jul 2024 13:38:55 +0200 (CEST)
Date: Wed, 10 Jul 2024 13:38:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, x86@kernel.org,
	mingo@redhat.com, tglx@linutronix.de, jpoimboe@redhat.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v4] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240710113855.GX27299@noisy.programming.kicks-ass.net>
References: <20240708231127.1055083-1-andrii@kernel.org>
 <20240709101133.GI27299@noisy.programming.kicks-ass.net>
 <CAEf4Bza22X+vmirG=Xf4zPV0DTn9jVXi1SRTn9ff=LG=z2srNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza22X+vmirG=Xf4zPV0DTn9jVXi1SRTn9ff=LG=z2srNQ@mail.gmail.com>

On Tue, Jul 09, 2024 at 10:50:00AM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 9, 2024 at 3:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jul 08, 2024 at 04:11:27PM -0700, Andrii Nakryiko wrote:
> > > +#ifdef CONFIG_UPROBES
> > > +/*
> > > + * Heuristic-based check if uprobe is installed at the function entry.
> > > + *
> > > + * Under assumption of user code being compiled with frame pointers,
> > > + * `push %rbp/%ebp` is a good indicator that we indeed are.
> > > + *
> > > + * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
> > > + * If we get this wrong, captured stack trace might have one extra bogus
> > > + * entry, but the rest of stack trace will still be meaningful.
> > > + */
> > > +static bool is_uprobe_at_func_entry(struct pt_regs *regs)
> > > +{
> > > +     struct arch_uprobe *auprobe;
> > > +
> > > +     if (!current->utask)
> > > +             return false;
> > > +
> > > +     auprobe = current->utask->auprobe;
> > > +     if (!auprobe)
> > > +             return false;
> > > +
> > > +     /* push %rbp/%ebp */
> > > +     if (auprobe->insn[0] == 0x55)
> > > +             return true;
> > > +
> > > +     /* endbr64 (64-bit only) */
> > > +     if (user_64bit_mode(regs) && *(u32 *)auprobe->insn == 0xfa1e0ff3)
> > > +             return true;
> >
> > I meant to reply to Josh suggesting this, but... how can this be? If you
> > scribble the ENDBR with an INT3 things will #CP and we'll never get to
> > the #BP.
> 
> Well, it seems like it works in practice, I just tried. Here's the
> disassembly of the function:
> 
> 00000000000019d0 <urandlib_api_v1>:
>     19d0: f3 0f 1e fa                   endbr64
>     19d4: 55                            pushq   %rbp
>     19d5: 48 89 e5                      movq    %rsp, %rbp
>     19d8: 48 83 ec 10                   subq    $0x10, %rsp
>     19dc: 48 8d 3d fe ed ff ff          leaq    -0x1202(%rip), %rdi
>  # 0x7e1 <__isoc99_scanf+0x7e1>
>     19e3: 48 8d 75 fc                   leaq    -0x4(%rbp), %rsi
>     19e7: b0 00                         movb    $0x0, %al
>     19e9: e8 f2 00 00 00                callq   0x1ae0 <__isoc99_scanf+0x1ae0>
>     19ee: b8 01 00 00 00                movl    $0x1, %eax
>     19f3: 48 83 c4 10                   addq    $0x10, %rsp
>     19f7: 5d                            popq    %rbp
>     19f8: c3                            retq
>     19f9: 0f 1f 80 00 00 00 00          nopl    (%rax)
> 
> And here's the state when uprobe is attached:
> 
> (gdb) disass/r urandlib_api_v1
> Dump of assembler code for function urandlib_api_v1:
>    0x00007ffb734e39d0 <+0>:     cc                      int3
>    0x00007ffb734e39d1 <+1>:     0f 1e fa                nop    %edx
>    0x00007ffb734e39d4 <+4>:     55                      push   %rbp
>    0x00007ffb734e39d5 <+5>:     48 89 e5                mov    %rsp,%rbp
>    0x00007ffb734e39d8 <+8>:     48 83 ec 10             sub    $0x10,%rsp
>    0x00007ffb734e39dc <+12>:    48 8d 3d fe ed ff ff    lea
> -0x1202(%rip),%rdi        # 0x7ffb734e27e1
>    0x00007ffb734e39e3 <+19>:    48 8d 75 fc             lea    -0x4(%rbp),%rsi
> => 0x00007ffb734e39e7 <+23>:    b0 00                   mov    $0x0,%al
>    0x00007ffb734e39e9 <+25>:    e8 f2 00 00 00          call
> 0x7ffb734e3ae0 <__isoc99_scanf@plt>
>    0x00007ffb734e39ee <+30>:    b8 01 00 00 00          mov    $0x1,%eax
>    0x00007ffb734e39f3 <+35>:    48 83 c4 10             add    $0x10,%rsp
>    0x00007ffb734e39f7 <+39>:    5d                      pop    %rbp
>    0x00007ffb734e39f8 <+40>:    c3                      ret
> 
> 
> You can see it replaced the first byte, the following 3 bytes are
> remnants of endb64 (gdb says it's a nop? :)), and then we proceeded,
> you can see I stepped through a few more instructions.
> 
> Works by accident?

Yeah, we don't actually have Userspace IBT enabled yet, even on hardware
that supports it.

