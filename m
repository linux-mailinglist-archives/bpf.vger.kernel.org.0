Return-Path: <bpf+bounces-33529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A491E810
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90F82839ED
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B6516F267;
	Mon,  1 Jul 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW6vZ/EU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55710F9;
	Mon,  1 Jul 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860417; cv=none; b=VcBSf0HZA4oYN24xgisfJwQoW8FA20Qj4Zq0TXywS9oWkmiP6kFDcUOmb91yjonP6nGIkaLIb56Qg5SbifyBqx0BulUEO0Fa6J7ikPA4Xre+UehHPQO+e9qT0Tdn/ifG6r9D+KnpxH3ZuOYVyWIe6IeDt7Mbgio04kokhj2qKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860417; c=relaxed/simple;
	bh=oWVPACVe2jDT+0IwJYl4c15rwjRhX4q07V6CionFsec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eM7Kuc1gTgbseMSA4FzCCE4W2nQMZMoHinjBSsFKJS0xf9FqVPTSFy3s5CKGHSvDPSYGSl1hj3s1pCwoRUnON/s4/bWffFPqPZYNsek4sBHwKriVd/ZcMbGlujVsjVhhBZWLNgbh8wUofAAR9hOT08dxKD0ZnX6hlN/qrSQdTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW6vZ/EU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39E8C116B1;
	Mon,  1 Jul 2024 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860416;
	bh=oWVPACVe2jDT+0IwJYl4c15rwjRhX4q07V6CionFsec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mW6vZ/EUqNgYg66p2GCSh8Mz9ufCJKuEQlM21fmHWFBj+JFOfMZpaa5RMpfAJ+22X
	 OqXgXL+rdtJET6W1vVD+y/izhaUF96579K7vrtdHEfYRWVJI9/HNDQftHudKCd1CMr
	 OyTgAg6dWHq7xQTGq49qfGLeacjrbKPm2Gh7C+0IwZVM2x1A6JlKErk22iGqgho+nc
	 kziiWFfHa3Ps++77rsvvx/+0oxDLYWjHRAxzt5zRQlgam3Ps4kxhEfKcF0tDbrqWMK
	 31vOW55AVjZBJWvEE1bcJ3ZoSxx8RULar4L8Gkgca2RHtJmGFdR/hAuRwkR1+TMtZu
	 k5SLZP091tG9w==
Date: Tue, 2 Jul 2024 00:21:18 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Masahiro Yamada <masahiroy@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH v3 04/11] powerpc/ftrace: Remove pointer to struct
 module from dyn_arch_ftrace
Message-ID: <vtwpgnyppfwn2fdekvolkun2x64j72x4ppiqr3tqfkh2p2jwxr@ztcqpbgactai>
References: <cover.1718908016.git.naveen@kernel.org>
 <f13b5e0cb4f9961f23c8880a2f98073e41f695d8.1718908016.git.naveen@kernel.org>
 <D2E3GNRTRCOF.16TWBZIA5EZS2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2E3GNRTRCOF.16TWBZIA5EZS2@gmail.com>

On Mon, Jul 01, 2024 at 07:27:55PM GMT, Nicholas Piggin wrote:
> On Fri Jun 21, 2024 at 4:54 AM AEST, Naveen N Rao wrote:
> > Pointer to struct module is only relevant for ftrace records belonging
> > to kernel modules. Having this field in dyn_arch_ftrace wastes memory
> > for all ftrace records belonging to the kernel. Remove the same in
> > favour of looking up the module from the ftrace record address, similar
> > to other architectures.
> 
> arm is the only one left that requires dyn_arch_ftrace after this.

Yes, but as you noticed, we add a different field in a subsequenct patch 
in this series.

> 
> >
> > Signed-off-by: Naveen N Rao <naveen@kernel.org>
> > ---
> >  arch/powerpc/include/asm/ftrace.h        |  1 -
> >  arch/powerpc/kernel/trace/ftrace.c       | 54 +++++++++++-------
> >  arch/powerpc/kernel/trace/ftrace_64_pg.c | 73 +++++++++++-------------
> >  3 files changed, 65 insertions(+), 63 deletions(-)
> >
> 
> [snip]
> 
> > @@ -106,28 +106,48 @@ static unsigned long find_ftrace_tramp(unsigned long ip)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> > +static unsigned long ftrace_lookup_module_stub(unsigned long ip, unsigned long addr)
> > +{
> > +	struct module *mod = NULL;
> > +
> > +	/*
> > +	 * NOTE: __module_text_address() must be called with preemption
> > +	 * disabled, but we can rely on ftrace_lock to ensure that 'mod'
> > +	 * retains its validity throughout the remainder of this code.
> > +	 */
> > +	preempt_disable();
> > +	mod = __module_text_address(ip);
> > +	preempt_enable();
> 
> If 'mod' was guaranteed to exist before your patch, then it
> should do afterward too. But is it always ftrace_lock that
> protects it, or do dyn_ftrace entries pin a module in some
> cases?

We don't pin a module. It is the ftrace_lock acquired during 
delete_module() in ftrace_release_mod() that protects it.

You're right though. That comment is probably not necessary since there 
are no new users of this new function.

> 
> > @@ -555,7 +551,10 @@ __ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> >  	ppc_inst_t op;
> >  	unsigned long ip = rec->ip;
> >  	unsigned long entry, ptr, tramp;
> > -	struct module *mod = rec->arch.mod;
> > +	struct module *mod = ftrace_lookup_module(rec);
> > +
> > +	if (!mod)
> > +		return -EINVAL;
> >  
> >  	/* If we never set up ftrace trampolines, then bail */
> >  	if (!mod->arch.tramp || !mod->arch.tramp_regs) {
> > @@ -668,14 +667,6 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> >  		return -EINVAL;
> >  	}
> >  
> > -	/*
> > -	 * Out of range jumps are called from modules.
> > -	 */
> > -	if (!rec->arch.mod) {
> > -		pr_err("No module loaded\n");
> > -		return -EINVAL;
> > -	}
> > -
> 
> A couple of these conversions are not _exactly_ the same (lost
> the pr_err here), maybe that's deliberate because the messages
> don't look too useful.

Indeed. Most of the earlier ones being eliminated are in 
ftrace_init_nop(). The other ones get covered by the pr_err in 
ftrace_lookup_module()/ftrace_lookup_module_stub().

> 
> Looks okay though
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


Thanks,
Naveen

