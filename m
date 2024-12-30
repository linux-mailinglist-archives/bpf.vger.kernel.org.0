Return-Path: <bpf+bounces-47708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F79FEAC1
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 21:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6689B3A2A3E
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 20:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48319ABA3;
	Mon, 30 Dec 2024 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="djDRWVjD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F31487DC
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735592379; cv=none; b=Sb3Rm6sviiLt8nCSaLXsivsYaUNYDw878vZwZKMe+T+RTzvrNWrO6sGRc/yXbOac62tTQ1w+c21fTaTzezHm40eLPmtz+NXDMwDaU9wk5fhzcdvmqhTBqttyvKIxX/UACBKMVXVFKGY4cGbZ8Fv+0dXO0OcL/XOJ5VVqtQSdBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735592379; c=relaxed/simple;
	bh=x/yKFv1USsaqINNeqW2DxpZF79SGO6J2nb5dYFZ8FWI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVkGlVCdcZUb0vZQ5YMTjTHksI6h5tm1aSmRa7YMvjf6YKbj2XjmkcnhKyMZ9yDmrDSQSsY71KJigYPMnueqiYFveQNGhhD9rXcEvms8+elVgJ2jngeV9qbjwlq2Wx4Gi97CwjW7UARdP1A2jpIxVlKxF27+d8jnxi0YuptLVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=djDRWVjD; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735592361; x=1735851561;
	bh=aJispVadYwzVtu8mJlf0e2qAMEfzplqqxOG5He9jnsY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=djDRWVjDMm/6xUp2liZC36AQkWjvTioiA/mFdCiyG/LYruzM7AhSqNd75LbewBy9d
	 x1p1mi+M1MsSGYrwiLSTm82lE08AjHdpDNPvVKimP8AV+fsihvCIDq50c8elKro+mX
	 D0TdgJ7DQM+gOi2D1Nqgw0C7UqXtMUPohsUpnhDHxkRXiru1DevlKViMfmh/ynwk1e
	 PvNoAS0Ad4MKVwvn0nHMt/mpxnIhxmXun/lEBPJirR3SU0IfB766z3DlD3zIPOlUD0
	 ewixJ34ygqdo/+gdI5izoV/ssoeCUTNBnqACgd+3II/9nV+B7y/grJlH01zZd0ceI3
	 HQHxYIkhev4Hw==
Date: Mon, 30 Dec 2024 20:59:15 +0000
To: Andrew Pinski <pinskia@gmail.com>, Sam James <sam@gentoo.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, Cupertino Miranda <cupertino.miranda@oracle.com>, David Faust <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Manu Bretelle <chantra@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
Message-ID: <7ZXLMz0XIsj0YzKNHVoLZ1JrCshOqeGCldUFbX3f8F14s0opaXTpmjfzZH2E10v0b2SFXk2x-DVTN5wGuUqPJQDhA3sOcVm7GeiGzKLRhRI=@pm.me>
In-Reply-To: <87v7v0oqla.fsf@gentoo.org>
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me> <CA+=Sn1ktCrXZMjrC0b1TNxfz1BnQfG24XUdVuktS8kRWeEP2kA@mail.gmail.com> <87v7v0oqla.fsf@gentoo.org>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: dfab9d249e39bd3dd4c313f84eed8082101e0705
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 30th, 2024 at 12:36 PM, Sam James <sam@gentoo.org> wrot=
e:

>=20
>=20
> Andrew Pinski via Gcc gcc@gcc.gnu.org writes:
>=20
> > On Mon, Dec 30, 2024 at 12:11=E2=80=AFPM Ihor Solodrai via Gcc gcc@gcc.=
gnu.org wrote:
> >=20
> > > Hello everyone.
> > >=20
> > > I picked up the work adding GCC BPF backend to BPF CI pipeline [1],
> > > originally done by Cupertino Miranda [2].
> > >=20
> > > I encountered issues compiling BPF objects for selftests/bpf with
> > > recent GCC 15 snapshots. An additional test runner binary is supposed
> > > to be generated by tools/testing/selftests/bpf/Makefile if BPF_GCC is
> > > set to a directory with GCC binaries for BPF backend. The runner
> > > binary depends on BPF binaries, which are produced by GCC.
> > >=20
> > > The first issue is compilation errors on vmlinux.h:
> > >=20
> > > In file included from progs/linked_maps1.c:4:
> > > /ci/workspace/tools/testing/selftests/bpf/tools/include/vmlinux.h:848=
3:9: error: expected identifier before =E2=80=98false=E2=80=99
> > > 8483 | false =3D 0,
> > > | ^~~~~
> > >=20
> > > A snippet from vmlinux.h:
> > >=20
> > > enum {
> > > false =3D 0,
> > > true =3D 1,
> > > };
> > >=20
> > > And:
> > >=20
> > > /ci/workspace/tools/testing/selftests/bpf/tools/include/vmlinux.h:235=
39:15: error: two or more data types in declaration specifiers
> > > 23539 | typedef _Bool bool;
> > > | ^~~~
> > >=20
> > > Full log at [3], and also at [4].
> >=20
> > These are simple, the selftests/bpf programs need to compile with
> > -std=3Dgnu17 or -std=3Dgnu11 since GCC has changed the default to C23
> > which defines false and bool as keywords now and can't be redeclared
> > like before.
>=20
>=20
> Yes, the kernel has various issues like this:
> https://lore.kernel.org/linux-kbuild/20241119044724.GA2246422@thelio-3990=
X/.
>=20
> Unfortunately, not all the Makefiles correctly declare that they need
> gnu11.
>=20
> Clang will hit issues like this too when they change default to gnu23.

Andrew, Sam, thank you for a swift response.

vmlinux.h is generated code, so for the booleans perhaps it's more
appropriate to generate a condition, for example:

    #if __STDC_VERSION__ < 202311L
    enum {
    =09false =3D 0,
    =09true =3D 1,
    };
    #endif

Any drawbacks to this?

Also if vmlinux was built with GCC C23 then I assume DWARF wouldn't
contain the debug info for the enum, hence it wouldn't be present in
vmlinux.h.

I don't think downgrading the standard for a relatively new backend
makes sense, especially in the context of CI testing.

>=20
> > [...]


