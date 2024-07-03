Return-Path: <bpf+bounces-33763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA1925E72
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 13:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9254D2A2EA6
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E1317CA1B;
	Wed,  3 Jul 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBfSww6S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9113776F
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006074; cv=none; b=dn7PYA2g5w5kgZ+hOpmn1l259DYauS30XIs0+MMFuXsE4i4tvKTQ/8lHOiPMOeSDox+8VVWyTo5D/OEG648CNQFwhDOxqhGD0OncQoujMjm+X0kF2jBu3UUOuVVME5XcXaVe6zQTeiL5ERZ2JTzdMcUJpTI+OcC2vExEEJwROKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006074; c=relaxed/simple;
	bh=d4NEpWgyhxbG0+UfHB9+eCl/WceTSOzblNKY5zJolHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d8hq7d+erIXSjRuWx9ByKH4kipM1VjM9TTHzadiNnTsi6YVxzX0CBaL05o1SiZkuffoxwbLTAwaW6+BXApqlsC8l9PTCfOvWNZcFRoIj5XFsmSeKp2/N5B4c5TvGqBVNMfYRo1cnegvyclLqGyo92SuOlZsG9jxstOQJlO0ZWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBfSww6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2243C2BD10;
	Wed,  3 Jul 2024 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720006074;
	bh=d4NEpWgyhxbG0+UfHB9+eCl/WceTSOzblNKY5zJolHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DBfSww6S23Hqu3HERqI4Fhbsk1WEwqsEvJscBPYM8Gdy3Jgi6YvzqUbJMIihsT4Ah
	 44E8DP7shNGxWtSp8UWQQpVoUI+jBTv2awIzqPX0oK+U6WFawN53qt5h2Ta1RtHzMs
	 cFgEUmMPC6xunlJc1MitchRCWcd9to4i3vOBdKvrvAtV7VLEBSxcSnwKYymmfwd4pU
	 9iJ4rglvgh5GerSyEDbnVmuLCPNmXlTO7DIUvOOnzhb2pzT6Sn0d6IDh7sPsWL47Jf
	 ZJqITOw5ucsbY5SHwfY57nokOdQKRsclxC69P4ZvfJylg4LXF88mnbHQcZ2/e5mwQQ
	 STf0Or/B604Zw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman
 <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, jose.marchesi@oracle.com, puranjay12@gmail.com
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for
 bpf_get_smp_processor_id()
In-Reply-To: <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
 <20240629094733.3863850-4-eddyz87@gmail.com>
 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
 <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
 <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
Date: Wed, 03 Jul 2024 11:27:39 +0000
Message-ID: <mb61ped8ak95g.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Jul 2, 2024 at 1:44=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>>
>> On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:
>>
>> [...]
>>
>> > > @@ -158,6 +158,7 @@ const struct bpf_func_proto bpf_get_smp_processo=
r_id_proto =3D {
>> > >         .func           =3D bpf_get_smp_processor_id,
>> > >         .gpl_only       =3D false,
>> > >         .ret_type       =3D RET_INTEGER,
>> > > +       .nocsr          =3D true,
>> >
>> > I'm wondering if we should call this flag in such a way that it's
>> > clear that this is more of an request, while the actual nocsr cleanup
>> > and stuff is done only if BPF verifier/BPF JIT support that for
>> > specific architecture/config/etc?
>>
>> Can change to .allow_nocsr. On the other hand, can remove this flag
>> completely and rely on call_csr_mask().
>
> I like the declaration that helper is eligible to be close to helper
> definition, so I'd definitely keep it, but yeah "allow_nocsr" seems
> betterto me
>
>>
>> [...]
>>
>> > > @@ -16030,7 +16030,14 @@ static u8 get_helper_reg_mask(const struct =
bpf_func_proto *fn)
>> > >   */
>> > >  static bool verifier_inlines_helper_call(struct bpf_verifier_env *e=
nv, s32 imm)
>> > >  {
>> > > -       return false;
>> > > +       switch (imm) {
>> > > +#ifdef CONFIG_X86_64
>> > > +       case BPF_FUNC_get_smp_processor_id:
>> > > +               return env->prog->jit_requested && bpf_jit_supports_=
percpu_insn();
>> > > +#endif
>> >
>> > please see bpf_jit_inlines_helper_call(), arm64 and risc-v inline it
>> > in JIT, so we need to validate they don't assume any of R1-R5 register
>> > to be a scratch register

They don't assume any register to be scratch (except R0) so we can
enable this on arm64 and riscv.

>>
>> At the moment I return false for this archs.

Yes, verifier_inlines_helper_call() should keep returning false for
arm64 and risc-v.=20

>> Or do you suggest these to be added in the current patch-set?

The correct way to do this would be to change call_csr_mask() to have:

verifier_inlines_helper_call(env, insn->imm) || bpf_jit_inlines_helper_call=
(insn->imm)

> I'd add them from the get go. CC Puranjay to double-check?


Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZoU1rBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nWrqAP0abI07Ie8oeCb7ANopGsRKLz1OewCR
4dEQ7FPyXmmu2wD/Viq1EW9603cZHSEfUlDe2bkGRLgk4+sRFyUIkXPbZAA=
=3zJe
-----END PGP SIGNATURE-----
--=-=-=--

