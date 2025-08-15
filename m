Return-Path: <bpf+bounces-65732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A866BB27A7B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02387AE096B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7732BE7C8;
	Fri, 15 Aug 2025 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4B2PYzR"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA723CE;
	Fri, 15 Aug 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244636; cv=none; b=A0WFtVwU4mODOqw7aD7NQ9mngo+US5FxjOrWBlfZDfFN7qhN9bG9TzUqu0dTEkSfamqQrFgs/M00FZj7NAxE8t5dsn9nlJ5GvFJXY/8KOcK2zv89gV8zLwzmmKNDq/8kH8dkqVpxzG9cjxb1fgmIVeNrYG18q6ml/NzVerm5ajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244636; c=relaxed/simple;
	bh=3osPC01Ljp5ANRjUTeg8DmGTTDJXs5SXusQAR8ULEfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaVjv8V7rbxf1nawuII4JPf6gTNO87vaMpUL8TbQ88rRa4gafDgfjZgCvYs/BYwTVOHIB9lfz9Kw1N2BH7ZUtk5YqJZCWmkUiZJW9NpMjhorh7ny6VO6ScA71P7bLF+xwxPJCC4X4NYdGV0t5QDUqgI0uInkpvHJeQfNSNQBy9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W4B2PYzR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TB61BP+fjBVuNp1rtfB34czc4Akb1WRHV2ohgDZf2o4=; b=W4B2PYzRPuCb1TfYFBz3Ktp6ng
	kNGZSOJRHnN+Qu7q5ZDj5ZxjRVmcFsZkmMrD6otNB5vsNW4cVszh2KUOFWsaTFjlx5aQowe0Bz1lg
	j56K3A/PWyNKw2Xq9D3D2ZQfoLL3jMOPjJap2fikqvkCRmAbemMvhc0yYxsFcjRvf/9miurMynzAo
	7PFS2ncS+ipjiE68X7xXSLYT/0awTYUVwOIKLuIYOo4+dyL41fCfoym7ZYKaC7FrH1QL1cSbIBPg8
	ZVa4rv+L/5/4SRDs7ZaLK5A2LAgzx6YW7ZwKuMEfRMDRGAD7R2SaVPgATIM2MDt1xTu8pVNWBpAco
	pRE3fLJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umpJF-0000000GeXv-2fwR;
	Fri, 15 Aug 2025 07:57:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 73CAD300310; Fri, 15 Aug 2025 09:57:08 +0200 (CEST)
Date: Fri, 15 Aug 2025 09:57:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf <bpf@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	alyssa.milburn@intel.com, scott.d.constable@intel.com,
	Joao Moreira <joao@overdrivepizza.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, ojeda@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250815075708.GB3419281@noisy.programming.kicks-ass.net>
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <CAADnVQLyahEsFereM_-Y-MUdWm2mLHNKfffwNKX5Fvy+EaH-Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLyahEsFereM_-Y-MUdWm2mLHNKfffwNKX5Fvy+EaH-Nw@mail.gmail.com>

On Fri, Aug 15, 2025 at 08:42:39AM +0300, Alexei Starovoitov wrote:
> On Thu, Aug 14, 2025 at 2:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hi!
> >
> > A while ago FineIBT started using the instruction 0xEA to generate #UD.
> > All existing parts will generate #UD in 64bit mode on that instruction.
> >
> > However; Intel/AMD have not blessed using this instruction, it is on
> > their 'reserved' list for future use.
> >
> > Peter Anvin worked the committees and got use of 0xD6 blessed, and it
> > will be called UDB (per the next SDM or so).
> >
> > Reworking the FineIBT code to use UDB wasn't entirely trivial, and I've
> > had to switch the hash register to EAX in order to free up some bytes.
> >
> > Per the x86_64 ABI, EAX is used to pass the number of vector registers
> > for varargs -- something that should not happen in the kernel. More so,
> > we build with -mskip-rax-setup, which should leave EAX completely unused
> > in the calling convention.
> 
> rax is used to pass tail_call count.
> See diagram in commit log:
> https://lore.kernel.org/all/20240714123902.32305-2-hffilwlqm@gmail.com/
> Before that commit rax was used differently.
> Bottom line rax was used for a long time to support bpf_tail_calls.
> I'm traveling atm. So cc-ing folks for follow ups.

IIRC the bpf2bpf tailcall doesn't use CFI at the moment. But let me
double check.

So emit_cfi() is called at the very start of emit_prologue() and
__arch_prepare_bpf_trampoline() in the BPF_TRAMP_F_INDIRECT case.

Now, emit_prologue() starts with the CFI bits, but the tailcall lands at
X86_TAIL_CALL_OFFSET, at which spot we only have EMIT_ENDBR(), nothing
else. So RAX should be unaffected at that point.

So, AFAICT, we're good on that point. It is just the C level indirect
function call ABI that is affected, BPF internal conventions are
unaffected.


