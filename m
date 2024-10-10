Return-Path: <bpf+bounces-41563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC0998449
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 12:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F28281EF9
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855BE1C2428;
	Thu, 10 Oct 2024 10:58:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739021C1AD1;
	Thu, 10 Oct 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557928; cv=none; b=WV2jBAuBPHO4boqlQi7k2N4I1YXOVAoLFTxHsGS2zBl6TYugPi59t2wUgIEaUEnzJZYM66P5Fp7nLNgfmmSSTMFLv8a7J+Qz/j084/27jbq5mEfY+9CIYcKNYCLK0KSu4PB7ECpRRHuNwGQ8n0SVknt6VabY3sy0IIzVZJ1sTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557928; c=relaxed/simple;
	bh=qYwH4tGIR+4FLqvSTaIjtz7u5nRLPHm/L9JJjwTwmIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvfx/FhW4BKDd/y/CWzZ8/Rv8svkeDSemuSolkaEUOr3avLD7wFuwthUWhnXRFK0jNUEc3gYyib7u/kkXbKzyO7k5GMYlymx/xxMD5yOUNIfQUOcmwLCPerxFH4WsPOysN4kOGnBUFI9Fj69ggu2DHRxbLt/mNCqsZBBH5+s+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57F1B497;
	Thu, 10 Oct 2024 03:59:15 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BEB93F58B;
	Thu, 10 Oct 2024 03:58:43 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:58:40 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Liao Chang <liaochang1@huawei.com>, will@kernel.org,
	catalin.marinas@arm.com, ast@kernel.org, puranjay@kernel.org,
	andrii@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] arm64: insn: Simulate nop instruction for better
 uprobe performance
Message-ID: <ZwezYJIIsiAeK46P@J2N7QTR9R3>
References: <20240909071114.1150053-1-liaochang1@huawei.com>
 <CAEf4BzZVUPZHyuyt6zGZVTQ3sB8u64Wxfuks9BGq-HXGM1yp3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZVUPZHyuyt6zGZVTQ3sB8u64Wxfuks9BGq-HXGM1yp3A@mail.gmail.com>

Hi Andrii,

On Wed, Oct 09, 2024 at 04:54:25PM -0700, Andrii Nakryiko wrote:
> On Mon, Sep 9, 2024 at 12:21 AM Liao Chang <liaochang1@huawei.com> wrote:

> I'm curious what's the status of this patch? It received no comments
> so far in the last month. Can someone on the ARM64 side of things
> please take a look? (or maybe it was applied to some tree and there
> was just no notification?)
> 
> This is a very useful performance optimization for uprobe tracing on
> ARM64, so would be nice to get it in during current release cycle.
> Thank you!

Sorry, I got busy chasing up a bunch of bugs and hadn't gotten round to
this yet.

I've replied with a couple of minor comments and an ack, and I reckon we
can queue this up this cycle. Usually this sort of thing starts to get
queued around -rc3.

Mark.

> 
> > diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> > index 8c0a36f72d6f..dd530d5c3d67 100644
> > --- a/arch/arm64/include/asm/insn.h
> > +++ b/arch/arm64/include/asm/insn.h
> > @@ -549,6 +549,12 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
> >                aarch64_insn_is_prfm_lit(insn);
> >  }
> >
> > +static __always_inline bool aarch64_insn_is_nop(u32 insn)
> > +{
> > +       return aarch64_insn_is_hint(insn) &&
> > +              ((insn & 0xFE0) == AARCH64_INSN_HINT_NOP);
> > +}
> > +
> >  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
> >  u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
> >  u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
> > diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
> > index 968d5fffe233..be54539e309e 100644
> > --- a/arch/arm64/kernel/probes/decode-insn.c
> > +++ b/arch/arm64/kernel/probes/decode-insn.c
> > @@ -75,6 +75,15 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
> >  enum probe_insn __kprobes
> >  arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
> >  {
> > +       /*
> > +        * While 'nop' instruction can execute in the out-of-line slot,
> > +        * simulating them in breakpoint handling offers better performance.
> > +        */
> > +       if (aarch64_insn_is_nop(insn)) {
> > +               api->handler = simulate_nop;
> > +               return INSN_GOOD_NO_SLOT;
> > +       }
> > +
> >         /*
> >          * Instructions reading or modifying the PC won't work from the XOL
> >          * slot.
> > diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> > index 22d0b3252476..5e4f887a074c 100644
> > --- a/arch/arm64/kernel/probes/simulate-insn.c
> > +++ b/arch/arm64/kernel/probes/simulate-insn.c
> > @@ -200,3 +200,14 @@ simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
> >
> >         instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> >  }
> > +
> > +void __kprobes
> > +simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
> > +{
> > +       /*
> > +        * Compared to instruction_pointer_set(), it offers better
> > +        * compatibility with single-stepping and execution in target
> > +        * guarded memory.
> > +        */
> > +       arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > +}
> > diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel/probes/simulate-insn.h
> > index e065dc92218e..efb2803ec943 100644
> > --- a/arch/arm64/kernel/probes/simulate-insn.h
> > +++ b/arch/arm64/kernel/probes/simulate-insn.h
> > @@ -16,5 +16,6 @@ void simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs);
> >  void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
> >  void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
> >  void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs);
> > +void simulate_nop(u32 opcode, long addr, struct pt_regs *regs);
> >
> >  #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
> > --
> > 2.34.1
> >

