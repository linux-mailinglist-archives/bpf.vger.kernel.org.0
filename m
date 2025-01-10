Return-Path: <bpf+bounces-48567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74041A0963D
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AD316B617
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4402116F0;
	Fri, 10 Jan 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="cF0OHtRo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDCD20B80D;
	Fri, 10 Jan 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523968; cv=none; b=kA4UD0aKl/9+/FxPcM5g33A0wplW8XW7LYHBUWZT/8zsfDN62OBwwgYRh0P8tjdj2pcS3Eo9t8aH/dBm5eqE6ps9/Dx+1Ffa1ARqAuz7cAIyNAvJ277AoHvr2uzRkObyO9+h6grSrjpfj+VkSkdHO6qm8MS9l5wBtHnr2Sn8SsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523968; c=relaxed/simple;
	bh=sJywLPhP2t4mgkxZO7uKwlX8iWOhS4eEyT22cGnulvE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpqRbdokx4GQQLMYGS+yJs7Z2ziAVywxYDlKB8Ky918tNkYgfhKGk8b57yVBZ2mJvRqKrnM0g0oCIXTRJxjavO30TAJwSCEc0KOTKq5q0HaqFxC+qU0/Fk04xK5RELyAMHTMmN0RcY0wKc0Rr5tZdv3FiFe4P/wLLTmhaZt35TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=cF0OHtRo; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736523963; x=1736783163;
	bh=sJywLPhP2t4mgkxZO7uKwlX8iWOhS4eEyT22cGnulvE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cF0OHtRo19wmYCTwClRhoTra9OKl2XUMN0usRroUmzfHm9SWTTxvk3Rlt4sRIWCCA
	 RsDNwvy+Ved7uHNqeiFzPug1U12VlKc26F+WcHNseO1FSFf3L8PWAMEWyGwbI+p1xV
	 fqfMWwFNF4++FXU7l87VNTkCbm4GiUZo/rztmnacvsIkVRofGopUCn+0fVgxRATk/7
	 ktGl1gEi5JLgTtvD5vRKMTNyf6Pw484WHBlSPmVkiix2D0x/b/S967xI9AOo4VJWRM
	 +vw4Ws/oQOxHbnJKpU0dOgAbJ/5JzUvtnStpcVtQXE09kqx8y3CRTw2YhgiNjTDets
	 QTt1vwFvNnArw==
Date: Fri, 10 Jan 2025 15:46:02 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, bpf@vger.kernel.org, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
Message-ID: <2DPNzTDSyhOINKZHxRh-XZ9q4D2cMLm8fU6zn7fnBQqcPz380eqG-CbdGKtehhKN-yT93_wiWC2MC2DC-6s-WMPBN5gGu68egpv6Y1KEcs4=@pm.me>
In-Reply-To: <Z4ElI8tY3otAZych@x1>
References: <20250110023138.659519-1-ihor.solodrai@pm.me> <3f5369ba-7bbb-4816-b7d9-ab08c48870ae@oracle.com> <Z4ElI8tY3otAZych@x1>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 721337461ec541f53a588f0bf11cce94c8623e12
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Friday, January 10th, 2025 at 5:48 AM, Arnaldo Carvalho de Melo <acme@ke=
rnel.org> wrote:

>=20
>=20
> On Fri, Jan 10, 2025 at 10:39:50AM +0000, Alan Maguire wrote:
>=20
> > On 10/01/2025 02:31, Ihor Solodrai wrote:
> >=20
> > > BPF CI caught a segfault on aarch64 and s390x [1] after recent merges
> > > into the master branch.
> > >=20
> > > The segfault happened at free(func_state->annots) in
> > > btf_encoder__delete_saved_funcs().
> > >=20
> > > func_state->annots arrived there uninitialized because after patch [2=
]
> > > in some cases func_state may be allocated with a realloc, but was not
> > > zeroed out.
> > >=20
> > > Fix this bug by always memset-ing a func_state to zero in
> > > btf_encoder__alloc_func_state().
> > >=20
> > > [1] https://github.com/kernel-patches/bpf/actions/runs/12700574327
> > > [2] https://lore.kernel.org/dwarves/20250109185950.653110-11-ihor.sol=
odrai@pm.me/
> >=20
> > Thanks for the quick fix! Reproduced this on an aarch64 system:
> >=20
> > BTF [M] kernel/resource_kunit.ko
> > /bin/sh: line 1: 630875 Segmentation fault (core dumped)
> > LLVM_OBJCOPY=3D"objcopy" pahole -J -j
> > --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimi=
zed_func,consistent_func,decl_tag_kfuncs
> > --lang_exclude=3Drust --btf_base ./vmlinux kernel/kcsan/kcsan_test.ko
> > make[2]: *** [scripts/Makefile.modfinal:57: kernel/kcsan/kcsan_test.ko]
> > Error 139
> > make[2]: *** Deleting file 'kernel/kcsan/kcsan_test.ko'
> > make[2]: *** Waiting for unfinished jobs....
> > /bin/sh: line 1: 630907 Segmentation fault (core dumped)
> > LLVM_OBJCOPY=3D"objcopy" pahole -J -j
> > --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimi=
zed_func,consistent_func,decl_tag_kfuncs
> > --lang_exclude=3Drust --btf_base ./vmlinux kernel/torture.ko
> > make[2]: *** [scripts/Makefile.modfinal:56: kernel/torture.ko] Error 13=
9
> > make[2]: *** Deleting file 'kernel/torture.ko'
> >=20
> > ...and verified that with the fix all works well.
> >=20
> > Nit: missing Signed-off-by
>=20
>=20
> I'm adding it, ok?

Yes, thanks!

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

>=20
> - Arnaldo
>=20
> > Tested-by: Alan Maguire alan.maguire@oracle.com
>=20
>=20
> Thanks!
>=20
> > > ---
> > > btf_encoder.c | 7 +++++--
> > > 1 file changed, 5 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index 78efd70..511c1ea 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -1083,7 +1083,7 @@ static bool funcs__match(struct btf_encoder_fun=
c_state *s1,
> > >=20
> > > static struct btf_encoder_func_state *btf_encoder__alloc_func_state(s=
truct btf_encoder *encoder)
> > > {
> > > - struct btf_encoder_func_state *tmp;
> > > + struct btf_encoder_func_state *state, *tmp;
> > >=20
> > > if (encoder->func_states.cnt >=3D encoder->func_states.cap) {
> > >=20
> > > @@ -1100,7 +1100,10 @@ static struct btf_encoder_func_state *btf_enco=
der__alloc_func_state(struct btf_e
> > > encoder->func_states.array =3D tmp;
> > > }
> > >=20
> > > - return &encoder->func_states.array[encoder->func_states.cnt++];
> > > + state =3D &encoder->func_states.array[encoder->func_states.cnt++];
> > > + memset(state, 0, sizeof(*state));
> > > +
> > > + return state;
> > > }
> > >=20
> > > static int32_t btf_encoder__save_func(struct btf_encoder *encoder, st=
ruct function *fn, struct elf_function *func)

