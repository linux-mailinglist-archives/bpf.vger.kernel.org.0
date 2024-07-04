Return-Path: <bpf+bounces-33887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53469274D0
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 13:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C151C231E1
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A4C1AC24D;
	Thu,  4 Jul 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0m+rdNR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9D1AC242
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091966; cv=none; b=Y/euG8bhLoNa5tTCZMJ+K7g8nwvOUKk1fS7lGUGRncKybugoL30/KO8AUI8HXw2QYe2eUVWPzaXl86QF9ztKMm4vsq3s24VHtv4AQeWfMmFJ46OKoK6fvd4kQEV2jQ/Hlu1/1B76mgIAOaHZ7ObQaA5hRkC7v/zdqRJd+lgJ+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091966; c=relaxed/simple;
	bh=1j3NPPrENuhq+Ta3ymSrqkD0A7A0KWDFmGMDiSVUg/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TbH6oeU+0tIGBhheUuzySiqIaeyWc55GHQlcWK9f3fayh9OhTLHBpmvpwAPKG8lWEKyXgmWUUiH+oylOEYNijjc0jepRNIpc/SZcHi58fub0HhUtL9JXi+NIc1LRpY/+OzVDBnSuDEq3y/fYymj1Xk6s34OZHh2IJkxE/VAjXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0m+rdNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4576C3277B;
	Thu,  4 Jul 2024 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720091966;
	bh=1j3NPPrENuhq+Ta3ymSrqkD0A7A0KWDFmGMDiSVUg/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U0m+rdNRQ4++UPIWyI5JM7+Uc6PDQ2xEaKfN1YT9k18ZhL70yiPTprls/z6ud35Tt
	 ZDwWFWgsMYmDwBHfESM3yIIZkt6Ok4Z7KrYcrD//Grb0OxPah7QMbUNLA4HhHlGZge
	 jsJdL4PYjMCxLhFVoEbFSHGewPGidMKmji0UOXlmT4TJWV4wMqoj55STgiq+W2PXS5
	 dvUPiJxs9cYMW9+g1R7ECYd3sSMee68snpa+bI+ptuj4rziPjdU1MTaBRdQ5v55Ff0
	 IOZfIZ7VLgokBFPalIupo/gaHQG/dljJxCQ0TPP8XwDtxkUqBwOZkNAPM86WsNWhcR
	 ELoUjB5prFdJw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, jose.marchesi@oracle.com
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for
 bpf_get_smp_processor_id()
In-Reply-To: <f9f7326c570b6163279a991d71ed0a354ef6f80e.camel@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
 <20240629094733.3863850-4-eddyz87@gmail.com>
 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
 <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
 <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
 <mb61ped8ak95g.fsf@kernel.org>
 <f9f7326c570b6163279a991d71ed0a354ef6f80e.camel@gmail.com>
Date: Thu, 04 Jul 2024 11:19:20 +0000
Message-ID: <mb61ptth5be13.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Wed, 2024-07-03 at 11:27 +0000, Puranjay Mohan wrote:
>
> [...]
>
>> > > > > @@ -16030,7 +16030,14 @@ static u8 get_helper_reg_mask(const str=
uct bpf_func_proto *fn)
>> > > > >   */
>> > > > >  static bool verifier_inlines_helper_call(struct bpf_verifier_en=
v *env, s32 imm)
>> > > > >  {
>> > > > > -       return false;
>> > > > > +       switch (imm) {
>> > > > > +#ifdef CONFIG_X86_64
>> > > > > +       case BPF_FUNC_get_smp_processor_id:
>> > > > > +               return env->prog->jit_requested && bpf_jit_suppo=
rts_percpu_insn();
>> > > > > +#endif
>> > > >=20
>> > > > please see bpf_jit_inlines_helper_call(), arm64 and risc-v inline =
it
>> > > > in JIT, so we need to validate they don't assume any of R1-R5 regi=
ster
>> > > > to be a scratch register
>>=20
>> They don't assume any register to be scratch (except R0) so we can
>> enable this on arm64 and riscv.
>
> Puranjay, just out of curiosity and tangential to this patch-set,
> I see that get_smp_processor_id is implemented as follows in riscv jit:
>
>   emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu=
),
> 	  RV_REG_TP, ctx);
>
> Where bpf_to_rv_reg() refers to regmap, which in turn has the following l=
ine:
>
>   static const int regmap[] =3D {
> 	[BPF_REG_0] =3D	RV_REG_A5,
> 	...
>   }
>
> At the same time, [1] says:
>
>> 18.2 RVG Calling Convention
>> ...
>> Values are returned from functions in integer registers a0 and a1 and
>> floating-point registers fa0 and fa1.
>
> [1] https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf
>
> So, I would expect r0 to be mapped to a0, do you happen to know why is it=
 a5?

I had the same question when I started working with the JITs. This is
seen on both risc-v and arm64, where as you said on risc-v R0 should be
mapped to A0 but is mapped to A5. Similarly, on ARM64, BPF_R0 should be
mapped to ARM64_R0 but is mapped to ARM64_R7.

Here is my understanding of this:

The reason for this quirk is the usage of BPF register R0 as defined by
BPF Registers and calling convention [1]

[1] says:

```
* R0: return value from function calls, and exit value for BPF programs
* R1 - R5: arguments for function calls
```

On arm64 and risc-v the first argument and the return value are
passed/returned in the same register, A0 on risc-v and R0 on arm64.

In BPF, the first argument to a function is passed in R1 and not in R0.
So when we map these registers to riscv or arm64 calling convention, we
have to map BPF_R1 to A0 on risc-v and to R0 on ARM64. This is to make
argument passing easy. Therefore BPF_R0 is mapped to A5 on risc-v and
ARM64_R7 on arm64.

And when we JIT the 'BPF_JMP | BPF_CALL' we add a mov instruction at the
end to move A0 to A5 on risc-v and R0 to R7 on arm64.

But when inlining the call we can directly put the result in A5 or R7.=20

Thanks,
Puranjay

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next/+=
/refs/heads/master/Documentation/bpf/standardization/abi.rst

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZoaFORQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nfNDAQDElamnqQGtO0ZZ9C8K/1aGIcJNh7kF
sErOM5CoyGbWAQD8DALYhkOETBB6mpFGD93yK/hnqZRVkgI5z0YxVmp8Hw0=
=Y89I
-----END PGP SIGNATURE-----
--=-=-=--

