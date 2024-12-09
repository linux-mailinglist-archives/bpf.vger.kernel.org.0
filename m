Return-Path: <bpf+bounces-46438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BF29EA330
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51598188799A
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E109E21CFE6;
	Mon,  9 Dec 2024 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="oVrBFb5p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F476197A8F;
	Mon,  9 Dec 2024 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788525; cv=none; b=tKvetjJvheYMZFOVSzV+sqh1YkRYry6R2ItoR/kB3tiWeP233IQolWmPBxBDM/OOw3y5lBdmnUHTsOBpwhu6SUTDjyfYwu7iogMCU8/FbvEm99adPSZKPhPDmdmw3g2m2J93+rQrqPP947QYHYiCkzZLKX37vUJQCyEsx1VttqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788525; c=relaxed/simple;
	bh=yrlMfcoTNGLw3a/ByWAtpE4VROOU2zblIneZVfhqbww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntxEs3RmUe3ClLGyy+gAynl3bzCFo1zuXHcBYPUASn5HGk5dwEwOAG182FtK+6a0WqqwoIM/68DiNh12tNYczF4Azf7XeIX0v2UUgq88JnbvekchMcwQlz//NPjgli/oIwIdcPNoGOkFLe3HiWRQICh94T6GPmpFtkJ60SQc3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=oVrBFb5p; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1733788515; x=1734047715;
	bh=yrlMfcoTNGLw3a/ByWAtpE4VROOU2zblIneZVfhqbww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=oVrBFb5pG8si56kQxVdBkqWRjtsJTfXrtp47vpoplQmqiesOcp0WQZMK0qBKeK/fQ
	 MBv0kzgd9GU5LSuWrHFFbuTLybJ70apQW9fZ2r4Y6LQz4HmqOjL1k8JuaGlBV4X+xe
	 J9Mkggvlf/5QCqK5Nw7Og6kLkkj3j6JOVacuE2dCmNyblci7leRox9bCJv0qXlTVKO
	 geoTHRlIDs6Vsc5U7YkRAkFafdROjv+9Zdpkky9sDGfhSppL6xHrqfkF4V6KCk2Yv3
	 c6Ck1uFpaBmT8ebRzAFiwp0JhWMTuJmMY2ByhhCrBe7B7bPs8z3ZTxO45lstMB1R+d
	 QkOSaV2XHt4+g==
Date: Mon, 09 Dec 2024 23:55:11 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, mykolal@fb.com
Subject: Re: [RFC PATCH 7/9] btf_encoder: switch to shared elf_functions table
Message-ID: <TBwqhmOT1zA3QS7C2gVwyWbVC-PFQOcRo17NzsWw8he4iudaCN24LCNsYCpyqKsQpZtGeTmfIKn_HJeNkCe1FgU5WNtnYI8q42EZURa2a7Y=@pm.me>
In-Reply-To: <3a012e7797907f466ce56a103e5b1d96ae564428.camel@gmail.com>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me> <20241128012341.4081072-8-ihor.solodrai@pm.me> <3a012e7797907f466ce56a103e5b1d96ae564428.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 7cf61f17033dc0583d07cea0bc305d29e5c8b5ca
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, November 29th, 2024 at 2:35 PM, Eduard Zingerman <eddyz87@gmail.=
com> wrote:

>=20
>=20
> On Thu, 2024-11-28 at 01:24 +0000, Ihor Solodrai wrote:
>=20
> > Do not collect functions from ELF for each new btf_encoder, and
> > instead set a pointer to a shared elf_functions table, built
> > beforehand by btf_encoder__pre_cus__load_module().
> >=20
> > Do not call btf_encoder__add_saved_funcs() on every
> > btf_encoder__add_encoder(). Instead, for non-reproducible
> > multi-threaded case do that in pahole_threads_collect(), and for
> > single-threaded or reproducible_build do that right before
> > btf_encoder__encode().
> >=20
> > Signed-off-by: Ihor Solodrai ihor.solodrai@pm.me
> > ---
>=20
>=20
> Acked-by: Eduard Zingerman eddyz87@gmail.com
>=20
>=20
> [...]
>=20
> > diff --git a/pahole.c b/pahole.c
> > index 1f8cf4b..b5aea56 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3185,12 +3185,16 @@ static int pahole_threads_collect(struct conf_l=
oad *conf, int nr_threads, void *
> > if (error)
> > goto out;
> >=20
> > + err =3D btf_encoder__add_saved_funcs(btf_encoder);
> > + if (err < 0)
> > + goto out;
> > +
> > for (i =3D 0; i < nr_threads; i++) {
> > /*
> > * Merge content of the btf instances of worker threads to the btf
> > * instance of the primary btf_encoder.
> > */
> > - if (!threads[i]->btf)
> > + if (!threads[i]->encoder || !threads[i]->btf)
> > continue;
>=20
>=20
> When can 'threads[i]->encoder' be NULL? In case if worker thread exits wi=
th error?

IIRC if the number of CUs is less than number of jobs, the threads
array may contain NULL elements. I believe this was caught by testing
earlier versions of the patch.

>=20
> > err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
> > if (err < 0)
>=20
>=20
> [...]

