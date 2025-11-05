Return-Path: <bpf+bounces-73577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F910C34310
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 08:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917103B912B
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 07:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C22D0C8A;
	Wed,  5 Nov 2025 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G8dt1cMj"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE42D2389
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326854; cv=none; b=rIbLEhIZ1YHaCXsgmPYhYcWAe4Q+Acps7f0gUEoLTJ+K4l/a90RYBfptf5GwL1oIUSJ5bhbkEvNFxziV7k0r/60UdIecFlHbhzBNBlvQLnzjrkbsdn8TBbG7QkidUn5d0hli6T1dWVZnzV2u2bH/cC0w/gWLLEuttXyUn3OWr/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326854; c=relaxed/simple;
	bh=7lWv1Lbyp1KL6LhHGzX+dIbc3TmF9sT/YjApLREzoDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMRt9gV1RyMhaQF8HLlbt8xX5Pxpi68UQmWo4pRwSxCgfCbEX2NTgY4953+7WGUYdI9i8drZqhQgzG0Uq3L/IFec9fdQYI1y0tRUV+4uqoIOKBWAeiy4q1BIXLDtNt6819pjdGBav2cGqwpYQ4U3Y9onhlBncqT9BvGEJB3uq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G8dt1cMj; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762326838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfK/agWz/0WkcTINCFySDbMfKDM1u8l6Zttpn4bCw/c=;
	b=G8dt1cMj9yQ0VdniTzxzBnpH0c0iYXvq2nqFWGjbWP9PZh7a5xW564NdFfkBuR7OJmgM1O
	rIhNwaguElgYYk5yXJ09ajYWNq2IbEMyj9qk+15h9rBmG+BAtoPOW+/meJjiWpdf/7KFQd
	go7BXb2SLpbbglhz+ciqHe8HI0JzaIk=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, peterz@infradead.org
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
Date: Wed, 05 Nov 2025 15:13:42 +0800
Message-ID: <4465519.ejJDZkT8p0@7950hx>
In-Reply-To:
 <CAADnVQKQXcUxjJ2uYNu1nvhFYt=KhN8QYAiGXrt_YwUsjMFOuA@mail.gmail.com>
References:
 <20251104104913.689439-1-dongml2@chinatelecom.cn> <5029485.GXAFRqVoOG@7950hx>
 <CAADnVQKQXcUxjJ2uYNu1nvhFYt=KhN8QYAiGXrt_YwUsjMFOuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/5 10:12, Alexei Starovoitov wrote:
> On Tue, Nov 4, 2025 at 5:30=E2=80=AFPM Menglong Dong <menglong.dong@linux=
=2Edev> wrote:
> >
> > On 2025/11/5 02:56, Alexei Starovoitov wrote:
> > > On Tue, Nov 4, 2025 at 2:49=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > > >
> > > > In origin call case, we skip the "rip" directly before we return, w=
hich
> > > > break the RSB, as we have twice "call", but only once "ret".
> > >
> > > RSB meaning return stack buffer?
> > >
> > > and by "breaks RSB" you mean it makes the cpu less efficient?
> >
> > Yeah, I mean it makes the cpu less efficient. The RSB is used
> > for the branch predicting, and it will push the "rip" to its hardware
> > stack on "call", and pop it from the stack on "ret". In the origin
> > call case, there are twice "call" but once "ret", will break its
> > balance.
>=20
> Yes. I'm aware, but your "mov [rbp + 8], rax" screws it up as well,
> since RSB has to be updated/invalidated by this store.
> The behavior depends on the microarchitecture, of course.
> I think:
> add rsp, 8
> ret
> will only screw up the return prediction, but won't invalidate RSB.
>=20
> > Similar things happen in "return_to_handler" in ftrace_64.S,
> > which has once "call", but twice "ret". And it pretend a "call"
> > to make it balance.
>=20
> This makes more sense to me. Let's try that approach instead
> of messing with the return address on stack?

The way here is similar to the "return_to_handler". For the ftrace,
the origin stack before the "ret" of the traced function is:

    POS:
    rip   ---> return_to_handler

And the exit of the traced function will jump to return_to_handler.
In return_to_handler, it will query the real "rip" of the traced function
and the it call a internal function:

    call .Ldo_rop

And the stack now is:

    POS:
    rip   ----> the address after "call .Ldo_rop", which is a "int3"

in the .Ldo_rop, it will modify the rip to the real rip to make
it like this:

    POS:
    rip   ---> real rip

And it return. Take the target function "foo" for example, the logic
of it is:

    call foo -> call ftrace_caller -> return ftrace_caller ->
    return return_to_handler -> call Ldo_rop -> return foo

As you can see, the call and return address for ".Ldo_rop" is
also messed up. So I think it works here too. Compared with
a messed "return address", a missed return maybe have
better influence?

And the whole logic for us is:

    call foo -> call trampoline -> call origin ->
    return origin -> return POS -> return foo

=46ollowing is the partial code of return_to_handler:

	/*
	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
	 * since IBT would demand that contain ENDBR, which simply isn't so for
	 * return addresses. Use a retpoline here to keep the RSB balanced.
	 */
	ANNOTATE_INTRA_FUNCTION_CALL
	call .Ldo_rop
	int3
=2ELdo_rop:
	mov %rdi, (%rsp)
	ALTERNATIVE __stringify(RET), \
		    __stringify(ANNOTATE_UNRET_SAFE; ret; int3), \
		    X86_FEATURE_CALL_DEPTH

>=20
> > I were wandering why the overhead of fexit is much higher
> > than fentry. I added the percup-ref-get-and-put stuff to the
> > fentry, and the performance of it still can be 130M/s. However,
> > the fexit only has 76M/s. And the only difference is the origin
> > call.
> >
> > The RSB balancing mitigate it, but there are still gap. I
> > suspect it's still the branch predicting things.
>=20
> If you have access to intel vtune profiler, check what is

Let me have a study on the "intel vtune profiler" stuff :)

I did a perf stat, and the branch miss increase seriously,
and the IPC(insn per cycle) decrease seriously.

> actually happening. It can show micro arch details.
> I don't think there is an open source alternative.
>=20
> > > Or you mean call depth accounting that is done in sw ?
> > >
> > > > Do the RSB balance by pseudo a "ret". Instead of skipping the "rip"=
, we
> > > > modify it to the address of a "ret" insn that we generate.
> > > >
> > > > The performance of "fexit" increases from 76M/s to 84M/s. Before th=
is
> > > > optimize, the bench resulting of fexit is:
> > > >
> > > > fexit          :   76.494 =C2=B1 0.216M/s
> > > > fexit          :   76.319 =C2=B1 0.097M/s
> > > > fexit          :   70.680 =C2=B1 0.060M/s
> > > > fexit          :   75.509 =C2=B1 0.039M/s
> > > > fexit          :   76.392 =C2=B1 0.049M/s
> > > >
> > > > After this optimize:
> > > >
> > > > fexit          :   86.023 =C2=B1 0.518M/s
> > > > fexit          :   83.388 =C2=B1 0.021M/s
> > > > fexit          :   85.146 =C2=B1 0.058M/s
> > > > fexit          :   85.646 =C2=B1 0.136M/s
> > > > fexit          :   84.040 =C2=B1 0.045M/s
> > >
> > > This is with or without calldepth accounting?
> >
> > The CONFIG_MITIGATION_CALL_DEPTH_TRACKING is enabled, but
> > I did the testing with "mitigations=3Doff" in the cmdline, so I guess
> > "without"?
>=20
> Pls benchmark both. It sounds like call_depth_tracking
> miscounting stuff ?

Sadly, the performance decrease from 28M/s to 26M/s with
mitigation enabled. I think the addition "ret" increase the
overhead with "return-thunks" enabled.

Things is not as simple as I thought, let me do more testing,
and see if ftrace has similar performance decreasing.

Hi, @Peter. Do you have any advice on this ting?

Thanks!
Menglong Dong

>=20
> > >
[......]
> >                            const u32 imm32_hi, const u32 imm32_lo)
> > {
> >         u64 imm64 =3D ((u64)imm32_hi << 32) | (u32)imm32_lo;
> >         u8 *prog =3D *pprog;
> >
> >         if (is_uimm32(imm64)) {
> >                 /*
> >                  * For emitting plain u32, where sign bit must not be
> >                  * propagated LLVM tends to load imm64 over mov32
> >                  * directly, so save couple of bytes by just doing
> >                  * 'mov %eax, imm32' instead.
> >                  */
> >                 emit_mov_imm32(&prog, false, dst_reg, imm32_lo);
> >         } else if (is_simm32(imm64)) {
> >                 emit_mov_imm32(&prog, true, dst_reg, imm32_lo);
> >         } else {
> >                 /* movabsq rax, imm64 */
> >                 EMIT2(add_1mod(0x48, dst_reg), add_1reg(0xB8, dst_reg));
> >                 EMIT(imm32_lo, 4);
> >                 EMIT(imm32_hi, 4);
>=20
> This part could be factored out as a separate helper.
> Then sizeof(movabsq) will be constant.
> Note, in the verifier we do:
> #if defined(MODULES_VADDR)
>                         u64 addr =3D MODULES_VADDR;
> #else
>                         u64 addr =3D VMALLOC_START;
> #endif
>                         /* jit (e.g. x86_64) may emit fewer instructions
>                          * if it learns a u32 imm is the same as a u64 im=
m.
>                          * Set close enough to possible prog address.
>                          */
>                         insn[0].imm =3D (u32)addr;
>                         insn[1].imm =3D addr >> 32;
>=20
> do mitigate this issue.
> So you could have done:
> emit_mov_imm64(&prog, BPF_REG_0, VMALLOC_START >> 32, 0);
>=20
> since 'ret_addr' math is incorrect at that point anyway.
> But prog +=3D sizeof is imo cleaner.

Great! This make things much more clear. After I figure out all
the stuff, (which I'm not sure if I'm able), I'll do this way.

Thanks!
Menglong Dong

> The whole thing might not be necessary with extra call approach.
> I suspect it should be faster than this approach.
>=20





