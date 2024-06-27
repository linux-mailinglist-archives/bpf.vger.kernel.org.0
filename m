Return-Path: <bpf+bounces-33258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1545691A90C
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 16:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CF61C223EA
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15F195B2E;
	Thu, 27 Jun 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPE3Bnoi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF98179658;
	Thu, 27 Jun 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498038; cv=none; b=AAiV5MoKlcBybruSgyAIm2sNQ9dCYHydjMCc4bXfUmg48+5LQPJoqTntQMPvQUlwf671btN1uNGKesBfV6amw2AgthBmSMZoUmC+fhe7t0GKaYhTH7V2NHffkdtGY5zBoKEwMNrdo4PRKXQU28N2vXGQzNUbuAKeh9SS68UEosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498038; c=relaxed/simple;
	bh=6jpdpavsTgvc7X+5C/YGS9Rd1h6rsBawCk2gIEwDWcU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HaIbfkpiUQqBTLdt9qEUFjFhG/2eeh3Zrt5kVX/pxAZHsyq8lWw4cevVspuiNyp5Y0JqMF6tebbR21/NXFds/B+ikMMugAJTcXckcxekuPqA+kAElwY/jX/HgmGfLrMjz1l6DLR/diYrHqmVYP49Yocv/QceTbJut58xBN3ygy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPE3Bnoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F8C2BBFC;
	Thu, 27 Jun 2024 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719498038;
	bh=6jpdpavsTgvc7X+5C/YGS9Rd1h6rsBawCk2gIEwDWcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gPE3BnoiM3lOpSUdHFHE3y0FyHv04P/fktEqlAuSubyYvKniCSFAaWObzgBs1ig99
	 mASXhCE5+chbUx65o51o8G2ESUOpiWQRBeoPypLQ9ctwcsO1o48cOMzF/nFHwnmyI2
	 UoP4Ixb/5egOc59mSp+tfZUeJiwsZsMRdCN62//GP0shfzbRZLb2IhqhujgJFfTsKA
	 L7OwgeMzaWzgKrBlGgcpxjQxs4C8ck4SGPoSwFSBjDAXYMXTjGCAJ6wjOw2OuatoO4
	 GMlIinVMGjs+BU1nC744kIsGP4dhRjTVHeVlxDsmSbG6gB+85A71d7zwXH7p+b3Daf
	 qnN2pfgEt8x3g==
Date: Thu, 27 Jun 2024 23:20:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 loongarch@lists.linux.dev
Subject: Re: [PATCH] uprobe: Do not use UPROBE_SWBP_INSN as static
 initializer
Message-Id: <20240627232032.a202e546f59a0290c615510f@kernel.org>
In-Reply-To: <Zn1ssLPeMj-On_uT@krava>
References: <20240618194306.1577022-1-jolsa@kernel.org>
	<CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
	<20240620193846.GA7165@redhat.com>
	<CAEf4BzaqgbjPfxKmzF-M7nzGroOwKikA0BM7Tnw7dKzKS+x9ZQ@mail.gmail.com>
	<20240621120149.GB12521@redhat.com>
	<ZnV9hvOP5388YJtw@krava>
	<Zn1ssLPeMj-On_uT@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 27 Jun 2024 15:44:16 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Jun 21, 2024 at 03:17:58PM +0200, Jiri Olsa wrote:
> > On Fri, Jun 21, 2024 at 02:01:50PM +0200, Oleg Nesterov wrote:
> > > On 06/20, Andrii Nakryiko wrote:
> > > >
> > > > On Thu, Jun 20, 2024 at 12:40 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > > But I can't understand what does it do, it calls emit_break() and
> > > > > git grep -w emit_break finds nothing.
> > > > >
> > > >
> > > > It's DEF_EMIT_REG0I15_FORMAT(break, break_op) in
> > > > arch/loongarch/include/asm/inst.h
> > > >
> > > > A bunch of macro magic, but in the end it produces some constant
> > > > value, of course.
> > > 
> > > I see, thanks!
> > > 
> > > Then perhaps something like below?
> > 
> > lgtm, added loong arch list/folks
> 
> ping
> 
> Oleg, do you want to send formal patch?
> 
> thanks,
> jirka

Yes, can you send v2 patch?

Thank you,

> 
> > 
> > for context:
> >   https://lore.kernel.org/bpf/20240614174822.GA1185149@thelio-3990X/
> > 
> > thanks,
> > jirka
> > 
> > > 
> > > Oleg.
> > > 
> > > 
> > > --- x/arch/loongarch/include/asm/uprobes.h
> > > +++ x/arch/loongarch/include/asm/uprobes.h
> > > @@ -9,7 +9,7 @@ typedef u32 uprobe_opcode_t;
> > >  #define MAX_UINSN_BYTES		8
> > >  #define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
> > >  
> > > -#define UPROBE_SWBP_INSN	larch_insn_gen_break(BRK_UPROBE_BP)
> > > +#define UPROBE_SWBP_INSN	(uprobe_opcode_t)(BRK_UPROBE_BP | (break_op << 15))
> > >  #define UPROBE_SWBP_INSN_SIZE	LOONGARCH_INSN_SIZE
> > >  
> > >  #define UPROBE_XOLBP_INSN	larch_insn_gen_break(BRK_UPROBE_XOLBP)
> > > --- x/arch/loongarch/kernel/uprobes.c
> > > +++ x/arch/loongarch/kernel/uprobes.c
> > > @@ -7,6 +7,13 @@
> > >  
> > >  #define UPROBE_TRAP_NR	UINT_MAX
> > >  
> > > +static __init int __ck_insn(void)
> > > +{
> > > +	BUG_ON(UPROBE_SWBP_INSN != larch_insn_gen_break(BRK_UPROBE_BP));
> > > +	return 0;
> > > +}
> > > +late_initcall(__ck_insn);
> > > +
> > >  int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
> > >  			     struct mm_struct *mm, unsigned long addr)
> > >  {
> > > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

