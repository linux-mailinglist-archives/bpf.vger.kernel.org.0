Return-Path: <bpf+bounces-41506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 696ED99798D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 02:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA811F22A29
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 00:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97273211;
	Thu, 10 Oct 2024 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="CyV8pAek"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4163D;
	Thu, 10 Oct 2024 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728519491; cv=none; b=jQ49PleyGREsUhEMnprUDhNhTp7pIwH0Ca6CVpMgD+HrnMQSAvawpqmVFq1OohHWam1kZ/1ioEEL9yXfERKsd3ODmcvOuqjFu/ZvEg32RX+lPGgMARiLwHmmUMFpXsSLflfjjqtyG9yVRWog5IhPYer44/O2Z4RzOarDf6iYt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728519491; c=relaxed/simple;
	bh=O9xG58odvWsucqMWWVo7YHR3ZrvcTUfms9diIUAGq/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ftq4gSHAytbaTnKWfmZKfd/yHVQyN6LUxGN7kF+zBhXzxGQUpDqVsSMSYDbWUKEfwNs7clhpA1Ex4txSBfkw4D1o50Z4wOezQsjr9pgpRUyWiB1RZ25ZTDz2xXa6VZ+a4lJqkKljPaEWJH9RJKeS5eKIqZRUV9V2qgmXw1TiRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=CyV8pAek; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728519486;
	bh=JCKWnvIHgN7NeIxYtThHAhakmq8YAiBt/o4wQGaz8/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CyV8pAekV/TOve0+yV3IEThJzCD8ee59ddQlBIzCCvWemKc/ImFTYPHIm8jTvew0E
	 2RDGh4pbUM9m9Jzk1MkSVWzDUKNAGDraYErd4MKcPTf3w8FQhfsKQgv0LWZqH3dPKo
	 2q+ccE1Ic0uxYQmUxGLyQjXJb9JhGNC9Dc4D/BDfGj7yEuPzFZ7oCUBMNUYklrervk
	 0rsMC99cZxcDUj+/f+cIqfFiu9qKdmuQGB3SO3eu6awPx3tiAQUhtP+Zq6bQ9xbrH+
	 Yk3vNRNh4aceCVyFBzMhabgs3VMdOh1hhQtkbXYZ3SxHW966Il1rAHeSFno4GT2GT/
	 g4EPuh3btN2Mw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XP9MK39qRz4wnw;
	Thu, 10 Oct 2024 11:18:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hari Bathini
 <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf <bpf@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Linux Kbuild
 mailing list <linux-kbuild@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "Naveen N. Rao" <naveen@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Masahiro Yamada <masahiroy@kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Vishal Chourasia
 <vishalc@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v5 17/17] powerpc64/bpf: Add support for bpf trampolines
In-Reply-To: <CAADnVQJjqnSVqq2n70-uqfrYRHH3n=5s9=t3D2AMooxxAHYfJQ@mail.gmail.com>
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
 <20240915205648.830121-18-hbathini@linux.ibm.com>
 <CAADnVQL60XXW95tgwKn3kVgSQAN7gr1STy=APuO1xQD7mz-aXA@mail.gmail.com>
 <32249e74-633d-4757-8931-742b682a63d3@linux.ibm.com>
 <CAADnVQKfSH_zkP0-TwOB_BLxCBH9efot9mk03uRuooCTMmWnWA@mail.gmail.com>
 <7afc9cc7-95cd-45c7-b748-28040206d9a0@linux.ibm.com>
 <CAADnVQJjqnSVqq2n70-uqfrYRHH3n=5s9=t3D2AMooxxAHYfJQ@mail.gmail.com>
Date: Thu, 10 Oct 2024 11:18:05 +1100
Message-ID: <875xq07qv6.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> On Tue, Oct 1, 2024 at 12:18=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.=
com> wrote:
>> On 30/09/24 6:25 pm, Alexei Starovoitov wrote:
>> > On Sun, Sep 29, 2024 at 10:33=E2=80=AFPM Hari Bathini <hbathini@linux.=
ibm.com> wrote:
>> >> On 17/09/24 1:20 pm, Alexei Starovoitov wrote:
>> >>> On Sun, Sep 15, 2024 at 10:58=E2=80=AFPM Hari Bathini <hbathini@linu=
x.ibm.com> wrote:
>> >>>>
>> >>>> +
>> >>>> +       /*
>> >>>> +        * Generated stack layout:
>> >>>> +        *
>> >>>> +        * func prev back chain         [ back chain        ]
>> >>>> +        *                              [                   ]
>> >>>> +        * bpf prog redzone/tailcallcnt [ ...               ] 64 by=
tes (64-bit powerpc)
>> >>>> +        *                              [                   ] --
>> >>> ...
>> >>>> +
>> >>>> +       /* Dummy frame size for proper unwind - includes 64-bytes r=
ed zone for 64-bit powerpc */
>> >>>> +       bpf_dummy_frame_size =3D STACK_FRAME_MIN_SIZE + 64;
>> >>>
>> >>> What is the goal of such a large "red zone" ?
>> >>> The kernel stack is a limited resource.
>> >>> Why reserve 64 bytes ?
>> >>> tail call cnt can probably be optional as well.
>> >>
>> >> Hi Alexei, thanks for reviewing.
>> >> FWIW, the redzone on ppc64 is 288 bytes. BPF JIT for ppc64 was using
>> >> a redzone of 80 bytes since tailcall support was introduced [1].
>> >> It came down to 64 bytes thanks to [2]. The red zone is being used
>> >> to save NVRs and tail call count when a stack is not setup. I do
>> >> agree that we should look at optimizing it further. Do you think
>> >> the optimization should go as part of PPC64 trampoline enablement
>> >> being done here or should that be taken up as a separate item, maybe?
>> >
>> > The follow up is fine.
>> > It just odd to me that we currently have:
>> >
>> > [   unused red zone ] 208 bytes protected
>> >
>> > I simply don't understand why we need to waste this much stack space.
>> > Why can't it be zero today ?
>>
>> The ABI for ppc64 has a redzone of 288 bytes below the current
>> stack pointer that can be used as a scratch area until a new
>> stack frame is created. So, no wastage of stack space as such.
>> It is just red zone that can be used before a new stack frame
>> is created. The comment there is only to show how redzone is
>> being used in ppc64 BPF JIT. I think the confusion is with the
>> mention of "208 bytes" as protected. As not all of that scratch
>> area is used, it mentions the remaining as unused. Essentially
>> 288 bytes below current stack pointer is protected from debuggers
>> and interrupt code (red zone). Note that it should be 224 bytes
>> of unused red zone instead of 208 bytes as red zone usage in
>> ppc64 BPF JIT come down from 80 bytes to 64 bytes since [2].
>> Hope that clears the misunderstanding..
>
> I see. That makes sense. So it's similar to amd64 red zone,
> but there we have an issue with irqs, hence the kernel is
> compiled with -mno-red-zone.

I assume that issue is that the interrupt entry unconditionally writes
some data below the stack pointer, disregarding the red zone?

> I guess ppc always has a different interrupt stack and
> it's not an issue?

No, the interrupt entry allocates a frame that is big enough to cover
the red zone as well as the space it needs to save registers.

See STACK_INT_FRAME_SIZE which includes KERNEL_REDZONE_SIZE:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/include/asm/ptrace.h?commit=3D8cf0b93919e13d1e8d4466eb4080a4c4d=
9d66d7b#n165

Which is renamed to INT_FRAME_SIZE in asm-offsets.c and then is used in
the interrupt entry here:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/kernel/exceptions-64s.S?commit=3D8cf0b93919e13d1e8d4466eb4080a4=
c4d9d66d7b#n497

cheers

