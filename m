Return-Path: <bpf+bounces-44130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882459BF178
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 16:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057B7B22267
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89952200CB5;
	Wed,  6 Nov 2024 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bSZoc8/S"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470318C03F
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906518; cv=none; b=gnsKrOZtJ1/LEHxHWVR/eXu6SwfOZELY00lDrrAHPNnPOdq0aOAUpQJ8uNaPKiBLbyc02msK1pfVr+iAWxnrwGAs1ntrAlIPGAlsVkIh6KF5xwfPF9bZEXdLksE1FYPPSkuW/QNDP1Nkp5jZFQV/OCGbRzg8Yozb8FVtqfFOZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906518; c=relaxed/simple;
	bh=c8KRWnRV1nCFogjaDPLsc4wI3nwNbyWMo+AyHy9ZAUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agUPQuGVPrXMtOOdvSsWB6FKrqrf8TzrO10125amvGM+Nd/i0xE26hrCxJLPgQiZXrBH2yMOgl2xPa5CoNdC6X2OXKhjyBzWfT/maA1G/6qRa9YjzY1SByL+BlpzJ7v0YCJ/2iZRWfwcYwohlso/9pFVUt61tjKeSlJMg65IiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bSZoc8/S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FvrkkWhxKvs+zJzYGh6XTPAspYID6zD7W+8NMYQePFs=; b=bSZoc8/Sn4DQnSAuBJOxF81i7v
	pJ5L1rV21RGducSq6Im7mo1ZR+BmnFxKc0rKE9yLsLnVj8fqlr5GCdwzgwC+l7k/1uA9T58TRnFBE
	fW+vDtJrAIQ+U7Z8yIN6qPtFcByMuRM/hz2FZeSl9YrqF3JpOKx8FJ37qRSht7y0n2LXQZ26U0AVn
	tR9ALHcLrsHAO6wkToLbGxxwImbPJbMa2QkuKhi701v5rMWEGWjyDPKBey0eK39JLeHpGF0Sio+rV
	ozBsI78y5nQnp7ciqhTZXEhexunAaoN3rl7IR+PjEkmKpGhSUwGVWFOE43HQAtuz+Q6ep+T80L6Ao
	N9539zDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8hql-00000004naT-1gul;
	Wed, 06 Nov 2024 15:21:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1AD74300478; Wed,  6 Nov 2024 16:21:39 +0100 (CET)
Date: Wed, 6 Nov 2024 16:21:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
	kkd@meta.com, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Rishabh Iyer <rishabh.iyer@berkeley.edu>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	X86 ML <x86@kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf, x86: Skip bounds checking for
 PROBE_MEM with SMAP
Message-ID: <20241106152139.GN10375@noisy.programming.kicks-ass.net>
References: <20241103193512.4076710-1-memxor@gmail.com>
 <20241103193512.4076710-3-memxor@gmail.com>
 <20241104195354.GA31782@noisy.programming.kicks-ass.net>
 <CAADnVQJwV6bg15qJjdHgzUM83V7t1XiM17Xjf+FSTKSZi445KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJwV6bg15qJjdHgzUM83V7t1XiM17Xjf+FSTKSZi445KQ@mail.gmail.com>

On Tue, Nov 05, 2024 at 10:35:40AM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 4, 2024 at 11:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sun, Nov 03, 2024 at 11:35:12AM -0800, Kumar Kartikeya Dwivedi wrote:
> > >  arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > index 06b080b61aa5..7e3bd589efc3 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -1954,8 +1954,8 @@ st:                     if (is_imm8(insn->off))
> > >               case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
> > >                       insn_off = insn->off;
> > >
> > > -                     if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
> > > -                         BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
> > > +                     if ((BPF_MODE(insn->code) == BPF_PROBE_MEM ||
> > > +                          BPF_MODE(insn->code) == BPF_PROBE_MEMSX) && !cpu_feature_enabled(X86_FEATURE_SMAP)) {
> > >                               /* Conservatively check that src_reg + insn->off is a kernel address:
> > >                                *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
> > >                                *   and
> >
> > Well, I can see why you'd want to get rid of that, that's quite
> > dreadful code you generate there.
> >
> > Can't you do something like:
> >
> >   lea off(%src), %r10
> >   mov %r10, %r11
> >   inc %r10
> >   sar $63, %r11
> >   and %r11, %r10
> >   dec %r10
> >
> >   mov (%r10), %rax
> 
> That's a Linus's hack for mask_user_address() and
> earlier in valid_user_address().

Yes, something along those lines. Preserves everything with MSB 1, and
maps the rest to ~0.

> I don't think it works because of
> #define VSYSCALL_ADDR (-10UL << 20)
> 
> We had to filter out that range.

Range of _1_ page. Also, nobody should ever touch that page these days
anyway.

> I don't understand why valid_user_address() is not broken,
> since fault handler considers vsyscall address to be user addr
> in fault_in_kernel_space().
> And user addr faulting doesn't have extable handling logic.

The vsyscall page has it's own magical exception handling that does
emulation.

> > I realize that's not exactly pretty either, but no jumps. Not sure
> > this'll help much if anything with the TDX thing though.
> 
> to clarify... this is not bpf specific. This bpf JIT logic is
> nothing but inlined version of copy_from_kernel_nofault().
> So if confidential computing has an issue lots of pieces are affected.

It's not copy_from_kernel_nofault() that's a problem per-se, it's
thinking it's 'safe' for random input that is.



