Return-Path: <bpf+bounces-47347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D629F83C1
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 20:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB08169244
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E31A706F;
	Thu, 19 Dec 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qZIWZakc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEC1A255C;
	Thu, 19 Dec 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635200; cv=none; b=JS3Cld0Jbhu1lHc7O3Gqpn+1dNScyODKYrsFyMdUyzMiN7prjp9B6bErsGaGWhC2QKhGTM4ZZkJ3Ndy8m496rux03QSX7qH+L3XY/Rs4Tn0VJY1jEzvzIWuIKhhKVyIvqjgx7jlvA/H6Xsf+0z7EOWgQG11/DZWRlV/Th6El58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635200; c=relaxed/simple;
	bh=uZXBpaUPnIs0v17kOvIODa1c2ZgMXfUTNoWXsLQrrhY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6XKgsZqIXAYan+haD1VzZjt3zNMcL5CQeZVZa6zyIIwdLrZvA2RRNMYwftruj+e5482ozG2yll+WPYkI4eFUZX3j0Snquv1gH7af1Qs6hPbiLM52gbe5xdN1vWSPmr4jL/vM1GOKv/g/yE/pX85qkFdF7k5ngLREQDSuDwS7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qZIWZakc; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734635190; x=1734894390;
	bh=uZXBpaUPnIs0v17kOvIODa1c2ZgMXfUTNoWXsLQrrhY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=qZIWZakcvSkA19JP3kAfH5LPsG2StVqxtauNXZ24R9qJG6QhwAzzylc5uRIp5kDxO
	 Ddes/M/lWhd2zIPSfymFKJp913QdyYJPuaOPsze5z9REfQwAE0ddqurg8Ws0tsWt0X
	 6P4sqBtc6/MdI9Le75sTi7/PrcGuMpBjUBwB+EOGQ6gfHT+VEUwn06eKq71PdUd18o
	 SWzQAv46/Gn2+1GDnKTtSIg8xncEcwbFcjlMqtsvaL0Fmqw7r9/L2PTq5Zq+vZtkaY
	 0WriXCJ5h1k99Ejs3cuPyzeZ5dwy1UJg2f1Cd2eXAJ5iqCAP0tKxNwSITP95agsv/l
	 wqrGHBhAS0r3Q==
Date: Thu, 19 Dec 2024 19:06:25 +0000
To: Jiri Olsa <olsajiri@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 06/10] btf_encoder: switch to shared elf_functions table
Message-ID: <K5et08J-yxHY85mfgEBd6GAJNjmpSDmhhcL5JiZYRA6YfVoAtrQTHHa4opWX0vrRrimoCzyWxVMz2x-NJ5P4BXGdBzF-zVbZrpFhBoKfqWU=@pm.me>
In-Reply-To: <Z2Q0kBEHvLV11Fne@krava>
References: <20241213223641.564002-1-ihor.solodrai@pm.me> <20241213223641.564002-7-ihor.solodrai@pm.me> <Z2Q0kBEHvLV11Fne@krava>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 97ec71539eb61d0b41bf7429c9c8bc4634e0c68e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, December 19th, 2024 at 6:58 AM, Jiri Olsa <olsajiri@gmail.com>=
 wrote:

>=20
>=20
> On Fri, Dec 13, 2024 at 10:37:13PM +0000, Ihor Solodrai wrote:
>=20
> SNIP
>=20
> > @@ -2116,9 +2128,6 @@ int btf_encoder__encode(struct btf_encoder *encod=
er)
> > int err;
> > size_t shndx;
> >=20
> > - /* for single-threaded case, saved funcs are added here */
> > - btf_encoder__add_saved_funcs(encoder);
> > -
> > for (shndx =3D 1; shndx < encoder->seccnt; shndx++)
> > if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
> > btf_encoder__add_datasec(encoder, shndx);
> > @@ -2477,14 +2486,13 @@ struct btf_encoder *btf_encoder__new(struct cu =
*cu, const char *detached_filenam
> > goto out_delete;
> > }
> >=20
> > - encoder->symtab =3D elf_symtab__new(NULL, cu->elf);
> > + encoder->functions =3D elf_functions__get(cu->elf);
>=20
>=20
> elf_functions__get should always return !=3D NULL right? should we add as=
sert call for that?
>=20
> SNIP
>=20
> > diff --git a/pahole.c b/pahole.c
> > index 17af0b4..eb2e71a 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3185,13 +3185,16 @@ static int pahole_threads_collect(struct conf_l=
oad *conf, int nr_threads, void *
> > if (error)
> > goto out;
> >=20
> > - btf_encoder__add_saved_funcs(btf_encoder);
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
>=20
>=20
> is this related to this change? seems like separate fix
>=20
> > continue;
> > err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
> > if (err < 0)
> > @@ -3846,6 +3849,9 @@ try_sole_arg_as_class_names:
> > exit(1);
> > }
> >=20
> > + if (conf_load.nr_jobs <=3D 1 || conf_load.reproducible_build)
> > + btf_encoder__add_saved_funcs(btf_encoder);
>=20
>=20
> should we check the return value here as well?
>=20
> thanks,
> jirka

Jiri, thanks for review.

This patch is going to be removed in the next version of the series,
following a discussion with Eduard and Andrii [1].

If you're interested you can inspect WIP v3 branch on github [2].

I am still testing it, and plan to add a patch removing global
btf_encoders list. Other than that it's close to what I am going to
submit.

[1] https://lore.kernel.org/dwarves/C82bYTvJaV4bfT15o25EsBiUvFsj5eTlm17933H=
vva76CXjIcu3gvpaOCWPgeZ8g3cZ-RMa8Vp0y1o_QMR2LhPB-LEUYfZCGuCfR_HvkIP8=3D@pm.=
me/
[2] https://github.com/theihor/dwarves/tree/v3.workers

>=20
> > +
> > err =3D btf_encoder__encode(btf_encoder);
> > btf_encoder__delete(btf_encoder);
> > if (err) {
> > --
> > 2.47.1

