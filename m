Return-Path: <bpf+bounces-33325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC191B5B6
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 06:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C170C1C2183C
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 04:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD102263A;
	Fri, 28 Jun 2024 04:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/HsRWj7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971002139DB;
	Fri, 28 Jun 2024 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719549037; cv=none; b=mkNG0oa2oi0grxYa+ov99FbS3jghtCbrDEu/NQV51ta2WFVA44u3yXzHEd8roYsFnaqPI1NNA8h1bSSZM4nGBvkNjIw2ageJCI0mTSMx4SzzZ4yHFo5UPSL5cpQG1pIk9997xWjPmQajIa8g20XrAnDruf4M41Q12Owj6hwzaqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719549037; c=relaxed/simple;
	bh=vQckPhpKqiMAKzoCbF5rVgOEtJBMfOEiLX2FgCp4+Yo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vx/LJSUu2oMjgwI77MeTKJgJDM9vc3bQDnE3b+4Kjj2TVrttLEOAegFwpLAvNN0xHy+AtZtRtds56uK3Q7d7WkOj+j4sSRgQ2enU5XJnUxSBtVdnpfzpmX+kvlgdsTzdimjj9rDQhDiX/PTVTVMhYeABieTf+XunK8hkYmwCOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/HsRWj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4B1C116B1;
	Fri, 28 Jun 2024 04:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719549037;
	bh=vQckPhpKqiMAKzoCbF5rVgOEtJBMfOEiLX2FgCp4+Yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E/HsRWj7Q0RlDBrb3+r2vtZk5iO+q7ciURaFaXEhlnqKxqmitsgBmrfX7I4eVXNPv
	 vPU5A9vn5Ds1FxKfbkZZm//yHG1BtwoWIQc8poqIUXaRD18Ks/BwmAdqfwVey1qR4K
	 /G19cllxyneBX1OyBVwli+k5pMaGNA3kDb9AkUgS3h7CMiBoVhSdfK3bXjVpY5OJ1v
	 WKLwVdFyS2KqVLHha93pXoiI1qsu/CLGRIMJJwRR9UK32RYne1K/t0uq4cz7UrUV4c
	 KmMUZgu7n3bLBlRRY5J1rcYn/PLzs61Jki2FZoL0bBYbgAlt/qq7q1t6jxuBig0php
	 jQopWswJrLQDA==
Date: Fri, 28 Jun 2024 13:30:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, Jiri Olsa <jolsa@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH] LoongArch: uprobes: make
 UPROBE_SWBP_INSN/UPROBE_XOLBP_INSN constant
Message-Id: <20240628133033.c9f1856455058f9bb97db6a7@kernel.org>
In-Reply-To: <20240627173806.GC21813@redhat.com>
References: <20240618194306.1577022-1-jolsa@kernel.org>
	<20240627160255.GA25374@redhat.com>
	<CAEf4BzZVmKjfQD1zKMDOD-Zc4pVp+EGgb8h2veg=bXe1Pjn_Uw@mail.gmail.com>
	<20240627173806.GC21813@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 19:38:06 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 06/27, Andrii Nakryiko wrote:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Thanks!
> 
> > > --- a/arch/loongarch/kernel/uprobes.c
> > > +++ b/arch/loongarch/kernel/uprobes.c
> > > @@ -7,6 +7,14 @@
> > >
> > >  #define UPROBE_TRAP_NR UINT_MAX
> > >
> > > +static __init int check_emit_break(void)
> > > +{
> > > +       BUG_ON(UPROBE_SWBP_INSN  != larch_insn_gen_break(BRK_UPROBE_BP));
> > > +       BUG_ON(UPROBE_XOLBP_INSN != larch_insn_gen_break(BRK_UPROBE_XOLBP));
> > > +       return 0;
> > > +}
> > > +arch_initcall(check_emit_break);
> > > +
> >
> > I wouldn't even bother with this, but whatever.
> 
> Agreed, this looks a bit ugly. I did this only because I can not test
> this (hopefully trivial) patch and the maintainers didn't reply.
> 
> If LoongArch boots at least once with this change, this run-time check
> can be removed.
> 
> And just in case... I didn't dare to make a more "generic" change, but
> perhaps KPROBE_BP_INSN and KPROBE_SSTEPBP_INSN should be redefined the
> same way for micro-optimization. In this case __emit_break() should be
> probably moved into arch/loongarch/include/asm/inst.h.

That idea sounds good to me too. If it is good to loongarch maintainers,
(e.g. breakpoint instruction is stable), it is better to define in
asm/insn.h.

Thank you,

> 
> Oleg.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

