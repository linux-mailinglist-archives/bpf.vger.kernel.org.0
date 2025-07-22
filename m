Return-Path: <bpf+bounces-64094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9215FB0E3EE
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8D3568277
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329C283FFD;
	Tue, 22 Jul 2025 19:11:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7B27E077;
	Tue, 22 Jul 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211501; cv=none; b=F/1qq02A73yjyGg+aGEdkWglaKIrdrx36VBoKVzqKyH+2RjIdy1Ap01EcBFMXT2DwUumPd7790H+eMg+Cdp9P2VtlyG3Pqso5W96NB5dvwROSyozBQ15/rbj1nnOm4cDsWpCoDWVmgohxEZAw+pSBPqwUpsH+Hu+nIJZnGv1t9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211501; c=relaxed/simple;
	bh=5wr86rH1s3ndtBz8PSBjIGV/spc58LLIDaS6Ef23x0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlvvKKyBP8l0hiLCOIQ5vb0vH/urUlkeXIxSds2BeAABG31aVs+UkVUqiVpwa4obYAdr9jGPMLrg4E7y6HA+BNg7nypDUjCttdVgqghkYH+WNYMj+cFsPLrq1LsFVwLCwKTo/MOOZiDH95UiALMnPSQbzPVfFowd1fFD1HsRdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 9BCC41129A1;
	Tue, 22 Jul 2025 19:11:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id A4A892000E;
	Tue, 22 Jul 2025 19:11:28 +0000 (UTC)
Date: Tue, 22 Jul 2025 15:11:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Brian Robbins
 <brianrob@microsoft.com>, Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [RFC] New codectl(2) system call for sframe registration
Message-ID: <20250722151127.0b64d3b6@batman.local.home>
In-Reply-To: <af021bce-8465-467d-b88b-8d45d11e0f0a@efficios.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
	<20250721145343.5d9b0f80@gandalf.local.home>
	<e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
	<20250721171559.53ea892f@gandalf.local.home>
	<1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
	<20250722122538.6ce25ca2@batman.local.home>
	<af021bce-8465-467d-b88b-8d45d11e0f0a@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ej1z1qkbe87t3ese35kmeponunzup3cs
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A4A892000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18CMkj6KtP8wmRWrDbXD2WRngu3I5Z/YpY=
X-HE-Tag: 1753211488-213026
X-HE-Meta: U2FsdGVkX1+HDBMhNxRu0G57e0lIQIlbnToAlwuv/AAbBAKMA0dp6DPDkz1gZAd1GY+/hi0CegypxpbD4wqr4zcPCbazqBSxMXARiQlBKbtp1MRNz2gM4ICYTZ5sWjqnQhpFX8srxnYG6ZQ92t2ewXXZ4MNtBlxFlmMdLQC+XYMEJX3LmsXits11qF+NfrlNDtWxouiPFTwiCavotXFotWwEWn86R1AeHX3e1jqgJyDmIv17NnU+YcADK7nTSx2dvmM496u9spgopt7/4tGXqow+J8qAprYTwJ0gl+5WLYfNuryLiEnIFmYJWB6yHDrRfW54gDwSq82js3sRu7UXv18OIoNEtfoQNX38R9+Ji8J3Wr0fYKMkTbjibrvKZs+0


Florian, You may want to read this email as there's some question about
dynamic linking.


On Tue, 22 Jul 2025 14:26:44 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > 
> > I'm looking for a mapping between already loaded text memory to how to
> > unwind it that will be in an sframe format somewhere on disk.  
> 
> OK, so what you have in mind is the compressed sframe use-case.
> 
> Ideally, for the compressed sframe use-case I suspect we'd want to do
> lazy on demand decompression which could decompress only the parts that
> are needed for the unwind, rather than expand everything in memory.
> 
> Pointing the kernel to a file/offset on disk is rather different than
> the current ELF sframe section scenario, where is it allocated,loaded
> into the process' address space. I suspect we would want to cover this
> with a future new code_opt enum label.

The sframe program header is of type PT_GNU_SFRAME and not PT_LOAD so
the linker will not be loading it. The code in the kernel has to do
something special with this section. It's not automatic.

So yes, I never had any expectation that the dynamic linker would even
load sframes into memory. It would simply tell the kernel where to find
it and it will load it.

> > 
> > Yes, but we are not registering ELF. We are registering how to unwind
> > something with sframes. If it's not sframes we are registering, what is
> > it?  
> 
> I am thinking of sframes as one of the properties of an ELF executable.
> So from my perspective we are registering an ELF file with various
> properties, one of which is its sframe section.

That wasn't what I was thinking.

> 
> But I think I get where you are getting at: if we define the sframe
> registration for ELF as sframe_start, sframe_end, then it forgoes
> approaches where sframe is provided through other means, such as
> pathname and offset, which would be useful for the compressed sframe
> use-case.
> 
> If system call overhead is not too much of an issue at library load,
> then we could break this down into multiple system calls, e.g.
> eventually:
> 
> codectl(CODE_REGISTER_SFRAME, /* provide sframe start + end */ )
> codectl(CODE_REGISTER_ELF, /* provide elf-specific info such as build id */ )

IIRC, and Florian (who has been Cc'd) can correct me if I'm wrong,
dynamic file loading is quite a slow process and a few extra system
calls isn't going to show up outside the noise.


> > The systemcall is to let the dynamic linker know where the kernel can
> > find the sframes for newly loaded text.  
> 
> I am saying this is a "new" model because the current sframe section is
> allocated,loaded, which means it is present in userspace memory, so it
> seems rather logical to delimit this area with pointers to the start/end
> of that range.

But its the kernel that maps it into memory. I was expecting that the
kernel would map it again into memory just like it does with the ELF
file. I wasn't expecting the dynamic linker to.


> > 
> > Actually, the sframe section shouldn't be mapped into user space
> > memory. The kernel will be doing that, not the linker.  
> 
> AFAIU, that's not how the sframe section works today. It's allocated,loaded.
> So userspace maps the section into its address space, and the kernel takes
> the page faults when it needs to load its content.

Yes, but the kernel maps it. I wasn't expecting the user space dynamic
linker to map it. I was expecting the system call to simply say "here's
where the sframe section is in this file" and the kernel would take
care of the rest.

> 
> 
> > I would say that
> > the system call can give a hint of where it would like it mapped, but
> > it should allow the kernel to decide where to map it as the user space
> > code doesn't care where it gets mapped.  
> 
> AFAIU currently the dynamic loader maps the section, not the kernel.

You mean the prctl()?

I haven't looked to deep into that systemcall. It may do that
currently. I'm just thinking what is the best way to do this. I guess
we should ask Florian which is best for the dynamic linker. If it
should map it in, or if the kernel should, with thinking about a
compressed format in mind as well.


> 
> > 
> > In the future, if we wants to compress the sframe section, it will not
> > even be a loadable ELF section. But the system call can tell the
> > kernel: "there's a sframe compressed section at this offset/size in
> > this file" for this text address range and then the kernel will do the
> > rest.  
> 
> I would see this compressed side-file handled entirely from the kernel
> (not mapped in userspace) as a new enum code_opt option.

Yes, it would likely be a new emum.

But if the dynamic linker has already mapped the sframe into memory and
giving it to the kernel, then it is even less an "elf" file. It's
simply mapping a sframe section in memory with some text in memory. The
way the dynamic linker mapped it will still do everything as normal.

> 
> >   
> >>
> >> Am I unknowingly adding some kind of redundancy here ?
> >>  
> > 
> > Maybe. This systemcall was to add unwinding information for the kernel.
> > It looks like you are having it be much more than that. I'm not against
> > that, but that should only be for extensions, and currently, this is
> > supposed to only make sframes work.  
> 
> I agree that if we state that "elf" registration has sframe_start/end
> as a mean to express sframe, then we are stuck with a model where userspace
> needs to map the section in its memory. Considering that you want to
> express different models where a filename and offset is provided to the
> kernel instead, then it makes sense to make the registration more specific.
> 
> The downside would be that we may have to do more than one system call if we
> want to register more than one "aspect", e.g. sframe vs elf build-id.
> 
> I think the overhead of a single vs a few system calls is an important
> aspect to consider. If the overhead of a few more system calls at library
> load does not matter too much, then we should go for the more specific
> registration. I have no clue whether that overhead matters in practice though.

If the linker needs to map it, it is already doing lots of systemcalls
to accomplish that ;-)

-- Steve

