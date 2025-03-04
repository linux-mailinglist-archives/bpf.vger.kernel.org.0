Return-Path: <bpf+bounces-53164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7591AA4D3A1
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 07:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131D51897BBB
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 06:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068101F5423;
	Tue,  4 Mar 2025 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N2WovOai"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94811F427D;
	Tue,  4 Mar 2025 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069017; cv=none; b=ZNcF4cl4vG6pebP0M3XuWudUgyhrUwJc1qIRDzQJKTUwinchNX+dQbCWrk7Jvy5KrCmIfXypLjkF/KS90hguWgRRuLgn57mrfY3w8U/DC0DfuO8PvMDi5AzAKFrXWVqx+Z4u+8oJajxOBTysSLBgoKtTe+oMHbNOX8rbUZn3uZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069017; c=relaxed/simple;
	bh=tPctZgjEhRRZal12UASbRN2RbchFHhep/cFENeVUq9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hly9+YtTwU40SwQimGKwXTh5SNJDS4/owSpny4igpLcaRG5zc9DeTN/QJflHifW+RnQKg2MDUnOy3MwxEpGSVr8Gs29DDWFuqG34aYuXFIZL/bvqUJ1s27wOZz5QJ6i/cYY2I8W9h18nlBCmfGEJgnVkTkyuOJaECEvxzhzD6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N2WovOai; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wv+PIGwL4Os+6UQr8shBumtmGLDADHsIVKfUG7p0oac=; b=N2WovOaitXsb/19o9wZCWBmkbx
	X6nG7aGP7e9xXTHfVKszHjHGCjHvP1s+unrd0sDaHVZPKiJKHowe9rCsl6nu1rGadL/60ARvewN3e
	ZAPsFep2gcveMkAMNvaShUynEhWKqrFc0bxjw+7cUptYPV2Ug91W/HRfS/0b1SL5xoTedaR6OSfTl
	F/5dr9LwADjHja4YomDwE3U3zdmH4SQF8wYmzJUr+lVJ/mcBBG53xFWkW2J/xpv842f8FpEz0sTV5
	6VJCazUVPutTp+RWfJgFrN7jb0UGwOsQZTD9Ik7ZOdKhY2PJM6Euq67lJgTL1Ysy6PVWKJW1Ixzrd
	SOuZMAag==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpLa3-00000000I7p-07aa;
	Tue, 04 Mar 2025 06:16:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7544D30049D; Tue,  4 Mar 2025 07:16:35 +0100 (CET)
Date: Tue, 4 Mar 2025 07:16:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	jolsa@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	mathieu.desnoyers@efficios.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	samitolvanen@google.com, kees@kernel.org, dongml2@chinatelecom.cn,
	akpm@linux-foundation.org, riel@surriel.com, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
Message-ID: <20250304061635.GA29480@noisy.programming.kicks-ass.net>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-2-dongml2@chinatelecom.cn>
 <20250303165454.GB11590@noisy.programming.kicks-ass.net>
 <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>
 <20250304053853.GA7099@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304053853.GA7099@noisy.programming.kicks-ass.net>

On Tue, Mar 04, 2025 at 06:38:53AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 04, 2025 at 09:10:12AM +0800, Menglong Dong wrote:
> > Hello, sorry that I forgot to add something to the changelog. In fact,
> > I don't add extra 5-bytes anymore, which you can see in the 3rd patch.
> > 
> > The thing is that we can't add extra 5-bytes if CFI is enabled. Without
> > CFI, we can make the padding space any value, such as 5-bytes, and
> > the layout will be like this:
> > 
> > __align:
> >   nop
> >   nop
> >   nop
> >   nop
> >   nop
> > foo: -- __align +5
> > 
> > However, the CFI will always make the cfi insn 16-bytes aligned. When
> > we set the FUNCTION_PADDING_BYTES to (11 + 5), the layout will be
> > like this:
> > 
> > __cfi_foo:
> >   nop (11)
> >   mov $0x12345678, %reg
> >   nop (16)
> > foo:
> > 
> > and the padding space is 32-bytes actually. So, we can just select
> > FUNCTION_ALIGNMENT_32B instead, which makes the padding
> > space 32-bytes too, and have the following layout:
> > 
> > __cfi_foo:
> >   mov $0x12345678, %reg
> >   nop (27)
> > foo:
> 
> *blink*, wtf is clang smoking.
> 
> I mean, you're right, this is what it is doing, but that is somewhat
> unexpected. Let me go look at clang source, this is insane.

Bah, this is because assemblers are stupid :/

There is no way to tell them to have foo aligned such that there are at
least N bytes free before it.

So what kCFI ends up having to do is align the __cfi symbol to the
function alignment, and then stuff enough nops in to make the real
symbol meet alignment.

And the end result is utter insanity.

I mean, look at this:

      50:       2e e9 00 00 00 00       cs jmp 56 <__traceiter_initcall_level+0x46>     52: R_X86_64_PLT32      __x86_return_thunk-0x4
      56:       66 2e 0f 1f 84 00 00 00 00 00   cs nopw 0x0(%rax,%rax,1)

0000000000000060 <__cfi___probestub_initcall_level>:
      60:       90                      nop
      61:       90                      nop
      62:       90                      nop
      63:       90                      nop
      64:       90                      nop
      65:       90                      nop
      66:       90                      nop
      67:       90                      nop
      68:       90                      nop
      69:       90                      nop
      6a:       90                      nop
      6b:       b8 b1 fd 66 f9          mov    $0xf966fdb1,%eax

0000000000000070 <__probestub_initcall_level>:
      70:       2e e9 00 00 00 00       cs jmp 76 <__probestub_initcall_level+0x6>      72: R_X86_64_PLT32      __x86_return_thunk-0x4


That's 21 bytes wasted, for no reason other than that asm doesn't have a
directive to say: get me a place that is M before N alignment.

Because ideally the whole above thing would look like:

      50:       2e e9 00 00 00 00       cs jmp 56 <__traceiter_initcall_level+0x46>     52: R_X86_64_PLT32      __x86_return_thunk-0x4
      56:       66 2e 0f 1f 84 		cs nopw (%rax,%rax,1)

000000000000005b <__cfi___probestub_initcall_level>:
      5b:       b8 b1 fd 66 f9          mov    $0xf966fdb1,%eax

0000000000000060 <__probestub_initcall_level>:
      60:       2e e9 00 00 00 00       cs jmp 76 <__probestub_initcall_level+0x6>      72: R_X86_64_PLT32      __x86_return_thunk-0x4




