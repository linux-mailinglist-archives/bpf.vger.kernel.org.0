Return-Path: <bpf+bounces-33525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC9D91E758
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 20:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4521C218DF
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF4B16EC02;
	Mon,  1 Jul 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8neZdN7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013016EBF8;
	Mon,  1 Jul 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858016; cv=none; b=UDP99M6AV5dQ8d9OBcpX9mIT7MdwFGVXNhPU/T2pDnq9u0A7yjH/qTqsplolmpUJzDPl/TUtQGomRQ1xgST2jbhVhhzQrkdrKnBSgsW6hKdhtjC+uX/uN+HRn/pNO7kyA17ZAsDa/a4FEfkCRsUCY8/fwrbbn3oXI2c14KRQpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858016; c=relaxed/simple;
	bh=v61sebZAM5Fq8S2wGe6p+xdUAaooGWaG2e3NPPa8p8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg5i7hnKwcwQ3FCrAQ0YkWzUHF7li3bp+fGKcyIv0lm9T4feUGWwQWe0JGeTqzG5bEjvUOh8z7eAJHa/q7Bgg5SOFShMgwQfnQUw113FJ104t0/wtY7nirG1qr1n+6+2XmXBKbWTsC/1omFN8MFxomGlL1B9z2yKI2JCDL3CNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8neZdN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6D1C116B1;
	Mon,  1 Jul 2024 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719858016;
	bh=v61sebZAM5Fq8S2wGe6p+xdUAaooGWaG2e3NPPa8p8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8neZdN7VMZUQ+pCnikRCXfuUW2R4Kl2KJlnHoTTqgR8/ND6ugQR8ik4guKKyEaV8
	 Yp6r7hiv6i4MiZe/vEv7tmSLHM4AjDZLBQYYU+ghNXUi57FqertEaKwpJ0uSszZzxm
	 bXQzrf2dsVwaS0Y6RipKlMz7iA6gFOXbHOxCyGcmwwPXGbuI37GcR29Kd7am4NgdtI
	 QAp4r4eCucHbZZde9lJJg1hyjv7LQBn+qzRWj7k6co9BqGVykA/4Qw2KOYVhunyOvY
	 1RJq7zWeSnM+/jTA58WseqJ1hbf3+fFGurgwNsBimt5fNp9oQKdhk2Q9rK4ycwerrt
	 Cq4E6x5imI3UA==
Date: Mon, 1 Jul 2024 23:48:37 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Masahiro Yamada <masahiroy@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH v3 01/11] powerpc/kprobes: Use ftrace to determine if
 a probe is at function entry
Message-ID: <owili23kr3wim6carm6ueogyureim6h2iv5a37kkz7viu564ca@xxkhtzst6l7n>
References: <cover.1718908016.git.naveen@kernel.org>
 <2cd04be69e90adc34bcf98d405ab6b21f268cb6a.1718908016.git.naveen@kernel.org>
 <D2E2GLXWB7TH.1L7TFQZO3149Y@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2E2GLXWB7TH.1L7TFQZO3149Y@gmail.com>

Hi Nick,
Thanks for the reviews!

On Mon, Jul 01, 2024 at 06:40:50PM GMT, Nicholas Piggin wrote:
> On Fri Jun 21, 2024 at 4:54 AM AEST, Naveen N Rao wrote:
> > Rather than hard-coding the offset into a function to be used to
> > determine if a kprobe is at function entry, use ftrace_location() to
> > determine the ftrace location within the function and categorize all
> > instructions till that offset to be function entry.
> >
> > For functions that cannot be traced, we fall back to using a fixed
> > offset of 8 (two instructions) to categorize a probe as being at
> > function entry for 64-bit elfv2, unless we are using pcrel.
> >
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Naveen N Rao <naveen@kernel.org>
> > ---
> >  arch/powerpc/kernel/kprobes.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> > index 14c5ddec3056..ca204f4f21c1 100644
> > --- a/arch/powerpc/kernel/kprobes.c
> > +++ b/arch/powerpc/kernel/kprobes.c
> > @@ -105,24 +105,22 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
> >  	return addr;
> >  }
> >  
> > -static bool arch_kprobe_on_func_entry(unsigned long offset)
> > +static bool arch_kprobe_on_func_entry(unsigned long addr, unsigned long offset)
> >  {
> > -#ifdef CONFIG_PPC64_ELF_ABI_V2
> > -#ifdef CONFIG_KPROBES_ON_FTRACE
> > -	return offset <= 16;
> > -#else
> > -	return offset <= 8;
> > -#endif
> > -#else
> > +	unsigned long ip = ftrace_location(addr);
> > +
> > +	if (ip)
> > +		return offset <= (ip - addr);
> > +	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && !IS_ENABLED(CONFIG_PPC_KERNEL_PCREL))
> > +		return offset <= 8;
> 
> If it is PCREL, why not offset == 0 as well?

That's handled by the fallback code that is after the above line:
	return !offset;

That addresses both pcrel, as well as 32-bit powerpc.

Thanks,
Naveen


